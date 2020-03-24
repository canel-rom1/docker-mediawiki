FROM canelrom1/apache2-php7:latest
MAINTAINER Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch

RUN apk update \
 && apk add imagemagick \
            gnupg \
            php7-ctype \
            php7-dom \
            php7-fileinfo \
            php7-iconv \
            php7-mbstring 
# && apk cache clean

RUN gpg --fetch-keys "https://www.mediawiki.org/keys/keys.txt" 
#RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
#    441276E9CCD15F44F6D97D18C119E1A64D70938E \
#    41B2ABE817ADD3E52BDA946F72BC1C5D23107F8A \
#    162432D9E81C1C618B301EECEE1F663462D84F01 \
#    1D98867E82982C8FE0ABC25F9B69B3109D3BB7B0 \
#    3CEF8262806D3F0B6BA1DBDD7956EE477F901A30 \
#    280DB7845A1DCAC92BB5A00A946B02565DC00AA7

ENV MEDIAWIKI_VERSION 1.34
ENV MEDIAWIKI_FULL_VERSION ${MEDIAWIKI_VERSION}.0

#&& gpg --verify /usr/src/mediawiki-*.tar.gz.sig \
RUN MEDIAWIKI_DOWNLOAD_URL="https://releases.wikimedia.org/mediawiki/$MEDIAWIKI_VERSION/mediawiki-$MEDIAWIKI_FULL_VERSION.tar.gz" \
 && wget "$MEDIAWIKI_DOWNLOAD_URL" -P /tmp \
 && wget "${MEDIAWIKI_DOWNLOAD_URL}.sig" -P /tmp \
 && tar -xf /tmp/mediawiki-${MEDIAWIKI_FULL_VERSION}.tar.gz -C /var/www \
 && rm -fr /var/www/html \
 && mv /var/www/mediawiki-${MEDIAWIKI_FULL_VERSION} /var/www/html \
 && chown apache:apache -R /var/www/html

#RUN sed -i "/fileinfo/s/^;//" /etc/php7/php.ini

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2"]
