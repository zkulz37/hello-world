<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vina Genuwin</title>
    <style type="text/css">
		.bodyscrollbar{
		scrollbar-face-color: #ffffff;
		scrollbar-shadow-color: #A8A8A8;
		scrollbar-base-color : #ffffff;
		scrollbar-highlight-color: #A8A8A8;
		scrollbar-3dlight-color: #ffffff;
		scrollbar-darkshadow-color: #ffffff;
		scrollbar-track-color: #f8f8f8;
		scrollbar-arrow-color: #3366CC}
	</style>
</head>
<%  ESysLib.SetUser("crm")%>
<script language="javascript">
function BodyInit()
{   
	BuildGrid();
	OnClick('ibtnSearch');
}
//======================================================================
function BuildGrid()
{
	var grd_con = grdData.GetGridControl();

	grd_con.AllowUserResizing = 0;
	//grd_con.FocusRect = 0;
	grd_con.HighLight = 0;
	grd_con.FixedRows = 1;

	grd_con.WordWrap = true;
	grd_con.RowHeight(0) = 1000;
	grd_con.ScrollBars	 = 2;
	grd_con.TextMatrix(0, 0)  = 'POMEC (Property Operation Maintenance & Energy Costs)';
	grd_con.TextMatrix(0, 1)  = 'Account Code';
	grd_con.TextMatrix(0, 2)  = 'Dept Code';
	grd_con.TextMatrix(0, 3)  = '1';
	grd_con.TextMatrix(0, 4)  = '2';
	grd_con.TextMatrix(0, 5)  = '3';
}
//======================================================================
function OnClick(obj)
{
    switch(obj)
    {
        case "ibtnSearch":
			dso_sp_sel_jama00100.Call('SELET');
        break;
        case "ibtnUpdate":
            alert("Update");
        break;
        case "ibtnDelete":
			alert("Insert");
        break;
        case "ibtnInsert":
            alert("Insert");
        break;
        case "ibtnReport":
            var fpath = System.RootURL+ '/reports/ja/ma/rpt_jama00100.aspx?p_Month=' + idMonth.GetData();
            window.open(fpath);
        break;
    }
}
//======================================================================
function OnDataReceive(obj)
{	
	var ctrl = grdData.GetGridControl();

    for (i = 2; i < ctrl.Rows; i++)
	{
	    if(grdData.GetGridData(i, 4)== "B")
        {
	        ctrl.Cell(14, i, 0, i, 2) = false;
	        grdData.SetCellBold(i, 0, i, 2, true);
        }
	    else
	    {
	        ctrl.Cell(14, i, 0, i, 2) = false;
	        grdData.SetCellBold(i, 0, i, 2, false);
	    }

		grdData.GetGridControl().MergeCol(1) = true;	
		grdData.GetGridControl().MergeCol(2) = true;
		grdData.GetGridControl().MergeCol(3) = true;
		grdData.GetGridControl().TextMatrix(1, 1)  = 'Account Code';
		grdData.GetGridControl().TextMatrix(1, 2)  = 'Dept Code';

		grdData.SetCellBgColor(i, 0, i, 2, Number(grdData.GetGridData(i, 5)));
	}

	//---------------------------------------------------------------
	grdData.GetGridControl().FixedRows   = 2;	
	grdData.GetGridControl().MergeCells  = 5;
}
</script>
<body>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_sp_sel_jama00100" onreceive="OnDataReceive()">
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="acnt.sp_sel_jama00100"> 
            <input> 
                <input bind="idMonth" />
            </input> 
            <output bind="grdData" /> 
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<table algin="center" border="0" style="width: 100%; height: 100%; background-color:#CCCCCC" cellpadding="3" cellspacing="1">
	<tr>
        <td style="width:50%" style="background:#f7f8fc;padding:5px" valign="top" align="center"> 
            <table style="width:100%">
                <tr width="100%">
                    <td style="width:10%" >Month</td>
                    <td style="width:84%">
						<gw:datebox id="idMonth" styles="width:100%" lang="<%=Session("Lang")%>" type="month" onchange="OnClick('ibtnSearch')"/>
					</td>
					<td style="width:1%" >
						<gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnClick('ibtnSearch');" />
					</td>
                    <td style="width:1%" >
						<gw:imgbtn id="ibtnReport" img="excel"  alt="report"    onclick="OnClick('ibtnReport')" />
					</td>					
                </tr>
				 <tr style="width:100%; height:95%">
                	<td colspan="4" style="padding-top:4px;background: #BDE9FF">
                    	<gw:grid id="grdData"
						 header		="0|1|2|_3|_4|_5"
						 format		="0|0|0|1|0|0"
						 aligns		="0|1|1|3|0|0"
						 defaults	="|||||"
						 editcol	="0|0|0|0|0|0"
						 sorting	="F"
						 widths		="3000|3000|3000|0|0|0"
						 styles		="width:100%; height:100%"
						 debug		='false'/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtMasterPK" style="display:none" />
</body>
</html>