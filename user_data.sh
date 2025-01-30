#!/bin/bash

# Update package lists
apt update -y  # For Debian/Ubuntu systems

# Install dependencies (example: for a Node.js app)
apt install -y nodejs npm # Node.js and npm
apt install -y nginx    # Nginx web server (for Ubuntu)

# Create application directory
mkdir /var/www/html

# Copy your application files (replace with your actual method)
# You could use `aws s3 cp` if your app is in S3
cp app.zip /var/www/html/
cd /var/www/html
unzip app.zip

# Install application dependencies
npm install

# Start your application (example: using pm2)
npm install -g pm2
pm2 start server.js # Replace server.js with your app's entry point

# Configure Nginx (important for proxying to your app)
cat <<EOF > /etc/nginx/sites-available/myapp
server {
    listen 80;
    server_name localhost; # Or your domain name

    location / {
        proxy_pass http://127.0.0.1:3000; # Assuming your app runs on port 3000
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx
