<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manfacturing Instruction and Record (4.Packaging)</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var l_main_m_pk	= "<%=Request.querystring("main_m_pk")%>";
var l_inst_date	= "<%=Request.querystring("inst_dt")%>";
var l_hoki		= "<%=Request.querystring("hoki")%>";
var l_issue_dt	= "<%=Request.querystring("issu_dt")%>";
var l_lotno		= "<%=Request.querystring("lotno")%>";
var l_item		= "<%=Request.querystring("item")%>";
var l_customer	= "<%=Request.querystring("customer")%>";
var l_type	= "<%=Request.querystring("type")%>";
//===============================================================
function BodyInit()
{
	BindingDataList();	
	SetEnableControl();

	if (l_main_m_pk != '')
	{
		txtMasterPK.text    = l_main_m_pk;
		dtFromDate.value	    = l_inst_date;
		dtToDate.value		= l_inst_date;
		lstMachineNo.value	= l_hoki; 
		//dtIssuDate.text	= l_issue_dt;
		txtLotNo.text		= l_lotno;
		txtItemName.text	= l_item;
		txtCustName.text	= l_customer;
		rdoSTATUS.value     =l_type;
	}
}
//===============================================================
function SetEnableControl()
{
	lstMachineNo.SetEnable(false); 
	txtLotNo.SetReadOnly(true);
	txtItemName.SetReadOnly(true);
	txtCustName.SetReadOnly(true);
}
//==============================================================
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.F_LOGISTIC_CODE('LGMF0010') FROM DUAL" )%>||";    
    lstMachineNo.SetDataText(data);
	lstMachineNo.value = '';
}
//===============================================================
function OnPopUp()
{
	var fpath = System.RootURL + "/form/sh/bo/shbo00230_popup.aspx?box_gu=" + rdoSTATUS.value;
	var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes');

	if (object != null)
	{
		ResetControl();
		txtMasterPK.text		= object[0];	// tsh_main_m_pk
		dtFromDate.text		= object[1];	// inst_date
		dtToDate.text			= object[1];	// inst_date
		lstMachineNo.value		= object[2];	// machine_no
		dtIssuDate.text		= object[3];	// issu date
		txtLotNo.text			= object[4];	// lot_no
		txtItemName.text		= object[5];	// producte name
		txtCustName.text		= object[6];	// custome name
	}        
}
//===============================================================
function ResetControl()
{
	lstMachineNo.value		= '';
	dtIssuDate.text		= '';
	txtLotNo.text			= '';
	txtItemName.text		= '';
	txtCustName.text		= '';
}
//===============================================================
function OnDataReceive(obj)
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00230.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00230&parameter=" + txtMasterPK.text+"," + rdoSTATUS.value;
    System.OpenTargetPage(url);   
     
}
//===============================================================
function OnPrint()
{
	if (txtLotNo.text != '')
	{
		data_shbo00230_1.Call();
	}
}
//===============================================================
</script>

<body>
    <gw:data id="data_shbo00230_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00230" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="txtLotno" /> 
                    <input bind="dtIssuDate" />  
                    <input bind="txtEmpPK" /> 
                    <input bind="rdoSTATUS" /> 
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
                                            <b>Class</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:radio id="rdoSTATUS" value="1" styles='height:22' >
												<span value="1">Norm</span>
												<span value="2">BOX</span>
											</gw:radio >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%; white-space: nowrap" align="right">
                                            <b>Instructed Date</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtFromDate" styles="width:50%" lang="1" />
                                            ~<gw:datebox id="dtToDate"  styles="width:50%" lang="1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b>Machine No.</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:list id="lstMachineNo" styles="width: 100%" />
                                        </td>
                                    </tr>
									<tr>
                                        <td style="width: 20%" align="right">
                                            <b>Issue Date</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:datebox id="dtIssuDate" styles="width:100%"  lang="1"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                            <b><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Lot No.</b></b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtLotNo" styles="width:100%" />
                                        </td>
                                    </tr>
									<tr>
                                        <td style="width: 20%" align="right">
                                            <b>Product Name</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtItemName" styles="width:100%" />
                                        </td>
                                    </tr>
									<tr>
                                        <td style="width: 20%" align="right">
                                            <b>Customer Name</b>
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap">
                                            <gw:textbox id="txtCustName" styles="width:100%" />
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
