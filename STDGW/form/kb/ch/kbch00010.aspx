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
	OnSearch('DATA');
	google.setOnLoadCallback(OnDraw); 
	
	OnToggle(imgArrow1);
}

//=======================================================================
function OnDraw()
{
    var l_ChartTitle ="                                Spinning Result";
    var l_ChartXTitle ="                                                                                                        g";
    var l_ChartYTitle ="                                                                                                                                                                                                Month";

    if (lst_ChartType.value == '2' )
    {
        l_ChartTitle ="                                Average yam (count)";
        l_ChartXTitle ="                                                                                                        'S";
    }
	//tbl_1.style.width="100%";		
	var l_width=Table1.offsetWidth*0.99;
	var  l_height=Table1.offsetHeight*0.95;
	
	if(imgArrow1.status != "expand")
        l_height=Table1.offsetHeight*0.88;

	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Month');
	data.addColumn('number', 'data');
	data.addColumn({type:'string', role:'annotation'});
	data.addColumn({type:'string', role:'tooltip'});
	
	data.addRows(grd_Data.cols - 2);
	
	var formatter = new google.visualization.NumberFormat( { pattern: '###,###.##', negativeParens: true})
	
	for (var i=1; i<grd_Data.cols-2; i++)
	{				
		var j = 0;
		data.setValue(i-1,j,grd_Data.GetGridData(j,i) + "");
		j = 1;
		 if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
		 {
			data.setValue(i-1,j,grd_Data.GetGridData(j,i)*1);
			data.setValue(i-1,j+1,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
			data.setValue(i-1,j+2, grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
		 }
		else
			data.setValue(i-1,j,null);
	}
	
	chart_div.innerHTML = ""; 
	var chart = new google.visualization.LineChart(document.getElementById('chart_div'));	

	chart.draw(data, {
						curveType: "none",
						width: l_width, 
						height: l_height, 
						legend:{position:'none',alignment:'end'}, 
						title: l_ChartTitle,
						titleTextStyle:{fontSize:24},
						vAxis: {
								 title: l_ChartXTitle, 
								 format:'#,###.##',
								 gridlines:{count:10},
								 showTextEvery:2
								},
						hAxis: {title: l_ChartYTitle
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
	
	data = "<%=ESysLib.SetListDataSQL("SELECT   a.pk, a.wh_id  || ' * ' || a.wh_name FROM tlg_in_warehouse a WHERE a.del_if = 0 AND a.use_yn = 'Y' ORDER BY a.wh_id")%>";
	lst_WH_Mon_Prod.SetDataText( data + "|| Select All");
    lst_WH_Mon_Prod.value = '';
    
    data = "DATA|1|Daily spinning capacity|2|Average yam (count)";
    lst_ChartType.SetDataText( data );
    	
}

//=======================================================================
function OnSearch(pos)
{
	switch ( pos )
	{
	    case 'DATA':	
	        var l_year = dt_Mon_Mon_Prod_From.value;
	        var l_PrvYear =  l_year  - 1;
	        for(var i=9; i<=12;i++)
	        {
	            if (i <10)
	                grd_Data.SetGridText(0,i-8,l_PrvYear.toString().substr(2,2) + "/0" + i);
	            else
	                grd_Data.SetGridText(0,i-8,l_PrvYear.toString().substr(2,2) + "/" + i);
	        }
	        
	        for(var i=1; i<=6;i++)
	        {
	            if(i<10)
	                grd_Data.SetGridText(0,4 + i,l_year.substr(2,2) + "/0"+ i);
	            else
	                grd_Data.SetGridText(0,4 + i,l_year.substr(2,2) + "/"+ i);
	        }
	            
            data_kbch00010.Call('SELECT');            
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
	    case 'data_kbch00010' ://monthly production
	        if(grd_Data.rows<2)
		    {
			    chart_div.innerHTML = "No Data";
		    }
		    else
		    {
			    OnDraw();
		    }	
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
		    grd_Data.style.height="38px";
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


</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="data_kbch00010" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00010"> 
			    <input bind="grdProcess" > 
			        <input bind="lst_WH_Mon_Prod" />			
			        <input bind="dt_Mon_Mon_Prod_From" />
			        <input bind="lst_ChartType" />
			    </input> 
			    <output bind="grd_Data" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!----------------------------------------------------------------
   
    <!------------------------------------------------------------------------------>
    <table id="tbl_1"  style="width: 100%; height: 100%;" cellpadding="0"
        cellspacing="0">
        <tr style="height: 1%;">
            <td>
                <table id="tbl_Header" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 5%;" align="right">
                            
                        </td>
                        <td style="width: 35%;" align="left">
                            <gw:list id="lst_WH_Mon_Prod" style="width: 100%;display:none;" />
                        </td>
                        <td style="width: 5%;" align="right">
                            Year
                        </td>
                        <td style="width: 10%; white-space: nowrap;" align="left">
                            <gw:datebox id="dt_Mon_Mon_Prod_From" type="year" lang="<%=session("lang")%>" />
                        </td>
                        <td style="width: 5%" align="right">
                        Type
                        </td>
                        <td style="width: 20%" >
                        <gw:list id="lst_ChartType" style="width: 100%;" />
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
                            <gw:grid id='grd_Data' 
                                header='_조업성적|09|10|11|12上|1월|2월|3월|4월|5월|6월|' 
                                format='0|1|1|1|1|1|1|1|1|1|1'
                                aligns='1|3|3|3|3|3|3|3|3|3|3' 
                                check='||||||||||' 
                                editcol='0|0|0|0|0|0|1|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' 
                                sorting='T'
                                autosize='T'
                                styles='width:100%; height:100%' />
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
    <!----------------------------------------------------------->
</body>
</html>