# darthhater/sonatype-book-docker

A Dockerfile for creating an environment for building Sonatype book projects

```
$ docker run --name sonatype-book-docker darthhater/sonatype-book-docker
```
To (re)build the image:

Copy the Dockerfile and do the build-

```
$ docker build --rm=true --tag=darthhater/sonatype-book-docker .
```