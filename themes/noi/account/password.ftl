<#import "template.ftl" as layout>
<@layout.mainLayout active='password' bodyClass='password'; section>

    <div>
        <h2 class="text-2xl">${msg("changePasswordHtmlTitle")}</h2>
        <div class="my-3">
            <span class="text-red-700"><span class="font-bold">*</span> ${msg("allFieldsRequired")}</span>
        </div>
    </div>

    <form action="${url.passwordUrl}" class="form-horizontal" method="post" class="max-w-3xl">
        <input type="text" id="username" name="username" value="${(account.username!'')}" autocomplete="username" readonly="readonly" style="display:none;">

        <#if password.passwordSet>
            <div class="md:flex md:items-center mb-2">
                <div class="md:w-1/4">
                    <label for="password" class="inline-form-label">${msg("password")}</label>
                </div>

                <div class="md:w-3/4">
                    <input type="password" class="inline-form-input" id="password" name="password" autofocus autocomplete="current-password">
                </div>
            </div>
        </#if>

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

        <div class="md:flex md:items-center mb-2">
            <div class="md:w-1/4">
                <label for="password-new" class="inline-form-label">${msg("passwordNew")}</label>
            </div>

            <div class="md:w-3/4">
                <input type="password" class="inline-form-input" id="password-new" name="password-new" autocomplete="new-password">
            </div>
        </div>

        <div class="md:flex md:items-center mb-2">
            <div class="md:w-1/4">
                <label for="password-confirm" class="inline-form-label" class="two-lines">${msg("passwordConfirm")}</label>
            </div>

            <div class="md:w-3/4">
                <input type="password" class="inline-form-input" id="password-confirm" name="password-confirm" autocomplete="new-password">
            </div>
        </div>

        <div class="form-group">
            <div id="kc-form-buttons" class="mt-4 flex flex-col md:flex-row">
                <button type="submit" class="btn btn-black" name="submitAction" value="Save">${msg("doSave")}</button>
            </div>
        </div>
    </form>

</@layout.mainLayout>
