#! /bin/bash  
  
#Ldap server地址及base DN  
LDAP_SERVER_IP=ldap-1.bigdata.svc.cluster.local
BASE_DN='dc=justep,dc=com'  
  
#--------------------------------------------------------------------------------  
    
#创建preseed文件-软件安装自应答  
touch debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/ldap-server    string    ldap://$LDAP_SERVER_IP" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/base-dn    string    $BASE_DN" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/ldapns/ldap_version    select    3" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/dbrootlogin    boolean    false" >> debconf-ldap-preseed.txt  
echo "ldap-auth-config    ldap-auth-config/dblogin    boolean    false" >> debconf-ldap-preseed.txt  
echo "nslcd   nslcd/ldap-uris string  ldap://$LDAP_SERVER_IP" >> debconf-ldap-preseed.txt  
echo "nslcd   nslcd/ldap-base string  $BASE_DN" >> debconf-ldap-preseed.txt  

cat debconf-ldap-preseed.txt | debconf-set-selections  
        
#安装ldap client相关软件  
apt-get update -y && apt-get install -y ldap-utils libpam-ldap libnss-ldap nslcd  
          
#认证方式中添加ldap  
auth-client-config -t nss -p lac_ldap  
            
#认证登录后自动创建用户家目录  
#echo "session required pam_mkhomedir.so skel=/etc/skel umask=0022" >> /etc/pam.d/common-session  
              
#自启动服务  
update-rc.d nslcd enable  
                
#可以在Host上通过passwd更改用户密码  
cp /etc/pam.d/common-password /etc/pam.d/common-password.bak  
sed -i 's/use_authtok//' /etc/pam.d/common-password  
                  
#使配置生效  
/etc/init.d/nscd restart  
