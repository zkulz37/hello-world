<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Rental</title>
     <%  ESysLib.SetUser("CRM")%>

<script>
function BodyInit()
{ 
var data="";
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CTYPE' AND USE_YN='Y' order by ord" )%>|ALL|Select All"; 
	lstCustType.SetDataText(data);
	lstCustType.value = 'ALL';	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CTYPE' AND USE_YN='Y' order by ord" )%>"; 
    grdRmMonthly.SetComboFormat(10, data);
   OnSearch();
}
function OnSearch(){
    dso_RMmonthly.Call("SELECT");
}
function OnDataReceive(obj)
{
	switch(obj.id)
	{ 
		case 'dso_RMmonthly':
			lblRows.text=grdRmMonthly.rows-1 + " Room(s).";
			grdRmMonthly.Subtotal( 1, 2, -1,'6!7');
		break; 
	}
}
function OnReport()
{  
    //url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/bk/htbk00070.rpt&procedure=CRM.sp_sel_htbk00070&parameter="+dtfr.value+","+dtTo.value+","+txtCustomer_PK.text;   
         	//System.OpenTargetPage(url); 
}

</script>

</head>
<body>
 <gw:data id="dso_RMmonthly" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="CRM.sp_sel_htbk00090" >  
                <input bind="grdRmMonthly" >  
                    <input bind="dtMonth" />  				
					<input bind="lstCustType" />  					
                </input> 
                <output bind="grdRmMonthly" /> 
            </dso> 
        </xml> 
    </gw:data> 
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td style="width: 6%" >
                Month:</td>
            <td style="width: 13%" >
                <gw:datebox id="dtMonth"  text=""  style="width:100%" type="month" lang="1" onchange="OnSearch()"  /></td>
            <td style="width: 12%" align="right">MKT.Segment
               </td>
            <td style="width: 25%" > 
               <gw:list id="lstCustType" styles="width: 100%" onchange="OnSearch()" />
            </td>
			<td style="width: 2%">
			</td>
           <td style="width: 6%">Total:</td>
            <td style="width: 13%"><gw:label id="lblRows" /> </td>
			<td style="width:4%"> 
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td width="3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" styles="display:none" />
            </td>
			<td style="width: 5%" align="right">
               </td>
        </tr>
        <tr style="height: 61%">
            <td colspan="12">
                <gw:grid 
                    id="grdRmMonthly"
                    header="Room No|Room Type|Last Name|First Name|Checkin Date|CheckOut Date|Nights|Amount|Partner ID|Partner Name|MKT.Segment" 
                    format="0|0|0|0|0|0|-0|-0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
					oncellclick=""
                    />
            </td>
        </tr>
       
    </table>
	<gw:textbox id="txtMasterPK" style="display: none" />
	<gw:textbox id="txtCustomer_PK" style="display: none" />
	<gw:textbox id="txtTGM_VISITORFEE_GOLFER_PK" styles="display:none" />
	<gw:textbox id="txtReturnMsg" styles="display:none" />
	<gw:textbox id="txtTmpCaddieNo" styles="display:none" />
	 <gw:grid id="grdCaddieList" header="caddie_pk|caddie_no|caddie_name" 
         format="0|0|0" sorting='T'   styles="width:100%; height:100%;display:none"
     />
</body>
</html>
