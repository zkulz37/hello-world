<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Invoice List</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
	OnChangeTab('radTab');
    //OnSearch();
}
function OnSearch()
{
	if(radTab.GetData()=='1')
	{
		dat_griddetail.Call("SELECT");
	}
	else
	{
		dat_griddetail_dtfrm_to.Call("SELECT");
	}
}
function OnDataReceive(obj)
 {
	if ( obj.id== 'dat_griddetail')
	{
		if (grdInvoiceList.rows > 1)	
		{
				grdInvoiceList.Subtotal( 1, 2, -1, '3!4!5!6!7!8!9!10');
				lblRows.text = grdInvoiceList.rows-2 +" row(s).";
		}
		else
		{
			lblRows.text ='0'+" row(s).";;
		}		
	}
	if ( obj.id== 'dat_griddetail_dtfrm_to')
	{
		if (grdInvoiceList.rows > 1)	
		{
				grdInvoiceList.Subtotal( 1, 2, -1, '3!4!5!6!7!8!9!10');
				lblRows.text = grdInvoiceList.rows-2 +" row(s).";
		}	
		else
		{
			lblRows.text ='0'+" row(s).";;
		}		
	}
 }
function OnPrint()
{
	var url =System.RootURL + '/reports/ht/fo/rpt_htfo00460_sct_item_list.aspx?p_month='+idMonth.value;
	System.OpenTargetPage(url); 
}
function OnChangeTab(pos)
 { 
    switch (pos)
    {        
        case 'radTab' :
            var strRad = radTab.GetData();
                 //alert(radTab.GetData());    
	        switch (strRad)
	        {
		       
				case '1':		    
		            rbt_date.style.display      = "none"; 
					rbt_month_control.style.display      = "";
		            rbt_month.style.display = "";	
					OnSearch();	
                break;
                
                case '2':
		            rbt_date.style.display      = ""; 
					rbt_month_control.style.display      = "none";
		            rbt_month.style.display = "none";
					OnSearch();	
                break;		        
            }             
        break;
    }    
 }

</script>
<body>
<gw:data id="dat_griddetail"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid"  function="crm.sp_sel_htfo00460"   > 
            <input bind="grdInvoiceList">                    
                <input bind="idMonth" /> 
            </input> 
            <output bind="grdInvoiceList"></output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_griddetail_dtfrm_to"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid"  function="crm.sp_sel_htfo00390_from_to"   > 
            <input bind="grdInvoiceList">                    
                <input bind="dtFrom" /> 
				<input bind="dtTo" /> 
            </input> 
            <output bind="grdInvoiceList"></output>
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
												<td  style="width: 12%; white-space: nowrap" align="center">
													<gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab('radTab')">                      
														<span id="tab_1" value="1">Month</span>                       
														<span id="tab_2" value="2">Date</span>   			                                
													</gw:radio>
												</td>
                                                <td width="20%" id='rbt_date'>
													<gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
													~<gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
												</td>
                                                    <td align="right" width="10%" id='rbt_month'>
                                                        Month:</td>
                                                    <td width="10%" id='rbt_month_control'>
                                                       <gw:datebox id="idMonth" maxlen="10" text="" styles='width:50%' lang="1"
														type="month" onchange="OnSearch()" />
                                                    </td>
													<td width="2%">
                                                        
                                                    </td>
													<td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
                                                    </td>
													<td width="3%">
                                                        
                                                    </td>
													<td width="5%">
                                                       Total: 
                                                    </td>
                                                    <td width="18%">
                                                       <gw:label id="lblRows" />
 
                                                    </td>
													<td style="width: 3%" align="right">
														<gw:imgbtn id="ibtnReport3" img="excel" alt="Invoice List" onclick="OnPrint()" />
													</td>
                                                    <td width="24%"></td>
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
                           <gw:grid id='grdInvoiceList'
							header='Invoice#|Invoice Date|Partner Name|Green Fee|Caddie Fee|Cart Fee|Drv Range Fee|Teaching Fee|Member Fee|SCT|Total'
							format='0|4|0|-0|-0|-0|-0|-0|-0|-0|-0'
							aligns='0|0|0|0|0|0|0|0|0|0|0'
							widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
							autosize='T' 
							styles='width:100%; height:100%'
							/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
</body>
</html>
