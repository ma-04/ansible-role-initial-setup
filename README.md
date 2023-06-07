### Required Files ###

## All ##
```vars/main.yml```
# rename example.main.yml to main.yml

## Wireguard ##
```wireguard/files/{{ inventory_hostname }}.conf ```
For wireguard server config file, wireguard/files folder doesnt exist and needs to be created

## certbot ##
```certbot/certbot/credentials.ini```
For certbot dns validation