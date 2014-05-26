mkdir -p /etc/puppet/modules
#puppet module install benben-rubybuild # Debian

# On ArchLinux
wget https://aur.archlinux.org/packages/ru/ruby-build/ruby-build.tar.gz
tar -xvzf ruby-build.tar.gz
cd ruby-build
makepkg -cs
sudo pacman -U ruby-build-20140517-1-any.pkg.tar.xz

sudo ruby-build 2.0.0-p451 /opt/rubies/ruby-2.0.0-p451
