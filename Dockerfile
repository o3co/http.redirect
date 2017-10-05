FROM nginx:alpine

ENV HOME /root
WORKDIR ${HOME}

RUN apk --no-cache add --virtual .build gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .build 

#COPY ./conf/      ${HOME}/
COPY nginx.conf          /etc/nginx/nginx.conf
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY conf.d              /etc/nginx/conf.d/
COPY scripts             ${HOME}/scripts

ENV CONFIG_FILE   "simple.conf.template"
ENV PORT          "80"
ENV LISTEN_FLAG   "default_server"
ENV SERVER_NAME   "_"
ENV REDIRECT_FLAG "redirect"
ENV ACCESS_LOG    "/dev/stdout"
ENV ERROR_LOG     "/dev/stderr"
ENV LOG_LEVEL     "warn"
#ENV REDIRECT_FLAG "permanent"
# Set following envs on runtime 
#ENV REDIRECT_TO   http://google.com

ENTRYPOINT ["/bin/sh", "-c"]
CMD [ "./scripts/starts" ]
