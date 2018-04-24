<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Work Division Entry</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script language="javascript">
function BodyInit()
{
	System.Translate(document);
	MerGrid();
}
//============================================================================================
function OnNew()
{
	Grid_WorkDivision.AddRow();
}
//============================================================================================
function OnYearChange()
{  
    
    dtCurrmonth.value=dtYear.value+''+dtCurrmonth.value.substring(4,6);
    MerGrid();
    
}
//============================================================================================
function MerGrid()
{
        fg=idGrid.GetGridControl();
		fg.Cell(0, 0, 6, 0, 6) =dtYear.value+"/01";
		fg.Cell(0, 0, 7, 0, 7) =dtYear.value+"/02";
		fg.Cell(0, 0, 8, 0, 8) =dtYear.value+"/03";
		fg.Cell(0, 0, 9, 0, 9) =dtYear.value+"/04";
		fg.Cell(0, 0, 10, 0, 10) =dtYear.value+"/05";
		fg.Cell(0, 0, 11, 0, 11) =dtYear.value+"/06";
		fg.Cell(0, 0, 12, 0, 12) =dtYear.value+"/07";
		fg.Cell(0, 0, 13, 0, 13) =dtYear.value+"/08";
		fg.Cell(0, 0, 14, 0, 14) =dtYear.value+"/09";
		fg.Cell(0, 0, 15, 0, 15) =dtYear.value+"/10";
		fg.Cell(0, 0, 16, 0, 16) =dtYear.value+"/11";
		fg.Cell(0, 0, 17, 0, 17) =dtYear.value+"/12";
		
//        fg.MergeCol(1) = true
//		fg.Cell(0, 0, 1, 1, 1) = "Detail Devision No"
//	
//		fg.MergeCol(2) = true
//		fg.Cell(0, 0, 2, 1, 2) = "Detail Level Code"
//		
//		fg.MergeCol(3) = true
//		fg.Cell(0, 0, 3, 1, 3) = "Detal Level Seq"
//		
//		fg.MergeCol(4) = true
//		fg.Cell(0, 0, 4, 1, 4) = "Work Item Name"
//		
//		fg.MergeCol(5) = true
//		fg.Cell(0, 0, 5, 1, 5) = "Specification"
//		
//		fg.MergeCol(6) = true
//		fg.Cell(0, 0, 6, 1, 6) = "Main Contract Detail No"
//		
//		fg.MergeRow(0) = true
//		fg.Cell(0, 0, 7, 0, 9) = "Main Contract"  
//		fg.Cell(0, 1, 7, 1) 	= "UOM"
//		fg.Cell(0, 1, 8, 1 ) 	= "Currency"
//		fg.Cell(0, 1, 9, 1) 	= "Quantity"

		
		
}
//============================================================================================
function OnDelete()
{
	Grid_WorkDivision.DeleteRow();	
}
//============================================================================================
function OnSearch()
{
	MerGrid();
}
//============================================================================================
function OnSave()
{
	dso_WorkDivision.Call();
}
//============================================================================================

</script>

<body>
    <table style="width: 100%; height: 100%">
        <tr style="height: 4%">
            <td align="right" width="10%">
                Project</td>
            <td width="10%">
                <gw:textbox id="txtProjectCode" styles='width:100%' />
            </td>
            <td width="40%" colspan="2">
                <gw:textbox id="txtProjectName" styles='width:100%' />
            </td>
            <td style="white-space: nowrap">
                Contract Period
            </td>
            <td>
                <gw:datebox id="dtPeriodFrom" />
                ~<gw:datebox id="dtPeriodTo" />
            </td>
            <td>
                <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()"/>
            </td>
        </tr>
        <tr style="height: 4%">
            <td align="right" width="10%">
                Year</td>
            <td width="10%">
                <gw:datebox id="dtYear" type="year" mode="01" styles='width:100%' onchange="OnYearChange()"/>
            </td>
            <td width="10%" style="white-space: nowrap">
                Current Month
            </td>
            <td align="left">
                <gw:datebox id="dtCurrmonth" type="month" mode="01" styles='width:100%' />
            </td>
            <td style="white-space: nowrap">
                Budget Period
            </td>
            <td>
                <gw:datebox id="dtBudPeriodFrom" />
                ~<gw:datebox id="dtBudPeriodTo" />
            </td>
        </tr>
        <tr style="height: 96%">
            <td width="100%" colspan="7">
                <gw:grid id="idGrid" header="Budget Item|Working Budget|Total Input Cost|Input Cost Rate|Previous Month Input Cost|Current Month input Cost|yyyy/01|yyyy/02|yyyy/03|yyyy/04|yyyy/05|yyyy/06|yyyy/07|yyyy/08|yyyy/09|yyyy/10|yyyy/11|yyyy/12"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="|||||||||||||||||" editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" widths="1700|1700|1800|1800|2400|2300|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                    styles="width:100%; height:100%" sorting="T" oncelldblclick="OnDblClick()" />
            </td>
        </tr>
    </table>
</body>
</html>
