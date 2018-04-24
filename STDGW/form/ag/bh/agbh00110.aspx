<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{ 
	System.Translate(document);
	// Set data source to Combobox
	var lstCategory_data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0087' ORDER BY CODE_NM")%>|%|Select All";
	lstCategory.SetDataText(lstCategory_data); lstCategory.value = "%";
	
	// Set Product type to grid combo
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 1 , "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0087' ORDER BY CODE_NM") %>;
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 5 , "SELECT V.CODE, V.CHAR_1 || ' - ' || CODE_NM FROM VHR_HR_CODE V WHERE  V.ID='HR0040' ORDER BY V.CODE_NM") %>;
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 10 , "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0003' ORDER BY CODE_NM") %>;
	ShowInfo();
	var con = grdList.GetGridControl();
	con.ColFormat(4) = "###,###,###,###,###.00"; 
	//dsoDataList.Call("SELECT");
}

function OnDataReceive(obj)
{
	if(obj.id == "dsoDataList")
    {
        ShowInfo();
		return;
    }
	return;
}

function ShowInfo()
{
	lblRecordCount.text = grdList.rows - 1 + " record(s) found."
	return;
}

function OnSearchData()
{
	dsoDataList.Call("SELECT");
	return;
}

function CheckValidData()
{
}

function OnAddnewData()
{
	for(i=1; i<grdList.rows;i++)
    {
        if (grdList.GetRowStatus(i) == 32 ) 
        {
            alert("An empty row existed ! Please input data");
			return;
        }
    }
	grdList.AddRow();
	//var mapCtrl = grdList.GetGridControl();
	//mapCtrl.TextMatrix(grdList.rows - 1 , 10) = lstCompany.GetData();
	return;
}

function OnDeleteData()
{
    var mapctrl = grdList.GetGridControl();
    for(i=1; i<grdList.rows;i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdList.DeleteRowAt(i)
        }
    }
}

function OnUnDeleteData()
{
    var mapctrl = grdList.GetGridControl();
    for(i=1; i<grdList.rows;i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdList.UnDeleteRowAt(i)
        }
    }
}

function OnSaveChangedData()
{
	if(CheckDataIsValid() == false)
	{
		return;
	}else
	{
		dsoDataList.Call();
	}
}

    function OnGrdListDblClick()
    {
       if(event.col == 7 || event.col == 8){
        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
        var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if ((object != null) &&(object[0]!="0"))
        {
            grdList.SetGridText(event.row,6,object[3]);//pk
            grdList.SetGridText(event.row,7,object[0]);//code
            grdList.SetGridText(event.row,8,object[1]);//name
        }
       }
    }

function CheckDataIsValid()
{
	if(		CheckValidValue(grdList, 1, "", "Category can not empty. You must select one in list" ) == false 
			|| CheckValidValue(grdList, 2, "", "Type ID can not null" ) == false
			|| CheckValidValue(grdList, 3, "", "Type name can not null" ) == false 
			//|| CheckValidValue(grdList, 7, "", "Account information can not null" ) == false
			|| CheckValueIsNumber(grdList, 4,"Please input numeric for Amount" ) == false
		)
	{
		return false;
	}
	else if(CheckDupplicateData(grdList,2 ) > 0)
	{
		return false;
	}
	return true;
}

function CheckDupplicateData(obj,col )
{
    if(col < 0)
        return -1; // khong trung
    if(obj.Rows <= 1)
        return 0; // khong trung
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        for( j = i+1; j<obj.rows; j++)
		{
			if(tmp.TextMatrix(i , col).toUpperCase() == tmp.TextMatrix(j , col).toUpperCase())
			{
				lb = ("Duplicate data at row : " + j + " with value : " + tmp.TextMatrix(j , col));
				alert(lb)
				return i;
			}
		}
    }
    return 0; // khong trung
}

function CheckValidValue(obj, col, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        if(tmp.TextMatrix(i , col) == values)
		{
			alert(msg)
			return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
		}
    }
    return true; // khong trung
}

function CheckValueIsNumber(obj, col, msg )
{
    if(col < 0)
        return true; // Is number
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        if(isNaN(tmp.TextMatrix(i , col)) == true && tmp.TextMatrix(i , col) != "")
		{
			alert(msg)
			return false; // Not number
		}
    }
    return true; // Is number
}

function CheckValidValueOnCell(obj, col, row, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    if(tmp.TextMatrix(row , col) == values)
	{
		alert(msg)
		return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
	}
    return true; // khong trung
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
    <title>Register Training Course</title>
</head>
<body>

<gw:data id="dsoDataList"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6,9,10,11,12,13,14,15" function="HR_sel_80020010_unit_cost"  procedure="HR_upd_80020009_allow_prob"  > 
            <input bind="grdList"  > 
				<input bind="lstCategory" /> 
				<input bind="txtTypeValue" /> 	
				<input bind="txtAccountValue" /> 
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data> 

    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
		<tr >
			<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="3%"></td>
				<td width="10%" align = "right">Category</td>
				<td width="12%">
					<gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnSearchData()" ></gw:list>
				</td>
				<td width="3%"></td>
				<td width="10%" align = "right">Type ID/Name</td>
				<td width="15%"><gw:textbox id="txtTypeValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()"  /></td>
				<td width="10%" align = "right">Acount ID/Code</td>
				<td width="15%"><gw:textbox id="txtAccountValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()"  /></td>
				<td ></td>
				<td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" /></td>	
				<td width="3%"><gw:imgBtn id="btnAddnew" img="new" alt="Add new item to list" onclick="OnAddnewData()" /></td>
				<td width="3%"><gw:imgBtn id="btnDelete" img="delete" alt="Delete Selected item from list" onclick="OnDeleteData()" /></td>
				<td width="3%"><gw:imgBtn id="btnSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData()" /></td>
				<td width="3%"></td>
			  </tr>
			</table></td>
		</tr>
		<tr >
			<td >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%"></td>
						<td width="60%" align="right"><gw:label id="lblRecordCount" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
						<td width="15%"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="90%">
			<td height="100%">
				<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<gw:grid   
								id="grdList"  
								header="_PK|Category|Type ID|Type Name|Amount|Currency|_Acc_PK|_Acc Code ID|_Acc Code|Leave Y/N
										|Absent Type|Leave Days|Active|Description|Local Name|Foreign Name"
								format="0|0|0|0|0|0|0|0|0|3|0|0|3|0|0|0"
								aligns="0|0|0|0|3|0|0|0|0|0|0|3|0|0|0|0"
								defaults="||||||||||||1|||"
								editcol="0|1|1|1|1|1|0|0|0|1|1|1|1|1|1|1"
								widths="0|2000|1500|2500|1500|1500|0|1500|2000|1000|2000|1500|1000|2000|2000|2000"
								styles="width:100%; height:100%"   
								sorting="T"   
								acceptNullDate
								param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" oncelldblclick="OnGrdListDblClick()" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<gw:list  id="lstCompany" styles='width:100%; display="none"'onchange="OnSearchData()" >
		<data>
			<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>
		</data>
    </gw:list>
</body>
</html>
