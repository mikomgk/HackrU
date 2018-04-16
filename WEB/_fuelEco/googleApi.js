var fileID = '1wLfKPiNqbgTakkyxWpzEMjG7KHGUtMwdiUQrd4_wk34';
var API_KEY = 'AIzaSyD_awRioYTthWk09yjS5D43nAfF0xhxyWg';
var CLIENT_ID = '591022824629-jga5u7ocedshk4oe5ob63nlehi02jin9.apps.googleusercontent.com';
var SCOPE = 'https://www.googleapis.com/auth/spreadsheets';

function initClient() {
    gapi.client.init({
        'apiKey': API_KEY,
        'clientId': CLIENT_ID,
        'scope': SCOPE,
        'discoveryDocs': ['https://sheets.googleapis.com/$discovery/rest?version=v4'],
    }).then(function() {
        console.log(gapi.auth2.getAuthInstance().isSignedIn.get() ? "Logged In" : "Error");
        gapi.auth2.getAuthInstance().isSignedIn.listen(updateSignInStatus);
        updateSignInStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
    });
}

function updateSignInStatus(isSignedIn) {
    if (isSignedIn) {

        // *****************         login page      *************************************************
    }
}

function handleClientLoad() {
    gapi.load('client:auth2', initClient);
}

function insertValues(_range, _values) {
    gapi.client.sheets.spreadsheets.values.append({
        spreadsheetId: fileID,
        valueInputOption: 'USER_ENTERED',
        range: _range,
        values: _values
    }).then((response) => {
        var result = response.result;
        console.log(`${result.updatedCells} cells updated.`);
    });
}

function readRange(_range, callback) {
    gapi.client.sheets.spreadsheets.values.get({
        spreadsheetId: fileID,
        range: _range
    }).then((response) => {
        var result = response.result;
        var numRows = result.values ? result.values.length : 0;
        console.log(`${numRows} rows retrieved.`);
        callback(numRows == 0 ? 0 : result.values);
    });
}

function insertRow() {
    var values = [
        [inputDate.value, inputMileage.value, , inputLiter.value, inputPrice.value, , fullTank.checked == true ? '1' : '0', , ]
    ];
    var range = car.value + '!A1:I1';
    insertValues(range, values);
}
