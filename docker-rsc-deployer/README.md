# rsc-deployer

Dockerfile and scripts for deploying examples en masse to an RSC of your choosing.

1. Connect to the RSC instance you want to deploy to locally on your Mac through RStudio.
1. Build the docker image: `docker build -t rsc-deployer .`
1. Run the docker image and link your rsc config directory as a shared volume:

```
docker run -it -v "/Users/$(whoami)/Library/Application Support/R/rsconnect":/root/.config/R/rsconnect rsc-deployer bash
```

In the container run R and install the version of Shiny you want to test with: 

`devtools::install_github("rstudio/shiny@v1.2-rc")`

Back in the shell, go to the directory all the examples were unzipped to during build:

`cd /shiny-examples`

Deploy the first app to make sure it works (use your account name and target server):

```
deployApp.R alan rsc.radixu.com 001-hello
```

Deploy all the apps, 5 at a time:

```
find * -maxdepth 0 -type d | egrep '^[0-9]{3}' | parallel -j5 deployApp.R alan rsc.radixu.com {}
```
