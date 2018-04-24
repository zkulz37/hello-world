<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>27.Wip Stock</title>

    <script type="text/javascript" src="../../tutorial/google_control/jsapi.js"></script>

</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    google.load("visualization", "1", { packages: ['corechart'] });

    //----------grdProcess-----
    var G1_DATE = 0,
    G1_AGV = 1,
    G1_MON_01 = 2,
    G1_MON_02 = 3,
    G1_MON_03 = 4,
    G1_MON_04 = 5,
    G1_MON_05 = 6,
    G1_MON_06 = 7,
    G1_MON_07 = 8,
	G1_MON_08 = 9,
	G1_MON_09 = 10,
	G1_MON_10 = 11,
	G1_MON_11 = 12,
	G1_MON_12 = 13;
    //---------------

    //=======================================================================
    function BodyInit() {
        google.setOnLoadCallback(OnDraw);
        System.Translate(document);

        //------------------
        BindingDataList();

        OnSearch('DATA');
        OnToggle(imgArrow1);
    }


    //=======================================================================
    function OnDraw() {
        //tbl_1.style.width="100%";
        var l_width = Table1.offsetWidth * 0.99;
        var l_height = Table1.offsetHeight * 0.90;

        if (imgArrow1.status != "expand")
            l_height = Table1.offsetHeight * 0.88;

        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Month');
        for (var i = 1; i < grd_Data.rows; i++) {
            data.addColumn('number', grd_Data.GetGridData(i, 0));
            data.addColumn({ type: 'string', role: 'annotation' });
            data.addColumn({ type: 'string', role: 'tooltip' });
        }

        data.addRows(grd_Data.cols - 2);
        var formatter = new google.visualization.NumberFormat({ pattern: '###,###.##', negativeParens: true })

        for (var i = 1; i < grd_Data.cols - 2; i++) {
            for (var j = 0; j < grd_Data.rows; j++) {
                if (j == 0) {
                    data.setValue(i - 1, j, grd_Data.GetGridData(0, i).substr(4, 2) + "");
                }
                else
                    if (typeof (grd_Data.GetGridData(j, i)) !== 'undefined' && grd_Data.GetGridData(j, i) != null && grd_Data.GetGridData(j, i) != "") {
                    if (j == 1) {
                        data.setValue(i - 1, j, grd_Data.GetGridData(j, i) * 1);
                        data.setValue(i - 1, j + 1, formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                        data.setValue(i - 1, j + 2, grd_Data.GetGridData(0, i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                    }
                    if (j == 2) {
                        data.setValue(i - 1, j + 2, grd_Data.GetGridData(j, i) * 1);
                        data.setValue(i - 1, j + 3, formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                        data.setValue(i - 1, j + 4, grd_Data.GetGridData(0, i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                    }
                    if (j == 3) {
                        data.setValue(i - 1, j + 4, grd_Data.GetGridData(j, i) * 1);
                        data.setValue(i - 1, j + 5, formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                        data.setValue(i - 1, j + 6, grd_Data.GetGridData(0, i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j, i) * 1));
                    }
                }
                else
                    data.setValue(i - 1, j, null);
            }
        }


        chart_div.innerHTML = "";
        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, {
            curveType: "none",
            width: l_width,
            height: l_height,
            legend: { position: 'top', alignment: 'end' },
            title: '                                     Wip Stock',
            titleTextStyle: { fontSize: 24 },
            vAxis: {
                title: "                                                                                                                   Qty",
                format: '#,###.##',
                gridlines: { count: 10 },
                showTextEvery: 2
            },
            hAxis: { title: "                                                                                                                                                                                                   Month"
            },
            pointSize: 5,
            interpolateNulls: false
        }
					);

    }

    //=======================================================================
    function BindingDataList() {
        var ctrl = grd_Data.GetGridControl();
        ctrl.ColFormat(G1_MON_01) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_02) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_03) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_04) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_05) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_06) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_07) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_08) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_09) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_10) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_11) = "###,###,###.##";
        ctrl.ColFormat(G1_MON_12) = "###,###,###.##";



    }

    //=======================================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'DATA':

                data_kbch00080.Call('SELECT');

                break;
        }
    }

    //=======================================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case 'data_kbch00080': //monthly production
                if (grd_Data.rows < 2) {
                    chart_div.innerHTML = "No Data";
                }
                else {
                    OnDraw();
                }
                break;

        }
    }

    //=======================================================================


    function OnToggle(obj) {
        if (obj.status == "expand") {
            obj.status = "collapse";
            obj.src = "../../../system/images/down.gif";

            tr_1.style.height = "9%";
            tr_2.style.height = "90%";
            grd_Data.style.display = "";
            grd_Data.style.height = "80px";
        }
        else if (obj.status == "collapse") {

            obj.status = "expand";
            obj.src = "../../../system/images/up.gif";

            grd_Data.style.display = "none";
            grd_Data.style.height = "0%";
            tr_1.style.height = "0%";
            tr_2.style.height = "99%";
        }
        if (grd_Data.rows < 2) {
            chart_div.innerHTML = "No Data";
        }
        else
            OnDraw();
    }

</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="data_kbch00080" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00080"> 
			    <input bind="grdProcess" > 
			        <input bind="dt_year" />			
			    </input> 
			    <output bind="grd_Data" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------>
    <table id="tbl_1" name="tbl_1" style="width: 100%; height: 100%;" cellpadding="0"
        cellspacing="0">
        <tr style="height: 1%;">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 5%;" align="right">
                            Year
                        </td>
                        <td style="width: 10%; white-space: nowrap;" align="left">
                            <gw:datebox id="dt_year" type="year" lang="<%=session("lang")%>" />
                        </td>
                        <td style="width: 2%;" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('DATA')" />
                        </td>
                        <td style="width: 83%" align="right">
                        </td>
                        <td style="width: 1%">
                            <img status="collapse" id="imgArrow1" src="../../../system/images/down.gif" alt="Show Chart data"
                                style="cursor: hand" onclick="OnToggle(imgArrow1)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="tr_1" style="height: 9%;">
            <td>
                <table id="tbl_Grid" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
                    <tr>
                        <td>
                            <gw:grid id='grd_Data' header='Year|Mon 01|Mon 02|Mon 03|Mon 04|Mon 05|Mon 06|Mon 07|Mon 08|Mon 09|Mon 10|Mon 11|Mon 12|'
                                format='0|1|1|1|1|1|1|1|1|1|1|1|1|1' aligns='1|3|3|3|3|3|3|3|3|3|3|3|3|3' check='|||||||||||||'
                                editcol='0|0|0|0|0|1|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:80px' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="tr_2" style="height: 90%">
            <td colspan="2">
                <table id="Table1" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                    border="1">
                    <tr>
                        <td>
                            <div id="chart_div" >
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <!----------------------------------------------------------->
</body>
</html>