<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get P/O Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>   
//======================================================================    
var G_PK            = 0,
    G_PO_NO         = 1,
    G_Invoice_Date  = 2,
    G_ITEM_PK       = 3,
    G_Item_Code     = 4,
    G_Item_Name     = 5,
    G_Qty           = 6,
    G_INV_QTY_02    = 7,
    G_BALANCE       = 8,
    G_Unit_Price    = 9,
    G_Unit          = 10, 
    G_Remark        = 11;
    
    
//======================================================================

function BodyInit()
{
    //---------------------------------------
    FormatGrid();
    txtSupplierPK.text="<%=Request.querystring("supplierpk")%>";
    
}
//======================================================================
 function FormatGrid()
 {           
//    var ctrl = grdPOItem.GetGridControl(); 
//    
//    ctrl.ColFormat(G_Qty)  = "#,###,###,###,###,###.##";
//    ctrl.ColFormat(G_BALANCE) = "#,###,###,###,###,###.##";
 } 
//======================================================================

function OnSearch()
{
    data_shmm00042.Call("SELECT");
}        
//======================================================================
function OnSelect(oGrid)
{   
        var arr_data = new Array();
        for(var i = 1; i < grdPOItem.rows; i++ )
        {
            if ( grdPOItem.GetGridControl().isSelected(i) == true )
            {
                 var arrTemp = new Array();
                     
                 for( var j = 0; j < grdPOItem.cols; j++ )
                 {
                      arrTemp[arrTemp.length]= grdPOItem.GetGridData(i,j);
                 }
                     
                 arr_data[arr_data.length]= arrTemp;
            }
        }
         
        window.returnValue =  arr_data;
        window.close();	          	
}

//======================================================================
function OnDataReceive(obj)
{
//    if ( grdPOItem.rows > 1 )
//    {
//         grdPOItem.SetCellBgColor( 1, G_Item_Code, grdPOItem.rows-1, G_Item_Name, 0xCCFFFF );
//         grdPOItem.SetCellBgColor( 1, G_BAL_QTY_01, grdPOItem.rows-1, G_BAL_QTY_01, 0xCCFFFF );
//         
//         grdPOItem.SetCellBold( 1, G_REF_PO_NO, grdPOItem.rows - 1, G_REF_PO_NO, true); 
//         grdPOItem.SetCellBold( 1, G_ITEM_CODE, grdPOItem.rows - 1, G_ITEM_CODE, true);
//         
//         grdPOItem.SetCellBold( 1, G_PO_QTY_01, grdPOItem.rows - 1, G_BAL_QTY_01, true);  
//    }
}
//======================================================================

</script>

<body>
    <!--------------------------------------------------------->
    <gw:data id="data_shmm00042" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="prod.sp_sel_shmm00042" > 
                <input> 
                    <input bind="txtSearchNo" />
                    <input bind="txtSupplierPK" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdPOItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            PO No/Item
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
                            Period
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Balance
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:checkbox id="chkBalance" styles="color:blue" defaultvalue="Y|N" value="Y" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExit" img="cancel" alt="Exit" text="Exit" onclick="OnSelect(grdPOItem)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" text="Select" onclick="OnSelect(grdPOItem)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="5">
                <gw:grid id='grdPOItem' header='_PK|P/O No|Invoice No|Invoice Date|_ITEM_PK|Item Code|Item Name|Qty|_INV_QTY_02|_BALANCE|Unit Price|Unit|Remark'
                    format='0|0|0|4|0|0|0|-0|-0|-0|-0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' oncelldblclick="OnSelect(this)" />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
    <gw:textbox id="txtSupplierPK" styles="width:100%;display:none" />
    <!-------------------------------------------------------------------------->
</body>
</html>
