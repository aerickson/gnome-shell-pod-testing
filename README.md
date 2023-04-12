# gnome-shell-pod testing

see https://github.com/Schneegans/gnome-shell-pod

## testing steps

```
# install deps on ubuntu host
sudo apt-get -y update
sudo apt-get -y install podman imagemagick

# download firefox tgz and place in dir
wget https://ftp.mozilla.org/pub/firefox/releases/112.0/linux-x86_64/en-US/firefox-112.0.tar.bz2

# run test
./detached.sh
```
