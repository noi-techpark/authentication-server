<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

    <#if section = "header">
        <h2 class="text-2xl underline">${msg("editAccountHtmlTitle")}</h2>
    <#elseif section = "content">
        <form action="${url.accountUrl}" method="post" class="max-w-3xl">

            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <#if !realm.registrationEmailAsUsername>
                <div class="mb-2">
                    <label for="username" class="inline-form-label ${messagesPerField.printIfExists('username','inline-form-label-error')}">
                        ${msg("username")}<span class="required">*</span>
                    </label>
                
                    <input type="text" class="inline-form-input" id="username" name="username" <#if !realm.editUsernameAllowed>disabled="disabled"</#if> value="${(account.username!'')}">
                </div>
            </#if>

            <div class="mb-2">
                <label for="email" class="inline-form-label ${messagesPerField.printIfExists('email','inline-form-label-error')}">
                    ${msg("email")}<span class="required">*</span>
                </label>
                <input type="text" class="inline-form-input" id="email" name="email" autofocus value="${(account.email!'')}">
            </div>

            <div class="mb-2">
                <label for="firstName" class="inline-form-label ${messagesPerField.printIfExists('firstName','inline-form-label-error')}">
                    ${msg("firstName")}<span class="required">*</span>
                </label>
                <input type="text" class="inline-form-input" id="firstName" name="firstName" autofocus value="${(account.firstName!'')}">
            </div>

            <div class="mb-2">
                <label for="lastName" class="inline-form-label ${messagesPerField.printIfExists('lastName','inline-form-label-error')}">
                    ${msg("lastName")}<span class="required">*</span>
                </label>
                <input type="text" class="inline-form-input" id="lastName" name="lastName" autofocus value="${(account.lastName!'')}">
            </div>

            <div class="form-group">
                <div id="kc-form-buttons" class="mt-4 flex flex-col md:flex-row">
                    <#if url.referrerURI??><a class="underline" href="${url.referrerURI}">${kcSanitize(msg("backToApplication")?no_esc)}</a></#if>
                    <button type="submit" class="btn btn-black-filled mb-2 md:mb-0 md:mr-2" name="submitAction" value="Save">${msg("doSave")}</button>
                    <button type="submit" class="btn btn-black" name="submitAction" value="Cancel">${msg("doCancel")}</button>
                </div>
            </div>
        </form>
    </#if>
</@layout.mainLayout>
