# Socat Bridge - Home Assistant Addon

Addon per Home Assistant che crea bridge di rete usando **socat**. Perfetto per esporre servizi su indirizzi IP e porte differenti.

## Utilizzi comuni

- **Port forwarding**: Esporre una porta locale su una porta diversa
- **IP binding**: Fare il bridge tra due indirizzi IP
- **Device bridging**: Collegare dispositivi su reti diverse
- **Protocol forwarding**: Inoltrare traffico TCP/UDP

## Configurazione

### Esempio semplice

```bash
#!/usr/bin/with-contenv bashio

echo "Avvio dei bridge Socat..."

# Primo tunnel: porta 80 (avviato in background con &)
socat TCP4-LISTEN:80,fork,reuseaddr TCP4:192.168.1.1:80 &

# Secondo tunnel: porta 443 (mantenuto in primo piano per tenere attivo il container)
socat TCP4-LISTEN:443,fork,reuseaddr TCP4:192.168.1.18:443

```

```yaml
ports:
  80/tcp: 80
  443/tcp: 443
```


### Parametri

| Parametro | Descrizione | Esempio |
|-----------|-------------|---------|
| **name** | Nome identificativo del bridge | "Device Bridge" |
| **listen_address** | Indirizzo di ascolto (0.0.0.0 = tutti) | "0.0.0.0" |
| **listen_port** | Porta di ascolto | 8080 |
| **target_address** | IP/hostname destinazione | "192.168.1.100" |
| **target_port** | Porta destinazione | 80 |
| **protocol** | TCP o UDP | "TCP" |
| **enabled** | Abilita/disabilita il bridge | true/false |

## Configurazione Avanzata

### Multiple Bridge

```yaml
bridges:
  - name: "Fotocamera"
    listen_address: "0.0.0.0"
    listen_port: 8081
    target_address: "192.168.1.50"
    target_port: 8080
    protocol: "TCP"
    enabled: true
  
  - name: "Sensore UDP"
    listen_address: "0.0.0.0"
    listen_port: 5000
    target_address: "192.168.1.200"
    target_port: 5000
    protocol: "UDP"
    enabled: true

log_level: "info"
```

### Binding su interfaccia specifica

```yaml
bridges:
  - name: "Local Only"
    listen_address: "127.0.0.1"  # Solo localhost
    listen_port: 3000
    target_address: "192.168.1.100"
    target_port: 3000
    protocol: "TCP"
    enabled: true
```

## Debug

### Abilitare log verbosi

Imposta `log_level: "debug"` nella configurazione per vedere i dettagli delle connessioni.

### Controllare lo stato

```bash
# Dall'host Home Assistant
docker ps | grep socat
docker logs addon_socat_bridge
```

## Troubleshooting

### Bridge non si avvia
- Verifica che le porte non siano già in uso
- Controlla che gli indirizzi IP siano raggiungibili
- Guarda i log con debug abilitato

### Connessione lenta
- Aumenta `fork` in socat per gestire più connessioni
- Verifica la connettività di rete

### Errore "Permission denied"
- Porte < 1024 richiedono permessi particolari
- Usa porte > 1024

## Sicurezza

⚠️ **Attenzione**: Non esporre servizi critici senza autenticazione

## Limiti

- Massimo numero di connessioni simultanee dipende dalle risorse di Home Assistant
- UDP potrebbe avere comportamenti diversi dal TCP
- Firewall del sistema potrebbe bloccare le porte

## Support

Per problemi, controlla:
1. La sintassi YAML della configurazione
2. I log dell'addon
3. La raggiungibilità dei target
4. Le porte non siano bloccate dal firewall
