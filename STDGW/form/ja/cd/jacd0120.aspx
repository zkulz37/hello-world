<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Caddies Fee Monthly Report</title>
    <%  ESysLib.SetUser("crm")%>

    <script>
function BodyInit()
{
    OnSearch();
    //Binding();
}
function Binding()
{
}
function OnSearch(){
    dso_CaddyReport.Call("SELECT");
}

function OnReport()
{   
   var url = '/reports/ja/cd/rpt_jacd0120_year.aspx?p_Year='+ idYear.value;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
}
function OnDataReceive(po_oData)
 {
     switch(po_oData.id)
     {
        case "dso_CaddyReport":
            //txtCount.text=grdCaddyReport.rows-1 + " item(s).";
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
    <gw:data id="dso_CaddyReport" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jacd0120" >  
                <input bind="grdCaddyReport" >  
                    <input bind="idYear" /> 
                </input> 
                <output bind="grdCaddyReport" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height: 100%">
        <tr style="height: 2%">
            <td style="width: 5%">
                <b>Date</b></td>
            <td style="width: 10%">
                <gw:datebox id="idYear" maxlen="10" text="" styles='width:50%' lang="<%=Session("Lang")%>"
                    type="year" onchange="OnSearch()" />
            </td>
            <td align="right" style="width: 10%">
                <b></b></td>
            <td style="width: 10%" align="center">
                <gw:label id="txtCount" />
            </td>
            <td style="width: 7%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            <td style="width: 45%" align="right">
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="7">
                <gw:grid id="grdCaddyReport" header="No|Caddy Name|Caddy#|EMP#|1|2|3|4|5|6|7|8|9|10|11|12|Total"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="||||||||||||||||" 
					editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    sorting='T' autosize='T' styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
