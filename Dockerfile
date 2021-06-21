FROM public.ecr.aws/amazonlinux/amazonlinux:2.0.20210525.0-amd64

LABEL maintainer="devops@ubreakifix.com"
LABEL name="Michael Solla"

# Set upstream conf and remove the default conf
RUN    yum update -y  \
    && yum install shadow-utils -y \
    && groupadd -g 999 nginx \
    && amazon-linux-extras install nginx1 \
    && yum install jq -y \
    && rm /etc/nginx/nginx.conf.default


COPY ./docker-files/nginx.conf /etc/nginx/nginx.conf
COPY ./docker-files/timeout.conf /etc/nginx/conf.d/timeout.conf
COPY --chown=nginx entrypoint.sh /var/entrypoint/entrypoint.sh
COPY --chown=nginx . /usr/share/nginx/html
COPY ./docker-files/former2-fargate.conf /etc/nginx/sites-available/former2.conf

ENTRYPOINT ["/var/entrypoint/entrypoint.sh"]
CMD ["nginx"]

EXPOSE 80
