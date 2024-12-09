# Etapa 1: Configurar o app no Node.js
FROM node:20.11.1-alpine3.19 AS build

# Defina o diretório de trabalho
WORKDIR /app

# Copie e instale dependências
COPY package.json package-lock.json ./
RUN npm install

# Copie os arquivos do projeto
COPY . .

# Etapa 2: Servir diretamente com NGINX (opcional para arquivos estáticos)
FROM nginx:1.25.4-alpine3.18

# Copie uma configuração personalizada do NGINX
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# **Ajuste para servir estáticos diretamente do NGINX**
# Se você tem arquivos estáticos no projeto, especifique o diretório correto (como `/app/static`):
# COPY --from=build /app/static /var/www/html
# Caso contrário, remova esta linha

# Exponha a porta usada pelo NGINX
EXPOSE 3005

# Inicie o NGINX
ENTRYPOINT ["nginx", "-g", "daemon off;"]
