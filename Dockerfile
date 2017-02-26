FROM ubuntu:xenial

# Adapted from ryshe/terraria to use xenial and drop Tshock
MAINTAINER J. Patrick Moffitt <zuryn@zuryn.net>

# Add mono repository
# Update and install mono and a zip utility
# fix for favorites.json error
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update && apt-get install -y zip mono-complete
RUN apt-get clean

ENV favorites_path "/root/My Games/Terraria"

RUN mkdir -p "$favorites_path" && echo "{}" > "$favorites_path/favorites.json"

# Allow for external data
VOLUME ["/world"]

# run the server
ENTRYPOINT ["mono", "--server", "--gc=sgen", "-O=all", "TerrariaServer.exe", "-configpath", "/world", "-worldpath", "/world", "-logpath", "/world"]
