## URLShortener PIENI

An URL Shortener with a small footprint, written with node.js and redis.


###Build and deploy
Build Dockerfile
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.15; export REDIS_VERSION=0.0.20; docker build pieni -t pieni-poc:latest```

Deploy to openshift
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.15; export REDIS_VERSION=0.0.20; ./install.sh```

remove on openshift
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.15; export REDIS_VERSION=0.0.20;./remove.sh```

redeploy (remove and install)
```export PIENI_PROJECT=u210645-pieni; export PIENI_POC_VERSION=0.0.15; export REDIS_VERSION=0.0.20;./redeploy.sh```
