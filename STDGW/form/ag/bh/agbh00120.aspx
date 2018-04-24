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
	grdListMapping.AddRow();
	
	//MergeHeader();
	
	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
        lstCompany.SetDataText(ls_company);
	lstCompany.value = "<%=Session("COMPANY_PK")%>";
	
	dsoGetCostCenterByCompany.Call();
	
	MergeHeader();
}


function MergeHeader()
{
    var fg = grdListMapping.GetGridControl();  
    
    grdListMapping.SetCellBold(1,1,1,9,true);
    fg.FixedRows = 2;
    fg.FixCols = 1;
    fg.MergeCells = 5;
	
	fg.MergeCol(0) = true;
    fg.Cell(0, 0, 0, 1, 0) = "_PK";
	
	fg.MergeCol(1) = true;
    fg.Cell(0, 0, 1, 1, 1) = "_CC_PK";
	
	fg.MergeCol(2) = true;
    fg.Cell(0, 0, 2, 1, 2) = "_CT_PK";
	
	fg.MergeCol(3) = true;
    fg.Cell(0, 0, 3, 1, 3) = "_ACC_PK";
    
	fg.MergeRow(0) = true;
    fg.Cell(0, 0, 4, 0, 5) = "Cost Center";
    fg.Cell(0, 1, 4, 1)    = "C.C ID";
    fg.Cell(0, 1, 5, 1 )   = "C.C Name";
	
	fg.MergeRow(0) = true;
    fg.Cell(0, 0, 6, 0, 7) = "Unit Cost";
    fg.Cell(0, 1, 6, 1)    = "C.T ID";
    fg.Cell(0, 1, 7, 1 )   = "C.T Name";
	
	fg.MergeRow(0) = true;
    fg.Cell(0, 0, 8, 0, 9) = "Account";
    fg.Cell(0, 1, 8, 1)    = "Acc Code";
    fg.Cell(0, 1, 9, 1 )   = "Acc Name";
	
    fg.MergeCol(10) = true
    fg.Cell(0, 0, 10, 1, 10) = "Description";
	
	fg.MergeCol(11) = true
    fg.Cell(0, 0, 11, 1, 11) = "Used";
    
}

function OnChangeCompany()
{
	dsoGetCostCenterByCompany.Call();
}

function OnDataReceive(obj)
{
	if(obj.id == "dsoGetCostCenterByCompany")
    {
		dsoGetCostCenterInfoByCompany.Call();
		ShowInfo();
		return;
    }
	if(obj.id == "dsoGetCostCenterInfoByCompany")
    {
		dsoCostCenterMapping.Call("SELECT");
		ShowInfo();
		return;
    }
	if(obj.id == "dsoCostCenterMapping")
    {
		MergeHeader();
		ShowInfo();
		return;
    }
	ShowInfo();
	
}

function ShowInfo()
{
	lblRecCntCC_Mapping.text = grdListMapping.rows - 2 + " record(s) found."
	lblRecCntUC.text = grdListUnitCost.rows - 1 + " record(s) found."
	return;
}

function OnSearchData(flag)
{
	if(flag == "UNIT_COST")
	{
		dsoGetCostCenterInfoByCompany.Call();
		
		dsoDataListUnitCost.Call("SELECT");
		return;
	}
	else if(flag == "COST_MAPPING")
	{
		dsoGetCostCenterInfoByCompany.Call();
		return;
	}
	else { return; }
}

function OnUnDeleteData()
{
    var mapctrl = grdListMapping.GetGridControl();
    for(i=1; i<grdListMapping.rows; i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdListMapping.UnDeleteRowAt(i)
        }
    }
}

function OnDeleteData() 
{
	var mapCtrl = grdListMapping.GetGridControl();
	if (mapCtrl.SelectedRows >0) 
	{
		for (i=mapCtrl.Rows-1;i>0;i--) 
		{
			//Add row to mapping grid
			if (mapCtrl.IsSelected(i)) 
			{
				grdListMapping.DeleteRowAt(i)//RemoveItem(i);
			}
		}
	} 
	else 
	{
		alert ("Please select Client Object for removing.\nCh?n ít nh?t m?t dòng d? xóa.");			
	}
}

function OnSaveChangedData()
{
	if(CheckDataIsValid() == false)
	{
		return;
	}else
	{
		dsoCostCenterMapping.Call();
		return;
	}
}

function CheckDataIsValid()
{
	if(CheckValidValue(grdListMapping, 3, "", "Please Double Click on Account cell and select one account" ) == false  )
	{
		return false;
	}
	return true;
}

function OnGrdListDblClick()
{
	if(event.col == 8 || event.col == 9)
	{
		//var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
		//var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
		var fpath = System.RootURL + "/form/ag/io/Get_Acc_Mapping.aspx?ItemType=" + "BUDGET"  + "&Company=" + lstCompany.value + "&ItemValue=" + lstCostCenter.value + "&Action=" + "UPDATE" + "&dsqlid=ACNT.SP_SEL_ACC_MAPPING";
		var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 

		if ((object != null))
		{
			grdListMapping.SetGridText( grdListMapping.GetGridControl().SelectedRow(0), 3, object[3] );//pk
			grdListMapping.SetGridText( grdListMapping.GetGridControl().SelectedRow(0), 8, object[1] );//code
			grdListMapping.SetGridText( grdListMapping.GetGridControl().SelectedRow(0), 9, object[2] );//name
		}
	}
}

function  PassGrid(flag)
{
	/* flag == true : grdListEmp ==> grdListCourse*/
	/* flag == false : grdListCourse ==> grdListEmp*/
	if(flag == true)
	{
		var SourceGrid = grdListUnitCost.GetGridControl();
		var DestinationGrid = grdListMapping.GetGridControl();
		if(SourceGrid.SelectedRows <= 0)
        {
            alert("Employee not selected")
            return;
        }
        else
        {
            for(i=SourceGrid.Rows-1; i>=0; i--)
            {
                if (SourceGrid.IsSelected(i)) 
                {
					if(lstCostCenter.value == null || lstCostCenter.value == "")
					{
						alert("Please select cost center first");
						return;
					}
					grdListMapping.AddRow();
                    grdListMapping.GetGridControl().TopRow = grdListMapping.rows-1;
					
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 1) = lstCostCenter.value; //C.C PK
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 4) = txtCostCeterID.text; //C.C ID		
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 5) =  txtCostCeterName.text;// C.C Name
					
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 2) = SourceGrid.TextMatrix(i,0); //C.T PK
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 6) = SourceGrid.TextMatrix(i,2); //C.T ID		
					DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , 7) =  SourceGrid.TextMatrix(i,3);// C.T Name
					
					//grdListUnitCost.SetCellBgColor( i,1, i, 4, 0xFF6A73);
					//grdListUnitCost.SetCellBgColor( i,1, i, 4, 0x000000);
					grdListUnitCost.RemoveRowAt(i);
				}	
            }
        }
	}
	else
	{
		return;
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
    <title>Cost Type Mapping</title>
</head>
<body>

<gw:data id="dsoDataListUnitCost"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3" function="HR_SEL_80020011_UNIT_COST"  procedure=""  > 
            <input bind="grdListUnitCost"  > 
				<input bind="lstCategory" /> 
				<input bind="txtTypeValue" /> 	
            </input> 
            <output bind="grdListUnitCost" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsoCostCenterMapping"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,10,11" function="hr_SEL_80020011_PLC_MAPP"  procedure="hr_upd_80020011_PLC_MAPP"  > 
            <input bind="grdListMapping"  > 
				<input bind="lstCostCenter" /> 
            </input> 
            <output bind="grdListMapping" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsoGetCostCenterByCompany" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)"  > 
	<xml> 
		<dso  type="list" procedure="HR_PRO_80020011_COST_LIST_NALL" > 
			<input>
				<input bind="lstCompany" /> 
			</input> 
			<output>
				<output bind="lstCostCenter" />
			</output>
		</dso> 
	</xml> 
</gw:data>

<gw:data id="dsoGetCostCenterInfoByCompany" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_PRO_80020011_COST_C_INFO" > 
                <input>
                    <input bind="lstCostCenter" />
                </input> 
                <output>
                    <output bind="txtCostCeterID" />
                    <output bind="txtCostCeterName" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<table width = "100%" height = "100%" border = "1">
	<tr >
		<td width = "40%" height = "100%">
			<table width = "100%" height = "100%" >
				<tr width = "100%" >
					<td><fieldset style="padding: 0"> <legend>Unit Cost Information</legend>
						<table table width = "100%" height = "100%" >
							<tr>
								<td width = "5%">
								<td width = "25%">Category</td>
								<td width = "65%" colspan = "3"><gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnSearchData('UNIT_COST')" ></gw:list></td>
								<td width = "5%">
								</td>
							</tr>
							<tr>
								<td width = "5%"></td>
								<td width = "25%">Type ID/Name</td>
								<td width = "55%"><gw:textbox id="txtTypeValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('UNIT_COST')"  /></td>
								<td width = "10%"><gw:imgBtn id="btnSearchUC" img="search" alt="Search item" onclick="OnSearchData('UNIT_COST')" /></td>
								<td width = "5%"><gw:icon id="BtnPassGrid" img="in" text = "Pass" alt="Pass selected employee to Course result" onclick="PassGrid(true)" /></td>
								<td width = "5%"></td>
								</td>
							</tr>
						</table></fieldset>
					</td>
				</tr>
				<tr>
					<td align = "right"><gw:label id="lblRecCntUC" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
				</td>
				<tr height="90%">
					<td height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<gw:grid   
										id="grdListUnitCost"  
										header="_PK|Category|Type ID|Type Name"
										format="0|0|0|0"
										aligns="0|0|0|0"
										defaults="|||"
										editcol="0|0|0|0"
										widths="0|2000|1500|2500"
										styles="width:100%; height:100%"   
										sorting="T"   
										acceptNullDate
										param="0,1,2,3" oncelldblclick="PassGrid(true)" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td width = "60%" height = "100%">
			<table width = "100%" height = "100%" >
				<tr width = "100%" >
					<td><fieldset style="padding: 0"> <legend>Mapping Information</legend>
						<table table width = "100%" height = "100%" >
							<tr>
								<td width = "3%">
								<td width = "10%">Company</td>
								<td width = "25%" colspan = "3"><gw:list  id="lstCompany" value = "%" styles='width:100%'onchange="OnChangeCompany()" ></gw:list></td>
								<td width = "10%">Cost Center</td>
								<td width = "30%"><gw:list  id="lstCostCenter" value = "%" styles='width:100%'onchange="OnSearchData('COST_MAPPING')" ></gw:list></td>
								<td></td>
								<td width = "3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData('COST_MAPPING')" /></td>
								<td width="3%"><gw:imgBtn id="idUDelete" img="udelete" alt="UnRemove" text="UnDelete" onclick="OnUnDeleteData()"/></td>
								<td width="3%"><gw:imgBtn id="idDelete" img="delete" alt="Remove" text="Delete" onclick="OnDeleteData()"/> </td>				
								<td width="3%"><gw:imgBtn id="idBtnSave" img="save" alt="Save" text="Save" onclick="OnSaveChangedData()"/></td>
								<td width = "3%"></td>
							</tr>
						</table></fieldset>
					</td>
				</tr>
				<tr>
					<td align = "right"><gw:label id="lblRecCntCC_Mapping" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
				</td>
				<tr height="90%">
					<td height="100%">
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<gw:grid   
										id="grdListMapping"  
										header="_0|_1|_2|_3|4|5|6|7|8|9|10|11"
										format="0|0|0|0|0|0|0|0|0|0|0|3"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="|||||||||||1"
										editcol="0|0|0|0|0|0|0|0|0|0|1|1"
										widths="0|0|0|0|1200|2500|1200|2500|1200|2500|2500|1000"
										styles="width:100%; height:100%"   
										sorting="T"   
										acceptNullDate
										param="0,1,2,3,4,5,6,7,8,9,10,11" oncelldblclick="OnGrdListDblClick()" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<gw:textbox id="txtCostCeterID" styles="display:none" />
<gw:textbox id="txtCostCeterName" styles="display:none" />
</body>
</html>
