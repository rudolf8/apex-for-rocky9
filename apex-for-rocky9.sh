#!/bin/bash
# bash script to install Oracle 23AI FREE datebase and APEX 24 (with ORDS) on Rocky Linux 9x

start_time=$(date +%s)

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

# get & install Java 17
dnf install -y java-17-openjdk
alternatives --set java /usr/lib/jvm/java-17-openjdk-17*/bin/java

cd /opt

# download latest oracle-database-preinstall-23ai
curl -JLO https://yum.oracle.com/repo/OracleLinux/OL9/appstream/x86_64/getPackage/oracle-database-preinstall-23ai-1.0-2.el9.x86_64.rpm

# download Oracle 23AI FREE database
curl -JLO https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23ai-1.0-1.el9.x86_64.rpm

# install package 
dnf -y install /opt/oracle-database-preinstall-23ai-1.0-2.el9.x86_64.rpm

# install database 
dnf -y localinstall /opt/oracle-database-free-23ai-1.0-1.el9.x86_64.rpm

export DB_PASSWORD="ApexRocky9"
(echo -e "${DB_PASSWORD}\n${DB_PASSWORD}";) | /etc/init.d/oracle-free-23ai configure

sed -i 's/:N/:Y/' /etc/oratab

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
hours=$((elapsed_time / 3600))
minutes=$(( (elapsed_time % 3600) / 60 ))
seconds=$((elapsed_time % 60))

echo "Elapsed time: ${hours}h ${minutes}m ${seconds}s"



