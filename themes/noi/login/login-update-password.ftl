<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header">
        <h1 class="text-2xl pb-4">${msg("updatePasswordTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

            <div class="flex flex-col">
                <label for="password-new" class="font-bold text-primary-500">${msg("passwordNew")}</label>
                <input type="password" id="password-new" name="password-new" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autofocus autocomplete="new-password" />
            </div>

            <div class="mt-4 flex flex-col">
                <label for="password-confirm" class="font-bold text-primary-500">${msg("passwordConfirm")}</label>
                <input type="password" id="password-confirm" name="password-confirm" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autocomplete="new-password" />
            </div>

            <div id="kc-form-buttons" class="mt-5 flex flex-row">
                <#if isAppInitiatedAction??>
                <input class="ml-4 btn btn-black" type="submit" value="${msg("doSubmit")}" />
                <button class="btn btn-black" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                <#else>
                <input class="btn btn-black" type="submit" value="${msg("doSubmit")}" />
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
