### What can this do? ###

## This playbook will do: (Everything here is customisable) (Primarily made for Ubuntu/Debian based systems)

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
    - Setup internal dns resolution for all hosts in the wireguard network (Usefull for docker swarm, kubernetes, etc)
- Install Docker and docker-compose and add user to docker group
    - Setup default docker bind address to the wireguard interface
- Setup prometheus node exporter service

### Required Files ###

**Required for most roles**
```bash
ansible-galaxy install -r requirements.yml -p roles/galaxy/ --force
```

**Variables for For All**

```vars/main.yml```
<br>rename example.main.yml to main.yml

**Wireguard**

```wireguard/files/{{ inventory_hostname }}.conf ```

For wireguard server config file, wireguard/files folder doesnt exist and needs to be created

### Containers
- Portainer agent
    - By default, setup a portainer agent container for all host except any host with the group name 'reverse_proxy'
- Watchtower
- Uptime-Kuma
    - Requires a group in ansible host with the name `uptime_kuma` for installation to that groups vm


**certbot**

```certbot/certbot/credentials.ini```

For certbot dns validation

**LXC**
<br>```lxc/files/.env-lac-backups```

**Prometheus**

```prometheus/files/node_exporter.crt```

```prometheus/files/node_exporter.key```

For prometheus node exporter ssl certificate
To generate a self signed certificate, run the following command:

```openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout node_exporter.key -out node_exporter.crt```
