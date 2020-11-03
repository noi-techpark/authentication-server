package it.bz.noi.keycloak.registrationlistener;

import java.util.Set;

public class EmailNotificationGroup {
    private String name;
    private Set<String> clients;

    public EmailNotificationGroup(String name, Set<String> clients) {
        this.name = name;
        this.clients = clients;
    }

    public String getName() {
        return name;
    }

    public Set<String> getClients() {
        return clients;
    }
}
