<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Warehouse Stock Checking</title>
</head>
<%  ESysLib.SetUser("inv")%>

<script>

var G3_Lot_No = 4 ;    

var G1_Trans_Type   = 0,
    G1_WH           = 1,
    G1_Date         = 2,
    G1_Slip_No      = 3,
    G1_Item_Code    = 4,
    G1_Item_name    = 5,
    G1_UOM          = 6,
    G1_Lot_No       = 7,
    G1_QTY          = 8,
    G1_Description  = 9,
    G1_TABLE_NAME   = 10,
    G1_TABLE_PK     = 11;

var G2_WH           = 0,
    G2_Item_Code    = 1,
    G2_Item_Name    = 2,
    G2_UOM          = 3,
    G2_SPEC1        = 4,
    G2_SPEC2        = 5,
    G2_SPEC3        = 6,
    G2_SPEC4        = 7,
    G2_SPEC5        = 8,
    G2_Lot_No       = 9,
    G2_Begin        = 10,
    G2_Input        = 11,
    G2_Output       = 12,
    G2_End          = 13;
    
var G3_WH           =0,
    G3_ST_Item_Code =1,
    G3_ST_Item_Code =2,
    G3_Begin_Qty    =3,
    G3_Input_Qty    =4,
    G3_Output_Qty   =5,
    G3_End_Qty      =6;
    
//----------------------------------------------------------------------------------------
var vPage = 1;

function BodyInit()
{
    OnSearch();
}

//----------------------------------------------------------------------------------------

function BindingDataList()
{
 
}

//===========================================================================
function SetGridFormat()
{ 
        
}

//===========================================================================

function OnSearch()
{
    data_ephl00060.Call("SELECT");
}

//===========================================================================

function OnPrint(obj)
{
}

//==================================================================
function OnProcess(obj)
{
}

//==================================================================
function OnDataReceive(obj)
{
}

//==================================================================


//==================================================================
function OnPopUp(obj)
{

}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_ephl00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="imex.sp_sel_ephl00090"  > 
                <input bind="grdStock">                    
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtItem" /> 
                </input> 
                <output bind="grdStock" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <!---------------------------------------------------------------->
    <!---------------------------------------------------------------->
    <!---------------------------------------------------------------->
    <table style="height: 100%; width: 100%">
        <tr valign="top" style="height: 100%">
            <td style="width: 100%">
                <table style="height: 100%; width: 100%" border="1" name="Item In/Out" id="TabInOutMonthly">
                    <tr style="height: 1%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 50%">
                                    <td style="width: 1%" align="right">
                                        Date</td>
                                    <td style="width: 20%" align="left">
                                        <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" />
                                        ~<gw:datebox id="dtTo" lang="<%=Application("Lang")%>" /></td>
                                    <td style="width: 5%" align="right">
                                        Item</td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtItem" styles="width:100%;" onenterkey="OnSearch('Monthly')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <gw:grid id='grdStock' header='Item Code|Item Name|Unit Price|UOM|Import Qty|Liquid Qty|Stock Qty'
                                format='0|0|0|0|-0|-0|-0' aligns='0|0|0|0|0|0|0' check='||||||' editcol='0|0|0|0|0|0|0'
                                widths='1200|1800|1000|1000|1200|1200|1200' sorting='T'  styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<!------------------------------------------------------->
</html>
