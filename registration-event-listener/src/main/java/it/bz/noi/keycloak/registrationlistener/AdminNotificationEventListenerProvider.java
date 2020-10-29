package it.bz.noi.keycloak.registrationlistener;

import org.jboss.logging.Logger;
import org.keycloak.email.DefaultEmailSenderProvider;
import org.keycloak.email.EmailException;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.RealmProvider;
import org.keycloak.models.UserModel;

public class AdminNotificationEventListenerProvider implements EventListenerProvider {

    private static final Logger log = Logger.getLogger(AdminNotificationEventListenerProvider.class);

    private final KeycloakSession session;
    private final RealmProvider model;

    public AdminNotificationEventListenerProvider(KeycloakSession session) {
        this.session = session;
        this.model = session.realms();
    }

    @Override
    public void onEvent(Event event) {

        if (EventType.REGISTER.equals(event.getType())) {
            log.infof("## NEW %s EVENT", event.getType());
            log.info("-----------------------------------------------------------");

            RealmModel realm = this.model.getRealm(event.getRealmId());
            UserModel user = this.session.users().getUserById(event.getUserId(), realm);

            DefaultEmailSenderProvider senderProvider = new DefaultEmailSenderProvider(session);

            try {
                String emailPlainContent = "New user registration\n\n" +
                        "Email: " + user.getEmail() + "\n" +
                        "Username: " + user.getUsername() + "\n" +
                        "Client: " + event.getClientId();

                String emailHtmlContent = "<h1>New user registration</h1>" +
                        "<ul>" +
                        "<li>Email: " + user.getEmail() + "</li>" +
                        "<li>Username: " + user.getUsername() + "</li>" +
                        "<li>Client: " + event.getClientId() + "</li>" +
                        "</ul>";


                senderProvider.send(session.getContext().getRealm().getSmtpConfig(), new AdminToNotify(), "Keycloak: New Registration - " + realm.getName(), emailPlainContent, emailHtmlContent);

                log.info("Successfully send notification email");
            } catch (EmailException e) {
                log.info("Failed to send Email");
            }


            log.info("-----------------------------------------------------------");
        }
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean b) {
    }

    @Override
    public void close() {
    }

}
