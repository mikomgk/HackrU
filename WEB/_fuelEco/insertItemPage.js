var minMileage = 0;
var v$ = '&#10004;';
var x$ = '&#10008;';

function renderNewItemPage() {
    var s = '';
    s += '<div id="insertNewItemDiv" style="display:none;">';
    s += '<div id="formDiv">'
    s += '<form action="javascript:handleSubmitButton();">';
    s += '<div id="divDate" class="divInput">';
    s += '<img src="_images/date.png" class="formIcon" />';
    s += '<input type="date" name="date" id="dateInput" required />';
    s += '</div>';
    s += '<div id="divMileage" class="divInput">';
    s += '<img src="_images/mileage.png" class="formIcon" />';
    s += '<input type="tel" name="mileage" id="mileageInput" class="inputNum correctInputFont" placeholder="' + minMileage + ' +" onblur="checkInputValid(id)" onfocus="handleReInput(id)" autocomplete="off" required />';
    s += '<div class="inputSign">ק\"מ</div>';
    s += '</div>';
    s += '<div id="divLiter" class="divInput">';
    s += '<img src="_images/fuel.png" class="formIcon" />';
    s += '<input type="tel" name="liter" id="literInput" class="inputNum correctInputFont" placeholder="דלק" onblur="checkInputValid(id)" onfocus="handleReInput(id)" autocomplete="off" required />';
    s += '<div class="inputSign">ליטר</div>';
    s += '</div>';
    s += '<div id="divPrice" class="divInput">';
    s += '<img src="_images/price.png" class="formIcon" />';
    s += '<input type="tel" name="price" id="priceInput" class="inputNum correctInputFont" placeholder="מחיר" onblur="checkInputValid(id)" onfocus="handleReInput(id)" autocomplete="off" required />';
    s += '<div class="inputSign">&#8362;</div>';
    s += '</div>';
    s += '<div id="fullTankDiv">';
    s += '<p>מיכל מלא</p>';
    s += '<label class="switch">';
    s += '<input type="checkbox" name="fulltank" id="check_fullTank" checked>';
    s += '<span class="slider round"></span>';
    s += '</label>';
    s += '</div>';
    s += '<button id="submitButton" class="beforeSubmit">הוסף</button>';
    s += '</form>';
    s += '</div>';
    s += '</div>';
    $('#pageContainer').html(s);
    $('#mileageInput').attr('inputMode', false);
    $('#literInput').attr('inputMode', false);
    $('#priceInput').attr('inputMode', false);
    $('#insertNewItemDiv').toggle(1000);
    setMinMileage();
    setNowDate();
}

function setMinMileage() {
    minMileage = $('#carSelect').val() == 'Picanto' ? picantoMinMileage : demioMinMileage;
    $('#mileageInput').attr('placeholder', minMileage + '+');
}

function HandleCheckInputValid(_id) {
    checkInputValid(_id);
}

function checkInputValid(_id) {
    var x = Number($('#' + _id).val());
    if (x == '') {
        inputValidater(_id, false);
        changeInputMode(_id, false);
    } else
        switch (_id) {
            case 'mileageInput':
                if (x <= minMileage) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id, false);
                } else
                    changeInputMode(_id, true);
                break;
            case 'literInput':
                if (x < 1) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id, false);
                } else
                    changeInputMode(_id, true);
                break;
            case 'priceInput':
                if (x < $('#literInput').val()) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id, false);
                } else
                    changeInputMode(_id, true);
                break;
        }
}

function shakeInputDiv(_id) {
    $('#' + _id).parent().addClass('wrongInputDiv');
}

function removeShakeInputDiv(_id) {
    $('#' + _id).parent().removeClass('wrongInputDiv');
}

function inputValidater(_id, mode) {
    if (mode) {
        $('#' + _id).removeClass('wrongInputFont');
        $('#' + _id).addClass('correctInputFont');
    } else {
        $('#' + _id).removeClass('correctInputFont');
        $('#' + _id).addClass('wrongInputFont');
    }
}

function changeInputMode(_id, _status) {
    $('#' + _id).attr('inputMode', _status);
}

function handleReInput(_id) {
    reInput(_id);
}

function reInput(_id) {
    inputValidater(_id, true);
    removeShakeInputDiv(_id);
}

function handleSubmitButton() {
    submit();
}

function submit() {
    removeShakeInputDiv($('#mileageInput').attr('id'));
    removeShakeInputDiv($('#literInput').attr('id'));
    removeShakeInputDiv($('#priceInput').attr('id'));
    checkInputValid($('#mileageInput').attr('id'));
    checkInputValid($('#literInput').attr('id'));
    checkInputValid($('#priceInput').attr('id'));
    if ($('#mileageInput').attr('inputMode') == $('#literInput').attr('inputMode') == $('#priceInput').attr('inputMode')) {
        $('#submitButton').html(loader);
        insertRow(function(_result) {
            setTimeout(function() {
                if (_result != 6) {
                    $('#submitButton').html(v$);
                    $('#submitButton').addClass('afterSubmit');
                    setTimeout(function() {
                        $('#insertNewItemDiv').css('background-color', '#4CAF50');
                        $('.inputNum #dateInput').addClass('afterInsert');
                        $('#insertNewItemDiv').toggle(1000);
                    }, 1000);
                } else {
                    $('#submitButton').html(x$);
                    $('#submitButton').css('background-color', 'red');
                    $('#submitButton').addClass('afterSubmit');
                    setTimeout(function() {
                        alert(_result);
                    }, 900);
                    //$('#submitButton').css('background-color','#4CAF50');
                }
            }, 2000);
        });

        //setTimeout(*************         close page                         // TODO:
    } else {
        checkInputValid($('#mileageInput').attr('id'));
        checkInputValid($('#literInput').attr('id'));
        checkInputValid($('#priceInput').attr('id'));
    }
}

function setNowDate() {
    var nowTime = new Date();
    var nowDate;
    if (nowTime.getMonth() < 10)
        nowDate = nowTime.getFullYear() + "-0" + (nowTime.getMonth() + 1);
    else
        nowDate = nowTime.getFullYear() + "-" + (nowTime.getMonth() + 1);
    if (nowTime.getDate() < 10)
        nowDate += "-0" + nowTime.getDate();
    else
        nowDate += "-" + nowTime.getDate();
    $('#dateInput').val(nowDate);
}
