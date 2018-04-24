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

    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30)); 
    //---------------------
    
//    if ( process_yn == 'Y') 
//    {
//        btnNew3.SetEnable(false);
//    } 
//    else
//    {
//        btnNew3.SetEnable(true);
//    }  
    //---------------------
    SetGridFormat();
    
    BindingDataList();
    //---------------------
    txtPONo.text = "<%=Request["po_no"]%>"
    var callerWindowObj = dialogArguments; 
    grdItem   = callerWindowObj.grdDetailMR;   
    OnSearch('grdMaster');
}
//---------------------------------------------------------------------------------------------------
function SetGridFormat()
{
    var ctrl = grdMaster.GetGridControl(); 

    ctrl.ColFormat(G1_EX_RATE)      = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_PO_Amount)    = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_VAT_Amount)   = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G1_Total_Amount) = "#,###,###,###,###,###.##";
    
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
     var data ;
     
     //-----------------------
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='PRCP0020' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " ) %> ";       
     grdMaster.SetComboFormat( G1_PO_STATUS, data);     
            
 }
//--------------------------------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    { 
        case 'grdMaster':
            txtMasterPK.text = '';
            data_epbp00101.Call("SELECT");
        break;
    
        case 'grdDetail':
        
            if ( grdMaster.row > 0 )
            {
                txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G1_PK    );
                lblPO.text       = grdMaster.GetGridData( grdMaster.row, G1_PO_NO );
                rtnValue[0] = lblPO.text;
                rtnValue[1] = grdMaster.GetGridData( grdMaster.row, G1_PO_Date );
            }
            else
            {
                txtMasterPK.text = '' ;
                lblPO.text       = '' ;
                rtnValue[0]='';
                rtnValue[1]='';
            }
            data_epbp00101_1.Call("SELECT");
         break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_epbp00101":   
            //--------------------
            if ( flag == 'save')
            {
                lblPO.text = 'Select one PO' ;                 
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
        if ( grdMaster.row > 0 )
        {        
            grdMaster.SetGridText( grdMaster.row, G1_PO_Amount,    SumCol(G2_PO_Amt)    ) ;
            grdMaster.SetGridText( grdMaster.row, G1_Total_Amount, SumCol(G2_Total_Amt) ) ;
            grdMaster.SetGridText( grdMaster.row, G1_VAT_Amount,   SumCol(G2_VAT_Rate)  ) ;
        }
        else
        {
            alert('Select one PO master');
        }    
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
            //---------------------------- 
            grdMaster.AddRow(); 
            
            grdMaster.SetGridText( grdMaster.rows - 1, G1_PO_EMP_PK, "<%=Session["EMPLOYEE_PK"]%>" ) ;
            grdMaster.SetGridText( grdMaster.rows - 1, G1_Emp,       "<%=Session["USER_NAME"]%>"   ) ;
                         
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
                data_epbp00101.Call();
                flag='save';
            }            
        break;
        case 'Detail':        
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
            
            grdMaster.SetGridText( grdMaster.row, G1_PO_Amount,    SumCol(G2_PO_Amt)    ) ;
            grdMaster.SetGridText( grdMaster.row, G1_Total_Amount, SumCol(G2_Total_Amt) ) ;
            grdMaster.SetGridText( grdMaster.row, G1_VAT_Amount,   SumCol(G2_VAT_Rate)  ) ;
                  
        }     
    }
}
//-------------------------------------------------------------------------------------
function BodyClose()
{
    window.returnValue =  rtnValue;
	window.close();
}
//-------------------------------------------------------------------------------------
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00101" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="prod.sp_sel_epbp00101" procedure="prod.sp_upd_epbp00101" > 
                <input bind="grdMaster">
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtPONo" />                
                </input> 
                <output bind="grdMaster" /> 
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
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right" nowrap>
                            Purchasing Date</td>
                        <td style="width: 30%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 10%" align="right" nowrap>
                            Purchasing No</td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPONo" styles="width:100%" onenterkey="OnSearch('grdMaster')" />
                        </td>
                        <td style="width: 25%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch1" img="search" alt="Search" onclick="OnSearch('grdMaster')" />
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
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdMaster' header='_PK|_TCO_COMPANY_PK|_PO_EMP_PK|Emp|Voucher Date|Voucher NO|_PO_TYPE|Status|_TAC_ABPL_PK|_PL_NM|Remark|_VENDOR_PK|_VENDOR|_DELIVER_PK|_DELIVER|_BUY_REP|_SALE_REP|_INCOTERM|_INCOTERM_DESC|_PAYMENT_FORM|_PAYMENT_TERM|_PO_CCY|_EX_RATE|Amount|VAT Amount|Total Amount'
                    format='0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3'
                    defaults='|||||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1000|1000|1000|2000|1200|1500|1000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1200|1200|1200'
                    sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('grdDetail')" /> 
            </td>
        </tr>
        <tr style="height: 1%">
            <td>
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right" nowrap>
                            Purchasing No :
                        </td>
                        <td style="width: 30%">
                            <gw:label id="lblPO" styles='width:100%;color:cc0000;font:9pt' text='PO No' />
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
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdDetail' header='_PK|_P_PK|_TPR_PURORD_PK|_TPR_POREQD_PK|_TPR_MATCONS_PK|No|_TCO_ITEM_PK|Item Code|Item Name|UOM|Req. Qty|Purchasing Qty|_Lot|_Lot Qty|U/P|_Lot Price|Amt|VAT(%)|Total Amt|_TAC_ABPL_PK|_Project|_ETD|_ETA|_Item Status|_BL Qty|_IQC Qty|Receive Qty|_Booked Qty|_Comm Qty|_Trans Qty|Description'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|1|3|3|1|3|3|3|3|3|3|0|0|1|1|0|3|3|3|3|3|3|0'
                    defaults='||||||||||||||||||||||||||||||' editcol='0|0|0|0|0|1|0|0|0|0|0|1|1|1|1|1|1|1|1|0|0|1|1|1|0|0|0|0|0|0|1'
                    widths='1000|1000|1000|1000|1000|1500|1000|1500|3000|800|1200|1500|1000|1200|1200|1200|1200|1200|1200|1000|2000|1200|1200|1500|1200|1200|1200|1200|1200|1200|1000'
                    sorting='T' onafteredit="CheckInput()" styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
