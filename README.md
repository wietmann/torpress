# Torpress

Torpress is a project to help small media outlets to serve their WordPress websites through the Tor network to resist censorship.

## How it works

By starting a single container you are getting a WordPress website in the Tor network, which is very resilient to blocking and censorship. To access such websites a [Tor browser](https://www.torproject.org/) is needed.

## Usage

```
docker create --name torpress torpress:latest
docker start torpress
docker exec -it $(docker ps -f "name=torpress" -q) cat /var/lib/tor/hidden_service/hostname
```
The last command should output the address of your new website in the Tor network. It might take a little while for the address to be broadcasted in the network.
