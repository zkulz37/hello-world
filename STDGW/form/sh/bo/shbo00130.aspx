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

    var G1_batch_qty        = 3;
 //---------------------------------------------------------
 function BodyInit()
 {
    d= new Date();
      FormatGrid();
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      shbo00130.Call("SELECT");
 }
 //---------------------------------------------------------
 function OnSearch()
 {      
       shbo00130.Call("SELECT");
 }
//----------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      
      trl = grdSearch.GetGridControl();
      	
      trl.ColFormat(G1_batch_qty )         = "###,###,###,###.##0";
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
    <!------------------------------------------------------------------>
    <gw:data id="shbo00130"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shbo00130" > 
                <input bind="grdSearch" > 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 25%; white-space: nowrap" align="center">
                <b>Instructed Period</b>
            </td>
            <td style="width: 15%; white-space: nowrap" align="right">
                <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()"/>
                ~
                <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" />
                <gw:datebox id="dtTodate" lang="<%=Application("Lang")%>" mode="01" style="display: none"  />
            </td>
            <td style="width: 20%" align="right">
            </td>
            <td style="width: 30%" align="right">
            </td>
            <td style="width: 45%" align="right">
            </td>
            <td style="width: 1%" align="right">
                
            </td>
            <td style="width: 1%" align="right">
                
            </td>
            <td style="width: 1%" align="right">
               
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="OnPrint()" />
            </td>
        </tr>
        <tr style="height: 10">
            <td colspan=10></td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdSearch'
                    header='_pk|Issued Date|Enter Date|Batch No|Batch Qty|Type No|Remark' format='1|4|4|0|0|0|0'
                    aligns='1|1|1|0|3|0|0' defaults='||||||' editcol='0|0|0|0|0|0|0' 
                    widths='0|1300|1300|1500|1300|1200|1000'
                    sorting='T'
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
