<#-- @ftlvariable name="listOfBlocks" type="kotlin.collections.List<kotlin.collections.IndexedValue<ru.project.zaicev.models.EventBlock>>" -->
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

        .blockHeader {
            padding: 10px;
            cursor: move;
            z-index: 10;
            background-color: #2196F3;
            color: #fff;
        }

        .blockNumber {
            height: 80%;
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

    <h1>Инструкция к выполнению</h1>

    <p id="instructionText">Перетащите блоки так, чтобы они находились в правильном порядке.</p>

    <div>
        <b>Время выполнения: </b>
        <p id="timerText" style="margin-top: 0">00:00.000</p>
    </div>

    <div style="padding-top: 15px; padding-bottom: 15px; -moz-user-select: none; -webkit-user-select: none; user-select: none;">
        <table style="display: flex; justify-content: center; align-items: center">
            <tr>
                <td id="ceil_1" class="tableCeil"></td>
                <td id="ceil_2" class="tableCeil"></td>
                <td id="ceil_3" class="tableCeil"></td>
                <td id="ceil_4" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_5" class="tableCeil"></td>
                <td id="ceil_6" class="tableCeil"></td>
                <td id="ceil_7" class="tableCeil"></td>
                <td id="ceil_8" class="tableCeil"></td>
            </tr>
            <tr>
                <td id="ceil_9" class="tableCeil"></td>
                <td id="ceil_10" class="tableCeil"></td>
                <td id="ceil_11" class="tableCeil"></td>
                <td id="ceil_12" class="tableCeil"></td>
            </tr>
        </table>
    </div>

    <#list listOfBlocks as block>
        <div id="draggableBlock_${block.index}" class="draggableBlock">
            <div class="blockHeader">
                Click here and move
            </div>
            <div class="blockNumber">
                <b id="checkBox_${block.value.blockNumber}">${block.value.blockNumber}</b>
            </div>
        </div>
    </#list>

    <form action="/articles/save" method="post">
        <input id="inputTimeBox" type="hidden" name="elapsedTime">
        <input id="inputUserBox" type="hidden" name="username">
        <button id="saveResultButton" class="button-save" type="submit" name="save-result" value="save-result"
                title="Сохранить результат" hidden="hidden">
        <span>
            Сохранить результат
        </span>
        </button>
    </form>

    <script>
        const arr = []
        const blockArray = []
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerStarted = false
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerInMilliseconds = 0
        <#--noinspection ES6ConvertVarToLetConst-->
        var timerInterval

        class Block {
            constructor(index, trueNumber) {
                this.index = index
                this.trueNumber = trueNumber
                this.isMovable = true
            }

            set oldTop(x) {
                this.oldX = x
            }

            set oldLeft(y) {
                this.oldY = y
            }

            set newTop(x) {
                this.newX = x
            }

            set newLeft(y) {
                this.newY = y
            }
        }

        <#list listOfBlocks as block>
        arr.push(true)
        </#list>
        var blockElem
        <#list listOfBlocks as block>
        arr.push(true)

        blockElem = new Block(${block.index}, ${block.value.blockNumber})
        blockArray.push(blockElem)

        setPositionToCeil(blockElem, document.getElementById("draggableBlock_${block.index}"), document.getElementById("ceil_${block.index + 1}"))
        </#list>

        timerInterval = setInterval(startTimer, 10)

        <#list listOfBlocks as block>
        arr.push(true)
        blockElem = blockArray.find < Block > ((it) => {
            return it.index === ${block.index}
        })
        moveToRightCeil(blockElem, document.getElementById("draggableBlock_${block.index}"), document.getElementById("ceil_${block.value.blockNumber}"))
        </#list>

        // blockArray.forEach((it) => {
        //     setPositionToCeil(it, document.getElementById("draggableBlock_" + it.index), document.getElementById("ceil_" + it.index + 1))
        // })
        //
        // blockArray.forEach((it) => {
        //     moveToRightCeil(document.getElementById("draggableBlock_" + it.index), document.getElementById("ceil_" + it.trueNumber))
        // })

        function moveToRightCeil(block, element, ceil) {
            setTimeout(setPosition, 3000)

            function setPosition() {
                changeFlagAndCheckEnd(element)
                setPositionToRight(block, element, ceil)
            }

            function changeFlagAndCheckEnd(elem) {
                let index = elem.id.toString().split("_")[1]
                arr[index] = false

                if (arr.findIndex((it) => {
                    return it === true
                }) === -1) {
                    clearInterval(timerInterval)

                    document.getElementById("instructionText").innerHTML = "Задание выполнено!"

                    let inputTimeBox = document.getElementById("inputTimeBox")
                    let inputUserBox = document.getElementById("inputUserBox")
                    let saveResultButton = document.getElementById("saveResultButton")

                    inputUserBox.value = "Vladislav"
                    inputTimeBox.value = "00:" + document.getElementById("timerText").textContent

                    saveResultButton.hidden = false
                    saveResultButton.style.visibility = "visible"
                }
            }

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

        function setPositionToRight(block, blockElement, ceilElement) {
            let ceilPosition = ceilElement.getBoundingClientRect()

            blockElement.style.top = ceilPosition.top + "px"
            blockElement.style.left = ceilPosition.left + "px"

            block.newTop = blockElement.style.top
            block.newLeft = blockElement.style.left
        }

        function setPositionToCeil(block, blockElement, ceilElement) {
            let ceilPosition = ceilElement.getBoundingClientRect()

            blockElement.style.top = ceilPosition.top + 186.25 + "px"
            blockElement.style.left = ceilPosition.left + "px"

            block.oldTop = blockElement.style.top
            block.oldLeft = blockElement.style.left
        }
    </script>
</@layout.header>