<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("crm")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Driving Range Daily Report</title>
</head>

<script>
var COL_PK          = 0,
    COL_INVOICE_ID  = 1,
    COL_TIME        = 2,
    COL_AMT         = 3,
    COL_LOCATION    = 4,
    COL_FULL_FNAME  = 5,
    COL_CARD_NO     = 6,
    COL_GOLFER_NAME = 7,
    COL_LOC         = 8;       
function BodyInit()
{
    txtTotalAMT.SetReadOnly(true);
    txtTotalDriving.SetReadOnly(true);
    
    OnSearch();
    Binding();
}
function Binding()
{
	var data;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-16') UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.NAME")%>";
	lstLocation.SetDataText(data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-16')")%>";
    grdTableName.SetComboFormat(1,data);   
}
function OnSearch()
{
    dsoListInvoices.Call();
}
function Control_OnClick(obj){
    switch(obj){
        case "Report1":
            var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ps/japs00040.rpt&procedure=CRM.sp_sel_japs00040_rptmt|CRM.sp_sel_japs00040_rptdt&parameter=" + dtDate.GetData() + "|" + dtDate.GetData();
            System.OpenTargetPage(url); 
            window.close();
        break;
    }
}
function OnDataReceive(obj)
{
    switch(obj.id){
        case "dsoListInvoices":
            var sum_amt=0, sum_Driving=0;
            if(grdInvoices.rows > 1){
                for ( var i=1; i < grdInvoices.rows; i++){
                    sum_amt += Number(grdInvoices.GetGridData( i, COL_AMT));
                    
                    if(grdInvoices.GetGridData( i, COL_LOC) == 'POINT-07')
                        sum_Driving  += Number(grdInvoices.GetGridData( i, COL_AMT));

                }
            }
            txtTotalAMT.SetDataText("" + sum_amt)
            txtTotalDriving.SetDataText("" + sum_Driving);
            
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
            <dso type="grid" function="crm.sp_sel_japs00040" procedure="">  
                <input bind="grdInvoices">  
                    <input bind="dtDate" />
                    <input bind="lstLocation" />
                </input> 
                <output bind="grdInvoices" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dsoListSell" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="crm.sp_sel_japs00041" procedure="">  
                <input bind="grdSell">  
                    <input bind="dtDate" />
                    <input bind="lstLocation" />
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
							            <td style="width:25%"></td>
								        <td width="5%" align="center">
									        Date
								        </td>
								        <td width="10%">
									        <gw:datebox id="dtDate" lang="1" onchange="OnSearch()" />
								        </td>
								        <td width="5%" align="center">
									        Location
								        </td>
								        <td width="20%">
									        <gw:list id="lstLocation" onchange="OnSearch()" />
								        </td>
								        <td width="1%"></td>
								        <td width="3%">
									        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
								        </td>
								        <td style="width:3%">
								            <gw:imgbtn id="ibtnReport" img="printer" alt="Driving Range Daily Report" onclick="Control_OnClick('Report1');" styles='width:100%'/>
								        </td>
								        <td style="width:22%" align="left">
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
                                        <gw:grid id='grdInvoices' header='_PK|Invoice ID|Time|AMT|Location|Staff|Locker No|Customer Name|_Loc'
                                            format  ='0|0|0|-2|0|0|0|0|0' 
                                            aligns  ='0|0|1|3|0|0|1|0|0' 
                                            editcol ='0|0|0|0|0|0|0|0|0'
                                            defaults='||||||||' 
                                            autosize='T'
                                            widths='2000|800|1000|1000|1000|1000|1000|1000|1000' sorting='T' styles='width:100%;height:100%' />
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
                                                <td style="padding-left:5px;background-color:White" width="35%">Total Driving Range Academy</td>
                                                <td style="background-color:White"><gw:textbox id="txtTotalDriving" type="number" format="###,###,###,###.##" styles="width:100%;border:0px;"  /></td>
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
                                            format  ='0|0|0|0|-2' 
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
