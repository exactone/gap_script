echo '=============='
echo 'SSL authentication, manual enter needed'
echo '=============='
mkdir ~/ssl
#openssl genrsa -des3 -out ~/ssl/bonzoyang.key 1024 
#openssl req -new -key ~/ssl/bonzoyang.key -out  ~/ssl/bonzoyang.req
#sudo openssl x509 -req -days 7305 -sha1 -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey ~/ssl/bonzoyang.key -in ~/ssl/bonzoyang.req -out /etc/ssl/certs/bonzoyang.crt
cd ~/ssl
#openssl req -x509 -newkey rsa:2048 -keyout ~/ssl/key.pem -out ~/ssl/cert.pem -days 7230
openssl req -x509 -nodes -days 3650 -newkey rsa:1024 -keyout ~/ssl/mykey.key -out ~/ssl/mycert.pem
cd ~


echo '=============='
echo 'install performance surveillance'
echo '=============='
mkdir ~/download
sudo apt-get install -y htop
sudo apt-get install -y p7zip-full


#echo '=============='
#echo 'install cuda'
#echo '=============='
#wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
#sudo yes y | dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
#sudo apt-get update && sudo apt-get install cuda


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


#echo '=============='
#echo 'install CUDA, cuDNN'
#echo '=============='
#sudo cp gcp_script/gdrive-linux-x64 /usr/local/bin/gdrive
#sudo chmod a+x /usr/local/bin/gdrive
#cd ~/download
##wget https://drive.google.com/open?id=0B3slvjD82cAJQncwMVJWc0oxNlk -O cudnn-8.0-linux-x64-v5.1.tar
#gdrive download 0B3slvjD82cAJQncwMVJWc0oxNlk
#tar -xf cudnn-8.0-linux-x64-v5.1.tar
#cd ~

echo '=============='
echo 'install apach'
echo '=============='
sudo apt-get install -y apache2


echo '=============='
echo 'install anaconda'
echo '=============='
wget -t0 -c -P ~/download https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh
#anaconda_installer=`ls ~/download/Anaconda*x86_64.sh`
#chmod 755 $anaconda_installer
#$anaconda_installer -b -p ~/anaconda3
chmod 755 ~/download/Anaconda*x86_64.sh
~/download/Anaconda3-4.3.1-Linux-x86_64.sh -b -p ~/anaconda3
echo "export PATH=\"\$HOME/anaconda3/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda3/bin:$PATH"
#source ~/.bashrc


#echo '=============='
#echo 'install google api'
#echo '=============='
#sudo apt-get -y install --upgrade python-pip
#pip install --upgrade pip
#pip install --upgrade google-api-python-client


echo '=============='
echo 'set jupyter notebook server'
echo '=============='
echo "y" | jupyter notebook --generate-config
sedhome=$(echo $HOME | sed 's/\//\\\//g')
sed -i "s/#c.NotebookApp.certfile = ''/c.NotebookApp.certfile = '$sedhome\/ssl\/mycert.pem'/g"  ~/.jupyter/jupyter_notebook_config.py 
sed -i "s/#c.NotebookApp.keyfile = ''/c.NotebookApp.keyfile = '$sedhome\/ssl\/mykey.key'/g"  ~/.jupyter/jupyter_notebook_config.py
sed -i "s/#c.NotebookApp.ip = 'localhost'/c.NotebookApp.ip = '\*'/g"  ~/.jupyter/jupyter_notebook_config.py
touch get_sha_passwd.py
echo "from IPython.lib import passwd" >> get_sha_passwd.py
echo "print(passwd())" >> get_sha_passwd.py
sha1passwd=`python get_sha_passwd.py`
rm -f get_sha_passwd.py
sed -i "s/#c.NotebookApp.password = ''/c.NotebookApp.password = u'$sha1passwd'/g" ~/.jupyter/jupyter_notebook_config.py 
sed -i "s/#c.NotebookApp.open_browser = True/c.NotebookApp.open_browser = False/g" ~/.jupyter/jupyter_notebook_config.py
sed -i "s/#c.NotebookApp.port = 8888/c.NotebookApp.port = 9999/g" ~/.jupyter/jupyter_notebook_config.py


echo '=============='
echo 'install Django'
echo '=============='
conda create --name Django --clone root
source activate Django
pip install Django
source deactivate
## https://github.com/bstriner/keras-tqdm
#pip install keras-tqdm
#pip install tensorflow-gpu


#echo '=============='
#echo 'install keras, keras-tqdm, tensorflow-gpu'
#echo '=============='
#conda create --name keras2.0 --clone root
#source activate keras2.0
#pip install keras
## https://github.com/bstriner/keras-tqdm
#pip install keras-tqdm
#pip install tensorflow-gpu


#echo '=============='
#echo 'install kaggle-cli, '
#echo '=============='
## https://github.com/floydwch/kaggle-cli
#pip install kaggle-cli


#echo '=============='
#echo 'install gensim, word2vec, nltk'
#echo '=============='
#pip install gensim
#pip install word2vec
#pip install nltk
#touch nltk_download.py
#echo "import nltk" >> nltk_download.py
#echo "nltk.download('all')" >> nltk_download.py
#python nltk_download.py
#rm -f nltk_download.py


#echo '=============='
#echo 'install xgboost'
#echo '=============='
## https://github.com/dmlc/xgboost
## https://pypi.python.org/pypi/xgboost/
#pip install xgboost
#source activate keras2.0
## solve 'GOMP_4.0 not found' bug
## https://github.com/dmlc/xgboost/issues/1786
#conda install libgcc
## solve 'libstdc++.so.6: version `GLIBCXX_3.4.22' not found' bug
## https://itbilu.com/linux/management/NymXRUieg.html
#cd ~/anaconda3/envs/keras2.0/lib
#cp /usr/lib32/libstdc++.so.6.0.23 .
#sudo rm -rf libstdc++.so.6
#sudo ln -s libstdc++.so.6.0.23 libstdc++.so.6
#cd ~
#source deactivate keras2.0
