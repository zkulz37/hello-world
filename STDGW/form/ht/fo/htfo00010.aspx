<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Guest Arriving</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_htfo00010.Call("SELECT");
 }
 function BodyInit()
 {
    var data;
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'RTYPE'")%>";
	//grdArriving.SetComboFormat(7, data);
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CTYPE'" )%>"; 
    //grdArriving.SetComboFormat(1, data);
	
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	//grdArriving.SetComboFormat(3, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	//grdArriving.SetComboFormat(4, data);
	dtTo.SetDataText(System.AddDate(dtFrom.GetData(),1));
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
 function OnReport(obj)
 {
    if(obj=='All')
	{
		var url = '/reports/ht/fo/htfo00010.aspx?p_dt_frm='+ dtFrom.value+'&p_dt_departure='+dtTo.value+'&p_guest_name='+txtGuestNameS.text+'&p_count_RM='+txtCount.text;
			System.OpenTargetPage( System.RootURL+url , "newform" );  
	}
	if(obj=='Detail')
	{
		if(grdArriving.row !='-1')
		{
			var url = '/reports/ht/fo/htfo00010_detail.aspx?p_pk='+ grdArriving.GetGridData(grdArriving.row,0);
				System.OpenTargetPage( System.RootURL+url , "newform" );  
		}
		else
		{
			alert("Please,choose one guest to print.");
		}
	}
	if(obj=='Detail_rpt')
	{
		url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00010_2.rpt&procedure=crm.sp_rpt_htfo00010&parameter="+dtFrom.value+","+dtTo.value;   
         System.OpenTargetPage(url);  

	}
 }
 function OnDataReceive(obj)
 {
	 if(obj.id=='data_htfo00010')
	 {
		if(grdArriving.rows-1 > 0)
		{
			txtCount.text=grdArriving.rows-1 + "   Room(s).";
			HighLightRoomNotAvailable();
			Sum_Adult_Child();
			grdArriving.SetCellBgColor(1, 9, grdArriving.rows-1, 9, 0xB3B3D7);
		}
	 }
 }
 function OnAdvance(obj){
	if(obj.col == 9)//deposit=advance
    {
		var guest_name = grdArriving.GetGridData(grdArriving.row, 3)+" "+grdArriving.GetGridData(grdArriving.row, 4);//last_name and first name
		var path = System.RootURL + '/form/ht/fo/htfo00010_advance.aspx?p_room_allocate_pk='+ grdArriving.GetGridData(grdArriving.row, 0)+"&p_guest_name="+guest_name+"&p_room_no="+grdArriving.GetGridData(grdArriving.row, 11);
		var object = System.OpenModal( path ,800 , 300 ,  'resizable:yes;status:yes');
		OnSearch();

	}
 }
 function HighLightRoomNotAvailable(){

     for(var i=1; i< grdArriving.rows;i++){
		if(grdArriving.GetGridData(i,30) <=0 ){
			grdArriving.SetCellBgColor(i, 0, i, grdArriving.cols-1,0XEE82EE);
		}
	 }
 }
 function OnSave()
 {
	data_htfo00010.Call();
 }
 function Sum_Adult_Child()
 {
	var l_adult=0,l_child=0;
     for(var i=1; i< grdArriving.rows;i++)
	 {
		if(grdArriving.GetGridData(i,16) !="" )//adult
		{
			l_adult= l_adult + Number(grdArriving.GetGridData(i,16));//adult
			l_child= l_child + Number(grdArriving.GetGridData(i,18));//child
		}
	 }
	 txtAdult.text= l_adult;
	 txtChild.text= l_child;
 }
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00010" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" parameter="3,4,16,18,25"  function="CRM.sp_sel_htfo00010_form" procedure="CRM.sp_upd_htfo00010" >
                <input  bind="grdArriving">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
					<input bind="txtGuestNameS" />
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
                        <td align="right" style="width: 5%; white-space: nowrap">
                             Date
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
						<td style="width: 25%" align="right" nowrap >Room/Last/First Name/Contact Name</td>
					<td style="width: 17%" >
						<gw:textbox id="txtGuestNameS" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td align="right" style="width: 5%">
							 <b>Adult:</b></td>
					 <td style="width: 4%" align="center">
						 <gw:label id="txtAdult" />
					 </td>
					 <td align="right" style="width: 5%"> 
							 <b>Child:</b></td>
					 <td style="width: 4%" align="center">
						 <gw:label id="txtChild" />
					 </td>
                    <td align="right" style="width: 5%">
							 <b>Total:</b></td>
					<td style="width: 12%" align="center">
						 <gw:label id="txtCount" />
					 </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
						<td style="width: 3%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
						 <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport_rpt" img="printer" alt="Print2" onclick="OnReport('Detail_rpt')" />
                        </td>
                        <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport('All')" />
                        </td>
						<td width="3%" align="right">
                            <gw:imgbtn id="ibtnReportDetail" img="printer" alt="Print R-Card" onclick="OnReport('Detail')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdArriving' header='_pk|Company/Agent|Guest Type|Last Name|First Name|Gender|Nation|Arrive Date|Departure|Advance|Room Rate|Room#|Room Type|Contact Name|Contact Phone|Contact Mail|Adult|_Adul_F|Child|Slip No|Create By|Create Date|Request|_Room_Pk|_Room_Type|_bookingd_pk|VIP|Guest2 Name|Guest3 Name|Guest4 Name|_Status'
                    format='0|0|0|0|0|0|0|0|0|-0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|3|3|1|0|0|0|0|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='|||||||||||||||||||||||||||||' 
					editcol='0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick="OnAdvance(this)" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
