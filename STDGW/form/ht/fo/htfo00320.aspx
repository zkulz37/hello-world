<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Ledger Adjust</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;
    
var G1_Room         = 0,
    G1_Last_Name    = 1,
    G1_First_Name   = 2,
    G1_Check_In     = 3,
    G1_Check_Out    = 4,
    G1_Days         = 5,
    G1_Type         = 6, 
    G1_Avg_Rate     = 7,
    G1_Room_Charge  = 8,
    G1_Total_Due    = 9,
    G1_Advance      = 10,
    G1_FB_Hotel     = 11,
    G1_MiniBar      = 12,
    G1_Laundry      = 13,
    G1_Biz_Center   = 14,
    G1_Others       = 15,
    G1_Nation       = 16,
    G1_Check_In_By  = 17,
    G1_Check_In_Date= 18,
    G1_Check_Out_By = 19,
    G1_Check_Out_Date= 20,
    G1_PK           = 21,
    G1_Rate_Plan    = 22,
    G1_Payment_Method= 23;  
    
var G2_PK           = 0,
    G2_Room_No      = 1,
    G2_Last_Name    = 2, 
    G2_First_Name   = 3,
    G2_Check_In     = 4,
    G2_Adjust_Date  = 5,
    G2_Ex_Rate      = 6,
    G2_Adj_Amt_USD  = 7,
    G2_Adj_Amt_VND  = 8,
    G2_Adj_Reason   = 9,
    G2_Adj_By_PK    = 10,
    G2_Adj_Emp_Name = 11,
    G2_RoomAllocatePK=12;
   
var arr_FormatNumber = new Array();  
 //===================================================================    

 function BodyInit()
 {
   var data="";
	data = "data|10|ROOM FEE|20|FnB FEE|30|GREEN FEE|40|CADDIE FEE|50|CART FEE|60|MINI BAR FEE|70|OTHERS|80|DEBIT FROM ADVANCE|ALL|Select All";
	lstFeeType.SetDataText(data);
	lstFeeType.value = 'ALL';
    OnSearch();
 }
 function OnSearch()
 {
	data_htfo00320.Call("SELECT");
 }
 //===================================================================    
 
  //===================================================================    

function OnReport()
{
      if(grdAdjust.rows >1)
	{		
		 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00320_adjust.rpt&procedure=crm.sp_sel_htfo00320&parameter="+dtAdjFr.value+","+dtAdjTo.value+","+txtRoomGuest.text+","+lstFeeType.value;              
	    System.OpenTargetPage(url); 
	}          
}
//=========================================================================

 function OnDataReceive(obj)
 {
	if(obj.id=='data_htfo00320')
	{
		grdAdjust.Subtotal( 1, 2, -1, '7!8');
		if(grdAdjust.rows > 2)
		{
			lblRecord.text=grdAdjust.rows-2 +" Room(s)."
		}
	}
 }
</script>

<body>
 
    <gw:data id="data_htfo00320" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"   function="crm.sp_sel_htfo00320">
                <input  bind="grdAdjust">
					<input bind="dtAdjFr" />
					<input bind="dtAdjTo" />
					<input bind="txtRoomGuest" />
					<input bind="lstFeeType" />
                </input> 
                <output bind="grdAdjust" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 2%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 7%; white-space: nowrap">
                            Adj Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtAdjFr" lang="1" styles="width:100%" onchange="OnSearch('ADJUST')"  />
                            ~
                            <gw:datebox id="dtAdjTo" lang="1" styles="width:100%" onchange="OnSearch('ADJUST')" />
                        </td>
						<td width="10%" align="right">
							Fee Type
						 </td>
						<td style="width: 21%; white-space: nowrap">
							<gw:list id="lstFeeType" styles='width:100%' onchange='OnSearch()' />
						</td>
                        <td style="width: 10%" align="right">
                            Room/Guest
                        </td>
                        <td style="width: 17%" align="right">
                            <gw:textbox id="txtRoomGuest" styles="width: 100%" onenterkey="OnSearch('ADJUST')" />
                        </td>
						<td style="width:5%">Total:
						</td>
						<td style="width:26%" align="left">
							<gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
						</td>
						<td style="width: 3%" align="right">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
						</td>
						<td style="width: 3%" align="right">
							 <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
						</td>              
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="13">
                            <gw:grid id='grdAdjust' header='_PK|Room No|Last Name|First Name|Check In|Adjust Date|_Ex-Rate|_AdjAmt(USD)|Adj Amt (VND)|Adj Reason|_Adj_By_PK|Adj Name|_Room_Allocate_PK|Fee Type'
                                format='0|0|0|0|0|0|-0|-2|-0|0|0|0|0|0' 
                                aligns='0|0|0|0|1|1|3|3|3|0|0|0|0|0' 
                                check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                widths='0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' acceptnulldate='F' styles='width:100%; height:100%' onafteredit="CheckInput()"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
   
    <!------------------------------------------------------------------>
</body>
</html>