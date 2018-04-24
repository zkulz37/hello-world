<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Member Fee Collection</title>
     <%  ESysLib.SetUser("crm")%>

<script>

var emp_pk = "<%=Session("EMPLOYEE_PK")%>";
var employee = "<%=Session("USER_NAME")%>";
var row_member_fee = 0;
var update = false;

var COL_MEMBER_PK			= 0,
	COL_MEMBER_ID			= 1,
	COL_MEMBER_NAME			= 2,
	COL_MEMBER_MEMBER_TYPE	= 3,
	COL_MEMBER_GENDER		= 4,
	COL_MEMBER_PHONE		= 5,
	COL_MEMBER_ADDRESS		= 6;

var COL_FEE_NO					= 0,
	COL_FEE_PK					= 1,
	COL_FEE_TYPE				= 2,
	COL_FEE_AMT					= 3,
	COL_FEE_AMT_USD				= 4,
	COL_FEE_FROM				= 5,
	COL_FEE_TO					= 6,
	COL_FEE_RECEIVED_AMT		= 7,
	COL_FEE_TCM_MEMBER_PK		= 8,
	COL_FEE_TGM_CUS_GRPPRICE_PK	= 9;

var COL_COLLE_NO				= 0,
	COL_COLLE_PK				= 1,
	COL_COLLE_DATE				= 2,
	COL_COLLE_AMT				= 3,
	COL_COLLE_RECEIVER			= 4,
	COL_COLLE_TCM_MEMBER_FEE_PK = 5,
	COL_COLLE_RECEIVER_PK		= 6;

function BodyInit()
{
	OnSearch(1);
	Binding();
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dsoGrdMember.Call('SELECT');
		break;
	}
}
function Binding()
{
    var dataMemberType;
    dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and type=10 ")%>|ALL|Select All";
    lstMemberType.SetDataText(dataMemberType);
    lstMemberType.value='ALL';
}

function onClick(n)
{
	switch(n)
	{
		case 1:
			if (grdMember.rows > 1)
			{
				txtMemberPK.text = grdMember.GetGridData(grdMember.row, 1);
				dsoGrdMemberFee.Call('SELECT');
			}
			
		break;
	}
}
function OnDataReceive()
{
    
}
function  OnPrint()
{
//	var arr_pk ="";
//	var rqt = "";
//	var tmp ="",arr_master_pk="";
//	var bl = 0;
	var url ="";
//	for (i = 1; i < grdMember.rows; i++)
//	{
//		if((grdMember.GetGridData(i,0)=="-1") &&(grdMember.GetGridData(i, 1)!=""))
//		{
//			arr_pk = arr_pk + tmp +grdMember.GetGridData(i, 1);
//			arr_master_pk = arr_master_pk + tmp +grdMember.GetGridData(i, 2);
//			tmp = '*';
//			bl = 1;
//		}
//	}
	if (grdMember.GetGridData(grdMember.row)!="-1")
	{
		 url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ms/jams0080.rpt&procedure=crm.sp_sel_jams0060_6|crm.sp_sel_jams0060_5|crm.sp_sel_jams0060_7&parameter="+grdMember.GetGridData(grdMember.row, 1)+"|"+grdMember.GetGridData(grdMember.row, 1)+"|"+grdMember.GetGridData(grdMember.row, 1);   
         System.OpenTargetPage(url);  
	 }
	 else
	 {
	    alert("Please check Member to print");
		return;
	 }
   
}
</script>
</head>
<body>
<gw:data id="dsoGrdMember" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" function="crm.sp_sel_jams0060_3" >  
			<input bind="grdMember" >  
				<input bind="txtMember" />	
				<input bind="lstMemberType" /> 															
			</input> 
			<output bind="grdMember" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dsoGrdMemberFee" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" parameter="1,3,4,5,6,8,9" function="crm.sp_sel_jams0060_4" procedure="crm.sp_upd_jams0060_1" >  
			<input bind="grdMemberFee" >  
				<input bind="txtMemberPK" />	 															
			</input> 
			<output bind="grdMemberFee" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="background: #BDE9FF; height: 100%; width: 100%">
	<tr>
		<td style="background: white; width: 35%">
			<table style="height: 100%; width: 100%">
				<tr style="height: 1%">
					<td style="width: 20%" align="center" >Member</td> 
					<td style="width: 77%"><gw:textbox id="txtMember" styles="width: 100%" onenterkey="OnSearch(1)" /></td>
					<td style="width: 3%"><gw:imgbtn img="excel" alt="Print Bill" onclick="OnPrint()" /></td>
				</tr>
				<tr style="height: 1%">
					<td style="width: 20%" align="center" >Type</td> 
					<td style="width: 77%"><gw:list id="lstMemberType" styles='width:100%' onchange="OnSearch(1)" /></td>
					<td style="width: 3%"><gw:imgbtn img="search" alt="Search" onclick="OnSearch(1)" /></td>
				</tr>
				<tr style="height: 99%">
					<td colspan="6">
						<gw:grid id="grdMember" header='_Check|_membertype_pk|_member_pk|ID|Name|Member Type|Gender|Phone|Address'
							format='3|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0' defaults='||||||||'
							editcol='0|0|0|0|0|0|0|0|0' widths='0|0|0|0|0|1500|0|0|0'
							sorting='T'  autosize='T' styles="width:100%;height:100%" 
							oncellclick="onClick(1)" />
					</td>
				</tr>
			</table>
		</td>
		<td style="background: white; width: 65%">
			<table style="height: 100%; width: 100%" >
				<tr style="height: 59%" width="100%">
					<td style="width: 100%" colspan="5">
						<gw:grid id="grdMemberFee" header='No|_PK|Fee Name|_Fee AMT|Fee AMT(USD)|Form|To|Received AMT|_TCM_MEMBER_PK|_TGM_CUS_GRPPRICE_PK'
						format ='0|0|0|1|1|4|4|1|0|0' aligns='3|0|0|3|3|0|0|3|0|0' defaults='|||||||||'
						editcol='0|0|0|1|1|1|1|0|0|0' widths='0|1500|1500|1500|2000|2000|2000|0|0|0'
						sorting='T' autosize='F' oncellclick="onClick(2)" onafteredit='AfterEdit(1)' styles="width:100%;height:100%" />  
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
<gw:textbox id="txtMemberPK" style="display:none"/>
<gw:textbox id="txtMemberFeePK" style="display:none"/>
</html>
