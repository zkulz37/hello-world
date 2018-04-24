<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
	btnCancel.SetEnable(false);
}

function OnDataReceive(obj)
{
    if (obj.id=="datTeamData")
    {
        lstTeam.value = "ALL";
    }
	else if(obj.id=="datEmpPaymentCancel")
	{
		datEmployeePayment.Call("SELECT");
	}
	else
	{
		return;
	}
}

function OnSearchData()
{
	datEmployeePayment.Call("SELECT");
}

function OnPaymentCancel()
{
	if(CheckDataIsValid() == false)
	{
		return;
	}
	else
	{
		datEmpPaymentCancel.Call();
	}
}

//------------------------------------------------
function OnChangeDept()
{
    datTeamData.Call();
}

function OnSelectEmployee()
{
	var status = "";
	
	lblResult.text = "";
	txtDesc.text = "";
	if(grdList.rows <= 1)
	{
		status = "";
		return;
	}
	else
	{
		lblResult.text = grdList.GetGridData( grdList.row, 6 ) + " : " + grdList.GetGridData( grdList.row, 7 );
		status = grdList.GetGridData( grdList.row, 14 );
		if(status == "1")
		{
			btnCancel.SetEnable(true);
			lblPaymentLogPK.text = grdList.GetGridData( grdList.row, 3 )
		}
		else
		{
			btnCancel.SetEnable(false);
		}
	}
}

function CheckDataIsValid() // true : it's OK; false : cannot
{
	if(txtDesc.text == "")
	{
		alert("Please input Cancel reason.");
		return false;
	}
	else
	{
		return true;
	}
	return true;
}

/*#######################################################################################*/
function OnDataError(obj)
{
	if (obj.id=="datStyleMaster")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	if (obj.id=="dsoStyleColor")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	else
	{
		alert(obj.errmsg);
	}
}

/*#######################################################################################*/
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
    var url =System.RootURL + '/reports/ch/cs/rpt_payment_log.aspx?' ;
	url += 'p_org=' +  lstOrg.value  ;
	url += '&p_org_type=' +  lstTeam.value  ;
	url += '&p_emp_info=' +  txtEmpInfo.text  ;
	url += '&p_work_mon=' +  datWorkMon.value  ;
	url += '&p_from_date=' +  datFrom.value  ;
	url += '&p_to_date=' +  datTo.value  ;
	url += '&p_status=' +  lstRecSts.value  ;	
	window.open(url);
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Salary Payment Management</title>
</head>
<body>

<gw:data id="datEmpPaymentCancel" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sel_10030012_payment_cancel" > 
                <input>
                    <input bind="lblPaymentLogPK" />
					<input bind="txtDesc" /> 
                </input> 
                <output>
                    <output bind="lblResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployeePayment" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso  type="grid"  parameter="1,6,7,8,9,10,11,12,13,14" function="hr_sel_10030013_payment_cancel" procedure=""> 
                <input bind="grdList" >
					<input bind="lstOrg" /> 
					<input bind="lstTeam" />
					<input bind="txtEmpInfo" />
					<input bind="datWorkMon" />
					<input bind="datFrom" />
					<input bind="datTo" />
					<input bind="lstRecSts" />
                </input>
                <output  bind="grdList" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datTeamData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_pro_10030013_team_data_all" > 
                <input>
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="lstTeam" />
                </output>
            </dso> 
        </xml> 
</gw:data>	

    <table cellpadding="2" cellspacing="2" border=0 style="width:100%;height:100%;"> <tr width="100%">
		<td><fieldset style="padding: 5"><legend>Search Information</legend>
			<table cellpadding="1" cellspacing="1" border=0>
				<tr style="width:100%;height:100%" valign="top">
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
				</tr>
				<tr>
					<td colspan = "15" align = "right">Organization</td>
					<td colspan = "20" align = "center">
						<gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%= ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 AND A.ORG_TYPE='06' ORDER BY A.SEQ")%>|ALL|Select All
                            </data>
                        </gw:list>
					</td>
					<td colspan = "10" align = "right">Team/Section</td>
					<td colspan = "20" align = "center"><gw:list  id="lstTeam" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type in('07','12') order by a.seq")%>|ALL|Select All</data>
							</gw:list>
					</td>
					<td colspan = "15" align = "right">Employee ID/Name</td>
					<td colspan = "15" align = "center"><gw:textbox id="txtEmpInfo" onenterkey = "OnSearchData()"/></td>
					<td colspan = "1" align = "right"></td>
					<td colspan = "3" align = "center"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearchData()"/></td>					
					<td colspan = "1" align = "right"></td>
				</tr>
				<tr>
					<td colspan = "15" align = "right">Salary Month</td>
					<td colspan = "10" align = "center">
						<gw:datebox id="datWorkMon" lang="1" styles="width:90%" onchange="" type=month></gw:datebox>
					</td>
					<td colspan = "10" align = "right"></td>
					<td colspan = "10" align = "right">Confirm Date</td>
					<td colspan = "9" align = "center">
						<gw:datebox id="datFrom" lang="1" styles="width:90%" nullaccept onchange=""></gw:datebox>
					</td>
					<td colspan = "2" align = "center">~</td>	
					<td colspan = "9" align = "center">
						<gw:datebox id="datTo" lang="1" styles="width:90%" nullaccept onchange=""></gw:datebox>
					</td>
					<td colspan = "15" align = "right">Receive Status</td>
					<td colspan = "10" align = "center">
						<gw:list  id="lstRecSts" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                |0|Not yet|1|Already Paid|2|Cancel|ALL|Select All ...
                            </data>
                        </gw:list>
					</td>
					<td colspan = "1" align = "right"></td>
					<td colspan = "9" align = "right">
						<gw:icon id="btnCancel" img="in" text="Cancel" styles="font-weight:bold;font-size:15pt;width:100%" onclick="OnPaymentCancel()" />
					</td>
				</tr>
				<tr>
					<td colspan = "15" align = "right">Cancel Reason</td>
					<td colspan = "50" align = "left"><gw:textbox id="txtDesc" onenterkey   ="" styles='font-weight:normal'/></td>
					<td colspan = "30" align = "center"><gw:label id="lblResult" styles='font-weight:bold;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "5" align = "center">
						<gw:imgBtn img="excel" id="ibtnReport" alt="Report"  onclick="OnReport()"/>
					</td>
				</tr>
			</table></fieldset>
		</td>
	</tr>
	<tr width="100%" height="100%" >
		<td ><table border=1 style="width:100%;height:100%;"><tr><td width="75%"  rowspan="2">
                             <gw:grid   
                                id="grdList"  
                                header="_T_HR_EMPLOYEE_PK|_THR_MONTH_SALARY_PK|_THR_PAY_SCANLOG_PK|_THR_PAYMENT_LOG_PK|Organization|Team/Section|Emp ID|Full Name|Scan Time|Receive Amt|Status|Confirm Date|Confirm By|Description|_status_log"   
                                format="0|0|0|0|0|0|0|0|0|1|0|0|0|0|0" 
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                defaults="||||||||||||||"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths="0|0|0|0|2500|2500|1000|2500|1000|1500|1000|1800|1000|2000|0"   
                                styles="width:100%; height:100%" 
								acceptNullDate
                                sorting="T"    oncellclick="OnSelectEmployee()" 
                                /> 
			</td></tr>
			</table>
	</td></tr>
	</table>
</body>
<gw:label id="lblPaymentLogPK" styles="display:none"/>
<gw:label id="lblStatusLog" styles="display:none"/>
</html>