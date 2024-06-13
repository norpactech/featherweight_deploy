```bash
openssl x509 -in docker/mysql-router/certs/server.crt -out docker/mysql-router/certs/server.crt.pem
openssl rsa -in docker/mysql-router/certs/server.key -out docker/mysql-router/certs/server.key.pem
cat docker/mysql-router/certs/server.crt docker/mysql-router/certs/server.key > docker/mysql-router/certs/server.includeprivatekey.pem
```
```bash
docker compose restart mrs-router
docker exec -u root -ti mrs-mrs-router-1 mysql -u root -pcara55I0 -h mrs-server-1 --port 3301 < GRANT 'mysql_rest_service_admin' TO 'root'@'%';
docker exec -u root -ti mrs-mrs-router-1 mysql -u root -pcara55I0 -h mrs-server-1 --port 3301 < GRANT 'mysql_rest_service_meta_provider', 'mysql_rest_service_data_provider' TO 'restuser'@'%';
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
Per generare i file certificati SSL utilizzando Linux, è possibile utilizzare OpenSSL, uno strumento ampiamente utilizzato per gestire certificati digitali e crittografia. Ecco come puoi generare i file `ca.pem`, `server-cert.pem`, e `server-key.pem`:

1. **Genera la chiave privata del certificato dell'autorità di certificazione (CA)**:
   
   ```
   openssl genrsa -out ca-key.pem 2048
   ```

2. **Genera il certificato dell'autorità di certificazione (CA)**:
   
   ```
   openssl req -new -x509 -days 365 -key ca-key.pem -out ca.pem
   ```

   Segui le istruzioni per fornire le informazioni richieste, come il nome comune (Common Name), che dovrebbe essere il nome del tuo CA.

3. **Genera la chiave privata del server**:

   ```
   openssl genrsa -out server-key.pem 2048
   ```

4. **Genera una richiesta di firma del certificato (CSR) per il server**:

   ```
   openssl req -new -key server-key.pem -out server-csr.pem
   ```

   Di nuovo, segui le istruzioni per fornire le informazioni richieste, inclusa la corretta identificazione del server.

5. **Firma il CSR con la chiave privata del CA per ottenere il certificato del server**:

   ```
   openssl x509 -req -days 365 -in server-csr.pem -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem
   ```

   Questo comando firma il CSR con la chiave privata del CA (`ca-key.pem`) per creare il certificato del server (`server-cert.pem`) valido per 365 giorni.

Ora hai generato i tre file richiesti: `ca.pem` (certificato dell'autorità di certificazione), `server-cert.pem` (certificato del server), e `server-key.pem` (chiave privata del server). Assicurati di proteggere attentamente la chiave privata del server (`server-key.pem`) poiché è cruciale per la sicurezza del tuo server.

```