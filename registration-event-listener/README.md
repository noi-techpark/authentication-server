# Registration Event Listener

This is a custom event listener for Keycloak events. Its goal is to notify an admin about new user registrations via email.

## How to build the artifact?

```sh
mvn clean install
```

## How to build the artifact with docker?

```sh
docker run --rm -v $PWD:/code -w /code maven:3-openjdk-11 mvn clean install
```

## How to add the jar in Keycloak?

Copy the jar in the target folder to the `/opt/keycloak/providers/` folder.
Or when using Docker mount the file `./registration-event-listener/target/registration-event-listener-0.0.1-SNAPSHOT.jar:/opt/keycloak/providers/registration-event-listener-0.0.1-SNAPSHOT.jar`

## How to configure the event listener in Keycloak?

Set the event listener

* Open up Keycloak administration console and select your realm
* Go to `Realm settings` and open the tab `Events`
* Click in the input box next to event listeners, a dropdown with all available event listeners is shown
* Select the `admin_notification_listener`

## How to add users to get notified about new registrations?

In order to add a user to the list of users that get notified, you need to add them to the group "Email Notification Group".
