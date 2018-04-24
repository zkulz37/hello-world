<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>25. MR Average Yarn Count</title>

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
var G1_DATE           = 0,
    G1_AGV            = 1,
    G1_MON_01         = 2,
    G1_MON_02         = 3,
    G1_MON_03         = 4,
    G1_MON_04         = 5, 
    G1_MON_05         = 6, 
    G1_MON_06         = 7,
    G1_MON_07         = 8,
	G1_MON_08         = 9,
	G1_MON_09         = 10,
	G1_MON_10         = 11,
	G1_MON_11         = 12,
	G1_MON_12         = 13;
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
    //tbl_1.style.width="100%";		
	var l_width=Table1.offsetWidth*0.99;
	var  l_height=Table1.offsetHeight*0.95;
	
	if(imgArrow1.status != "expand")
        l_height=Table1.offsetHeight*0.75;

	
			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Month');
			data.addColumn('number', "Avg 2010");
			data.addColumn({type:'string', role:'annotation'});
			data.addColumn({type:'string', role:'tooltip'});
			data.addColumn('number', "Avg 2011");
			data.addColumn({type:'string', role:'annotation'});
			data.addColumn({type:'string', role:'tooltip'});
			data.addColumn('number', "Avg 2012");
			data.addColumn({type:'string', role:'annotation'});
			data.addColumn({type:'string', role:'tooltip'});
			for (var i=1; i<grd_Data.rows; i++)
			{
				data.addColumn('number', grd_Data.GetGridData(i,0));
				data.addColumn({type:'string', role:'annotation'});
			    data.addColumn({type:'string', role:'tooltip'});
			}
			

			data.addRows(grd_Data.cols - 1);
			var formatter = new google.visualization.NumberFormat( { pattern: '###,###.##', negativeParens: true})
			
			for (var i=1; i<grd_Data.cols-2; i++)
			{
			    if(i==1)
			    {
			        data.setValue(0,0,grd_Data.GetGridData(0,i)+ "");
			        if(typeof(grd_Data.GetGridData(1,i)) !== 'undefined' && grd_Data.GetGridData(1,i) != null && grd_Data.GetGridData(1,i) != "")
			        {
		                data.setValue(0,1,grd_Data.GetGridData(1,i)*1);
		                data.setValue(0,2,formatter.formatValue(grd_Data.GetGridData(1,i)*1));
		                data.setValue(0,3,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(1,i)*1));
		            }
		            else
		                data.setValue(0,1,null);
		            
		            if(typeof(grd_Data.GetGridData(2,i)) !== 'undefined' && grd_Data.GetGridData(2,i) != null && grd_Data.GetGridData(2,i) != "")
		            {
		                data.setValue(0,4,grd_Data.GetGridData(2,i)*1);
		                data.setValue(0,5,formatter.formatValue(grd_Data.GetGridData(2,i)*1));
		                data.setValue(0,6,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(2,i)*1));
		            }
		            else
		                data.setValue(0,4,null);
		                
		            if(typeof(grd_Data.GetGridData(3,i)) !== 'undefined' && grd_Data.GetGridData(3,i) != null && grd_Data.GetGridData(3,i) != "")
		            {
		                data.setValue(0,7,grd_Data.GetGridData(3,i)*1);
		                data.setValue(0,8,formatter.formatValue(grd_Data.GetGridData(3,i)*1));
		                data.setValue(0,9,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(3,i)*1));
		            }
		            else
		                data.setValue(0,7,null);
		                
		            //data.setValue(0,4, null);
        			//data.setValue(0,5, null);
        			//data.setValue(0,6, null);
			    }
			    else
			    {
				    for (var j=0; j<grd_Data.rows; j++)
			        {
			            if( j==0)
			            {
			                data.setValue(i,j,grd_Data.GetGridData(0,i).substr(4,2) + "");
			            }
			            else
			                if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
			                {
			                    if(j==1)
			                    {
				                    data.setValue(i,j+9,grd_Data.GetGridData(j,i)*1);
				                    data.setValue(i,j+10,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                    data.setValue(i,j+11,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                }
				                if(j==2)
				                {
				                    data.setValue(i,j+11,grd_Data.GetGridData(j,i)*1);
				                    data.setValue(i,j+12,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                    data.setValue(i,j+13,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                }
				                if(j==3)
				                {
				                    data.setValue(i,j+13,grd_Data.GetGridData(j,i)*1);
				                    data.setValue(i,j+14,formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                    data.setValue(i,j+15,grd_Data.GetGridData(0,i) + ' :: ' + formatter.formatValue(grd_Data.GetGridData(j,i)*1));
				                }
				            }
				            //else
				              //  data.setValue(i,j+3,null);
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
							title: '                     MR Average Yarn Count',
							titleTextStyle:{fontSize:24},
							vAxis: {
							         title: "                                                                                                                Qty", 
							         format:'#,###.##',
							         gridlines:{count:10},
							         showTextEvery:2
							        },
							hAxis: {title: "                                                                                                                                                                               Month"
							},
							chartArea:{width:'auto',height:'auto'},
							pointSize:5,
							interpolateNulls:false,
							series:{
							            0:{
							                visibleInLegend: false,
							                color:'#3366cc'
							              }, 
							            1:{
							                visibleInLegend: false,
							                color:'#dc3912'
							              },
							            2:{
							                visibleInLegend: false,
							                color:'#ff9900'
							              },
							            3:{color:'#3366cc'},
							            4:{color:'#dc3912'},
							            5:{color:'#ff9900'}						            
							        }
						 }
					);
 
}

//=======================================================================
function BindingDataList()
{
    var data=""; 
    
    var ctrl = grd_Data.GetGridControl();
    ctrl.ColFormat(G1_MON_01) = "###,###,###.##" ;                          
	ctrl.ColFormat(G1_MON_02) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_03) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_04) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_05) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_06) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_07) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_08) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_09) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_10) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_11) = "###,###,###.##" ;
	ctrl.ColFormat(G1_MON_12) = "###,###,###.##" ;
	
	data = "<%=ESysLib.SetListDataSQL("SELECT   a.pk, a.wh_id  || ' * ' || a.wh_name FROM tlg_in_warehouse a WHERE a.del_if = 0 AND a.use_yn = 'Y' ORDER BY a.wh_id")%>";
	lst_WH_Mon_Prod.SetDataText( data + "|| Select All");
    lst_WH_Mon_Prod.value = '223';
    lst_WH_Mon_Prod.SetEnable(false);
   
	
}

//=======================================================================
function OnSearch(pos)
{
	switch ( pos )
	{
	    case 'DATA':
	       
                data_kbch00100.Call('SELECT');
            
	  break;
	}
}

//=======================================================================
function OnDataReceive(obj)
{
	switch ( obj.id )
	{
	    case 'data_kbch00100' :
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


function OnToggle(obj)
{      
		if(obj.status == "expand")
		{			
			obj.status = "collapse";
			obj.src = "../../../system/images/down.gif"; 
			
            tr_1.style.height="9%";
            tr_2.style.height="90%";
		    grd_Data.style.display="";
		    grd_Data.style.height="80px";
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

</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="data_kbch00100" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00100"> 
			    <input bind="grdProcess" > 
			        <input bind="lst_WH_Mon_Prod" />			
			        <input bind="dt_Mon_Mon_Prod_From" />
			    </input> 
			    <output bind="grd_Data" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------>
    <table id="tbl_1" style="width: 100%; height: 100%;" cellpadding="0" cellspacing="0">
        <tr style="height: 1%;">
            <td>
                <table id="tbl_Header" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 5%;" align="right">
                            W/H
                        </td>
                        <td style="width: 25%;">
                            <gw:list id="lst_WH_Mon_Prod" style="width: 100%;" />
                        </td>
                        <td style="width: 5%;" align="right">
                            Year
                        </td>
                        <td style="width: 10%; white-space: nowrap;">
                            <gw:datebox id="dt_Mon_Mon_Prod_From" type="year" lang="<%=session("lang")%>" />
                        </td>
                        <td style="width: 1%;">
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
                            <gw:grid id='grd_Data' header='Year|Avg|Mon 01|Mon 02|Mon 03|Mon 04|Mon 05|Mon 06|Mon 07|Mon 08|Mon 09|Mon 10|Mon 11|Mon 12|'
                                format='0|1|1|1|1|1|1|1|1|1|1|1|1|1|1' aligns='1|3|3|3|3|3|3|3|3|3|3|3|3|3|3'
                                check='||||||||||||||' editcol='0|0|0|0|0|0|1|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
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
