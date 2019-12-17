<#import "template.ftl" as layout>
<@layout.mainLayout active='sessions' bodyClass='sessions'; section>

    <#if section = "header">
        <h2 class="text-2xl">${msg("sessionsHtmlTitle")}</h2>
    <#elseif section = "content">
        <table class="table-auto">
            <thead>
            <tr>
                <th class="px-4 py-2">${msg("ip")}</th>
                <th class="px-4 py-2">${msg("started")}</th>
                <th class="px-4 py-2">${msg("lastAccess")}</th>
                <th class="px-4 py-2">${msg("expires")}</th>
                <th class="px-4 py-2">${msg("clients")}</th>
            </tr>
            </thead>

            <tbody>
            <#list sessions.sessions as session>
                <tr class="<#if session?index % 2 == 1>bg-gray-100</#if>">
                    <td class="border px-4 py-2">${session.ipAddress}</td>
                    <td class="border px-4 py-2">${session.started?datetime}</td>
                    <td class="border px-4 py-2">${session.lastAccess?datetime}</td>
                    <td class="border px-4 py-2">${session.expires?datetime}</td>
                    <td class="border px-4 py-2">
                        <#list session.clients as client>
                            ${client}<br/>
                        </#list>
                    </td>
                </tr>
            </#list>
            </tbody>

        </table>

        <form action="${url.sessionsUrl}" method="post" class="mt-4">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
            <button id="logout-all-sessions" class="btn btn-black">${msg("doLogOutAllSessions")}</button>
        </form>
    </#if>

</@layout.mainLayout>
