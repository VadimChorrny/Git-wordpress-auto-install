function installWordpress(){
    echo "NAME OF DB "
    read -e namedb
    echo "USER OF DB "
    read -e userdb
    echo "PASS OF DB "
    read -s passdb
    sudo yum -y update httpd
    sudo yum -y install httpd
    sudo firewall-cmd --permanent --add-service=http
    sudo firewall-cmd --permanent --add-service=https
    sudo firewall-cmd --reload
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo yum -y install mariadb-server
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    sudo mysql_secure_installation
    yum install epel-release yum-utils -y
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql -y
    yum -y install phpmyadmin
    yum -y install rsync
    cd /var/www
    curl https://uk.wordpress.org/latest-uk.tar.gz > wordpress.tar.gz
    tar xzf wordpress.tar.gz
    rsync -avP wordpress/ /var/www/html/
}
read -p "Do you want to install Wordpress? " answer
if [[ "$answer" == "y" ]]; then
    installWordpress;
elif [[ "$answer" == "n" ]]; then
    exit
