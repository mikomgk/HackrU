var isNewMealDiv;
var meals = [];
var priceMonth;
var gotRows = false;

function ready() {
    setTimeout(getRows, 1);
    openNewMealDiv();
}

function getRows() {
    readRange("Sheet1!K1:K2", function (response) {
        var rowsNum = (response == 0 ? 0 : parseInt(response[0]));
        priceMonth = parseInt(response[1]);
        $("#monthlyAmountSpan").html(priceMonth);
        $("h2").css('color', '#fff');
        readRange("Sheet1!H6:M" + (5 + rowsNum), function (response) {
            console.log(response);
            for (var i = 0; i < (response == 0 ? 0 : response.length); i++) {
                meals.push(new Meal(response[i][1], response[i][2], response[i][5] + "/" + response[i][4] + "/" + response[i][3]));
            }
            gotRows = true;
        });
    })
}

function renderLog() {
    var s = '';
    for (var i = 0; i < meals.length; i++) {
        var meal = meals[i];
        s += '<div class="logItem">';
        s += '<img src="/_images/image.png" class="restaurantImg" />'
        s += '<div class="priceItem">' + meal.price;
        s += '</div>';
        s += '<div class="itemProp">';
        s += '<div class="descriptionItem">' + meal.description;
        s += '</div>';
        s += '<div class="dateItem">' + meal.date;
        s += '</div>';
        s += '</div>';
        s += '<img src="/_images/image.png" class="editImg" />'
        s += '</div>';
    }
    $("#logListDiv").html(s);
}

function Meal(_price, _description, _date) {
    this.price = _price;
    this.description = _description;
    this.date = _date;
}

function sendNewMeal() {
    var price = $("#priceInput");
    var description = $("#descriptionInput");
    if (price.val().length == 0) {
        return;
    }
    if (description.val().length == 0) {
        var answer = confirm("You didn't enter description\nDo you want to send anyway?\n");
        if (answer == false)
            return;
    }
    price.prop('disabled', true);
    description.prop('disabled', true);
    $("#sendMealBtn").html(loader);
    $("#logListDiv").html(loader("logListLoader", $("body").css("background-color")));
    insertRow(price.val(), description.val(), function () {
        if (gotRows) {
            $("#monthlyAmountSpan").html((priceMonth = priceMonth + parseInt(price.val())));
            var d = new Date();
            meals.push(new Meal(price, description, d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear()));
        }
        closeNewMealDiv();
        renderLogIfReady();
    });
}

function renderLogIfReady() {
    if (gotRows)
        renderLog();
    else
        setTimeout(renderLogIfReady, 50);
}

function openNewMealDiv() {
    var s = '';
    s += '<div id="enterNewMealDiv" class="container" style="display: none;">';
    s += '<button id="closeNewMealDiv" onclick="handleCloseNewMealBtn()">&#10008;</button>';
    s += '<form id="form" action="javascript:sendNewMeal();">';
    s += '<input type="tel" name="price" id="priceInput" onkeyup="changeWidth(id)"/>';
    s += '<span id="nisSign" style="visibility: hidden;">&#8362;</span><br/>';
    s += '<input type="text" name="description" id="descriptionInput" onkeyup="changeWidth(id)"/><br/>';
    s += '<button id="sendMealBtn">שלח</button>';
    s += '</form>';
    s += '</div>';
    $("body").html($("body").html()+s);
    $("#enterNewMealDiv").toggle(1000);
    isNewMealDiv = 1;
}

function closeNewMealDiv() {
    $("#enterNewMealDiv").toggle(1000).remove();
    isNewMealDiv = 0;
}

function changeWidth(_id) {
    var charLength = _id == 'priceInput' ? 13 : 10;
    var element = $("#" + _id);
    var length = element.val().length * charLength;
    length = _id == 'priceInput' ? length : length < 60 ? 60 : length;
    element.css('width', length == 0 ? charLength : length);
    if (_id == 'priceInput')
        $("#nisSign").css('visibility', 'visible');
}

function loader(_id, _backColor) {
    var loader = '<div class="loader" style="border-color: ' + _backColor + ';border-top-color: ' + $(".loader").css("border-top-color") + '">';
    loader += '<div class="loader1" style="border-color: ' + _backColor + ';border-top-color: ' + $(".loader1").css("border-top-color") + '">';
    loader += '<div class="loader2" style="border-color: ' + _backColor + ';border-top-color: ' + $(".loader2").css("border-top-color") + '">';
    loader += '</div></div></div>';
    return loader;
}

function handleNewMealBtn() {
    if (!isNewMealDiv)
        openNewMealDiv();
}

function handleCloseNewMealBtn() {
    closeNewMealDiv();
}