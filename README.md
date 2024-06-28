## postgREST Development/Evaulation Environment

This project contains a Docker Compose file for development/evaluation of the postgREST environment. 
The following components are installed and configured:

1. Postgres Database
2. pgAdmin
3. postgREST instance

It's important to note that the docker compose file downloads the :latest versions of all images.
As of this writing, everything worked in harmony. There might be instances, however, where versions
might be incompatible. If that becomes evident, there may be a need to set the versions of each 
image explicitly.

### postgREST Roles

See [postgREST Authentication](https://postgrest.org/en/v12/references/auth.html)

pgAdmin right-click on database -> select 'CREATE Script' -> run the following:

```sql
CREATE ROLE authenticator LOGIN NOINHERIT NOCREATEDB NOCREATEROLE NOSUPERUSER;
CREATE ROLE anonymous NOLOGIN;
CREATE ROLE apiuser NOLOGIN;
```

Users are created in the system using the following, where:
 - [username] is a database user:
 - [api] is the name of a schema
 - [object] is the name of a table, etc...

```sql
GRANT usage ON SCHEMA [schema] TO apiuser;
GRANT all ON [schema].[object] to apiuser;

GRANT [username] TO authenticator;
GRANT [username] TO webuser;
GRANT anonymous TO authenticator;
```

### Keycloak

http://localhost:9080/realms/featherweight/protocol/openid-connect/certs

PGRST_JWT_SECRET: [https://www.mathieupassenaud.fr/codeless_backend/](https://www.mathieupassenaud.fr/codeless_backend/)