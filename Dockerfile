# Sử dụng Node.js 20
FROM node:20.0.0

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép package.json trước để tối ưu caching
COPY package*.json ./

# Cài đặt dependencies trước
RUN npm install

# Cài đặt Angular CLI toàn cục
RUN npm install -g @angular/cli

# Cấp quyền thực thi cho `ng`
RUN chmod +x /usr/local/bin/ng
RUN chmod +x /app/node_modules/.bin/ng

# Chuyển quyền thư mục làm việc cho user non-root
RUN chown -R node:node /app
USER node

# Sao chép toàn bộ source code vào container
COPY . .

# Mở cổng 4200 cho Angular
EXPOSE 4200

# Chạy ứng dụng Angular với `npx` (đảm bảo ng chạy đúng)
CMD ["npx", "ng", "serve", "--host", "0.0.0.0"]
