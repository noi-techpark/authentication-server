<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <h1 class="text-2xl pb-4">${msg("registerTitle")}</h1>
    <#elseif section = "form">
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
            <div class="space-y-4">
                <div class="form-input-group ${messagesPerField.printIfExists('firstName','form-input-group-error')}">
                    <label for="firstName" class="form-label">${msg("firstName")}</label>
                    <input type="text" id="firstName" name="firstName" class="form-input" value="${(register.formData.firstName!'')}" autofocus/>
                </div>

                <div class="form-input-group ${messagesPerField.printIfExists('lastName','form-input-group-error')}">
                    <label for="lastName" class="form-label">${msg("lastName")}</label>
                    <input type="text" id="lastName" name="lastName" class="form-input" value="${(register.formData.lastName!'')}"/>
                </div>

                <div class="form-input-group ${messagesPerField.printIfExists('email','form-input-group-error')}">
                    <label for="email" class="form-label">${msg("email")}</label>
                    <input type="text" id="email" name="email" class="form-input" value="${(register.formData.email!'')}" autocomplete="email"/>
                </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="form-input-group ${messagesPerField.printIfExists('username','form-input-group-error')}">
                    <label for="username" class="form-label">${msg("username")}</label>
                    <input type="text" id="username" name="username" class="form-input" value="${(register.formData.username!'')}" autocomplete="username"/>
                </div>
            </#if>

                <#if passwordRequired??>
                <div class="form-input-group ${messagesPerField.printIfExists('password','form-input-group-error')}">
                    <label for="password" class="form-label">${msg("password")}</label>
                    <input type="password" id="password" name="password" class="form-input" autocomplete="new-password"/>
                </div>

                <div class="form-input-group ${messagesPerField.printIfExists('password-confirm','form-input-group-error')}">
                    <label for="password-confirm" class="form-label">${msg("passwordConfirm")}</label>
                    <input type="password" id="password-confirm" name="password-confirm" class="form-input"/>
                </div>
                </#if>

                <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
                </#if>
            </div>

            <div class="mt-5 flex flex-col lg:flex-row-reverse lg:justify-between lg:items-center">
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <input class="btn btn-black" type="submit" value="${msg("doRegister")}"/>
                </div>
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}" class="hover:underline focus:underline">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
