# SSL自签名证书过程

## 第一步：生成CA证书
### 1- 修改全局配置文件：/etc/pki/tls/openssl.cnf （非必须，只是说修改后，好方便生成CA证书）
### 2- 进入/etc/pki/CA/目录，生成index.txt和serial文件，并写入"01"到serial文件中。
### 3- 生成根密钥：openssl genrsa -out private/cakey.pem 2048
### 4- 生成根证书：openssl req -new -x509 -key private/cakey.pem -out cacert.pem

## 第二步：生成haproxy所需为pem格式的ssl证书
### 1- cd /etc/pki/CA/
### 2- openssl genrsa -out haproxy.key 2048
### 3- openssl req -new -key haproxy.key -out haproxy.csr -days 35600
### 4- openssl x509 -req -in haproxy.csr -CA cacert.pem -CAkey private/cakey.pem -CAcreateserial -out haproxy.crt -days 35600
### 5- cat haproxy.crt haproxy.key > haproxy.pem

## 第三步：haproxy.cfg修改，请查看haproxy.cfg即可。

## 参考资料：
- https://www.jianshu.com/p/71ce5e6eb6a7
- https://www.cnblogs.com/qiumingcheng/p/12024280.html
- https://zhuanlan.zhihu.com/p/146587866