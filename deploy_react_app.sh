#!/bin/bash

# Get user inputs for variables
read -p "Enter the desired site name: " site_name
read -p "Enter the site URL (domain or server IP): " site_url

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Reload the shell or restart the terminal
source ~/.bashrc  # or source ~/.zshrc if you are using Zsh

# Install the newest version of Node.js and npm
nvm install node --latest-npm

# Use the newest version of Node.js
nvm use node

# Install the latest version of tar globally
npm install -g tar@latest

# Make the directory for the new site
sudo mkdir -p /var/www/$site_name

# Create a new React app directly in /var/www/$site_name
cd /var/www/$site_name
npx create-react-app .

# Ensure group ownership and permissions
sudo chown -R www-data:www-data /var/www/$site_name
sudo chmod -R 755 /var/www/$site_name

# Install Nginx
sudo apt install -y nginx

# Configure Nginx virtual host for React app
echo "server {
    listen 80;
    server_name $site_url;

    root /var/www/$site_name/build;
    index index.html;

    location / {
        try_files \$uri /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max;
        log_not_found off;
    }

    location ~ /\. {
        deny all;
    }
}" | sudo tee /etc/nginx/sites-available/$site_name

# Create a symbolic link to sites-enabled
sudo ln -s /etc/nginx/sites-available/$site_name /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Install Certbot, allow ports, configure Certbot, and set up monthly cronjob
sudo apt install -y python3-certbot-nginx
sudo ufw allow 80
sudo ufw allow 443
sudo certbot --nginx
(crontab -l 2>/dev/null; echo "0 0 1 * * certbot --nginx renew") | crontab -

# Install serve globally
npm install -g serve

# Build React app
npm run build

# Run serve in the background and echo the PID
nohup serve -s build & echo "Serve process ID: $!"
