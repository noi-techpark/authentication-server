<#import "template.ftl" as layout>
<@layout.mainLayout active='applications' bodyClass='applications'; section>

    <#if section = "header">
        <h2 class="text-2xl underline">${msg("applicationsHtmlTitle")}</h2>
    <#elseif section = "content">
        <div class="mt-2">
        <form action="${url.applicationsUrl}" method="post">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
            <input type="hidden" id="referrer" name="referrer" value="${stateChecker}">

            <table class="table-auto border-2 border-black">
                <thead>
                <tr class="bg-gray-300">
                    <th class="border-r border-black px-4 py-2">${msg("application")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("availableRoles")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("grantedPermissions")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("additionalGrants")}</th>
                    <th class="px-4 py-2">${msg("action")}</th>
                </tr>
                </thead>

                <tbody>
                <#list applications.applications as application>
                    <tr class="<#if application?index % 2 == 1>bg-gray-100</#if> border-t border-black">
                        <td class="border-r border-black px-4 py-2">
                            <#if application.effectiveUrl?has_content><a href="${application.effectiveUrl}"></#if>
                                <#if application.client.name?has_content>${advancedMsg(application.client.name)}<#else>${application.client.clientId}</#if>
                            <#if application.effectiveUrl?has_content></a></#if>
                        </td>

                        <td class="min-w-md border-r border-black px-4 py-2">
                            <#list application.realmRolesAvailable as role>
                                <#if role.description??>- ${advancedMsg(role.description)}<#else>- ${advancedMsg(role.name)}</#if></br>
                            </#list>
                            <#list application.resourceRolesAvailable?keys as resource>
                                <#list application.resourceRolesAvailable[resource] as clientRole>
                                    <#if clientRole.roleDescription??>- ${advancedMsg(clientRole.roleDescription)}<#else>- ${advancedMsg(clientRole.roleName)}</#if>
                                    ${msg("inResource")} <strong><#if clientRole.clientName??>${advancedMsg(clientRole.clientName)}<#else>${clientRole.clientId}</#if></strong></br>
                                </#list>
                            </#list>
                        </td>

                        <td class="border-r border-black px-4 py-2">
                            <#if application.client.consentRequired>
                                <#list application.clientScopesGranted as claim>
                                    - ${advancedMsg(claim)}
                                </#list>
                            <#else>
                                <strong>${msg("fullAccess")}</strong>
                            </#if>
                        </td>

                        <td class="border-r border-black px-4 py-2">
                        <#list application.additionalGrants as grant>
                                ${advancedMsg(grant)}<#if grant_has_next>, </#if>
                            </#list>
                        </td>

                        <td class="px-4 py-2">
                            <#if (application.client.consentRequired && application.clientScopesGranted?has_content) || application.additionalGrants?has_content>
                                <button type='submit' class='${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}' id='revoke-${application.client.clientId}' name='clientId' value="${application.client.id}">${msg("revoke")}</button>
                            </#if>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </form>
        </div>
    </#if>

</@layout.mainLayout>
