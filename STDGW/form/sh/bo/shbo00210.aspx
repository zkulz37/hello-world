<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manufacturing Instruction and Record (2.Production)</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

 var main_m_pk = "<%=Request.querystring("main_m_pk")%>";
 var lotno="<%=Request.querystring("lotno")%>";
 var hoki="<%=Request.querystring("hoki")%>";
 var instructedDT="<%=Request.querystring("InstructDT")%>";
 var  emp_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
 var  user_id  = "<%=Session("USER_ID")%>" ; 
//===============================================================
function BodyInit()
{
    txtMasterPK.text=main_m_pk;
    BindingDataList();
    lstMachineNo.value=hoki;
    txtLotno.text=lotno;
    txtEmpPK.text = emp_pk;
    lstMachineNo.SetEnable(false);
    dtFromDate.value=instructedDT;
    dtToDate.value=instructedDT;
}
//===============================================================
function OnPopUp()
{
	var fpath = System.RootURL + "/form/sh/bo/shbo00210_popup.aspx";
	var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');

	if (object != null)
	{
		txtMasterPK.text		= object[0];	// tsh_main_m_pk
		lstMachineNo.value      = object[2];    // hoki
		txtLotno.text           = object[1];    // lotno
	}        
}
//==============================================================
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>||";    
    lstMachineNo.SetDataText(data);
    lstMachineNo.value="";
}
//===============================================================
function OnDataReceive(obj)
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00210.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00210&parameter=" + txtLotno.text + ',' + lstMachineNo.value ;              
	System.OpenTargetPage(url); 
}
//===============================================================
function OnPrint()
{
    
	data_shbo00210_1.Call();
}
//===============================================================
</script>

<body>
    <gw:data id="data_shbo00210_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00210" > 
                <input>
                    <input bind="txtLotno" /> 
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
                    <tr style="height: 80%">
                        <td valign="center" align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%; white-space: nowrap" align="right">
                                            <b>Instructed Period</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b>Issued Date</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtIssueDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b>Machine No</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:list id="lstMachineNo" styles="width: 100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Lot No.</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtLotno" styles="width:100%" />
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
