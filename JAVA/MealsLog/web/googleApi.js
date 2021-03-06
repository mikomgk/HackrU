var fileID = '';
var API_KEY = '';
var CLIENT_ID = '';
var SCOPES = "https://www.googleapis.com/auth/spreadsheets";
var DISCOVERY_DOCS = ["https://sheets.googleapis.com/$discovery/rest?version=v4"];

function handleClientLoad() {
    gapi.load('client:auth2', initClient);
}

function initClient() {
    gapi.client.init({
        apiKey: API_KEY,
        clientId: CLIENT_ID,
        discoveryDocs: DISCOVERY_DOCS,
        scope: SCOPES
    }).then(function () {
        console.log(gapi.auth2.getAuthInstance().isSignedIn.get() ? "Logged In" : "Error");
        gapi.auth2.getAuthInstance().isSignedIn.listen(updateSignInStatus);
        gapi.auth2.getAuthInstance().signIn();
        updateSignInStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
    },function (response) {
        var errorMessage = response.result.error.message;
        console.log(errorMessage);
    });
}

function updateSignInStatus(isSignedIn) {
    if (isSignedIn) {
        ready();
    } else {
    }
}

function insertValues(_range, _values, _callback) {
    gapi.client.sheets.spreadsheets.values.append({
        spreadsheetId: fileID,
        valueInputOption: 'USER_ENTERED',
        range: _range,
        values: _values
    }).then(function (response) {
        var updatedCells = response.result.updates.updatedCells;
        console.log(`${updatedCells} cells updated.`);
        _callback(updatedCells);
    }, function (response) {
        var errorMessage = response.result.error.message;
        console.log(errorMessage);
        // _callback(errorMessage);
    });
}

function readRange(_range, _callback) {
    gapi.client.sheets.spreadsheets.values.get({
        spreadsheetId: fileID,
        range: _range
    }).then(function (response) {
        var result = response.result;
        var numRows = result.values ? result.values.length : 0;
        console.log(`${numRows} rows retrieved.`);
        _callback(numRows == 0 ? 0 : result.values);
    }),function (response) {
        var errorMessage = response.result.error.message;
        console.log(errorMessage);
        // _callback(errorMessage);
    };
}

function insertRow(_price, _description, _callback) {
    var d = new Date();
    var values = [
        [_price, _description, d.getFullYear(), d.getMonth()+1, d.getDate()]
    ];
    var range = 'Sheet1!A2:E2';
    insertValues(range, values, _callback);
}
