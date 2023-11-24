FROM public.ecr.aws/nginx/nginx
#copy local static files to nginx container
# app name : minha-app
#
RUN apt-get update -y
COPY static-content /usr/share/nginx/html