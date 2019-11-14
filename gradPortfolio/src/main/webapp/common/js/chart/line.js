am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart = am4core.create("line", am4charts.XYChart);

// Increase contrast by taking evey second color
chart.colors.step = 2;

// Add data
chart.data = lineData;

// Create axes
var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.minGridDistance = 50;

// Create series
function createAxisAndSeries(field, name, opposite, bullet) {
  var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
  
  var series = chart.series.push(new am4charts.LineSeries());
  series.dataFields.valueY = field;
  series.dataFields.dateX = "date";
  series.strokeWidth = 2;
  series.yAxis = valueAxis;
  series.name = name;
  series.tooltipText = "{name}: [bold]{valueY}[/]";
  series.tensionX = 0.8;
  
  var interfaceColors = new am4core.InterfaceColorSet();
  
  switch(bullet) {
    case "triangle":
      var bullet = series.bullets.push(new am4charts.Bullet());
      bullet.width = 12;
      bullet.height = 12;
      bullet.horizontalCenter = "middle";
      bullet.verticalCenter = "middle";
      var triangle = bullet.createChild(am4core.Triangle);
      triangle.stroke = interfaceColors.getFor("background");
      triangle.strokeWidth = 2;
      triangle.direction = "top";
      triangle.width = 12;
      triangle.height = 12;
      
      series.fill = am4core.color("#6771dc");
      series.stroke = am4core.color("#6771dc");
      break;
    case "rectangle":
      var bullet = series.bullets.push(new am4charts.Bullet());
      bullet.width = 10;
      bullet.height = 10;
      bullet.horizontalCenter = "middle";
      bullet.verticalCenter = "middle";
      
      var rectangle = bullet.createChild(am4core.Rectangle);
      rectangle.stroke = interfaceColors.getFor("background");
      rectangle.strokeWidth = 2;
      rectangle.width = 10;
      rectangle.height = 10;
      
      series.fill = am4core.color("#a367dc");
      series.stroke = am4core.color("#a367dc");
      break;
    default:
      var bullet = series.bullets.push(new am4charts.CircleBullet());
      bullet.circle.stroke = interfaceColors.getFor("background");
      bullet.circle.strokeWidth = 2;
      
      series.fill = am4core.color("#67b7dc");
      series.stroke = am4core.color("#67b7dc");
      break;
  }
  
  valueAxis.renderer.line.strokeOpacity = 1;
  valueAxis.renderer.line.strokeWidth = 2;
  valueAxis.renderer.line.stroke = series.stroke;
  valueAxis.renderer.labels.template.fill = series.stroke;
  valueAxis.renderer.opposite = opposite;
  valueAxis.renderer.grid.template.disabled = true;
}

createAxisAndSeries("dog", "강아지", false, "circle");
createAxisAndSeries("cat", "고양이", true, "rectangle");
createAxisAndSeries("etc", "기타", true, "triangle");

// Add legend
chart.legend = new am4charts.Legend();

// Add cursor
chart.cursor = new am4charts.XYCursor();

}); // end am4core.ready()
