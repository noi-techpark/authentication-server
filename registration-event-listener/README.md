# Registration Event Listener

This is a custom event listener for Keycloak events. 
Its goal is to notify an admin about new user registrations via email.

## How to change the email address of the user that gets notified?

Open `it.bz.noi.keycloak.registrationlistener.AdminToNotify` and change the email. 
Build the artifact and redeploy keycloak.

## How to build the artifact?

```sh
mvn clean install
```

## How to add the jar in Keyclaok?

Copy the jar in the target folder to the `/opt/jboss/keycloak/standalone/deployments/` folder.
Or when using Docker mount the file `./registration-event-listener-0.0.1-SNAPSHOT.jar:/opt/jboss/keycloak/standalone/deployments/registration-event-listener-0.0.1-SNAPSHOT.jar`

## How to configure the event listener in Keycloak?

Set the event listener

* Open up Keycloak administration console and select your realm
* Go to events in the left side bar under Manage
* Open the config [tab]
* click in the input box next to event listeners, a dropdown with all available event listeners is shown
* select our registration_event_listener
