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
            <ol class="mt-3">
                <li>
                    <div class="inline-block bg-black py-2 px-3 text-white text-xl font-bold">1</div>
                    <div class="mt-4"><p class="text-lg">${msg("totpStep1")}</p></div>

                    <ul class="mt-3">
                        <#list totp.policy.supportedApplications as app>
                            <li class="lg:mr-3 my-1 lg:my-0 inline-block min-w-sm py-2 px-4 bg-black text-white text-center">${app}</li>
                        </#list>
                    </ul>
                </li>

                <#if mode?? && mode = "manual">
                    <li class="mt-5 mb-1">
                        <div class="inline-block bg-black py-2 px-3 text-white text-xl font-bold">2</div>
                        <div class="mt-4"><p class="text-lg">${msg("totpManualStep2")}</p></div>
                        <div id="kc-totp-secret-key" class="my-3 inline-block border-2 border-black p-2">${totp.totpSecretEncoded}</div>
                        <p><a href="${totp.qrUrl}" id="mode-barcode" class="font-bold hover:underline">${msg("totpScanBarcode")}</a></p>
                    </li>
                    <li class="mt-3 mb-1">
                        <div class="mt-4"><p class="text-lg">${msg("totpManualStep3")}</p></div>
                        <ul class="mt-1">
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
                    <li class="mt-5 mb-1">
                        <div class="inline-block bg-black py-2 px-3 text-white text-xl font-bold">2</div>
                    
                        <div class="mt-4"><p class="text-lg">${msg("totpStep2")}</p></div>
                        <p><img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"></p>
                        <p><a href="${totp.manualUrl}" id="mode-manual" class="font-bold hover:underline">${msg("totpUnableToScan")}</a></p>
                    </li>
                </#if>
                <li class="mt-5 mb-1">
                    <div class="inline-block bg-black py-2 px-3 text-white text-xl font-bold">3</div>
                    <div class="mt-4"><p class="text-lg">${msg("totpStep3")}</p></div>
                </li>
            </ol>

            <form action="${url.totpUrl}" class="mt-3 max-w-xl" method="post">
                <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                <div class="mb-2 lg:max-w-xs">
                    <label for="totp" class="inline-form-label">${msg("authenticatorCode")}</label>
                    <input type="text" class="inline-form-input" id="totp" name="totp" autocomplete="off" autofocus>
                    <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}"/>
                </div>

                <div class="mb-2">
                    <label for="userLabel" class="inline-form-label">Device Name</label>
                    <input type="text" class="inline-form-input" id="userLabel" name="userLabel" autocomplete="off">                    
                </div>

                <div class="form-group">
                    <div id="kc-form-buttons" class="mt-4 flex flex-col lg:flex-row">
                        <button type="submit" class="btn btn-black-filled mb-2 lg:mb-0 lg:mr-2" name="submitAction" value="Save">${msg("doSave")}</button>
                        <button type="submit" class="btn btn-black" name="submitAction" value="Cancel">${msg("doCancel")}</button>
                    </div>
                </div>
            </form>
        </#if>
    </#if>
</@layout.mainLayout>
