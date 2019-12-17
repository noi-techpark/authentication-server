<#import "template.ftl" as layout>
<@layout.mainLayout active='account' bodyClass='user'; section>

    <div class="row">
        <h2 class="text-2xl">${msg("editAccountHtmlTitle")}</h2>
        <div class="my-3">
            <span class="text-red-700"><span class="font-bold">*</span> ${msg("requiredFields")}</span>
        </div>
    </div>

    <form action="${url.accountUrl}" method="post" class="max-w-3xl">

        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

        <#if !realm.registrationEmailAsUsername>
            <div class="md:flex md:items-center mb-2">
                <div class="md:w-1/4">
                    <label for="username" class="block text-gray-500 font-bold mb-1 md:mb-0 pr-4 ${messagesPerField.printIfExists('username','text-red-700')}">
                        ${msg("username")}<span class="required">*</span>
                    </label>
                </div>
                <div class="md:w-3/4">
                    <input type="text" class="appearance-none w-full py-2 px-2 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="username" name="username" <#if !realm.editUsernameAllowed>disabled="disabled"</#if> value="${(account.username!'')}">
                </div>
            </div>
        </#if>

        <div class="md:flex md:items-center mb-2">
            <div class="md:w-1/4">
                <label for="email" class="block text-gray-500 font-bold mb-1 md:mb-0 pr-4 ${messagesPerField.printIfExists('email','text-red-700')}">
                    ${msg("email")}<span class="required">*</span>
                </label>
            </div>
            <div class="md:w-3/4">
                <input type="text" class="appearance-none border-2 border-black w-full py-2 px-2 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="email" name="email" autofocus value="${(account.email!'')}">
            </div>
        </div>

        <div class="md:flex md:items-center mb-2">
            <div class="md:w-1/4">
                <label for="firstName" class="block text-gray-500 font-bold mb-1 md:mb-0 pr-4 ${messagesPerField.printIfExists('firstName','text-red-700')}">
                    ${msg("firstName")}<span class="required">*</span>
                </label>
            </div>
            <div class="md:w-3/4">
                <input type="text" class="appearance-none border-2 border-black w-full py-2 px-2 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="firstName" name="firstName" autofocus value="${(account.firstName!'')}">
            </div>
        </div>

        <div class="md:flex md:items-center mb-2">
            <div class="md:w-1/4">
                <label for="lastName" class="block text-gray-500 font-bold mb-1 md:mb-0 pr-4 ${messagesPerField.printIfExists('lastName','text-red-700')}">
                    ${msg("lastName")}<span class="required">*</span>
                </label>
            </div>
            <div class="md:w-3/4">
                <input type="text" class="appearance-none border-2 border-black w-full py-2 px-2 text-gray-700 leading-tight focus:outline-none focus:bg-white focus:border-purple-500" id="lastName" name="lastName" autofocus value="${(account.lastName!'')}">
            </div>
        </div>

        <div class="form-group">
            <div id="kc-form-buttons" class="mt-4 flex flex-col md:flex-row">
                <#if url.referrerURI??><a class="underline" href="${url.referrerURI}">${kcSanitize(msg("backToApplication")?no_esc)}</a></#if>
                <button type="submit" class="btn btn-black mb-2 md:mb-0 md:mr-2" name="submitAction" value="Save">${msg("doSave")}</button>
                <button type="submit" class="btn btn-black" name="submitAction" value="Cancel">${msg("doCancel")}</button>
            </div>
        </div>
    </form>

</@layout.mainLayout>
