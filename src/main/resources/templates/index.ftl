<#-- @ftlvariable name="username" type="String" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <#if username??>
        <p>
            <h1>${username}</h1>
        <p>
            <a href="/logout">Выйти из аккаунта</a>
        </p>
        <p>
            <a href="/shulte/startEvent">Start test</a>
        </p>
    <#else>
        <p>
            <a href="/login">Войти в аккаунт</a>
        </p>
        <p>
            <a href="/registration">Создать аккаунт</a>
        </p>
    </#if>
    <p>
        <a href="/shulte/instruction">Instruction</a>
    </p>
</@layout.header>