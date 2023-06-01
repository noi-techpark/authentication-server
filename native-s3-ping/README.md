<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC0-1.0
-->

# Native S3 Ping

This plugin provides the necessary S3 ping cluster detection dependencies.

## How to build the artifact?

```sh
mvn clean install
```

## How to build the artifact with docker?

```sh
docker run --rm -v $PWD:/code -w /code maven:3-openjdk-11 mvn clean install
```

## How to add the jar in Keycloak?

Copy the jar (that includes the dependencies) in the target folder to the `/opt/keycloak/providers/` folder.

Or when using Docker mount the file `./native-s3-ping/target/native-s3-ping-jar-with-dependencies.jar:/opt/keycloak/providers/native-s3-ping-jar-with-dependencies.jar`
