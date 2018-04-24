<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cashier Closure</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var G_CLOSE_PK          = 0,
    G_CLOSE_DATE        = 1,
    G_SHIFT             = 2,     
    G_CRT_DT            = 3,
    G_CRT_BY            = 4;

//=================================================================
function BodyInit()
{
    SetGridFormat();
    //-------------------
    OnSearch('LIST');    
}
//=================================================================

function OnSearch(pos)
{ 
    switch(pos)
    {
        case 'MASTER': 
            if ( grdDetail.row > 0 )
            { 
                txtMasterPK.text = grdDetail.GetGridData( grdDetail.row, G_CLOSE_PK );                
            }  
             
            data_htfo00120_1.Call("SELECT");        
        break;
        
        case 'LIST':
            data_htfo00120.Call("SELECT");        
        break;        
    }   
}

//=================================================================

function OnSave()
{
    data_htfo00120_1.Call();
}

//=================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_htfo00120':
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G_SHIFT, grdDetail.rows - 1, G_SHIFT, true);
            }
        break;
        
        case 'pro_htfo00120':
            alert(txtReturnValue.text);
            OnSearch('LIST');
        break;    
        
        case 'pro_htfo00120_1':
            alert(txtReturnValue.text);
            OnSearch('LIST');
        break;                
    }
}
//=================================================================

 function SetGridFormat()
 {      
     //-----------------------
    var data = "data|1|Shift 1|2|Shift 2|3|Shift 3";
    lstShift.SetDataText(data);  
    lstShift.value = 1;       
 }
 
//=================================================================

function OnClose()
{
    if ( confirm("Do you want to close shift?"))
    {
        pro_htfo00120.Call();
    }        
}

//=================================================================

function OnUnClose()
{
    if ( confirm("Do you want to un close shift?"))
    {
        pro_htfo00120_1.Call();
    }
}


//=================================================================
function OnGridClick()
{
      OnSearch('MASTER');
}
//=================================================================

function OnTextBlur(obj)
{
    if ( obj.id == 'txtOpenCashUSD' || obj.id == 'txtReceiveCashUSD' || obj.id == 'txtPaidOutUSD' || obj.id == 'txtAdjustCashUSD' )
    {
            txtBalanceUSD.text = Number(txtOpenCashUSD.text) + Number(txtReceiveCashUSD.text) - Number(txtPaidOutUSD.text) + Number(txtAdjustCashUSD.text);            
    }
    else if ( obj.id == 'txtOpenCashVND' || obj.id == 'txtReceiveCashVND' || obj.id == 'txtPaidOutVND' || obj.id == 'txtAdjustCashVND' )
    {
            txtBalanceVND.text = Number(txtOpenCashVND.text) + Number(txtReceiveCashVND.text) - Number(txtPaidOutVND.text) + Number(txtAdjustCashVND.text);            
    }
}
//=================================================================

function OnReport()
{
	if ( txtMasterPK.text != '' )
	{
        	var url =System.RootURL + '/reports/ht/fo/rpt_htfo00120.aspx?tht_shift_close_pk=' + txtMasterPK.text ;
	    	window.open(url, "_blank");    	
	}
}


//=================================================================
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="data_htfo00120" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" user="crm" function="CRM.sp_sel_htfo00120" > 
                <input bind="grdDetail">                    
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                </input> 
                <output bind="grdDetail" />
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="data_htfo00120_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="CRM.sp_sel_htfo00120_1" procedure="CRM.sp_upd_htfo00120_1"> 
                <inout> 
	                 <inout  bind="txtMasterPK" />
	                 <inout  bind="dtCloseDate" /> 			
                     <inout  bind="lstShift" />                     
                     <inout  bind="txtOpenCashUSD" />
                     <inout  bind="txtOpenCashVND" />                     
                     <inout  bind="txtReceiveCashUSD" />
                     <inout  bind="txtReceiveCashVND" />                     
                     <inout  bind="txtPaidOutUSD" /> 
                     <inout  bind="txtPaidOutVND" />                            
                     <inout  bind="txtAdjustCashUSD" /> 
                     <inout  bind="txtAdjustCashVND" />                                          
                     <inout  bind="txtBalanceUSD" />                     
                     <inout  bind="txtBalanceVND" /> 
                     <inout  bind="txtDropUSD" />                     
                     <inout  bind="txtDropVND" />                   
                     <inout  bind="txtCreditUSD" />                                    
                     <inout  bind="txtCreditVND" /> 
                     <inout  bind="txtLedgerUSD" />                      
                     <inout  bind="txtLedgerVND" />                                                          
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="pro_htfo00120" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_htfo00120" > 
                <input>
                    <input bind="dtCloseDate" />
                    <input bind="lstShift" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_htfo00120_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_htfo00120_1" > 
                <input>
                    <input bind="dtCloseDate" />
                    <input bind="lstShift" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="width: 100%; height: 1%">
            <td width="30%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 94%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" onchange="OnSearch('LIST')" />
                            ~
                            <gw:datebox id="dtTo" lang="1" onchange="OnSearch('LIST')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Print" onclick="OnSearch('LIST')" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 99%">
                        <td width="100%" colspan="3">
                            <gw:grid id='grdDetail' header='_PK|Date|Shift|Crt Dt|Crt By' format='0|4|0|0|0'
                                aligns='0|1|1|1|0' editcol='0|0|0|0|0' widths='0|1200|1000|1500|1500|0' sorting='T'
                                styles='width:100%; height:100%' onclick="OnGridClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td width="70%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%" align="right">
                            Close
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:datebox id="dtCloseDate" lang="1" />
                        </td>
                        <td style="width: 5%" align="right">
                            Shift
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstShift" styles='width:100%;' csstype="mandatory" />
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnClose" img="2" text="Close" styles='width:100%' onclick="OnClose()" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnUnClose" img="2" text="UnClose" styles='width:100%' onclick="OnUnClose()" />
                        </td>
                        <td style="width: 8%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnReport" img="excel" alt="Report" onclick="OnReport()" styles='width:100%' />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" styles='width:100%' />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <table style="width: 100%; height: 100%" cellspacing="0">
                                <tr>
                                    <td style="width: 20%">
                                    </td>
                                    <td style="width: 40%; color: cc0000; background-color: CCFFFF; font: 14pt" align="center">
                                        USD
                                    </td>
                                    <td style="width: 40%; color: cc0000; background-color: DDBBFF; font: 14pt" align="center">
                                        VND
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Open
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtOpenCashUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtOpenCashVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Receive
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtReceiveCashUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtReceiveCashVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Paid Out
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtPaidOutUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtPaidOutVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Adjust
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtAdjustCashUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtAdjustCashVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R"
                                            onblur="OnTextBlur(this)" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Balance
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtBalanceUSD" styles="width: 100%;font:14pt" csstype="mandatory"
                                            type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtBalanceVND" styles="width: 100%;font:14pt" csstype="mandatory"
                                            type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Drop
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtDropUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtDropVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%">
                                        Credit
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtCreditUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtCreditVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%; white-space: nowrap">
                                        City Ledger
                                    </td>
                                    <td style="width: 40%; background-color: CCFFFF">
                                        <gw:textbox id="txtLedgerUSD" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                    <td style="width: 40%; background-color: DDBBFF">
                                        <gw:textbox id="txtLedgerVND" styles="width: 100%;font:14pt" type="number" format="#,###,###,###,###.##R" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
