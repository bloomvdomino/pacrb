FROM archlinux

# Install all needed build dependencies
RUN pacman -Syu --noconfirm --noprogressbar --quiet base base-devel bash git jq pacutils pacman aria2 devtools expac parallel repose vifm diffstat wget pacman-contrib signify; \
    useradd -u 1002 --create-home build; \
    usermod -g wheel build;


# Build the aurutils package
USER build
WORKDIR /tmp
RUN mkdir -p /home/build/.gnupg/; \
    echo "keyserver-options auto-key-retrieve" >> /home/build/.gnupg/gpg.conf; \
    echo "keyserver ha.pool.sks-keyservers.net" >> /home/build/.gnupg/gpg.conf; \
    git clone https://aur.archlinux.org/aurutils.git; \
    cd aurutils; PKGDEST=../ makepkg; rm -rf aurutils;


# Install the aurtils package
USER root
RUN pacman -U aurutils*.pkg.tar.zst --noconfirm; rm -rf aurutils-*.pkg.tar.zst;


# Set autoretrieve keys when building
#RUN mkdir -p /var/lib/aurbuild/x86_64/root/etc/skel/.gnupg/; \
#    echo "keyserver-options auto-key-retrieve" >> /var/lib/aurbuild/x86_64/root/etc/skel/.gnupg/gpg.conf; \
#    echo "keyserver ha.pool.sks-keyservers.net" >> /var/lib/aurbuild/x86_64/root/etc/skel/.gnupg/gpg.conf


# Setup the configurations
STOPSIGNAL SIGRTMIN+3
ENV container docker
RUN mkdir -p /etc/pacman.d/repos; \
    chown -R build:build /etc/pacman.d/repos; \
    touch /etc/pacman.d/repos/build_dummy; \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
    echo "build ALL = NOPASSWD: /usr/sbin/pacsync" >> /etc/sudoers; \
    systemctl enable paccache.timer;


# Polish the things a little bit.
COPY ./systemd/pacrb-build-repo.* /etc/systemd/system/
COPY ./pacman/pacman.conf /etc/pacman.conf
RUN systemctl enable pacrb-build-repo.timer pacrb-build-repo.service; \
    systemctl enable paccache.timer; \
    rm -rf /etc/pacman.d/repos/build_dummy;


# Set up the volumes for mounting.
VOLUME /var/cache/pacman /etc/pacman.d/repos

ENV XDG_RUNTIME_DIR /home/build

WORKDIR /home/build

# And now: Run it all!
CMD ["init"]
