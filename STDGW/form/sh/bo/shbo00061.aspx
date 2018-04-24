<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Printing S/Tank Label</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

 var machine = "<%=Request.querystring("machineNo")%>";
var min = "<%=Request.querystring("min")%>";
var max = "<%=Request.querystring("max")%>"; 
//===============================================================
function BodyInit()
{
    txtMachine_F.text = machine;
    txtMachine_T.text = machine;
   dtFromDate.value = min;
   dtToDate.value = max;
}
//===============================================================
function SetEnableControl()
{  
               
}
//==============================================================
function BindingDataList()
{ 
   
}
//===============================================================

function OnSearch()
{  

}
//===============================================================
function OnPopUp(pos)
{
    
    
    
}
//===============================================================
function OnDelete()
{
   
}
//===============================================================
function OnNew()
{

}
//===============================================================
function OnSave()
{
    
    
}
//===============================================================
function OnClickGridMaster()
{
   
}
//===============================================================
function OnDataReceive(obj)
{
}
//===============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00061.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00061_1&parameter=" + dtFromDate.value +',' + dtToDate.value + ',' + txtMachine_F.text + ',' + txtMachine_T.text ;              
	System.OpenTargetPage(url); 
}
//===============================================================
</script>

<body>
   
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 10%">
                        <td style="width:100%" valign="top" align="right">
                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                        </td>
                    </tr>
                    <tr style="height: 80%">
                        <td valign="top" align="center">
                            <fieldset style="padding: 2; width: 80%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td style="width:25%" align="right">
                                            Machine No.
                                        </td>
                                        <td style="width:30%"  align="left" style="white-space:nowrap">
                                            <gw:textbox id="txtMachine_F"  styles="width:30%"  />
                                            ~<gw:textbox id="txtMachine_T" styles="width:30%"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:25%" align="right">
                                            Date
                                        </td>
                                        <td style="width:30%"  align="left" style="white-space:nowrap" colspan=2>
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan=3 align=center>
                                            <gw:radio id="radShipType" value="G" styles="width:100%"> 
                                                <span value="G">Gelatin </span> 
                                            </gw:radio>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
