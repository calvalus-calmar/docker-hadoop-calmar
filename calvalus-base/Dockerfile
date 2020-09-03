FROM calvalusmarine/hadoop-base:master

LABEL Description="This image is used to enable shell access to setup and maintain data and processors for Calvalus" \
      Maintainer="Declan Dunne"

# Install prerequisites
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libssl1.1 \
      wget \
      build-essential \
      libproj-dev \
      python3-dev \
      swig \
      ant \
      git \
      maven \
    && rm -rf /var/lib/apt/lists/*

# GDAL (mininum GDAL build)
# The GDAL part of this script is part based on https://github.com/OSGeo/gdal/blob/master/gdal/docker/ubuntu-full/Dockerfile
ARG GDAL_VERSION=3.1.2

RUN mkdir gdal \
    && wget -q https://github.com/OSGeo/gdal/releases/download/v${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz -O - \
        | tar xz -C gdal --strip-components=1 \
    && cd gdal \
    && ./configure --prefix=/usr --without-libtool \
    --with-hide-internal-symbols \
    --with-jpeg=internal --with-jpeg12 \
    --with-libtiff=internal --with-rename-internal-libtiff-symbols \
    --with-geotiff=internal --with-rename-internal-libgeotiff-symbols \
    --with-proj \
    --with-java \
    --with-python \
    # make and install
    && make -j$(nproc) \
    && make install DESTDIR="/build" \
    # make and install java
    && cd swig/java/ \
    && make -j$(nproc) \
    && make install DESTDIR="/build" \
    && cd ../.. \
    # prepare install files
    && for i in /build/usr/lib/*.so; do strip -s $i 2>/dev/null || /bin/true; done \
    && for i in /build/usr/lib/python3/dist-packages/osgeo/*.so; do strip -s $i 2>/dev/null || /bin/true; done \
    && for i in /build/usr/bin/*; do strip -s $i 2>/dev/null || /bin/true; done \
    && mkdir -p /build/usr/share/java \
    && cp -p /gdal/swig/java/gdal.jar /build/usr/share/java \
    # remove gdal build files
    && cd .. \
    && rm -rf gdal

# Build SNAP
RUN mkdir snap && \
    cd snap && \
    # snap-engine
    git clone https://github.com/calvalus-calmar/snap-engine.git && \
    cd snap-engine && \
    git checkout develop-calmar && \
    mvn clean install && \
    # snap-desktop
    cd .. && \
    git clone https://github.com/calvalus-calmar/snap-desktop.git && \
    cd snap-desktop && \
    git checkout master && \
    mvn clean install && \
    # snap-jython
    cd .. && \
    git clone https://github.com/calvalus-calmar/snap-jython.git && \
    cd snap-jython && \
    git checkout master && \
    mvn clean install && \
    # s1tbx
    cd .. && \
    git clone https://github.com/calvalus-calmar/s1tbx.git && \
    cd s1tbx && \
    git checkout master && \
    mvn clean install

# Build Calvalus
RUN mkdir calvalus && \
    cd calvalus && \
    git clone https://github.com/calvalus-calmar/calvalus2.git && \
    cd calvalus2 && \
    git checkout develop && \
    mvn clean install -DskipTests

# Build Calmar processors
RUN mkdir calmar && \
    cd calmar && \
    git clone https://github.com/calvalus-calmar/calmar-processors.git && \
    cd calmar-processors && \
    git checkout master && \
    mvn clean install

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
