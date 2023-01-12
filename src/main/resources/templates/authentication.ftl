<#-- @ftlvariable name="authFlag" type="ru.project.zaicev.util.AuthenticationFlag" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <style>
        .button {
            cursor: pointer;
            display: inline-block;
            text-align: center;
            white-space: nowrap;
            font-size: 17px;
            line-height: 1.17648;
            font-weight: 400;
            letter-spacing: -.022em;
            font-family: SF Pro Text, SF Pro Icons, Helvetica Neue, Helvetica, Arial, sans-serif;
            min-width: 28px;
            padding: 8px 16px;
            border-radius: 980px;
            background: #0071e3;
            border: 0;
            color: #fff;
            --sk-button-margin-horizontal: 14px;
            --sk-button-margin-vertical: 14px;
        }

        input {
            horiz-align: center;
            border-radius: 100px;
            font-size: 17px;
            line-height: 1.29412;
            font-weight: 400;
            letter-spacing: -.021em;
            font-family: SF Pro Text, SF Pro Icons, Helvetica Neue, Helvetica, Arial, sans-serif;
            display: inline-block;
            box-sizing: border-box;
            width: 100%;
            text-align: left;
            background: #fff;
            background-clip: padding-box;
            border: 1px solid #d6d6d6;
            padding-left: 15px;
            margin: 0;
            box-shadow: none;
            height: 2.6em;
            direction: ltr;
            background-image: none !important;
            writing-mode: horizontal-tb !important;
            text-rendering: auto;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0;
            text-shadow: none;
            -webkit-rtl-ordering: logical;
            cursor: text;
        }

        .text-block {
            font-size: 17px;
            font-weight: 400;
            letter-spacing: -.021em;
            font-family: SF Pro Text, SF Pro Icons, Helvetica Neue, Helvetica, Arial, sans-serif;
            box-shadow: none;
            direction: ltr;
            background-image: none !important;
            writing-mode: horizontal-tb !important;
            text-rendering: auto;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0;
            text-shadow: none;
            -webkit-rtl-ordering: logical;
            cursor: text;
            margin-bottom: 10px;
        }
    </style>

    <#if authFlag??>
        <div class="text-block">${authFlag.reason}</div>
    </#if>

    <#if authFlag??>
        <#if authFlag.code == 1 || authFlag.code == -2>
            <div>
                <form action="/shulte/registration" method="post" id="loginForm">
                    <div>
                        <label for="inputUsernameBox"></label>
                        <input id="inputUsernameBox" type="text" name="username"
                               required="required" autofocus
                               placeholder="username"
                               style="width: 300px">
                    </div>
                    <div>
                        <label for="inputPasswordBox"></label>
                        <input id="inputPasswordBox" type="password" name="password"
                               required="required" autofocus
                               placeholder="password"
                               style="width: 300px">
                    </div>
                    <button id="sign-in" class="button" type="submit" style="margin-top: 10px">
                        <span>авторизоваться</span>
                    </button>
                </form>
            </div>
        <#else>
            <div>
                <form action="/login" method="post" id="loginForm">
                    <div>
                        <label for="inputUsernameBox"></label>
                        <input id="inputUsernameBox" type="text" name="username"
                               required="required" autofocus
                               placeholder="username"
                               style="width: 300px">
                    </div>
                    <div>
                        <label for="inputPasswordBox"></label>
                        <input id="inputPasswordBox" type="password" name="password"
                               required="required" autofocus
                               placeholder="password"
                               style="width: 300px">
                    </div>
                    <button id="sign-in" class="button" type="submit" style="margin-top: 10px">
                        <span>войти</span>
                    </button>
                </form>
            </div>
        </#if>
    <#else>
        <div>
            <form action="/login" method="post" id="loginForm">
                <div>
                    <label for="inputUsernameBox"></label>
                    <input id="inputUsernameBox" type="text" name="username"
                           required="required" autofocus
                           placeholder="username"
                           style="width: 300px">
                </div>
                <div>
                    <label for="inputPasswordBox"></label>
                    <input id="inputPasswordBox" type="password" name="password"
                           required="required" autofocus
                           placeholder="password"
                           style="width: 300px">
                </div>
                <button id="sign-in" class="button" type="submit" style="margin-top: 10px">
                <span>войти</span>
                </button>
            </form>
        </div>
    </#if>
</@layout.header>