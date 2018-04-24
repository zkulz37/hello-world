<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
  OnSearch();
}
function OnSearch()
{
    dso_TennisRevenue.Call("SELECT");
}
function OnReport()
 {
	 if(grdTennisRevenue.rows > 1)
	 {
		 
		 var url = '/reports/ht/fo/rpt_htfo00450_tennis_revenue.aspx?p_dtfrom='+ dtFromDate.value+'&p_dtto='+dtToDate.value+'&p_invoice='+txtInvoiceNo.text+'&p_roomno='+txtRoomNo.text+'&p_delete='+cbDelete.value;
		  System.OpenTargetPage( System.RootURL+url , "newform" );                           
		 /*var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00450_tennis_revenue.rpt&procedure=CRM.sp_sel_htfo00450&parameter="+dtFromDate.value+","+dtToDate.value+","+txtInvoiceNo.text+","+txtRoomNo.text+","+cbDelete.value;      
		 System.OpenTargetPage(url); */
	 }
 }
 function OnDataReceive(obj)
 {
	if(obj.id=='dso_TennisRevenue')
	{
		if (grdTennisRevenue.rows > 1)	
		{
			grdTennisRevenue.Subtotal( 1, 2, -1, '5!6!7!8!9!11');
		}
	}
}
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="dso_TennisRevenue" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="crm.sp_sel_htfo00450"> 
            <input bind="grdTennisRevenue">                    
                <input bind="dtFromDate" />   
                <input bind="dtToDate" /> 
                <input bind="txtInvoiceNo" /> 
                <input bind="txtRoomNo" /> 
                <input bind="cbDelete" />
            </input> 
            <output bind="grdTennisRevenue" />
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
                                                    <td style="width: 25%; white-space: nowrap">
                                                        <gw:datebox id="dtFromDate" lang="1" onchange="OnSearch()" />
                                                        ~
                                                        <gw:datebox id="dtToDate" lang="1" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="13%" align="right">
                                                        Invoice No</td>
                                                    <td width="15%">
                                                        <gw:textbox id="txtInvoiceNo" styles="width:100%" onenterkey="OnSearch()" />
                                                    </td>
                                                    <td width="12%" align="right">
                                                        Room No</td>
                                                    <td width="10%">
                                                        <gw:textbox id="txtRoomNo" styles="width:100%" onenterkey="OnSearch()" />
                                                    </td>
                                                    <td width="10%" align="right">
                                                        <gw:checkbox id="cbDelete" defaultvalue="-1|0" onchange="OnSearch()"  />Delete YN
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                         <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()"
                                                            styles='width:100%' />
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
                            <gw:grid id="grdTennisRevenue" 
                                header="Date|Invoice#|Room|Last Name|First Name|Amount|Discount|SVC Amt|VAT Amt|Total due|Rate|Total Due(VND)|Payed|Create By|Create Date|Delete By|Delete Date"
                                format="4|0|0|0|0|-0|-0|-2|-2|-0|-0|-0|0|0|4|0|4"
                                styles="width:100%; height:100%" sorting="T" autosize="T" acceptNullDate="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
</body>
</html>
