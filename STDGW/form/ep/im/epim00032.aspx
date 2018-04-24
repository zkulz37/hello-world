<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Im-Invoice : Pop Up Get Item from P/O</title>
</head>


<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>


<script>
//======================================================================    
var G_PO_M_PK       = 0,
    G_PO_NO         = 1,
    G_REQ_DATE      = 2,
    G_STATUS        = 3,
    G_HS_CODE       = 4,
    G_PO_D_PK       = 5,
    G_SEQ           = 6,
    G_PO_ITEM_PK    = 7,
    G_ITEM_CODE     = 8,
    G_ITEM_NAME     = 9,
    G_PO_QTY_01     = 10, 
    G_TR_QTY_01     = 11,
    G_BAL_QTY_01    = 12,
    G_REQ_UOM_01    = 13,   
    G_PO_QTY_02     = 14,
    G_TR_QTY_02     = 15, 
    G_BAL_QTY_02    = 16,   
    G_REQ_UOM_02    = 17,
    G_ST_ITEM_PK    = 18,
    G_U_PRICE       = 19,
    G_Supplier_PK   = 20,
    G_PL_PK         = 21,
    G_DESCRIPTION   = 22,
    G_PAYMENT_METHOD= 23,
    G_PAYMENT_TERM  = 24,
    G_PO_CCY        = 25, 
    G_ETD_FROM      = 26,
    G_ETD_TO        = 27,
    G_ETA_FROM      = 28,
    G_ETA_TO        = 29,
    G_TOTAL_AMOUNT  = 30;               
    
//======================================================================

function BodyInit()
{
    var supplier_pk = "<%=Request.querystring("supplier_pk")%>";
    
    if ( Number(supplier_pk) > 0 )
    {
        txtSupplierPK.text = supplier_pk ;    
    }
    
    //---------------------------------------
    FormatGrid();
    
    //---------------------------------------
    txtSupplierName.SetEnable(false);
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));

    //---------------------------------------
    OnSearch('SUPPLIER');
}
//======================================================================
 function FormatGrid()
 {           
    var ctrl = grdPOItem.GetGridControl(); 
    
    ctrl.ColFormat(G_PO_QTY_01)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_TR_QTY_01)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_BAL_QTY_01) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_PO_QTY_02)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_TR_QTY_02)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_BAL_QTY_02) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_U_PRICE)    = "#,###,###,###,###,###.##";
    
    grdPOItem.GetGridControl().MergeCells  = 2 ;	
    grdPOItem.GetGridControl().MergeCol(0) = true ;	
    grdPOItem.GetGridControl().MergeCol(1) = true ;   	
    grdPOItem.GetGridControl().MergeCol(2) = true ;	
    grdPOItem.GetGridControl().MergeCol(3) = true ;	
    grdPOItem.GetGridControl().MergeCol(4) = true ; 
 } 
//======================================================================

function OnSearch(pos)
{
    switch (pos)
    {
        case 'SUPPLIER':
            pro_epim00032.Call("SELECT");
        break;
        
        case 'PO':
            data_epim00032.Call("SELECT");
        break;
    }    
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
    if ( grdPOItem.rows > 1 )
    {
         grdPOItem.SetCellBgColor( 1, G_ITEM_CODE,  grdPOItem.rows-1, G_ITEM_NAME,  0xCCFFFF );
         grdPOItem.SetCellBgColor( 1, G_BAL_QTY_01, grdPOItem.rows-1, G_BAL_QTY_01, 0xCCFFFF );
         grdPOItem.SetCellBgColor( 1, G_BAL_QTY_02, grdPOItem.rows-1, G_BAL_QTY_02, 0xCCFFFF );
         
         grdPOItem.SetCellBold( 1, G_PO_NO,     grdPOItem.rows - 1, G_PO_NO,     true); 
         grdPOItem.SetCellBold( 1, G_ITEM_CODE, grdPOItem.rows - 1, G_ITEM_CODE, true);
         
         grdPOItem.SetCellBold( 1, G_PO_QTY_01, grdPOItem.rows - 1, G_BAL_QTY_01, true);  
         grdPOItem.SetCellBold( 1, G_PO_QTY_02, grdPOItem.rows - 1, G_BAL_QTY_02, true);
    }
}

//======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00032" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="control" user="prod" function="<%=l_user%>lg_pro_epim00032"  > 
                <inout> 
                    <inout bind="txtSupplierPK" />
                    <inout bind="txtSupplierName" />
                 </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------->
    <gw:data id="data_epim00032" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="<%=l_user%>lg_sel_epim00032" > 
                <input> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtSearchNo" />
                    <input bind="chkBalance" />
                    <input bind="txtSupplierPK" />
                </input> 
                <output bind="grdPOItem" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Supplier</td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSupplierPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%;" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtTo" lang="1" width="10%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            No</td>
                        <td style="width: 10%">
                            <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch('PO')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
                            Balance
                            <gw:checkbox id="chkBalance" styles="color:blue" defaultvalue="Y|N" value="Y" onclick="OnSearch('PO')" />
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('PO')" />
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
                <gw:grid id='grdPOItem' header='_M_PK|P/O No|Req Date|_Status|_HS_CODE|_D_PK|Seq|_TCO_ITEM_PK|Item Code|Item name|P/O Qty 1|Inv Qty 1|Bal Qty 1|UOM|P/O Qty 2|Inv Qty 2|Bal Qty 2|UOM|_NULL|U/P|_Supplier_PK|_PL_PK|Remark|_PM|_PT|_CYY|_ETD_FROM|_ETD_TO|_ETA_FROM|_ETA_TO|_AMOUNT'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|1|0|0|0|3|3|3|1|3|3|3|1|0|3|0|0|0|0|0|0|0|0|0|0|0'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1200|1200|1000|1500|0|800|0|2000|3000|1200|1200|1200|800|1200|1200|1200|800|1500|1200|0|0|1000|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
