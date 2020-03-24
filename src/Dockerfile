FROM canelrom1/apache2-php7:latest
MAINTAINER Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch

ENV MEDIAWIKI_VERSION 1.30
ENV MEDIAWIKI_FULL_VERSION 1.30.0

RUN apt-get update \
 && apt-get -y -q --no-install-recommends \
            install imagemagick \
                    curl gpg dirmngr wget \
 && rm -rf /var/lib/apt/lists/*

RUN gpg --fetch-keys "https://www.mediawiki.org/keys/keys.txt" 
#RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
#    441276E9CCD15F44F6D97D18C119E1A64D70938E \
#    41B2ABE817ADD3E52BDA946F72BC1C5D23107F8A \
#    162432D9E81C1C618B301EECEE1F663462D84F01 \
#    1D98867E82982C8FE0ABC25F9B69B3109D3BB7B0 \
#    3CEF8262806D3F0B6BA1DBDD7956EE477F901A30 \
#    280DB7845A1DCAC92BB5A00A946B02565DC00AA7

RUN MEDIAWIKI_DOWNLOAD_URL="https://releases.wikimedia.org/mediawiki/$MEDIAWIKI_VERSION/mediawiki-$MEDIAWIKI_FULL_VERSION.tar.gz" \
 && set -x \ 
 && wget --no-check-certificate "$MEDIAWIKI_DOWNLOAD_URL" -P /usr/src \
 && wget --no-check-certificate "${MEDIAWIKI_DOWNLOAD_URL}.sig" -P /usr/src \
 #&& gpg --verify /usr/src/mediawiki-*.tar.gz.sig \
 && tar -xf /usr/src/mediawiki-${MEDIAWIKI_FULL_VERSION}.tar.gz -C /var/www \
 && mv /var/www/mediawiki-${MEDIAWIKI_FULL_VERSION} /var/www/wiki \
 && chown www-data:www-data -R /var/www/wiki

COPY ./conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./conf/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2"]
