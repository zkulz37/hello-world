<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head id="Head1" runat="server">
    <title>Im-Declaration : Pop Up Get Item from Import C/I</title>
</head>

<script>

var G1_CHK          = 0,
    G1_CI_PK        = 1,
    G1_SUPPLIER_PK  = 2,
    G1_CI_DATE      = 3,
    G1_CI_NO        = 4,
    G1_CONTRACT_NO  = 5,
    G1_REF_PO_NO    = 6,
    G1_TR_CCY       = 7,
    G1_TR_AMOUNT    = 8,
    G1_BOOK_AMOUNT  = 9;
       
var G2_DETAIL_PK = 0,
    G2_MST_PK    = 1,
    G2_SEQ       = 2,
    G2_REF_PO_NO = 3,
    G2_ST_ITEM_PK= 4,
    G2_ITEM_PK   = 5,
    G2_ITEM_CODE = 6,
    G2_ITEM_NAME = 7,
    G2_SPEC01_PK = 8,
    G2_SPEC01_ID = 9,
    G2_SPEC02_PK = 10,
    G2_SPEC02_ID = 11,
    G2_SPEC03_PK = 12,
    G2_SPEC03_ID = 13,
    G2_SPEC04_PK = 14,
    G2_SPEC04_ID = 15,
    G2_SPEC05_PK = 16,
    G2_SPEC05_ID = 17,
    G2_HS_CODE   = 18,    
    G2_INV_QTY_01= 19,
    G2_UOM_01    = 20,
    G2_INV_QTY_02= 21,
    G2_UOM_02    = 22,
    G2_UPRICE    = 23,
    G2_AMOUNT    = 24,
    G2_PO_D_PK   = 25,
    G2_REMARK    = 26;
        
//=======================================================================
   
function BodyInit()
{
    var supplier_pk = "<%=Request.querystring("supplier_pk")%>";
    
    if ( Number(supplier_pk) > 0 )
    {
        txtSupplierPK.text = supplier_pk ;    
    }
     
    txtSupplierName.SetEnable(false);
    //-------------------------------

    FormatGrid();  
    OnToggleGrid();  
    //-------------------------------
    OnSearch('SUPPLIER');
    //-------------------------------   
}
//=======================================================================
function FormatGrid()
{
    var ctrl = grdDetail.GetGridControl();  

    ctrl.ColFormat(G2_INV_QTY_01) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_INV_QTY_02) = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_UPRICE)     = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_AMOUNT)     = "#,###,###,###,###,###.##";   
    
    ctrl = grdMaster.GetGridControl(); 
        
    ctrl.ColFormat(G1_TR_AMOUNT)   = "###,###,###,###.##";
    ctrl.ColFormat(G1_BOOK_AMOUNT) = "###,###,###,###.##";

}

//=======================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_epim00052':
            lbRecord.text = grdMaster.rows-1 + " record(s)";
            
            if ( grdMaster.rows > 1 )
            {
                grdMaster.SetCellBold( 1, G1_TR_AMOUNT, grdMaster.rows - 1, G1_BOOK_AMOUNT, true);
                grdMaster.SetCellBold( 1, G1_CI_NO,     grdMaster.rows - 1, G1_CI_NO,       true);

                grdMaster.SetCellBgColor( 1, G1_CI_NO , grdMaster.rows - 1, G1_CI_NO , 0xCCFFFF ); 
                
                grdMaster.Subtotal( 0, 2, -1, '8!9','###,###,###.##');   
            } 
            
            grdDetail.ClearData();           
        break;        
        
        case 'data_epim00052_1':
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G2_INV_QTY_01, grdDetail.rows - 1, G2_INV_QTY_01, true);
                grdDetail.SetCellBold( 1, G2_INV_QTY_02, grdDetail.rows - 1, G2_INV_QTY_02, true);
                grdDetail.SetCellBold( 1, G2_AMOUNT,  grdDetail.rows - 1, G2_AMOUNT,  true);              
                                
                grdDetail.Subtotal( 0, 2, -1, '19!21','###,###,###.##');                
            }    
        break;  
        
        case 'pro_epim00052':
            OnSearch('grdMaster');
        break;       
    }
}
 
//=======================================================================

function OnSearch(obj)
{
    switch(obj)
    {
        case 'grdMaster':
            data_epim00052.Call("SELECT");
        break;
    
        case 'grdDetail':

            var t = 0 ;
            
            var array_ci_no = '';
            var array_ci_pk = '';
            var ci_date     = ''; 
                            
            for(var i = 1; i < grdMaster.rows-1 && t < 15; i++)
            {
                if ( grdMaster.GetGridData( i, G1_CHK) == -1 )
                {  
                    t = t + 1 ;    
                                       
                    array_ci_no = array_ci_no + grdMaster.GetGridData( i, G1_CI_NO) + ',';
                    array_ci_pk = array_ci_pk + grdMaster.GetGridData( i, G1_CI_PK) + ',';
                    
                    ci_date = grdMaster.GetGridData( i, G1_CI_DATE);                
                }
            }
                                   
            array_ci_no = array_ci_no.substring( 0, array_ci_no.length-1 );
            array_ci_pk = array_ci_pk.substring( 0, array_ci_pk.length-1 ); 
             
            if ( array_ci_pk != '' )
            {                
                txtArrayCIPK.text = array_ci_pk ;
                lbCINo.text       = array_ci_no ;
                txtCIDate.text    = ci_date ;
                                    
                data_epim00052_1.Call("SELECT");
            }                                                 
            //-----------------------------------            
        break;  
        
        case 'SUPPLIER':
            pro_epim00052.Call("SELECT");
        break;                    
    }
}

//=========================================================

function OnSelect()
{
        var arr_data = new Array();
        // the last row is sub total --> no need to select 
        for(var i = 1; i < grdDetail.rows-1; i++ )
        {
             var arrTemp = new Array();
                 
             for( var j = 0; j < grdDetail.cols; j++ ) 
             {
                  arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
             }
                 
             arr_data[arr_data.length]= arrTemp;
        }

        if ( arr_data != null )
        {
            var callerWindowObj = dialogArguments;    
              
            callerWindowObj.txtArrayCIPK.text = txtArrayCIPK.text ;
            callerWindowObj.txtInvoceNo.text  = lbCINo.text       ;  
            
            callerWindowObj.dtInvoiceDate.text  = txtCIDate.text ;           
        }
                              
        window.returnValue = arr_data;
        window.close();
      
} 

//=========================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G2_SPEC01_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC02_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC03_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC04_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC05_ID) = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G2_SPEC01_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC02_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC03_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC04_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G2_SPEC05_ID) = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
} 
 //===================================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00052" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="control" user="prod" function="<%=l_user%>lg_pro_epim00052"  > 
                <inout> 
                    <inout bind="txtSupplierPK" />
                    <inout bind="txtSupplierName" />
                 </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="data_epim00052" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_epim00052"  > 
                <input bind="grdMaster" >
			        <input bind="txtSupplierPK" />			        
			        <input bind="txtSearchNo" />			   
                </input>
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_epim00052_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid"  function="<%=l_user%>lg_sel_epim00052_1"  > 
                  <input bind="grdDetail" > 
                    <input bind="txtArrayCIPK" />					 																		
                  </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Cust</td>
            <td style="width: 55%">
                <gw:textbox id="txtSupplierPK" styles='width:100%;display:none' />
                <gw:textbox id="txtSupplierName" maxlen="100" styles='width:100%' />
            </td>
            <td align="right" style="width: 5%">
                No</td>
            <td style="width: 20%; white-space: nowrap">
                <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch('grdMaster')" />
            </td>
            <td style="width: 13%; text-align: center">
                <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'>record(s)</gw:label>
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdMaster')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="select" alt="Select" id="btnSelect" onclick="OnSelect()" />
            </td>
        </tr>
        <tr style="height: 39%">
            <td colspan="7">
                <gw:grid id='grdMaster' header='Chk|_PK|_SUPPLIER_PK|C/I Date|C/I No|Contract No|P/O No|CCY|Tr Amount|Book Amount'
                    format='3|0|0|4|0|0|0|0|0|0' aligns='0|0|0|1|0|0|0|1|3|3' check='|||||||||' editcol='1|0|0|0|0|0|0|0|0|0'
                    widths='1000|0|0|1200|2000|2000|2000|1000|1500|1500' sorting='T' styles='width:100%; height:100%'
                    onclick="OnSearch('grdDetail')" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                    style="cursor: hand" onclick="OnToggleGrid()" /></td>
            <td colspan="6">
                <gw:label id="lbCINo" styles='width:100%;font:9pt;color:red'></gw:label>
            </td>
        </tr>
        <tr style="height: 59%">
            <td colspan="7">
                <gw:grid id='grdDetail' header='_PK|_MST_PK|Seq|P/O No|_ST_ITEM_PK|_ITEM_PK|Item Code|Item Name|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|HS Code|Inv Qty|UOM|Qty 02|UOM|U/Price|Inv Amount|_SO_D_PK|Remark'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|0|0|0|1|0|1|0|1|0|1|0|1|0|3|1|3|1|3|3|0|0'
                    check='||||||||||||||||||||||||||' editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0|1|1|1|1'
                    widths='0|0|800|1500|0|0|2000|2500|0|1500|0|1500|0|1500|0|1500|0|1500|1000|1200|1000|1200|1000|1200|1200|1200|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------->
<gw:textbox id="txtArrayCIPK" styles='width:100%; display:none' />
<!--------------------------------------------------------------------------->
<gw:textbox id="txtCIDate" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------->
</html>
