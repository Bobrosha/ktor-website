<#-- @ftlvariable name="resultList" type="kotlin.collections.List<kotlin.collections.IndexedValue<kotlin.collections.List<kotlin.Pair<Int, Int>>>>" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <style>
        .menu {
            border-radius: 10px;
            width: 500px;
            list-style: none;
            padding: 0;
            border: 1px solid rgba(0, 0, 0, .2);
            position: relative;
        }

        .menu li {
            overflow: hidden;
            padding: 6px 10px;
            font-size: 20px;
        }

        .menu li:first-child {
            font-weight: bold;
            padding: 15px 0 10px 15px;
            margin-bottom: 10px;
            border-bottom: 1px solid rgba(0, 0, 0, .2);
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            color: #679bb7;
            font-size: 24px;
            box-shadow: 0 10px 20px -5px rgba(0, 0, 0, .2);
        }

        .menu li:first-child:before {
            content: "\27AB";
            margin-right: 10px;
        }

        .menu span {
            float: left;
            width: 75%;
            color: #7C7D7F;
        }

        .menu em {
            float: right;
            color: #bd1515;
            font-weight: bold;
        }

        ul b {
            float: left;
            color: #7C7D7F;
        }
    </style>
    <div style="display: inline-block">
        <#if resultList??>
        <#list resultList as tests>
            <ul class="menu" style="width: 450px; padding-bottom: 10px">
                <li>${tests.index + 1} тест</li>
                <#list tests.value as test>
                    <li>
                        <span style="text-align: left">Время выполнения: ${test.second / 100}cек</span>
                        <em>Ошибки: ${test.first}</em>
                    </li>
                </#list>
                <li><b id="efficiencyResult_${tests.index + 1}" style="text-align: left"></b></li>
                <li><b id="workabilityResult_${tests.index + 1}" style="text-align: left"></b></li>
                <li><b id="sustainabilityResult_${tests.index + 1}" style="text-align: left"></b></li>
                <li><b id="timerText_${tests.index + 1}" style="text-align: left"></b></li>
            </ul>
        </#list>
            <script>
                let testsResults
                let effCount
                let sustCount
                let workCount
                let num

                <#list resultList as tests>
                testsResults = []
                effCount = 0

                <#list tests.value as test>
                num = Number("${test.second / 100}".replace(",", "."))
                effCount += num
                testsResults.push(num)
                </#list>

                document.getElementById("timerText_${tests.index + 1}").innerHTML = "Общая продолжительность " + effCount.toFixed(2).toString() + " сек"

                effCount /= 5
                sustCount = testsResults[3] / effCount;
                workCount = testsResults[0] / effCount;

                document.getElementById("efficiencyResult_${tests.index + 1}").innerHTML = "Эффективность работы " + effCount.toFixed(2).toString()
                document.getElementById("workabilityResult_${tests.index + 1}").innerHTML = "Степень врабатываемости " + workCount.toFixed(2).toString()
                document.getElementById("sustainabilityResult_${tests.index + 1}").innerHTML = "Психическая устойчивость " + sustCount.toFixed(2).toString()
                </#list>
            </script>
        <#else>
            Нет результатов
        </#if>
    </div>
</@layout.header>