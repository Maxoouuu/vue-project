# Utilisez une image officielle de Node.js comme base
FROM node:lts-alpine

# Créez un répertoire pour l'application
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json
COPY package*.json ./

# Installez les dépendances du projet
RUN npm install

# Copiez le code source de l'application dans le conteneur
COPY . .

# Construisez l'application pour la production
RUN npm run build

# Utilisez une image officielle nginx pour servir l'application
FROM nginx:stable-alpine

# Copiez la configuration nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiez les fichiers de l'application construite dans le conteneur nginx
COPY --from=0 /app/dist /usr/share/nginx/html

# Exposez le port 80 pour le conteneur
EXPOSE 80

# Lancez nginx
CMD ["nginx", "-g", "daemon off;"]
