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
	if ( chkCheckOut.value == 'N' )
        {
		id_date.style.display = 'none';
        }
        else
        {
		id_date.style.display = '';
        }   
    data_htfo00250.Call("SELECT");
 }
 function BodyInit()
 {
    dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-1));
    //----------------------
    grdRoomAllocate.GetGridControl().FrozenCols = 5;
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE ||'-'|| NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE")%>||Select All";
	lstLocation.SetDataText(data);
	lstLocation.value='';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE,CODE ||'-'|| NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE")%>";
	grdInvoice.SetComboFormat(2, data);//location
	EMPLOYEE_PK.text= "<%=Session("EMPLOYEE_PK")%>" ;
	OnSearch();
 }
 function OnSearchLocation()
 {
	txtRoom_Allocate_pk.text = grdRoomAllocate.GetGridData(grdRoomAllocate.row, 24);//
	data_htfo00250_Location.Call("SELECT");
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='data_htfo00250_Location')
	{
		if (grdInvoice.rows > 1)	
		{
				grdInvoice.Subtotal( 1, 2, -1, '3!4!5!6!7!8');
		}
	}
	else if ( obj.id== 'data_htfo00250')
	{
		if (grdRoomAllocate.rows > 1)	
		{
				grdRoomAllocate.Subtotal( 1, 2, -1, '8!9!10!11!12!13!14!15!16!17!18!19');
				lblRows.text = grdRoomAllocate.rows-2;
				grdRoomAllocate.SetGridText(1,0,"");
		}	    
	}
 }
function OnReport(pos)
{
    switch(pos)
    {
        case '1':
               /* var url =System.RootURL + '/reports/ht/fo/rpt_htfo00250.aspx?checkout_yn=' + chkCheckOut.value + '&from_dt=' + dtFrom.value;
	            window.open(url, "_blank");*/
			if(grdRoomAllocate.rows > 1)
			{		
				var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00250.rpt&procedure=CRM.sp_rpt_htfo00250_2&parameter="+txtRoomNo.GetData()+","+dtFrom.value+","+chkCheckOut.value;  
				 System.OpenTargetPage(url); 
			}		
	    break;   
	    
	    case '2':
			if (chkCheckOut.value == 'N'){alert('Please select checkout!'); return false;}
			if ( grdRoomAllocate.row > 0 ){
				if(grdRoomAllocate.GetGridData(grdRoomAllocate.row,24) != ''){
					var url =System.RootURL + '/reports/ht/fo/rpt_htfo00050_print_Hotel_Golf.aspx?p_tht_room_allocate_pk='+grdRoomAllocate.GetGridData(grdRoomAllocate.row,24);
	                System.OpenTargetPage(url);	
				}
			}
			
            /*if ( grdRoomAllocate.row > 0 )
	        {	    
                if ( chkCheckOut.value == 'N' )
                {	        	       
                     var url =System.RootURL + '/reports/ht/fo/rpt_htfo00251.aspx?p1=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row,24);
	                 window.open(url, "_blank");  
	            }
	            else if ( chkCheckOut.value == 'Y')
	            {
                     var url =System.RootURL + '/reports/ht/fo/rpt_htfo00252.aspx?p1=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row,24);
	                 window.open(url, "_blank");  	            
	            }
	        }*/  	    
	    break; 
	    
        case '3': 
			if(grdInvoice.row !="-1")
				 {
					 var url =System.RootURL + '/reports/ht/fo/rpt_htfo00253.aspx?tcm_invoice_pk=' + grdInvoice.GetGridData(grdInvoice.row,15);
					 System.OpenTargetPage(url);  
				 }
			else
				{
					alert("Please,choose invoice to print.");
				}		
	    break;
	    case '4':    //24 proom_allocate_k     26 paymentmethod  
			if(grdRoomAllocate.rows >1)
			{
				 if(grdRoomAllocate.row !="-1")
				 {
					 /*var url = '/reports/ht/fo/Invoice.aspx?p1=' + TABLE_PK.GetData() +"&p2="+EMPLOYEE_PK.text + "&p3=Y&p4=" + grdMST.GetGridData(idx,COL_PAY_METHOD);
						System.OpenTargetPage( System.RootURL+url , "newform" );*/
					 var url = '/reports/ht/fo/rpt_htfo00040_print_Hotel_Golf.aspx?p_tht_room_allocate_pk='+grdRoomAllocate.GetGridData(grdRoomAllocate.row,24)+'&p_cashier_pk='+EMPLOYEE_PK.text+'&p__printed_yn='+'N'+'&p_paymethod='+grdRoomAllocate.GetGridData(grdRoomAllocate.row,26);
					 System.OpenTargetPage( System.RootURL+url , "newform" );	
				}
				else
				{
					alert("Please,choose customer to print invoice.");
				}
			}
			else
				{
					alert("No data.");
				}
	    break;
	}    
}
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00250" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00250" >
                <input  bind="grdRoomAllocate">
                    <input bind="txtRoomNo" /> 
                    <input bind="dtFrom" />
                    <input bind="chkCheckOut" />
                </input> 
                <output bind="grdRoomAllocate" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="data_htfo00250_Location" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00250_Location" >
                <input  bind="grdInvoice">
                    <input bind="txtRoom_Allocate_pk" />
					<input bind="lstLocation" />
                </input> 
                <output bind="grdInvoice" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Room#/Guest Name:
                        </td>
                        <td width="20%" align="right">
                            <gw:textbox id="txtRoomNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="left">
                            Check Out
                            <gw:checkbox id="chkCheckOut" styles="color:blue" defaultvalue="Y|N" value="N" onclick="OnSearch()">
                            </gw:checkbox>
                        </td>
                        <td style="width: 30%; white-space: nowrap" align="center" id="id_date">
                            From:
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Total Room:
                        </td>
                        <td style="width: 20%">
                            <gw:label id="lblRows" />
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
						<td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnReport3" img="excel" alt="Print Invoice" onclick="OnReport('4')" style="display:none" />
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnReport1" img="excel" alt="Report" onclick="OnReport('1')" />
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnReport2" img="excel" alt="Invoice" onclick="OnReport('2')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id='grdRoomAllocate' header='Room|Last Name|First Name|Check In|Check Out|Days|Type|Avg Rate|Room Charge|Total Due|Payed|Advance|F&B Hotel|MiniBar|Laundry|Telephone|Others|Golf Package|Golf fees|Adjust|Check In By|Check In Date|Check Out By|Check Out Date|_PK|Rate Plan|Payment Method'
                                format='0|0|0|4|4|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0'								
								sorting='T' autosize='T' acceptnulldate="T" styles='width:100%; height:100%'
                                oncellclick="OnSearchLocation()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 8%; white-space: nowrap">
                            Location
                        </td>
                        <td style="width: 40%; white-space: nowrap">
                            <gw:list id="lstLocation" onchange="OnSearchLocation()" />
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td style="width: 5%" align="right">
                        </td>
                        <td width="13%" align="right">
                        </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                        </td>
                        <td style="width: 28%" align="right">
                            <gw:imgbtn id="ibtnReport3" img="excel" alt="Report" onclick="OnReport('3')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdInvoice' header='Invoice No|Date|Location|Amount(usd)|Amount(vnd)|SVC Amt|Vat Amt|Discount|Total Due|Room#|Created By|Created date|Modified by|Modified date|Status|_PK'
                                format='0|4|0|-2|-0|-0|-0|-0|-0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|1|0|0|0|1|0|0'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                sorting='T' styles='width:100%; height:100%' autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtRoom_Allocate_pk" styles='width:100%;display:none' />
	<gw:textbox id="EMPLOYEE_PK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
