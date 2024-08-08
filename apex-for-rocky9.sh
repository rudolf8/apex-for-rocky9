#!/bin/bash
# bash script to install Oracle 23AI FREE datebase and APEX 24 (with ORDS) on Rocky Linux 9x

# Start the timer
# start_time=$(date +%s)

# check if user is root
if [[ $(whoami) != "root" ]]; then
  echo "This program must be run as root." >&2  
  exit 1
fi

# set up Rocky Linux & install KDE
# update system
dnf -y install epel-release
dnf -y update

dnf config-manager --set-enabled crb

# NE 
#dnf groupinstall -y “KDE Plasma Workspaces”
#dnf --enablerepo=epel group -y install “KDE Plasma Workspaces” “base-x”

dnf -y group install "Server with GUI"
systemctl set-default graphical

# install grubby & various software 
dnf install -y grubby git nano unzip wget sudo
dnf install -y bc binutils compat-openssl10 elfutils-libelf glibc glibc-devel ksh libaio libXrender libX11 libXau libXi libXtst libgcc libnsl libstdc++ libxcb libibverbs make 
dnf install -y policycoreutils policycoreutils-python-utils smartmontools sysstat libnsl2 net-tools nfs-utils 

# disable SElinux
grubby --update-kernel ALL --args selinux=0

# install Java 17
dnf install -y java-17-openjdk
alternatives --set java /usr/lib/jvm/java-17-openjdk-17*/bin/java

# download Java 
# wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

cd /opt

# download latest oracle-database-preinstall-23ai
curl -JLO https://yum.oracle.com/repo/OracleLinux/OL9/appstream/x86_64/getPackage/oracle-database-preinstall-23ai-1.0-2.el9.x86_64.rpm

# download Oracle 23AI FREE database
curl -JLO https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23ai-1.0-1.el9.x86_64.rpm

# install package 
dnf -y install /opt/oracle-database-preinstall-23ai-1.0-2.el8.x86_64.rpm

# install database 
dnf -y localinstall /opt/oracle-database-free-23ai-1.0-1.el9.x86_64.rpm

#export DB_PASSWORD=Chevapiand1beer!
#(echo "${DB_PASSWORD}"; echo "${DB_PASSWORD}";) | /etc/init.d/oracle-free-23c configure
#sed -i '/^FREE:\/opt\/oracle\/product\/23c\/dbhomeFree:/s/:N$/:Y/' /etc/oratab







