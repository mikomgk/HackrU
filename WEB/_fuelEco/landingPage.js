var kmpl;
var lpkm;
var deltaMileage;
var sumLiter;
var sumPrice;
var avg100KmCost;
var avgCostLiter;
var lastDeltaMileage;
var lastLiter;
var lastPrice;

function renderLandingPage() {
    currentPage = 'landingPage';
    var s = '';
    s += '<div id="landingPageDiv"  style="display:none;">';
    s += '<div class="logRow">';
    s += '<div class="logItem right">';
    s += '<div id="KMPLLogItem" class="itemNumber">12.22';// + kmpl;
    s += '</div>';
    s += '<div class="itemUnit">ק\"מ/לליטר';
    s += '</div>';
    s += '</div>';
    s += '<div class="lineSeperatorVer">';
    s += '</div>';
    s += '<div class="logItem left">';
    s += '<div id="LPKMLogItem" class="itemNumber">45.62';// + lpkm;
    s += '</div>';
    s += '<div class="itemUnit">ליטר/לק\"מ';
    s += '</div>';
    s += '</div>';
    s += '</div>';
    s += '<div class="logRow">';
    s += '<div class="lineSeperatorHor">';
    s += '</div>';
    s += '<button id="newItemBtn" onclick="handleNewItemBtn()"><img src="_images/fuel.png" /></button>';
    s += '<div class="lineSeperatorHor">';
    s += '</div>';
    s += '</div>';
    s += '<div class="logRow">';
    s += '<div class="logItem right">';
    s += '<div id="drivingCostLogItem" class="itemNumber">40.85';// + avg100KmCost;
    s += '</div>';
    s += '<div class="itemUnit">&#8362;/100 ק\"מ';
    s += '</div>';
    s += '</div>';
    s += '<div class="lineSeperatorVer">';
    s += '</div>';
    s += '<div class="logItem left">';
    s += '<div id="literCostLogItem" class="itemNumber">6.15&#8199;';// + avgCostLiter;
    s += '</div>';
    s += '<div class="itemUnit">&#8362;/לליטר';
    s += '</div>';
    s += '</div>';
    s += '</div>';

    s+='<div class="infoRow">';
    s+='<p>תדלוק אחרון:</p>';
    s+='<div class="infoItem"><span id="lastMileageSpan">400</span><sub>ק\"מ</sub>';
    s += '</div>';
    s+='<div class="smallLineSeperator">';
    s+='</div>';
    s+='<div class="infoItem"><span id="lastLiterSpan">25</span><sub>ליטר</sub>';
    s += '</div>';
    s+='<div class="smallLineSeperator">';
    s+='</div>';
    s+='<div class="infoItem"><span id="lastPriceSpan">150</span><sub>&#8362;</sub>';
    s += '</div>';
    s += '</div>';

    s+='<div class="infoRow">';
    s+='<p>סה\"כ:</p>';
    s+='<div class="infoItem"><img src="_images/mileage.png" /><span id="sumMileageSpan">50,123</span><sub>ק\"מ</sub>';
    s += '</div>';
    s+='<div class="smallLineSeperator">';
    s+='</div>';
    s+='<div class="infoItem"><img src="_images/fuel.png" /><span id="sumLiterSpan">2,123</span><sub>ליטר</sub>';
    s += '</div>';
    s+='<div class="smallLineSeperator">';
    s+='</div>';
    s+='<div class="infoItem"><img src="_images/money.png" /><span id="sumCostSpan">20,201</span><sub>&#8362;</sub>';
    s += '</div>';
    s += '</div>';

    s += '</div>';
    $('#pageContainer').html(s);
    $('#landingPageDiv').toggle(1000);
    setLastMileage();
    setAvgStats();
}

function setAvgStats() {
    kmpl = $('#carSelect').val() == 'Picanto' ? picantoKMPL : demioKMPL;
    lpkm = $('#carSelect').val() == 'Picanto' ? picantoLPKM : demioLPKM;
    deltaMileage = $('#carSelect').val() == 'Picanto' ? picantoDeltaMileage : demioDeltaMileage;
    sumLiter = $('#carSelect').val() == 'Picanto' ? picantoSumLiter : demioSumLiter;
    sumPrice = $('#carSelect').val() == 'Picanto' ? picantoSumPrice : demioSumPrice;
    avgCostLiter = $('#carSelect').val() == 'Picanto' ? picantoAvgCostLiter : demioAvgCostLiter;
    avg100KmCost = deltaMileage == 0 ? 0 : 100 * sumPrice / deltaMileage;
    lastDeltaMileage = $('#carSelect').val() == 'Picanto' ? picantoLastDeltaMileage : demioLastDeltaMileage;
    lastLiter = $('#carSelect').val() == 'Picanto' ? picantoLastLiter : demioLastLiter;
    lastPrice = $('#carSelect').val() == 'Picanto' ? picantoLastPrice : demioLastPrice;
    $('#KMPLLogItem').html(kmpl.toFixed(2));
    $('#LPKMLogItem').html(lpkm.toFixed(2));
    $('#literCostLogItem').html(avgCostLiter.toFixed(2));
    $('#drivingCostLogItem').html(avg100KmCost.toFixed(2));
    $('#lastMileageSpan').html(lastDeltaMileage.toFixed(2));
    $('#lastLiterSpan').html(lastLiter.toFixed(2));
    $('#lastPriceSpan').html(lastPrice.toFixed(2));
    $('#sumMileageSpan').html(deltaMileage.toFixed(2));
    $('#sumLiterSpan').html(sumLiter.toFixed(2));
    $('#sumCostSpan').html(sumPrice.toFixed(2));
}

function handleNewItemBtn(){
    openNewItemWindow();
}

function openNewItemWindow(){
    renderNewItemPage();
}
