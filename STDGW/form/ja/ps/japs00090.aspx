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
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-02','POINT-03','POINT-07','POINT-16','POINT-21') UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.CODE")%>";
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
    dso_japs00090.Call("SELECT");
}
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_japs00090':			
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 1 + " record(s)";
				grdData.Subtotal( 1, 2, -1, '2!3!4!5!6!7!8!9!10!13!14!15!16!17!18!19!20!21');
			}
		break;
	}
}
function OnReport(){
		   if(grdData.rows > 1)
		   {
			   var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ps/rpt_japs00090.rpt&procedure=CRM.sp_rpt_japs00090&parameter=" + dtfr.value+","+ dtTo.value+","+ lstLocation.value+","+lstGolfType.value+","+lstPayMethod.value;
			   System.OpenTargetPage(url);  
		   }
}
</script>

</head>
<body>
 <gw:data id="dso_japs00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="" function="crm.sp_sel_japs00090" procedure="" >  
                <input bind="grdData" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" />
					<input bind="lstLocation" />
					<input bind="lstGolfType" />
					<input bind="lstPayMethod" />
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 5%">
            <td width="5%" align="center"><b>Date</b></td>
            <td width="7%" ><gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" /></td>
            <td width="2%">~</td>
            <td width="7%" ><gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" /></td>
            <td width="5%" align="center">Location</td>
            <td width="19%"><gw:list id="lstLocation" onchange="OnSearch()" /></td>
			<td width="5%">Customer</td>
			<td style="width:15%">
					<gw:list id="lstGolfType" onchange="OnSearch()" />
			</td>
			<td width="7%" nowrap>Payment Method</td>
			<td style="width:15%">
					<gw:list id="lstPayMethod" onchange="OnSearch()" />
			</td>
			<td with="5%" align="center" >Total</td>
            <td width="10%" align="right">
                <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
            </td>
            <td with="3%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td> 
        </tr>
        <tr style="height: 95%">
            <td colspan="14">
                 <gw:grid 
                    id="grdData"
                    header="Invoice No|Invoice Date|Guest|Amount(+)|_Beverage(+)|_Others(+)|SVC(+)|VAT(+)|Disct(-)|Total(=)|Adjust(+/-)|_In Time
                    |_Out Time|Cash|Credit Card|FO Hotel|FO Club|Debit|Office Check|Entertainment|Tranfer|Total Bill|Guest Name" 
                    format  ="0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0"
                    aligns  ="0|1|1|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0" 
                    defaults="|||||||||||||||||||||" 
                    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T'
                    autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
