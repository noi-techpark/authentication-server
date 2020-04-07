<#import "template.ftl" as layout>
<@layout.mainLayout active='sessions' bodyClass='sessions'; section>

    <#if section = "header">
        <h2 class="text-2xl underline">${msg("sessionsHtmlTitle")}</h2>
    <#elseif section = "content">
        <div class="mt-2">
            <table class="table-auto border-2 border-black">
                <thead>
                <tr class="bg-gray-300">
                    <th class="border-r border-black px-4 py-2">${msg("ip")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("started")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("lastAccess")}</th>
                    <th class="border-r border-black px-4 py-2">${msg("expires")}</th>
                    <th class="px-4 py-2">${msg("clients")}</th>
                </tr>
                </thead>

                <tbody>
                <#list sessions.sessions as session>
                    <tr class="<#if session?index % 2 == 1>bg-gray-100</#if> border-t border-black">
                        <td class="border-r border-black px-4 py-2">${session.ipAddress}</td>
                        <td class="border-r border-black px-4 py-2">${session.started?string["dd.MM.yyyy, HH:mm"]}</td>
                        <td class="border-r border-black px-4 py-2">${session.lastAccess?string["dd.MM.yyyy, HH:mm"]}</td>
                        <td class="border-r border-black px-4 py-2">${session.expires?string["dd.MM.yyyy, HH:mm"]}</td>
                        <td class="px-4 py-2">
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
                <button id="logout-all-sessions" class="btn btn-black-filled">${msg("doLogOutAllSessions")}</button>
            </form>
        </div>
    </#if>

</@layout.mainLayout>
