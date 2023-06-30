### What can this do? ###

## This playbook will do: (Everything here is customisable)

- add hostname (from ansible hostname) to /etc/hosts 
- Install some packages
- Install zsh and setup some usefull alias
- Setup Swap and if running on azure( identified with .az in hostname), it will add swap to temporary storage
- Setup a loopback and a bridge interface
- Get ssl certificate with certbot
- Change ssh port to something non-standard
- setup iptables/nftables firewall
- Setup fail2ban
- Setup wireguard (private keys needs to be genarated beforehand)
- Install Docker and docker-compose and add user to docker group
- Setup prometheus node exporter service

### Required Files ###

**For All**

```vars/main.yml```
# rename example.main.yml to main.yml

**Wireguard**

```wireguard/files/{{ inventory_hostname }}.conf ```

For wireguard server config file, wireguard/files folder doesnt exist and needs to be created

**certbot**

```certbot/certbot/credentials.ini```

For certbot dns validation