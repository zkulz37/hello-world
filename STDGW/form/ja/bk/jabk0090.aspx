<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Booking Sheet</title>
    <%  ESysLib.SetUser("crm")%>
</head>
<script>
function BodyInit(){InitData(); OnSearch();}
function InitData(){
    var data = "data|1|Out|2|In|3|E9";
    lstCourse.SetDataText(data); 
}
function OnSearch(){
	dso_jabk0090.Call("SELECT");
}

function OnDataReceive(obj){
	if(obj.id=='dso_jabk0090')
		txtCount.text = grdData.rows - 1 + " record(s)";
}
function OnPrint3(){
    var url = '/reports/ja/bk/rpt_jabk0090_2.aspx?p_dt='+ dtDate.GetData();
	System.OpenTargetPage( System.RootURL+url , "newform" );
 }
function OnPrint(){
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0090.rpt&procedure=CRM.sp_sel_jabk0090|CRM.sp_sel_jabk0090|CRM.sp_sel_jabk0090&parameter=" + dtDate.GetData() + ",M,"+lstCourse.GetData()+"|" + dtDate.GetData() + ",A,"+lstCourse.GetData()+"|" + dtDate.GetData() + ",M,"+lstCourse.GetData();
      System.OpenTargetPage(url); 
}
function OnReport2()
{
	var url = '/reports/ja/bk/jabk0090.aspx?p_dt_para='+ dtDate.value + '&p_am=' + txtAMPM.text +'&p_course='+lstCourse.value;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
}
function Registation_OnReport()
{
	if(grdData.row !='-1')
	{
		var url = '/reports/ja/bk/rpt_jabk0090_Golf_Registration.aspx?p_dt_time='+ dtDate.value + '&p_teetime=' +url_encode(grdData.GetGridData(grdData.row,1))+'&p_course='+lstCourse.value;//grid col 1 is teetime
			 System.OpenTargetPage( System.RootURL+url , "newform" );
	}
	else
	{
		alert("Please,choose group to print.");
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
<body>
	<gw:data id="dso_jabk0090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jabk0090"> 
                <input bind="grdData" > 
                     <input bind="dtDate" /> 
                     <input bind="txtAMPM" />
                     <input bind="lstCourse" /> 
                </input> 
                <output bind="grdData" />  
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">  
		<tr style="height: 100%" valign="top">
            <td>
                <table style="width: 100%; height: 100%" border="0">
					<tr style=" height: 2%">
						<td style="width: 5%;" align="center">Date</td>
						<td width="7%" align="left"><gw:datebox id="dtDate" type="date" lang="1" onchange="OnSearch()" /></td>
						<td style="width: 5%;" align="center">Course</td>
						<td style="width: 5%;" align="center"><gw:list id="lstCourse" styles="width:100%" onchange="OnSearch()" /></td>
						<td style="width: 7%;" align="center">Total : </td>
						<td style="width: 23%;" align="center"><gw:label id="txtCount" /></td>
						<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
						<td style="width:3%">
					            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" styles='width:100%'/>
					    </td>
						<td width="3%" align="right" valign="middle" class="topright"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport2()" /></td>
					    <td style="width:3%">
							<gw:imgBtn id="ibtnReport" alt="Customer Start List Table" img="excel" text="Print" onclick="OnPrint3()" /></td>
							<td style="width:3%">
							<gw:icon id="idRegistration" img="in" text="Registration Form" styles='width:100%' onclick="Registation_OnReport()" /></td>
					<td style="width: 35%;"></td>
					</tr>
					
                    <tr style="height: 98%">
                        <td colspan="12">
                            <gw:grid id="grdData" 
                                header  ="Group|T.O.Time|Player A|Member No|CD#|Player B|Member No|CD#|Player C|Member No|CD#|Player D|Member No|CD#" 
                                format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                aligns  ="1|1|0|1|1|0|1|1|0|1|1|0|1|1" 
                                defaults="|||||||||||||" 
                                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths  ="700|850|2000|1100|700|2000|1100|700|2000|1100|700|2000|1100|700" 
                                sorting ='T'
                                styles  ="width:100%; height:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtAMPM" style="display:none" />
</body>
</html>
