function renderLogsPage() {
    /*var numRows;
    readRange(($('#carSelect').val() == 'Picanto' ? 'Picanto' : 'Demio') + '!J1', function(_val) {
        numRows= val[0];
    });*/
    var s= '<div id="logsPageDiv" class="inPageContainer" style="display:none;">';
    readRange(($('#carSelect').val() == 'Picanto' ? 'Picanto' : 'Demio') + '!A3:I' , function(_values) { // TODO: change I to K
        for (i = _values.length - 1; i >= 0; i--) {
            s+= '<div class="logsRow">';
            s+= '<img src="_images/fuel.png" />';
            s+= '<div class="logsInfo">';
            s+= '<div class="logsRight">';
            s+= '<div class="logsDate">' + _values[i][0];
            s+= '</div>';
            s+= '<div class="logsLPKM">' + _values[i][8];
            s+= '</div>';
            s+= '<div class="rightUnit"><sub>ליטר/לק\"מ</sub>';
            s+= '</div>';
            s+= '</div>';
            s+= '</div>';
            s+= '<div class="lineSeperatorVer">';
            s+= '</div>';
            s+= '<div class="logsLeft">';
            s+= '<div class="logsItem"><img src="_images/odometer.png" />' + _values[i][1] + '<sub>ק\"מ</sub>';
            s+= '</div>';
            s+= '<div class="logsItem"><img src="_images/mileage.png" />' + _values[i][2] + '<sub>ק\"מ</sub>';
            s+= '</div>';
            s+= '<div class="smallLineSeperator">';
            s+= '</div>';
            s+= '<div class="logsItem"><img src="_images/fuel.png" />' + _values[i][3] + '<sub>ליטר</sub>';
            s+= '</div>';
            s+= '<div class="smallLineSeperator">';
            s+= '</div>';
            s+= '<div class="logsItem"><img src="_images/money.png" />' + _values[i][4] + '<sub>&#8362;</sub>';
            s+= '</div>';
            s+= '<div class="fuelPercent">';
            s+= '</div>';
            s+= '</div>';
            s+= '</div>';
        }
        s+= '</div>';
        $('#pageContainer').html(s);
        $('#logsPageDiv').toggle(1000);
    });
}
