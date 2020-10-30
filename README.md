# pacrb

Generates and auto-updates a pacman repository.

Heavily inspired by [aur-build-server](https://github.com/ullebe1/aur-build-server) from [ullebe1](https://github.com/ullebe1).

## Installation

Not written yet.

## Usage

You can use the following commands to add or remove a package.

### Add a package to pacrb

```
docker exec -it -u build [CONTAINER_NAME] aur sync -d [REPO_NAME] --root /var/cache/pacman/[REPO_NAME] -ncT --noview [PACKAGE_NAME]
```

### Remove a package from pacrb

```
docker exec -it -u build [CONTAINER_NAME] repo-remove /var/cache/pacman/[REPO_NAME]/[REPO_NAME].db.tar [PACKAGE_NAME(S)]
```
