<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Rental</title>
     <%  ESysLib.SetUser("CRM")%>

<script>
function BodyInit()
{ 
	Binding();
    OnSearch();
}
function Binding()
{
     var ctrl = grdGolfer.GetGridControl();
     ctrl.FrozenCols = 5;
     ctrl.ColEditMask(6) = "##:##";   
     ctrl.ColEditMask(13) = "##:##";   
     ctrl.ColEditMask(14) = "##:##";   
     ctrl.ColEditMask(15) = "##:##";   
     ctrl.ColEditMask(16) = "##:##";   
     ctrl.ColEditMask(17) = "##:##";
     ctrl.ColEditMask(18) = "##:##";
     
     var data = "#9;9|#18;18|#27;27|#36;36|#;";
	/* grdGolfer.SetComboFormat(19, data);
	 grdGolfer.SetComboFormat(20, data);
	 grdGolfer.SetComboFormat(21, data);*/

	 //data = "<%=ESysLib.SetListDataSQL(" SELECT    pk, grp_cd || ' - ' || grp_nm  FROM comm.tco_itemgrp  WHERE del_if = 0 and GRP_CD in('XC','XD','XE','XF','XG')   CONNECT BY PRIOR pk = p_pk  START WITH p_pk is null") %>||Please, choose group.";     
    //lstItemGroup.SetDataText(data); 
	//lstItemGroup.value=""; 
	var lstHoles ="#9;9|#18;18|#27;27|#36;36|#45;45|#54;54";
    //grdGolferFree.SetComboFormat(8,lstHoles);
}
function OnSearch(){
    dso_grdGolfer.Call("SELECT");
}
var _action="";        
function OnDataReceive(obj)
{
    if(obj.id == "dso_grdGolfer"){
        lblRows.text = "" + grdGolfer.rows-1;
    }
	else if(obj.id == "dsoCreateNewGroup"){
		alert("New group is " + txtReturnMsg.text);
	}
}
function GridOnCellClick()
{
    if ( grdGolfer.row > 0 )
        {
            txtMasterPK.text = grdGolfer.GetGridData( event.row, 0);  
            if(grdGolfer.GetGridData(grdGolfer.row, 0)!="")
            {
                dso_grdGolferFree.Call("SELECT");
            }             
        }
 }
 function OnReport()
{  
    url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/st/jast00010.rpt&procedure=CRM.sp_rpt_jast00010&parameter="+dtfr.value+","+dtTo.value+","+txtName.text;   
         	System.OpenTargetPage(url); 
}
</script>

</head>
<body>
 <gw:data id="dso_grdGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="CRM.sp_sel_jast00010_search" >  
                <input bind="grdGolfer" >  
                    <input bind="dtfr" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtName" /> 	 															
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data> 
	 <gw:data id="dso_grdGolferFree" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="crm.sp_sel_jams0010_search_dtl" >  
                <input bind="grdGolferFree" >  
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdGolferFree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td style="width: 5%" >
                Date</td>
            <td style="width: 8%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
            <td style="width: 2%">~</td>
            <td style="width: 8%" >
                <gw:datebox id="dtTo"  lang="1" onchange="OnSearch()" />
            </td>
            <td  style="width: 5%"></td>
            <td style="width: 17%" align="right">
                Name/Locker#</td>
            <td style="width: 15%" > 
                <gw:textbox id="txtName" onenterkey="OnSearch()" />
            </td>
            <td  style="width: 5%"></td>
            <td style="width: 14%">Total Player:</td>
            <td style="width: 5%"><gw:label id="lblRows" /> </td>
			<td style="width:4%">
               
            </td>
            <td  style="width: 3%"></td>
            <td style="width: 3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
			<td style="width:3%">
                
            </td>
             <td width="3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
        </tr>
        <tr style="height: 61%">
            <td colspan="15">
                <gw:grid 
                    id="grdGolfer"
                    header="_PK|Group#|_tgm_visitorfee|Player Name|Member Type|Locker#|Bagtag#|Tee Time|_Caddie_PK|Caddy#|Caddie Name|Cart Fee|Golfbag Fee|Other Rental Fee|Start Time|Cross 1st|Cross 2nd|Cross 3rd
                    |Finish Time|Total Time|Out Course|In Course|E9 Course|_BookCart|_Drivingrange|Checkin Time" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
					oncellclick="GridOnCellClick()"
                    />
            </td>
        </tr>
        <!----start-->
        <tr style="height: 2%">
        <td colspan="5">                
		Rental Items
        </td>
        <td colspan="5"></td>
        </tr>
        <tr style="height: 35%" id="idfree">
            <td colspan="15">
                <table style="height: 100%"; width="100%">
                    <tr style="height:100%"> 
                        <td colspan="13">
                            <gw:grid id="grdGolferFree" header="_PK|_PK_golfer|_item_pk|Item Group|Item Code|Item Name|Unit|Price|Holes|Qty|Amt"
                                format="0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0" defaults="||||||||||" editcol="0|0|0|0|0|0|0|0|1|1|0"
                                widths="0|1500|2000|1000|1200|3000|1000|1000|1000|1000|1000" sorting='T' autosize='T'
                                styles="width:100%; height:100%" onafteredit="AmountSum()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!--end--->
    </table>
	<gw:textbox id="txtMasterPK" style="display: none" />
	<gw:textbox id="txtTGM_VISITORFEE_GOLFER_PK" styles="display:none" />
	<gw:textbox id="txtReturnMsg" styles="display:none" />
	<gw:textbox id="txtTmpCaddieNo" styles="display:none" />
	 <gw:grid id="grdCaddieList" header="caddie_pk|caddie_no|caddie_name" 
         format="0|0|0" sorting='T'   styles="width:100%; height:100%;display:none"
     />
</body>
</html>
