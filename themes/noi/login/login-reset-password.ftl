<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <h1 class="text-2xl pb-4">${msg("emailForgotTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            
            <div class="flex flex-col">
                <label for="username" class="font-bold text-primary-500"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <#if auth?has_content && auth.showUsername()>
                    <input type="text" id="username" name="username" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autofocus value="${auth.attemptedUsername}"/>
                <#else>
                    <input type="text" id="username" name="username" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autofocus/>
                </#if>
            </div>

            <div class="mt-3">
                <div id="kc-form-options" class="mt-2 underline">
                    <a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                </div>

                <div id="kc-form-buttons" class="mt-5">
                    <input class="btn btn-black" type="submit" value="${msg("doSubmit")}"/>
                </div>
            </div>
        </form>
    <#elseif section = "info" >
        ${msg("emailInstruction")}
    </#if>
</@layout.registrationLayout>
