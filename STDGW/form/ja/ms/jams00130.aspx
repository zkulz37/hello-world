<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Non Member Handicap Entry</title>
</head>
<%EsysLib.SetUser("crm") %>
<script>
function BodyInit()
{       
	dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10")%>|ALL|Select All";
	lstMemberType.SetDataText(dataMemberType);
	lstMemberType.value = "ALL";
	OnSearch();
}
function OnShowPicture()
{
  var picture_pk = grdMember.GetGridData(grdMember.row,0);
   imgItem_AS_Member.SetDataText(picture_pk); 

}
function OnSearch()
{
	dso_grdMember.Call("SELECT");
}
function OnPrint()
{
	 if(grdMember.rows > 1)
	 {
			 var url = '/reports/ja/ms/rpt_jams00130_member_list.aspx?p_member_type_pk='+lstMemberType.value+'&p_member_id='+idMemberId.GetData()+'&p_member_name='+idMemberNm.GetData();
			System.OpenTargetPage( System.RootURL+url , "newform" );
	 }
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_grdMember')
	{
		txtCount.text=grdMember.rows-1 +" Member(s).";
	}
}
</script>

<body>

<gw:data id="dso_grdMember" onreceive="OnDataReceive(this)"> 
    <xml>
        <dso id="1" type="grid" function="crm.sp_sel_jams00130" procedure="">
            <input bind="grdMember" >
				<input bind="lstMemberType" />
				<input bind="idMemberId" />
				<input bind="idMemberNm" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
	<tr>
		<td width="100%" style="background: white">
            <table  width="100%" height="100%" border="0" >			    
			   <tr style='height: 10%'>
					<td width="40%">
						<table width="100%" height="100%" border="0">
							<tr style='height: 33%'>
									<td width=20%> Type </td>
									<td style="width:77%">
										   <gw:list id="lstMemberType" styles='width:100%' onchange="OnSearch()" />
									</td>
									<td style='width: 3%' align="right"><gw:imgBtn id="idSearch"  alt="Search"  img="search"  onclick="OnSearch()" /></td>
									
							</tr>
							<tr style='height: 33%'>
									<td >Member Id</td>
									<td ><gw:textbox id="idMemberId" styles="width:97%" onenterkey="OnSearch()" /> </td>
									<td >
                                        <gw:imgbtn img="excel" alt="Print" text="Print" id="btnReport" onclick="OnPrint()" />
                                    </td>

							</tr>
							<tr style='height: 34%'>
									<td > Name</td>
									<td ><gw:textbox id="idMemberNm" styles="width:97%" text="" csstype="filter" onenterkey="OnSearch()" /> </td>
									<td ></td>
							</tr>
						</table>
					</td>
					<td width="25%">
						<table width="100%" height="100%" border="0">
							<tr>
									<td>
										<gw:image id="imgItem_AS_Member" table_name="CRM.TGM_MEMBERPHOTO" procedure="CRM.SP_UPD_TGM_MEMBERPHOTO"
														styles="width:100;height:100" style='border: 1px solid #1379AC' view="/binary/ViewFile.aspx"
														post="/binary/PostFile.aspx" style='border: 1px solid #1379AC' />
									</td>
							</tr>
						</table>
					</td>
					<td width="35%">					
						Total:&nbsp;&nbsp;&nbsp<gw:label id="txtCount" styles="width:60%" />
					</td>
			</tr>
				<tr width="100%" height="90%" >
					<td colspan="3">
						<table width="100%" height="100%" border="0">
							<tr>
							<td>
								<gw:grid   
								id="grdMember"  
								header="_picture_pk|Type|ID|Name|Gender|Phone|ID/Passport|Adress|Register Date|Company Name|Active|Birthday|Valid From|Valid To"
								format ="0|0|0|0|0|0|0|0|0|0|3|0|0|0"
								aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								default="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								widths ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								styles="width:100%; height:100%"   
								sorting="T"   
								acceptNullDate="T"
								autosize='T' 
								oncellclick="OnShowPicture()" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
        </td>
	</tr>
   
</table>
<gw:textbox id="txtMasterPK" styles="width:100%;display:none" /> 
</body>