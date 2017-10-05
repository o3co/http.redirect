FROM nginx:alpine

RUN apk --no-cache add --virtual .build gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .build 

#COPY ./conf/      ${HOME}/
COPY nginx.conf   /etc/nginx/nginx.conf
COPY conf.d       /etc/nginx/conf.d/

ENV CONFIG_FILE   "simple.conf.template"
ENV PORT          "80"
ENV LISTEN_FLAG   "default_server"
ENV SERVER_NAME   "_"
ENV REDIRECT_FLAG "redirect"
ENV LOG_LEVEL     "warn"
#ENV REDIRECT_FLAG "permanent"
# Set following envs on runtime 
#ENV REDIRECT_TO   http://google.com

ENTRYPOINT ["/bin/sh", "-c"]
CMD [ \
  "envsubst '$$PORT$$SERVER_NAME$$LISTEN_FLAG$$REDIRECT_TO$$REDIRECT_FLAG&&LOG_LEVEL' < /etc/nginx/nginx.conf.template | tee /etc/nginx/nginx.conf && envsubst '$$PORT$$SERVER_NAME$$LISTEN_FLAG$$REDIRECT_TO$$REDIRECT_FLAG&&LOG_LEVEL' < /etc/nginx/conf.d/${CONFIG_FILE} | tee /etc/nginx/conf.d/default.conf && nginx -g \"daemon off;\"" \
]
