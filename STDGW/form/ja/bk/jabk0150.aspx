<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Golf Booking(Web)</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
	var G_COL_PK=0,
	G_COL_Reservation_No=1,
	G_COL_RSV_Date=2,
	G_COL_Status=3,
	G_COL_Play_Date=4,
	G_COL_Tee_Off_Time=5,
	G_COL_Number_Of_Golfer=6,
	G_COL_Fee_per_Golfer=7,
	G_COL_Total_Fees=8,
	G_COL_Title=9,
	G_COL_Last_Name=10,
	G_COL_First_Name=11,
	G_COL_Email=12,
	G_COL_Phone=13,
	G_COL_Cart_YN=14,
	G_COL_Golfbag_YN=15,
	G_COL_Request=16,
	G_COL_Description=17,
	G_COL_Description=18;
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_jabk0140.Call("SELECT");
 }
 function BodyInit()
 {
    var data;
	data ="data|20|SUBMIT|30|CONFIRMED|40|CANCELLED"
    lstStatus.SetDataText(data);  
    
    data ="#20;SUBMIT|#30;CONFIRMED|#40;CANCELLED"
    grdBookingWeb.SetComboFormat(G_COL_Status,data);
	grdBookingWeb.GetGridControl().FrozenCols = 5;
	OnSearch();
 }
 function OnReport()
 {
		 alert("Not....Yet");
		 /*var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00180_1.rpt&procedure=CRM.sp_rpt_htfo00180&parameter="+txtRoomNo.text;   
         System.OpenTargetPage(url); */
 }
 function OnSave()
 {
	data_jabk0140.Call(); 
 }
 function OnDataReceive()
{
	txtCount.text= grdBookingWeb.rows-1 + " Guest(s)."
} 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_jabk0140" onreceive="OnDataReceive()"> 
        <xml>
           <dso  type="grid" parameter="0,3,4,5,6,16,17"  function="crm.sp_sel_jabk0140" procedure="CRM.sp_upd_jabk0140" >
                <input  bind="grdBookingWeb">
                    <input bind="dtDateFrm" />
					<input bind="dtDateTo" />
					<input bind="lstStatus" />
                </input> 
                <output bind="grdBookingWeb" />  
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 6%; white-space: nowrap">
                             Date
                        </td>
                        <td style="width: 24%; white-space: nowrap">
                            <gw:datebox id="dtDateFrm" lang="1" onchange="OnSearch()" />
							~
							<gw:datebox id="dtDateTo" lang="1" onchange="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
							Status
                        </td>
						<td style="width: 18%" align="right">
							<gw:list id="lstStatus" onchange="OnSearch()" />
                        </td>
						 <td style="width: 3%" align="right">
                        </td>
						<td align="right" style="width: 5%">
							 <b>Total:</b></td>
						<td style="width: 18%" align="center">
							 <gw:label id="txtCount" />
						 </td>
						 <td style="width: 10%" align="right">
                        </td>
						 <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
						</td>
						<td style="width: 3%" align="right">
							<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
						<td style="width: 3%" align="right">
							
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdBookingWeb' header='_PK|Reservation#|RSV Date|Status|Play Date|Tee Off Time|Number Of Golfer|Fee per Golfer|Total Fees|Title|Last Name|First Name|Email|Phone|Cart YN|Golfbag YN|Request|Description|Course Name|Member ID'
                    format='0|0|4|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    editcol='0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0'
                    widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
