# NYCU SDN NFV Docker

The script provided by the TA can mess up the environment in ways aren't quite my tempo, and it only supports Debian-based Linux distributions.

If you're not setting up a VM for this course and plan to use your own Linux machine, managing or cleaning up the environment could be a real hassle. To avoid that, I decided to create a Docker container to keep things isolated

To save you some time, I've included the `Dockerfile` and `docker-compose.yml` so you can set up the environment easily. Just keep in mind that the container runs in privileged mode with host network access to meet the homework requirements and improve debugging. Be cautious with any scripts you execute inside it.

> [!NOTE]
> Building ONOS on an aarch64 architecture can be challenging, so you may need to use an x86_64 machine instead. Also if you're considering running a x86_64 container on an aarch64 machine with OrbStack, be aware that OVS might not work due to a missing kernel module required by OVS. (OrbStack may support this in the future, but there’s no certainty yet.)

## Setup the environment with docker

### Start the container

```bash
sudo docker compose up -d
```

### Enter the container

```bash
sudo docker compose exec sdn_nfv_env bash
```

### Stop the container

```bash
sudo docker compose down
```
