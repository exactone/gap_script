mkdir ~/download
sudo apt-get install -y htop
echo '=============='
echo 'install cuda'
echo '=============='
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update && sudo apt-get install cuda

echo '=============='
echo 'install gcc'
echo '=============='

sudo apt-get update && \
sudo apt-get install build-essential software-properties-common -y && \
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
sudo apt-get update && \
sudo apt-get install gcc-snapshot -y && \
sudo apt-get update && \
sudo apt-get install gcc-6 g++-6 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
sudo apt-get install gcc-4.8 g++-4.8 -y && \
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8;


echo '=============='
echo 'install anaconda'
echo '=============='
wget -t0 -c -P ~/download https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
anaconda_installer=`ls ~/download/Anaconda*x86_64.sh`
chmod 755 $anaconda_installer
wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh
bash $anaconda_installer -b -p ~/anaconda3
export PATH="$HOME/miniconda/bin:$PATH"


$anaconda_installer
source ~/.bashrc
conda create --name keras2.0 --clone root
source activate keras2.0
pip install keras
pip install nltk
pip install word2vec
