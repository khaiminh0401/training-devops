# Stage 1: Build Angular
FROM node:20 AS build-stage

# Đặt thư mục làm việc trong container
WORKDIR /app

# Copy package.json và package-lock.json vào container
COPY package*.json ./

# Cài đặt dependencies
RUN npm install

# Copy toàn bộ source code vào container
COPY . .

# Build Angular app (thay đổi nếu cần mode khác)
RUN npm run build -- --configuration=production

# Stage 2: Run Angular app với Nginx
FROM nginx AS production-stage

# Copy file build từ stage 1 vào Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose cổng 80
EXPOSE 80

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]
