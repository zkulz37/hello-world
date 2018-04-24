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
	google.setOnLoadCallback(OnDraw); 
	
    System.Translate(document);
    //------------------
    BindingDataList();
	OnSearch('DATA');
    
    OnToggle(imgArrow1);
}

//=======================================================================
function OnDraw()
{

	//Table1.style.width="100%";		
	var l_width=Table1.offsetWidth*0.99;
	var  l_height=Table1.offsetHeight*0.95;
	if(imgArrow1.status != "expand")
        l_height=Table1.offsetHeight*0.85;

	var data = new google.visualization.DataTable();
	data.addColumn('string', 'Month');
	data.addColumn('number', '6??');
	data.addColumn({type:'string', role:'annotation'});
	data.addColumn({type:'string',role:'tooltip'});
	data.addColumn({type:'boolean',role:'certainty'}); // certainty col.
	
	data.addColumn('number', '7??');
	data.addColumn({type:'string', role:'annotation'});
	data.addColumn({type:'string',role:'tooltip'});
	data.addColumn({type:'boolean',role:'certainty'}); // certainty col.
	
	data.addRows(grd_Data.cols - 2);
	var formatter = new google.visualization.NumberFormat( { pattern: '###,###.##', negativeParens: true})
	

	for (var i=0; i<grd_Data.cols-2; i++)
	{
	   //get data for axis x				
	   var j = 0;
	   data.setValue(i,j,grd_Data.GetGridData(j,i) + "");
	   //get data for label      
	   j = 1;
	   if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
		{
			data.setValue(i,j,grd_Data.GetGridData(j,i)*1);			
			data.setValue(i,j+1,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
			data.setValue(i,j+2,'Mon ' + data.getValue(i,0) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
		}
		else
			data.setValue(i,j,null);
	   
	    if(i==grd_Data.cols-3 || i== grd_Data.cols-4)
			data.setValue(i,j+3,false);
	    else
			data.setValue(i,j+3,true);     
			
	   j = 2;
	   if(grd_Data.rows>j)
	   {
             if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
             {
                data.setValue(i,j+3,grd_Data.GetGridData(j,i)*1);
                data.setValue(i,j+4,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
                data.setValue(i,j+5,'Mon ' + data.getValue(i,0) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
             }
            else
                data.setValue(i,j+3,null);
	        if(i==grd_Data.cols-3 || i== grd_Data.cols-4)
		        data.setValue(i,j+6,false);
	       else
		        data.setValue(i,j+6,true);
		}
	}
	

	chart_div.innerHTML = ""; 
	var chart = new google.visualization.LineChart(document.getElementById('chart_div'));	

	chart.draw(data, {
					curveType: "none",
					width: l_width, 
					height: l_height, 
					legend:{position:'left',alignment:'end'}, 
					title: '            Product Inventory amount by Cost Center',
					titleTextStyle:{fontSize:24},
					vAxis: {
							 title: "                                                                                                                        Qty", 
							 format:'#,###.##',
							 gridlines:{count:10},
							 showTextEvery:2
							},
					hAxis: {title: "                                                                                                                                                                                                  Month"
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
	lst_WH_Mon_Prod.SetDataText( data );
    	
}

//=======================================================================
function OnSearch(pos)
{
	switch ( pos )
	{
	    case 'DATA':
		var l_year = dt_Mon_Mon_Prod_From.value;
	        var l_PrvYear =  l_year  - 1;
	        var l_PrvYear1 =  l_year  - 2;
	        for(var i=10; i<=12;i++)
	        {
	            if (i <10)
	                grd_Data.SetGridText(0,i-10,l_PrvYear1.toString().substr(2,2) + "/0" + i);
	            else
	                grd_Data.SetGridText(0,i-10,l_PrvYear1.toString().substr(2,2) + "/" + i);
	        }
	        
	        for(var i=1; i<=12;i++)
	        {
	            if (i <10)
	                grd_Data.SetGridText(0,i + 2,l_PrvYear.toString().substr(2,2) + "/0" + i);
	            else
	                grd_Data.SetGridText(0,i + 2,l_PrvYear.toString().substr(2,2) + "/" + i);
	        }
	        
	        for(var i=1; i<=7;i++)
	        {
	            if(i<10)
	                grd_Data.SetGridText(0,14 + i,l_year.substr(2,2) + "/0"+ i);
	            else
	                grd_Data.SetGridText(0,14 + i,l_year.substr(2,2) + "/"+ i);
	        }
		       
            	data_kbch00040.Call('SELECT');            
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
	    case 'data_kbch00040' ://monthly production
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
		    grd_Data.style.height="50px";
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
    <gw:data id="data_kbch00040" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00040"> 
			    <input bind="grd_Data" > 
			        <input bind="lst_WH_Mon_Prod" />			
			        <input bind="dt_Mon_Mon_Prod_From" />
			        <input bind="dt_Mon_Mon_Prod_To" />
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
                            W/H
                        </td>
                        <td style="width: 30%;" align="left">
                            <gw:list id="lst_WH_Mon_Prod" style="width: 100%;" />
                        </td>
                        <td style="width: 5%;" align="right">
                            Month
                        </td>
                        <td style="width: 20%; white-space: nowrap;" align="left">
                            <gw:datebox id="dt_Mon_Mon_Prod_From" type="month" lang="<%=session("lang")%>" />
                            ~
                            <gw:datebox id="dt_Mon_Mon_Prod_To" type="month" lang="<%=session("lang")%>" />
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
        </tr>
        <tr id="tr_1" style="height: 9%;">
            <td>
                <table id="tbl_Grid" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;">
                    <tr>
                        <td>
                            <gw:grid id='grd_Data' header='10.10|11|12|11.1|2|3|4|5|6|7|8|9|10|11|12|12.1|2|3|4|5|6|7|-'
                                format='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0' aligns='2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|2|0'
                                check='||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' />
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
                            <div id="chart_div">
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
