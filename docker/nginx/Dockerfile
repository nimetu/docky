
FROM nginx:mainline-alpine

# add new user using uid(1000), gid(1000)
RUN addgroup -g 1000 -S ryzom && \
	adduser -u 1000 -S ryzom -G ryzom && \
	chown -R 1000:1000 /var/cache/nginx

USER ryzom

