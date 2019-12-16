<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>
    <#if section = "form">
    <div id="kc-form" class="px-0 xl:px-4">
      <div id="kc-form-wrapper" class="p-5 flex justify-center bg-gray-300">
        <#if realm.password>
            <form id="kc-form-login" class="mx-2 my-4 xl:mx-0 w-full max-w-2xl p-5 border-3 border-black bg-white" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">

                <div class="mb-5">
                    <img src="${url.resourcesPath}/img/login.png" alt="Login" class="h-5" />
                </div>

                <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                <#-- during login.                                                                               -->
                <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                    <div class="mb-4 border-2 px-4 py-3 <#if message.type = 'error'>bg-red-100 border-red-400 text-red-700<#elseif message.type = 'warning'>bg-yellow-100 border-yellow-400 text-yellow-700<#elseif message.type = 'info'>bg-blue-100 border-blue-400 text-blue-700<#elseif message.type = 'success'>bg-green-100 border-green-400 text-green-700</#if>" role="alert">
                        <strong class="font-bold">${msg(message.type)}!</strong>
                        <span class="block sm:inline">${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <div class="flex flex-col">
                    <label for="username" class="font-bold text-primary-500""><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" />
                    </#if>
                </div>

                <div class="mt-4 flex flex-col">
                    <label for="password" class="font-bold text-primary-500">${msg("password")}</label>
                    <input tabindex="2" id="password" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" name="password" type="password" autocomplete="off" />
                </div>

                <div class="mt-3 flex flex-col md:flex-row md:justify-between">
                    <div id="kc-form-options" class="mt-2 flex">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                    </div>
                    <div class="mt-2 flex">
                        <#if realm.resetPasswordAllowed>
                            <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                        </#if>
                    </div>
                  </div>

                  <div id="kc-form-buttons" class="mt-5 flex justify-between">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="px-4 py-2 border-3 border-black hover:bg-black hover:text-white uppercase" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>
            </form>
        </#if>
        </div>
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}">
                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 4>${properties.kcFormSocialAccountDoubleListClass!}</#if>">
                    <#list social.providers as p>
                        <li class="${properties.kcFormSocialAccountListLinkClass!}"><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span>${p.displayName}</span></a></li>
                    </#list>
                </ul>
            </div>
        </#if>
      </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
