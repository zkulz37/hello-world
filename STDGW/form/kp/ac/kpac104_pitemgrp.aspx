<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Item Group</title>
</head>
<%  ESysLib.SetUser("comm")
  
%>

<script>

var G_WH            = 7,
    G_Description   = 8,
    G_GrpCD_Display = 9,
    G_UOM           = 10,
    G_W_UOM         = 11,
    G_Lot_UOM       = 12,
    G_itemcd_prefix = 19,
    G_itemnm_prefix = 20;

 //---------------------------------------------------------
  
function BodyInit()
{
    
    var company_pk      = "<%=request.QueryString("company_pk")%>";
    var sale_yn         = "<%=request.QueryString("sale_yn")%>";
    var prod_yn         = "<%=request.QueryString("prod_yn")%>";
    //-----------------------
    if ( sale_yn == 'Y' )
    {
        txtSaleYN.text = sale_yn ;
    }
    //----------
    if ( prod_yn == 'Y' )  
    {  
        txtProdYN.text = prod_yn ;
    }    
    //-----------------------
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    cboCompany.SetDataText(data);

    if ( company_pk  > 0 )
    {
        cboCompany.value = company_pk;
    }
    
    //---------------------------------------- 
    data = "<%=ESysLib.SetGridColumnDataSQL("select pk, wh_id || '-' || wh_name  from inv.TIN_WAREHOUSE where del_if = 0 and use_yn='Y' " )%>" ; 
    grdGroup.SetComboFormat(G_WH,data);    
    
    //----------------------------------------         
    OnSearch();
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{
     data_agci00111.Call("SELECT");
}
//-----------------------------------------------------------------------------------------------

function OnGridCellDoubleClick(oGrid)
{
        var code_data=new Array()
        
	    var ctrl = oGrid.GetGridControl();
	    
	    var index, rowNo
	    index = 0 ;
	    rowNo = 0 ;
	    if( ctrl.SelectedRows == 0 )
        {
               return ;
        }
        else
	    {
            rowNo = event.row;
            for( j=0 ; j<oGrid.cols -1 ; j++ )
            {
                code_data[index] = oGrid.GetGridData(rowNo , j );
                index ++;
            } 
	    }
	    window.returnValue = code_data; 
	    this.close(); 	
} 

//-------------------------------------------------------------
</script>

<body>
    <!--------------------------------------------->
    <gw:data id="data_agci00111" onreceive=""> 
    <xml> 
           <dso id="1" type="grid" function="ec111.sp_sel_kpac104_pitemgrp" > 
                  <input bind="grdGroup" > 
                    <input bind="cboCompany" />
                    <input bind="txtGroup" />
                    <input bind="txtSaleYN" />
                    <input bind="txtProdYN" />				                 
                  </input>
                <output bind="grdGroup" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------->
    <table class="table" style="width: 100%; height: 100%" border="1">
        <tr style="height: 2%">
            <td>
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                        <td style="width: 10%" align="right">
                            Company
                        </td>
                        <td style="width: 30%">
                            <gw:list id="cboCompany" styles="width:100%" onchange="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
                            Group
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtGroup" text="" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td>
                <gw:grid id='grdGroup' header='_PK|Group Code|Group Name|Prod YN|Sale YN|Pur YN|_STSeqLength|WH|Description|_GrpCD_Display|UOM|WT UOM|Lot UOM|_expense_pk|_expense_cd|_expense_nm|_revenue_pk|_revenue_cd|_revenue_nm|_itemcd_prefix|_itemnm_prefix'
                    format='0|0|0|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1000|1500|5000|1000|1000|1000|1000|2000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0' sorting='T'
                    styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
    </table>
    <!--------------------------------------------->
    <gw:textbox id="txtSaleYN" text="" styles="width:100%;display:none" />
    <gw:textbox id="txtProdYN" text="" styles="width:100%;display:none" />
    <!--------------------------------------------->
</body>
</html>
