<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Colorant Batch No.Register</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       

    var G1_PROD_qty        = 6;
 //---------------------------------------------------------
 function BodyInit()
 {
    var d = new Date();
     FormatGrid();
     dtFrom.SetDataText(System.AddDate(dtTo.GetData(), (1+(-1)*(d.getDate()))));
     datshbo00240.Call();
 }
 //---------------------------------------------------------
 function OnSearch()
 {      
      data_shbo00240_1.Call('SELECT');
 }
//----------------------------------------------------------
 function OnDataReceive(obj)
 {
    
 }
//----------------------------------------------------------
function OnChangeClass()
{
    grdSearch.ClearData();
    datshbo00240.Call();
} 
//----------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      
      trl = grdSearch.GetGridControl();
      trl.ColFormat(G1_PROD_qty )         = "###,###,###,##0";
 }
//---------------------------------------------------------
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00130.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shbo00130&parameter=" + dtFrom.value + "," + dtTo.value ;              
	System.OpenTargetPage(url); 
}
//------------------------------------------------------------------------------
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="datshbo00240" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_shbo00240" > 
                <input> 
                    <input bind="rdoSTATUS" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input>
	           <output>
	                <output bind="lstMachineNo" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_shbo00240_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid"  function="prod.sp_sel_shbo00240_1">
                <input bind="grdSearch" >
                    <input bind="rdoSTATUS" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstMachineNo" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 10%" align="right">
                Class &nbsp;
            </td>
            <td style="width: 25%" >
                <gw:radio id="rdoSTATUS" value="1" styles='height:22' onchange="OnChangeClass()" >
					<span value="1">Norm</span>
					<span value="2">BOX</span>
				</gw:radio >
            </td>
            <td style="width: 25%; white-space: nowrap" align="right">
                <b>Instructed Period</b>
            </td>
            <td style="width: 15%; white-space: nowrap" align="right">
                <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnChangeClass()" />
                ~
                <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="OnChangeClass()"/>
            </td>
            <td style="width: 20%" align="right">
            </td>  
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
            </td>
        </tr>
        <tr style="height: 2%">
            <td style="width: 10%; white-space: nowrap" align="right">
                Machine No.
            </td>
            <td style="width: 25%" >
               <gw:list id="lstMachineNo" styles='width:100%' onchange="OnSearch()"/>
            </td>
            <td style="width: 25%; white-space: nowrap" align="right">
            </td>
            <td style="width: 15%; white-space: nowrap" align="right">
            </td>
            <td style="width: 20%" align="right">
            </td>  
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
            </td>
        </tr>
        <tr style="height: 88%">
            <td colspan="7">
                <gw:grid id='grdSearch'
                    header='Issue No|Issue Date|MFG Date|Prod Name|Lotno|Customer Name|Prod. Qty'
                    format='0|4|4|0|0|0|0' aligns='0|0|0|0|0|0|3' check='||||||' editcol='0|0|0|0|0|0|0'
                    widths='1200|1200|1200|2300|1600|2500|1500' sorting='T' styles='width:100%; height:100%'
                />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
</html>
