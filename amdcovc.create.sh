#!/bin/bash
PathHome=$(dirname $(readlink -f $0))
PathScript=$(dirname $PathHome)
cd $PathScript
sudo apt install pciutils libpci-dev libncurses-dev

wget https://github.com/matszpk/amdcovc/archive/refs/tags/0.4.1.1.tar.gz
tar -xvzf 0.4.1.1.tar.gz
cd amdcovc-0.4.1.1/
make
./amdcovc -v

echo "#!/bin/bash
cd "$(dirname "$0")"
./amdcovc ccoreclk:0=900 
./amdcovc ccoreclk:1=900
./amdcovc ccoreclk:2=900
./amdcovc ccoreclk:3=900
./amdcovc ccoreclk:4=900 
" > $PathScript/amdcovc-0.4.1.1/amdcovc.sh
chmod +x $PathScript/amdcovc-0.4.1.1/amdcovc.sh
