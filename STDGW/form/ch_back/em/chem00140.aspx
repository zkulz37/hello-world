<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
function BodyInit()
{
   <%=ESysLib.SetGridColumnComboFormatString2( "grdList" ,3 , "1|Option 1|2|Option 2") %>;
   var lstEvaYear_Data = "<%=ESysLib.SetListDataSQL("SELECT PK, E.EVA_YYYY || ' - ' || E.EVA_SEQ FROM THR_EVA_MASTER E WHERE E.DEL_IF = 0 ORDER BY E.EVA_YYYY || ' - ' || E.EVA_SEQ DESC")%>";
   lstEvaYear.SetDataText(lstEvaYear_Data); 
   MergeHeader();
   OnSelectEvaYear();
}
function MergeHeader()
{
    var tmp=grdList.GetGridControl();  
    grdList.AddRow()
    grdList.SetCellBold(1,1,1,7,true);
    tmp.FixedRows = 2;
    tmp.FixCols= 2;
    tmp.MergeCells = 5
    
    tmp.MergeCol(2) = true
    tmp.Cell(0, 0, 2, 1, 2) = "Number of Employee"
	
    tmp.MergeCol(3) = true
    tmp.Cell(0, 0, 3, 1, 3) = "Option"
	    
    tmp.MergeRow(0) = true
    tmp.Cell(0, 0, 4, 0, 6) = "GRADE"
    tmp.Cell(0, 1, 4, 1)    = "S"
    tmp.Cell(0, 1, 5, 1 )   = "A"
    tmp.Cell(0, 1, 6, 1)    = "B"
}
function MergeHeader_Search()
{
    var tmp=grdList.GetGridControl();  
    grdList.SetCellBold(1,1,1,7,true);
    tmp.FixedRows = 2;
    tmp.FixCols= 2;
    tmp.MergeCells = 5
    
    tmp.MergeCol(2) = true
    tmp.Cell(0, 0, 2, 1, 2) = "Number of Employee"
	
    tmp.MergeCol(3) = true
    tmp.Cell(0, 0, 3, 1, 3) = "Option"
	    
    tmp.MergeRow(0) = true
    tmp.Cell(0, 0, 4, 0, 6) = "GRADE"
    tmp.Cell(0, 1, 4, 1)    = "S"
    tmp.Cell(0, 1, 5, 1 )   = "A"
    tmp.Cell(0, 1, 6, 1)    = "B"
}
function SetGridHeader()
{
	//colHeader = headerList.split("|");
	var tmp =grdList.GetGridControl();  
	grdList.SetCellBold(1,1,1,7,true);
    tmp.FixedRows = 2
    tmp.FixCols= 2;
    tmp.MergeCells = 5
    
    tmp.MergeCol(2) = true
    tmp.Cell(0, 0, 2, 1, 2) = "Number of Employee"
	
    tmp.MergeCol(4) = true
    tmp.Cell(0, 0, 3, 1, 3) = "Option"
	    
    tmp.MergeRow(0) = true
    tmp.Cell(0, 0, 4, 0, 6) = "GRADE"
	tmp.Cell(0, 1, 4, 1)    = "S (30%)";
    tmp.Cell(0, 1, 5, 1 )   = "A (40%)";
    tmp.Cell(0, 1, 6, 1)    = "B (30%)";
}
function OnSearch()
{
    dsoLoadEvaGradeTO.Call("SELECT");
}
function CheckValid()
{
	for (var i = 2; i< grdList.rows; i++)
    {
        if(grdList.GetGridData(i,2) =="")
            {
                alert('Please enter a number "Number Of Employee" at row :' + (i-1))
                 return false;
            }
        if(grdList.GetGridData(i,3) =="")
            {
                alert('You must select one Option in row :'+(i-1))
                 return false;
            }
         if(grdList.GetGridData(i,4) =="")
            {
                alert('Please enter a number "Grand S" at row :' + (i-1))
                 return false;
            }
         if(grdList.GetGridData(i,5) =="")
            {
                alert('Please enter a number "Grand A" at row :' + (i-1))
                 return false;
            }   
        if(grdList.GetGridData(i,6) =="")
        {
            alert('Please enter a number "Grand B" at row :' + (i-1))
             return false;
        }
    }
    return true;
	 
}
function OnSelectEvaYear()
{
	dso_EvaYearInfo.Call();
}
function OnDataReceive(obj)
{
    if(obj.id == "dso_EvaYearInfo")
	{
		MergeHeader_Search();
		dsoLoadEvaGradeTO.Call("SELECT");
	}
	if(obj.id == "dsoLoadEvaGradeTO")
	{
		SetGridHeader();
	}
}
function OnAddnew()
{
    if(lstEvaYear.GetData() == "")
	{
		alert("Unknown Evaluation number, select one in list before add new data");
		return;
	}
	grdList.AddRow();
	var mapCtrl = grdList.GetGridControl();
	mapCtrl.TextMatrix(grdList.rows - 1 , 1) = lstEvaYear.GetData();
	mapCtrl.TopRow = grdList.rows - 1;
	return;
}
function OnSave()
{
   grdList.SetRowStatus(1, 0x00); 
    if(CheckValid())
    {
        dsoLoadEvaGradeTO.Call();
    }
}
function OnDelete()
{
    if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdList.DeleteRow();
				dsoLoadEvaGradeTO.Call();
			}
}
</script>

<html>
<head>
    <title>Evaluation Grade T/O Entry</title>
</head>
<body>
    <gw:data id="dso_EvaYearInfo" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_LOAD_AVE_YEAR" > 
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
<gw:data id="dsoLoadEvaGradeTO" onreceive="OnDataReceive(this)" > 
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6" function="sp_sel_chem00140" procedure="sp_upd_chem00140" >
                <input bind="grdList">
                    <input bind="lstEvaYear" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>
<gw:data id="dso_GetGridHeader" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_LOAD_AVE_GRADE" > 
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
						<td width="3%"><gw:imgBtn id="btnSearch" alt="Search data" img="search" text="Search data" onclick="OnSearch()" /></td>
						<td width="3%"><gw:imgBtn id="btnNew" alt="New entry" img="new" text="New entry" onclick="OnAddnew()" /></td>
						<td width="3%"><gw:imgBtn id="btnSave" alt="Save change information" img="save" text="Save" onclick="OnSave()" /></td>
						<td width="3%"><gw:imgBtn id="btnDelete" alt="Delete information" img="delete" text="Delete" onclick="OnDelete()" /></td>
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
	                            header="_pk|_THR_EVA_MASTER_PK|Number of Employee|Option|S|A|B"   
	                            format="0|0|0|0|0|0|0"  
	                            aligns="0|0|3|1|3|3|3"  
	                            defaults="||||||" 
	                            editcol="1|1|1|1|1|1|1" 
	                            widths="0|0|2000|2000|2000|2000|2000" 
	                            styles="width:100%; height:100%" 
	                            sorting="T" oncelldblclick = "" 
	                          /> 
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
