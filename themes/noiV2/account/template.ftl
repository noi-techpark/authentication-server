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
        
    <header>
        <div class="flex content-end items-stretch border-b border-gray-500">
            <div class="border-r border-gray-500 lg:min-w-md flex flex-col justify-center items-center p-3 lg:p-4">
                <a href="/"><img src="${url.resourcesPath}/img/noi.svg" alt="NOI" class="image-noi" /></a>
            </div>
            <div class="flex-1 flex flex-col justify-center px-3 lg:pl-5 lg:pr-4 leading-tight font-light text-3xl lg:text-4xl">
                <a href="" class="block">${kcSanitize(msg(realm.displayNameHtml!''))?no_esc}</a>
            </div>
            <div class="flex items-center justify-end mr-3">
                <!-- Desktop Navigation -->
                <nav role="navigation" class="hidden lg:flex items-center space-x-2">
                    <div class="flex items-center"><#if referrer?has_content && referrer.url?has_content><a href="${referrer.url}" id="referrer" class="btn btn-black">${msg("backTo",referrer.name)}</a></#if></div>
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <div class="group relative block">
                            <button class="btn btn-black">
                                <div class="block pr-8">
                                ${locale.current}
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                                    <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                                </svg>
                            </button>
                            <ul class="z-10 shadow hidden absolute right-0 left-0 group-hover:block bg-white">
                                <#list locale.supported as l>
                                    <li class="list-none"><a href="${l.url}" class="block px-4 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                                </#list>
                            </ul>
                        </div>
                    </#if>
                    <div class="flex items-center"><a href="${url.logoutUrl}" class="flex btn btn-black">${msg("doSignOut")}</a></div>
                </nav>
                <!-- Mobile Navigation - Burger Icon -->
                <button class="lg:hidden" onclick="toggleNav()">
                    <img src="${url.resourcesPath}/img/menu.svg" alt="MENU" width="24" />
                </button>
            </div>
        </div>

        <!-- Mobile Navigation -->
        <nav id="mobile-nav" role="navigation" class="mobile-nav">
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="group relative block mb-2">
                    <button class="btn btn-black w-full text-left" onclick="toggleLanguage()">
                        <div class="block pr-2">
                        ${locale.current}
                        </div>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                            <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                        </svg>
                    </button>
                    <ul id="mobile-languages" class="mobile-languages">
                        <#list locale.supported as l>
                            <li class="list-none"><a href="${l.url}" class="block px-4 py-2">${l.label}</a></li>
                        </#list>
                    </ul>
                </div>
            </#if>
            <#if referrer?has_content && referrer.url?has_content><a href="${referrer.url}" id="referrer" class="btn btn-black mb-2">${msg("backTo",referrer.name)}</a></#if>
            <a href="${url.logoutUrl}" class="block btn btn-black mb-2">${msg("doSignOut")}</a>
            <ul class="px-2">
                <li class="side-menu-item <#if active=='account'>side-menu-item-active</#if>"><a href="${url.accountUrl}">${msg("account")}</a></li>
                <#if features.passwordUpdateSupported><li class="side-menu-item <#if active=='password'>side-menu-item-active</#if>"><a href="${url.passwordUrl}">${msg("password")}</a></li></#if>
                <li class="side-menu-item <#if active=='totp'>side-menu-item-active</#if>"><a href="${url.totpUrl}">${msg("authenticator")}</a></li>
                <#--  <#if features.identityFederation><li class="side-menu-item <#if active=='social'>side-menu-item-active</#if>"><a href="${url.socialUrl}">${msg("federatedIdentity")}</a></li></#if>  -->
                <li class="side-menu-item <#if active=='sessions'>side-menu-item-active</#if>"><a href="${url.sessionsUrl}">${msg("sessions")}</a></li>
                <#--  <li class="side-menu-item <#if active=='applications'>side-menu-item-active</#if>"><a href="${url.applicationsUrl}">${msg("applications")}</a></li>  -->
                <#--  <#if features.log><li class="<#if active=='log'>active</#if>"><a href="${url.logUrl}">${msg("log")}</a></li></#if>  -->
                <#if realm.userManagedAccessAllowed && features.authorization><li class="<#if active=='authorization'>active</#if>"><a href="${url.resourceUrl}">${msg("myResources")}</a></li></#if>
            </ul>
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

    <!-- Footer -->
    <footer class="mt-8 mb-0 xl:mb-8 mx-0 xl:mx-8 p-8 lg:p-10 flex flex-col bg-gray-300">
        <div class="mb-4 text-base lg:text-2xl font-bold">
            &copy; ${.now?string('yyyy')} NOI Techpark
        </div>
        <div class="flex flex-col lg:flex-row leading-relaxed text-xs lg:text-base">
            <div class="mr-10">
                NOI SPA<br />
                Techpark Südtirol / Alto Adige<br />
                <a href="mailto:info@davinci.bz.it" class="hover:underline">info@opendatahub.bz.it</a>
            </div>
            <div class="mt-4 lg:mt-0">
                A.-Volta-Straße 13/A - 39100 Bozen/South Tyrol - Italy<br />
                P.IVA 02595720216<br />
                <a href="https://noi.bz.it" class="hover:underline">noi.bz.it</a>
            </div>
        </div>
        <div class="mt-4 text-xs lg:text-lg font-bold">
            Developed by
            <a href="https://aboutbits.it" class="hover:underline">About Bits</a>
        </div>
    </footer>
</body>
<script>
    function toggleNav() {
        var x = document.getElementById("mobile-nav");
        if (x.className === "mobile-nav") {
            x.className += " mobile-nav-open";
        } else {
            x.className = "mobile-nav";
        }
    }

    function toggleLanguage() {
        var x = document.getElementById("mobile-languages");
        if (x.className === "mobile-languages") {
            x.className += " mobile-languages-open";
        } else {
            x.className = "mobile-languages";
        }
    }
</script>
</html>
</#macro>
