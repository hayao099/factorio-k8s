## UNPACK
FROM registry.access.redhat.com/ubi9/ubi-minimal AS unpack
RUN microdnf update -y
RUN microdnf install -y tar xz
COPY ./factorio-headless_linux_2.0.55.tar.xz ./
RUN tar Jxvf ./factorio-headless_linux_2.0.55.tar.xz

## EXECUTE
FROM registry.access.redhat.com/ubi9/ubi-minimal
RUN microdnf install glibc -y
COPY --from=unpack ./factorio ./opt/factorio 
RUN ["/opt/factorio/bin/x64/factorio", "--create", "/opt/factorio/saves/my-save.zip"]
EXPOSE 34197
ENTRYPOINT ["/opt/factorio/bin/x64/factorio", "--start-server", "/opt/factorio/saves/my-save.zip"]
