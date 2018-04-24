<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("crm")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
var COL_PK          = 0,
    COL_INVOICE_ID  = 1,
    COL_TIME        = 2,
    COL_DUE         = 3,
	COL_AMT         = 4,
	COL_VAT         = 5,
	COL_SVC         = 6,
	COL_DSC         = 7,
    COL_LOCATION    = 8,
    COL_FULL_FNAME  = 9,
    COL_CARD_NO     = 10,
    COL_GOLFER_NAME = 11,
    COL_LOC         = 12;       
function BodyInit()
{
    txtTotalAMT.SetReadOnly(true);
    txtTotalSnackBar.SetReadOnly(true);
    
    OnSearch();
    Binding();
}
function Binding()
{
	var data;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-09') UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.NAME")%>";
	lstLocation.SetDataText(data);
	 
    data = "<%=ESysLib.SetListDataSQL("SELECT '', 'ALL' FROM DUAL UNION ALL SELECT TO_CHAR (pk), last_name FROM crm.tht_room_allocate WHERE pk < 0 AND del_if = 0")%>";
    lstGolfType.SetDataText(data);
}
function OnSearch()
{
    dsoListInvoices.Call();
}
function Control_OnClick(obj){
    switch(obj){
        case "Report1":
            var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/rt/htrt00100.rpt&procedure=CRM.sp_sel_htrt00100_rptmt|CRM.sp_sel_htrt00100_rptdt|CRM.sp_sel_htrt00100_rptdt2|CRM.sp_sel_htrt00100_rptdt3|CRM.sp_sel_htrt00100_rptdt4|CRM.sp_sel_htrt00100_rptdt5&parameter=" + dtFrom.GetData()+","+dtTo.GetData()+"|"+ dtFrom.GetData()+","+dtTo.GetData()+"|"+ dtFrom.GetData()+","+dtTo.GetData()+"|"+ dtFrom.GetData()+","+dtTo.GetData()+"|"+ dtFrom.GetData()+","+dtTo.GetData()+"|"+ dtFrom.GetData()+","+dtTo.GetData();
            System.OpenTargetPage(url); 
            window.close();
        break;
    }
}
function OnDataReceive(obj)
{
    switch(obj.id){
        case "dsoListInvoices":
            var sum_amt=0, sum_SnackBar=0;
            if(grdInvoices.rows > 1){
				grdInvoices.Subtotal( 1, 2, -1, '3!4!5!6!7');
                for ( var i=1; i < grdInvoices.rows; i++){
                    sum_amt += Number(grdInvoices.GetGridData( i, COL_AMT));
                    
                    if(grdInvoices.GetGridData( i, COL_LOC) == 'POINT-09')
                        sum_SnackBar    += Number(grdInvoices.GetGridData( i, COL_AMT));
                        
                }
            }
            txtTotalAMT.SetDataText("" + sum_amt)
            txtTotalSnackBar.SetDataText("" + sum_SnackBar);
            
            dsoListSell.Call();
        break;
        case "dsoListSell":
            lblRecord.text = grdInvoices.rows - 1 + " record(s)";
            if (grdInvoices.rows > 1)	
				grdSell.Subtotal( 1, 2, -1, '4');
        break;
    }
}
</script>
<body bgcolor='#F5F8FF'>
    <gw:data id="dsoListInvoices" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="crm.sp_sel_htrt00100" procedure="">  
                <input bind="grdInvoices">  
                    <input bind="dtFrom" />
					<input bind="dtTo" />
                    <input bind="lstLocation" />
                    <input bind="lstGolfType" />
					<input bind="txtInvoiceNo" />
                </input> 
                <output bind="grdInvoices" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dsoListSell" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="crm.sp_sel_htrt00101" procedure="">  
                <input bind="grdSell">  
                    <input bind="dtFrom" />
					<input bind="dtTo" />
                    <input bind="lstLocation" />
                    <input bind="lstGolfType" />
					<input bind="txtInvoiceNo" />
                </input> 
                <output bind="grdSell" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr style=" height: 2%">
                         <td colspan="2">
                             <fieldset>
						        <table style="width: 100%; height: 100%">
							        <tr>
							            <td style="width:5%">
											Invoice#
										</td>
										<td style="width:10%">
											<gw:textbox id="txtInvoiceNo" styles="width:100%;"  />
										</td>
								        <td width="5%" align="center">
									        Date
								        </td>
										<td width="5%">
									        <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
								        </td>
								        <td style="width:1%"> ~ </td>
								        <td width="5%">
									        <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" /> 
								        </td>
								        <td width="5%" align="center">
									        Location
								        </td>
								        <td width="20%">
									        <gw:list id="lstLocation" onchange="OnSearch()" />
								        </td>
								        <td width="7%" style="white-space:nowrap">
								            Customer Type
								        </td>
								        <td style="width:10%">
								            <gw:list id="lstGolfType" onchange="OnSearch()" />
								        </td>
								        <td width="3%">
									        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
								        </td>
								        <td style="width:3%">
								            <gw:imgbtn id="ibtnReport" img="printer" alt="Print Daily Revenue Report Hotel" onclick="Control_OnClick('Report1');" styles='width:100%'/>
								        </td>
								        <td style="width:15%" align="left">
								            <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
								        </td>
							        </tr>
						        </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style=" height: 98%">
                         <td style="width:70%" rowspan="2">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 98%">
                                    <td>
                                        <gw:grid id='grdInvoices' header='_PK|Invoice ID|Time|DUE|AMT(+)|VAT(+10%)|SVC(+5%)|DSC(-)|Location|Staff|Room#|Customer Name|_Loc'
                                            format  ='0|0|0|-0|-0|-0|-0|-0|0|0|0|0|0' 
                                            aligns  ='0|0|1|0|0|0|0|0|0|0|1|0|0' 
                                            editcol ='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            defaults='||||||||||||' 
                                            autosize='T'
                                            widths	='0|0|0|0|0|0|0|0|0|0|0|0|0' 
											sorting='T' styles='width:100%;height:100%' />
                                    </td>
                                </tr>  
                            </table>
                        </td>
                        <td style="width: 30%;height:55px" valign="top">
                            <table style="width: 100%">
                                <tr>
                                    <td valign="top" style="background-color:#33CCFF">
                                        <table style="height: 100%; width: 100%;border:0px;" cellspacing="1" cellpadding="1">
                                            <tr style="height:17px">
                                                <td style="padding-left:5px;background-color:White" width="65%">Total AMT</td>
                                                <td style="background-color:White"><gw:textbox id="txtTotalAMT" type="number" format="###,###,###,###.##" styles="width:100%;border:0px;"  /></td>
                                            </tr>
                                            <tr style="height:17px">
                                                <td style="padding-left:5px;background-color:White" width="35%">F&B Hotel</td>
                                                <td style="background-color:White"><gw:textbox id="txtTotalSnackBar" type="number" format="###,###,###,###.##" styles="width:100%;border:0px;"  /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table style="width: 100%;height:100%" border="0">
                                <tr style="height: 100%">
                                    <td valign="top">
                                        <gw:grid id='grdSell' header='_Item Code|Item Name|_Price| Q.ty |Price'
                                            format  ='0|0|0|0|-0' 
                                            aligns  ='0|0|0|1|3' 
                                            editcol ='0|0|0|0|0'
                                            defaults='||||' 
                                            autosize='T'
                                            widths='0|0|0|1100|2000' sorting='T' styles='width:100%;height:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
