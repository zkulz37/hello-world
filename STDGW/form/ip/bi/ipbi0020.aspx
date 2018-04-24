<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("STM")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head  runat="server">
    <title>Line Entry</title>
</head>

<script>

function BodyInit()
{
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 1 , " SELECT A.PK, A.FACTORY_NM FROM TST_FACTORY A WHERE A.DEL_IF = 0 ") %>; 
	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 2 , "SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'LT001'") %>; 
	ShowInfo();
	dsoDataList.Call("SELECT");
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
	//mapCtrl.TextMatrix(grdList.rows - 1 , 11) = lstCompany.GetData();
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
	if(CheckValidValue(grdList, 1, "", "Factory can not empty" ) == false 
		|| CheckValidValue(grdList, 3, "", "Line ID can not empty !") == false
		|| CheckValidValue(grdList, 5, "", "Line name can not empty !") == false)
	{
		return;
	}
	else if(CheckDupplicateData(grdList,3 ) > 0)
	{
		return;
	}
	else if(CheckValidNumber(grdList,4, 0,"Capability is a numeric and larger than Zero !") == false)
	{
		return;
	}
	else
	{
		dsoDataList.Call();
	}
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
			if(tmp.TextMatrix(i , col) == tmp.TextMatrix(j , col))
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

function CheckValidValueOnCell(obj, col, row, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    if(tmp.TextMatrix(row , col) == trim(values))
	{
		alert(msg)
		return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
	}
    return true; // khong trung
}

function CheckValidNumber(obj, col, usign,msg)
{
	var ctrl 	= obj.GetGridControl();
	var rownum 	= ctrl.Rows;
	
	if(rownum == 1)
		return false;
	
	var i;
	for(i=1; i<rownum; i++)
	{
		
		var ij_num 	= obj.GetGridData(i, col);
		if (isNaN(ij_num) && ij_num != "")
		{
			alert("Please enter a number at row " + i + " : " + msg);
			return false;
		}
		if (Number(ij_num) <  0 && usign == true)
		{
			alert("Please enter a number larger than 0,  at row " + i + " : " + msg);
			return false;
		}
			
	}
	return true;
	 
}

</script>


<body>

<gw:data id="dsoDataList"  onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="STM.SP_SEL_LINE_LIST"  procedure="STM.SP_UPD_LINE_ENTRY"  > 
            <input bind="grdList"  > 
				<input bind="lstCompany" /> 
				<input bind="txtFilterValue" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data> 

    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
		  <tr >
			<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td width="3%">&nbsp;</td>
				<td width="60">Company</td>
				<td width="12%">
					<gw:list  id="lstCompany" styles='width:100%'onchange="OnSearchData()" >
						<data>
							<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>
						</data>
                    </gw:list>
				</td>
				<td width="3%"></td>
				<td width="80">Search value</td>
				<td width="20%"><gw:textbox id="txtFilterValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()"  /></td>
				<td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" /></td>	
				<td width="12%"> </td>
				<td width="12%"></td>			
				<td width="7%">&nbsp;</td>
				<td width="3%"><gw:imgBtn id="btnAddnew" img="new" alt="Add new item" onclick="OnAddnewData()" /></td>
				<td width="3%"><gw:imgBtn id="btnDelete" img="delete" alt="Delete Selected item" onclick="OnDeleteData()" /></td>
				<td width="3%"><gw:imgBtn id="btnUnDelete" img="udelete" alt="UnDelete Selected item" onclick="OnUnDeleteData()" /></td>
				<td width="3%"><gw:imgBtn id="btnSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData()" /></td>
				<td width="3%">&nbsp;</td>
			  </tr>
			</table></td>
		</tr>
		</tr >
		<tr >
			<td >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%">&nbsp;</td>
						<td width="60%" align="right"><gw:label id="lblRecordCount" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
						<td width="15%">&nbsp;</td>
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
								header="_PK|Factory|Line Type|Line ID|Capability|Line Name|Line Local Name|Line Foreign Name|Description|Start Date|End Date|Used"
								format="0|2|2|0|1|0|0|0|0|4|4|3"  
								aligns="0|0|0|0|0|0|0|0|0|0|0|0"  
								defaults="|||||||||||1"  
								editcol="0|1|1|1|1|1|1|1|1|1|1|1"  
								widths="0|1500|1500|1500|1500|3000|3000|3000|3000|1500|1500|1000"  
								styles="width:100%; height:100%"   
								sorting="T"   
								acceptNullDate
								param="0,1,2,3,4,5,6,7,8,9,10,11" onSelChange="" OnClick=""  />
						</td>
					</tr>
				</table>		
			</td>
		  </tr>
	</table>
</body>
</html>
