<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <h1 class="text-2xl pb-4">${msg("doLogIn")}</h1>
    <#elseif section = "form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <div class="${properties.kcSelectOTPListClass!}">
                            <input type="hidden" value="${otpCredential.id}">
                                <div class="${properties.kcSelectOTPListItemClass!}">
                                    <span class="${properties.kcAuthenticatorOtpCircleClass!}"></span>
                                    <h2 class="text-2xl underline">
                                        ${otpCredential.userLabel}
                                    </h2>
                                </div>
                            </div>
                        </#list>
                    </div>
                </div>
            </#if>

            <div class="flex flex-col">
                <label for="otp" class="font-bold text-primary-500">${msg("loginOtpOneTime")}</label>
                <input autofocus type="text" id="otp" name="otp" class="py-1 border-b border-black text-2xl placeholder-gray-500 focus:border-primary-500" autocomplete="off"/>
            </div>

            <div id="kc-form-buttons" class="mt-5">
                <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                <input class="btn btn-black" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
            </div>
        </form>
        <script type="text/javascript" src="${url.resourcesCommonPath}/node_modules/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript">
        $(document).ready(function() {
            // Card Single Select
            $('.card-pf-view-single-select').click(function() {
                if ($(this).hasClass('active'))
                { $(this).removeClass('active'); $(this).children().removeAttr('name'); }
                else
                { $('.card-pf-view-single-select').removeClass('active');
                $('.card-pf-view-single-select').children().removeAttr('name');
                $(this).addClass('active'); $(this).children().attr('name', 'selectedCredentialId'); }
            });

            var defaultCred = $('.card-pf-view-single-select')[0];
            if (defaultCred) {
                defaultCred.click();
            }
            });
        </script>
    </#if>
</@layout.registrationLayout>
