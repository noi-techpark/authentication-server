<#import "template.ftl" as layout>
<@layout.mainLayout active='password' bodyClass='password'; section>

    <#if section = "header">
        <h2 class="text-2xl underline">${msg("changePasswordHtmlTitle")}</h2>
    <#elseif section = "content">
        <form action="${url.passwordUrl}" method="post" class="max-w-3xl">
            <input type="text" id="username" name="username" value="${(account.username!'')}" autocomplete="username" readonly="readonly" style="display:none;">

            <#if password.passwordSet>
                <div class="mb-2">
                    <label for="password" class="inline-form-label">${msg("password")}*</label>
                    <input type="password" class="inline-form-input" id="password" name="password" autofocus autocomplete="current-password">
                </div>
            </#if>

            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <div class="mb-2">
                <label for="password-new" class="inline-form-label">${msg("passwordNew")}*</label>
                <input type="password" class="inline-form-input" id="password-new" name="password-new" autocomplete="new-password">
            </div>

            <div class="mb-2">
                <label for="password-confirm" class="inline-form-label" class="two-lines">${msg("passwordConfirm")}*</label>
                <input type="password" class="inline-form-input" id="password-confirm" name="password-confirm" autocomplete="new-password">
            </div>

            <div class="form-group">
                <div id="kc-form-buttons" class="mt-4 flex flex-col md:flex-row">
                    <button type="submit" class="btn btn-black-filled" name="submitAction" value="Save">${msg("doSave")}</button>
                </div>
            </div>
        </form>
    </#if>

</@layout.mainLayout>
