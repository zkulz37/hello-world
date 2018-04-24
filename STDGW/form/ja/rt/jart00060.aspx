<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Summary By Invoice</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	Binding();
    OnSearch();
}
function Binding()
{
	var grd_con = grdData.GetGridControl();
    grd_con.RowHeight(0) = 500;
	
	var data;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-01','POINT-04','POINT-05','POINT-06','POINT-09') UNION SELECT 'GOLF', 'F&B GOLF' FROM DUAL UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.CODE")%>";
	lstLocation.SetDataText(data);
	lstLocation.value = '';
	
	data = "<%=ESysLib.SetListDataSQL("SELECT pk, last_name FROM tht_room_allocate WHERE pk < 0 AND del_if = 0")%>||ALL";
    lstGolfType.SetDataText(data);
	lstGolfType.value = '';
	
	data = "DATA|Y|CASH|N|SEND FO|R|DEBIT|C|CREDIT CARD||ALL";
	lstPayMethod.SetDataText(data);
	lstPayMethod.value = '';
}
function OnSearch(){
    dso_jart00060.Call("SELECT");
}
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_jart00060':			
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 1 + " record(s)";
				grdData.Subtotal( 1, 2, -1, '2!3!4!5!6!7!8!9!10!11!12!13!14!15!16!19!20!21!22!23!24!25!26!27');
			}
		break;
	}
}
function OnReport(){
		   if(grdData.rows > 1)
		   {
			   var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/rpt_jart00060.rpt&procedure=CRM.sp_sel_jart00060_rpt&parameter=" + dtfr.value+","+ dtTo.value+","+ lstLocation.value+","+lstGolfType.value+","+lstPayMethod.value+","+url_encode(txtGuestName.text);
			   System.OpenTargetPage(url); 
		   }
}
function OnExcel(){
			if(grdData.rows > 1)
		   {
			   var url = System.RootURL + '/reports/ja/rt/SumaryByInvoices.aspx?dtfr='+dtfr.value+'&dtTo='+dtTo.value+'&loc='+lstLocation.value+'&golf='+lstGolfType.value+'&pay='+lstPayMethod.value;
			   System.OpenTargetPage(url); 
		   }
}
function OnReportSession(){
			if(grdData.rows > 1)
		   {
			   var url = System.RootURL + '/reports/ja/rt/FNBReport1108.aspx?dtfr='+dtfr.value+'&dtTo='+dtTo.value;
			   System.OpenTargetPage(url); 
		   }
}
function OnReportRevenue(){
		   if(grdData.rows > 1)
		   {
			   var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/rpt_jart00060_revenue.rpt&procedure=CRM.sp_sel_jart00060_rpt_revenue&parameter=" + dtfr.value+","+ dtTo.value;
			   System.OpenTargetPage(url); 
		   }
}
function OnPopUp(){
    var path = System.RootURL + '/form/ht/fo/htfo00041.aspx?pk=' + grdData.GetGridData(grdData.row, 29) + '&sn=' + grdData.GetGridData(grdData.row, 0)+ '&date=' + grdData.GetGridData(grdData.row, 1).substring(0,2) + '/' + grdData.GetGridData(grdData.row, 1).substring(3,5)+ '/' + grdData.GetGridData(grdData.row, 1).substring(6,10)+ '&room=' + url_encode(grdData.GetGridData(grdData.row, 28));
    var obj = System.OpenModal( path ,650 , 500,  'resizable:yes;status:yes');
}
function url_encode(s) {
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return escape(utftext);
}
</script>

</head>
<body>
 <gw:data id="dso_jart00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="" function="crm.sp_sel_jart00060" procedure="" >  
                <input bind="grdData" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" />
					<input bind="lstLocation" />
					<input bind="lstGolfType" />
					<input bind="lstPayMethod" />
					<input bind="txtGuestName" />
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 5%">
            <td width="5%" align="right"><b>Date</b></td>
            <td width="7%" ><gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" /></td>
            <td width="2%">~</td>
            <td width="7%" ><gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" /></td>
            <td width="12%" align="right">Customer</td>
            <td width="19%"><gw:list id="lstGolfType" onchange="OnSearch()" /></td>
			<td width="10%" align="right">Guest Name</td>
			<td style="width:20%"><gw:textbox id="txtGuestName" onenterkey="OnSearch()" /></td>
			<td width="0%" nowrap></td>
			<td style="width:5%"></td>
			<td with="5%" align="center" >Total</td>
            <td width="10%" align="right">
                <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
            </td>
            <td with="3%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td style="width: 3%"><gw:imgBtn id="ibUpde" img="excel" alt="Sumary By Invoice Detail" onclick="OnExcel()" /></td>'
			<td style="width: 3%"><gw:imgBtn id="ibtnReportSession" img="excel" alt="F&B Session" onclick="OnReportSession()" /></td>
			<td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="FNB Revenue Report" onclick="OnReportRevenue()" />
            </td> 
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td> 
        </tr>
		<tr style="height: 5%">
			<td align="right"><b>Location</b></td>
			<td align="left" colspan="3"><gw:list id="lstLocation" onchange="OnSearch()" /></td>
			<td align="right"><b>Payment Method</b></td>
			<td align="left"><gw:list id="lstPayMethod" onchange="OnSearch()" /></td>
		</tr>
        <tr style="height: 95%">
            <td colspan="17">
                 <gw:grid 
                    id="grdData"
                    header="Invoice No|Invoice Date|Guest|Food AMB(+)|Food Not AMB(+)|Food Other(+)|_Food(+)|Bvr AMB(+)|Bvr Not AMB(+)|Bvr Other(+)|_Beverage(+)|Others(+)|SVC(+)|VAT(+)|Disct(-)|Total(=)|Adjust(+/-)|_In Time|_Out Time|Cash|Credit Card|FO Hotel|FO Club|Debit|Office Check|Entertainment|Tranfer|Total Bill|Guest Name|_Pk|Company Name" 
                    format  ="0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0"
                    aligns  ="0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    defaults="|||||||||||||||||||||||||||||" 
                    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting ='T'
                    autosize='T'
	                styles  ="width:100%; height:100%"
			        oncelldblclick="OnPopUp();"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
