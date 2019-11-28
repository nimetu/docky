
FROM nginx:mainline-alpine

RUN apk add --update openssl && rm -fr /var/cache/apk*

# add new user using uid(1000), gid(1000)
RUN addgroup -g 1000 -S ryzom && \
	adduser -u 1000 -S ryzom -G ryzom && \
	chown -R 1000:1000 /var/cache/nginx && \
	mkdir -p /etc/nginx/certs && \
	chown -R 1000:1000 /etc/nginx/certs

COPY ./docker-entrypoint.sh /

USER ryzom

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]

