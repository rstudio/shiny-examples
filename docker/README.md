Running development version of Shiny in Shiny Server in Docker
==============================================================

This Dockerfile allows you to run the latest version of Shiny from GitHub in Shiny Server. It installs shiny-examples from GitHub so that when you run the container, it will by default serve up those examples. It is also possible to mount a local directory at /srv/shiny-server, if you would like to run apps that are hosted on the local machine.


## Shiny Server

### Building

To build the Docker image, start in the shiny-examples directory and run:

```sh
docker build -t ss-shiny-devel docker/
```

If you are not on the master branch and would like to build with shiny-examples from your current branch, run:

```sh
 docker build --build-arg SHINY_EXAMPLES_BRANCH=$(git symbolic-ref --short -q HEAD) -t ss-shiny-devel .
```

This will tell it to install shiny-examples from your currently checked-out branch. (`git symbolic-ref --short -q HEAD` returns the name of the current branch.)

### Running the image

Option 1: Run Shiny Server with the already-installed shiny-examples:

```sh
docker run --rm -p 3838:3838 --name ss ss-shiny-devel
```

Option 2: Run Shiny Server with the shiny-examples directory mounted from the host. This allows you to modify the examples from the host:

```sh
# Start in the shiny-examples directory
docker run --rm -p 3838:3838 -v $(pwd):/srv/shiny-server --name ss ss-shiny-devel
```

Option 3: Run Shiny Server with shiny-examples directory mounted from the host, as well as the shiny source directory mounted from the host. This lets you modify the Shiny source code on the host and install it on the Shiny Server:

```sh
# Start in the parent directory of shiny and shiny-examples
docker run --rm -p 3838:3838 \
    -v $(pwd)/shiny-examples:/srv/shiny-server \
    -v $(pwd)/shiny:/shiny \
    --name ss ss-shiny-devel

# Then, in another terminal, you can install Shiny:
docker exec -ti ss Rscript -e 'devtools::install("/shiny")'
```

### Miscellaneous notes

If you want to install newer versions of packages from GitHub, the cleanest way is to delete the `ss-shiny-devel` image and rebuild. The image can be deleted with:

```sh
docker rmi ss-shiny-devel
# Then run `docker build` again
```

If you need to enter a running container and inspect it or install software on it, run:

```sh
docker exec -ti ss /bin/bash
```


## Deploying apps from a container

It is possible to deploy apps from a container, using the Shiny Server image created above. It has all the necessary packages installed, and all the packages will be up-to-date (if the container was built recently).

You must already have your rsconnect credentials set up in the host machine. Launching the container as shown below will make those credentials available inside the container. Note that this will mount the host's shiny-examples/ directory, in case you need to temporarily modify any examples or the `deploy` script. (If you don't want to do this, remove the `-v $(pwd):/srv/shiny-server` from the command).

```sh
# Deploy from host's shiny-examples directory
cd shiny-examples
docker run --rm -ti --name deployer \
    -v "$(pwd)":/srv/shiny-server \
    -v "$(Rscript -e 'cat(rsconnect:::rsconnectConfigDir())')":/root/.config/R/rsconnect \
    ss-shiny-devel /bin/bash
```

Once in the container, you can deploy apps with:

```sh
cd /srv/shiny-server
./deploy 111 116

# Or, to deploy all
./deploy --all
```
