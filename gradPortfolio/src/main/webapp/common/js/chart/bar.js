	am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		// Create chart instance
		var chart = am4core.create("barchart", am4charts.XYChart);

		// Add data
		var data = [];
		for (var i=7; i>0; i--) {
			var d = new Date().getDate()-i;
			var m = new Date().getMonth();
			var y = new Date().getFullYear();
			var date = new Date(y,m,d);
			data.push({
				year : (date.getMonth()+1)+"-"+date.getDate(),
				dog : Math.ceil(Math.random()*100),
				cat : Math.ceil(Math.random()*100),
				etc : Math.ceil(Math.random()*100)
			});
			
		}
		chart.data = data;

		// Create axes
		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "year";
		categoryAxis.title.text = "유기 현황";
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.minGridDistance = 20;
		categoryAxis.renderer.cellStartLocation = 0.1;
		categoryAxis.renderer.cellEndLocation = 0.9;

		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.min = 0;
		valueAxis.title.text = "";

		// Create series
		function createSeries(field, name, stacked) {
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.valueY = field;
			series.dataFields.categoryX = "year";
			series.name = name;
			series.columns.template.tooltipText = "{name}: [bold]{valueY}[/]";
			series.stacked = stacked;
			series.columns.template.width = am4core.percent(95);
		}
		
		createSeries("dog", "강아지", false);
		createSeries("cat", "고양이", true);
		createSeries("etc", "기타", true);

		// Add legend
		chart.legend = new am4charts.Legend();

	}); // end am4core.ready()