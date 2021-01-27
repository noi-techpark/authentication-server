<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>${msg("accountManagementTitle")}</title>
    
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />

    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script type="text/javascript" src="${url.resourcesPath}/${script}"></script>
        </#list>
    </#if>

</head>
<body class="admin-console user ${bodyClass}">
        
    <header class="navbar navbar-default navbar-pf navbar-main header">
        <nav class="navbar" role="navigation">
            <div class="navbar-header">
                <div class="container">
                    <h1 class="navbar-title">Keycloak</h1>
                </div>
            </div>
            <div class="navbar-collapse navbar-collapse-1">
                <div class="container">
                    <ul class="nav navbar-nav navbar-utility">
                        <#if realm.internationalizationEnabled>
                            <li>
                                <div class="kc-dropdown" id="kc-locale-dropdown">
                                    <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                    <ul>
                                        <#list locale.supported as l>
                                            <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                        </#list>
                                    </ul>
                                </div>
                            <li>
                        </#if>
                        <#if referrer?has_content && referrer.url?has_content><li><a href="${referrer.url}" id="referrer">${msg("backTo",referrer.name)}</a></li></#if>
                        <li><a href="${url.logoutUrl}">${msg("doSignOut")}</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="flex flex-row flex-grow">
        <div class="hidden min-w-md border-r border-gray-500 lg:flex flex-col pt-2">
            <ul class="min-w-sm px-2">
                <li class="side-menu-item<#if active=='account'>side-menu-item-active</#if>"><a href="${url.accountUrl}">${msg("account")}</a></li>
                <#if features.passwordUpdateSupported><li class="side-menu-item <#if active=='password'>side-menu-item-active</#if>"><a href="${url.passwordUrl}">${msg("password")}</a></li></#if>
                <li class="side-menu-item <#if active=='totp'>side-menu-item-active</#if>"><a href="${url.totpUrl}">${msg("authenticator")}</a></li>
                <#--  <#if features.identityFederation><li class="side-menu-item <#if active=='social'>side-menu-item-active</#if>"><a href="${url.socialUrl}">${msg("federatedIdentity")}</a></li></#if>  -->
                <li class="side-menu-item <#if active=='sessions'>side-menu-item-active</#if>"><a href="${url.sessionsUrl}">${msg("sessions")}</a></li>
                <#--  <li class="side-menu-item <#if active=='applications'>side-menu-item-active</#if>"><a href="${url.applicationsUrl}">${msg("applications")}</a></li>  -->
                <#--  <#if features.log><li class="side-menu-item <#if active=='log'>side-menu-item-active</#if>"><a href="${url.logUrl}">${msg("log")}</a></li></#if>  -->
                <#if realm.userManagedAccessAllowed && features.authorization><li class="side-menu-item <#if active=='authorization'>side-menu-item-active</#if>"><a href="${url.resourceUrl}">${msg("myResources")}</a></li></#if>
            </ul>
        </div>

        <div class="col-sm-9 content-area">
            <#if message?has_content>
                <div class="alert alert-${message.type}">
                    <#if message.type=='success' ><span class="pficon pficon-ok"></span></#if>
                    <#if message.type=='error' ><span class="pficon pficon-error-circle-o"></span></#if>
                    <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>

            <#nested "content">
        </div>
    </div>

</body>
</html>
</#macro>
