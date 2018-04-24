<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("stm")%>
<head>

    <script type="text/javascript" src="../../tutorial/google_control/jsapi.js"></script>

    <script type="text/javascript" src="../../tutorial/google_control/areachart.js"></script>

    <script type="text/javascript" src="../../tutorial/google_control/columnchart.js"></script>

    <script type="text/javascript">

    var offset = "<%=request.QueryString("offset") %>"  ;
    var rowsDisplay = "<%=request.QueryString("rowsDisplay") %>"  ;    
    var factory_pk = "<%=request.QueryString("factory_pk") %>"  ;  
    var p_date = "<%=request.QueryString("p_date") %>"  ; 
    
    google.load("visualization", "1", {packages:["columnchart"]});
    google.setOnLoadCallback(drawChart);
   //------------------------------------------------------------------------------------>
function BodyInit(){
    
}
  function OnDataReceive(obj)
  {
   var lastViewRow = Number(offset) + (Number(rowsDisplay)-1) <= grdGrade.rows-1 ? Number(offset) + (Number(rowsDisplay)-1) : grdGrade.rows-1;
  
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'GradeName');
    for (var mon =1 ; mon<grdGrade.cols-2 ; mon ++)
    {
        data.addColumn('number',grdGrade.GetGridData(0,mon) );
    }
     //Add row
    data.addRows(Number(lastViewRow)-Number(offset)+1);
 
    var k;
    k=0;
    for(var i = offset; i<= lastViewRow ; i++ )
    {
        data.setValue(k, 0,grdGrade.GetGridData(i,0));
        for (var mon =1 ; mon<grdGrade.cols-2 ; mon ++)
        {
             data.setValue(k, mon,Number(grdGrade.GetGridData(i,mon)+"") );
        }
        k=k+1;
    }
    
    var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
    chart.draw(data, {width: 1080, height: 300, is3D: true,titleColor:'white', backgroundColor:'black', legendBackgroundColor:'black', legendTextColor:'white', title: 'Monitoring Display'});
   }
   //------------------------------------------------------------------------------------>

  function drawChart() 
  {
    chart_div.innerHTML ="";  
    txtFactory.text = factory_pk;
    txtDate.text = p_date;
    data_ippr0042.Call('SELECT')
  }
  //------------------------------------------------------------------------------------>

    </script>

</head>
<body>
    <!------------------------------------------------------------------------------------>
    <gw:data id="data_ippr0042" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="stm.sp_sel_ippr0041" > 
                <input bind="grdGrade" > 
                    <input bind="txtFactory" /> 
                    <input bind="txtDate" />
                </input> 
                <output bind="grdGrade" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%; background-color: Black">
        <tr style="height: 100%">
            <td>
                <div id="chart_div" style ="background-color:Black"> 
                </div>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtFactory" styles='width:100%;display:none' />
<gw:textbox id="txtDate" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------------>
<gw:grid id='grdGrade' header='grade_code|PLAN|REAL PLAN|ACTUAL|DEFECT|RATE(%)'
    format='0|0|0|0|0|0' aligns='0|0|0|0|0|0' defaults='|||||' editcol='1|1|1|1|1|1'
    widths='1000|1000|1000|1000|1000|1000' sorting='T' styles='width:100%; height:100%;display:none' />
<!------------------------------------------------------------------------------------>
</html>
