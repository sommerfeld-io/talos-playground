# Talos Playground

[doc-website]: https://sommerfeld-io.github.io/talos-playground
[github-repo]: https://github.com/sommerfeld-io/talos-playground
[file-issues]: https://github.com/sommerfeld-io/talos-playground/issues
[project-board]: https://github.com/orgs/sommerfeld-io/projects/1/views/1

This project is a Kubernetes Playground with [Talos](https://talos.dev). Talos Linux is Linux designed for Kubernetes - secure, immutable, and minimal. Supports cloud platforms, bare metal, and virtualization platforms. All system management is done via an API. No SSH, shell or console.

This project also acts as a playground for [Argo CD](https://argo-cd.readthedocs.io/en/stable) which is setup with [Argo CD Autopilot](https://argocd-autopilot.readthedocs.io/en/stable). Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. The autopilot bootstrap command will deploy an Argo CD manifest to a target K8s cluster and will commit an Argo CD Application manifest under a specific directory in your GitOps repository. This Application will manage the Argo CD installation itself - so after running this command, you will have an Argo CD deployment that manages itself through GitOps.

- [Documentation Website][doc-website]
- [Github Repository][github-repo]
- [Where to file issues][file-issues]
- [Project Board for Issues and Pull Requests][project-board]

## Argo CD Autopilot

When [initializing or recovering an Argo CD installation](https://argocd-autopilot.readthedocs.io/en/stable/Getting-Started/), a personal access with `repo` scope is needed. After Argo CD is up and running autopilot will push the installation manifests to the installation repository.

## Contact

Feel free to contact me via <sebastian@sommerfeld.io> or [raise an issue in this repository][file-issues].
