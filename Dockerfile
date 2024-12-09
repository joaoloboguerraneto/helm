# Etapa 1: Configurar o app no Node.js
FROM node:20.11.1-alpine3.19 AS build

# Defina o diretório de trabalho
WORKDIR /app

# Copie e instale dependências
COPY package.json package-lock.json ./
RUN npm install

# Copie os arquivos do projeto
COPY . .

# Etapa 2: Servir com NGINX
FROM nginx:1.25.4-alpine3.18

# Copie os arquivos estáticos gerados pela etapa anterior
COPY --from=build /app/public /var/www/html

# Configuração opcional do NGINX
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Exponha a porta usada pelo NGINX
EXPOSE 3005

# Inicie o NGINX
ENTRYPOINT ["nginx", "-g", "daemon off;"]
