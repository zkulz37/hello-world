<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Colorant Packing Instruction and Record</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

 var main_m_pk = "<%=Request.querystring("main_m_pk")%>";
  var  emp_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_id  = "<%=Session("USER_ID")%>" ; 
 var batchno="<%=Request.querystring("batchno")%>";
 var batchdes="<%=Request.querystring("batchdesc")%>";
//===============================================================
function BodyInit()
{
    txtMasterPK.text=main_m_pk;
    txtEmpPK.text = emp_pk;
    txtBatchNo.text=batchno;
    txtBatchDesc.text=batchdes;
}
//===============================================================
function OnDataReceive(obj)
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00190.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00190&parameter=" + txtBatchNo.text ;              
	System.OpenTargetPage(url); 
}
//===============================================================
function OnPrint()
{
    data_shbo00190_1.Call();
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00190_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00190" > 
                <input>
                    <input bind="txtBatchno" /> 
                    <input bind="dtIssueDate" /> 
                    <input bind="txtEmpPK" /> 
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
                            <fieldset style="padding: 2; width: 80%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Instructed Date
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Issue Date
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtIssueDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Batch No.
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtBatchNo" styles='width:100%' />
                                        </td>
                                        <td style="width: 35%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="2">
                                            <gw:textbox id="txtBatchDesc" styles='width:80%' />
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
    <gw:textbox id="txtEmpPK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
