<#-- @ftlvariable name="username" type="String" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <style>
        a {
            text-decoration: none;
            color: #ffffff;
            font-family: SF Pro Text, SF Pro Icons, Helvetica Neue, Helvetica, Arial, sans-serif;
            font-size: 17px;
            font-weight: 400;
            letter-spacing: -.021em;
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
        }

        .menu-bar {
            border-radius: 25px;
            height: fit-content;
            display: inline-flex;
            background-color: #0071e3;
            -webkit-backdrop-filter: blur(10px);
            backdrop-filter: blur(10px);
            align-items: center;
            padding: 0 10px;
            margin: 50px 0 0 0;
        }

        .menu-bar li {
            list-style: none;
            color: white;
            font-family: sans-serif;
            font-weight: bold;
            padding: 12px 16px;
            margin: 0 8px;
            position: relative;
            cursor: pointer;
            white-space: nowrap;
        }

        .menu-bar li::before {
            content: " ";
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            z-index: -1;
            transition: 0.2s;
            border-radius: 25px;
        }

        .menu-bar li:hover {
            color: black;
        }

        .menu-bar li:hover::before {
            background: linear-gradient(140deg, #42a5e3, #ff8900);
            box-shadow: 0 3px 20px 0 black;
            transform: scale(1.2);
        }
    </style>
    <ul class="menu-bar">
        <#if username??>
            <li>${username}</li>
            <li><a href="/logout">Выйти из аккаунта</a></li>
            <li><a href="/shulte/startEvent">Начать тестирование</a></li>
            <li><a href="/showPersonalStatistic">Просмотреть личные результаты</a></li>

            <#if username == "admin">
                <li><a href="/showAllStatistics">Просмотреть общие результаты</a></li>
            </#if>
        <#else>
            <li><a href="/login">Войти в аккаунт</a></li>
            <li><a href="/registration">Создать аккаунт</a></li>
        </#if>
        <li><a href="/shulte/instruction">Инструкция</a></li>
    </ul>
</@layout.header>