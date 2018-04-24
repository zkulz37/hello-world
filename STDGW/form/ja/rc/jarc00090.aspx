<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	var data="";
	/*data = "data|10|ROOM FEE|20|FnB FEE|30|GREEN FEE|40|CADDIE FEE|50|CART FEE|60|MINI BAR FEE|70|OTHERS|80|DEBIT FROM ADVANCE|ALL|Select All";
	lstFeeType.SetDataText(data);
	lstFeeType.value = 'ALL';*/
 OnSearch();
}
function OnSearch()
{
    dat_OtherFee.Call("SELECT");
}
function OnReport()
 {
	 if(grdOtherFee.rows > 1)
	 {
		 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00400_tennis.rpt&procedure=CRM.sp_rpt_htfo00400&parameter="+dtFromDate.value+","+dtToDate.value+","+txtInvoiceNo.text+","+txtRoomNo.text;      
		 System.OpenTargetPage(url); 
	 }
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='dat_OtherFee')
	{
		
		if(grdOtherFee.rows > 1)
		{
			grdOtherFee.Subtotal( 1, 2, -1, '6');
			lblRecord.text=grdOtherFee.rows-2 +" Guest(s)."
		}
	}
 }

</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dat_OtherFee" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="crm.sp_sel_jarc00090"> 
            <input bind="grdOtherFee">                    
                <input bind="dtFromDate" />  
                <input bind="dtToDate" /> 
            </input> 
            <output bind="grdOtherFee" />
        </dso> 
    </xml> 
</gw:data>
    <!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td style="width: 5%">
                                                        Date
                                                    </td>
                                                    <td style="width: 18%; white-space: nowrap">
                                                        <gw:datebox id="dtFromDate" lang="1" onchange="OnSearch()" />
                                                        ~
                                                        <gw:datebox id="dtToDate" lang="1" onchange="OnSearch()" />
                                                    </td>
													<td width="10%" align="right">
														Total:
                                                     </td>
													<td style="width: 21%; white-space: nowrap">
														<gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
													</td>
													<td width="3%">
                                                        <gw:imgbtn id="btnSearch" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="20%" align="right">
                                                       </td>
                                                    <td width="20%">
                                                       
                                                    </td>
                                                    
                                                    
                                                    <td width="3%">
                                                         <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()"
                                                            styles='width:100%;display: none' />
                                                    </td>
													 
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%"> 
                            <gw:grid id='grdOtherFee'
							header='Invoice#|Golfer Name|Checkin Date|Checkout Date|_Vat Rate|_Service Rate|Fee Amt|Fee Description'
							format='0|0|4|4|-0|-0|-0|0'
							aligns='0|0|0|0|0|0|0|0'
							check='|||||||'
							editcol='0|0|0|0|0|0|0|0'
							widths='1000|1000|1000|1000|1000|1000|1000|1000'
							sorting='T'
							autosize='T' 
							styles='width:100%; height:460'
							/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
</body>
</html>
