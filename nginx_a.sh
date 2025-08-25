#!/bin/bash
apt install  nginx  -y
# Must be run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

AUTH_DIR="/etc/nginx/auth"
SITE_DIR="/etc/nginx/sites-enabled"

# 1. Create auth directory
mkdir -p "$AUTH_DIR"

# 2. Enter username and password
read -p "Enter auth username: " AUTH_USER
read -s -p "Enter auth password: " AUTH_PASS
echo
read -s -p "Re-enter auth password: " AUTH_PASS2
echo

if [ "$AUTH_PASS" != "$AUTH_PASS2" ]; then
  echo "Passwords do not match. Exiting."
  exit 1
fi

# Generate password file (using openssl)
PASS_HASH=$(openssl passwd -apr1 "$AUTH_PASS")
echo "$AUTH_USER:$PASS_HASH" > "$AUTH_DIR/.passwd"

echo "Auth file created: $AUTH_DIR/.passwd"

# 3. Enter domain and proxy URL
read -p "Enter domain name (e.g., example.com): " DOMAIN
read -p "Enter proxy target URL (e.g., https://127.0.0.1:8443): " PROXY_URL

CONF_FILE="$SITE_DIR/$DOMAIN.conf"

# 4. Generate nginx config
cat > "$CONF_FILE" <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        auth_basic "Restricted Area";
        auth_basic_user_file $AUTH_DIR/.passwd;

        proxy_pass $PROXY_URL;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        # Ignore SSL certificate verification for upstream
        proxy_ssl_verify off;
        proxy_ssl_verify_depth 0;
        proxy_ssl_server_name off;
    }
}
EOF

echo "Nginx config created: $CONF_FILE"

# 5. Test nginx config
nginx -t
if [ $? -ne 0 ]; then
  echo "Nginx configuration test failed. Please check $CONF_FILE"
  exit 1
fi

# 6. Restart nginx
systemctl restart nginx
if [ $? -eq 0 ]; then
  echo "Nginx restarted successfully. Domain $DOMAIN is now configured."
else
  echo "Failed to restart nginx. Please check system logs."
fi
