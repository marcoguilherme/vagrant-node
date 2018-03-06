MYSQL_PASSWORD="123456"
GIT_USER_NAME="marcoguilherme"
GIT_USER_EMAIL="mgbm13@gmail.com"
NODE_VERSION="9"



echo
echo "========================================================================"
echo "# ATUALIZANDO O SISTEMA OPERACIONAL"
echo "========================================================================"
sudo apt-get update && sudo apt-get upgrade -y



echo
echo "========================================================================"
echo "# INSTALANDO E CONFIGURANDO O GIT"
echo "========================================================================"
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"



echo
echo "========================================================================"
echo "# INSTALANDO DEPENDENCIAS"
echo "========================================================================"
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev \
                        libsqlite3-dev sqlite3 libxml2-dev libcurl4-openssl-dev python-software-properties \
                        libffi-dev nodejs libgdbm-dev libncurses5-dev automake libtool bison libxslt1-dev
						
						
echo
echo "========================================================================"
echo "# INSTALANDO NODEJS"
echo "========================================================================"
\curl -sSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
sudo apt-get update
sudo apt-get install nodejs -y
						
echo
echo "========================================================================"				
echo " INSTALANDO PM2 "
echo "========================================================================"	
sudo npm install pm2

echo "========================================================================"	
echo " INSTALANDO MONGODB "
echo "========================================================================"	

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64,ppc64el,s390x ] http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
sudo apt-get update
sudo apt-get install -y mongodb-enterprise


echo
echo "========================================================================"
echo "# INSTALANDO E CONFIGURANDO O MYSQL"
echo "========================================================================"
sudo apt-get install debconf-utils -y
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_PASSWORD}"
sudo apt-get install mysql-server mysql-client libmysqlclient-dev -y



echo
echo "========================================================================"
echo "# INSTALANDO E CONFIGURANDO O OH-MY-ZSH"
echo "========================================================================"
sudo apt-get update
sudo apt-get install zsh -y
echo "# setup zsh" >> .profile
echo "export SHELL=/bin/zsh" >> .profile
echo "[ -z "$ZSH_VERSION" ] && exec /bin/zsh -l" >> .profile
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc