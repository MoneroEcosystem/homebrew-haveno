#!/bin/sh
wget https://github.com/KewbitXMR/haveno-app/releases/download/v1.0.0/daemon-v1.0.18.jar -O /usr/local/bin/daemon.jar
wget -q https://github.com/KewbitXMR/haveno-app/releases/download/v1.0.0/monero-wallet-rpc -O /usr/local/bin/monero-wallet-rpc
chmod +x /usr/local/bin/monero-wallet-rpc
wget -q https://github.com/KewbitXMR/haveno-app/releases/download/v1.0.0/tor-4.5a6.zip -O /usr/local/bin/tor.zip
brew install unzip
unzip -q /usr/local/bin/tor.zip -d /usr/local/bin/
