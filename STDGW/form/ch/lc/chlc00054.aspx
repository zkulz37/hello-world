<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MR Process : Pop Up Take In Material</title>
</head>
<%ESysLib.SetUser("prod");%>

<script>
var grdItem;
var rtnValue = new Array();
var G1_PK               = 0,
    G1_TCO_COMPANY_PK   = 1,
    G1_Slip_No          = 2,
    G1_Doc_Date         = 3,
    G1_TAKEIN_EMP_PK    = 4,
    G1_Employee         = 5,
    G1_Warehouse        = 6,       
    G1_Description      = 7,
    G1_CLOSE_YN         = 8;
    
var G2_TIN_MATTAKEIND_PK    = 0,
    G2_TIN_MATTAKEIN_PK     = 1 ,   
    G2_TPR_PURORDD_PK       = 2,
    G2_TPR_REQIQCD_PK       = 3,
    G2_No                   = 4 ,   
    G2_TCO_BUSPARTNER_PK    = 5,
    G2_Vendor               = 6,
    G2_TakeIn_DT            = 7 ,   
    G2_TIN_WAREHOUSE_PK     = 8,
    G2_Warehouse            = 9,
    G2_TCO_ITEM_PK          = 10,
    G2_Item_Code            = 11,
    G2_Item_Name            = 12 ,   
    G2_UOM                  = 13,
    G2_TPR_LOTNO_PK         = 14,
    G2_Lot_No               = 15,
    G2_TakeIn_Qty           = 16,
    G2_Item_Price           = 17,
    G2_Amount               = 18,
    G2_CCY                  = 19,
    G2_Description          = 20;  
    
var G3_tpr_purord_pk    = 0,   
    G3_po_date          = 1,   
    G3_po_no            = 2,   
    G3_pl_nm            = 3,   
    G3_incoterm         = 4,   
    G3_payment_form     = 5,   
    G3_payment_term     = 6,   
    G3_po_ccy           = 7,   
    G3_ex_rate          = 8,   
    G3_po_amt           = 9,   
    G3_vat_amt          = 10,   
    G3_po_tot_amt       = 11,   
    G3_tac_abpl_pk      = 12,   
    G3_tco_company_pk   = 13,   
    G3_tpr_purordd_pk   = 14,   
    G3_tpr_poreqd_pk    = 15,   
    G3_tco_item_pk      = 16,   
    G3_select           = 17,    
    G3_item_code        = 18,   
    G3_item_name        = 19,   
    G3_item_unit        = 20,   
    G3_po_qty           = 21,   
    G3_pur_lot          = 22,   
    G3_po_lotqty        = 23,   
    G3_item_price       = 24,    
    G3_lot_price        = 25,   
    G3_po_amt           = 26,   
    G3_vat_rate         = 27,   
    G3_total_amt        = 28,   
    G3_etd_date         = 29,   
    G3_eta_date         = 30,   
    G3_description      = 31; 
  //--------------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    
    //---------------------
    SetGridFormat();
    
    BindingDataList();
    //---------------------
    txtVoucherNo.text = "<%=Request["slip_no"]%>"
    var callerWindowObj = dialogArguments; 
    grdItem   = callerWindowObj.grdDetailPO;   
    OnAddNew('grdMaster');
}
//---------------------------------------------------------------------------------------------------
function SetGridFormat()
{
    var ctrl = grdDetail.GetGridControl(); 

    ctrl.ColFormat(G2_TakeIn_Qty)   = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Item_Price)   = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Amount)       = "#,###,###,###,###,###.##";
}
//--------------------------------------------------------------------------

 function BindingDataList()
 {      
     var data ;
     
     //-----------------------
 }
//--------------------------------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdMaster':
            data_epbp00102.Call("SELECT");
        break;
    
        case 'grdDetail':        
            rtnValue[0] = txtVoucherNo.text;
            rtnValue[1] = dtVoucherDate.value
            data_epbp00102_1.Call("SELECT");
         break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_chlc00054":
            //----------------------
            if ( flag == 'save')
            {               
                //----------------------            
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }         
            //---------------------------- 
        break;
        case 'data_epbp00102_1':
            for(i=1; i<grdDetail.rows; i++)
                grdDetail.SetGridText(i, G2_No,i);
        break;
    }
}
//-------------------------------------------------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G2_TakeIn_Qty || col == G2_Item_Price || col == G2_Amount )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }     
    }
    //----------------------Calculate Amount -----
    if ( col == G2_TakeIn_Qty || col == G2_Item_Price )
    {
        dQuantiy = grdDetail.GetGridData( row, G2_TakeIn_Qty) ;
        dPrice   = grdDetail.GetGridData( row, G2_Item_Price) ;
        
        if(dQuantiy!=""&& dPrice!="")
        {    
            var dAmount = dQuantiy * dPrice;
            
            grdDetail.SetGridText( row, G2_Amount, parseFloat(dAmount+"").toFixed(2));
        }
        else
        {
            grdDetail.SetGridText( row, G2_Amount,"");
        }            
    }    
    //----------------------
}

//---------------------------------------------------------------------------------------------------
function OnAddNew(pos)
{
    switch (pos) 
    {
        case 'grdMaster': 
            data_chlc00054.StatusInsert();
           txtEmpPK.text = "<%=Session["EMPLOYEE_PK"]%>" ; 
           txtEmp.text   = "<%=Session["USER_NAME"]%>"  ; 
           cboCompany.text = '1';            
        break;
    }
}

//---------------------------------------------------------------------------------------------------
var flag;

function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_chlc00054.Call();
                flag='save';
            }            
        break;
        case 'Detail':   
            for(i =1; i< grdDetail.rows; i++)
                grdDetail.SetGridText(i, G2_TIN_MATTAKEIN_PK, txtMasterPK.text);    
            data_epbp00102_1.Call();
        break;
    }
}
//-------------------------------------------------------------------------------------
function Validate()
{  
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData(i,G2_TakeIn_Qty)) == 0)
        {
            alert("Input receiving Qty. at " + i + ",pls!")
            return false;
        }
        //---------------Posco ko co warehouse
//        if ( grdDetail.GetGridData(i, G2_TIN_WAREHOUSE_PK) == "")
//        {
//            alert("Input Warehouse at " + i + ",pls!")
//            return false;
//        }
        //---------------
    }
    //----------------
    return true;
}
//-------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------

function OnPopUp(pos)
{
    switch(pos)
    { 
        case 'POItem':
             //---------------------------
             if ( txtMasterPK.text == ''  )
             {
                alert('Pls save Voucher or select saved Voucher !');
                return ;
             }
             //---------------------------
             var path = System.RootURL + '/form/fp/ab/fpab00020.aspx';
             
             var object = window.showModalDialog( path ,this,  'resizable:yes;status:yes;dialogWidth:900px;dialogHeight:600px');
             
             if ( object != null )
             {
                var arrTemp
                for( var i=0; i < object.length; i++)	  
                {	
                    arrTemp = object[i];
                        
                    grdDetail.AddRow();                            
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TCO_BUSPARTNER_PK, arrTemp[0]);//Buss PK
                    grdDetail.SetGridText( grdDetail.rows-1, G2_Vendor,            arrTemp[1]);//Buss Name
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_No,             arrTemp[3]);//PO No
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TPR_PURORDD_PK, arrTemp[4]);//PO Detail PK	    
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TCO_ITEM_PK, arrTemp[5]);//item_pk	    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Code,   arrTemp[6]);//item_code	    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Name,   arrTemp[7]);//item_name	    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_UOM,         arrTemp[8]);//item_uom
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TakeIn_Qty, Number(arrTemp[11]) - Number(arrTemp[18]) );//PO QTY - Take In Qty
                    grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Price, arrTemp[12] );//Item Price
                    grdDetail.SetGridText( grdDetail.rows-1, G2_Amount,     arrTemp[14] );//Amount
                    grdDetail.SetGridText( grdDetail.rows-1, G2_CCY,        arrTemp[15] );//CCY
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G2_TakeIn_DT, grdMaster.GetGridData( grdMaster.row, G1_Doc_Date) );//Take In Date

                    grdDetail.SetGridText( grdDetail.rows-1, G2_TIN_WAREHOUSE_PK , grdMaster.GetGridData( grdMaster.row, G1_Warehouse));                            
                }		            
             }        
        break;    
    }
} 
//-------------------------------------------------------------------------------------
function onLoadItem()
{
    for(i=1; i<grdItem.rows; i++)
    {
        if(grdItem.GetGridData(i, G3_select) == '-1')
        {
            grdDetail.AddRow();
            
            grdDetail.SetGridText(grdDetail.rows-1, G2_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk
            grdDetail.SetGridText(grdDetail.rows-1, G2_TPR_PURORDD_PK  , grdItem.GetGridData(i, G3_tpr_purordd_pk));
            grdDetail.SetGridText(grdDetail.rows-1, G2_TCO_ITEM_PK    , grdItem.GetGridData(i, G3_tco_item_pk));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Item_Code      , grdItem.GetGridData(i, G3_item_code));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Item_Name      , grdItem.GetGridData(i, G3_item_name));
            grdDetail.SetGridText(grdDetail.rows-1, G2_UOM            , grdItem.GetGridData(i, G3_item_unit));
            grdDetail.SetGridText(grdDetail.rows-1, G2_TakeIn_Qty     , grdItem.GetGridData(i, G3_po_qty));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Item_Price     , grdItem.GetGridData(i, G3_item_price));
            grdDetail.SetGridText(grdDetail.rows-1,G2_TIN_WAREHOUSE_PK , 1);
                                                 
            grdDetail.SetGridText(grdDetail.rows-1, G2_Amount, Number(grdDetail.GetGridData(grdDetail.rows-1, G2_TakeIn_Qty))*Number(grdDetail.GetGridData(grdDetail.rows-1, G2_Item_Price)));                                   
        }     
    }
}
//-------------------------------------------------------------------------------------
function BodyClose()
{   
    rtnValue[0] = txtVoucherNo.text;
    rtnValue[1] = dtVoucherDate.value
    window.returnValue = rtnValue;
	window.close();
}
//-------------------------------------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------->
    <gw:data id="data_chlc00054" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7" function="inv.sp_sel_chlc00054"  procedure="inv.sp_upd_chlc00054"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="cboCompany" /> 
                     <inout  bind="txtVoucherNo" />
                     <inout  bind="dtVoucherDate" />                          
                     <inout  bind="txtEmpPK" /> 
                     <inout  bind="txtEmp" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtRemark" />  
                     <inout  bind="txtMasterClose" />                    
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00102_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  function="prod.sp_sel_epbp00102_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" procedure="prod.sp_upd_epbp00102_1" > 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />             
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 30%">
                        </td>
                        <td style="width: 10%" align="right">
                            </td>
                        <td style="width: 20%">
                            
                        </td>
                        <td style="width: 25%">
                        </td>
                        <td style="width: 1%">
                            <%--<gw:imgbtn id="btnSearch1" img="search" alt="Search" onclick="OnSearch('grdMaster')" />--%>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew1" img="new" alt="Select" onclick="OnAddNew('grdMaster')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete1" img="delete" alt="Select All" onclick="onSelectAll()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete1" img="udelete" alt="UnDelete" onclick="onUnSelectAll()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave1" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%">Emp Name</td>
                        <td style="width: 20%"><gw:textbox id="txtEmp" styles="width:100%"/></td>
                        <td style="width: 10%"><gw:textbox id="txtEmpPK" styles="width:100%;display:none"/></td>
                        <td style="width: 20%"></td>
                        <td style="width: 10%"></td> 
                        <td style="width: 30%"></td>                       
                    </tr>
                    <tr>
                        <td >Voucher No</td>
                        <td ><gw:textbox id="txtVoucherNo" styles="width:100%" csstype="mandatory" /></td>
                        <td ></td>
                        <td >Voucher Date</td>
                        <td ><gw:datebox id="dtVoucherDate" lang="1" /></td>    
                        <td></td>                    
                    </tr>
                    <tr>
                        <td>Remark</td>
                        <td colspan="5"><gw:textbox id="txtRemark" styles="width:100%"  /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 30%">
                        </td>
                        <td style="width: 10%" align="right">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 25%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew3" img="process" alt="Process" onclick="onLoadItem()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew2" img="new" alt="Select" onclick="OnPopUp('POItem')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete2" img="delete" alt="Select All" onclick="onSelectAll()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete2" img="udelete" alt="UnDelete" onclick="onUnSelectAll()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 97%">
            <td>
                <gw:grid id='grdDetail' header='_TIN_MATTAKEIND_PK|_TIN_MATTAKEIN_PK|_TPR_PURORDD_PK|_TPR_REQIQCD_PK|No|_TCO_BUSPARTNER_PK|_Vendor|TakeIn DT|_TIN_WAREHOUSE_PK|_Warehouse|_TCO_ITEM_PK|Item Code|Item Name|UOM|_TPR_LOTNO_PK|Lot No|TakeIn Qty|Item Price|Amount|_CCY|Description'
                    format='0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|0|0|1|0|0|0|0|0|1|0|0|3|3|3|1|0'
                    defaults='||||||||||||||||||||' editcol='0|0|0|0|1|0|0|1|0|0|0|0|0|0|0|0|1|1|1|1|1'
                    widths='1000|1000|1000|1000|800|1000|2000|1200|1000|2000|1000|1500|2500|800|1000|1500|1200|1200|1200|800|1000'
                    sorting='T' onafteredit="CheckInput()" styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->    
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtDate" styles="width: 100%;display: none" />
    <gw:textbox id="cboCompany" text="1" styles="width: 100%;display: none" />
    <gw:textbox id="lstWH" text="1" styles="width: 100%;display: none" />
    <gw:textbox id="txtMasterClose" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
