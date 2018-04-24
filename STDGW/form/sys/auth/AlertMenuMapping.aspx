<!-- #include file="../../../system/lib/form.inc"  -->

<script>
var G_No=0,
	G_User_ID=1,
	G_Emp_ID=2,
	G_Emp_Name=3,
	G_PK=4;
var G2_Mapping=0,
	G2_Menu_Alert=1,
	G2_Used=2,
	G2_Description=3,
	G2_PK=4,
	G2_TCO_BSUSER_PK=5,
	G2_TES_ALERTLIST_PK=6;
//_PK|_TCO_BSUSER_PK|_TES_ALERTLIST_PK|Mapping|Menu Alert|Used|Description
function BodyInit()
{
    dsoAlertListCategory.Call("SELECT");
	lstAlertCat.value = "ALL";
}

function SearchUserList()
{
	dsoSearchUserList.Call("SELECT");
}

function SaveMappingChange()
{
	dsoSearchAlertList.Call();
}

function GetAlertListByUser()
{
	//lblUserPK.text = "";
	if(grdUserList.rows <= 1)
		return;
    if(lblUserPK.text == grdUserList.GetGridData(grdUserList.row,G_PK))
        return;
    lblUserPK.text = grdUserList.GetGridData(grdUserList.row,G_PK);
	if(lblUserPK.text == "")
	{
		return;
	}
	else
	{
		dsoSearchAlertList.Call("SELECT");
	}
}

function OnDataReceive(obj)
{
	if (  obj.id == "dsoAlertMenuEntry" )
	{
	  
	    if(sStatus == 2 ||  sStatus == 3)
	    {
	        sStatus = 0;
	        dsoMenuTree.Call("SELECT");
	        
	    }
		return;
	}  
}

function OnDataError(obj)
{
	if (obj.id=="dsoDataList")
    {
		AlertDBError(obj.errmsg)
		return;
	}
	else
	{
		AlertDBError(obj.errmsg)
		return;
	}
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Alert Menu Mapping</title>
</head>
<body>

<gw:data id="dsoSearchUserList"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
    <xml> 
        <dso type="grid" function="SP_es_SEL_USER_LIST"  > 
            <input bind="grdUserList"  > 
                <input bind="txtSearchUserValue" />
            </input> 
            <output bind="grdUserList" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsoSearchAlertList"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6" function="SP_es_SEL_USER_ALERT_LIST"  procedure="SP_es_UPD_USER_ALERT_MAPPING" > 
            <input bind="grdMappingList"  > 
                <input bind="lblUserPK" />
				<input bind="lstAlertCat" />
            </input> 
            <output bind="grdMappingList" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsoAlertListCategory" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
        <xml> 
            <dso  type="list" procedure="SP_es_PRO_ALERT_LIST_CATGORY" > 
                <input></input> 
                <output>
                    <output bind="lstAlertCat" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<table height="100%" width="100%" border = "1">
	<tr height="100%" width="100%">
		<td width="40%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr width="100%" >
					<td width="40%" >Emp ID/Emp Name/User ID</td>
					<td width="30%"><gw:textbox id="txtSearchUserValue" styles="width:100%" /></td>
					<td width="15%"><gw:imgBtn id="btnSearchUser" img="search" alt="Search user" onclick="SearchUserList()" /></td>
					<td width="15%"><gw:label id="lblUser" /> </td>
				</tr>
				<tr height="100%" >
					<td colspan="4">
						<div style="width:100%; height:435; overflow:auto">
							<gw:grid  
									id="grdUserList"  
									header="No|User ID|Emp ID|Emp Name|_PK"
									format="0|0|0|0|0"  
									aligns="0|0|0|0|0"  
									defaults="||||"  
									editcol="0|0|0|0|0"  
									autosize="true"  
									styles="width:100%; height:100%"   
									sorting="T"  paging="true" pageview="17" 
									oncellclick="GetAlertListByUser()"  /> 
						</div>
					</td>
				</tr>
			</table>
		</td>
		</td>
		<td width="60%">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr width="100%" >
					<td width="20%" align = "right" >Alert Category</td>
					<td width="5%"><gw:label id="lblMapping" /> </td>
					<td width="30%"><gw:list id="lstAlertCat" value="ALL" onchange="GetAlertListByUser()">
                    </gw:list></td>
					<td width="45%"><gw:label id="lblMapping" /> </td>
					<td width="5%"><gw:imgBtn id="btnSave" img="save" alt="Save" onclick="SaveMappingChange()" /></td>
				</tr>
				<tr height="100%" >
					<td colspan="5">
						<div style="width:100%; height:435; overflow:auto">
							<gw:grid    
									id="grdMappingList"  
									header="Mapping|Menu Alert|Used|Description|_PK|_TCO_BSUSER_PK|_TES_ALERTLIST_PK"
									format="3|0|3|0|0|0|0"  
									aligns="0|0|0|0|0|0|0"  
									defaults="||||||"  
									editcol="1|0|1|1|0|0|0"  
									autosize="true"   
									styles="width:100%; height:100%"   
									sorting="T"   paging="true" pageview="17"  /> 
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<gw:label id="lblUserPK" style="display:none" />
</body>
</html>
