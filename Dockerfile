FROM nginx:1.27-alpine

# Nettoyage des fichiers par défaut
RUN rm -rf /usr/share/nginx/html/*

# Configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Fichiers statiques de l'application
COPY index.html /usr/share/nginx/html/index.html
COPY logo/ /usr/share/nginx/html/logo/
COPY LISEZMOI.md /usr/share/nginx/html/LISEZMOI.md

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
