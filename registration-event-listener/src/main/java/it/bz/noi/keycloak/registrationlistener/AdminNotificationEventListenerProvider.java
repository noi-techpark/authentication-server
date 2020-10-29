package it.bz.noi.keycloak.registrationlistener;

import org.jboss.logging.Logger;
import org.keycloak.email.DefaultEmailSenderProvider;
import org.keycloak.email.EmailException;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.models.*;

import java.util.List;
import java.util.Optional;

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

            Optional<GroupModel> sanktVirtualGroup = this.model.getGroups(realm).stream()
                    .filter(groupModel -> "Sankt Virtual Managers".equals(groupModel.getName()))
                    .findFirst();

            if (sanktVirtualGroup.isEmpty()) {
                log.info("The \"Sankt Virtual Managers\" does not exist and therefore we don't send a registration notification mail.");
                return;
            }

            UserModel newRegisteredUser = this.session.users().getUserById(event.getUserId(), realm);
            List<UserModel> usersToNotify = this.session.users().getGroupMembers(realm, sanktVirtualGroup.get());

            String emailPlainContent = "New user registration\n\n" +
                    "Email: " + newRegisteredUser.getEmail() + "\n" +
                    "Username: " + newRegisteredUser.getUsername() + "\n" +
                    "Client: " + event.getClientId();

            String emailHtmlContent = "<h1>New user registration</h1>" +
                    "<ul>" +
                    "<li>Email: " + newRegisteredUser.getEmail() + "</li>" +
                    "<li>Username: " + newRegisteredUser.getUsername() + "</li>" +
                    "<li>Client: " + event.getClientId() + "</li>" +
                    "</ul>";

            DefaultEmailSenderProvider senderProvider = new DefaultEmailSenderProvider(session);

            usersToNotify.forEach(userToNotify -> {
                try {
                    senderProvider.send(session.getContext().getRealm().getSmtpConfig(), userToNotify, "Keycloak - New Registration", emailPlainContent, emailHtmlContent);
                } catch (EmailException e) {
                    log.warn("Failed send notification to: " + userToNotify.getEmail());
                }
            });


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
