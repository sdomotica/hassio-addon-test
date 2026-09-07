#!/usr/bin/with-contenv bashio

echo "Avvio del bridge Socat..."
echo "Reindirizzamento: Porta locale 83 -> 192.168.1.120:80"
#echo "Reindirizzamento: Porta locale 83 -> 192.168.1.102:80"

# Esecuzione di socat
#INIM
socat TCP-LISTEN:83,fork,reuseaddr TCP:192.168.1.120:80
#Ecowitt
#socat TCP-LISTEN:83,fork,reuseaddr TCP:192.168.1.102:80