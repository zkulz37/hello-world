<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Daily Product Delivery</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>  
//===============================================================
function BodyInit()
{
    txtCnt2.SetEnable(false);
    txtCnt.SetEnable(false);
}
//===============================================================
function OnDataReceive(obj)
{
//    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00170.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00170&parameter=" + txtBatchNo.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;                            
//	System.OpenTargetPage(url); 
}
function OnCancel()
{
    data_shcl00020_1.Call();
}
//----------------------------------------------------------------
function OnExecute()
{
    data_shcl00020.Call();
}
//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00070.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00070|prod.sp_rpt_shpp00070_1&parameter=" + lstCompany.value + "," + dtFromDate.value + "," + dtToDate.value  +"|"+ lstCompany.value+ "," + dtFromDate.value + "," + dtToDate.value ;                            
	System.OpenTargetPage(url);
}
 
//===============================================================
</script>

<body>
     <!----------------------------------------------------------------------------->
    <gw:data id="data_shcl00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="inv.sp_PROD_shcl00020_ex" > 
                <input>   
                    <input bind="dtPeriod" />
                 </input> 
                <output>
                    <output bind="txtCnt" />
                    <output bind="txtCnt2" />
                    <output bind="txtCnt4" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="data_shcl00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="inv.sp_TRANS_DELETE_shcl00020" > 
                <input>   
                    <input bind="dtPeriod" />
                 </input> 
                <output>
                   <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    
    
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 100%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 50%" >
                                 <table width="100%" cellpadding="1" cellspacing="2" border="0">                          
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Period
                                        </td>
                                        <td style="width: 30%" align="left" >
                                            <gw:datebox id="dtPeriod" lang="1" type="month" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            <b>Completed Data(Lot)</b>
                                        </td>
                                        <td style="width: 30%" align="left"  >
                                            <gw:textbox id="txtCnt" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            <b>Completed Data(Raw Matl.)</b>
                                        </td>
                                        <td style="width: 30%" align="left"  >
                                            <gw:textbox id="txtCnt2" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            <gw:button id="btnExe"  text="Gelatin (Execution)" onclick="OnExecute()" />
                                        </td>
                                        <td style="width: 30%" align="left"  >
                                            <gw:button id="btnExeCa" text="Gelatin (Cancellation)" img="1" alt="open" onclick="OnCancel()" />
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
    <gw:textbox id="txtReturnValue" style="display: none" />
     <gw:textbox id="txtCnt4" lang="1" styles="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
