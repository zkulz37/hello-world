<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Product Inquiry</title>
  </head>
  
 <% ESysLib.SetUser("stm")%>
<script>
function BodyInit()
{
    grdData.AddRow();
    MergeHeader();
	grdDefect.GetGridControl().FrozenCols = 4;
	grdData.GetGridControl().FrozenCols = 5;
}

function MergeHeader()
{
    var fg = grdData.GetGridControl();  
    
    grdData.SetCellBold(1,1,1,17,true);
    fg.FixedRows = 2
    fg.FixCols = 1;
    fg.MergeCells = 5
    
    fg.MergeCol(0) = true
    fg.Cell(0, 0, 0, 1, 0) = "STYLE"
    fg.MergeCol(1) = true
    fg.Cell(0, 0, 1, 1, 1) = "PO"
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 1, 2) = "COLOR"
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 1, 3) = "SIZE"
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 1, 4) = "ORDER"
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 5, 0, 8) = "CUTTING"
    fg.Cell(0, 1, 5, 1)    = "PREV"
    fg.Cell(0, 1, 6, 1 )   = "DAILY"
    fg.Cell(0, 1, 7, 1)    = "TTL"
    fg.Cell(0, 1, 8, 1)    = "BAL"
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 9, 0, 12) = "SEWING"
    fg.Cell(0, 1, 9, 1)     = "PREV"
    fg.Cell(0, 1, 10, 1 )    = "DAILY"
    fg.Cell(0, 1, 11, 1)     = "TTL"
    fg.Cell(0, 1, 12, 1)     = "BAL"
    
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 13, 0, 16) = "FINISHING"
    fg.Cell(0, 1, 13, 1)     = "PREV"
    fg.Cell(0, 1, 14, 1 )    = "DAILY"
    fg.Cell(0, 1, 15, 1)     = "TTL"
    fg.Cell(0, 1, 16, 1)     = "BAL"

    fg.ColWidth(0) = 3000;  // STYLE.
    fg.ColWidth(1) = 3000;  // PO 
    fg.ColWidth(2) = 1000; // COLOR
    fg.ColWidth(3) = 1000; // SIZE
    fg.ColWidth(4) = 1200; // ORDER
    fg.ColWidth(5) = 1800; // CUTTING/PREV
    fg.ColWidth(6) = 1200; // CUTTING/DAILY
    fg.ColWidth(7) = 1200; // CUTTING/TTL
    fg.ColWidth(8) = 1200; // CUTTING/BAL
    fg.ColWidth(9) = 1200; // IN SEWING/PREV
    fg.ColWidth(10)= 1000; // IN SEWING/DAILY
    fg.ColWidth(11)= 1000; // IN SEWING/TTL
    fg.ColWidth(12)= 1000; // IN SEWING/BAL
    fg.ColWidth(13)= 1000; // OUT SEWING/PREV
    fg.ColWidth(14)= 1400; // OUT SEWING/PREV
    fg.ColWidth(15)= 1500; // OUT SEWING/PREV
    fg.ColWidth(16)= 1500; // OUT SEWING/PREV
}

function MergeCols()
{
    var ctr = grdData.GetGridControl(); 
    ctr.MergeCells = 4; 
    ctr.MergeCol(0) = true;
    
    for (col = 0; col <= 4; col++) 
    { 
        ctr.MergeCol(col) = true;
    }
}

function MergeColsDefect()
{
    var ctr = grdDefect.GetGridControl(); 
    ctr.MergeCells = 4; 
    ctr.MergeCol(0) = true;
    
    for (col = 0; col <= 2; col++) 
    { 
        ctr.MergeCol(col) = true;
    }
}

function OnSearch(key)
{
	if(key == "PRODUCT" )
	{	
		idData_sp_sel_prod_daily.Call("SELECT");
	}
	else if (key == "DEFECT" )
	{
		idData_SP_SEL_DEFECT_INQUIRY_LIST.Call("SELECT");
	}	
	else
		return;
}

function OnChangeFact()
{
	idData_ChangeFact.Call();
	lstLine.value = "%";
}

function OnDataReceive(dso)
{
	if(dso.id == "idData_sp_sel_prod_daily")
	{
		var count = grdData.rows - 2;
		lbRecords.text = "<b style=\"color: Blue\">" + count + " record(s) </b>";
		
		MergeHeader();
		MergeCols();
	}
	else if	(dso.id == "idData_SP_SEL_DEFECT_INQUIRY_LIST")
	{
		MergeColsDefect();
	}
	else { return; }
}

function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=../reports/ip/pr/ippr0030.rpt&procedure=stm.sp_sel_prod_daily"
        + "&parameter="+txtPO.text + ", " + txtStyle.text + ", " + dtProd.GetData();
        window.open(url);
}

/*#######################################################################################*/
function OnDataError(obj)
{
	if (obj.id=="idData_sp_sel_prod_daily")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	else if (obj.id=="idData_SP_SEL_DEFECT_INQUIRY_LIST")
    {
		AlertDBError(obj.errmsg);
		return;
	}
	else
	{
		alert(obj.errmsg);
	}
}

/*#######################################################################################*/
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

<body style="background: white" >
<gw:data id="idData_sp_sel_prod_daily" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso id="2" type="grid" parameter="0,1,2" function="stm.sp_sel_prod_daily" > 
            <input> 
                <input bind="txtPO" /> 
                <input bind="txtStyle" /> 
                <input bind="dtProd" /> 
            </input> 
            <output bind="grdData" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_SP_SEL_DEFECT_INQUIRY_LIST" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso id="2" type="grid" parameter="0,1,2" function="STM.SP_SEL_DEFECT_INQUIRY_LIST" > 
            <input> 
                <input bind="lstFactory" /> 
                <input bind="lstLine" /> 
                <input bind="idMonth" /> 
            </input> 
            <output bind="grdDefect" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_ChangeFact" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
        <xml> 
            <dso  type="list" procedure="STM.SP_PRO_LINE_BY_FACT_LIST" > 
                <input>
                    <input bind="lstFactory" /> 
                </input> 
                <output>
                    <output bind="lstLine" />
                </output>
            </dso> 
        </xml> 
</gw:data>


    <gw:tab id="tab" > 
        <table name="Daily Product" style="background: #BDE9FF; width: 100%; height: 100%" >
            <tr style="background: white" height="5%" >
                <td width="100%">
                    <table style="width: 100%; height: 100%" border="0" >
                        <tr valign="top">
                            <td width="8%" align="right" valign="middle">PO No &nbsp;</td>
                            <td width="10%" valign="middle"><gw:textbox id="txtPO" styles="width: 100%" /></td>
                            <td width="8%" align="right" valign="middle">Style ID &nbsp;</td>
                            <td width="10%" valign="middle"><gw:textbox id="txtStyle" styles="width: 100%" /></td>
                            <td width="8%" align="right" valign="middle">Pord Date &nbsp;</td>
                            <td width="5%" valign="middle"><gw:datebox id="dtProd" lang="1" /></td>
                            <%--<td width="2%" valign="middle"><b>~</b></td>
                            <td width="5%" valign="middle"><gw:datebox id="dtTo" lang="1" /></td>--%>
                            <td width="27%"></td>
                            <td width="19%" align="right" valign="middle"><gw:label id="lbRecords" ><b style="color: Blue">record(s)</b></gw:label></td>
                            <td width="3%" valign="middle"><gw:imgBtn id="btnSearch" img="search" alt="Search product" onclick="OnSearch('PRODUCT')" /></td>
                            <td width="3%"><gw:imgBtn id="btnReport" img="excel" onclick="OnReport()" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="background: white" height="95%" >
                <td width="100%" valign="top">
                    <gw:grid 
                    id="grdData" 
                    header="1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17"
                    format="0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="||||||||||||||||" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    styles="width:100%; height:100%" 
                    sorting="T" 
                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" /> 
                </td>
            </tr>
        </table>
        <table name="Defect" style="background: #BDE9FF; width: 100%; height: 100%">
            <tr style="height: 25%" style="background: white">
                <td >
                    <table style="width: 100%; height: 100%" >
						<tr height="1%" >
							<td>
								<table style="width: 100%; height: 100%" border="0" >
									<tr>
										<td width="20" align="right" valign="middle"> &nbsp;</td>
										<td width="80" align="right" valign="middle">Factory &nbsp;</td>
										<td width="12%">
											<gw:list  id="lstFactory" value='%' styles='width:100%'onchange="OnChangeFact()" >
												<data>
													<%=ESysLib.SetListDataSQL(" SELECT A.PK, A.FACTORY_NM FROM TST_FACTORY A WHERE A.DEL_IF = 0 ")%>|%|Select All
												</data>
											</gw:list>
										</td>
										<td width="50" align="right" valign="middle">Line &nbsp;</td>
										<td width="12%">
											<gw:list  id="lstLine" value='%' styles='width:100%'onchange="OnSearch('DEFECT')" >
												<data>
													<%=ESysLib.SetListDataSQL("SELECT L.PK, L.LINE_NAME FROM TST_LINE L WHERE L.DEL_IF = 0 AND L.USE_YN = 'Y'")%>|%|Select All
												</data>
											</gw:list>
										</td>
										<td width="50" align="right" valign="middle">Month &nbsp;</td>
										<td width="12%">
											<gw:datebox id="idMonth"  maxlen = "10" text="" lang="<%=Session("Lang")%>" type=month onchange="OnSearch('DEFECT')" />
										</td>
										<td > &nbsp;</td>
										<td width="19%" align="right" valign="middle"><gw:label id="lbRecords" ><b style="color: Blue">record(s)</b></gw:label></td>
										<td width="3%" valign="middle"><gw:imgBtn id="btnSearchDefect" img="search" alt="Search Defect" onclick="OnSearch('DEFECT')" /></td>
										<td width="3%"><gw:imgBtn id="btnReportDefect" img="excel" onclick="OnReport()" /></td>
										<td width="3%" align="right" valign="middle"> &nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr height="99%" >
							<td>
								<gw:grid 
									id="grdDefect" 
									header="Factory|Line|Defect Name|Month Sumary
											|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15
											|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31"
									format="0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"
									aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
									defaults="||||||||||||||||||||||||||||||||||"
									editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
									widths="2500|2500|3000|2000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
									styles="width:100%; height:100%" 
									sorting="F" 
									param="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33" /> 
							</td>
						</tr>
                    </table>
                </td>
            </tr>
        </table>        
    </gw:tab>
</body>
</html>
