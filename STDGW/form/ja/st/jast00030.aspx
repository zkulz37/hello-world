<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
//======================================================================
function BodyInit()
{  
     OnSearch();       
}
//============================================================================== 

 function BindingDataList()
 {   
      var data="";   
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  pk, COURSE_ID || ' - ' || COURSE_NAME from crm.tgm_golf_course where del_if = 0 and ACTIVE_YN='-1' order by COURSE_ID" )%>";
      grdDetail.SetComboFormat(3,data);                          
 }
 //===================================================================================
function OnReport()
 {
    var url =System.RootURL + '/reports/ja/st/rpt_jast0030.aspx?dtbooking=' + dtBooking.value + '&today='+ dtToday.value ;
    System.OpenTargetPage(url);
 }
 //===================================================================================
function OnSearch()
{
    data_jast0030.Call("SELECT");
}  
//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jast0030" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jast0030" > 
                <input> 
                   <inout bind="dtFrom" />
				   <inout bind="dtTo" />
				   <inout bind="txtName" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="left" style="width: 5%">
                Date</td>
            <td align="left" style="width: 7%">
                <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
            </td>
			<td>~<td>
			<td align="left" style="width: 7%">
                <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
			<td>Name<td>
			<td align="left" style="width:15%">
                <gw:textbox id="txtName" onenterkey="OnSearch()" />
            </td>
			<td style="width:50%"></td>
            <td style="width:5%" align="right">
                <gw:imgbtn id="btnExcel" img="excel" alt="Print Result" text="Print" onclick="OnReport()" />
            </td>
            <td style="width:3%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="11">
                <gw:grid id='grdDetail' header='Teetime|Member Type|Name|Golf Course|Holes|Gender|_TCM_CADDY_PK|Caddy No|Caddy Name|Book Cart|Member No'
                    format='0|0|0|0|0|0|0|0|0|3|0' aligns='0|0|0|0|0|0|0|0|0|0|0'  editcol='0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' autosize='T'
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:datebox id="dtToday" lang="1" onchange="OnSearch()" style="display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
