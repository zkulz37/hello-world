<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Summary By Invoice</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    OnSearch();
    Binding();
}
function Binding()
{
     
}
function OnSearch(){
    dso_htrt00090.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/rt/htrt00090.rpt&procedure=crm.sp_sel_htrt00090&parameter="+dtfr.GetData()+","+dtTo.GetData()+","+txtInvoiceNo.text;   
     System.OpenTargetPage(url); 
}
function OnPopUp(){
    var path = System.RootURL + '/form/ht/fo/htfo00041.aspx?pk=' + grdData.GetGridData(grdData.row, 23) + '&sn=' + grdData.GetGridData(grdData.row, 0)+ '&date=' + grdData.GetGridData(grdData.row, 1).substring(0,2) + '/' + grdData.GetGridData(grdData.row, 1).substring(3,5)+ '/' + grdData.GetGridData(grdData.row, 1).substring(6,10)+ '&room=' + url_encode(grdData.GetGridData(grdData.row, 22));
    var obj = System.OpenModal( path ,650 , 500,  'resizable:yes;status:yes');
}
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_htrt00090':			
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 1 + " record(s)";
				grdData.Subtotal( 1, 2, -1, '2!3!4!5!6!7!8!9!10!13!14!15!16!17!18!19!20!21');
			}
		break;
	}
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
 <gw:data id="dso_htrt00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="" function="crm.sp_sel_htrt00090" procedure="" >  
                <input bind="grdData" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtInvoiceNo" />
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 5%">
            <td width="10%" align="center">
                <b>Date</b></td>
            <td width="10%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
            <td width="2%">~</td>
            <td width="10%" >
                <gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" />
            </td>
            <td style="width:5%">
				Invoice#
			</td>
			<td style="width:10%">
				<gw:textbox id="txtInvoiceNo" styles="width:100%;"  />
			</td>
            <td width="30%" align="right">
                <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
            </td>
            <td with="6%"></td>
            <td with="3%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            
        </tr>
        <tr style="height: 95%">
            <td colspan="11">
                 <gw:grid 
                    id="grdData"
                    header="Invoice No|Invoice Date|Guest|Food(+)|Beverage(+)|Others(+)|SVC(+)|VAT(+)|Disct(-)|Total(=)|Adjust(+/-)|_In Time|_Out Time|Cash|Credit Card|FO Hotel|_FO Club|Debit|Office Check|Entertainment|Tranfer|Total Bill|Guest Name|_Pk" 
                    format  ="0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0"
                    aligns  ="0|1|1|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0" 
                    defaults="||||||||||||||||||||||" 
                    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
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
