#!/bin/bash
set -e

# Download latest awless binary from Github

ARCH_UNAME=`uname -m`
if [[ "$ARCH_UNAME" == "x86_64" ]]; then
	ARCH="amd64"
else
	ARCH="386"
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	OS="darwin"
elif [[ "$OSTYPE" == "win32" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] ; then
	OS="windows"
else
	echo "No awless binary available for OS '$OSTYPE'. You may want to use go to install awless with 'go get -u github.com/wallix/awless'"
  exit
fi

LATEST_VERSION=`curl -fs https://updates.awless.io | grep -oE "v[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"`

DOWNLOAD_URL="https://github.com/wallix/awless/releases/download/$LATEST_VERSION/awless-$OS-$ARCH.zip"

echo "Downloading awless from $DOWNLOAD_URL"

ZIPFILE="awless.zip"

if ! curl --fail -o $ZIPFILE -L $DOWNLOAD_URL; then
    exit
fi

echo ""
echo "unzipping $ZIPFILE to ./awless"
echo 'y' | unzip $ZIPFILE 2>&1 > /dev/null
echo "removing $ZIPFILE"
rm $ZIPFILE
chmod +x ./awless

echo ""
echo "awless successfully installed to ./awless"
echo ""
echo "don't forget to add it to your path, with, for example, 'sudo mv awless /usr/local/bin/' "
echo ""
echo "then, for autocompletion, run:"
echo "    [bash] echo 'source <(awless completion bash)' >> ~/.bashrc"
echo "    OR"
echo "    [zsh]  echo 'source <(awless completion zsh)' >> ~/.zshrc"
