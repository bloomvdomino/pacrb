# pacrb

Generates and auto-updates a pacman repository.

Heavily inspired by [aur-build-server](https://github.com/ullebe1/aur-build-server) from [ullebe1](https://github.com/ullebe1).

## Installation

### Initialize the repo

docker exec -it -u root [CONTAINER_NAME] install -d /var/cache/pacman/[REPO_NAME] -o build
docker exec -it -u root [CONTAINER_NAME] repo-add /var/cache/pacman/[REPO_NAME]/[REPO_NAME].db.tar.gz
docker exec -it -u root [CONTAINER_NAME] chown -R build:build /var/cache/pacman/[REPO_NAME]

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

## What's remaining to say…

This README isn't finished yet, it will be improved in future. This project is in alpha state for now. There are some instructions in the `Dockerfile` considered to be unsafe, which will be hopefully changed to more secure instructions in the near future.

This software is provided AS IS and there is no warranty given (see LICENSE).

Feel free to open issues, suggest improvements and open pull requests.
