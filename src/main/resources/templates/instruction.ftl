<#import "_layout.ftl" as layout />
<@layout.header>
    <style>
        .textBox {
            cursor: pointer;
            display: inline-block;
            text-align: center;
            white-space: nowrap;
            font-size: 17px;
            line-height: 1.47648;
            font-weight: 400;
            letter-spacing: -.022em;
            font-family: SF Pro Text, SF Pro Icons, Helvetica Neue, Helvetica, Arial, sans-serif;
            min-width: 28px;
            max-width: 1000px;
            padding: 8px 16px;
            border-radius: 980px;
            background: #ffffff;
            border: 0;
        }
    </style>
    <div class="textBox">
        <i>
            <p>Вам будут поочередно предложены 5 таблиц с числами от 1 до 25, расположенными в произвольном порядке.<br>
                Ваша задача - выбирать в каждой таблице числа по возрастанию (от 1 до 25).<br>
                Выбор осуществляется при помощи клика по ячейке с числом.</p>
            <p>По окончании прохождения каждой таблицы, вам будет показано время выполнения и предложено перейти к
                следующей таблице.<br>
                После нажатия кнопки "Следующий тест" тестирование продолжится с новой таблицей.<br>
                В случае ошибки, блок будет подсвечен красным.</p>
            <p>По окончанию тестирования будет показан итоговый результат, с которым можно повтоорно ознакомиться в меню
                "Просмотр личных результатов".</p>
        </i>
    </div>
</@layout.header>