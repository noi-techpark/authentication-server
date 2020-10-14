<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && social.providers??); section>
    <#if section = "header">
        <div class="mb-5">
            <img src="${url.resourcesPath}/img/login.png" alt="Login" class="h-5" />
        </div>
    <#elseif section = "form">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="space-y-4">
                    <div class="form-input-group">
                        <label for="username" class="form-label""><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                        <#if usernameEditDisabled??>
                            <input tabindex="1" id="username" class="form-input" name="username" value="${(login.username!'')}" type="text" placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>" disabled />
                        <#else>
                            <input tabindex="1" id="username" class="form-input" name="username" value="${(login.username!'')}"  type="text" placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>" autofocus autocomplete="off" />
                        </#if>
                    </div>

                    <div class="form-input-group">
                        <label for="password" class="form-label">${msg("password")}</label>
                        <input tabindex="2" id="password" class="form-input" name="password" type="password" placeholder="${msg("password")}" autocomplete="off" />
                    </div>

                    <div class="flex flex-col lg:flex-row lg:justify-between">
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

                    <div id="kc-form-buttons" class="mt-1 flex justify-between">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <input tabindex="4" class="btn btn-black" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                    </div>
                </div>
            </form>
            <div id="kc-registration" class="mt-4">
                <span class="text-sm">${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}" class="hover:underline focus:underline">${msg("doRegister")}</a></span>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
