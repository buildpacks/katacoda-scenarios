#!/bin/bash
mkdir -p /opt/.katacodacode/user-data/User/
cat << VSCODEEOF > /opt/.katacodacode/user-data/User/settings.json
{ 
  "editor.tokenColorCustomizations": {
      "semanticHighlighting": true
  },
  "files.exclude": {
    "**/.*": true
  }
}
VSCODEEOF

(curl -sSL "https://github.com/buildpacks/pack/releases/download/v0.18.1/pack-v0.18.1-linux.tgz" | sudo tar -C /usr/local/bin/ --no-same-owner -xzv pack)
sudo touch /opt/setup-done
docker pull cnbs/sample-builder:bionic
docker pull buildpacksio/lifecycle
