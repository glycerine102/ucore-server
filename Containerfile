ARG SOURCE_IMAGE="ucore"
ARG SOURCE_TAG="stable-zfs-20251024"

FROM scratch AS ctx
COPY build /

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}:${SOURCE_TAG}

COPY rootfs /

RUN ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/manage_files.sh && \
    /ctx/remove_packages.sh && \
    /ctx/install_packages.sh && \
    /ctx/manage_services.sh && \
    /ctx/cleanup_image.sh
