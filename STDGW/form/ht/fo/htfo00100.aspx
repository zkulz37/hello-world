<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Guest Arriving</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
var  user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name = "<%=Session("USER_NAME")%>" ;
    
//===================================================================================

 function OnSearch(pos) 
 {	  
    if ( pos == 'INVOICE' )
    {
        if ( grdRoomAllocate.row > 0 )
        {
            txtRoomAllocatePK.text = grdRoomAllocate.GetGridData( grdRoomAllocate.row, 0);
            data_htfo00100_1.Call("SELECT");
        }    
    }
    else
    {
        data_htfo00100.Call("SELECT");
    }    
 }

//===================================================================================

 function BodyInit()
 {
    //dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-1));
    //----------------------
    grdRoomAllocate.GetGridControl().FrozenCols = 5;
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE DESC")%>||Select All";
	lstLocation.SetDataText(data);
	lstLocation.value='';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE DESC")%>";
	grdInvoice.SetComboFormat(2, data);//location
	EMPLOYEE_PK.text=user_pk;
	var l_dtFrm=(dtFrom.GetData());
	var l_get_dt_frm=l_dtFrm.substring(0,6)+"01";
	dtFrom.value=l_get_dt_frm;


	OnSearch();
 }
 
//===================================================================================
 
 function OnDataReceive(obj)
 {
	if(obj.id=='data_htfo00100_1')
	{
		if (grdInvoice.rows > 1)	
		{
				grdInvoice.Subtotal( 1, 2, -1, '3!4!5!6!7!8');
				for (i = 2; i < grdInvoice.rows; i++)
				{
					grdInvoice.SetCellBgColor(i, 0, i, 0, 0xB3B3D7);
					grdInvoice.SetCellBgColor(i, 9, i, 9, 0xB3B3D7);	
				}
		}
	}
	else if ( obj.id== 'data_htfo00100')
	{
		if (grdRoomAllocate.rows > 1)	
		{
				grdRoomAllocate.Subtotal( 1, 2, -1, '7!8!9!10!11!12!13!14!15!16!17!18!19!20!21!22!23!24!25');
				lblRows.text = grdRoomAllocate.rows-2;
		}	    
	}
 }
 
//===================================================================================
 
function OnReport(pos)
{
    switch(pos)
    {
        case '1':
                var url =System.RootURL + '/reports/ht/fo/rpt_htfo00100.aspx?p_date='+dtFrom.value+'&p_date_to='+dtTo.value+'&p_gst_name_rm_no='+txtRoomGuest.text;  
	            System.OpenTargetPage(url);	           
	    break;   
	    
	    case '2':
            if ( grdRoomAllocate.row > 0 )
	        {	    
                if ( chkCheckOut.value == 'N' )
                {	        	       
                     var url =System.RootURL + '/reports/ht/fo/rpt_htfo00251.aspx?p1=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row,21);
	                 System.OpenTargetPage(url);  
	            }
	            else if ( chkCheckOut.value == 'Y')
	            {
                     var url =System.RootURL + '/reports/ht/fo/rpt_htfo00252.aspx?p1=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row,21);
	                 System.OpenTargetPage(url);  	            
	            }
	        }      	    
	    break; 
	    
		case '3':
            if(grdInvoice.rows > 1) 
				{
					 if(grdInvoice.row !='-1')
					 {
						var url =System.RootURL + '/reports/ht/fo/rpt_htfo00101.aspx?tcm_invoice_pk=' + grdInvoice.GetGridData(grdInvoice.row,15);
						System.OpenTargetPage(url);  	              
					 }
				}  
	    break; 	
		case '4':
				if(grdInvoice.rows > 1)
				{
					var check_all_pk="",check_all_pk_end="";
					for(var i=1;i<grdInvoice.rows;i++)//check crca_pk exit?if crca_pk not null-->printview report 
					{
						if(grdInvoice.GetGridData(i,0) !="") 
						{
							check_all_pk += grdInvoice.GetGridData(i,15)+",";//pk--col=15
							
						}
					}
					check_all_pk_end=check_all_pk.substring(0,check_all_pk.length-1);
					txtChkALLPK.text=check_all_pk_end;
				}
				if(txtChkALLPK.text !="")
					{
						var url =System.RootURL + '/reports/ht/fo/rpt_htfo00101_all_detail.aspx?tcm_invoice_pk='+txtChkALLPK.text;
						System.OpenTargetPage(url);  	  
					}
             /*if(grdInvoice.rows > 1) 
				{
					 if(grdInvoice.row !='-1')
					 {
						var url =System.RootURL + '/reports/ht/fo/rpt_htfo00101.aspx?tcm_invoice_pk=' + grdInvoice.GetGridData(grdInvoice.row,15);
						window.open(url, "_blank");  	              
					 }
				}*/
	    break; 
	}    
}
function OnPrintLedger(){
	if(grdRoomAllocate.row !='-1')
	{
		 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00100_Ledger.rpt&procedure=CRM.sp_sel_htfo00100_detail&parameter=" + grdRoomAllocate.GetGridData(grdRoomAllocate.row,0);
		  System.OpenTargetPage(url);
	}	  
}
function ShowDetailInvoice()
{
	if(grdInvoice.col=='0')//double click in column Invoice
	{
		var path = System.RootURL + '/form/ht/fo/htfo00100_1.aspx?pk=' + grdInvoice.GetGridData(grdInvoice.row, 15) + '&sn=' + grdInvoice.GetGridData(grdInvoice.row, 0)+ '&date=' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(6,8) + '/' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(4,6)+ '/' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(0,4)+ '&room=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row, 1);
		var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
	}
	if(grdInvoice.col=='9')//double click in column Room
	{
	  var path = System.RootURL + '/form/ht/fo/htfo00061.aspx';
		   var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
		   if ( obj != null )
		   {
				grdInvoice.SetGridText(grdInvoice.row, 9, obj[2]);//room
				grdInvoice.SetGridText(grdInvoice.row, 16, obj[0]);//room_allocate_pk					
		   }
	}

}
//=========================================================================
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
function OnSave()
{
	if(grdInvoice.rows > 1)
	{
		if(grdInvoice.row !=-1)
		{
			data_htfo00100_1.Call();
		}
		else
		{
			alert("Please,choose room and change room to save.");
		}
	}
}
function OnPrinFolio(){
    if(grdRoomAllocate.rows > 1)
	{
		if(grdRoomAllocate.row !=-1)
		{
			var url = '/reports/ht/fo/rpt_htfo00100_print_Hotel_Golf.aspx?p_tht_room_allocate_pk='+grdRoomAllocate.GetGridData(grdRoomAllocate.row,0)+'&p_cashier_pk='+ user_pk + '&p_dtfrom='+dtFrom.value+'&p_dtto='+dtTo.value; 
			System.OpenTargetPage( System.RootURL+url , "newform" );
		}
		else
		{
			alert("Please,choose room# to print.")
			
		}
    }
}

</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00100" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00100" >
                <input  bind="grdRoomAllocate">
                    <input bind="dtFrom" /> 
					<input bind="dtTo" />
                    <input bind="txtRoomGuest" /> 
                </input> 
                <output bind="grdRoomAllocate" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00100_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" parameter="15,16" function="CRM.sp_sel_htfo00100_1" procedure="crm.sp_upd_htfo00100_1" >
                <input  bind="grdInvoice">
                    <input bind="txtRoomAllocatePK" />
					<input bind="lstLocation" />
					<input bind="dtFrom" /> 
					<input bind="dtTo" />
                </input> 
                <output bind="grdInvoice" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 25%; white-space: nowrap" align="center">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
							~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Room#/Guest Name:
                        </td>
                        <td width="20%" align="right">
                            <gw:textbox id="txtRoomGuest" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Total Room:
                        </td>
                        <td style="width: 17%">
                            <gw:label id="lblRows" />
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
						<td style="width:3%">
					            <gw:imgbtn id="ibtnReport" img="printer" alt="Print Room Ledger Detail" onclick="OnPrintLedger()" styles='width:100%'/>
					    </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnReport1" img="excel" alt="Report" onclick="OnReport('1')" />
                        </td>
                        <td style="width: 5%" >
							<gw:icon id="btnIFolio" text="Folio" onclick="OnPrinFolio()"  styles="width: 100%"/>
						</td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id='grdRoomAllocate'
								header='_pk|Room No|Room Type|Last Name|First name|Checkin Date|Checkout Date|Total|Room Amt|BF Amt|FnB Hotel|Minibar|Laundry|Tennis|Telephone|Golf FnB|Proshop|Prv Range|Teaching|Golf Rental|Green Fee|Caddie Fee|Cart Fee|Bag Fee|Discount|Adjust'
								format='0|0|0|0|0|4|4|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0'
								aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
								check='|||||||||||||||||||||||||'
								editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0||0'
								widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
								acceptnulldate="T" sorting='T' autosize='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('INVOICE')"
								/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width:7%; white-space: nowrap">
                            Location
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:list id="lstLocation" onchange="OnSearch('INVOICE')" />
                        </td>
                        
                        <td style="width:70%; white-space: nowrap" align="center">
						   Double click on the row below to see detail invoice
                        </td>
						
						<td style="width: 3%" align="right">
                            <gw:imgbtn id="btnSaveM" img="Save" alt="Save" onclick="OnSave()" />
                        </td>
						<td style="width: 3%" align="right">
                            <gw:imgbtn id="ibtnReport4" img="excel" alt="Print All" onclick="OnReport('4')" styles='width:100%;'  />
                        </td>
                        <td style="width: 3%" align="right">
                            <gw:imgbtn id="ibtnReport3" img="excel" alt="Folio" onclick="OnReport('3')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdInvoice' header='Invoice No|Date|Location|Amount(usd)|Amount(vnd)|SVC Amt|Vat Amt|Discount|Total Due|Room#|Created By|Created date|Modified by|Modified date|Status|_invoice_PK|_room_allocate_pk'
                                format='0|4|0|-2|-0|-0|-0|-0|-0|0|0|0|0|0|0|0|0' 
                                aligns='0|0|0|0|0|0|0|0|0|0|1|0|0|0|1|0|0'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                sorting='T' styles='width:100%; height:100%' autosize="T" 
								oncelldblclick="ShowDetailInvoice()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtRoomAllocatePK" styles='width:100%;display:none' />
	<gw:textbox id="txtChkALLPK" styles='width:100%;display:none' />
	<gw:textbox id="EMPLOYEE_PK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
