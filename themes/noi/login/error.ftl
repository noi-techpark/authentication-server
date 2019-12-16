<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${msg("errorTitle")}
    <#elseif section = "form">
        <div id="kc-error-message">
            <p class="instruction">${message.summary?no_esc}</p>
            <#if client?? && client.baseUrl?has_content>
                <a id="backToApplication" href="${client.baseUrl}" class="underline">${kcSanitize(msg("backToApplication"))?no_esc}</a>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
