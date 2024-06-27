## postgREST environment

This is a development/evaluation project to exercise the postgREST environment. In a nutshell, 
the following components are installed and configured:

1. Postgres Database
2. pgAdmin
3. postgREST instance

It's important to note that the docker compose file downloads the :latest versions of all images.
As of this writing, everything worked in harmony. There might be instances, however, where versions
might be incompatible. If that becomes evident, there may be a need to set the versions of each 
image explicitly.