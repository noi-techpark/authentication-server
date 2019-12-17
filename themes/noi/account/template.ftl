<#macro mainLayout active bodyClass>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <title>${msg("accountManagementTitle")}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
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
    <header>
        <div class="mb-4">
            <div class="mb-4 xl:mb-0 flex content-end items-stretch border-b border-gray-500">
                <div class="p-4 flex flex-col justify-center">
                    <a href="/"><img src="${url.resourcesPath}/img/noi.svg" alt="NOI" class="image-noi" /></a>
                </div>
                <div class="flex flex-grow border-l border-gray-500 items-center justify-end mr-2">
                    <nav role="navigation" class="flex mr-4 items-center">
                        <div class="group relative block">
                            <button class="relative border-3 border-black md:min-w-sm px-3 md:px-4 py-2 group-hover:bg-black group-hover:text-white uppercase cursor-pointer">
                                ${locale.current}
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center right-0 fill-current">
                                    <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                                </svg>
                            </button>
                            <ul class="z-10 shadow hidden absolute right-0 left-0 group-hover:block bg-white">
                                <#list locale.supported as l>
                                    <li><a href="${l.url}" class="block px-4 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                                </#list>
                            </ul>
                        </div>
                    </nav>
                    <div class="flex items-center"><#if referrer?has_content && referrer.url?has_content><a href="${referrer.url}" id="referrer" class="btn btn-black">${msg("backTo",referrer.name)}</a></#if></div>
                    <div class="flex items-center"><a href="${url.logoutUrl}" class="flex btn btn-black">${msg("doSignOut")}</a></div>
                </div>
            </div>
        </div>
    </header>

    <div class="container m-auto flex flex-row">
        <div class="flex flex-col min-w-sm">
            <ul class="px-2">
                <li class="side-menu-item <#if active=='account'>side-menu-item-active</#if>"><a href="${url.accountUrl}">${msg("account")}</a></li>
                <#if features.passwordUpdateSupported><li class="side-menu-item <#if active=='password'>side-menu-item-active</#if>"><a href="${url.passwordUrl}">${msg("password")}</a></li></#if>
                <li class="side-menu-item <#if active=='totp'>side-menu-item-active</#if>"><a href="${url.totpUrl}">${msg("authenticator")}</a></li>
                <#if features.identityFederation><li class="side-menu-item <#if active=='social'>side-menu-item-active</#if>"><a href="${url.socialUrl}">${msg("federatedIdentity")}</a></li></#if>
                <li class="side-menu-item <#if active=='sessions'>side-menu-item-active</#if>"><a href="${url.sessionsUrl}">${msg("sessions")}</a></li>
                <li class="side-menu-item <#if active=='applications'>side-menu-item-active</#if>"><a href="${url.applicationsUrl}">${msg("applications")}</a></li>
                <#if features.log><li class="<#if active=='log'>active</#if>"><a href="${url.logUrl}">${msg("log")}</a></li></#if>
                <#if realm.userManagedAccessAllowed && features.authorization><li class="<#if active=='authorization'>active</#if>"><a href="${url.resourceUrl}">${msg("myResources")}</a></li></#if>
            </ul>
        </div>

        <div class="flex flex-col flex-grow mx-2">
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
