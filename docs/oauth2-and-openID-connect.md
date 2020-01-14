# OAuth 2.0 and OpenID Connect

## Table of contents

- [OAuth 2.0](#oauth-2.0)
- [OpenID Connect](#openid-connect)
- [Protocol Flows](#protocol-flows)

## OAuth 2.0

OAuth 2.0 is a security standard that specifies how you can give or grant an application the permission to access your data from another application.
You, as a user, allow or grant permission, to access your data, or use features in another application on your behalf. The important thing here is that you never share your password with the other applications. As you are not sharing your credentials with other applications, you are able to limit the scope of which data and features are accessible for each application.

This article shows an example how OAuth2.0 works. https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc

As you can see in the example, the user has to grant permission to the requested scopes. In this case the application only needs read access on the contact list. The issued access token will allow the client application only to read the contacts from your Email account and does not allow anything else, such as creating or deleting contacts.

It is also possible to grant access to a client application to its own behalf. This is very useful for server to server communication.

### The four roles in OAuth 2.0 

| Term                 | Description                                                                                                                                                                                                                                                          |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Resource Owner       | You are the resource owner! You own your data and identity.                                                                                                                                                                                                          |
| Client               | An application that wants to access data from or act as the resource owner.                                                                                                                                                                                          |
| Authorization Server | The authorization server holds the account of the resource owner.                                                                                                                                                                                                    |
| Resource Server      | This is a service that holds specific information or provides functionality that a client wants to use on behalf of the Resource Owner. For example this service can be a contact service, that manages all contacts of a user.                                      |
| Authorization Server | The authorization server holds the account of the resource owner and issues access tokens to the client after successfully authenticating the resource owner and obtaining authorization. Has the user the user the necessary rights to answer the requested scopes? |

## OpenID Connect

### ID Token

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

#### NOTE

The ID_Token can **not** be used to request information from a resource server. You always have to use the **access_token**.

## Protocol Flows

On an abstract level the protocol can be defined in 3 steps.

1. Authorization Request

The client requests authorization from the resource owner. The client receives an authorization grant, which is a credential representing the resource owner.

2. Token request

The client uses the authorization grant from the previous response and authenticates itself at the authorization server to get an access token.

3. Protected resource request

With the access token the client app can request protected resources in behalf of the user. The resource server validates the access token and, if valid, serves the request.

### Authorization Grant

An authorization grant is a credential representing the resource owner's authorization (to access its protected resources) used by the client to obtain an access token. Oauth supports different grant types: Authorization Code, Implicit, Resource Owner Password Credentials, Client Credentials.



