#!/bin/bash

# Update and install prerequisites
sudo apt-get update
sudo apt-get install -y golang-go python3-pip cargo git

# Set GOPATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Install Go tools
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install github.com/ferreiraklet/airixss@latest
go install github.com/dwisiswant0/cf-check@latest
go install -v github.com/edoardottt/cariddi/cmd/cariddi@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/jaeles-project/gospider@latest
go install -v github.com/Emoe/kxss@latest
go install github.com/hakluke/hakrevdns@latest
go install github.com/hakluke/haktldextract@latest
go install github.com/hakluke/haklistgen@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/tomnomnom/qsreplace@latest
go install github.com/shenwei356/rush@latest
go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
go install -v github.com/lc/subjs@latest
go install -v github.com/dwisiswant0/unew@latest
go install github.com/tomnomnom/unfurl@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/detectify/page-fetch@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install Python tool
pip3 install bhedak

# Install Cargo tool
cargo install x8

# Clone and install Metabigor
git clone https://github.com/j3ssie/metabigor.git
cd metabigor
go install
cd ..

# Metabigor usage examples
# echo 'example.com' | metabigor related -s 'whois'
# echo 'https://example.com' | metabigor related -s 'google-analytic'
# cat list_of_ips.txt | metabigor ipc --json

echo "Installation completed."
