<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Housekeeping Assignment</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;

function BodyInit()
{
	BindingDataList();
	dsoTaskPlan.Call("SELECT");
}
function BindingDataList()
{ 
       var data ="#OC;OC|#OD;OD|#VC;VC|#VD;VD|#OOO;OOO"; // status
        //grdHkpAssignment.SetComboFormat(2,data);//
		data ="#VIP1;VIP1|#VIP2;VIP2|#VIP3;VIP3|#;"; // VIP
		//grdHkpAssignment.SetComboFormat(9,data);//VIP
}
function OnSearch()
{
	dsoTaskPlan.Call("SELECT");
}
function OnDataReceive()
{
			
}
function OnNotEdit()
{
	if(grdHkpAssignment.col=='2')
	{
		grdHkpAssignment.rows=-1;
	}
} 
function Onprint()
{
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00300.rpt&procedure=crm.sp_sel_htfo00300&parameter="+dtFrom.value+","+dtTo.value+","+txtStaff.text;   
	  System.OpenTargetPage(url); 
}
</script>
<body>
<gw:data id="dsoTaskPlan" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" function="CRM.sp_sel_htfo00310" procedure="">
			<input bind="grdHkpAssignment">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtStaff" />
			</input> 
			<output bind="grdHkpAssignment" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
	<tr style="width: 100%; height: 1%">
		<td style="width: 100%; background: white" valign="top" >			
			<table style="width: 100%" border="0">
				<tr >
					<td style="width: 5%" align="right" >Date</td>
					<td style="width: 30%" >
						<gw:datebox id="dtFrom" lang="1" styles="width:51%" onchange="OnSearch()" />
						~
						<gw:datebox id="dtTo" lang="1"  styles="width:49%" onchange="OnSearch()" />
					</td>
					<td style="width: 10%" align="right" >Staff</td>
					<td style="width: 15%" >
						<gw:textbox id="txtStaff" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 28%" ></td>
					<td style="width: 3%" >
						<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td style="width: 3%" >
						 <gw:imgbtn img="printer" alt="print" id="btnSayhve" onclick="Onprint()" />  
					</td>
					<td style="width: 3%" >
						
					</td>
					<td style="width: 3%" >
						
					</td>
					<td style="width: 3%" >
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="width: 100%; height: 30%; background: white">
		<td style="width: 100%">
			<gw:grid id="grdHkpAssignment" 
			header="_PK|Date|Status|Type|RM#|_employee_pk|Staff|_Inspector_pk|Inspector|VIP|Remark" 
			format="0|0|0|0|0|0|0|0|0|0|0" 
			aligns="0|0|0|0|0|0|0|0|0|0|0" 
			editcol="0|0|0|0|0|0|0|0|0|0|0" 
			defaults="||||||||||" 
			styles="width:100%;height:100%"
			autosize='T' debug='false'
			  />
		</td>
	</tr>
</table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
