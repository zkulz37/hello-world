<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
function BodyInit()
{
    MergeHeader();
   <%=ESysLib.SetGridColumnComboFormatString2( "grdList" ,4 , "1|Option 1|2|Option 2|3|Option 3") %>;
   var lstEvaYear_Data = "<%=ESysLib.SetListDataSQL("SELECT PK, E.EVA_YYYY || ' - ' || E.EVA_SEQ FROM THR_EVA_MASTER E WHERE E.DEL_IF = 0 ORDER BY E.EVA_YYYY || ' - ' || E.EVA_SEQ DESC")%>";
   lstEvaYear.SetDataText(lstEvaYear_Data); 
   OnSelectEvaYear();
}
   

function MergeHeader()
{
    var tmp=grdList.GetGridControl();  
    grdList.AddRow()
    grdList.SetCellBold(1,1,1,10,true);
    tmp.FixedRows = 2
    tmp.FixCols= 3;
    tmp.MergeCells = 5
    
    tmp.MergeCol(3) = true
    tmp.Cell(0, 0, 3, 1, 3) = "Number of Employee"
	
    tmp.MergeCol(4) = true
    tmp.Cell(0, 0, 4, 1, 4) = "Option"
	    
    tmp.MergeRow(0) = true
    tmp.Cell(0, 0, 5, 0, 10) = "GRADE"
    tmp.Cell(0, 1, 5, 1)    = "S"
    tmp.Cell(0, 1, 6, 1 )   = "A"
    tmp.Cell(0, 1, 7, 1)    = "B"
    tmp.Cell(0, 1, 8, 1)    = "C"
	tmp.Cell(0, 1, 9, 1)    = "D"
	tmp.Cell(0, 1, 10, 1)    = "E"
    
	/*fg.ColWidth(0)=800; // No.
    fg.ColWidth(1)=800; // No.
    fg.ColWidth(2)=1400; // Order No.
    fg.ColWidth(3)=1300; // Code
    fg.ColWidth(4)=2000; // Name
    fg.ColWidth(5)=1800; // HS Code 
    fg.ColWidth(6)=1200; // unit
    fg.ColWidth(7)=1200; // unit packing
	*/
}

function SetGridHeader(headerList)
{
	colHeader = headerList.split("|");
	var tmp =grdList.GetGridControl();  
	grdList.SetCellBold(1,1,1,10,true);
    tmp.FixedRows = 2
    tmp.FixCols= 3;
    tmp.MergeCells = 5
    
    tmp.MergeCol(3) = true
    tmp.Cell(0, 0, 3, 1, 3) = "Number of Employee"
	
    tmp.MergeCol(4) = true
    tmp.Cell(0, 0, 4, 1, 4) = "Option"
	    
    tmp.MergeRow(0) = true
    tmp.Cell(0, 0, 5, 0, 10) = "GRADE"
	tmp.Cell(0, 1, 5, 1)    = colHeader[0];
    tmp.Cell(0, 1, 6, 1 )   = colHeader[1];
    tmp.Cell(0, 1, 7, 1)    = colHeader[2];
    tmp.Cell(0, 1, 8, 1)    = colHeader[3];
	tmp.Cell(0, 1, 9, 1)    = colHeader[4];
	tmp.Cell(0, 1, 10, 1)    = colHeader[5];
	/*tmp.TextMatrix(1 , 2) = colHeader[0];
	tmp.TextMatrix(1 , 3) = colHeader[1];
	tmp.TextMatrix(1 , 4) = colHeader[2];
	tmp.TextMatrix(1 , 5) = colHeader[3];
	tmp.TextMatrix(1 , 6) = colHeader[4];
	tmp.TextMatrix(1 , 7) = colHeader[5];*/
}

function CheckDataIsValid()
{
	if( CheckValidValue(grdList, 0, "", "Unkown Evaluation Year number" ) == false 
		|| CheckValidValue(grdList, 4, "", "You must select one Option" ) == false )
	{
		return false;
	}
	if(CheckValidNumber(grdList, 5, true, "") == false
		|| CheckValidNumber(grdList, 6, true, "") == false
		|| CheckValidNumber(grdList, 7, true, "") == false
		|| CheckValidNumber(grdList, 8, true, "") == false
		|| CheckValidNumber(grdList, 9, true, "") == false
		|| CheckValidNumber(grdList, 10, true, "") == false)
	{
		return false;
	}
	return true;
}

function OnSearchData()
{
	if(lstEvaYear.GetData() == "")
	{
		alert("Unknown Evaluation number, select one in list before Searching");
		return;
	}
	dsoLoadEvaGradeTO.Call("SELECT");
}

function OnAddnewData()
{
	if(lstEvaYear.GetData() == "")
	{
		alert("Unknown Evaluation number, select one in list before add new data");
		return;
	}
	/*for(i=2; i<grdList.rows;i++)
    {
        if (grdList.GetRowStatus(i) == 32 ) 
        {
            alert("An empty row existed ! Please input data");
			return;
        }
    }*/
	grdList.AddRow();
	var mapCtrl = grdList.GetGridControl();
	/*
	mapCtrl.TextMatrix(grdList.rows - 1 , 0) = lstEvaYear.GetData();
	mapCtrl.TextMatrix(grdList.rows - 1, 11) = mapCtrl.TextMatrix(1, 5);
	mapCtrl.TextMatrix(grdList.rows - 1, 12) = mapCtrl.TextMatrix(1, 6);
	mapCtrl.TextMatrix(grdList.rows - 1, 13) = mapCtrl.TextMatrix(1, 7);
	mapCtrl.TextMatrix(grdList.rows - 1, 14) = mapCtrl.TextMatrix(1, 8);
	mapCtrl.TextMatrix(grdList.rows - 1, 15) = mapCtrl.TextMatrix(1, 9);
	mapCtrl.TextMatrix(grdList.rows - 1, 16) = mapCtrl.TextMatrix(1, 10);
	*/
	var colHeader_cd = lblGrdHeader.text.split("|");
	mapCtrl.TextMatrix(grdList.rows - 1 , 0) = lstEvaYear.GetData();
	mapCtrl.TextMatrix(grdList.rows - 1, 11) = colHeader_cd[0];
	mapCtrl.TextMatrix(grdList.rows - 1, 12) = colHeader_cd[1];
	mapCtrl.TextMatrix(grdList.rows - 1, 13) = colHeader_cd[2];
	mapCtrl.TextMatrix(grdList.rows - 1, 14) = colHeader_cd[3];
	mapCtrl.TextMatrix(grdList.rows - 1, 15) = colHeader_cd[4];
	mapCtrl.TextMatrix(grdList.rows - 1, 16) = colHeader_cd[5];
	mapCtrl.TopRow = grdList.rows - 1;
	return;
}

function OnDeleteData()
{
    var mapctrl = grdList.GetGridControl();
	if(grdList.rows <= 2)
	{
		alert("No data to delete");
        return; 
	}
    for(i=1; i<grdList.rows;i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdList.DeleteRowAt(i)
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
		dsoLoadEvaGradeTO.Call();
	}
}

function OnSelectEvaYear()
{
	dso_EvaYearInfo.Call();
	
}

function OnDataReceive(obj)
{
	if(obj.id == "dso_EvaYearInfo")
	{
		dso_GetGridHeader.Call();
	}
	else if(obj.id == "dso_GetGridHeader")
	{
		dsoLoadEvaGradeTO.Call("SELECT");
	}
	else if(obj.id == "dsoLoadEvaGradeTO")
	{
		//SetGridHeader(lblGrdHeader.text);
		SetGridHeader(lblGrdHeaderText.text)
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
    if(obj.Rows <= 2)
        return true; 
    var tmp = obj.GetGridControl();
    for(i=2; i<obj.rows; i++)
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
    if(tmp.TextMatrix(row , col) == values)
	{
		alert(msg)
		return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
	}
    return true; // khong trung
}

function CheckValidNumber(obj, col, usign, msg)
{
	var ctrl 	= obj.GetGridControl();
	var rownum 	= ctrl.Rows;
	
	if(rownum == 2)
		return false;
	
	var i;
	for(i=2; i<rownum; i++)
	{
		
		var ij_num 	= obj.GetGridData(i, col);
		if (isNaN(ij_num) && ij_num != "")
		{
			var ri = i-1;
			alert("Please enter a number at row " + ri + " : " + msg);
			return false;
		}
		if (Number(ij_num) <  0 && usign == true)
		{
			var ri = i-1;
			alert("Please enter a number larger than 0,  at row " + ri + " : " + msg);
			return false;
		}
			
	}
	return true;
	 
}

function OnDataError(obj)
{
	AlertDBError(obj.errmsg)
	return;
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
<head id="Head1" runat="server">
    <title>Evaluation Grade T/O Entry</title>
</head>
<body>

<gw:data id="dso_EvaYearInfo" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_CHEM00040_01" > 
                <input>
                    <input bind="lstEvaYear" /> 
                </input> 
                <output>
                    <output bind="lblEvaPerFr" />
					<output bind="lblEvaPerTo" />
					<output bind="lblSchedFr" />
					<output bind="lblSchedTo" />
					<output bind="lblDescription" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dso_GetGridHeader" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00040_02" > 
                <input>
                    <input bind="lstEvaYear" /> 
                </input> 
                <output>
                    <output bind="lblGrdHeader" />
					<output bind="lblGrdHeaderText" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dsoLoadEvaGradeTO" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="HR_SEL_chem00040_02" procedure="HR_UPD_chem00040_02" >
                <input bind="grdList">
                    <input bind="lstEvaYear" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>

    <table width="100%" height="100%">
		<tr>
			<td><fieldset><legend >Evaluation ...</legend>
				<table>
					<tr>
						<td width="1%">
						    <table width="100%">
						        <tr>
						            <td width = "5%" align="right">Eva #</td>
						            <td width = "23%"><gw:list  id="lstEvaYear" value='ALL' maxlen = "100" onchange="OnSelectEvaYear()" ></gw:list></td>
						            <td width="1%"></td>
						            <td width = "20%">Eva Period</td>
						            <td width = "10%"><gw:label id="lblEvaPerFr" onchange=""  maxlen = "10" styles='width:100%;color:blue'lang="1" /></td>
						            <td width = "3%">~</td>
						            <td width = "10%"><gw:label id="lblEvaPerTo" onchange=""  maxlen = "10" styles='width:100%;color:blue'lang="1" /></td>
						            <td width="1%"></td>
						            <td width = "7%">Schedule</td>
						            <td width = "10%"><gw:label id="lblSchedFr" onchange=""  maxlen = "10" styles='width:100%;color:blue'lang="1" /></td>
						            <td width = "3%">~</td>
						            <td width = "10%"><gw:label id="lblSchedTo" onchange=""  maxlen = "10" styles='width:100%;color:blue'lang="1" /></td>
						        </tr>
						    </table>
						</td>
						
					</tr>
					<tr>
						<td>
						    <table width="100%">
						        <tr>
						            <td width="15%">Description</td>
						            <td width="85%"><gw:label id="lblDescription" onenterkey   ="" styles='width:100%;color:blue'/></td>
						        </tr>
						    </table>
						</td>
					</tr>
				</table></fieldset>
			</td>
			<td width="9%"><fieldset height = "100%"><legend >X</legend>
				<table width="100%" height="100%">
					<tr>
						<td width="3%"><gw:imgBtn id="btnSearch" alt="Search data" img="search" text="Search data" onclick="OnSearchData()" /></td>
						<td width="3%"><gw:imgBtn id="btnNew" alt="New entry" img="new" text="New entry" onclick="OnAddnewData()" /></td>
						<td width="3%"><gw:imgBtn id="btnSave" alt="Save change information" img="save" text="Save" onclick="OnSaveChangedData()" /></td>
						<td width="3%"><gw:imgBtn id="btnDelete" alt="Delete information" img="delete" text="Delete" onclick="OnDeleteData()" /></td>
					</tr>
					<tr>
						<td colspan="3"><gw:icon id="btnRefresh" img="in" text="Refresh" alt="Refresh data"  style="display:none"  styles='width:100%'  onclick=""  /></td>
					</tr>
				</table></fieldset>
			</td>
		</tr>
		<tr height="100%">
			<td colspan = "2">
				<table width="100%" height="100%" border="1">
					<tr>
						<td  style="width:100%"> 
                            <gw:grid   
	                            id="grdList"  
	                            header="_THR_EVA_MASTER_PK|_EVA_TO_PK|_EVA_TO_GRADE_PK|Number of Employee|Option|S|A|B|C|D|_E|_GS|_GA|_GB|_GC|_GD|_GE"   
	                            format="0|0|0|-0|0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0"  
	                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            defaults="||||1||||||||||||" 
	                            editcol="0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|0|0" 
	                            widths="0|0|0|2000|2000|2000|2000|2000|2000|2000|2000|0|0|0|0|0|0" 
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = "" 
	                            param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" onSelChange="" OnClick="" /> 
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<gw:label id="lblGrdHeader" style="display:none" />
<gw:label id="lblGrdHeaderText" style="display:none" />
</body>
</html>
