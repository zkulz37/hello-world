<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("acnt")%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{ 
	System.Translate(document);
	// Set data source to Combobox
	var lstCompany_data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
	var lstCostGroup_data = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from hr.vhr_hr_code where id='HR0092' order by code")%>" +"|ALL|Select All";
	var lstCostType_data = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from hr.vhr_hr_code where id='HR0093' order by code")%>" +"|ALL|Select All";
	var cboCurrency_data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //trade term
    
	//grdList.ColFormat(2) = "#,###,###,###,###,###,###,###,###.##";
	//grdList.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##";
	//grdList.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##";
	
	lstCompany.SetDataText(lstCompany_data); //lstCompany.value = "<%=Session("COMPANY_PK")%>";
	lstSearchCT.SetDataText(lstCostType_data)//;lstSearchCT.value = "ALL";
	lstSearchCG.SetDataText(lstCostGroup_data)//;lstSearchCG.value = "ALL";
	cboCurrency.SetDataText(cboCurrency_data); 
	
	//btnPost.SetEnable(0);//temporary 
	txtProposedByUserPk.text="<%=Session("USER_PK")%>";
    //dso_ctl_getProposedBy.Call("SELECT");
	dso_getCompany.Call();
    
	
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

function getExRate()
{    
	var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + datPayDate.value +"&curr=" + cboCurrency.value;
	ajax_test = null;
   
	ajax_test = GetXmlHttpRequest(returnExRate);
	ajax_test.open("GET", url , true);
	ajax_test.send(null); 
}
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
	if(obj.id == "dso_getCompany")
	{
		LoadCostCenter();
	}
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
		lstCostCenter.Value = "ALL";
	}
	else if(obj.id == "dsoProcessGetTransRate")
	{
	    getExRate();
	}
    else if(obj.id == "dsoPostData")
    {
        //status = 'Exporting data...';
        //dsoExportInvoices.Call();  
		return;		
	}
	else if(obj.id=='dsoSearchSlipInfo')
	{
	    auto_resize_column(grdList,0,grdList.cols-1,9);   	
	} 
    else if(obj.id == "dsoProcessGSlipData")
    {
        OnsearchPayroll();
		return;		
	}   
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

function ShowDetailPopup()
{/*
	var strcom;
	
	var vSalAccPK = grdList.GetGridData(grdList.GetGridControl().SelectedRow(0),9);//pk
	var vSalAccNm = grdList.GetGridData( grdList.GetGridControl().SelectedRow(0),0);//name
	
	var fpath = System.RootURL + "/form/gf/pm/gfpm00020_popup.aspx?";
	fpath = fpath + "Company=" + lstCompany.value + "&SalMon=" + datSalMonth.value + "&CostCenterPK=" + lstCostCenter.value;
	fpath = fpath + "&CostGroupPK=" + lstSearchCG.value + "&CostTypePK=" + lstSearchCT.value + "&SalAccPk=" + vSalAccPK;
	fpath = fpath + "&CostCenterNm=" + lstCostCenter.GetText() + "&CostGroupNm=" + lstSearchCG.GetText() + "&CostTypeNm=" + lstSearchCT.GetText()
	fpath = fpath + "&SalAccNm=" + vSalAccNm + "&DeptPK=" + lstOrg.value;
	var object = System.OpenModal( fpath , 700 , 600, 'resizable:no;status:no;scroll:no;status:no'); 
	return;*/
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
function OnReport()
{
    var url=System.RootURL;
        
    url=url + '/reports/gf/pm/rpt_payroll_make_slip.aspx?p_1=' + lstCompany.value + '&p_2=' + datSalMonth.value + '&p_3=' + lstCostCenter.value + '&p_4=' + lstSearchCG.value + '&p_5=' + lstSearchCT.value + '&p_6=' + lstOrg.value ;
    window.open(url); 
    
}
function OnShowPopup()
{
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
         var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			lstOrg.value = obj;
	    }
     
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------

function OnSlipData(action)
{
	if(action == "PROCESS")
	{
		lblAction.text = "PROCESS";
		dsoProcessGSlipData.Call();
	}
	else if(action == "DELETE")
	{
		lblAction.text = "DELETE";
		dsoProcessGSlipData.Call();
	}
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Payroll Make Slip</title>
</head>
<body>
<!------------------------------------------------------------------------>
<gw:data id="dso_getCompany" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="ACNT.sp_sel_gfac00100_4_entry" > 
                <input> 
                     <input bind="txtProposedByUserPk"/>
                </input>
                <output>
                     <output bind="lstCompany"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

<!------------------------------------------------------------------------>
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
                    <input bind="lstAPkind" />
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
					<input bind="lstAPkind" />
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
                    <input bind="datSalMonth" /> 
                </input>
                <output>
                    <output bind="txtTransRate" />
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
					<input bind="lstOrg" />
					<input bind="lstAPkind" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>

<gw:data id="dsoProcessGSlipData" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_PAYROLL_MAKE_GSLIP" onerror="OnDataError(this)" > 
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
                    <input bind="lstAPkind" />
                </input> 
                <output>
                    <output bind="lblResult" />
					<output bind="lblProStatus" />
                </output>
            </dso> 
        </xml> 
</gw:data>


    <table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border="0">
		<tr id="tr_process">
			<td><fieldset style="padding: 6"><legend>Process Slip Information</legend>
				<table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border="0">
					<tr width="100%">
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					</tr>
					<tr height = "100%">
						<td colspan="13" align = "right">Company</td>
						<td colspan="25"><gw:list id="lstCompany" onchange="LoadCostCenter()" styles='width:100%'></gw:list></td>
						<td colspan="10" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >
                            Organization</a></td>
						<td colspan="20" style="border:0;" align="left" >
							<gw:list  id="lstOrg" value="ALL" styles='width:100%' onchange=""> 
							<data>
								<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0  order by a.seq")%>|ALL|Select All
							</data></gw:list>
						</td>
						<td colspan="10" align = "right">Month</td>
						<td colspan="10"><gw:datebox id="datSalMonth"  onchange="GetTransRate()" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
						<td colspan="5" align = "right">Payroll Date</td>
						<td colspan="5"><gw:datebox id="datPayDate" styles="width:100%" lang="<%=Session("Lang")%>" /></td>
						<td colspan="2"><gw:imgBtn img="excel" id="ibtnSumPrinter"    alt="detail Report"  onclick="OnReport()"/></td>
					</tr>
					<tr height = "100%">
						<td colspan="13" align = "right">Cost Center</td>
						<td colspan="25"><gw:list id="lstCostCenter" value = "ALL" onchange="OnsearchPayroll()" styles='width:100%'></gw:list></td>
						<td colspan="10" align = "right">Cost Group</td>
						<td colspan="20"><gw:list id="lstSearchCG" onchange="OnsearchPayroll()" styles='width:100%'></gw:list></td>
						<td colspan="10" align = "right">Cost Type</td>
						<td colspan="10"><gw:list id="lstSearchCT" onchange="OnsearchPayroll()" styles='width:100%'></gw:list></td>
						<td colspan="10" style="border:0;" align="left" >
							<table width = "100%"><tr>
								<td>
									<gw:icon id="btnProcess" img="in" text="Process" styles="width:100" onclick="OnProcessData('PROCESS')" />
								</td>
								<td>
									<gw:icon id="btnCancel" img="in" text="Cancel" styles="width:100" onclick="OnProcessData('DELETE')" />
								</td>
							</tr></table>
						</td>
						<td colspan="2"><gw:icon id="btnSLip" img="in" text="Slip" styles="width:100" onclick="OnSlipData('PROCESS')" /></td>
						
					</tr>
					<tr height = "100%">
						<td colspan="13" align = "right">Trans. Rate</td>
						<td colspan="10"><gw:textbox id="txtTransRate" styles="" /></td>
						<td colspan="15" align=right>Book Rate</td>
						<td colspan="20"> 
								<table width = "100%">
									<tr>
										<td width="60%" colspan="2" ><gw:list id="cboCurrency" styles="width:100%;" onchange="getExRate();"></gw:list></td>
										<td width="40%"><gw:textbox id="txtBookRate" styles="" /></td>
									</tr>
								</table>
						</td>
						<td colspan="10" align=right>AP Type</td>
						<td colspan="10" align = "right"><gw:list id="lstAPkind" styles="width:100%;" onchange="OnsearchPayroll()">
						    <data>|01|Salary|03|Health Ins|02|Social Ins|04|Unemp Ins|05|Meal</data>
						</gw:list></td>
						<td colspan="10" style="border:0;" align="right" >
							<gw:label id="lblProStatus"  text="Process Status" maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" />
					    </td>
						<td colspan="10"> 
							<table width = "100%"><tr>
								<td>
									<gw:icon id="btnSearch" img="in" text="Search" styles="width:100" onclick="OnsearchPayroll()" />
								</td>
								<td>
									<gw:icon id="btnPost" img="in" text="Post" styles="width:100" onclick="OnProcessData('POST')" />
								</td>
							</tr></table>
						</td>
						<td colspan="2"><gw:icon id="btnSLipCancel" img="in" text="Cancel" styles="width:100" onclick="OnSlipData('DELETE')" /></td>
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
								header="Name|Currency|BK Rate|Count emp|PL Code|PL Name|Trans Amount|Books Amount|Account Code DR|Account Code CR|_TAC_PMCOSTTYPE_PK"
                                format="0|0|1|1|0|0|1|0|0|0|0"
								aligns="0|0|0|0|0|0|0|0|0|0|0"
								defaults="||||||||||"
                                editcol="0|0|0|0|0|0|0|0|0|0|0"
								widths="4500|1500|2000|1500|2000|2000|2000|2000|1500|1500|0"
                                styles="width:100%; height:100%" sorting="T" acceptnulldate="T" oncelldblclick="ShowDetailPopup()" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<gw:label id="lblAction" style="display: none" />
	<gw:label id="lblResult" style="display: none" />
	<gw:textbox id="txt1" text="" styles="display: none" />
	<gw:textbox id="txt2" text="" styles="display: none" />
	<gw:textbox id="txtProposedByUserPk"       styles='display:none'/>
</body>
</html>
