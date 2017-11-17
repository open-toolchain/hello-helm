Sample application packaged as a container with a Helm Chart for deployment to Kubernetes


Note: The Helm chart was created using a `helm create hello` command, then altered to pass an image pull secret (to enable later deployments from private image registries), i.e.  in /chart/hello/templates/deployment.yaml:
`      imagePullSecrets:
        - name: {{ .Values.image.pullSecrets }}`

and corresponding addition in /chart/hello/values/yaml
`  pullSecret: regsecret`