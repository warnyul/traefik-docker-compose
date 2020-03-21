#!/usr/bin/env sh

# Variables
BASEDIR=$(dirname "$0")

# Load environment variables
set -a # automatically export all variables
source .env
source .dev.env
set +a

# Install dnsmasq if needed
if brew ls --versions dnsmasq > /dev/null; then
    echo "dnsmasq is already installed"
else
    brew install dnsmasq
fi

# Override dnsmasq.conf
cat > $(brew --prefix)/etc/dnsmasq.conf <<EOF

# Route all *.${DOMAIN} addresses to localhost
address=/${DOMAIN}/127.0.0.1

# Don't read /etc/resolv.conf or any other configuration files.
no-resolv
# Never forward plain names (without a dot or domain part).
domain-needed
# Never forward addresses in the non-routed address spaces.
bogus-priv

EOF

# Create a resolver for DOMAIN to allow MacOS resolve our subdomains
sudo mkdir -p /etc/resolver
sudo bash -c "echo 'nameserver 127.0.0.1' > /etc/resolver/${DOMAIN}"

# Restart dnsmasq service
sudo brew services restart dnsmasq