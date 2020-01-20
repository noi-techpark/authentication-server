<#import "select.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <h1 class="text-2xl pb-4">${msg("doLogIn")}</h1>
    <#elseif section = "form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="flex flex-col">
                <label for="otp" class="font-bold text-primary-500">${msg("loginOtpOneTime")}</label>
                <input autofocus type="text" id="otp" name="otp" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autocomplete="off"/>
            </div>

            <div id="kc-form-buttons" class="mt-5">
                <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                <input class="btn btn-black" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                <input class="btn btn-black" name="cancel" id="kc-cancel" type="submit" value="${msg("doCancel")}"/>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
