#!/usr/bin/with-contenv bashio

# Array con le configurazioni: "porta_locale:ip_dest:porta_dest:nome"
CONFIGURAZIONI=(
    "83:192.168.110.60:80:INIM"
    "84:192.168.1.102:80:Ecowitt"
    "502:192.168.110.60:502:INIMMODBUS2"
)

#    "502:192.168.1.120:502:INIMMODBUS"
#"83:192.168.1.120:80:INIM"

avvia_socat() {
    local config=$1
    IFS=':' read -r porta_locale ip_dest porta_dest nome <<< "$config"
    
    echo "Avvio $nome: porta $porta_locale -> $ip_dest:$porta_dest"
    socat TCP-LISTEN:$porta_locale,fork,reuseaddr TCP:$ip_dest:$porta_dest &
}

echo "Avvio dei bridge Socat..."

for config in "${CONFIGURAZIONI[@]}"; do
    avvia_socat "$config"
done

echo "Tutti i bridge sono attivi"
wait