<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Booking Sheet</title>
    <%  ESysLib.SetUser("crm")%>
</head>
<script>
function BodyInit(){
   InitData();
}
function InitData(){
    OnChangeDate();
}
function OnSearch(){
	dso_jabk0110.Call("SELECT");
}

function OnDataReceive(obj){
    if(obj.id == "dso_jabk00110_time"){
		OnSearch();
	}
	else if(obj.id=='dso_jabk0110'){
		txtCount.text       = grdData.rows - 1;
		if(grdData.rows > 1){
		    lbTOT.text      = grdData.GetGridData(1, 14);
		    lbEvent.text    = grdData.GetGridData(1, 15);
		}
		
	}
}
function OnChangeDate(){
	OnSearch_time();
}
function OnPrint(){
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0110.rpt&procedure=CRM.sp_sel_jabk0110&parameter=" + dtDate.GetData()+","+lstTime.GetData();
      System.OpenTargetPage(url); 
}
function OnSearch_time()
{
	dso_jabk00110_time.Call("SELECT");
}
</script>  
<body>
	<gw:data id="dso_jabk0110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jabk0110"> 
                <input bind="grdData" > 
                     <input bind="dtDate" />
					<input bind="lstTime" /> 					 
                </input> 
                <output bind="grdData" />  
            </dso> 
        </xml> 
    </gw:data>
	<gw:data id="dso_jabk00110_time" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="list" procedure="crm.sp_pro_jabk00110" > 
				<input>
					 <input bind="dtDate" /> 
				</input> 
				<output> 
					<output bind="lstTime"/>
				</output>
			</dso> 
		</xml> 
	</gw:data>
    <table style="width: 100%; height: 100%">  
		<tr style="height: 100%" valign="top">
            <td>
                <table style="width: 100%; height: 100%" border="0">
					<tr style=" height: 2%">
						<td style="width: 5%;" align="center">Date</td>
						<td width="7%" align="left"><gw:datebox id="dtDate" type="date" lang="1" onchange="OnChangeDate()" /></td>
						
						<td style="width: 10%;" align="right">Time:</td>
						<td style="width:10%;" align="center"><gw:list id="lstTime" styles="width: 100%" onchange="OnSearch()" /></td>
						<td style="width:5%;" align="center">Groups: </td>
						<td style="width:5%;" align="center"><gw:label id="txtCount" /></td>
						<td width="10%">Event Name:</td>
					    <td width="30%"><gw:label id="lbEvent" /></td>
						<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
						<td style="width:3%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" styles='width:100%'/></td>
					    
					</tr>
					<tr style="height: 98%">
                        <td colspan="10">
                            <gw:grid id="grdData" 
                                header  ="Hole|Group|Player A|Member|CD#|Player B|Member|CD#|Player C|Member|CD#|Player D|Member|CD#|_Teetime|_Event Name" 
                                format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                aligns  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                autosize='T'
                                sorting ='T'
                                styles  ="width:100%; height:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtAMPM" style="display:none" />
	<gw:label id="lbTOT" style="display:none" />
</body>
</html>
