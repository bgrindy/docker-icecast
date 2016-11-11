# docker-icecast

## Build Image
Keep in mind, the default security is not overriden yet!
```bash
docker build -t icecast .
```
## Network security concerns with UFW
may need to prevent UFW bypass
```bash
# /etc/defaults/docker
DOCKER_OPTS="--iptables=false"

# restart docker
sudo service docker restart

# add ufw rule
sudo ufw allow from 192.168.20.0/24 to any port 8000
```

## Run icecast
```bash
docker run -d -p 8000:8000 --name ic icecast
```

## Route pulseaudio sink to icecast server using gstreamer1.0
If running into issues, try using fakesink with gstreamer.
```bash
# Setup a null sink
pactl load-module module-null-sink

# Use gstreamer pipeline null->flac->ogg->icecast
gst-launch-1.0 pulsesrc device=null.monitor ! \
audioconvert ! \
audio/x-raw,format=S16LE,channels=2 ! \
flacenc ! \
oggmux ! \
shout2send \
ip=localhost \
port=8000 \
username=source \
password=hackme \
mount=/stream

# Use pavucontrol to redirect app to null sink
pavucontrol
```
