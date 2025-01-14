# Akeyless OpenLDAP LDIF of Star Trek
Repo to store a configured OpenLDAP LDIF file to use to demonstrate LDAP importing

## Admin User

The admin user password should be `live long and prosper`

## Deployment Example

Setup the directory structure and download the 

```bash
mkdir -p ldap/data
mkdir -p ldap/config
mkdir -p ldif && curl -f -L -o ldif/startrek.ldif --create-dirs --retry 3 --retry-delay 2 --retry-max-time 30 -H "Accept: application/vnd.github.raw" "https://raw.githubusercontent.com/akeyless-community/akeyless-openldap-ldif-star-trek/refs/heads/main/star-trek.ldif"
```

Here is an exmaple Docker Compose file

```yaml
version: '3'
services:
  openldap:
    image: osixia/openldap:latest
    container_name: openldap
    environment:
      LDAP_ORGANISATION: "Starfleet Command"
      LDAP_DOMAIN: "starfleet.federation.org"
      LDAP_ADMIN_PASSWORD: "live long and prosper"
    ports:
      - "389:389"
      - "636:636"
    volumes:
      - ./ldap/data:/var/lib/ldap
      - ./ldap/config:/etc/ldap/slapd.d
      - ./ldif:/container/service/slapd/assets/config/bootstrap/ldif/custom

  phpldapadmin:
    image: osixia/phpldapadmin:latest
    container_name: phpldapadmin
    environment:
      PHPLDAPADMIN_LDAP_HOSTS: "openldap"
      PHPLDAPADMIN_HTTPS: "false"
    ports:
      - "8080:80"
    depends_on:
      - openldap
```
