<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("HR")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
function BodyInit()
{ 
	System.Translate(document);
	// Set data source to Combobox
	var lstStatus_data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0089' ORDER BY CODE_NM")%>|%|Select All";
	lstStatus.SetDataText(lstStatus_data); lstStatus.value = "%";
	GetLastMonth();
	
	grdList.GetGridControl().FrozenCols =6;
    grdList.GetGridControl().ScrollTrack=true;
    
	btnSearch.SetEnable(true);
	btnCancel.SetEnable(false);
	btnNew.SetEnable(true);
	btnMod.SetEnable(false);
	btnDelelte.SetEnable(false);
	txtEmployeePK.text = "<%=session("EMPLOYEE_PK") %>";
	txtCrtBy.text = "<%=session("USER_ID") %>";
}

function OnAddnewData()
{
	System.Menu.NewWindow( "form/ch/ni/chni00010.aspx" , "ID Card Entry", "ID Card Entry", "ID Card Entry" );
	return;
}

function OnCancelData()
{
	//var SourceGrid = grdListUnitCost.GetGridControl();
	if(grdList.GetGridControl().SelectedRows <= 0)
	{
		alert("ID Card not selected")
		return;
	}
	if(txtaCancel.GetData().length < 10)
	{
		alert("Cancel Reason can not empty or too short. Please input Cancel reason.")
		return;
	}
	dsoID_Card_Cancel.Call();
	return;
}

function OnSearchData()
{
	dsoDataList.Call("SELECT");
	btnSearch.SetEnable(true);
	btnCancel.SetEnable(false);
	btnNew.SetEnable(true);
	btnMod.SetEnable(false);
	btnDelelte.SetEnable(false);
}

function OnModifyData()
{
    if(grdList.GetGridControl().SelectedRows <= 0)
	{
		alert("ID Card not selected")
		return;
	}
	var stat = grdList.GetGridData( grdList.row, 15 );
	if( stat != "1" && stat != "7")
	{
		alert("This Id Card can not modify. Modify only when ID Card status is SAVE")
		return;
	}
	var id_card_pk;
    id_card_pk = grdList.GetGridData( grdList.row, 0 );
	if( id_card_pk == "")
	{
		return;
	}
    System.Menu.NewWindow( "form/ch/ni/chni00010.aspx?id_card_pk="+id_card_pk , "ID Card Entry", "ID Card Entry", "ID Card Entry" );
}

function OnDeleteData()
{
	if(grdList.GetGridControl().SelectedRows <= 0)
	{
		alert("ID Card not selected")
		return;
	}
	dsoID_Card_Delete.Call();
}

function OnSelectItem()
{ 
	if(grdList.GetGridControl().SelectedRows <= 0)
	{
		return;
	}
	txtIdCard_pk.text = grdList.GetGridData( grdList.row, 0 );//GetGridData(event.row,0);
	txtaCancel.SetDataText(grdList.GetGridData( grdList.row, 14 ));
	SetButtonAvailable();
	return;
}

function OnDataReceive(obj)
{
	if(obj.id != "dsoDataList")
	{
		dsoDataList.Call("SELECT");
	}
	return;
	
}

function SetButtonAvailable()
{
	//btnSearch
	//btnCancel
	//btnNew
	//btnMod
	//btnDelelte
	/*Check by ID Card State*/
	/* 1 : Save; 2 : Submit; 3 : Cancel; 4 : Order; 5 : Delivered; 6 : Distributed;7:Request more information*/
	var stat = grdList.GetGridData( grdList.row, 15 );
	if( stat == "1" ) // SAVE or SUBMIT
	{
		btnCancel.SetEnable(true);
		btnMod.SetEnable(true);
		btnDelelte.SetEnable(true);
		return;
	}
	if( stat == "2") // SAVE or SUBMIT
	{
		btnCancel.SetEnable(true);
		btnMod.SetEnable(false);
		btnDelelte.SetEnable(false);
		return;
	}
	else if( stat == "3" || stat == "4" || stat == "5" || stat == "6" ) // Cancel
	{
		btnCancel.SetEnable(false);
		btnMod.SetEnable(false);
		btnDelelte.SetEnable(false);
		return;
	}
	else if(stat == "7") {
	    btnCancel.SetEnable(false);
		btnMod.SetEnable(true);
		btnDelelte.SetEnable(false);
	}
	
}

function OnDataError(obj)
{
	if (obj.id=="dsoDataList")
    {
		AlertDBError(obj.errmsg);
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

function GetLastMonth()
{
    sysDate = new Date()
    newDate1 = sysDate.getMonth() 
    if (Number(newDate1) < 10)    
        newDate1="0"+ String(newDate1) 
    newDate2 = sysDate.getDate() 
    if (Number(newDate2) < 10 )
        newdate2="0" +String(newDate2) 
    newDate3 = sysDate.getFullYear()
    
    sysDate = newDate3 + newDate1 + newDate2
    
    datDateModFr.SetDataText(sysDate);
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ID Card List</title>
</head>
<body>
    <gw:data id="dsoDataList" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso type="grid" parameter="0,5,6,7,8,9,10,11" function="HR.SP_SEL_ID_CARD_LIST"  procedure=""  > 
            <input bind="grdList"  > 
				<input bind="datDateModFr" /> 
				<input bind="datDateModTo" /> 	
				<input bind="lstStatus" />
				<input bind="txtCrtBy" />
				<input bind="txtEmployeePK" />
				<input bind="rbType" /> 
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data>
    <gw:data id="dsoID_Card_Cancel" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso type="process"  procedure="HR.SP_PRO_ID_CARD_CANCEL"> 
                <input> 
                    <input bind="txtIdCard_pk" /> 
                    <input bind="txtaCancel" />                                           
                </input> 
                <output>
                    <output bind="txtReturnVal" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="dsoID_Card_Delete" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso type="process"  procedure="HR.SP_PRO_ID_CARD_DELETE"> 
                <input> 
                    <input bind="txtIdCard_pk" />                                       
                </input> 
                <output>
                    <output bind="txtReturnVal" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <table width="100%" height="100%">
        <tr>
            <td>
                <fieldset style="padding: 5">
                    <legend>Search Information</legend>
                    <table width="100%">
                        <tr>
                            <td width="10%">
                                Created Date</td>
                            <td width="8%">
                                <gw:datebox id="datDateModFr" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
                            </td>
                            <td width="1%">
                                ~</td>
                            <td width="8%">
                                <gw:datebox id="datDateModTo" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
                            </td>
                            <td width="3%">
                                Status</td>
                            <td width="15%">
                                <gw:list id="lstStatus" styles='width:100%' onchange=""></gw:list>
                            </td>
                            <td width="17%">
                                <gw:radio id="rbType" value="1" onchange="OnSearchData()">
                                    <span value="1">My application</span>
                                    <span value="2">Application I made</span>
                                </gw:radio>
                            </td>
                            <td width="2%" align="right">
                                <gw:icon id="btnSearch" img="in" text="Search" styles="width:100" onclick="OnSearchData()" />
                            </td>
                            <td width="2%" align="right">
                                <gw:icon id="btnCancel" img="in" text="Cancel" styles="width:100" onclick="OnCancelData()" />
                            </td>
                            <td width="2%" align="right">
                                <gw:icon id="btnNew" img="in" text="New" styles="width:100" onclick="OnAddnewData()" />
                            </td>
                            <td width="2%" align="right">
                                <gw:icon id="btnMod" img="in" text="Modify" styles="width:100" onclick="OnModifyData()" />
                            </td>
                            <td width="2%" align="right">
                                <gw:icon id="btnDelelte" img="in" text="Delete" styles="width:100" onclick="OnDeleteData()" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr height="70%">
            <td>
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr height="100%">
                        <td height="100%">
                            <gw:grid id="grdList" header="_PK|Application No|Emp ID|Emp Name|Department|Group|App Type|Reason|Item|Amount|Submit Date|Status|Remark|_RESPONSE|_REASON_CANCEL|_Status_cd"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" defaults="|||||||||||||||"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="0|1500|2500|3000|2500|2000|2000|2000|2000|0|2000|0|0|0|0|0"
                                styles="width:100%; height:100%" sorting="T" acceptnulldate="T" onclick="OnSelectItem()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
        <tr height="20%">
            <td>
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            Reason of Cancelation :</td>
                    </tr>
                    <tr>
                        <td>
                            <gw:textarea id="txtaCancel" text="" styles="width:100%;height:100%;font-size:15" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtIdCard_pk" styles="display:none" />
    <gw:textbox id="txtCurrStatus" styles="display:none" />
    <gw:textbox id="txtReturnVal" styles="display:none" />
    <gw:textbox id="txtCrtBy" styles="display:none" />
    <gw:textbox id="txtEmployeePK" styles="display:none" />
</body>
</html>
