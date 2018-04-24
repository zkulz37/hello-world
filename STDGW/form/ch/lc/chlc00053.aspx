<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%ESysLib.SetUser("prod");%>

<head>
    <title>Application Process : Pop Up Purchasing Entry</title>
</head>

<script>

var rtnValue = new Array();
var grdItem ;
var G1_PK               = 0,
    G1_TCO_COMPANY_PK   = 1,
    G1_PO_EMP_PK        = 2,
    G1_Emp              = 3,
    G1_PO_Date          = 4,
    G1_PO_NO            = 5,
    G1_PO_TYPE          = 6,       
    G1_PO_STATUS        = 7,
    G1_TAC_ABPL_PK      = 8,
    G1_PL_NM            = 9,  
    G1_Remark           = 10,
    G1_VENDOR_PK        = 11,
    G1_VENDOR           = 12,
    G1_DELIVER_PK       = 13,
    G1_DELIVER          = 14,
    G1_BUY_REP          = 15,
    G1_SALE_REP         = 16,
    G1_INCOTERM         = 17,
    G1_INCOTERM_DESC    = 18,  
    G1_PAYMENT_FORM     = 19,
    G1_PAYMENT_TERM     = 20,
    G1_PO_CCY           = 21,
    G1_EX_RATE          = 22,
    G1_PO_Amount        = 23,
    G1_VAT_Amount       = 24,
    G1_Total_Amount     = 25;
    
var G2_PK               = 0,
    G2_P_PK             = 1,
    G2_TPR_PURORD_PK    = 2,
    G2_TPR_POREQD_PK    = 3,
    G2_TPR_MATCONS_PK   = 4,
    G2_No               = 5,
    G2_TCO_ITEM_PK      = 6,
    G2_Item_Code        = 7,
    G2_Item_Name        = 8,   
    G2_UOM              = 9,
    G2_MR_Qty           = 10,
    G2_PO_Qty           = 11,
    G2_Lot              = 12,
    G2_Lot_Qty          = 13,
    G2_U_P              = 14,
    G2_Lot_Price        = 15,
    G2_PO_Amt           = 16,
    G2_VAT_Rate         = 17,
    G2_Total_Amt        = 18,  
    G2_TAC_ABPL_PK      = 19,
    G2_Project          = 20,
    G2_ETD              = 21,
    G2_ETA              = 22,
    G2_Item_Status      = 23,
    G2_BL_Qty           = 24,
    G2_IQC_Qty          = 25,
    G2_TakeIn_Qty       = 26,
    G2_Booked_Qty       = 27,
    G2_Comm_Qty         = 28,
    G2_Trans_Qty        = 29,
    G2_Description      = 30;    
    
var G3_tpr_poreq_pk     = 0,    
    G3_mr_no            = 1,    
    G3_doc_date         = 2,    
    G3_pl_nm            = 3,   
    G3_line_name        = 4,    
    G3_mrdescription    = 5,    
    G3_tco_company_pk   = 6,    
    G3_tac_abpl_pk      = 7,    
    G3_req_emp_pk       = 8,    
    G3_select           = 9,       
    G3_tpr_poreqd_pk    = 10,    
    G3_tco_item_pk      = 11,    
    G3_item_code        = 12,    
    G3_item_name        = 13,    
    G3_item_unit        = 14,    
    G3_req_qty          = 15,    
    G3_po_qty           = 16,    
    G3_unit_price       = 17,    
    G3_amount           = 18,    
    G3_itemdescription  = 19;
  //--------------------------------------------------------------------------

function BodyInit()
{        
    //----------------------
    System.Translate(document);  // Translate to language session

    //---------------------
    SetGridFormat();    
    SetStatus();
    BindingDataList();
    //---------------------
    txtMasterPK.text = "<%=Request["po_pk"]%>"
    var callerWindowObj = dialogArguments; 
    grdItem   = callerWindowObj.grdDetailMR;   
    OnAddNew('grdMaster');
    
    onLoadItem();
}
//---------------------------------------------------------------------------------------------------
function SetGridFormat()
{   
    ctrl = grdDetail.GetGridControl(); 

    ctrl.ColFormat(G2_MR_Qty)        = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_PO_Qty)        = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Lot_Qty)       = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_U_P)           = "#,###,###,###,###,###.##";
    
    ctrl.ColFormat(G2_Lot_Price)     = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_PO_Amt)        = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_VAT_Rate)      = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Total_Amt)     = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_BL_Qty)        = "#,###,###,###,###,###.##";

    ctrl.ColFormat(G2_IQC_Qty)       = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_TakeIn_Qty)    = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_TakeIn_Qty)    = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Booked_Qty)    = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Comm_Qty)      = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G2_Trans_Qty)     = "#,###,###,###,###,###.##";         
}
//--------------------------------------------------------------------------

 function BindingDataList()
 {      
         
            
 }
//--------------------------------------------------------------------------
function SetStatus()
{
    txtVATAmt.SetEnable(false); 
    txtAmt.SetEnable(false);   
    txtTotalAmt.SetEnable(false); 
}
//--------------------------------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    { 
        case 'grdMaster':
            txtMasterPK.text = '';
            data_chlc00053.Call("SELECT");
        break;
    
        case 'grdDetail':
        
            
            data_epbp00101_1.Call("SELECT");
         break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_chlc00053":   
            //--------------------
            if ( flag == 'save')
            {               
                //--------------------                        
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }         
            //---------------------------- 
        break;
    }
}
//-------------------------------------------------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G2_PO_Qty || col== G2_U_P || col == G2_Lot_Qty || col == G2_Lot_Price || col == G2_PO_Amt || col == G2_VAT_Rate || col == G2_Total_Amt)
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
        
        //-------------calculate amount-------------
        var quantity, unit_price, lot_price, lot_qty, tax, amount=0, total=0 ;
        
        quantity    = grdDetail.GetGridData( row, G2_PO_Qty     );
        unit_price  = grdDetail.GetGridData( row, G2_U_P        );
        lot_qty     = grdDetail.GetGridData( row, G2_Lot_Qty    );
        lot_price   = grdDetail.GetGridData( row, G2_Lot_Price  );
        tax         = grdDetail.GetGridData( row, G2_VAT_Rate   );
        
        // amount
        if ( (col!=G2_PO_Amt) && (col!=G2_Total_Amt) && (col!=G2_VAT_Rate) )
        {
                if (quantity!="" && unit_price !="")
                {
                  amount = Number(quantity)*Number(unit_price);
                }
                else
                {
                    if(lot_qty !="" && lot_price !="" && quantity!="")
                    {
                         amount = Number(quantity)/Number(lot_qty) *Number(lot_price);
                    }
                }
                grdDetail.SetGridText(row,G2_PO_Amt,amount);
        }
        else
        {
            var t = grdDetail.GetGridData(row,G2_PO_Amt);
            amount = t=""?0:Number(t)
        }
        
        //tax
        if( col != G2_Total_Amt) 
        {
            if ( amount>0 && tax!="" )
            {
                total = Number(tax) * amount / 100 + amount
            }
            else
            {
                total = amount;
            }    
            grdDetail.SetGridText( row, G2_Total_Amt, total); 
        } 
        
        //set PO mater amount
        txtAmt.text = ''+ SumCol(G2_PO_Amt);
        txtTotalAmt.text = ''+ SumCol(G2_Total_Amt) ;
        txtVATAmt.text = ''+  SumCol(G2_VAT_Rate) ;
   }  
}

//------------------------------------------------------------------------

function SumCol(col)    
{
    var value =0, temp =0;
    
    if ( col == G2_VAT_Rate)
    {
        var temp1=0;
        
        for(var i = 1 ; i< grdDetail.rows; i++)
        {   
            temp  = grdDetail.GetGridData(i,col);
            temp1 = grdDetail.GetGridData(i,G2_PO_Amt);
            
            if ( Number(temp)&& Number(temp1) )
            {
                value = value + temp*temp1/100 ;
            }
        }
    }
    else
    {
        for(var i = 1 ; i< grdDetail.rows; i++)
        {   
            temp = grdDetail.GetGridData(i,col);
            if(Number(temp))
            {
                value = value + Number(temp) ;
            }
        }
    }
    return value;
}

//---------------------------------------------------------------------------------------------------
function OnAddNew(pos)
{
    switch (pos) 
    {
        case 'grdMaster': 
            //------------------
            data_chlc00053.StatusInsert(); 
            txtEmpPK.text =  "<%=Session["EMPLOYEE_PK"]%>" ;
            txtEmpName.text = "<%=Session["USER_NAME"]%>"  ;
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
                data_chlc00053.Call();
                flag='save';
            }            
        break;
        case 'Detail':    
            for(i=1; i< grdDetail.rows ; i++)
                grdDetail.SetGridText(i, G2_TPR_PURORD_PK, txtMasterPK.text)
                    
            data_epbp00101_1.Call();
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
        if ( Number(grdDetail.GetGridData(i,G2_PO_Qty)) == 0)
        {
            alert("Input Puchasing Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}
//-------------------------------------------------------------------------------------

function OnPopUp(pos)
{
    switch(pos)
    { 
        case 'MR':
             //---------------------------
             if ( txtMasterPK.text == ''  )
             {
                alert('Pls save Purchasing or select saved PO !');
                return ;
             }
             //---------------------------
             var path = System.RootURL + '/form/ep/bp/epbp00021.aspx';
             
             var object = window.showModalDialog( path ,this,  'resizable:yes;status:yes;dialogWidth:1000px;dialogHeight:700px');             
             
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TPR_PURORD_PK, txtMasterPK.text); //master_pk	    	                                               

                            grdDetail.SetGridText( grdDetail.rows-1, G2_TPR_MATCONS_PK, arrTemp[2] ); //consumption	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_No,             arrTemp[5] );//MR No
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TPR_POREQD_PK,  arrTemp[0] );//MR Detail PK	 
                               
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MR_Qty, Number(arrTemp[14]) - Number(arrTemp[15]) );//MR Ref Qty	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_PO_Qty, Number(arrTemp[14]) - Number(arrTemp[15]) );//PO Qty	    
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_TCO_ITEM_PK, arrTemp[9]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Code,   arrTemp[10]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Name,   arrTemp[11]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_UOM,         arrTemp[12]);//item_uom
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Lot,         arrTemp[12]);//lot_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Lot_Qty,   1);//number of item per lot
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Status, 'A' );//status                             
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
            grdDetail.SetGridText(grdDetail.rows-1, G2_No            , grdDetail.rows-1);
            grdDetail.SetGridText(grdDetail.rows-1, G2_TPR_PURORD_PK , txtMasterPK.text);  
            grdDetail.SetGridText(grdDetail.rows-1, G2_TPR_POREQD_PK  , grdItem.GetGridData(i, G3_tpr_poreqd_pk));
            grdDetail.SetGridText(grdDetail.rows-1, G2_TCO_ITEM_PK    , grdItem.GetGridData(i, G3_tco_item_pk));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Item_Code      , grdItem.GetGridData(i, G3_item_code));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Item_Name      , grdItem.GetGridData(i, G3_item_name));
            grdDetail.SetGridText(grdDetail.rows-1, G2_UOM      , grdItem.GetGridData(i, G3_item_unit));
            grdDetail.SetGridText(grdDetail.rows-1, G2_PO_Qty         , grdItem.GetGridData(i, G3_req_qty));
            grdDetail.SetGridText(grdDetail.rows-1, G2_U_P     , grdItem.GetGridData(i, G3_unit_price));
                                                
            grdDetail.SetGridText(grdDetail.rows-1, G2_PO_Amt, Number(grdDetail.GetGridData(grdDetail.rows-1, G2_PO_Qty))*Number(grdDetail.GetGridData(grdDetail.rows-1, G2_U_P)));
            grdDetail.SetGridText(grdDetail.rows-1, G2_Total_Amt, grdDetail.GetGridData(grdDetail.rows-1, G2_PO_Amt));
            
            grdDetail.SetGridText( grdDetail.rows-1, G2_Item_Status, 'A' );//status 
            
            txtAmt.text = ''+ SumCol(G2_PO_Amt);
            txtTotalAmt.text = ''+ SumCol(G2_Total_Amt) ;
            txtVATAmt.text = ''+  SumCol(G2_VAT_Rate) ;
                  
        }     
    }
}
//-------------------------------------------------------------------------------------
function BodyClose()
{
    rtnValue[0] = txtPONo.text;
    rtnValue[1] = dtPODate.value;
    window.returnValue =  rtnValue;
	window.close();
}
//-------------------------------------------------------------------------------------
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chlc00053" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="prod.sp_sel_chlc00053" procedure="prod.sp_upd_chlc00053">
                <input>
                    <inout bind="txtMasterPK" />
                    <inout bind="cboCompany" /> 
                    <inout bind="txtEmpPK" />  
                    <inout bind="txtEmpName" />                    
                    <inout bind="dtPODate" />
                    <inout bind="txtPONo" />
                    <inout bind="lstTrading" />                    
                    <inout bind="lstStatus" />
                    <inout bind="txtProjectPK" />
                    <inout bind="txtProject" />  
                    <inout bind="txtRemark" />                                      
                    <inout bind="txtVendorPK" />
                    <inout bind="txtVendor" />
                    <inout bind="txtDeliverPK" />
                    <inout bind="txtDeliver" />                    
                    <inout bind="txtBuyRep" />
                    <inout bind="txtSaleRep" />                    
                    <inout bind="lstIncoterms" />                        
                    <inout bind="txtIncoTermsDesc" />                     
                    <inout bind="lstPaymentType" />
                    <inout bind="lstPayTerms" />
                    <inout bind="lstCurrency" />
                    <inout bind="txtExRate" />   
                    <inout bind="txtAmt" />   
                    <inout bind="txtVATAmt" /> 
                    <inout bind="txtTotalAmt" /> 
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00101_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  function="prod.sp_sel_epbp00101_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30" procedure="prod.sp_upd_epbp00101_1" > 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />             
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="0">
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right" nowrap>
                            </td>
                        <td style="width: 30%">
                        </td>
                        <td style="width: 10%" align="right" nowrap>
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
            <td></td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr valign="top" style="height: 1%;">
                        <td style="width: 10%" align="right" >Emp ID</td>
                        <td style="width: 20%" >
                            <gw:textbox id="txtEmpName" styles="width: 100%" /><gw:textbox id="txtEmpPK" styles="width: 100%;display:none" />
                        </td>
                        <td style="width: 10%" align="right"></td>
                        <td style="width: 30%" >
                        </td>
                        <td style="width: 10%" align="right">Amount</td>
                        <td style="width: 20%" >
                            <gw:textbox id="txtAmt"  type="number" format="#,###,###,###,###.##R"  styles="width: 100%" />
                        </td> 
                    </tr>
                    <tr valign="top" style="height: 1%;">
                        <td  align="right">Slip No</td>
                        <td >
                            <gw:textbox id="txtPONo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right">Slip Date</td>
                        <td ><gw:datebox id="dtPODate" lang="1" /></td>
                        <td align="right" nowrap >VAT Amount</td>
                        <td >
                            <gw:textbox id="txtVATAmt"  type="number" format="#,###,###,###,###.##R"  styles="width: 100%"  />
                        </td> 
                    </tr>
                    <tr valign="top" style="height: 98%;">
                        <td align="right">Remark</td>
                        <td colspan="3" >
                            <gw:textbox id="txtRemark" styles="width: 100%"/>
                        </td>
                        <td nowrap align="right">Total Amount</td>
                        <td >
                            <gw:textbox id="txtTotalAmt"  type="number" format="#,###,###,###,###.##R"  styles="width: 100%"/>
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right" nowrap>
                        </td>
                        <td style="width: 30%">
                            <gw:label id="lblPO" styles='width:100%;color:cc0000;font:9pt;display:none' text='PO No' />
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
                            <gw:imgbtn id="btnNew2" img="new" alt="Select" onclick="OnPopUp('MR')" />
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
                <gw:grid id='grdDetail' header='_PK|_P_PK|_TPR_PURORD_PK|_TPR_POREQD_PK|_TPR_MATCONS_PK|No|_TCO_ITEM_PK|Item Code|Item Name|UOM|Req. Qty|Purchasing Qty|_Lot|_Lot Qty|U/P|_Lot Price|Amt|VAT(%)|Total Amt|_TAC_ABPL_PK|_Project|_ETD|_ETA|_Item Status|_BL Qty|_IQC Qty|Receive Qty|_Booked Qty|_Comm Qty|_Trans Qty|Description'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|1|0|0|0|1|3|3|1|3|3|3|3|3|3|0|0|1|1|0|3|3|3|3|3|3|0'
                    defaults='||||||||||||||||||||||||||||||' editcol='0|0|0|0|0|1|0|0|0|0|0|1|1|1|1|1|1|1|1|0|0|1|1|1|0|0|0|0|0|0|1'
                    widths='1000|1000|1000|1000|1000|800|1000|1500|3000|800|1200|1500|1000|1200|1200|1200|1200|1200|1200|1000|2000|1200|1200|1500|1200|1200|1200|1200|1200|1200|1000'
                    sorting='T' onafteredit="CheckInput()" styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>                      
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtExRate" styles="width: 100%;display: none" />
    <gw:textbox id="lstCurrency" styles="width: 100%;display: none" />
    <gw:textbox id="lstPayTerms" styles="width: 100%;display: none" />
    <gw:textbox id="lstPaymentType" styles="width: 100%;display: none" />
    <gw:textbox id="txtIncoTermsDesc" styles="width: 100%;display: none" />
    <gw:textbox id="lstIncoterms" styles="width: 100%;display: none" />
    <gw:textbox id="txtSaleRep" styles="width: 100%;display: none" />
    <gw:textbox id="txtBuyRep" styles="width: 100%;display: none" />
    <gw:textbox id="txtDeliver" styles="width: 100%;display: none" />
    <gw:textbox id="txtDeliverPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtVendor" styles="width: 100%;display: none" />
    <gw:textbox id="txtVendorPK" styles="width: 100%;display: none" />
    <gw:textbox id="cboCompany" styles="width: 100%;display: none" />
    <gw:textbox id="lstTrading" styles="width: 100%;display: none" />
    <gw:textbox id="lstStatus" text="10" styles="width: 100%;display: none" />
    <gw:textbox id="txtProjectPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtProject" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
