<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>03.Monthly Ending Stock</title>

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
}

//=======================================================================
function OnDraw()
{
  tbl_1.style.width="100%";		
//if(grddata.rows>1)
//{ 
var l_width=tbl_1.offsetWidth*1;
//if(td_chart1.style.width=="80%")
//l_width=l_width*0.70;
var  l_height=tbl_1.offsetHeight*0.75;
//	if(chart_detail.style.height=="10%")
	//l_height=l_height*0.80;

			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Month');
			for (var i=1; i<grd_Data.rows; i++)
			{
				data.addColumn('number', grd_Data.GetGridData(i,0));
				data.addColumn({type:'number', role:'annotation'});
			    //data.addColumn({type:'boolean',role:'certainty'}); // certainty col
			}
//			data.addColumn('number', '6??');
//			data.addColumn({type:'number', role:'annotation'});
//			data.addColumn({type:'boolean',role:'certainty'}); // certainty col.
//			
//		    data.addColumn('number', '7??');
//			data.addColumn({type:'number', role:'annotation'});
//			
//			data.addColumn({type:'boolean',role:'certainty'}); // certainty col.
			
			data.addRows(grd_Data.cols - 2);
			
			for (var i=1; i<grd_Data.cols-2; i++)
			{
			    for (var j=0; j<grd_Data.rows; j++)
			    {
			        if( j==0)//get data for axis x
			        {
			            data.setValue(i,j,grd_Data.GetGridData(0,i) + "");
			        }
			        else
			        {
				         if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
				         {
				            data.setValue(i,j,grd_Data.GetGridData(j,i)*1);
				            data.setValue(i,j+1,grd_Data.GetGridData(j,i)*1);
				         }
				        else
				        {
				            data.setValue(i,j,null);
				            data.setValue(i,j+1,null);
				        }
				     }
				}
				
//			   //get data for axis x				
//		       var j = 0;
//		            data.setValue(i,j,grd_Data.GetGridData(j,i) + "");
//		       //get data for label      
//		       j = 1;
//	             if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
//	             {
//		            data.setValue(i,j,grd_Data.GetGridData(j,i)*1);
//		            data.setValue(i,j+1,grd_Data.GetGridData(j,i)*1);
//		         }
//		        else
//		            data.setValue(i,j,null);
//		       
//		       if(i==grd_Data.cols-3 || i== grd_Data.cols-4)
//	            data.setValue(i,j+2,false);
//	          else
//	            data.setValue(i,j+2,true);     
//		            
//			   j = 2;
//                 if(typeof(grd_Data.GetGridData(j,i)) !== 'undefined' && grd_Data.GetGridData(j,i) != null && grd_Data.GetGridData(j,i) != "")
//                 {
//	                data.setValue(i,j+2,grd_Data.GetGridData(j,i)*1);
//	                data.setValue(i,j+3,grd_Data.GetGridData(j,i)*1);
//	             }
//	            else
//	                data.setValue(i,j+2,null);
//	          if(i==grd_Data.cols-3 || i== grd_Data.cols-4)
//	            data.setValue(i,j+4,false);
//	          else
//	            data.setValue(i,j+4,true);
	            
			}
			

			chart_div.innerHTML = ""; 
		var chart = new google.visualization.LineChart(document.getElementById('chart_div'));	
		
		chart.draw(data, {
							curveType: "none",
							width: l_width, 
							height: l_height, 
							legend:{position:'top',alignment:'end'}, 
							title: '광주 월말 재고 추이',
							titleTextStyle:{fontSize:24},
							vAxis: {
							         title: "Kg", 
							         format:'#,###.##',
							         gridlines:{count:10},
							         showTextEvery:2
							        },
							hAxis: {title: "Month"},
							//tooltip:{trigger:'focus'},
							chartArea:{width:'auto',height:'auto'},
							//chartArea:{left:20,top:0,width:"50%",height:"75%"},
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
	lst_WH.SetDataText( data + "|| Select All");
    lst_WH.value = '';
    	
}

//=======================================================================
function OnSearch(pos)
{
	switch ( pos )
	{
	    case 'DATA':	        
            data_kbch00060.Call('SELECT');            
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
	    case 'data_kbch00060' ://monthly production
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

</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="data_kbch00060" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kbch00060"> 
			    <input bind="grdProcess" > 
			        <input bind="lst_WH" />			
			        <input bind="dt_year_From" />
			        <input bind="dt_year_To" />
			    </input> 
			    <output bind="grd_Data" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!----------------------------------------------------------------
   
    <!------------------------------------------------------------------------------>
    <table id="tbl_1" name="tbl_1" style="width: 100%; height: 100%">
       <tr style="height: 22%; width:50%">
            <td style="width:50%;" align:'top' >
                <table id="tbl_Header" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 5%;" align="right">
                            W/H
                        </td>
                        <td style="width: 44%;" align="left">
                            <gw:list id="lst_WH" style="width: 100%;" />
                        </td>
                        <td style="width: 5%;" align="right">
                            Month
                        </td>
                        <td style="width: 44%; white-space: nowrap;" align="left">
                            <gw:datebox id="dt_year_From" type="year" lang="<%=session("lang")%>" />
                            ~
                            <gw:datebox id="dt_year_To" type="year" lang="<%=session("lang")%>" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('DATA')" />
                        </td>
                    </tr>
                </table>
            </td>
			<td style="width:50%">
			    <gw:grid id='grd_Data'
                            header='Year|01월|2월|3월|4월|5월|6월|7월|8월|9월|10월|11월|12월|-'
                            format='0|1|1|1|1|1|1|1|1|0|1|1|1|0'
                            aligns='0|2|2|2|2|2|2|2|2|2|2|2|2|0'
                            check='|||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='T'
                            styles='width:100%; height:100%'
                    />
			</td>
        </tr>
        <tr style="height: 78%">
		
            <td colspan="2">
                <div id="chart_div" style="display:table-cell; overflow:visible;"></div>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <!----------------------------------------------------------->
</body>
</html>
