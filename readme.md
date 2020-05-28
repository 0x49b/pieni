## URLShortener PIENI

An URL Shortener with a small footprint, written with node.js and redis.


### Build and deploy

PIENI_PROJECT - Name of the Openshift Project  
PIENI_POC_VERSION - Version of Pieni to be deployed  
REDIS_VERSION - Version of Redis to be deployed  

All Versions are stored in the SBB Artifactory (bin.sbb.ch).

#### Build
Build Dockerfile
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.16; export REDIS_VERSION=0.0.20; docker build pieni -t pieni-poc:latest```


#### Deploy
cd into deploy and execute these commands:  
Deploy to openshift
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.16; export REDIS_VERSION=0.0.20; ./install.sh```

remove on openshift
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.16; export REDIS_VERSION=0.0.20;./remove.sh```

redeploy (remove and install)
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.16; export REDIS_VERSION=0.0.20;./redeploy.sh```

Attention: These Scripts are not suitable for production. They remove all parts from Openshift and readd them with new versions. For Production, you should use a rolling deployment Strategy