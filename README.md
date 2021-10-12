# Modelcatalogue (FDA Modelkataloget)
Dette repositorium indeholder implementeringen af det fællesoffentlige katalog over begrebs- og datamodeller

## Om FDA Modelkataloget
FDA Modelkataloget leverer et katalog over begrebs- og datamodeller udarbejdet i offentligt regi og som er registret med henblik på videndeling og genbrug. Derudover indeholder dette katalog også oplysninger om en række anerkendte internationale modeller som kan have en bred anvendelse i dansk administrativ og fællesoffentlig kontekst. 

**Link til Modelkatalog:** 
https://data.gov.dk/catalogue/models 

Ydeligere beskrivelse vedrørende kataloget kan findes her: 
https://arkitektur.digst.dk/node/610 

## Overordnet arkitekturbeskrivelse
FDA Modelkataloget realiserer et behov for webudstilling af et fællesoffentligt katalog over begrebs- og datamodeller. 

Løsningen består af metadata om modeller (modeldatasæt) samt en transformationsapplikation der konverterer datasættet serialiseret som RDF/XML til HTML.

## Implementeringen

## Modelmetadata
Modelmetadata distribueres i et maskinlæsbart format (en RDF/XML-fil) på følgende link: https://data.gov.dk/catalogue/models/xml/modelkatalog.rdf.xml

### Datamodellen modelDCAT-AP
Den bagvedliggende datamodel for Modelkataloget udgøres af anvendelsesprofilen [modelDCAT-AP](https://github.com/digst/modelDCAT-AP) som er udarbejdet som en profil af den internationale datakatalogstandard [DCAT-AP](https://joinup.ec.europa.eu/solution/dcat-application-profile-data-portals-europe). 



# Local setup

## Prerequisite:
 - [Docker compose](https://docs.docker.com/compose/install)

## Steps:
1.  Clone git repo.
2.  Navigate into folder and run `docker compose up`
3.  Enter http://localhost inside your preferred browser.

> You can change the port for where the application should run by replacing the line in `docker-compose.yaml` where the ports are specified with:
```
ports: 
    - 8080:80
```
> Run `docker-compose up` and it should now be accessible on http://localhost:8080.


# Helmchart deployment for Modelcatalogue

## Pre-requisites:
- kubectl is configured and connected


## Deployment steps:

1. Navigate into `helm` directory.
2. Create a namespace on rancher.
3. Create the credentials for docker registry if they don't exist globally or for the namespace:

### replace `[]` with actual values
`kubectl create secret docker-registry [secretName] --docker-server=[reg.govcloud.dk] --docker-username='[robot-name]' --docker-password=[robot-token] -n [namespace]`


### Almost working example without namespace
`kubectl create secret docker-registry harbor-credentials --docker-server=reg.govcloud.dk --docker-username='robot$sprogressourcen+helm-test' --docker-password=4Aaytoe6X5oiMwYiddfGzx8GtKrrZBcQ -n [namespace]`

4. Upgrading previous deployment and/or installing a new in a namespace:
`helm upgrade [deployment name] . -n [namespace] --install`


> Choosing a good deployment name will make it easier to upgrade / uninstall later, and will give a better overview of deployments.



## Other helm commands

#### Listing deployments in a namespace:
`helm ls -n [namespace]`

#### Uninstalling a deployment in a namespace:
`helm uninstall [deployment name] -n [namespace]`

#### Generate a single deployment yaml from the helm template:
`helm template .`


#### Extending / overwriting values file:
When deploying you can specify the values file to be used, by default it will be `values.yaml`.

Example of specifying an exact values file:
`helm upgrade [deployment name] . -n [namespace] --install -f test-deploy.yaml`


Example of extending values files:
`helm upgrade [deployment name] . -n [namespace] --install -f test-deploy.yaml -f disabled-pv.yaml`

> Values will be overwritten accordingly to the order specified in the commando.
So in the case above, disabled-pv.yaml will overwrite test-deploy.yaml for those key/values pairs.

