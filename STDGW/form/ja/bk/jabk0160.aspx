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
     BindingDataList();   
     OnSearch();       
}
//============================================================================== 

 function BindingDataList()
 {   
      var data="";   
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  pk, COURSE_ID || ' - ' || COURSE_NAME from crm.tgm_golf_course where del_if = 0 and ACTIVE_YN='-1' order by COURSE_ID" )%>";
      grdDetail.SetComboFormat(3,data);    
      data="DATA|10|Denfinite (Confirm)|20|Waiting|30|Cancelled|40|Tentative";    
      lstStatus.SetDataText(data);                      
 }

 //===================================================================================    
function OnSearch()
{
    data_jabk0020.Call("SELECT");
}  
function url_encode(s) {
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return escape(utftext);
}
function OnReport()
{
     var url = '/reports/ja/bk/jabk0020_inquiry2.aspx?p_dtfrom='+ dtFrom.GetData() + '&p_dtto=' + dtTo.GetData()+ '&p_member_no=' + txtMemberNo.GetData()+ '&p_member_name=' + txtMemberName.GetData()+ '&p_status=' + lstStatus.GetData();
	    System.OpenTargetPage( System.RootURL+url , "newform" );
//   var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0020.rpt&procedure=CRM.sp_sel_jabk0020&parameter="+dtFrom.GetData()+","+dtTo.GetData()+","+txtMemberNo.GetData()+","+txtMemberName.GetData()+","+lstStatus.GetData();   
//         	System.OpenTargetPage(url); 
}
function OnReport_Reservation(){
   /* var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ja/bk/japk0020_reservation.rpt&procedure=CRM.sp_sel_jabk0022|CRM.sp_sel_jabk0022&parameter="+dtFrom.GetData()+","+dtTo.GetData()+","+txtMemberNo.GetData()+","+url_encode(txtMemberName.GetData())+","+lstStatus.GetData()
                            +"|"+dtFrom.GetData()+","+dtTo.GetData()+","+txtMemberNo.GetData()+","+url_encode(txtMemberName.GetData())+","+lstStatus.GetData();   
    System.OpenTargetPage(url); */
	var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ja/bk/rpt_jabk00020.rpt&procedure=CRM.sp_sel_jabk0022&parameter="+dtFrom.GetData()+","+dtTo.GetData()+","+txtMemberNo.GetData()+","+url_encode(txtMemberName.GetData())+","+lstStatus.GetData();
    System.OpenTargetPage(url); 
}
function OnDataReceive(obj){
	for(var i=1;i<grdDetail.rows;i++){
		if(grdDetail.GetGridData(i,18) == "N"){
			grdDetail.SetCellBgColor(i, 0, i, grdDetail.cols-1,0XEE82EE);
		}
	}
	lblRows.text = grdDetail.rows-1;
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="crm.sp_sel_jabk0160" > 
                <input> 
                   <inout bind="dtFrom" /> 
                    <inout bind="dtTo" />                                     
                    <inout bind="txtMemberNo" /> 
                    <inout bind="txtMemberName" />    
                    <inout bind="lstStatus" />                                  
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 5%">
                Date</td>
            <td align="right" style="width: 10%">
                <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()"/>
            </td>
            <td align="right" style="width: 2%">
                ~</td>
            <td align="right" style="width: 10%">
                <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
            <td align="right" style="width: 9%">
                Member No</td>
            <td style="width: 10%">
                <gw:textbox id="txtMemberNo" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td align="right" style="width: 10%">
                Full Name</td>
            <td style="width: 12%">
                <gw:textbox id="txtMemberName" styles="width:100%" onenterkey="OnSearch()"  />
            </td>
            <td style="width: 5%">Status</td>
            <td style="width: 15%"><gw:list id="lstStatus" styles='width:100%' onchange="OnSearch()" /></td>
			<td align="right" style="width:7%">
                Rows:</td>
            <td style="width:7%">
                <gw:label id="lblRows" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td width="2%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            <td width="2%">
                <gw:imgbtn id="ibtnReport2" img="printer" alt="Print" onclick="OnReport_Reservation()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 100%" colspan="15">
                     <gw:grid id='grdDetail' 
                        header='Play Date|T.O.Time|Member ID|Full Name|HDCP|Gender|Member Type|Golf Type|_Greenfee|Status|Contact Person|Book Cart|Book Bag|Book Shoes|Booking No|Book Date|_DtFromTo|_DtSystem|_Active|Company Name'
                        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                        aligns='1|1|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0' 
                        autosize="T"
                        sorting='T'  
                        styles='width:100%; height:100%'/>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
