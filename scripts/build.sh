#!/bin/bash
echo -e "Build environment variables:"
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "BUILD_NUMBER=${BUILD_NUMBER}"
echo "ARCHIVE_DIR=${ARCHIVE_DIR}"

# Learn more about the available environment variables at:
# https://console.bluemix.net/docs/services/ContinuousDelivery/pipeline_deploy_var.html#deliverypipeline_environment

# To review or change build options use:
# bx cr build --help

echo -e "Checking for Dockerfile at the repository root"
if [ -f Dockerfile ]; then 
   echo "Dockerfile found"
else
    echo "Dockerfile not found"
    exit 1
fi

echo -e "Checking registry current plan and quota"
bx cr plan
bx cr quota
echo "If needed, discard older images using: bx cr image-rm. It may take a few minutes for quota to clear up."

echo -e "Checking registry namespace: ${REGISTRY_NAMESPACE}"
ns=$( bx cr namespaces | grep ${REGISTRY_NAMESPACE} ||: )
if [ -z $ns ]; then
    echo "Registry namespace ${REGISTRY_NAMESPACE} not found, creating it."
    bx cr namespace-add ${REGISTRY_NAMESPACE}
    echo "Registry namespace ${REGISTRY_NAMESPACE} created."
else 
    echo "Registry namespace ${REGISTRY_NAMESPACE} found."
fi

echo -e "Existing images in registry"
bx cr images

echo -e "Building container image: ${IMAGE_NAME}:${BUILD_NUMBER}"
set -x
bx cr build -t $REGISTRY_URL/$REGISTRY_NAMESPACE/$IMAGE_NAME:$BUILD_NUMBER .
set +x

echo -e "Copying artifacts needed for deployment and testing"

# IMAGE_NAME from build.properties is used by Vulnerability Advisor job to reference the image qualified location in registry
echo "IMAGE_NAME=${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME}:${BUILD_NUMBER}" >> $ARCHIVE_DIR/build.properties

# RELEASE_NAME from build.properties is used in Helm Chart deployment to set the release name
echo "RELEASE_NAME=${IMAGE_NAME}" >> $ARCHIVE_DIR/build.properties

if [ -f ./chart/${CHART_NAME}/values.yaml ]; then
    #Update Helm chart values.yml with image name and tag
    echo "UPDATING CHART VALUES:"
    sed -i "s~^\([[:blank:]]*\)repository:.*$~\1repository: ${REGISTRY_URL}/${IMAGE_NAME}~" ./chart/${CHART_NAME}/values.yaml
    sed -i "s~^\([[:blank:]]*\)tag:.*$~\1tag: ${BUILD_NUMBER}~" ./chart/${CHART_NAME}/values.yaml
    cat ./chart/${CHART_NAME}/values.yaml
    if [ ! -d $ARCHIVE_DIR/chart/ ]; then # no need to copy if working in ./ already
      cp -r ./chart/ $ARCHIVE_DIR/
    fi
else 
    echo -e "${red}Helm chart values for Kubernetes deployment (/chart/${CHART_NAME}/values.yaml) not found.${no_color}"
    exit 1
fi     
