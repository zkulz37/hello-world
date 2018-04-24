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
    var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
}
//===============================================================
//function OnDataReceive(obj)
//{
//    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00170.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00170&parameter=" + txtBatchNo.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;                            
//	System.OpenTargetPage(url); 
//}
//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00190.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00190|prod.sp_rpt_shpp00190_1&parameter=" + dtDate.value + "|" +  dtDate.value;
	System.OpenTargetPage(url);
}
 //==============================================================
 function OnPopUp(obj)
{
    switch(obj)
    { 
        
    }
}
//===============================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shpp00190':
            alert(txtReturnValue.text);
        break;
    }
}
//===============================================================
function OnClosing()
{
    data_shpp00190.Call();
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpp00190" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shpp00190_1" > 
                <input>
                    <input bind="dtDate" />
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
            <td style="width: 100%" >
                <table style="height: 100%; width: 100%" border=0>
                    <tr style="height: 100%">
                        <td style="width: 100%" valign="middle" align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table style="width:100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 75%;white-space: nowrap" align="left" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            MFG Date
                                        </td>
                                        <td style="width: 5%;white-space: nowrap" align="left" >
                                            <gw:datebox id="dtDate" lang="1" />
                                        </td>
                                        <td  style="width: 70%;white-space: nowrap"  align ="left">
                                            <gw:icon id="btnClose" img="3" text="Closing" onclick="OnClosing()" />                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            <b>Product Type</b>
                                        </td>
                                        <td style="width: 3%" align="right" >
                                            <gw:checkbox id="chkProType" styles='width:100%' />
                                        </td>
                                        <td style="width: 35%">
                                            Gelatin Cap.
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
