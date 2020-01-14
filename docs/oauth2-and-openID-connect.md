OAuth 2.0 and OpenID Connect
============================

## Table of contents

- [OAuth 2.0](#oauth-2.0)
- [OpenID Connect](#openid-connect)

## OAuth 2.0

OAuth 2.0 is a security standard that specifies how you can give or grant an application the permission to access your data from another application.
You, as a user, allow or grant permission, to access your data, or use features in another application on your behalf. The important thing here is that you never share your password with the other applications. As you are not sharing your credentials with other applications, you are able to limit the scope of which data and features are accessible for each application.

https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc


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



