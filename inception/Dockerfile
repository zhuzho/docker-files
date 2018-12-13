from centos:latest
# wget https://github.com/mysql-inception/inception/archive/master.zip

add master.zip bison-2.5.1.tar.gz inc.cnf /root/

run yum remove bison

workdir /root

run mkdir config

run mv inc.cnf config

run yum install unzip gcc-c++ g++ make cmake libncurses5-dev libssl-devbison openssl-devel.x86_64 ncurses-devel m4 -y

workdir bison-2.5.1 

run ./configure    

run make install

workdir ..

run unzip master.zip > /dev/null

run rm -f master.zip

workdir inception-master

run ./inception_build.sh debug

CMD exec ./debug/sql/Inception --defaults-file=/root/config/inc.cnf
