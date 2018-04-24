<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("acnt")%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{ 
	System.Translate(document);
	// Set data source to Combobox
	var lstCompany_data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
	var lstCostGroup_data = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from hr.vhr_hr_code where id='HR0092' order by code")%>";// +"|ALL|Select All";
	var lstCostType_data = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from hr.vhr_hr_code where id='HR0093' order by code")%>";// +"|ALL|Select All";
	//var cboCurrency_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //trade term
    
	//grdList.ColFormat(2) = "#,###,###,###,###,###,###,###,###.##";
	//grdList.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##";
	//grdList.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##";
	
	lstCompany.SetDataText(lstCompany_data); //lstCompany.value = "<%=Session("COMPANY_PK")%>";
	lstSearchCT.SetDataText(lstCostType_data)//;lstSearchCT.value = "ALL";
	lstSearchCG.SetDataText(lstCostGroup_data)//;lstSearchCG.value = "ALL";
	//cboCurrency.SetDataText(cboCurrency_data); 
	LoadCostCenter();
	
	
}

function OnProcessData(action)
{
	if(action == "PROCESS")
	{
		if(CheckDataIsValid() == false)
		{
			return;
		}
		else
		{
			lblAction.text = "PROCESS";
			dsoProcessSlipData.Call();
		}
	}
	else if(action == "DELETE")
	{
		if(CheckDataIsValid() == false)
		{
			return;
		}
		else
		{		
			lblAction.text = "DELETE";
			dsoProcessSlipData.Call();
		}
	}
	else if(action == "POST")
	{
		lblAction.text = "POST";
		dsoPostData.Call();
	}
	else
	{
		return;
	}
}

function GetTransRate()
{
	dsoProcessGetTransRate.Call();
}

function GetBookRate()
{
	dsoProcessGetBookRate.Call();
}

/*function getExRate()
{    
	var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + datPayDate.value +"&curr=" + cboCurrency.value;
	ajax_test = null;
   
	ajax_test = GetXmlHttpRequest(returnExRate);
	ajax_test.open("GET", url , true);
	ajax_test.send(null); 
}*/
//---------------------------------------------------------
function returnExRate()
{
	if(GetRequestState(ajax_test))
	{	
		strdata = ajax_test.responseText;	 	  
		txtBookRate.SetDataText(''+strdata);
	}
}

function OnsearchPayroll()
{
	dsoSearchSlipInfo.Call("SELECT");
}

function OnDataReceive(obj)
{
	if(obj.id == "dsoProcessSlipData")
	{
		if(lblResult.text == "0" && lblAction.text == "PROCESS")
		{
			alert("Process successfull");
			//OnsearchPayroll();
		}
		else if(lblResult.text == "0" && lblAction.text == "DELETE")
		{
			alert("Delete successfull");
			//OnsearchPayroll();
		}
		OnsearchPayroll();
	}
	else if(obj.id == "dsoGetCostCenterByCompany")
	{
	    GetTransRate();
	}
	else if(obj.id == "dsoProcessGetTransRate")
	{
	    //getExRate();
		dsoProcessGetBookRate.Call();
		// GetBookRate();
	}
   else { return; }
}

function CheckDataIsValid()
{
	if(lstCostCenter.GetData() == "")
	{
		alert("Please select Cost Center before process")
		return false;
	}
	if((txtTransRate.text == "" || txtBookRate.text == "") && lblAction.text == "PROCESS" )
	{
		alert("You must input Trans Rate and Book Rate before process")
		return false;
	}
	return true;
}

function LoadCostCenter()
{
	dsoGetCostCenterByCompany.Call();
	//OnsearchPayroll()
}



function OnDataError(obj)
{
	AlertDBError(obj.errmsg)
	return;
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Payroll Make Slip</title>
</head>
<body>

<gw:data id="dsoGetCostCenterByCompany" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
	<xml> 
		<dso  type="list" procedure="ACNT.SP_PRO_COST_CENTER_LIST_ALL" > 
			<input>
				<input bind="lstCompany" /> 
			</input> 
			<output>
				<output bind="lstCostCenter" />
			</output>
		</dso> 
	</xml> 
</gw:data>

<gw:data id="dsoProcessSlipData" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_PAYROLL_MAKE_SLIP" onerror="OnDataError(this)" > 
                <input>
                    <input bind="lstCompany" /> 
                    <input bind="datSalMonth" /> 
                    <input bind="datPayDate" /> 
					<input bind="txtTransRate" /> 
					<input bind="txtBookRate" /> 
					<input bind="lstCostCenter" /> 
					<input bind="lstSearchCG" /> 
					<input bind="lstSearchCT" /> 
                    <input bind="lblAction" />
                </input> 
                <output>
                    <output bind="lblResult" />
					<output bind="lblProStatus" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dsoPostData" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_INSERT_AP_INV_INTERFACE" onerror="OnDataError(this)" > 
                <input>
                    <input bind="datSalMonth" /> 
					<input bind="datPayDate" /> 
                </input>
                <output>
                    <output bind="lblProStatus" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dsoProcessGetTransRate" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_PRO_GET_SAL_TR_RATE" onerror="OnDataError(this)" > 
                <input>
					<input bind="lstCompany" /> 
                    <input bind="datSalMonth" /> 
                </input>
                <output>
					<output bind="txtTransRate" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dsoProcessGetBookRate" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_PRO_GET_SAL_BK_RATE" onerror="OnDataError(this)" > 
                <input>
					<input bind="lstCompany" /> 
                    <input bind="datPayDate" /> 
                </input>
                <output>
                    <output bind="lblCurrency" />
					<output bind="txtBookRate" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dsoSearchSlipInfo" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
        <xml>
            <dso type="grid" function="ACNT.SP_SEL_SLIP_LIST">
                <input bind="grdList">
                    <input bind="lstCompany"/>
                    <input bind="datSalMonth"/>
                    <input bind="lstCostCenter"/>
                    <input bind="lstSearchCG"/>
                    <input bind="lstSearchCT" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>

    <table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border="0">
		<tr id="tr_process">
			<td><fieldset style="padding: 5"><legend>Process Slip Information</legend>
				<table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border="0">
					<tr height = "100%">
						<td width = "10%" align = "right">Company</td>
						<td width = "10%"><gw:list id="lstCompany" onchange="LoadCostCenter()" styles='width:100%'></gw:list></td>
						<td width = "10%" align = "right">Salary Month</td>
						<td width = "10%"><gw:datebox id="datSalMonth"  onchange="GetTransRate()" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
						<td width = "10%" align = "right">Payroll Date</td>
						<td width = "10%"><gw:datebox id="datPayDate" styles="width:100%" onchange="GetBookRate()" lang="<%=Session("Lang")%>" /></td>
						<td width = "10%" align = "right">Trans Rate</td>
						<td width = "10%"> <gw:textbox id="txtTransRate" styles="" /></td>
						<td width="10%" style="border:0;" align="right" >
							<gw:label id="lblProStatus"  text="Process Status" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" />
						<td width="10%" style="border:0;" align="left" >
							<table width = "100%"><tr>
								<td>
									<gw:icon id="btnProcess" img="in" text="Process" styles="width:100" onclick="OnProcessData('PROCESS')" />
								</td>
								<td>
									<gw:icon id="btnCancel" img="in" text="Cancel" styles="width:100" onclick="OnProcessData('DELETE')" /></td>
								</td>
							</tr></table>
						</td>
					</tr>
					<tr height = "100%">
						<td width = "10%" align = "right">Cost Center</td>
						<td width = "10%"><gw:list id="lstCostCenter" onchange="OnsearchPayroll()" styles='width:100%'></gw:list></td>
						<td width = "10%" align = "right">Cost Group</td>
						<td width = "10%"><gw:list id="lstSearchCG" onchange="OnsearchPayroll()" styles='width:100%'></gw:list></td>
						<td width = "10%" align = "right">Cost Type</td>
						<td width = "10%"><gw:list id="lstSearchCT" onchange="OnsearchPayroll()" styles='width:100%'></gw:list>
						<td width = "10%" align = "right">Book Rate</td>
						<td width = "20%" colspan = "2"> 
								<table width = "100%">
									<tr>
										<td width="50%" colspan="2" align = "right"><gw:label id="lblCurrency"/></td>
										<td width="50%"><gw:textbox id="txtBookRate" styles="" /></td>
									</tr>
								</table>
						</td>
						<td width = "10%"> 
							<table width = "100%"><tr>
								<td>
									<gw:icon id="btnSearch" img="in" text="Search" styles="width:100" onclick="OnsearchPayroll()" />
								</td>
								<td>
									<gw:icon id="btnPost" img="in" text="Post" styles="width:100" onclick="OnProcessData('POST')" /></td>
								</td>
							</tr></table>
						</td>
					</tr>
				</table>
				</fieldset>
				</td>
		</tr>
		<tr height = "100%">
			<td>
				<table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border = "">
					<tr>
						<td>
							<gw:grid id="grdList" 
								header="Name|Currency|BK Rate|Trans Amount|Books Amount|Account Code DR|Account Code CR"
                                format="0|0|1|1|1|0|0"
								aligns="0|0|0|0|0|0|0"
								defaults="||||||"
                                editcol="0|0|0|0|0|0|0"
								widths="4500|1500|2000|2000|2000|1500|1500"
                                styles="width:100%; height:100%" sorting="T" acceptnulldate="T" onclick="" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<gw:label id="lblAction" style="display: none" />
	<gw:label id="lblResult" style="display: none" />
	<!--gw:list id="cboCurrency" styles="width:100%;display: none" onchange="getExRate();"></gw:list-->
</body>
</html>
