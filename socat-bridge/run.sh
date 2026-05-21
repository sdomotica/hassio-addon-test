#!/usr/bin/with-contenv bashio

echo "Avvio del bridge Socat..."
echo "Reindirizzamento: Porta locale 83 -> 192.168.1.120:80"

# Esecuzione di socat
socat TCP-LISTEN:83,fork,reuseaddr TCP:192.168.1.120:80