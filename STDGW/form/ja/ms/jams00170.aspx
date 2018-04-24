<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Contract Payment Entry</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var l_crt_by;
var G1_Pk=0,
G1_Date=1,
G1_Contract_No=2,
G1_Title=3,
G1_First_Name=4,
G1_Member_Type=5,
G1_Amount=6,
G1_Payed=7,
G1_Balance=8,
G1_Rate=9;


var G2_pk=0,
G2_Master_pk=1
G2_Date=2,
G2_Amount_USD=3,
G2_Amount_VND=4,
G2_EX_Rate=5,
G2_Receiver_pk=6,
G2_Receiver=7,
G2_Description=8,
G2_Local_Description=9;
function BodyInit()
{
	BindingDataList();
}
function BindingDataList() 
 {
	var data;   
    data = "<%=ESysLib.SetListDataSQL(" select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y' and type=10  order by a.NAME")%>|ALL|Select All";     
	lstMembershipType.SetDataText(data);
	lstMembershipType.value='ALL';
	data = "<%=ESysLib.SetGridColumnDataSQL(" select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y' and type=10  order by a.NAME" ) %> "; 
	grdcontractsearch.SetComboFormat(G1_Member_Type,data);
	grdcontractsearch.SetComboFormat(G1_Title,'#10;Ms|#20;Mr|#30;Mrs|#40;Drs|#50;Pro');
	txtEmpPK.text   =  "<%=Session("EMPLOYEE_PK")%>"  ;
	txtRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_sell_ex_rate(2,'USD') from dual")%>";
 }
var g_lag="";   
function OnSearch(obj)
{
	if(obj=='master')
	{
		dso_jams00170.Call('SELECT');
	}
	if(obj=='detail')
	{
		txtMasterPK.text=grdcontractsearch.GetGridData(grdcontractsearch.row, G1_Pk )
		if(txtMasterPK.text!="")
		{
			dso_jams00170_detail.Call('SELECT');
		}
	}
}
function OnAddNew()
{            
	if(grdcontractsearch.rows >1)
	{
		if(grdcontractsearch.row !='-1')
		{
			grd2.AddRow(); 
			grd2.SetGridText(grd2.rows-1,G2_Master_pk, txtMasterPK.text);	
			grd2.SetGridText(grd2.rows-1,G2_Receiver_pk, txtEmpPK.text); 
			grd2.SetGridText(grd2.rows-1,G2_EX_Rate, txtRate.text);
		}
		else
		{
			alert("Please,chosse contract master to add new!!!");
		}
	}
}

function OnDelete()
{
   /* grd2.DeleteRow();
    if(confirm("Do you want to delete this item?"))
    {
        dso_grd2.Call();
    }*/
}
function Validate()
{
	for(var i=1; i < grd2.rows;i++)
                {
					 if (grd2.GetGridData( i, G2_Date) == '' )
					 {
						alert("Please,input date at row "+i)
						return false;
					 }
					 if (grd2.GetGridData( i, G2_Amount_USD) == '' )
					 {
						alert("Please,input Amount uds to at row "+i)
						return false;
					 }
					 if (grd2.GetGridData( i, G2_Amount_VND) == '' )
					 {
						alert("Please,input amount vnd at row "+i)
						return false;
					 }
					 if (grd2.GetGridData( i, G2_EX_Rate) == '' )
					 {
						alert("Please,input Rate at row "+i)
						return false;
					 }
					 if (grd2.GetGridData( i, G2_Receiver_pk) == '' )
					 {
						alert("Please,input Receiver  at row "+i)
						return false;
					 }
				}	 
				return true;	 
}
function OnSave()
{    
	if(Validate())
	{ 
		dso_jams00170_detail.Call();
	}
}
function OnDelete()
{
	if(grd2.rows >1)
			{
				if(grd2.row !="-1")
				{
					if(confirm('Do you want to delete this contract detail?'))
					{
						if ( grd2.GetGridData( grd2.row, G2_pk ) == '' )
						{
							grd2.RemoveRow();
						}
						else
						{   
							grd2.DeleteRow();
							dso_jams00170_detail.Call();
						}    
					} 
				}					
			}	
}
function OnReditUSD_VND()
{
	var usd,vnd;
	if(grd2.col == G2_Amount_USD)
	{
		vnd=Math.round(Number(grd2.GetGridData(grd2.row, G2_Amount_USD))*Number(txtRate.text));
		grd2.SetGridText(grd2.row,G2_Amount_VND,vnd);	
	}
	if(grd2.col == G2_Amount_VND)
	{
		usd=Number(grd2.GetGridData(grd2.row, G2_Amount_VND))/Number(txtRate.text);
		grd2.SetGridText(grd2.row,G2_Amount_USD,usd);
	}
}
</script>

<body>
<!------------------------------------------------------------------->
    <gw:data id="dso_jams00170" onreceive=""> 
        <xml> 
            <dso type="grid" function="crm.sp_sel_jams00170_M"> 
                <input bind="grdcontractsearch" > 
                    <input bind="dtfrom" /> 
					<input bind="dtTo" /> 
					<input bind="lstMembershipType" /> 
					<input bind="txtName" />
					<input bind="txtContract" />
                </input> 
                <output bind="grdcontractsearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
	<gw:data id="dso_jams00170_detail" onreceive=""> 
        <xml> 
            <dso type="grid"  parameter="0,1,2,3,4,5,6,7,8,9" function="crm.sp_sel_jams00170_dtl" procedure="crm.sp_upd_jams00170_dtl"> 
                <input bind="grd2" > 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grd2" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 2%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td align="right" width="5%">
                                                        Date</td>
                                                    <td width="10%">
                                                        <gw:datebox id="dtfrom" lang="1" onchange="OnSearch('master')" />
                                                    </td>
													<td align="center">~</td>
													<td width="10%">
                                                        <gw:datebox id="dtTo" lang="1" onchange="OnSearch('master')" />
                                                    </td>
                                                    <td align="right" width="10%"> 
                                                        Member Type</td>
                                                    <td width="15%">
                                                         <gw:list id="lstMembershipType" styles="width:100%"  onchange="OnSearch('master')"/>
                                                    </td>
                                                    <td  align="right"width="5%">
													Name 
                                                    </td>
                                                    <td width="16%"align="right">
                                                        <gw:textbox id="txtName" styles='width:100%' onenterkey="OnSearch('master')" />
                                                    </td>
													<td align="right"width="10%">
													Contract No
                                                    </td>
													<td width="16%">
													<gw:textbox id="txtContract" styles='width:100%' onenterkey="OnSearch('master')" />
													 </td>
												                                                   
													<td width="3%"><gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="search" onclick="OnSearch('master')" /></td>
                                                    <td>
                                                        <gw:label id="txtCount" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
		
        <tr style="width: 100%; height: 48%">
            <td width="100%" >
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            <gw:grid id="grdcontractsearch" header="_pk|Date|Contract No|Title|Member Name|Member Type|Amount|Payed|Balance|Rate(%)"
                                format="0|4|0|0|0|-0|0|-1|-0|0" 
								aligns="0|0|0|0|0|0|3|0|0|3"
                                editcol="0|0|0|0|0|0|0|0|0|0" 
								styles="width:100%; height:100%" oncellclick="OnSearch('detail')"
                                sorting="T" autosize="T"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
		
		<tr style="width: 100%; height: 50%">
            <td width="100%" >
                <table valign='top'  cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
					<tr style="height: 2%">
						<td width="94%">
							
						</td>
						<td width="2%">
						<gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnAddNew()" />
						</td>
						<td width="2%">
						<gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete()"/>
						</td>
						<td width="2%">
							<gw:imgBtn img="save"   alt="Save"     onclick ="OnSave()"/>
						</td>
					</tr> 
				<tr valign="top" style="height: 98%">
					<td colspan="10" >
						<gw:grid id="grd2" header="_pk|_Master_pk|Date|Amount (USD)|Amount (VND)|EX.Rate|_Receiver_pk|Receiver|Description|Local Description"
							format="0|0|4|-1|-0|-0|0|0|0|0" 
							aligns="0|0|0|0|0|0|0|0|0|0"
							editcol="1|1|1|1|1|0|0|0|1|1" 
							styles="width:100%; height:100%" 
							sorting="T" autosize="T" onafteredit="OnReditUSD_VND()"  />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
  <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" /> 
 <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" /> 
 <gw:textbox id="txtRate" styles="width: 100%;display: none" />  
</body>
</html>