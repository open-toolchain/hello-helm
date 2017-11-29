### Sample node.js hello world application packaged as a container with a Helm Chart

Try to deploy it to Kubernetes with this IBM Cloud DevOps toolchain: https://github.com/open-toolchain/simple-helm-toolchain fully preconfigured for you.


Note: The Helm chart was created using a 'helm create hello' command, then altered to pass an image pull secret (to enable later deployments from private image registries), i.e.  

- in [/chart/hello/templates/deployment.yaml](https://github.com/open-toolchain/hello-helm/blob/56ccf087e2d8fc18f7774f84f9400f02060736f2/chart/hello/templates/deployment.yaml#L18-L19):
```
imagePullSecrets:
- name: {{ .Values.image.pullSecret }}
```

- and corresponding addition in [/chart/hello/values/yaml](https://github.com/open-toolchain/hello-helm/blob/56ccf087e2d8fc18f7774f84f9400f02060736f2/chart/hello/values.yaml#L8) as a placeholder for receiving an actual pull secret during deployment automatically.
```
pullSecret: regsecret
```

