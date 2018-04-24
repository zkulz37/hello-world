<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Check In</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var _user_id = "<%=Session("USER_ID")%>";
function BodyInit()
 {
	var data="";
	data = "<%=ESysLib.SetListDataSQL("SELECT code,NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PTYPE' and code not in('PTYPE-04')" )%>|ALL|Select All"; 
	lstPaymentMethod.SetDataText(data);
	lstPaymentMethod.value = 'ALL';
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT code,NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PTYPE'")%>";
	grdMST.SetComboFormat(26, data);//payment method
	var l_date=(dtDate.GetData());
	var l_date_from=l_date.substring(0,6)+"01";
	dtDate.value=l_date_from;
	grdMST.GetGridControl().FrozenCols = 5;
	OnSearch();
 }
function OnSearch()
{
	dso_htfo00270.Call('SELECT');
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_htfo00270')
	{
		txtCount.text=grdMST.rows-1+ "   Room(s).";
		if (grdMST.rows > 1)
		{		
				grdMST.Subtotal( 1, 2, -1, '7!8!9!10!11!12!13!14!15!16!17!18!19!20!21!22!23!24!25');
		}
	}
}
function OnReport()
{
	// url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00270.rpt&procedure=CRM.sp_sel_htfo00270_rpt&parameter="+dtDate.value;  
         //System.OpenTargetPage(url);  
		 url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00270_1.rpt&procedure=CRM.sp_sel_htfo00270_1_rpt&parameter="+dtDate.value+","+dtDateTo.value;   //+","+dtDateTo.value
         System.OpenTargetPage(url);  
}
function OnPopUp(obj)
{		
	if(obj=='customer_s')
	{
		var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				txtCompany_PK.text  = object[0]; 
				txtCompanyNameS.text			= object[3];
				OnSearch();
			}
	}
}
</script>
<body>
<gw:data id="dso_htfo00270" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid"   function="CRM.sp_sel_htfo00270" >
			<input bind="grdMST">
				<input bind="dtDate" />
				<input bind="dtDateTo" />
				<input bind="txtRoom" />
				<input bind="lstPaymentMethod" />
				<input bind="txtCompany_PK" />
			</input> 
			<output bind="grdMST" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
	<tr style="width: 100%; height: 1%">
		<td style="width: 100%; background: white" valign="top" >			
			<table style="width: 100%" border="0">
				<tr >
					<td style="width: 5%" align="right" nowrap >Date</td>
					<td style="width: 8%" >
						<gw:datebox id="dtDate" lang="<%=Session("Lang")%>" onchange="OnSearch()" />~<gw:datebox id="dtDateTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
					</td>
					<td style="width: 5%" align="right" nowrap >Room</td>
					<td style="width: 8%" >
						<gw:textbox id="txtRoom" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					
					<td width="12%" align="right">
						Payment Method
					 </td>
					<td style="width: 14%; white-space: nowrap">
						<gw:list id="lstPaymentMethod" styles='width:100%' onchange='OnSearch()' />
					</td>
					<td style="width: 5%">
						<a href="#" onclick="OnPopUp('customer_s')">Customer</a></td> 
					<td style="width: 19%; white-space: nowrap">
						<gw:textbox id="txtCompanyNameS" styles="width:100%" readonly="true" />   
					</td>
					<td style="width: 1%" ><gw:imgbtn id="btnClearGolf" img="reset" alt="Reset" onclick="txtCompanyNameS.text='';txtCompany_PK.text='';" /></td>
					<td style="width: 5%" >Total :</td>
					<td style="width: 12%" align="center">
						 <gw:label id="txtCount" />
					</td>
					<td style="width: 3%" >
						<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                    </td>	
				</tr>
			</table>
		</td>
	</tr>
	<tr style="width: 100%; height: 30%; background: white">
		<td style="width: 100%">
			<gw:grid id="grdMST" 
			header="_PK|Room#|Invoice No|Last Name|First Name|Checkin|Checkout|Night|Total Due|Actual Payed|Return(VND)|Cash (VND)|Cash(USD)|Credit Card(VND)|Credit Card(USD)|AR(VND)|Room Charge|Restaurant|Minibar|Laudry|Telephone|Others|Other Golf|Package Golf|Advance|Adjust|Pay Method|Customer" 
			format="0|0|0|0|0|4|4|-0|-0|-0|-0|-0|1|-0|1|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0"			
			styles="width:100%;height:100%"
			autosize='T'
			debug='false'
			acceptnulldate="T"
			oncelldblclick="OnGetRoom()" />
		</td>
	</tr>
</table>
<gw:textbox id="txtMasterPK" style="display: none" />
<gw:textbox id="txtTEMP" style="display: none" />
<gw:textbox id="txtCompany_PK" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
