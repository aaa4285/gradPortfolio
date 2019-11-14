	am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		// Create chart instance
		var chart = am4core.create("barchart", am4charts.XYChart);

		// Add data
		chart.data = barData;

		// Create axes
		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "date";
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
			series.dataFields.categoryX = "date";
			series.name = name;
			series.columns.template.tooltipText = "{name}: [bold]{valueY}[/]";
			series.stacked = stacked;
			series.columns.template.width = am4core.percent(95);
			// 멍이
			switch (field) {
				case "dog":
					//series.fill = am4core.color("#67b7dc");
					//series.stroke = am4core.color("#67b7dc");
					break;
				case "cat":
					//series.fill = am4core.color("#a367dc");
					//series.stroke = am4core.color("#a367dc");
					break;
				case "etc":
					//series.fill = am4core.color("#6771dc");
					//series.stroke = am4core.color("#6771dc");
					break;
			}
			
		}
		
		createSeries("dog", "강아지", false);
		createSeries("cat", "고양이", true);
		createSeries("etc", "기타", true);

		// Add legend
		chart.legend = new am4charts.Legend();

	}); // end am4core.ready()