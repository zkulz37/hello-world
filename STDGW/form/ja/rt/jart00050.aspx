<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cash Summary Daily</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var l_crt_by;
function BodyInit()
{
    /*data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'PTYPE' and del_if=0")%>";
    grdSummaryReport.SetComboFormat(26,data);//payment method*/
    grdSummaryReport.GetGridControl().FrozenCols = 4;
    l_crt_by = "<%=Session("User_ID")%>";
    dat_SummaryReport.Call("SELECT");
}
function OnSearch()
{
    dat_SummaryReport.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00050_cash_summary_daily.rpt&procedure=CRM.sp_sel_jart00050_report&parameter="+dtTranFrom.GetData()+","+dtTranTo.GetData();   
     System.OpenTargetPage(url); 
}
function OnPrintBill(){
   if(grdSummaryReport.row > 1){
        var pk=grdSummaryReport.GetGridData(grdSummaryReport.row,27);
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart0050_invoice.rpt&procedure=CRM.sp_rpt_jart00050_invoice&parameter="+
	        pk+","+l_crt_by;   
	    System.OpenTargetPage(url); 
	}		 
	else{
	    alert("Please select one invoice to print.");
	    return;
	}   
}
function OnDataRec(obj)
{
    
    switch(obj.id)
	{
		case 'dat_SummaryReport':
		        txtCount.text=grdSummaryReport.rows-1 + " Bill(s).";	
			    grdSummaryReport.Subtotal( 1, 2, -1,'4!5!6!7!8!9!10!11!12!13!14!15!16!17!18!19!20!21!22!23!24!25!30');
		break;
		case 'dat_updatePackage':
		        txtCount.text=grdSummaryReport.rows-1 + " Bill(s).";	
			    grdSummaryReport.Subtotal( 1, 2, -1,'4!5!6!7!8!9!10!11!12!13!14!15!16!17!18!19!20!21!22!23!24!25!30');
		break;
    }
}
function OnSave()
{
    if(grdSummaryReport.row !='-1')
	{
		if(grdSummaryReport.GetGridData(grdSummaryReport.row,26) =='-1')//check
		{
			if(confirm("Are you sure undo checkout?"))
			{
				dat_SummaryReport.Call();
			}
		}
	}
	else
		{
			alert("You must check one Locker to undo checkout.");
		}
}
function OnSave_Package()
{
    if(grdSummaryReport.row !='-1')
	{
		dat_updatePackage.Call();	
	}
	else
		{
			alert("You must check one Locker to save package.");
		}
}
</script>

<body>
    <gw:data id="dat_SummaryReport" onreceive="OnDataRec(this)"> 
    <xml> 
        <dso  type="grid" parameter="26,27"  function="crm.sp_sel_jart00050_form" procedure="CRM.sp_upd_jart00050_form" > 
            <input bind="grdSummaryReport"> 
				<input bind="dtTranFrom" /> 
                <input bind="dtTranTo" /> 
                <input bind="txtLockerNo" /> 
            </input> 
            <output bind="grdSummaryReport"></output>
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dat_updatePackage" onreceive="OnDataRec(this)"> 
    <xml> 
        <dso  type="grid" parameter="27,31"  function="crm.sp_sel_jart00050_form" procedure="CRM.sp_upd_jart00050_package" > 
            <input bind="grdSummaryReport"> 
				<input bind="dtTranFrom" /> 
                <input bind="dtTranTo" /> 
                <input bind="txtLockerNo" /> 
            </input> 
            <output bind="grdSummaryReport"></output>
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
                                                    <td align="right" width="5%">
                                                        Date</td>
                                                    <td width="18%">
                                                        <gw:datebox id="dtTranFrom" lang="1" onchange="OnSearch()" />~<gw:datebox id="dtTranTo" lang="1" onchange="OnSearch()" />
                                                    </td>
                                                    <td align="right" width="10%">
                                                        Locker#/Invoice</td>
                                                    <td width="20%">
                                                        <gw:textbox id="txtLockerNo" lang="1" onenterkey="OnSearch()" />
                                                    </td>
                                                    <td width="2%">
                                                    </td>
                                                    <td style="width: 5%">
														 <gw:icon id="idBtnPrintBill" img="2" text="Print Bill" styles='width:100%' onclick="OnPrintBill()" />
													</td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="search" onclick="OnSearch()" />
                                                    </td>
                                                    <td style="width: 3%">
                                                        <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                                                    </td>
                                                    <td style="width: 3%" align="right">
                                                        <gw:icon id="btnSave" img="2" text="Undo Checkout" styles='width:100%' onclick="OnSave()" />

                                                    </td>
                                                    <td style="width: 5%">
														<gw:icon id="btnSavePackage" img="2" text="Save Package" styles='width:100%' onclick="OnSave_Package()" />
													</td>
                                                    <td align="right" style="width: 16%">
                                                        <b>Total Record</b></td>
                                                    <td style="width: 20%" align="center">
                                                        <gw:label id="txtCount" />
                                                    </td>
                                                    <td width="10%">
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
                            <gw:grid id="grdSummaryReport" header="No|Locker#|Invoice#|Golfer Name|Green Fee|Cart|Caddie|Rental|_SCTax|_VAT|_Total|Proshop|FnB|TeeHouse|Teaching|Drv.Range|Other|Org.Pay|Discount|Total Payment|Cash VND|Cash USD|Credit VND|Credit USD|Receivable|Sent Hotel|Select|_tgm_visitorfee_golfer_pk|Room|Customer|Other P/L|Package Y/N"
                                format="0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-1|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|3|0|0|0|-0|3" 
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|0|0|1" styles="width:100%; height:100%"
                                sorting="T" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
</body>
</html>
