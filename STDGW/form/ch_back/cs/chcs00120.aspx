<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
	imgFile.SetEnable(false);
	btnConfirm.SetEnable(false);
	txtScanFrom.text = "08:00";
	set_Interval(10000) ;
	datLoadScanEvent.Call("SELECT");
}

function OnDataReceive(obj)
{
	if (obj.id=="datLoadScanEvent")
	{      
		return;
	}
	else if (obj.id=="datLoadEmpPaymentInfo")
	{      
		imgFile.SetDataText(lblPicPK.text);	
		SetActionStatus();
	}
	else if (obj.id=="datEmpPaymentConfirm" )
	{      
		datLoadScanEvent.Call("SELECT");
	}
	else if (obj.id == "datEmpPaymentSkip")
	{
		datLoadScanEvent.Call("SELECT");
	}	
	else return;
}

function OnLoadScanEvent()
{
	if(IsValidTime(txtScanFrom.text) == false)
	{
		txtScanFrom.GetControl().focus();
		return;
	}
	datLoadScanEvent.Call("SELECT");
}
function OnChangeWorkMonth()
{
	lblEmpPK.text = "";
	lblMonthSalPK.text = "";
	lblPayScanLogPK.text = "";
	lblEmpID.text = "";
	lblEmpName.text = "";
	lblDept.text = "";
	lblGroup.text = "";
	lblRecSts.text = "";
	lblRecAmt.text = "";
	lblStatusLog.text = "";
	lblPicPK.text = "";
	btnConfirm.SetEnable(false);
	
	OnLoadScanEvent();
}

function OnSelectEmployee()
{
	lblEmpPK.text = "";
	lblMonthSalPK.text = "";
	lblPayScanLogPK.text = "";
	lblResult.text = "";
	
	if(grdList.rows <= 1)
	{
		return;
	}
	else
	{
		lblEmpPK.text = grdList.GetGridData( grdList.row, 0 );
		lblMonthSalPK.text = grdList.GetGridData( grdList.row, 1 );
		lblPayScanLogPK.text = grdList.GetGridData( grdList.row, 2 );
		
		if(lblEmpPK.text == "" || lblMonthSalPK.text == "" || lblPayScanLogPK.text == "")
		{
			return;
		}
		else
		{
			lblPicPK.text = "";
			txtDesc.text = ""; 
			datLoadEmpPaymentInfo.Call();
			//imgFile.SetDataText(lblPicPK.text);			
		}
	}
}

function IsValidTime(timeStr) {
// Checks if time is in HH:MM:SS AM/PM format.
// The seconds and AM/PM are optional.

	//var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;
	var timePat = /^(\d{1,2}):(\d{2})(:(\d{2}))?(\s?(AM|am|PM|pm))?$/;

	var matchArray = timeStr.match(timePat);
	if (matchArray == null) {
		alert("Time is not in a valid format. Time format is in HH:MM");
		return false;
	}
	
	hour = matchArray[1];
	minute = matchArray[2];
	second = matchArray[4];
	ampm = matchArray[6];

	if (second=="") { second = null; }
	if (ampm=="") { ampm = null }

	if (hour < 0  || hour > 23) {
		alert("Hour must be between 1 and 12. (or 0 and 23 for military time). Time format is in HH:MM");
		return false;
	}
	/*if (hour <= 12 && ampm == null) {
		if (confirm("Please indicate which time format you are using.  OK = Standard Time, CANCEL = Military Time")) {
			alert("You must specify AM or PM.");
			return false;
		   }
	}
	if  (hour > 12 && ampm != null) {
		alert("You can't specify AM or PM for military time. Time format is in HH:MM");
		return false;
	}/**/
	if (minute<0 || minute > 59) {
		alert ("Minute must be between 0 and 59. Time format is in HH:MM");
		return false;
	}
	if (second != null && (second < 0 || second > 59)) {
		alert ("Second must be between 0 and 59. Time format is in HH:MM");
		return false;
	}/**/
	return true;
}

function PaymentConfirm()
{
	datEmpPaymentConfirm.Call();
}

function OnSkipPayment()
{
	datEmpPaymentSkip.Call();
}

function SetActionStatus()
{
	if(lblStatusLog.text == "1")
	{
		btnConfirm.SetEnable(false);
	}
	else
	{
		btnConfirm.SetEnable(true);
	}
}

function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("OnLoadScanEvent()",x);
}

function clock(start,x) 
{
 var d = new Date();
 //idInterval.text= Math.round((d.valueOf()-start)/x);

}
/**/

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


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Employee Salary Payment</title>
</head>
<body>

<gw:data id="datLoadScanEvent" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso  type="grid"  parameter="1,6,7,8,9,10,11,12,13,14" function="hr_sel_10030012_scan_event" procedure=""> 
                <input bind="grdList" >
					<input bind="txtScanFrom" />
					<input bind="datWorkMon" />
                </input>
                <output  bind="grdList" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>

<gw:data id="datLoadEmpPaymentInfo" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sel_10030012_payment_info" > 
                <input>
                    <input bind="lblEmpPK" /> 
					<input bind="lblMonthSalPK" /> 
					<input bind="lblPayScanLogPK" /> 
                </input> 
                <output>
                    <output bind="lblEmpID" />
					<output bind="lblEmpName" />
					<output bind="lblDept" />
					<output bind="lblGroup" />
					<output bind="lblRecSts" />
					<output bind="lblRecAmt" />
					<output bind="lblStatusLog" />
					<output bind="lblPicPK" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmpPaymentSkip" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030012_payment_skip" > 
                <input>
                    <input bind="lblPayScanLogPK" />
					<input bind="lblStatusLog" />
                </input> 
                <output>
                    <output bind="lblResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmpPaymentConfirm" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030012_confirm" > 
                <input>
                    <input bind="lblEmpPK" /> 
					<input bind="lblMonthSalPK" /> 
					<input bind="lblPayScanLogPK" /> 
					<input bind="lblStatusLog" /> 
					<input bind="txtDesc" /> 
                </input> 
                <output>
                    <output bind="lblResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

	<table cellpadding="2" cellspacing="2" border=0 style="width:100%;height:100%;"> <tr width="100%">
		<td><fieldset style="padding: 5"><legend>Employee payment information</legend>
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
					<td colspan = "15" align = "right">Employee ID</td>
					<td colspan = "15" align = "center"><gw:label id="lblEmpID" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "35" align = "center"><gw:label id="lblEmpName" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "15" align = "right">Salary Month</td>
					<td colspan = "5" align = "center"><gw:datebox id="datWorkMon" lang="1" styles="width:90%" onchange="OnChangeWorkMonth()" type=month></gw:datebox></td>
					<td colspan = "4" align = "right">From</td>
					<td colspan = "6" align = "center"><gw:textbox id="txtScanFrom" format="##:##" maxlen = "5" onenterkey   ="OnLoadScanEvent()" styles='font-weight:normal;font-size:12pt'/></td>
					<td colspan = "5" align = "right"><gw:icon id="btnLoadScanEvent" img="in" text="Load" styles="font-weight:bold;font-size:15pt;width:100%" onclick="OnLoadScanEvent()" /></td>
				</tr>
				<tr>
					<td colspan = "15" align = "right">Organization</td>
					<td colspan = "24" align = "center"><gw:label id="lblDept" styles='font-weight:bold;font-size:9pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "2" align = "center">-</td>
					<td colspan = "24" align = "center"><gw:label id="lblGroup" styles='font-weight:bold;font-size:9pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "15" align = "right">Receive Amt</td>
					<td colspan = "15" align = "center"><gw:label id="lblRecAmt" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "5" align = "right"><gw:icon id="btnSkip" img="in" text="Skip" styles="font-weight:bold;font-size:15pt;width:100%" onclick="OnSkipPayment()" /></td>
				</tr>
				<tr>
					<td colspan = "15" align = "right">Description</td>
					<td colspan = "50" align = "left"><gw:textbox id="txtDesc" onenterkey   ="" styles='font-weight:normal;font-size:12pt'/></td>
					<td colspan = "15" align = "right">Receive Status</td>
					<td colspan = "10" align = "center"><gw:label id="lblRecSts" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
					<td colspan = "10" align = "right"><gw:icon id="btnConfirm" img="in" text="Confirm" styles="font-weight:bold;font-size:15pt;width:100%" onclick="PaymentConfirm()" /></td>
				</tr>
			</table></fieldset>
		</td>
	</tr>
	<tr width="100%" height="100%" >
		<td ><table border=1 style="width:100%;height:100%;"><tr><td width="75%"  rowspan="2">
                             <gw:grid   
                                id="grdList"  
                                header="HR_EMPLOYEE_PK|THR_MONTH_SALARY_PK|THR_PAY_SCANLOG_PK|THR_PAYMENT_LOG_PK|Scan Time|Emp ID|ID Num|Full Name|Receive Amt|Month|Status"   
                                format="0|0|0|0|0|0|0|0|1|0|0" 
                                aligns="0|0|0|0|0|0|0|0|0|0|0" 
                                defaults="||||||||||" 
                                editcol="0|0|0|0|0|0|0|0|0|0|0"   
                                widths="1200|1200|1200|1200|1500|1200|1200|2500|2000|1000|500" 
                                styles="width:100%; height:100%" 
								acceptNullDate
                                sorting="F"    oncellclick="OnSelectEmployee()" 
                                /> 
			</td>
			<td width="25%"  align = "center" ><gw:label id="lblResult" styles='font-weight:bold;font-size:10pt;width:100%;border:1px solid #6B9EB8'/>
			</td></tr>
			<tr height="100%"><td><gw:image id="imgFile" enable="false" table_name="TC_FSBINARY" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100%;height:100%"  />
			</td></tr>
			</table>
	</td></tr>
	</table>
</body>
<gw:label id="lblEmpPK" styles="display:none"/>
<gw:label id="lblMonthSalPK" styles="display:none"/>
<gw:label id="lblPayScanLogPK" styles="display:none"/>
<gw:label id="lblStatusLog" styles="display:none"/>
<gw:label id="lblPicPK" styles="display:none"/>
</html>