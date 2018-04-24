<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Guest Arriving</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 var G_pk=0,
 G_Company_Agent=1,
 G_Guest_Type=2,
 G_Last_Name=3,
 G_First_Name=4,
 G_Gender=5,
 G_Nation=6,
 G_Arrive_Date=7,
 G_Departure=8,
 G_Advance=9,
 G_Room_Rate=10,
 G_Room_No=11,
 G_Room_Type=12,
 G_Contact_Name=13,
 G_Contact_Phone=14,
 G_Contact_Mail=15,
 G_Adult_Male=16,
 G_Adult_Female=17,
 G_Child_Male=18,
 G_Child_Female=19,
 G_Checkin_By=20,
 G_Checkin_Date=21,
 G_Request=22,
 G_Room_Pk=23,
 G_Room_Type_code=24,
 G_PA_ID=25,
 G_Rate_Plan=26,
 G_Rate=27,
 G_SLIP_NO=28,
 G_Guest2_name=29,
 G_Guest3_name=30,
 G_Guest4_name=31,
 G_Company_pk=32;
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_htfo00180.Call("SELECT");
 }
 function BodyInit()
 {
    var data;
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdArriving.SetComboFormat(G_Gender, data);//gender

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdArriving.SetComboFormat(G_Nation, data);//nation
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CTYPE' AND USE_YN='Y' order by ord")%>";
	grdArriving.SetComboFormat(G_Guest_Type, data);//MKT.Segment

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.PK,a.RATE_CODE ||' - '||a.RATE_NAME FROM  CRM.THT_RATE_PLANS a WHERE a.DEL_IF=0 order by a.RATE_CODE " )%>"; 
    grdArriving.SetComboFormat(G_Rate_Plan, data);//rate plan
	grdArriving.GetGridControl().FrozenCols = 5;
	OnSearch();
 }
 function OnClickGrid()
 {
    if(grdArriving.rows-1 >0)
    {
        grdArriving.row=-1;
    }
 }
 function OnReport()
 {
    //var url = '/reports/ht/fo/htfo00180.aspx?p_room='+ txtRoomNo.text;
	  //   System.OpenTargetPage( System.RootURL+url , "newform" );
		 
		 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00180_1.rpt&procedure=CRM.sp_rpt_htfo00180&parameter="+txtRoomNo.text+","+txtAdult.text+","+txtChild.text;      
         System.OpenTargetPage(url); 
 }
 function OnReport2()
 {
  
   //var url = '/reports/ht/fo/rpt_htfo00180.aspx?p_room='+ txtRoomNo.text;
	     //System.OpenTargetPage( System.RootURL+url , "newform" );
		 
		var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00180_4.rpt&procedure=CRM.sp_rpt_htfo00180_2&parameter="+txtRoomNo.text+","+txtAdult.text+","+txtChild.text;    
         System.OpenTargetPage(url); 
 }
 function OnSave()
 {
	data_htfo00180.Call();
 }
  function OnReport_R_Card()
 {
		if(grdArriving.row !='-1' )
		{
			var url = '/reports/ht/fo/rpt_htfo00180_R_Card.aspx?p_pk='+grdArriving.GetGridData(grdArriving.row, G_pk);
			 System.OpenTargetPage( System.RootURL+url , "newform" );
		 }
 }
//=========================================================================
 function RoomPopup(obj)
{
	if(obj.col==G_Room_No)
    {
       if (confirm("New room and old room are them same daily rate?"))
		{
		   var path = System.RootURL + "/form/ht/fo/htfo00180_room_popup.aspx?";
			var object = System.OpenModal( path ,500 , 400 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				grdArriving.SetGridText(grdArriving.row,G_Room_Pk, object[0]);//room_pk
				grdArriving.SetGridText(grdArriving.row, G_Room_No, object[1]);//room no
				grdArriving.SetGridText(grdArriving.row,G_Room_Type_code, object[2]);//room type
			}  
		}
    }
	if(obj.col==G_Advance)//deposit=advance
    {
		var guest_name = grdArriving.GetGridData(grdArriving.row, G_Last_Name)+" "+grdArriving.GetGridData(grdArriving.row, G_First_Name);//last_name and first name
		var path = System.RootURL + '/form/ht/fo/htfo00180_popup_deposit.aspx?p_room_allocate_pk='+ grdArriving.GetGridData(grdArriving.row, G_pk)+"&p_guest_name="+guest_name+"&p_room_no="+grdArriving.GetGridData(grdArriving.row, G_Room_No);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes',window);
		OnSearch();

	}
	if(obj.col==G_Company_Agent)//Company
	{
		var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				grdArriving.SetGridText(grdArriving.row,G_Company_pk, object[0]);//company_pk object[0];
				grdArriving.SetGridText(grdArriving.row,G_Company_Agent, object[4]);//company name object[4];
			}

	}
}
function OnDataReceive()
{
	if(grdArriving.rows >0)
	{
		for (i = 1; i < grdArriving.rows; i++)
		{
			grdArriving.SetCellBgColor(i, G_Advance, i, G_Advance, 0xB3B3D7);
			grdArriving.SetCellBgColor(i, G_Room_No, i, G_Room_No, 0xB3B3D7);
			grdArriving.SetCellBgColor(i, G_Company_Agent, i, G_Company_Agent, 0xB3B3D7);
		}
		txtCount.text=grdArriving.rows-1 + " Rooms.";
		Sum_Adult_Child();
	}
}
function Sum_Adult_Child()
 {
	var l_adult=0,l_child=0;
     for(var i=1; i< grdArriving.rows;i++)
	 {
		if(grdArriving.GetGridData(i,16) !=""|| grdArriving.GetGridData(i,17) !="")//adult(M) or Adult(F)
		{
			l_adult= l_adult + Number(grdArriving.GetGridData(i,16))+ Number(grdArriving.GetGridData(i,17));//adult(M)
			l_child= l_child + Number(grdArriving.GetGridData(i,18))+ Number(grdArriving.GetGridData(i,19));//child(M)
		}
	 }
	 txtAdult.text= l_adult; 
	 txtChild.text= l_child;
 }
 function OnPrintAdvance(url){
		System.OpenTargetPage(url); 
 }
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00180" onreceive="OnDataReceive()"> 
        <xml>
           <dso  type="grid" parameter="0,2,3,4,5,6,7,8,13,14,15,16,17,18,19,22,23,24,25,26,27,29,30,31,32"  function="crm.SP_SEL_HTFO00180_FORM" procedure="CRM.sp_upd_htfo00180" >
                <input  bind="grdArriving">
                    <input bind="txtRoomNo" />
                </input> 
                <output bind="grdArriving" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                             Room No/Guest Name
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:textbox id="txtRoomNo" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
						<td align="right" style="width: 5%">
							 <b>Total:</b></td>
						<td style="width: 17%" align="center">
							 <gw:label id="txtCount" />
						 </td>
						 <td align="right" style="width: 8%">
							 <b>Adult:</b></td>
						 <td style="width: 7%" align="center">
							 <gw:label id="txtAdult" />
						 </td>
						 <td align="right" style="width: 7%"> 
								 <b>Child:</b></td>
						 <td style="width: 7%" align="center">
							 <gw:label id="txtChild" />
						 </td>
						 <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
						</td>
						<td style="width: 2%" align="right">
							<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
						<td style="width: 2%" align="right">
							<gw:imgbtn id="ibtnReport2" img="printer" alt="Print2" onclick="OnReport2()" />
                        </td>
						<td style="width: 2%" align="right">
							<gw:imgbtn id="ibtnReport3" img="printer" alt="R-Card" onclick="OnReport_R_Card()" /> 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdArriving' header='_pk|Company|MKT.Segment|Last Name|First Name|Gender|Nation|Arrive Date|Departure|Advance|_Rate|Room#|Room Type|Contact Name|Phone|Mail|Adult-M|Adult-F|Child-M|Child-F|Checkin By|Checkin Date|Request|_Room_Pk|_Room_Type|PA/ID|Rate Plan|Rate|Slip No|Guest2 Name|Guest3 Name|Guest4 Name|_Company_pk'
                    format='0|0|0|0|0|0|0|4|4|-0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|3|3|1|0|0|0|0|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    editcol='0|0|0|1|1|1|1|0|1|0|1|0|0|1|1|1|1|1|1|1|0|0|1|1|1|1|1|1|0|1|1|1|0'
                    widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick="RoomPopup(this)"  />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
