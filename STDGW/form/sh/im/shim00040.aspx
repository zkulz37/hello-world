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
    if(rdGRGI.value==1)
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/im/rpt_shim00040_1.rpt&export_pdf=Y&procedure=prod.sp_rpt_shim00040_1&parameter=" + txtCustomerID.text+','+txtCustomerID1.text ;                         
	    System.OpenTargetPage(url);
    }
    else
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/im/rpt_shim00040_2.rpt&export_pdf=Y&procedure=prod.sp_rpt_shim00040_2&parameter=" + txtCustomerID.text+','+txtCustomerID1.text ;                         
	    System.OpenTargetPage(url);
    }
    
}
//==============================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case '1':
            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtCustomerPK.text = object[0];
                txtCustomerID.text   = object[1];
                txtCustomerName.text = object[2];
            }
        break;
        case '2':
            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx";
            var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
                txtCustomerPK1.text = object[0];
                txtCustomerID1.text   = object[1];
                txtCustomerName1.text = object[2];
            }
        break;
    }
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 100%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 90%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstCompany" styles='width:60%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%; white-space: nowrap" align="right">
                                            Type 
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:radio id="rdGRGI" value="1" styles="width:100%; height:100%">                   
		                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span value="1" id="rd1"><a>Local</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                   
		                                        <span value="2" id="rd2"><a>Export</a></span>  
    			                            </gw:radio>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%" align="right">
                                            <b>Customer</b>
                                        </td>
                                        <td style="width: 35%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtCustomerPK" styles="width:30%;display:none" csstype="mandatory" />
                                            <gw:textbox id="txtCustomerID" styles="width:30%" csstype="mandatory" ondblclick="OnPopUp('1')" />
                                            <gw:textbox id="txtCustomerName" styles="width:70%" csstype="mandatory" ondblclick="OnPopUp('1')"/>
                                        </td>
                                        <td style="width: 35%">
                                            <gw:textbox id="txtCustomerPK1" styles="width:30%;display:none" csstype="mandatory" />
                                            <gw:textbox id="txtCustomerID1" styles="width:30%" csstype="mandatory" ondblclick="OnPopUp('2')"/>
                                            <gw:textbox id="txtCustomerName1" styles="width:70%" csstype="mandatory" ondblclick="OnPopUp('2')"/>
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
