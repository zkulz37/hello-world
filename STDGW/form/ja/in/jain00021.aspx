<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Purchasing Request Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
//======================================================================    
var G_PR_M_PK       = 0,
    G_PR_NO         = 1,
    G_REQ_DATE      = 2,
    G_STATUS        = 3,
    G_1             = 4,
    G_PR_D_PK       = 5,
    G_SEQ           = 6,
    G_TCO_ITEM_PK   = 7,
    G_ITEM_CODE     = 8,
    G_ITEM_NAME     = 9,
    G_REQ_QTY_01    = 10, 
    G_PO_QTY_01     = 11,
    G_BAL_QTY_01    = 12,
    G_REQ_UOM_01    = 13,   
    G_2             = 14,
    G_3             = 15, 
    G_4             = 16,   
    G_5             = 17,
    G_6             = 18,
    G_DESCRIPTION   = 19;
    
//======================================================================

function BodyInit()
{
    //---------------------------------------
    FormatGrid();
    
}
//======================================================================
 function FormatGrid()
 {           
    var ctrl = grdPRItem.GetGridControl(); 
    
    ctrl.ColFormat(G_REQ_QTY_01) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_PO_QTY_01)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_BAL_QTY_01) = "#,###,###,###,###,###.##";
    
    grdPRItem.GetGridControl().MergeCells  = 2 ;	
    grdPRItem.GetGridControl().MergeCol(0) = true ;	
    grdPRItem.GetGridControl().MergeCol(1) = true ;   	
    grdPRItem.GetGridControl().MergeCol(2) = true ;	
    grdPRItem.GetGridControl().MergeCol(3) = true ;	
    grdPRItem.GetGridControl().MergeCol(4) = true ; 
 } 
//======================================================================

function OnSearch()
{
    data_jain00021.Call("SELECT");
}        
//======================================================================
function OnSelect(oGrid)
{   
        var arr_data = new Array();
        for(var i = 1; i < grdPRItem.rows; i++ )
        {
            if ( grdPRItem.GetGridControl().isSelected(i) == true )
            {
                 var arrTemp = new Array();
                     
                 for( var j = 0; j < grdPRItem.cols; j++ )
                 {
                      arrTemp[arrTemp.length]= grdPRItem.GetGridData(i,j);
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
    if ( grdPRItem.rows > 1 )
    {
         grdPRItem.SetCellBgColor( 1, G_ITEM_CODE, grdPRItem.rows-1, G_ITEM_NAME, 0xCCFFFF );
         grdPRItem.SetCellBgColor( 1, G_BAL_QTY_01, grdPRItem.rows-1, G_BAL_QTY_01, 0xCCFFFF );
         
         grdPRItem.SetCellBold( 1, G_ITEM_CODE, grdPRItem.rows - 1, G_ITEM_CODE, true);
         
         grdPRItem.SetCellBold( 1, G_REQ_QTY_01, grdPRItem.rows - 1, G_BAL_QTY_01, true);  
    }
}

//======================================================================

</script>

<body>
    <!--------------------------------------------------------->
    <gw:data id="data_jain00021" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="crm.sp_sel_jain00021" > 
                <input> 
                    <input bind="txtSearchNo" />
                    <input bind="chkBalance" />
                </input> 
                <output bind="grdPRItem" /> 
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
                            Search No</td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Balance
                        </td>
                        <td style="width: 30%">
                            <gw:checkbox id="chkBalance" styles="color:blue" defaultvalue="Y|N" value="Y" onclick="OnSearch()" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExit" img="cancel" alt="Exit" text="Exit" onclick="OnSelect(grdPRItem)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" text="Select" onclick="OnSelect(grdPRItem)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="5">
                <gw:grid id='grdPRItem' header='_M_PK|M/R No|Req Date|Status|_NULL|_D_PK|Seq|_TCO_ITEM_PK|Item Code|Item name|Req Qty|P/O Qty|Bal Qty|UOM|_NULL|_NULL|_NULL|_NULL|_NULL|Remark'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|1|0|0|0|3|3|3|1|3|3|3|1|0|0'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1200|1200|1000|1500|0|1500|0|2000|3000|1200|1200|1200|800|1200|1200|1200|800|1500|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
