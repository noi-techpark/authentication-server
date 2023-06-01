// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

package it.bz.noi.keycloak.registrationlistener;

import java.util.Set;

public class EmailNotificationGroup {
    private final String name;
    private final Set<String> clients;

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
