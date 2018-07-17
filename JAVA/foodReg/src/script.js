var isNewMealDiv;
var loader = '';
var meals = [];
var priceMonth;

$(function () {
    //gapi.auth2.getAuthInstance().signIn();
    loader = '<div class="loader">';
    loader += '<div class="loader1">';
    loader += '<div class="loader2">';
    loader += '</div></div></div>';
    openNewMealDiv;
    $("#logListDiv").html(loader);
    getRows()
})

function getRows() {
    readRange("Sheet1!K1:K2", function (response) {
        var rowsNum = (response == 0 ? 0 : parseInt(response[0]));
        priceMonth = response[1];
        readRange("Sheet1!H6:M" + (5 + rowsNum), function (response) {
            for (var i = 0; i < (response == 0 ? 0 : response.length); i++) {
                meals.push(new Meal(response[i][2], response[i][3], response[i][6] + "/" + response[i][5] + "/" + response[i][4]));
            }
            renderLog();
        })
    })
}

function renderLog() {
    $("#monthlyAmountSpan").html(priceMonth);
    var s='';
    for (var i = 0; i < meals.length; i++) {
        s += '<div class="logItem">';
        s += '<div class="priceItem">' + meals[i].price;
        s += '</div>';
        s += '<div class="descriptionItem">' + meals[i].description;
        s += '</div>';
        s += '<div class="dateItem">' + meals[i].date;
        s += '</div>';
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
    var price = $("#priceInput").val();
    var description = $("#descriptionInput").val();
    $("#enterNewMealDiv").html(loader);
    insertRow(price, description, function () {
        closeNewMealDiv();
    })
}

function openNewMealDiv() {
    $("#enterNewMealDiv").fadeIn(50);
    isNewMealDiv = 1;
}

function closeNewMealDiv() {
    $("#enterNewMealDiv").fadeOut(50);
    isNewMealDiv = 0;
}