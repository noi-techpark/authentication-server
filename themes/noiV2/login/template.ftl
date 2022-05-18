<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700;1,900&amp;display=swap" rel="stylesheet">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
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
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
    <div class="${properties.kcLoginClass!}">
        <!-- Navigation Bar -->
        <div>
            <div class="${properties.kcHeaderContainerClass!}">
                <div class="py-2 md:py-4 pr-4 flex flex-col justify-center">
                    <a href="https://noi.bz.it"><img src="${url.resourcesPath}/img/noi.svg" alt="NOI Techpark" class="image-noi" /></a>
                </div>
                <div class="${properties.kcHeaderTitleContainerClass!}">
                    <#if client?? && client.name?has_content>
                            <a class="no-underline hover:underline" href="${client.baseUrl}">${kcSanitize(msg("loginTitleHtml",((client.name?has_content)?string(client.name, realm.displayNameHtml))))?no_esc}</a>
                    <#else>
                        <h2>Login</h2>
                    </#if>
                </div>
                <!-- Desktop Navigation -->
                <nav role="navigation" class="hidden lg:flex items-center">
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <div class="group relative block">
                            <button class="relative border border-black pl-4 pr-4 py-2 text-left group-hover:bg-black group-hover:text-white uppercase cursor-pointer">
                                <div class="block pr-8">
                                ${locale.current}
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                                    <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                                </svg>
                            </button>
                            <ul class="z-10 shadow hidden absolute right-0 left-0 group-hover:block bg-white list-none">
                                <#list locale.supported as l>
                                    <li><a href="${l.url}" class="block px-4 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                                </#list>
                            </ul>
                        </div>
                    </#if>
                </nav>
            </div>
        </div>

        <div id="kc-content">
            <div id="kc-content-wrapper">
                <div class="${properties.kcFormCardClass!}">
                    <header class="${properties.kcFormHeaderClass!}">
                        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                            <#if displayRequiredFields>
                                <div class="${properties.kcContentWrapperClass!}">
                                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                                    </div>
                                    <div class="col-md-10">
                                        <h1 id="kc-page-title"><#nested "header"></h1>
                                    </div>
                                </div>
                            <#else>
                                <h1 id="kc-page-title"><#nested "header"></h1>
                            </#if>
                        <#else>
                            <#if displayRequiredFields>
                                <div class="${properties.kcContentWrapperClass!}">
                                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                                    </div>
                                    <div class="col-md-10">
                                        <#nested "show-username">
                                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                            <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                                <div class="kc-login-tooltip">
                                                    <i class="${properties.kcResetFlowIcon!}"></i>
                                                    <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            <#else>
                                <#nested "show-username">
                                <div id="kc-username">
                                    <a id="reset-login" href="${url.loginRestartFlowUrl}" class="text-base self-end">
                                        <div class="kc-login-tooltip">
                                            <i class="${properties.kcResetFlowIcon!}"></i>
                                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                        </div>
                                    </a>
                                </div>
                            </#if>
                        </#if>
                    </header>


                    <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                    <#-- during login.                                                                               -->
                    <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                        <div class="alert-${message.type} ${properties.kcAlertClass!}">
                            <div class="mr-4 self-center">
                                <#if message.type = 'success'><svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg></#if>
                                <#if message.type = 'warning'><svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/></svg></#if>
                                <#if message.type = 'error'><svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg></#if>
                                <#if message.type = 'info'><svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24" fill="currentColor"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/></svg></#if>
                            </div>
                            <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <#nested "form">

                    <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                        <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                            <div class="${properties.kcFormGroupClass!}">
                                <input type="hidden" name="tryAnotherWay" value="on"/>
                                <a href="#" id="try-another-way"
                                onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                            </div>
                        </form>
                    </#if>

                    <#if displayInfo>
                        <div id="kc-info" class="${properties.kcSignUpClass!}">
                            <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                <#nested "info">
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <footer class="${properties.kcFooterClass!}">
        <div class="flex items-center justify-between">
            <div class="mb-4 text-base lg:text-2xl font-bold">
                &copy; ${.now?string('yyyy')} NOI Techpark
            </div>
            <!-- Mobile Navigation -->
            <nav role="navigation" class="mb-2 mx-2 xs:mx-4 flex lg:hidden flex-col items-stretch">
                <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                    <div class="group relative block">
                        <button class="relative w-full pl-4 pr-4 py-2 text-left uppercase mobile-language-select-button" onclick="toggleLanguage()">
                            <div class="block pr-6">
                            ${locale.current}
                            </div>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" width="18" class="absolute vertical-center fill-current" style="right: 1rem">
                                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                            </svg>
                        </button>
                        <ul id="mobile-languages" class="mobile-languages">
                            <#list locale.supported as l>
                                <li><a href="${l.url}" class="block px-4 py-2 hover:bg-black hover:text-white">${l.label}</a></li>
                            </#list>
                        </ul>
                    </div>
                </#if>
            </nav>
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
    <script>
        function toggleLanguage() {
            var x = document.getElementById("mobile-languages");
            if (x.className === "mobile-languages") {
                x.className += " mobile-languages-open";
            } else {
                x.className = "mobile-languages";
            }
        }
    </script>
</body>
</html>
</#macro>
