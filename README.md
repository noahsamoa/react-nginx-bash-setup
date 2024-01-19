# Automated React App Deployment with Nginx and Certbot

This bash script automates the deployment of a React app using Nginx as a web server, Certbot for SSL/TLS certificates, and serve for serving the built React app. It guides you through the process of setting up a new React app, configuring Nginx, obtaining SSL certificates, and running the app.

## Usage

1. Make sure you have the necessary permissions to install packages, configure Nginx, and run scripts.

2. Save the script to a file, for example, `deploy_react_app.sh`.

3. Make the script executable:

   ```bash
   chmod +x deploy_react_app.sh
   ```
   
4. Run the script:

   ```bash
   ./deploy_react_app.sh
   ```
5. Follow the prompts to enter the desired site name and URL.

6. Follow the prompts to configure Certbot.

## Prerequisites
- This script assumes a clean Ubuntu environment.
- Ensure you are running the script with appropriate permissions (e.g., sudo).

## Caution
- Double-check the inputs before proceeding to avoid errors.
- Review the generated Nginx virtual host configuration in /etc/nginx/sites-available/ to ensure it meets your requirements.

## License
- This script is licensed under the MIT License.
