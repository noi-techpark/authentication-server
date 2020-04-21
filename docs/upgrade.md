Upgrade
=======

In this section you can find all relevant information on how to upgrade the authentication server.

More detailed description about the necessary steps and the migration changes can be found here: [https://www.keycloak.org/docs/latest/upgrading/](https://www.keycloak.org/docs/latest/upgrading/).

## Steps

The required steps that must be taken when upgrading the application are the followings:

1. Upgrade the Keycloak version by updating the Docker image in `docker/keycloak/Dockerfile`.

2. Make sure that the NOI theme in `themes/noi` does not have breaking changes or errors. This can be validated by comparing it to the original `keycloak` and `base` theme: [https://github.com/keycloak/keycloak/tree/master/themes/src/main/resources/theme](https://github.com/keycloak/keycloak/tree/master/themes/src/main/resources/theme).

    Another approach is to deploy the new version to the testing environment and clicking through all views. When there is no error, then everything should be fine.

3. Deploy the new version of the application.
