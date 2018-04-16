var minMileage = 0;

function renderNewItemPage() {
    var s = '';
    s += '<div id="insertNewItemDiv">';
    s += '<form action="javascript:handleSubmitButton();">';
    s += '<img src="_images/date.png" class="formIcon" />';
    s += '<input type="date" name="date" id="dateInput" required />';
    s += '<div id="divMileage" class="divInput">';
    s += '<img src="_images/mileage.png" class="formIcon" />';
    s += '<input type="tel" name="mileage" id="mileageInput" class="inputNum correctInputFont" placeholder="' + minMileage + ' +" onblur="checkInputValid(id)" onfocus="handleReInput(id)" required />';
    s+='<div class="inputSign">ק\"מ</div>';
    s += '</div>';
    s += '<div id="divLiter" class="divInput">';
    s += '<img src="_images/fuel.png" class="formIcon" />';
    s += '<input type="tel" name="liter" id="literInput" class="inputNum correctInputFont" placeholder="דלק" onblur="checkInputValid(id)" onfocus="handleReInput(id)" required />';
    s+='<div class="inputSign">ליטר</div>';
    s += '</div>';
    s += '<div id="divPrice" class="divInput">';
    s += '<img src="_images/price.png" class="formIcon" />';
    s += '<input type="tel" name="price" id="priceInput" class="inputNum correctInputFont" placeholder="מחיר" onblur="checkInputValid(id)" onfocus="handleReInput(id)" required />';
    s+='<div class="inputSign">&#8362;</div>';
    s += '</div>';
    s += '<div id="fullTankDiv">';
    s += '<p>מיכל מלא</p>';
    s += '<label class="switch">';
    s += '<input type="checkbox" name="fulltank" id="check_fullTank" checked>';
    s += '<span class="slider round"></span>';
    s += '</label>';
    s += '</div>';
    s += '<input type="submit" value="הוסף" id="submitButton" />';
    s += '</form>';
    s += '</div>';
    $(pageContainer).html(s);
    $(mileageInput).attr('mode', 0);
    $(literInput).attr('mode', 0);
    $(priceInput).attr('mode', 0);
    setNowDate();
}

function HandleCheckInputValid(_id) {
    checkInputValid(_id);
}

function checkInputValid(_id) {
    var x = $('#' + _id).val();
    if (x == '') {
        inputValidater(_id, false);
        changeInputMode(_id);
    } else
        switch (_id) {
            case 'mileageInput':
                if (x <= minMileage) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id);
                } else
                    changeInputMode(_id);
                break;
            case 'literInput':
                if (x < 1) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id);
                } else
                    changeInputMode(_id);
                break;
            case 'priceInput':
                if (x < $('#literInput').val()) {
                    inputValidater(_id, false);
                    shakeInputDiv(_id);
                    changeInputMode(_id);
                } else
                    changeInputMode(_id);
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

function changeInputMode(_id) {
    $('#' + _id).attr('mode', ($('#' + _id).attr('mode') == 0 ? 1 : 0));
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
    if ($(mileageInput).attr('mode') == $(literInput).attr('mode') == $(priceInput).attr('mode') == 1)
        submit;
    else {
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
