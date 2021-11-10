Identity broker
==================

Keycloak supports [identity brokering](https://www.keycloak.org/docs/latest/server_admin/index.html#_identity_broker). An identity broker allows a user to connect different accounts on multiple identity providers into one single login.

Keycloak supports:
- SAML v2.0
- OpenID Connect v1.0
- OAuth v2.0

Moreover, Keycloak provides you with a set of social logins, where some configuration is already done for you.

## How to configure another Keycloak server as identity provider?

### Configuration on the identity broker

1. Go to "Identity Providers"
2. Click on "Add provider"
3. Select "Keycloak OpenID Connect"
4. Enter alias (e.g. eurac) -> be careful, this value can not be changed after configuration
5. Enter display name -> this will be shown in the login page
6. Enabled -> true
7. Trust Email -> true, if you trust the identity provider, that it already validated the email
8. GUI order -> specify the position in the list of identity providers on the login page
9. First login flow -> first broker login (default flow, it will make sure that the user account gets merged and the required fields of a profile are filled out)
10. Sync mode -> import (data from identity provider is only synced the first time) (force: This option would sync the data on every login)
11. Authorization URL -> You will get this from the identity provider (e.g. https://edp-portal.eurac.edu/auth/realms/edp/protocol/openid-connect/auth)
12. Pass login_hint -> on
13. Token URL -> Similar to authorization url (replace /auth with /token)
14. Logout URL -> Similar to authorization url (replace /auth with /logout)
15. Client Authentication -> Client secret sent as basic auth (or another option if you prefer
16. Client ID -> Client ID of the client configuration in the identity provider 
17. Client Secret -> Client Secret of the client configuration in the identity provider

### Configuration on the identity provider

1. Go to "clients"
2. Click on "Create"
3. ClientID -> e.g. (edp@eurac)
4. Name -> Display name of the client
5. Enabled -> true
6. Client Protocol -> openid-connect
7. Access-Type -> confidential
8. Standard flow enabled -> true (for the user login)
9. Service accounts enabled -> true (so that the servers can communicate)
10. Authorization enabled -> true
11. Valid Redirect URIs -> This is the Redirect URI from the identity broker
12. Backchannel logout -> If enabled it logs out every session of a user for each application

## How to configure Microsoft Azure as identity provider?

Keycloak provides you a simplified configuration for Microsoft identity provider.

### Configuration of identity broker

1. Go to "Identity Providers"
2. Click on "Add provider"
3. Select "Microsoft"
4. Client ID -> Client ID of the client configuration in Azure 
5. Client Secret -> Client Secret of the client configuration in Azure
6. Trust Email -> true
7. GUI order -> position in login screen
8. First Login Flow -> first broker login
9. Sync Mode -> import

### Configuration in Microsoft

You can find a very detail description on this [page](https://documentation.avaya.com/de-DE/bundle/AdministeringAvayaDeviceServices_R8.0.2/page/Office_365_Oauth2_configuration_checklist.html).
