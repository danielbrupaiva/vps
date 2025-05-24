# Setups and References

## SSH
- Generate new ssh key pair
```bash
ssh-keygen -t ed25519
```
- Send a copy of pub key to target
```bash
ssh-copy-id -i /home/$USER/.ssh/id_ed25519.pub USER@REMOTE_IP
```

## Git / Github
- Add the new public key content at Gihub account setting

```bash
cat /home/$NEW_USER/.ssh/id_ed25519.pub
````
- Git configs
```bash
sudo git config --system user.name "Your Name"
sudo git config --system user.email "you@example.com"
````
## Linux

- Create new user at VPS

```bash
sudo adduser $NEW_USER
```

- Grant sudo access

```bash
sudo usermod -aG sudo $NEW_USER
```

- Login with new user

```bash
su - $NEW_USER
```

## Docker

Install docker

- https://docs.docker.com/engine/install/debian/
- https://docs.docker.com/engine/install/linux-postinstall/

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Post install
# Add new user at docker group to no need to elevate user's privileges

sudo groupadd docker
sudo usermod -aG docker $USER
# logout and login to apply new group
exit
su - $NEW_USER
# check if docker is running wiht new user add in docker group
docker run hello-world
```

### Useful commands for docker

- Docker Compose

```bash
docker compose up -d --build
```

```bash
docker compose down
```

```bash
docker exec
```

```bash
docker cp
```

```bash
docker run
```

- Clean system

```bash
docker system prune -a --volumes
```

or

- Stop all running containers

```bash
docker stop $(docker ps -q)
```

- Remove all containers

```bash
docker rm $(docker ps -aq)
```

- Remove all images

```bash
docker rmi -f $(docker images -q)
```

- Remove all volumes

```bash
docker volume rm $(docker volume ls -q)
```

- Remove all networks (except default ones)

```bash
docker network rm $(docker network ls -q)
```
