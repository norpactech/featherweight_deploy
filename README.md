## Cluster recovery when new containers are introduced
This section only applies to persisting data in the environment. If your using ephemeral mode, please disregard. 

When a cluste is created, a unique Peer Id i.e. de0c0742d488:3306 is created for the database node. The problem 
is that when a container is distroyed, the previous Peer Id will not be reassinged to the new container. 
Thus, the cluster is broken and error messages will appear. i.e.:
```
[GCS] Error on opening a connection to peer node de0c0742d488:3306 when joining a group.
```
###
To recover from this scnario two actions need to be taken:
1. Remove the 'mysql_innodb_cluster_metadata' schema from each node
2. Remove the mysqld-auto.cnf file from the root data directory

##
Removing the 'mysql_innodb_cluster_metadata'...
- Gracefully shut down docker:
```bash
docker compose stop
```
- Run the mysql-shell in interactive mode. In the docker compose file, uncomment the following
line: 
```
entrypoint: tail -f /dev/null
```
- Restart docker
```bash
docker compose up (or docker-compose up -d)
```
- Attach your console to the mysql-shell and run the following script:
```bash
docker exec -it mysql-shell bash
bash-4.2# mysqlsh -f scripts/remove-metadata.js
```
- Gracefully shutdown docker
```bash
docker compose stop
```
- Run the mysql-shell in batch mode. In the docker compose file, comment the following
line: 
```
# entrypoint: tail -f /dev/null
```

##
Removing the mysqld-auto.cnf file from each server data directory...
- Go to the utils/bat folder of this project and run:
```bash
featherweight_deploy\utils\bat>remove-cluster-config.bat
```
- Restart docker
```bash
docker compose up (or docker-compose up -d)
```


## Cert stuff


```bash
openssl x509 -in docker/mysql-router/certs/server.crt -out docker/mysql-router/certs/server.crt.pem
openssl rsa -in docker/mysql-router/certs/server.key -out docker/mysql-router/certs/server.key.pem
cat docker/mysql-router/certs/server.crt docker/mysql-router/certs/server.key > docker/mysql-router/certs/server.includeprivatekey.pem
```
```bash
docker compose restart mrs-router
docker exec -u root -ti mrs-mrs-router-1 mysql -u root -ppassword -h mysql-server-1 --port 3301 < GRANT 'mysql_rest_service_admin' TO 'root'@'%';
docker exec -u root -ti mrs-mrs-router-1 mysql -u root -ppassword -h mysql-server-1 --port 3301 < GRANT 'mysql_rest_service_meta_provider', 'mysql_rest_service_data_provider' TO 'restuser'@'%';
```



```bash
docker exec -u root -ti mrs-mrs-router-1 mysqlrouter -c /etc/mysqlrouter/mysqlrouter.conf
```


```bash
docker exec -u root -ti mrs-mrs-router-1 mysqlrouter_passwd set /etc/mysqlrouter/mysqlrouter.pwd webappuser
docker exec -u root -ti mrs-mrs-router-1 chown -R mysqlrouter:mysqlrouter /etc/mysqlrouter
docker exec -u root -ti mrs-mrs-router-1 mysqlrouter -a /etc/myrouter/mysqlrouter.conf
```

GRANT 'mysql_rest_service_admin' TO 'restuser'@'%';
GRANT 'mysql_rest_service_meta_provider', 'mysql_rest_service_data_provider' TO 'restuser'@'%';

/var/lib/mysqlrouter/.mysqlrouter.conf


# SELF SIGNED SSL CERTIFICATES 
```bash

To generate SSL certificate files using Linux, you can use OpenSSL, a widely used tool for managing digital certificates and encryption. Here's how you can generate the files.
`ca.pem`, `server-cert.pem`, e `server-key.pem`:

1. Generate the private key of the certificate authority (CA).
   
   ```
   openssl genrsa -out ca-key.pem 2048
   ```

2. Generate the certificate of the certification authority (CA).
   
   ```
   openssl req -new -x509 -days 365 -key ca-key.pem -out ca.pem
   ```

Follow the instructions to provide the requested information, such as the common name (Common Name), which should be the name of your CA.

3. Generate the private key of the server.

   ```
   openssl genrsa -out server-key.pem 2048
   ```

4. Generate a certificate signing request (CSR) for the server.

   ```
   openssl req -new -key server-key.pem -out server-csr.pem
   ```

   Again, follow the instructions to provide the requested information, including the correct identification of the server.

5. Sign the CSR with the private key of the CA to obtain the server certificate.

   ```
   openssl x509 -req -days 365 -in server-csr.pem -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem
   ```

   This command signs the CSR with the private key of the CA (ca-key.pem) to create the server certificate (server-cert.pem) valid for 365 days.

Now you have generated the three required files: ca.pem (certificate of the certification authority), server-cert.pem (server certificate), and server-key.pem (server's private key). Make sure to carefully protect the server's private key (server-key.pem) as it is crucial for the security of your server.

```