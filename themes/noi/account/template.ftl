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

        <div class="mb-2 flex content-end items-stretch border-b border-gray-500">
            <div class="p-4 flex flex-col justify-center">
                <a href="/"><img src="${url.resourcesPath}/img/noi.svg" alt="NOI" class="image-noi" /></a>
            </div>
            <div class="flex-1 flex flex-col justify-center px-4 border-l border-gray-500 leading-tight font-light text-2xl md:text-3xl sm:text-4xl">
                <a href="" class="block">${kcSanitize(msg(realm.displayNameHtml!''))?no_esc}</a>
            </div>
            <div class="flex items-center justify-end mr-4">
                <!-- Desktop Navigation -->
                <nav role="navigation" class="hidden sm:flex items-center">
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <div class="mr-2 group relative block">
                            <button class="relative border-3 border-black pl-4 pr-4 py-2 text-left group-hover:bg-black group-hover:text-white uppercase cursor-pointer">
                                <div class="block pr-2">
                                ${locale.current}
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                                    <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                                </svg>
                            </button>
                            <ul class="z-10 shadow hidden absolute right-0 left-0 group-hover:block bg-white">
                                <#list locale.supported as l>
                                    <li><a href="${l.url}" class="block px-2 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                                </#list>
                            </ul>
                        </div>
                    </#if>
                    <div class="flex items-center"><#if referrer?has_content && referrer.url?has_content><a href="${referrer.url}" id="referrer" class="btn btn-black">${msg("backTo",referrer.name)}</a></#if></div>
                    <div class="flex items-center"><a href="${url.logoutUrl}" class="flex btn btn-black">${msg("doSignOut")}</a></div>
                </nav>
            </div>
        </div>
    </header>

    <!-- Mobile Navigation -->
    <nav role="navigation" class="mb-2 mx-2 xs:mx-4 flex sm:hidden flex-col items-stretch">
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
            <div class="group relative block mb-2">
                <button class="relative w-full border-3 border-black pl-4 pr-4 py-2 text-left group-hover:bg-black group-hover:text-white uppercase cursor-pointer">
                    <div class="block pr-2">
                    ${locale.current}
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                        <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                    </svg>
                </button>
                <ul class="z-10 shadow hidden absolute right-0 left-0 group-hover:block bg-white">
                    <#list locale.supported as l>
                        <li><a href="${l.url}" class="block px-4 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                    </#list>
                </ul>
            </div>
        </#if>
        <#if referrer?has_content && referrer.url?has_content><a href="${referrer.url}" id="referrer" class="btn btn-black mb-2">${msg("backTo",referrer.name)}</a></#if>
        <a href="${url.logoutUrl}" class="block btn btn-black mb-2">${msg("doSignOut")}</a>
    </nav>

    <div class="container m-auto flex flex-row overflow-scroll">
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

            <div class="mb-4"><#nested "header"></div>

            <#if message?has_content>
                <div class="mb-4 border-2 px-4 py-3 <#if message.type = 'error'>bg-red-100 border-red-400 text-red-700<#elseif message.type = 'success'>bg-green-100 border-green-400 text-green-700</#if>" role="alert">
                    <strong class="font-bold">${msg(message.type)}!</strong>
                    <span class="block sm:inline">${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>

            <#nested "content">
        </div>
    </div>


    <!-- Footer -->
    <div class="mt-4 mb-0 xl:mb-4 mx-0 xl:mx-4 p-4 md:p-5 flex flex-col bg-gray-300">
        <div class="mb-3 text-base md:text-2xl font-bold">
            &copy; ${.now?string('yyyy')} NOI Techpark
        </div>
        <div class="flex flex-col sm:flex-row leading-relaxed text-xs md:text-base">
            <div class="mr-5">
                NOI SPA<br />
                Techpark Südtirol / Alto Adige<br />
                <a href="mailto:info@davinci.bz.it" class="hover:underline">info@opendatahub.bz.it</a>
            </div>
            <div class="mt-3 sm:mt-0">
                A.-Volta-Straße 13/A - 39100 Bozen/South Tyrol - Italy<br />
                P.IVA 02595720216<br />
                <a href="https://noi.bz.it" class="hover:underline">noi.bz.it</a>
            </div>
        </div>
        <div class="mt-3 text-xs md:text-lg font-bold">
            Developed by
            <a href="https://aboutbits.it" class="hover:underline">About Bits</a>
        </div>
    </div>

</body>
</html>
</#macro>
