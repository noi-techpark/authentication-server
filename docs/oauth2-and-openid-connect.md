# OAuth 2.0 and OpenID Connect

## Table of contents

- [OAuth 2.0](#oauth-2.0)
- [OpenID Connect](#openid-connect)
- [Authorization Grant and Flow](#authorization-grant-and-flow)

# OAuth 2.0

OAuth 2.0 is a security standard that specifies how you can give or grant an application the permission to access your data from another application.
You, as a user, allow or grant permission, to access your data, or use features in another application on your behalf. The important thing here is that you never share your password with the other applications. As you are not sharing your credentials with other applications, you are able to limit the scope of which data and features are accessible for each application.

This article shows an example how OAuth2.0 works. https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc

As you can see in the example, the user has to grant permission to the requested scopes. In this case the application only needs read access on the contact list. The issued access token will allow the client application only to read the contacts from your Email account and does not allow anything else, such as creating or deleting contacts.

It is also possible to grant access to a client application to its own behalf. This is very useful for server to server communication.

## The four roles in OAuth 2.0 

| Term                 | Description                                                                                                                                                                                                                                                          |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Resource Owner       | You are the resource owner! You own your data and identity.                                                                                                                                                                                                          |
| Client               | An application that wants to access data from or act as the resource owner.                                                                                                                                                                                          |
| Resource Server      | This is a service that holds specific information or provides functionality that a client wants to use on behalf of the Resource Owner. For example this service can be a contact service, that manages all contacts of a user.                                      |
| Authorization Server | The authorization server holds the account of the resource owner and issues access tokens to the client after successfully authenticating the resource owner and obtaining authorization. Has the user the user the necessary rights to answer the requested scopes? |

# OpenID Connect

OpenID Connect is an extension to the OAuth 2.0 protocol. It enables the client application to get basic profile information about the End-User.

## ID Token

The primary extension that OpenID Connect makes to OAuth 2.0 to enable End-Users to be Authenticated is the ID Token data structure. A client can securely extract user information from the ID Token. This information can be used to personalize the web experience. In the ID_Token request (scope: openid) it is possible to define claims. A claim is a piece of user specific information such as email, phone and more. The values of the requested claims are encoded in the ID_Token and can be consumed by the client.

```json
{
  "name": "John Doe",
  "preferred_username": "john.doe",
  "given_name": "John",
  "locale": "en",
  "family_name": "Doe",
  "email": "john.doe@aboutbits.it"
}
```

Claims can be requested explicitly with the claims parameter, or implicitly by the requested scope. The OpenID Connect standard describes the standard claims in this [document](https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims).

Claims are also included if certain scopes are requested. For example if you request the scope profile, following claims will be included by default: name, preferred_username, given_name, locale, family_name.

### NOTE

The ID_Token can **not** be used to request information from a resource server. You always have to use the **access_token**.

# Client registration

The first step to use OAuth in your client is the registration step. In order for the client app to initiate a OAuth2.0 flow it needs to be listed on the authorization server.

You register your application with some basic information such as name, website, logo,... Moreover you need to register a redirect URI to redirect users back to your web server, SPA or mobile app.

## Redirect URI

The service will only redirect to the configured redirect URI. This URI has to be served via HTTPS for web apps. The client has to handle the returned codes or tokens from the URI.

## Client ID and secret 

Upon registration of the client app in the registration panel of the service, you will receive a client ID and secret. The client ID is public information and is used to build login URLs. The client secret is used by the client application to prove its identity to the authorization server and therefore must be kept **confidential**. This means single page apps or mobile apps can not use the client secret. 

# Authorization Grant and Flow

The authorization grant defines how access_tokens can be requested by the client application. Check out following resources for more details:

- [IETF](https://tools.ietf.org/html/rfc6749#section-1.2)
- [Introduction to OAuth 2](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2)


## Grant Type: Authorization Code

**Use case**: Server-side applications

This is the most commonly used grant type with server side rendered web apps, because the client secret can be kept confidential on the server. Once the server is authenticated it will receive an access_token and a refresh_token. The access_token usually has a short time to live. The refresh token can be used to request new access tokens.

## Grant Type: Implicit

**Use case**: Single page applications, mobile apps

The access_token is already returned in the redirect URI . This allows browser extensions and browser history to read access_tokens. Be careful with this approach. When this grant type is used, make sure to limit the scope to the minimum possible configuration.

This grant type also doesn't support refresh tokens.

The authorization server authenticates the client solely on the redirect URI, because the client secret can not be kept confidential for such apps.

## Grant Type: Client credentials

**Use case**: Server to server communication

The Application acts on the behalf of itself. The client application POSTS the client ID and the client secret without any user information to the authorization server and gets in the response an access and a refresh token, which can be used to access resources.
