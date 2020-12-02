# Docker-Nginx-ModSecurity-CoreRuleSet
Nginx Protected by ModSecurity&amp;OWASP ModSecurity CoreRuleSet , Containerized with Docker

This project is created according to the instructions described in the book "MODSECURITY 3.0 & NGINX: Quick Start Guide" by Faisal Memon, Owen Garrett, and Michael Pleshakov. For more information, please visit [the official website of this book](https://www.nginx.com/resources/library/modsecurity-3-nginx-quick-start-guide/)

## How to build?
Before building the docker image, you must make sure that docker and make are available on your workstation. You might also want to change the default version of "ModSecurity", "OWASP Core Rule Set" and "Nginx-ModSecurity Connector" which are configured as "MODSEC_VERSION", "CRS_VERSION" and "CONNECTOR_VERSION" respectively in the Makefile, and you definitely want to change the nginx configurations in the nginx/ directory or add extra ModSec rules in the nginx/modsec/ directory. Finally use the following command to build your docker image.

`
$ make build
`
