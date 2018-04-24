<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Basic Info for Uniform</title>
</head>
<%EsysLib.SetUser("crm") %>
<script>
function BodyInit()
{       
		var data = "#10; GREEN FEE|#20; CADDIE FEES|#30; CART FEE|#40; GOLFBAG FEE|#50; LIGHT MEAL FEE|#60;OTHERS"; 
		grdMemberEvent.SetComboFormat(2,data);//item type
		OnSearch();
}
function OnCellClickMember()
{
    txtMasterPK.text = grdMember.GetGridData(grdMember.row,0);
    dso_grdMemberEvent.Call('SELECT');
}

function OnSave()
{
    if(checkvalidate())
	{
		dso_grdMemberEvent.Call();
	}
}

function OnSearch()
{
   dso_grdMember.Call('SELECT');
}

function OnDelete()
{
    grdMemberEvent.DeleteRow();
    if(confirm("Do you want to delete this item?"))
    {
        dso_grdMemberEvent.Call();
    }
}
var flag_new="new";
function OnNew()
{
   if(txtMasterPK.GetData()!= "" && flag_new=="new")
   {
		grdMemberEvent.AddRow();
		grdMemberEvent.SetGridText(grdMemberEvent.rows-1 , 1, txtMasterPK.GetData());	
	}
	else
	{
	    alert("Please, select player name to add new(or player name checked out).");
        return false;
	}
}
function checkvalidate()
{
	for (i = 1; i < grdMemberEvent.rows; i++)
	{
		if(grdMemberEvent.GetGridData(i,2)=="")
		{
			alert("Please,input item type at row  "+ i);
			return false;
		}
		if(grdMemberEvent.GetGridData(i,3)=="")
		{
			alert("Please,input item fee at row "+ i);
			return false;
		}
	}
	return true;
}
function Receive(obj)
{
	if(obj.id=='dso_grdMember')
	{
		for ( i = 1; i < grdMember.rows; i ++ )
			{
					var getdata_setcolor="",getdata_date_checkin="",getdata_sysdate="";
					 getdata_setcolor = grdMember.GetGridData(i, 6);//visitorfee_golfer
					 getdata_date_checkin= grdMember.GetGridData(i, 1);
					 getdata_sysdate= grdMember.GetGridData(i, 7);	
					// alert(getdata_sysdate);
					if(getdata_setcolor != "")
					{       
							grdMember.SetCellBgColor(i, 0, i, 5,0XEE82EE);
					}
					else if(getdata_date_checkin != getdata_sysdate)
					{       
							flag_new="select";
							grdMember.SetGridText(i , 0, '');
							grdMember.SetCellBgColor(i, 0, i, 5,0xB3B3D7 );//  
					}
					else if(getdata_date_checkin == getdata_sysdate)
					{
						flag_new="new";
					}
			}
	}
}
</script>

<body>

<gw:data id="dso_grdMember" onreceive="Receive(this)" >
    <xml>
        <dso id="1" type="grid" function="CRM.sp_sel_jabk00120">
            <input bind="grdMember" >
				<input bind="dtDate" />
				<input bind="txtName" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_grdMemberEvent" >
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4" function="crm.sp_sel_jabk00120_1" procedure="crm.sp_upd_jabk00120_1">
            <input bind="grdMemberEvent" >
                <input bind="txtMasterPK" />
            </input>
            <output bind="grdMemberEvent" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr>
        <td width="50%" style="background: white">
            <table  width="100%" height="100%" border="0" >	
				<tr>
				    <td  width="10%">Date</td>
				    <td align = "left" width="20%">
					     <gw:datebox id="dtDate" lang="1" onchange="OnSearch()" />
				    </td>
				   <td  width="10%">Name</td>
				    <td align = "left" width="50%" >
					    <gw:textbox id="txtName" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearch()"  />
				    </td>
					<td width="10%">
                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                   </td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="5" >
						<gw:grid   
						id="grdMember"  
						header="_PK|Date|Locker#|Player Name|Member Type|Tee Off|_TGM_VISITORFEE_GOLFER_PK|_Sysdate"
						format ="0|0|0|0|0|0|0|0"
						aligns ="0|0|0|0|0|0|0|0"
						default="0|0|0|0|0|0|0|0"
						editcol="0|0|0|0|0|0|0|0"
						widths ="0|1500|2500|1000|1000|1000|1000|1000"
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
        <td width="50%" style="background: white">
            <table width="100%" width="100%" height="100%">
                <tr valign="top" style="background: #BDE9FF" height="5%" >        
                    <td style="background: white">
                    <fieldset>
                        <table width="100%" border="0">
                            <tr width="100%">
							<td width="15%">
								</td>
									<td width="7%">
                                      
                                    </td>
									<td width="36%"></td>
                                <td width="3%">
                                    <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnNew()" />
                                 </td>
                                <td width="3%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete()"/></td>
                                <td width="3%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave()"/></td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>           
                </tr>
                <tr valign="top" height="90%">
                    <td colspan="3" width="100%" >
                        <gw:grid   
                        id="grdMemberEvent"  
                        header="_PK|_TGM_VISITORFEE_GOLFER_PK|Item Type|Item Fee|Description"
                        format="0|0|0|-1|0"
                        aligns="0|0|0|0|0"
                        defaults="||||"
                        editcol="1|1|1|1|1"
                        widths="0|0|0|0|0"
                        styles="width:100%; height:100%"  
                        autosize='T' acceptnulldate="T"
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