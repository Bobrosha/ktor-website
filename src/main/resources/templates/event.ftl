<#-- @ftlvariable name="listOfBlocks" type="kotlin.collections.List<kotlin.collections.IndexedValue<ru.project.zaicev.models.EventBlock>>" -->
<#-- @ftlvariable name="earlyResultList" type="kotlin.collections.List<kotlin.collections.List<String>>" -->
<#import "_layout.ftl" as layout />
<@layout.header>
    <style>
        .tableCeil {
            height: 170px;
            width: 170px;
            border: 1px solid #d3d3d3;
        }

        .draggableBlock {
            height: 170px;
            width: 170px;
            position: unset;
            z-index: 9;
            background-color: #f1f1f1;
            text-align: center;
            border: 1px solid #d3d3d3;
            display: inline-block;
        }

        .blockNumber {
            height: 100%;
            font-size: xxx-large;
            color: darkorange;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        ul b {
            padding-right: 10px;
        }

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
            visibility: hidden;
        }

        ul {
            display: flex;
        }
    </style>
    <b style="font-size: 39px;">Тест Шульте</b>
    <p id="instructionText">Нажимайте на блоки в правильном порядке.</p>

    <div>
        <b>Время выполнения: </b>
        <p id="timerText" style="margin-top: 0">00:00.000</p>
    </div>
    <div id="result" style="visibility:hidden; display:inline-block" hidden="hidden">
        <b> Результаты тестирования: </b>
        <ul>
            <b> Первый тест </b>
            <span id="firstTestResult"> </span>
        </ul>
        <ul>
            <b> Второй тест </b>
            <span id="secondTestResult"> </span>
        </ul>
        <ul>
            <b> Третий тест </b>
            <span id="thirdTestResult"> </span>
        </ul>
        <ul>
            <b> Четвертый тест </b>
            <span id="fourthTestResult"> </span>
        </ul>
        <ul>
            <b> Пятый тест </b>
            <span id="fifthTestResult"> </span>
        </ul>
        <ul>
            <b> Эффективность работы </b>
            <span id="efficiencyResult"> </span>
        </ul>
        <ul>
            <b> Степень врабатываемости </b>
            <span id="workabilityResult"> </span>
        </ul>
        <ul>
            <b> Психическая устойчивость </b>
            <span id="sustainabilityResult"> </span>
        </ul>

    </div>

    <div id="eventTable"
         style="-moz-user-select: none; -webkit-user-select: none; user-select: none;">
        <table style="display: flex; justify-content: center; align-items: center">
            <#list listOfBlocks as block>
                <#if block.index % 5 == 0>
                    <tr>
                </#if>
                <td id="ceil_${block.index}" class="tableCeil">
                    <div id="draggableBlock_${block.index}" class="draggableBlock">
                        <div class="blockNumber">
                            <b id="checkBox_${block.value.blockNumber}">${block.value.blockNumber}</b>
                        </div>
                    </div>
                </td>
                <#if block.index % 5 == 4>
                    </tr>
                </#if>
            </#list>
        </table>
    </div>

    <form action="/shulte/save" method="post" id="saveForm">
        <input id="inputResultList" type="hidden" name="resultList">
        <button id="saveResultButton" class="button" type="submit" name="save-result" value="save-result"
                title="Сохранить результат" hidden="hidden">
            <span>Сохранить результат</span>
        </button>
    </form>

    <form action="/shulte/retryEvent" method="post" id="nextEvent">
        <input id="resultList" type="hidden" name="resultList">
        <button id="nextEventButton" class="button" type="submit" name="next-event" value="next-event"
                title="Следующий тест" hidden="hidden">
            <span>Следующий тест</span>
        </button>
    </form>

    <script>
        document.getElementById("kotlinKtor").innerHTML = ""

        const resultDiv = document.getElementById("result").innerHTML
        document.getElementById("result").innerHTML = ""

        const testsResults = []
        const arr = []

        <#--noinspection ES6ConvertVarToLetConst-->
        var lastElemNumber = 25

        const numberOfTest = 5

        <#--noinspection ES6ConvertVarToLetConst-->
        var wrongClicks = 0
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerStarted = false
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerInMilliseconds = 0
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerInterval
        <#--noinspection ES6ConvertVarToLetConst-->
        var nextRightNumber = 1
        <#--noinspection ES6ConvertVarToLetConst-->
        var clickedElement = null

        <#if earlyResultList??>
        <#list earlyResultList as elem>
        testsResults.push(["${elem[0]}", "${elem[1]}"])
        </#list>
        </#if>

        <#list listOfBlocks as block>
        // elemNumber++
        arr.push(${block.value.blockNumber})
        initElement(document.getElementById("draggableBlock_${block.index}"), ${block.value.blockNumber})
        </#list>

        function nextEvent() {
            console.info("Redirect to next event")
            console.info(testsResults)

            let resultList = document.getElementById("resultList")
            let nextEventButton = document.getElementById("nextEventButton")

            resultList.value = testsResults

            nextEventButton.hidden = false
            nextEventButton.style.visibility = "visible"
        }

        function initElement(element, trueIndex) {
            element.onmousedown = dragMouseDown

            function dragMouseDown() {
                if (!timerStarted) {
                    timerStarted = true
                    timerInterval = setInterval(startTimer, 10)
                }

                if (clickedElement != null) {
                    clickedElement.style.backgroundColor = "#f1f1f1"
                }
                clickedElement = element

                if (trueIndex === nextRightNumber) {
                    element.style.backgroundColor = "#14ff00"

                    if (nextRightNumber === lastElemNumber) {
                        rememberAndClean()
                        clickedElement.style.backgroundColor = "#f1f1f1"

                        if (testsResults.length === numberOfTest) {
                            console.info("all tests completed")
                            allTestsCompleted()
                        } else {
                            console.info("next test. len = " + testsResults.length + "/" + numberOfTest)
                            nextEvent()
                        }
                    } else {
                        nextRightNumber++
                    }
                } else {
                    wrongClicks++
                    element.style.backgroundColor = "#ff0000"
                }
            }

            function allTestsCompleted() {
                document.getElementById("result").innerHTML = resultDiv
                document.getElementById("instructionText").innerHTML = "Задание выполнено!"
                document.getElementById("eventTable").innerHTML = ""

                let effCount = 0;
                for (let i = 0; i < testsResults.length; i++)
                    effCount += Number(testsResults[i][1])

                document.getElementById("firstTestResult").innerHTML = testsResults[0][1] / 100 + " cек"
                document.getElementById("secondTestResult").innerHTML = testsResults[1][1] / 100 + " cек"
                document.getElementById("thirdTestResult").innerHTML = testsResults[2][1] / 100 + " cек"
                document.getElementById("fourthTestResult").innerHTML = testsResults[3][1] / 100 + " cек"
                document.getElementById("fifthTestResult").innerHTML = testsResults[4][1] / 100 + " cек"
                document.getElementById("timerText").innerHTML = effCount / 100 + " cек"

                effCount /= 5
                const sustCount = Number(testsResults[3][1]) / effCount;
                const workCount = Number(testsResults[0][1]) / effCount;

                document.getElementById("efficiencyResult").innerHTML = Number(effCount / 100).toFixed(2).toString()
                document.getElementById("workabilityResult").innerHTML = Number(workCount).toFixed(2).toString()
                document.getElementById("sustainabilityResult").innerHTML = Number(sustCount).toFixed(2).toString()

                let result = document.getElementById("result")
                result.hidden = false
                result.style.visibility = "visible"

                let inputResultList = document.getElementById("inputResultList")
                let saveResultButton = document.getElementById("saveResultButton")

                inputResultList.value = testsResults

                saveResultButton.hidden = false
                saveResultButton.style.visibility = "visible"
            }

            function rememberAndClean() {
                testsResults.push([wrongClicks, timerInMilliseconds])

                document.getElementById("instructionText").innerHTML = "Пройдено тестов " + testsResults.length + " из " + numberOfTest

                <#list listOfBlocks as block>
                document.getElementById("draggableBlock_${block.index}").onmousedown = null
                </#list>
                clearInterval(timerInterval)
            }

            function startTimer() {
                timerInMilliseconds++
                let timerElement = document.getElementById("timerText")
                let timeInSeconds = Math.floor(timerInMilliseconds / 100)
                let timeInMinutes = Math.floor(timeInSeconds / 60)

                let printSeconds = timeInSeconds - timeInMinutes * 60
                let printMilliseconds = timerInMilliseconds - timeInSeconds * 100

                timerElement.innerHTML = (timeInMinutes < 10 ? "0" + timeInMinutes : timeInMinutes) + ":" + (printSeconds < 10 ? "0" + printSeconds : printSeconds) + "." + printMilliseconds
            }
        }
    </script>
</@layout.header>