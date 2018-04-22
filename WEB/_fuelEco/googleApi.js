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
        getLastStats();
        getAvgStats();
        setTimeout(renderLogsPage,1000);
        // *****************         login page                         // TODO:  ***********************************
    }
}

function handleClientLoad() {
    gapi.load('client:auth2', initClient);
}

function insertValues(_range, _values, _callback) {
    gapi.client.sheets.spreadsheets.values.append({
        spreadsheetId: fileID,
        valueInputOption: 'USER_ENTERED',
        range: _range,
        values: _values
    }).then(function(response) {
        var updatedCells = response.result.updates.updatedCells;
        console.log(`${updatedCells} cells updated.`);
        _callback(updatedCells);
    }, function(response) {
        var errorMessage = response.result.error.message;
        console.log(errorMessage);
        _callback(errorMessage);
    });
}

function readRange(_range, _callback) {
    gapi.client.sheets.spreadsheets.values.get({
        spreadsheetId: fileID,
        range: _range
    }).then((response) => {
        var result = response.result;
        var numRows = result.values ? result.values.length : 0;
        console.log(`${numRows} rows retrieved.`);
        _callback(numRows == 0 ? 0 : result.values);
    });
}

function insertRow(_callback) {
    var values = [
        [$('#dateInput').val(), $('#mileageInput').val(), , $('#literInput').val(), $('#priceInput').val(), , $('#check_fullTank').prop('checked') == true ? 1 : 0, , ]
    ];
    var range = $('#carSelect').val() + '!A1:I1';
    insertValues(range, values, _callback);
}
