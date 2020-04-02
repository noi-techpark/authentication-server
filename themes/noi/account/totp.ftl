<#import "template.ftl" as layout>
<@layout.mainLayout active='totp' bodyClass='totp'; section>

    <#if section = "header">
        <h2 class="text-2xl underline">${msg("authenticatorTitle")}</h2>
    <#elseif section = "content">
        <#if totp.enabled>
            <table class="table-auto">
                <thead>
                <#if totp.otpCredentials?size gt 1>
                    <tr>
                        <th class="px-4 py-2" colspan="4">${msg("configureAuthenticators")}</th>
                    </tr>
                <#else>
                    <tr>
                        <th class="px-4 py-2" colspan="3">${msg("configureAuthenticators")}</th>
                    </tr>
                </#if>
                </thead>
                <tbody>
                <#list totp.otpCredentials as credential>
                    <tr class="<#if credential?index % 2 == 1>bg-gray-100</#if>">
                        <td class="border px-4 py-2">${msg("mobile")}</td>
                        <#if totp.otpCredentials?size gt 1>
                            <td class="border px-4 py-2">${credential.id}</td>
                        </#if>
                        <td class="border px-4 py-2">${credential.userLabel!}</td>
                        <td class="border px-4 py-2">
                            <form action="${url.totpUrl}" method="post" class="form-inline">
                                <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                                <input type="hidden" id="submitAction" name="submitAction" value="Delete">
                                <input type="hidden" id="credentialId" name="credentialId" value="${credential.id}">
                                <button id="remove-mobile" class="btn btn-black">
                                    ${msg('doRemove')}
                                </button>
                            </form>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        <#else>
            <ol>
                <li>
                    <p>${msg("totpStep1")}</p>

                    <ul>
                        <#list totp.policy.supportedApplications as app>
                            <li class="ml-4 list-disc">${app}</li>
                        </#list>
                    </ul>
                </li>

                <#if mode?? && mode = "manual">
                    <li class="mt-3 mb-1">
                        <p>${msg("totpManualStep2")}</p>
                        <div id="kc-totp-secret-key" class="my-2 inline-block border-2 border-black p-2">${totp.totpSecretEncoded}</div>
                        <p><a href="${totp.qrUrl}" id="mode-barcode" class="underline">${msg("totpScanBarcode")}</a></p>
                    </li>
                    <li class="mt-3 mb-1">
                        <p>${msg("totpManualStep3")}</p>
                        <ul>
                            <li id="kc-totp-type" class="ml-4 list-disc">${msg("totpType")}: ${msg("totp." + totp.policy.type)}</li>
                            <li id="kc-totp-algorithm" class="ml-4 list-disc">${msg("totpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                            <li id="kc-totp-digits" class="ml-4 list-disc">${msg("totpDigits")}: ${totp.policy.digits}</li>
                            <#if totp.policy.type = "totp">
                                <li id="kc-totp-period" class="ml-4 list-disc">${msg("totpInterval")}: ${totp.policy.period}</li>
                            <#elseif totp.policy.type = "hotp">
                                <li id="kc-totp-counter" class="ml-4 list-disc">${msg("totpCounter")}: ${totp.policy.initialCounter}</li>
                            </#if>
                        </ul>
                    </li>
                <#else>
                    <li class="mt-3 mb-1">
                        <p>${msg("totpStep2")}</p>
                        <p><img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"></p>
                        <p><a href="${totp.manualUrl}" id="mode-manual">${msg("totpUnableToScan")}</a></p>
                    </li>
                </#if>
                <li class="mt-3 mb-1">
                    <p>${msg("totpStep3")}</p>
                </li>
            </ol>

            <form action="${url.totpUrl}" class="max-w-3xl" method="post">
                <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                <div class="md:flex md:items-center mb-2">
                    <div class="md:w-1/4">
                        <label for="totp" class="inline-form-label">${msg("authenticatorCode")}</label>
                    </div>

                    <div class="md:w-3/4">
                        <input type="text" class="inline-form-input" id="totp" name="totp" autocomplete="off" autofocus>
                        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
                    </div>
                </div>

                <div class="md:flex md:items-center mb-2">
                    <div class="md:w-1/4">
                        <label for="userLabel" class="inline-form-label">Device Name</label>
                    </div>

                    <div class="md:w-3/4">
                        <input type="text" class="inline-form-input" id="userLabel" name="userLabel" autocomplete="off">
                    </div>
                </div>

                <div class="form-group">
                    <div id="kc-form-buttons" class="mt-4 flex flex-col md:flex-row">
                        <button type="submit" class="btn btn-black mb-2 md:mb-0 md:mr-2" name="submitAction" value="Save">${msg("doSave")}</button>
                        <button type="submit" class="btn btn-black" name="submitAction" value="Cancel">${msg("doCancel")}</button>
                    </div>
                </div>
            </form>
        </#if>
    </#if>
</@layout.mainLayout>
