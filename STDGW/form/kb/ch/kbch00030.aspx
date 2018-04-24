<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Process Entry</title>

    <script type="text/javascript" src="../../tutorial/google_control/jsapi.js"></script>

</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
google.load("visualization", "1", {packages:['corechart']});
//

//----------grdProcess-----
var G1_COL0           = 0,
    G1_MON_09         = 1,
    G1_MON_10         = 2,
    G1_MON_11         = 3,
    G1_MON_12         = 4, 
    G1_MON_01         = 5, 
    G1_MON_02         = 6,
    G1_MON_03         = 7,
	G1_MON_04         = 8,
	G1_MON_05         = 9,
	G1_MON_06         = 10;
//---------------
   
//=======================================================================
function BodyInit()
{
    System.Translate(document);
    //------------------
    BindingDataList();
    
    data_kbch00030_0.Call('SELECT');   
    
    google.setOnLoadCallback(OnDraw); 
    
    OnToggle(imgArrow1);
}

//=======================================================================
function OnDraw()
{
	//Table1.style.width="100%";		
	var l_width=Table1.offsetWidth*0.99;
	var  l_height=Table1.offsetHeight*0.95;
	if(imgArrow1.status != "expand")
        l_height=Table1.offsetHeight*0.75;
        
	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Month');
	for (var i=1; i<grd_Data.rows; i++)
	{
		data.addColumn('number', grd_Data.GetGridData(i,0) + "");
		data.addColumn({type:'string', role:'annotation'});
		data.addColumn({type:'string', role:'tooltip'});
	}
	
	data.addRows(grd_Data.cols - 2);
	
	var formatter = new google.visualization.NumberFormat( { pattern: '###,###.##', negativeParens: true})
	for (var i=1; i<grd_Data.cols-2; i++)
	{				
	   	var j =0;
		data.setValue(i-1,j,grd_Data.GetGridData(j,i) + "");
		var h = 0;
		for (j=1; j<grd_Data.rows; j++)
		{
			h = h +1;

			if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
			 {
				data.setValue(i-1,h,grd_Data.GetGridData(j,i)*1);
				h = h +1;
				data.setValue(i-1,h,formatter.formatValue( grd_Data.GetGridData(j,i)*1));
				h = h +1;
				data.setValue(i-1,h,'Mon ' + grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue( grd_Data.GetGridData(j,i)*1) + "%");
			 }
			else
			 {
				data.setValue(i-1,h,null);
				h = h +2;
			 }
		}
		
		
	}
	

	chart_div.innerHTML = ""; 
	var chart = new google.visualization.LineChart(document.getElementById('chart_div'));	

	chart.draw(data, {
					curveType: "none",
					width: l_width, 
					height: l_height, 
					legend:{position:'top',alignment:'end'}, 
					title: '                                          Yield',
					titleTextStyle:{fontSize:24},
					vAxis: {
							title: "                                                                                                                %", 
							format:'#,###.00',
							gridlines:{count:10},
							showTextEvery:2
							//titleTextStyle:{color: 'black', fontName: 'tohama', fontSize: 11},
							//textStyle:{color: 'black', fontName: 'tohama', fontSize: 10}
							},
					hAxis: {title: "                                                                                                                                                                                              Month",
						//titleTextStyle:{color: 'black', fontName: 'tohama', fontSize: 11},
						//textStyle:{color: 'black', fontName: 'tohama', fontSize: 10},
						slantedTextAngle:45,
						slantedText:true
						},
					chartArea:{width:'auto',height:'auto'},
					pointSize:5,
					interpolateNulls:false
				 }
			);
}

//=======================================================================
function BindingDataList()
{
   var ctrl = grd_Data.GetGridControl();
    ctrl.ColFormat(G1_MON_01) = "###,###,###.##" ;                          
	ctrl.ColFormat(G1_MON_02) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_03) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_04) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_05) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_06) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_09) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_10) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_11) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_12) = "###,###,###.##" ;
	
	data = "<%=ESysLib.SetListDataSQL("SELECT   a.pk, a.factory_id || ' * ' || a.factory_name FROM tlg_pr_factory a WHERE a.del_if = 0 AND a.tco_company_pk =  2 ORDER BY factory_id ASC")%>";
	lst_WH_Mon_Prod.SetDataText( data + "|| Select All");
    lst_WH_Mon_Prod.value = '';
    	
}

//=======================================================================
function OnSearch(pos)
{
	switch ( pos )
	{
	    case 'DATA':
	        var dateStr = dt_Mon_Mon_Prod_From.value;
            var match = dateStr.match(/(\d{4})(\d{2})/);
            var betterDateStr = match[2] + '/' + match[1];
            var l_year = match[1] - 2;
            var date = new Date(match[1],match[2],'01');
            date.setFullYear(l_year,match[2],'01');
	    
	        for(var i=1; i<=24;i++)
	        {
	            var l_month = date.getMonth();
	            l_month = l_month + 1;
	            if( l_month < 10)
	                l_month = '0'+ l_month;
	            grd_Data.SetGridText(0,i,date.getYear().toString().substr(2,2) + "/" + l_month);
	            date.setMonth(date.getMonth(),32);
	        }
            data_kbch00030.Call('SELECT');   
	    break;
	  case "WH":
		
	  break;
	}
}


//=======================================================================
function OnDataReceive(obj)
{
	switch ( obj.id )
	{
	    case 'data_kbch00030' ://monthly production
	        if(grd_Data.rows<2)
		    {
			    //alert();
			    chart_div.innerHTML = "No Data";
		    }
		    else
		    {
			    OnDraw();
		    }
	    break;
	    case 'data_kbch00030_0':
	        OnSearch('DATA');
	    break;
    }
}

//=======================================================================


function OnToggle(obj)
{      
		if(obj.status == "expand")
		{			
			obj.status = "collapse";
			obj.src = "../../../system/images/down.gif"; 
			
            tr_1.style.height="9%";
            tr_2.style.height="90%";
		    grd_Data.style.display="";
		    grd_Data.style.height="115px";
		}
		else if(obj.status == "collapse")
		{
			
			obj.status = "expand";
			obj.src = "../../../system/images/up.gif";	
		    
		    grd_Data.style.display="none";
		    grd_Data.style.height="0%";
		    tr_1.style.height="0%";
		    tr_2.style.height="99%";
		}
		if(grd_Data.rows<2)
		{
			chart_div.innerHTML = "No Data";
		}
		else
            OnDraw();
}
//=======================================================================

function OnChangedValue()
{
    var l_selVal = dt_Mon_Mon_Prod_From.value;
    var l_LastVal = txt_MaxClosingym.text;
    if(l_selVal  <= l_LastVal)
        OnSearch('DATA');
    else
    {
        alert("This Valus selected is large more '" + l_LastVal + "' than");
        dt_Mon_Mon_Prod_From.value = l_LastVal;
    }
}

</script>

<body>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbch00030_0" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso  type="control"   parameter="0" function="<%=l_user%>lg_sel_kbch00030_0"  > 
                <inout> 
                     <inout  bind="dt_Mon_Mon_Prod_From" />
                     <inout  bind="txt_MaxClosingym" />
                 </inout>                 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <gw:data id="data_kbch00030" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00030"> 
			    <input bind="grdProcess" > 
			        <input bind="lst_WH_Mon_Prod" />			
			        <input bind="dt_Mon_Mon_Prod_From" />
			    </input> 
			    <output bind="grd_Data" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!----------------------------------------------------------------
   
    <!------------------------------------------------------------------------------>
    <table id="tbl_1" name="tbl_1" style="width: 100%; height: 100%;" cellpadding="0"
        cellspacing="0">
        <tr style="height: 1%;">
            <td>
                <table id="tbl_Header" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 5%;" align="right">
                            Factory
                        </td>
                        <td style="width: 15%;" align="left">
                            <gw:list id="lst_WH_Mon_Prod" style="width: 100%;" />
                        </td>
                        <td style="width: 5%;" align="right">
                            month
                        </td>
                        <td style="width: 10%; white-space: nowrap;" align="left">
                            <gw:datebox id="dt_Mon_Mon_Prod_From" type="month" lang="<%=session("lang")%>" onchange="OnChangedValue()" />
                        </td>
                        <td style="width: 1%" align="right">
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
                            <gw:grid id='grd_Data' header='CM|11/01|11/2|11/3|11/4|11/5|11/6|11/7|11/8|11/9|11/10|11/11|11/12|12/1|12/2|12/3|12/4|12/5|12/6|12/7|12/8|12/9|12/10|12/11|12/12|'
                                format='0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0' aligns='0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0'
                                check='|||||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:115px' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="tr_2" style="height: 90%">
            <td>
                <table id="Table1" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;"
                    border="1">
                    <tr>
                        <td>
                            <div id="chart_div" style="display: table-cell; overflow: visible;">
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_MaxClosingym" styles="width:100%;display:none;" />
    <!----------------------------------------------------------->
</body>
</html>
