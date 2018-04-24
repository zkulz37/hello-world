<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("crm")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Member Operation Detail</title>
</head>
<%EsysLib.SetUser("HR") %>
<script>
function BodyInit()
{       
  var data ="#F;FeMale|#M;Male"; 
        grdMember.SetComboFormat(4,data);
		var l_dtFrm=(dtFrom.GetData());
		var l_get_dt_frm=l_dtFrm.substring(0,4)+"0101";
		dtFrom.value=l_get_dt_frm;
		dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10")%>|ALL|Select All";
		lstMemberType.SetDataText(dataMemberType);
		lstMemberType.value = "ALL";
		OnSearch();
}
function OnCellClickMember()
{
    txtMasterPK.text = grdMember.GetGridData(grdMember.row,0);
    dso_grdMemberEvent.Call('SELECT');
}
function OnSearch()
{
   dso_grdMember.Call('SELECT');
}
function OnSearchDetail()
{
	if(grdMember.row !="-1" && txtMasterPK.text !="")
	{
		dso_grdMemberEvent.Call('SELECT');
	}
	else
	{
		grdMemberEvent.ClearData();
	}
}
function OnPrint()
{
	 if(grdMember.rows > 1)
	 {
			var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ms/jams0140.rpt&procedure=crm.sp_rpt_jams0140&parameter="+txtMasterPK.text+","+dtFrom.value+","+dtTo.value+","+grdMember.GetGridData(grdMember.row,0)+","+grdMember.GetGridData(grdMember.row,0);   
			System.OpenTargetPage(url);                                                                                                           
	 }
}
function OnDataReceive(obj)
{
	if(grdMemberEvent.rows > 1)
	{
		lblRows.text = grdMemberEvent.rows-1+" Row(s).";
	}
}
</script>

<body>

<gw:data id="dso_grdMember" >
    <xml>
        <dso id="1" type="grid" function="crm.sp_sel_jams0050">
            <input bind="grdMember" >
				<input bind="lstMemberType" />
				<input bind="txtID" />
				<input bind="txtName" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_grdMemberEvent" onreceive="OnDataReceive(this)">
    <xml>
        <dso id="1" type="grid" function="CRM.sp_sel_jams0140" >
            <input bind="grdMemberEvent" >
                <input bind="txtMasterPK" />
				<input bind="dtFrom" />
				<input bind="dtTo" />
            </input>
            <output bind="grdMemberEvent" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr>
        <td width="35%" style="background: white">
            <table  width="100%" height="100%" border="0" >	
				<tr>
				    <td  width="20%">Type</td>
				    <td align = "left" width="50%">
					    <gw:list id="lstMemberType" styles='width:100%' onchange="OnSearch()" />
				    </td>
				    <td width="3%">
                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                   </td>
			    </tr>
			    <tr>
				    <td  width="20%">ID</td>
				    <td align = "left" width="50%">
					    <gw:textbox id="txtID" styles="width:100%" alt="Search by ID" onenterkey="OnSearch()"  />
				    </td>
			    </tr>
				<tr>
				    <td  width="20%">Name</td>
				    <td align = "left" width="50%">
					    <gw:textbox id="txtName" styles="width:100%" alt="Search by Name" onenterkey="OnSearch()"  />
				    </td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="3" >
						<gw:grid   
						id="grdMember"  
						header="_PK|Member ID|Member Name|Card Number|Gender"
						format ="0|0|0|0|0"
						aligns ="0|0|0|0|0"
						default="0|0|0|0|0"
						editcol="0|0|0|0|0"
						widths ="0|1500|2500|1500|1200"
						styles="width:100%; height:100%"   
						sorting="T"   
						acceptNullDate="T"
						autosize='T' 
						oncellclick="OnCellClickMember()"  />
					</td>
				</tr>
			</table>
        </td>
        <!------------------------------------------------------------------->
        <td width="65%" style="background: white">
            <table width="100%" width="100%" height="100%">
                <tr valign="top" style="background: #BDE9FF" height="5%" >        
                    <td style="background: white">
                    <fieldset>
                        <table width="100%" border="0">
                            <tr width="100%">
								<td width="5%">Date:</td>
								<td width="18%"><gw:datebox id="dtFrom" lang="1" onchange="OnSearchDetail()" />~<gw:datebox id="dtTo" lang="1" onchange="OnSearchDetail()" /></td>
                                <td width="10%" >Total:</td>
								<td width="64%"><gw:label id="lblRows" /></td>
                                <td width="3%" ><gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" /></td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>           
                </tr>
                <tr valign="top" height="90%">
                    <td colspan="6" width="100%" >
                        <gw:grid   
                        id="grdMemberEvent"  
                        header="Checkin Date|Member ID|Member Name|Member Type|Card No|Bag No|Play Holes|Total USD"
                        format="4|0|0|0|0|0|0|-2"
                        aligns="0|1|0|1|1|1|1|0"
                        defaults="|||||||"
                        editcol="0|0|0|0|0|0|0|0"
                        widths="0|0|1200|1500|1000|2500|2500|1000"
                        styles="width:100%; height:100%"  
                        autosize='T' 
                        sorting="T"
                        />
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
</table>
<gw:textbox id="txtMasterPK" styles="width:100%;display:none" /> 
</body>