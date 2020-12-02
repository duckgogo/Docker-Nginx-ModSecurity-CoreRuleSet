FROM nginx:stable-alpine
ARG MODSEC_VERSION
ARG CRS_VERSION
ARG CONNECTOR_VERSION
RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache linux-headers file make gawk g++ pkgconf libtool pcre-dev zlib-dev curl-dev openssl-dev geoip-dev lmdb-dev pcre-dev libxml2-dev yajl-dev libstdc++ \
    && cd /usr/local \
    # Install ModSec
    && wget https://github.com/SpiderLabs/ModSecurity/releases/download/v${MODSEC_VERSION}/modsecurity-v${MODSEC_VERSION}.tar.gz \
    && tar xzf modsecurity-v${MODSEC_VERSION}.tar.gz \
    && cd modsecurity-v${MODSEC_VERSION} \
    && ./configure \
    && make \
    && make install \
    && make clean \
    && cd .. \
    && rm -f modsecurity-v${MODSEC_VERSION}.tar.gz \
    # Download OWASP Core Rule Set
    && wget https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/v${CRS_VERSION}.tar.gz \
    && tar xzf v${CRS_VERSION}.tar.gz \
    && cp owasp-modsecurity-crs-${CRS_VERSION}/crs-setup.conf.example owasp-modsecurity-crs-${CRS_VERSION}/crs-setup.conf \
    && rm -f v${CRS_VERSION}.tar.gz \
    # Build ModSec-Nginx Connector
    && wget https://github.com/SpiderLabs/ModSecurity-nginx/releases/download/v${CONNECTOR_VERSION}/modsecurity-nginx-v${CONNECTOR_VERSION}.tar.gz \
    && tar xzf modsecurity-nginx-v${CONNECTOR_VERSION}.tar.gz \
    && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -xzf nginx-${NGINX_VERSION}.tar.gz \
    && cd nginx-${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=../modsecurity-nginx-v${CONNECTOR_VERSION} \
    && make modules \
    && cp objs/ngx_http_modsecurity_module.so /etc/nginx/modules/ \
    && cd .. \
    && rm -f modsecurity-nginx-v${CONNECTOR_VERSION}.tar.gz \
    && rm -rf modsecurity-nginx-v${CONNECTOR_VERSION} \
    && rm -f nginx-${NGINX_VERSION}.tar.gz \
    && rm -rf nginx-${NGINX_VERSION} \
    # Clean
    && apk del --no-cache linux-headers file make gawk g++ pkgconf
COPY nginx/ /etc/nginx
RUN sed -i "s|&CRS_VERSION&|${CRS_VERSION}|g" /etc/nginx/modsec/main.conf \
    && cp /usr/local/modsecurity-v${MODSEC_VERSION}/unicode.mapping /etc/nginx/modsec/