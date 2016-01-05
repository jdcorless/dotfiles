# How to install the Nikola static site generator on Ubuntu
# From Martin Wimpress article
# https://flexion.org/posts/2015-11-installing-nikola-on-ubuntu/

sudo apt-get install cython3 libpython3.4 python3.4 python3.4-dev python3.4-minimal
sudo apt-get install python-setuptools python-virtualenv python-pip virtualenvwrapper
virtualenv -p /usr/bin/python3.4 ~/Snakepit/nikola-773
source ~/Snakepit/nikola-773/bin/activate
cd Snakepit/nikola-773/
sudo apt-get install liblcms2-dev libfreetype6-dev libjpeg8-dev libopenjp2-7-dev libtiff5-dev libwebp-dev libxslt1-dev libxml2-dev libyaml-dev libzmq-dev zlib1g-dev
sudo apt-get install closure-compiler jpegoptim optipng yui-compressor
sudo apt-get -y remove libtidy-0.99-0 tidy
wget http://binaries.html-tidy.org/binaries/tidy-5.1.14/tidy-5.1.14-64bit.deb -O /tmp/tidy5.deb
sudo dpkg -i /tmp/tidy5.deb
sudo ln -s /usr/bin/tidy /usr/local/bin/tidy5
rm /tmp/tidy5.deb
pip install --upgrade Cython
pip install --upgrade "Nikola[extras,tests]"

# Initiating a demo (populates with example data) blog
# nikola init --demo testblog
# cd testblog/
# nikola install_theme lanyon
# edit conf.py to set THEME="lanyon"
# nikola plugin -i orgmode
# make changes to POSTS and COMPILERS in conf.py per instructions
# nikola build && nikola serve
