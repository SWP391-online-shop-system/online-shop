// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';
var dateList1_real;
var dateList2_real;
var dateList3_real;
var dateList4_real;
var dateList5_real;
var dateList6_real;
var dateList7_real;
var dateList1_real;

var dataSold1;
var dataSold2;
var dataSold3;
var dataSold4;
var dataSold5;
var dataSold6;
var dataSold7;

function number_format(number, decimals, dec_point, thousands_sep) {
    // *     example: number_format(1234.56, 2, ',', ' ');
    // *     return: '1 234,56'
    number = (number + '').replace(',', '').replace(' ', '');
    var n = !isFinite(+number) ? 0 : +number,
            prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
            sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
            dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
            s = '',
            toFixedFix = function (n, prec) {
                var k = Math.pow(10, prec);
                return '' + Math.round(n * k) / k;
            };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
        s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
        s[1] = s[1] || '';
        s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
}

function autoUpdateWeekTo(weekFrom) {
    // Convert the weekFrom string to a Date object 
    const weekFromDate = new Date(weekFrom);
    // Add 7 days to the weekFrom date to get the weekTo date 
    const weekToDate = new Date(weekFromDate.getTime() + 6 * 24 * 60 * 60 * 1000);
    // Convert the weekTo date back to a string 
    const weekToString = weekToDate.toISOString().split('T')[0];
    // Set the value of the weekTo input tag to the weekToString 
    document.querySelector('input[name="weekTo"]').value = weekToString;
    // Display all the dates between weekFrom and weekTo in separate <p> tags with unique IDs 
    const dateList = document.getElementById('dateList');
    dateList.innerHTML = '';
    const currentDate = new Date(weekFromDate.getTime());
    let counter = 1;
    while (currentDate <= weekToDate) {
        const dateString = currentDate.toISOString().split('T')[0];
        const dateElement = document.createElement('p');
        dateElement.innerHTML = dateString;
        dateElement.id = 'dateList' + counter;
        dateList.appendChild(dateElement);
        currentDate.setDate(currentDate.getDate() + 1);
        counter++;
    }
    dateList1_real = document.getElementById("dateList1").innerHTML.substring(5, 10).replace("-", "/");
    dateList2_real = document.getElementById("dateList2").innerHTML.substring(5, 10).replace("-", "/");
    dateList3_real = document.getElementById("dateList3").innerHTML.substring(5, 10).replace("-", "/");
    dateList4_real = document.getElementById("dateList4").innerHTML.substring(5, 10).replace("-", "/");
    dateList5_real = document.getElementById("dateList5").innerHTML.substring(5, 10).replace("-", "/");
    dateList6_real = document.getElementById("dateList6").innerHTML.substring(5, 10).replace("-", "/");
    dateList7_real = document.getElementById("dateList7").innerHTML.substring(5, 10).replace("-", "/");
    dataSold1 = document.getElementById("DataSold1");
    dataSold2 = document.getElementById("DataSold2");
    dataSold3 = document.getElementById("DataSold3");
    dataSold4 = document.getElementById("DataSold4");
    dataSold5 = document.getElementById("DataSold5");
    dataSold6 = document.getElementById("DataSold6");
    dataSold7 = document.getElementById("DataSold7");
    if (dataSold1 === null) {
        dataSold1 = 0;
    } else {
        dataSold1 = dataSold1.innerHTML;
    }
    if (dataSold2 === null) {
        dataSold2 = 0;
    } else {
        dataSold2 = dataSold2.innerHTML;
    }
    if (dataSold3 === null) {
        dataSold3 = 0;
    } else {
        dataSold3 = dataSold3.innerHTML;
    }
    if (dataSold4 === null) {
        dataSold4 = 0;
    } else {
        dataSold4 = dataSold4.innerHTML;
    }
    if (dataSold5 === null) {
        dataSold5 = 0;
    } else {
        dataSold5 = dataSold5.innerHTML;
    }
    if (dataSold6 === null) {
        dataSold6 = 0;
    } else {
        dataSold6 = dataSold6.innerHTML;
    }
    if (dataSold7 === null) {
        dataSold7 = 0;
    } else {
        dataSold7 = dataSold7.innerHTML;
    }
    drawChart();
}
autoUpdateWeekTo(document.getElementById("dateInputFrom").value);
function updateWeekTo(weekFrom) {
    realWeek = weekFrom;
    console.log("weekFrom = " + weekFrom);
    // Convert the weekFrom string to a Date object 
    const weekFromDate = new Date(weekFrom);
    // Add 7 days to the weekFrom date to get the weekTo date 
    const weekToDate = new Date(weekFromDate.getTime() + 6 * 24 * 60 * 60 * 1000);
    // Convert the weekTo date back to a string 
    const weekToString = weekToDate.toISOString().split('T')[0];
    // Set the value of the weekTo input tag to the weekToString 
    document.querySelector('input[name="weekTo"]').value = weekToString;
    // Display all the dates between weekFrom and weekTo in separate <p> tags with unique IDs 
    const dateList = document.getElementById('dateList');
    dateList.innerHTML = '';
    const currentDate = new Date(weekFromDate.getTime());
    let counter = 1;
    while (currentDate <= weekToDate) {
        const dateString = currentDate.toISOString().split('T')[0];
        const dateElement = document.createElement('p');
        dateElement.innerHTML = dateString;
        dateElement.id = 'dateList' + counter;
        dateList.appendChild(dateElement);
        currentDate.setDate(currentDate.getDate() + 1);
        counter++;
    }
    drawChart();
}

function drawChart() {
    var ctx = document.getElementById("myAreaChart");
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [dateList1_real,
                dateList2_real,
                dateList3_real,
                dateList4_real,
                dateList5_real,
                dateList6_real,
                dateList7_real],
            datasets: [{
                    label: "Earnings",
                    lineTension: 0.3,
                    backgroundColor: "rgba(78, 115, 223, 0.5)",
                    borderColor: "rgba(78, 115, 223, 1)",
                    pointRadius: 3,
                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointBorderColor: "rgba(78, 115, 223, 1)",
                    pointHoverRadius: 3,
                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                    pointHitRadius: 10,
                    pointBorderWidth: 2,
                    data: [dataSold1, dataSold2, dataSold3, dataSold4, dataSold5, dataSold6, dataSold7],
                }],
        },
        options: {
            maintainAspectRatio: false,
            layout: {
                padding: {
                    left: 10,
                    right: 25,
                    top: 25,
                    bottom: 0
                }
            },
            scales: {
                xAxes: [{
                        time: {
                            unit: 'date'
                        },
                        gridLines: {
                            display: false,
                            drawBorder: false
                        },
                        ticks: {
                            maxTicksLimit: 7
                        }
                    }],
                yAxes: [{
                        ticks: {
                            maxTicksLimit: 5,
                            padding: 10,
                            // Include a dollar sign in the ticks
                            callback: function (value, index, values) {
                                return number_format(value) + 'VND';
                            }
                        },
                        gridLines: {
                            color: "rgb(234, 236, 244)",
                            zeroLineColor: "rgb(234, 236, 244)",
                            drawBorder: false,
                            borderDash: [2],
                            zeroLineBorderDash: [2]
                        }
                    }],
            },
            legend: {
                display: false
            },
            tooltips: {
                backgroundColor: "rgb(255,255,255)",
                bodyFontColor: "#858796",
                titleMarginBottom: 10,
                titleFontColor: '#6e707e',
                titleFontSize: 14,
                borderColor: '#dddfeb',
                borderWidth: 1,
                xPadding: 15,
                yPadding: 15,
                displayColors: false,
                intersect: false,
                mode: 'index',
                caretPadding: 10,
                callbacks: {
                    label: function (tooltipItem, chart) {
                        var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                        return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + 'VND';
                    }
                }
            }
        }
    });
}

function autoUpdateWeekToUser(weekFrom) {
    // Convert the weekFrom string to a Date object
    const weekFromDate = new Date(weekFrom);
    // Add 6 days to the weekFrom date to get the weekTo date
    const weekToDate = new Date(weekFromDate.getTime() + 6 * 24 * 60 * 60 * 1000);
    // Convert the weekTo date back to a string
    const weekToString = weekToDate.toISOString().split('T')[0];
    // Set the value of the weekTo input tag to the weekToString
    document.querySelector('input[name="userWeekTo"]').value = weekToString;
    autoUpdateWeekTo(document.getElementById("dateInputFrom").value);
}