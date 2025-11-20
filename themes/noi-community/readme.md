<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC0-1.0
-->

NOI Community Theme
===================

The NOI is inspired by the NOI Website.

## Using the Theme

### I want to use the Sankt Virtual theme for all clients in the Realm.

Open "Realm Settings" -> "Themes" -> "Login Theme" and select "noiV2".

### I want to use the Sankt Virtual theme for selected clients only.

Open "Clients" -> "YOUR CLIENT" -> "Settings" -> "Login Theme" and select "noiV2".

## Development of Login Theme

The NOI Login Theme V2 is based on the "base" theme of Keycloak and uses Tailwind CSS for styling.

### Start gulp to watch changes in styles and properties file

```sh
cd common/resources
npm run watch
```

## Development of Account Theme

The NOI Account Theme V2 is base on the "keycloak.v2" theme. The Keycloak theme uses React and Patternfly for styling.
To change styles all you can do is overriding CSS variables of the default Patternfly theme. For reference look [here](https://www.patternfly.org/v4/get-started/global-css-variables/).

Just change CSS rules in the `layout.css` file and refresh the browser. This is enough to see the changes.
