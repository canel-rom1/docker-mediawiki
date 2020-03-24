FROM canelrom1/apache2-php7:latest

LABEL maintainer="Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch"
LABEL date="24/03/2020"
LABEL description="MediaWiki 1.34"

RUN apk update \
 && apk add --no-cache \
            gnupg \
            imagemagick \
            php7-ctype \
            php7-dom \
            php7-fileinfo \
            php7-iconv \
            php7-mbstring

ENV MEDIAWIKI_VERSION 1.34
ENV MEDIAWIKI_FULL_VERSION ${MEDIAWIKI_VERSION}.0

RUN MEDIAWIKI_DOWNLOAD_URL="https://releases.wikimedia.org/mediawiki/$MEDIAWIKI_VERSION/mediawiki-$MEDIAWIKI_FULL_VERSION.tar.gz" \
 && TMP_DIR="/tmp" \
 && HTML_DIR="/var/www/html" \
 && gpg --fetch-keys "https://www.mediawiki.org/keys/keys.txt" \
 && wget "$MEDIAWIKI_DOWNLOAD_URL" -P ${TMP_DIR} \
 && wget "${MEDIAWIKI_DOWNLOAD_URL}.sig" -P ${TMP_DIR} \
 && gpg --verify ${TMP_DIR}/mediawiki-*.tar.gz.sig \
 && tar -xf ${TMP_DIR}/mediawiki-${MEDIAWIKI_FULL_VERSION}.tar.gz -C ${TMP_DIR} \
 && rm -fr ${HTML_DIR} \
 && mv ${TMP_DIR}/mediawiki-${MEDIAWIKI_FULL_VERSION} ${HTML_DIR} \
 && rm -fr ${TMP_DIR}/* \
 && chown ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} -R ${HTML_DIR}

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2"]
