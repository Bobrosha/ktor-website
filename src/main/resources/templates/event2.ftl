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
            position: absolute;
            z-index: 9;
            background-color: #f1f1f1;
            text-align: center;
            border: 1px solid #d3d3d3;
        }

        .blockNumber {
            height: 100%;
            font-size: xxx-large;
            color: darkorange;
            display: flex;
            justify-content: center;
            align-items: center;
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
    </style>

    <h1>Name Event</h1>

    <p id="instructionText">Перетащите блоки так, чтобы они находились в правильном порядке.</p>

    <div>
        <b>Время выполнения: </b>
        <p id="timerText" style="margin-top: 0">00:00.000</p>
    </div>

    <div style="padding-top: 15px; padding-bottom: 15px; -moz-user-select: none; -webkit-user-select: none; user-select: none;">
        <form action="/shulte/save" method="post" id="saveForm">
            <input id="inputTimeBox" type="hidden" name="elapsedTime">
            <input id="inputUserBox" type="hidden" name="username">
            <button id="saveResultButton" class="button" type="submit" name="save-result" value="save-result"
                    title="Сохранить результат" hidden="hidden">
                <span>Сохранить результат</span>
            </button>
        </form>

        <table style="display: flex; justify-content: center; align-items: center">
            <tr>
                <td id="ceil_1" class="tableCeil"></td>
                <td id="ceil_2" class="tableCeil"></td>
                <td id="ceil_3" class="tableCeil"></td>
                <td id="ceil_4" class="tableCeil"></td>
                <td id="ceil_5" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_6" class="tableCeil"></td>
                <td id="ceil_7" class="tableCeil"></td>
                <td id="ceil_8" class="tableCeil"></td>
                <td id="ceil_9" class="tableCeil"></td>
                <td id="ceil_10" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_11" class="tableCeil"></td>
                <td id="ceil_12" class="tableCeil"></td>
                <td id="ceil_13" class="tableCeil"></td>
                <td id="ceil_14" class="tableCeil"></td>
                <td id="ceil_15" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_16" class="tableCeil"></td>
                <td id="ceil_17" class="tableCeil"></td>
                <td id="ceil_18" class="tableCeil"></td>
                <td id="ceil_19" class="tableCeil"></td>
                <td id="ceil_20" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_21" class="tableCeil"></td>
                <td id="ceil_22" class="tableCeil"></td>
                <td id="ceil_23" class="tableCeil"></td>
                <td id="ceil_24" class="tableCeil"></td>
                <td id="ceil_25" class="tableCeil"></td>
            </tr>
        </table>
    </div>

    <#list listOfBlocks as block>
        <div id="draggableBlock_${block.index}" class="draggableBlock">
            <div class="blockNumber">
                <b id="checkBox_${block.value.blockNumber}">${block.value.blockNumber}</b>
            </div>
        </div>
    </#list>

    <form action="/shulte/retryEvent" method="post" id="nextEvent">
        <input id="resultList" type="hidden" name="resultList">
        <button id="nextEventButton" class="button" type="submit" name="next-event" value="next-event"
                title="Следующий тест" hidden="hidden">
            <span>Следующий тест</span>
        </button>
    </form>

    <script>
        const testsResults = []
        const arr = []

        <#--noinspection ES6ConvertVarToLetConst-->
        var lastElemNumber = 5

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

        shuffle(testsResults)

        <#if earlyResultList??>
        <#list earlyResultList as elem>
        testsResults.push(["${elem[0]}", "${elem[1]}"])
        console.info("${elem[0]} ${elem[1]}")
        console.info(testsResults)
        </#list>
        </#if>

        <#list listOfBlocks as block>
        // elemNumber++
        arr.push(${block.value.blockNumber})
        initElement(document.getElementById("draggableBlock_${block.index}"), ${block.value.blockNumber})
        setPositionToCeil(document.getElementById("draggableBlock_${block.index}"), document.getElementById("ceil_${block.index + 1}"))
        </#list>

        function shuffle(array) {
            array.sort(() => Math.random() - 0.5);
        }

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
                document.getElementById("instructionText").innerHTML = "Задание выполнено!"

                <#list listOfBlocks as block>
                document.getElementById("draggableBlock_${block.index}").style.visibility = "hidden"
                document.getElementById("ceil_${block.index + 1}").style.visibility = "hidden"
                </#list>


                let inputTimeBox = document.getElementById("inputTimeBox")
                let inputUserBox = document.getElementById("inputUserBox")
                let saveResultButton = document.getElementById("saveResultButton")

                inputUserBox.value = "Vladislav"
                inputTimeBox.value = testsResults

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

        function setPositionToCeil(blockElement, ceilElement) {
            let ceilPosition = ceilElement.getBoundingClientRect()

            blockElement.style.top = ceilPosition.top + 186.25 + "px"
            blockElement.style.left = ceilPosition.left + "px"
        }
    </script>
</@layout.header>