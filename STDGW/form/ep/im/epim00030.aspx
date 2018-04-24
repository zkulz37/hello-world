<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Import Invoice Entry</title>
</head>


<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>


<script>

   var user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
   var user_name  = "<%=Session("USER_NAME")%>" ;

var flag;
      
var G_DETAIL_PK = 0,
    G_MST_PK    = 1,
    G_SEQ       = 2,
    G_REF_PO_NO = 3,
    G_ST_ITEM_PK= 4,
    G_ITEM_PK   = 5,
    G_ITEM_CODE = 6,
    G_ITEM_NAME = 7,
    G_SPEC01_PK = 8,
    G_SPEC01_ID = 9,
    G_SPEC02_PK = 10,
    G_SPEC02_ID = 11,
    G_SPEC03_PK = 12,
    G_SPEC03_ID = 13,
    G_SPEC04_PK = 14,
    G_SPEC04_ID = 15,
    G_SPEC05_PK = 16,
    G_SPEC05_ID = 17,
    G_HS_CODE   = 18,    
    G_INV_QTY_01= 19,
    G_UOM_01    = 20,
    G_INV_QTY_02= 21,
    G_UOM_02    = 22,
    G_UPRICE    = 23,
    G_AMOUNT    = 24,
    G_PO_D_PK   = 25,
    G_REMARK    = 26;
    
var G2_DETAIL_PK = 0,
    G2_MST_PK    = 1,
    G2_SEQ       = 2,
    G2_REF_PO_NO = 3,
    G2_ST_ITEM_PK= 4,
    G2_ITEM_PK   = 5,
    G2_ITEM_CODE = 6,
    G2_ITEM_NAME = 7,
    G2_HS_CODE   = 8,    
    G2_INV_QTY_01= 9,
    G2_UOM_01    = 10,
    G2_INV_QTY_02= 11,
    G2_UOM_02    = 12,
    G2_UPRICE    = 13,
    G2_AMOUNT    = 14,
    G2_PO_D_PK   = 15,
    G2_REMARK    = 16;

var arr_FormatNumber = new Array();     
//=========================================================================        
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        //--------------------------------------
        txtStaffID.SetEnable(false);
        txtStaffName.SetEnable(false);
        txtSupplierID.SetEnable(false);
        txtSupplierName.SetEnable(false);
        txtShipToID.SetEnable(false);
        txtShipToName.SetEnable(false);
        txtPaidToID.SetEnable(false);
        txtPaidToName.SetEnable(false);
        txtCarrierID.SetEnable(false);
        txtCarrierName.SetEnable(false);
        txtNotifyID.SetEnable(false);
        txtNotifyName.SetEnable(false);
        //--------------------------------------
        OnChangeTab();
        OnToggleGrid();
        //--------------------------------------
        BindingDataList();
        //--------------------------------------
        OnAddNew('Master');               
    }
//=========================================================================        
 function BindingDataList()
 {   
      var data = "" ;
      
      data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
      lstCompany.SetDataText(data);
          
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0100') FROM DUAL")%>";  
      lstTrCCY.SetDataText(data);
      lstPayCCY.SetDataText(data);
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0250') FROM DUAL")%>"; 
      lstDeliMethod.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0230') FROM DUAL")%>"; 
      lstDomesticPort.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0240') FROM DUAL")%>"; 
      lstOverSeaPort.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0130') FROM DUAL")%>"; 
      lstPriceType.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0110') FROM DUAL")%>"; 
      lstPaymentMethod.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0120') FROM DUAL")%>"; 
      lstPaymentTerm.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0150') FROM DUAL")%>"; 
      lstDiscountRate.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IEIM0010') FROM DUAL")%>"; 
      lstReportType.SetDataText(data);    
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IEBS0010') FROM DUAL")%>"; 
      lstLCBank.SetDataText(data);
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IEBS0020') FROM DUAL")%>"; 
      lstCustomsPort.SetDataText(data);      

      data ="data|1|Inv Qty 1|2|Inv Qty 2"
      lstPriceBy.SetDataText(data);  
      lstPriceBy.value = 1;
                 
      var ctr = grdDetail.GetGridControl(); 
      ctr.ColFormat(G_INV_QTY_01) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_INV_QTY_02) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_UPRICE)     = "#,###,###,###,###,###.##";
      ctr.ColFormat(G_AMOUNT)     = "#,###,###,###,###,###.##";             
                                                 
      arr_FormatNumber[G_INV_QTY_01] = 2;
      arr_FormatNumber[G_INV_QTY_02] = 2;
      arr_FormatNumber[G_UPRICE]     = 2;
      arr_FormatNumber[G_AMOUNT]     = 2;                                                  
 }
     
//=========================================================================        
function OnSave(pos)
{
    switch (pos)
    {
        case 'Master':
            if ( ValidateData('Master') ) 
            {
                flag='save';                
                data_epim00030.Call();
            }
        break;        
        
        case 'Detail':        
            data_epim00030_1.Call();
        break;
        
        case 'Item_im':
            if(txtMasterPK.text=="")
            {
                alert("Please choose one invoice");
            }
            else
            {
                data_epim00030_item_im.Call();
            }
            
        break;
    }
}
//=========================================================================        
function OnAddNew(pos)
{
    switch(pos)
    {    
        case 'Master':
            data_epim00030.StatusInsert(); 
            
            txtStaffPK.text   = user_pk ; 
            txtStaffName.text = user_name ;           
      
            txtInvoiceNo.text = '<< New Invoice >>'; 
            
            grdDetail.ClearData();
            
            data_epim00030_2.Call('SELECT')
        break;
        
        case 'POItem':
            if ( txtSupplierPK.text == '' )            
            {
                alert('Pls select supplier first.');
                return;
            }
            //----------------------------------
            var fpath = System.RootURL + "/form/ep/im/epim00032.aspx?supplier_pk="+ txtSupplierPK.text ; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MST_PK, txtMasterPK.text );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_PO_D_PK,   data[5] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_REF_PO_NO, data[1] );

                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, grdDetail.rows-1 );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_ST_ITEM_PK, data[18] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    data[7] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  data[8] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  data[9] );                    
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_HS_CODE, data[4] );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY_01, System.Round(data[12],arr_FormatNumber[G_INV_QTY_01]));
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_01,     data[13] );                                        
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY_02, System.Round(data[16],arr_FormatNumber[G_INV_QTY_02]));
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_02,     data[17] ); 
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE, data[19] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_AMOUNT, System.Round(data[12],arr_FormatNumber[G_AMOUNT])* System.Round(data[21],arr_FormatNumber[G_AMOUNT]));                     
                }
             }                               
        break;    
        
        case 'FreeItem':
            var fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=|Y|Y|Y|Y|"; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MST_PK, txtMasterPK.text );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, grdDetail.rows-1 );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    data[0] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  data[1] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  data[2] );                    
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_HS_CODE, data[22] );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_01, data[5] );                                        
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_02, data[5] ); 
                }
             }                       
        break;     
        
        case 'FreeItem1':
            var fpath = System.RootURL + "/form/ep/im/epim00034.aspx?group_type=2"; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    
                    data = object[i];
                    
                    grdDetail2.AddRow();
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_MST_PK, txtMasterPK.text );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_SEQ, grdDetail2.rows-1 );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_ITEM_PK,    data[0] );
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_ITEM_CODE,  data[1] );
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_ITEM_NAME,  data[2] );                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_HS_CODE, data[4] );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_UOM_01, data[3] );                                        
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_UOM_02, data[3] ); 
                    
                }
             }                       
        break;     
        
          case 'POMaster':
            if ( txtSupplierPK.text == '' )            
            {
                alert('Pls select supplier first.');
                return;
            }
            //----------------------------------
            var fpath = System.RootURL + "/form/ep/im/epim00033.aspx?supplier_pk="+ txtSupplierPK.text ; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MST_PK, txtMasterPK.text );

                    grdDetail.SetGridText( grdDetail.rows-1, G_PO_D_PK,   data[1] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_REF_PO_NO, txtRefPONo.text );

                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, grdDetail.rows-1 );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_ST_ITEM_PK, data[6] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    data[6] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  data[7] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  data[8] );                    
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_HS_CODE, "" );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY_01, System.Round(data[9],arr_FormatNumber[G_INV_QTY_01]));
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_01,     data[10] );                                        
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY_02, System.Round(data[11],arr_FormatNumber[G_INV_QTY_02]));
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM_02,     data[12] ); 
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE, data[13] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_AMOUNT, System.Round(data[17],arr_FormatNumber[G_AMOUNT]));
                }
             }                               
        break;  
    }        
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G_AMOUNT));
    }

    txtTrAmount.text = sumAmount.toFixed(2)+"";
} 

//=========================================================================        

function CheckInput(pos)
{
    switch(pos)
    {
        case'1':
            var col, row
            col = event.col
            row = event.row  
            
            if ( col == G_INV_QTY_01 || col == G_INV_QTY_02 || col == G_UPRICE || col == G_AMOUNT  )
            {
                var dQuantiy ;
                
                dQuantiy =  grdDetail.GetGridData(row,col) ;
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdDetail.SetGridText( row, col, System.Round(dQuantiy,2));
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
                //------------------------
                if ( col == G_INV_QTY_01 || col == G_INV_QTY_02 || col == G_UPRICE )
                {
                    var dAmount;
                    
                    if ( lstPriceBy.value == '1' )
                    {             
                        dAmount = Number(grdDetail.GetGridData( row, G_INV_QTY_01 )) * Number(grdDetail.GetGridData( row, G_UPRICE )) ;
                    }
                    else
                    {
                        dAmount = Number(grdDetail.GetGridData( row, G_INV_QTY_02 )) * Number(grdDetail.GetGridData( row, G_UPRICE )) ;
                    }    
                     
                    grdDetail.SetGridText( row, G_AMOUNT, System.Round(dAmount,2));
                }
                //------------------------        
                TotalAmount();
            }
        break;
        
        case'2':
            var col, row
            col = event.col
            row = event.row  
            if(col==G2_INV_QTY_01 ||col==G2_UPRICE||col==G2_INV_QTY_02)
            {
                var dQuantiy ;
                dQuantiy =  grdDetail2.GetGridData(row,col) ;
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        var a= Number(grdDetail2.GetGridData(grdDetail2.row,G2_INV_QTY_01));
                        var b= Number(grdDetail2.GetGridData(grdDetail2.row,G2_UPRICE));
                        var c= a*b;
                        grdDetail2.SetGridText( grdDetail2.row, G2_AMOUNT,c);
                    }
                    else
                    {
                        alert(" Value must greater than zero !!");
                        grdDetail2.SetGridText( row, col, "");
                    }
                }
                else
                {
                    grdDetail2.SetGridText(row,col,"") ;
                } 
            }
            
        break;
    }   
    
}
   
//=========================================================================        
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case "data_epim00030" :
                if ( flag == 'save')
                {
                    for(var i=0; i < grdDetail.rows;i++)
                    {
                        if ( grdDetail.GetGridData( i, G_MST_PK) == '' )
                        {
                            grdDetail.SetGridText( i, G_MST_PK, txtMasterPK.text);
                        }    
                    }                
                    
                    OnSave('Detail');            
                }
                else
                {
                    //---------------------------- 
                    OnSearch('Detail');   
                }            
            break;
            
            case "data_epim00030_1" :
                if ( grdDetail.rows > 1 )
                {   
                    grdDetail.SetCellBold( 1, G_ITEM_CODE, grdDetail.rows - 1, G_ITEM_CODE, true);
                    grdDetail.SetCellBold( 1, G_REF_PO_NO, grdDetail.rows - 1, G_REF_PO_NO, true);
                    grdDetail.SetCellBold( 1, G_INV_QTY_01, grdDetail.rows - 1, G_INV_QTY_01, true); 
                    grdDetail.SetCellBold( 1, G_INV_QTY_02, grdDetail.rows - 1, G_INV_QTY_02, true);
                    
                    grdDetail.SetCellBold( 1, G_UPRICE, grdDetail.rows - 1, G_UPRICE, true);
                    grdDetail.SetCellBold( 1, G_AMOUNT, grdDetail.rows - 1, G_AMOUNT, true);
                }    
                if ( flag == 'save')
                {

                    OnSave('Item_im');
                    flag = '' ;
                }
                else
                {
                    OnSearch('Item_im');
                }                   
            break;
            
            case "data_fpab00220_2":
                 if ( txtLGGroupCodeID.text == 'LGCM0250')
                 {
                    lstDeliMethod.SetDataText(txtLGCodeList.text);  
                    lstDeliMethod.value = rtnLGCode;                      
                 }        
                 else if ( txtLGGroupCodeID.text == 'LGCM0230')
                 {
                    lstDomesticPort.SetDataText(txtLGCodeList.text);
                    lstDomesticPort.value = rtnLGCode;                      
                 }             
                 else if ( txtLGGroupCodeID.text == 'LGCM0240')
                 {
                    lstOverSeaPort.SetDataText(txtLGCodeList.text);  
                    lstOverSeaPort.value = rtnLGCode;                      
                 }
                 else if ( txtLGGroupCodeID.text == 'LGCM0130')
                 {
                    lstPriceType.SetDataText(txtLGCodeList.text);  
                    lstPriceType.value = rtnLGCode;                      
                 } 
                 else if ( txtLGGroupCodeID.text == 'LGCM0110')
                 {
                    lstPaymentMethod.SetDataText(txtLGCodeList.text);  
                    lstPaymentMethod.value = rtnLGCode;                      
                 }  
                 else if ( txtLGGroupCodeID.text == 'LGCM0120')
                 {
                    lstPaymentTerm.SetDataText(txtLGCodeList.text);  
                    lstPaymentTerm.value = rtnLGCode;                      
                 }  
                 else if ( txtLGGroupCodeID.text == 'LGCM0150')
                 {
                    lstDiscountRate.SetDataText(txtLGCodeList.text);  
                    lstDiscountRate.value = rtnLGCode;                      
                 }
                 else if ( txtLGGroupCodeID.text == 'IEBS0010')
                 {
                    lstLCBank.SetDataText(txtLGCodeList.text);  
                    lstLCBank.value = rtnLGCode;                      
                 } 
                 else if ( txtLGGroupCodeID.text == 'IEBS0020')
                 {
                    lstCustomsPort.SetDataText(txtLGCodeList.text);  
                    lstCustomsPort.value = rtnLGCode;                      
                 } 
                 else if ( txtLGGroupCodeID.text == 'IEIM0010')
                 {
                    lstReportType.SetDataText(txtLGCodeList.text);  
                    lstReportType.value = rtnLGCode;                      
                 }  
                 else if ( txtLGGroupCodeID.text == 'LGCM0100')
                 {
                    lstTrCCY.SetDataText(txtLGCodeList.text);
                    lstTrCCY.value = rtnLGCode;
                    lstPayCCY.SetDataText(txtLGCodeList.text);  
                    lstPayCCY.value = rtnLGCode;                      
                 }                                                                                                          
             break;   
             
             case 'pro_epim00030_1' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epim00030_2' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epim00030_3' :
                alert(txtReturnValue.text);
             break;  
             
             case 'pro_epim00030_copy':
                OnSearch('Master');
             break;     
             case'pro_epim00030_merce':
                OnSearch('Item_im');
             break;                                                                
        }    
    }
    
 
//=========================================================================        
function OnDelete(index)
{
    switch (index)
    {
        case 'Master':// delete master
            if ( txtMasterPK.text != '' )
            {
                if(confirm('Do you want to delete this Invoice?'))
                {
                    flag='delete';
                    data_epim00030.StatusDelete();
                    data_epim00030.Call();
                }   
            }
        break;

        case 'Detail':
            if ( grdDetail.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                {
                    if ( grdDetail.GetGridData( grdDetail.row, G_DETAIL_PK ) == '' )
                    {
                        grdDetail.RemoveRow();
                    }
                    else
                    {   
                        grdDetail.DeleteRow();
                    }    
                }
            }            
        break;
        
        case 'Item_im':
            if ( grdDetail2.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                {
                    if ( grdDetail2.GetGridData( grdDetail2.row, G2_DETAIL_PK ) == '' )
                    {
                        grdDetail2.RemoveRow();
                    }
                    else
                    {   
                        grdDetail2.DeleteRow();
                    }    
                }
            }            
        break;
    }
}
//=========================================================================        
function ValidateData(index)
{
    switch(index)
    {
        case 'Master' :
            if ( txtSupplierPK.text == '' )
            {
                alert("You must input Supplier !");
                return false;
            }
            return true;
        break;
    }
}
 
//===================================================================================   
function OnProcess(pos)
{
    switch (pos)
    {           
        case 'Confirm':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
                    
            if ( confirm('Do you want to confirm this Invoice ?') )
            {
                pro_epim00030_1.Call();                
            }        
        break;
        
        case 'Cancel':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
                    
            if ( confirm('Do you want to cancel this Invoice ?') )
            {
                pro_epim00030_2.Call();                
            }        
        break;     
        
        case 'Declaration' :
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
                    
            if ( confirm('Do you want to generate Declaration ?') )
            {
                pro_epim00030_3.Call();                
            }          
        break;   
        case 'MergeItem':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Saved Invoice.');
                return;
            }

            if ( confirm('Do you want to merge items ?') )
            {
                pro_epim00030_merce.Call();               
            }    
        break;
    }    
}    
//===================================================================================   
function OnPrint()
{
    switch(lstReportType.value)
    {
        case '10' :        
            var  url= System.RootURL + "/reports/ep/ex/rpt_epim00030_SH_EX_CI.aspx?pk=" + txtMasterPK.text;                
            System.OpenTargetPage( url, "_blank" );
        break;
        
        case '20' :        
            var  url= System.RootURL + "/reports/ep/ex/rpt_epim00030_SH_EX_PL.aspx?pk=" + txtMasterPK.text;                
            System.OpenTargetPage( url, "_blank" );
        break;        
    }    
}
  
//===================================================================================   
 function OnChangeTab()
 { 
    var strRad = radTab.GetData();
             
	switch (strRad)
	{
		case '1':
		    document.all("Tab_Invoice_Info").style.display     = "";
		    document.all("Tab_Shipment_Payment").style.display = "none";
		    document.all("Tab_License_BL").style.display       = "none";
 		    
		    document.all("Invoice_Info").style.color     = "red"; 
		    document.all("Shipment_Payment").style.color = "";
		    document.all("License_BL").style.color       = "";
         break;
        
        case '2':
		    document.all("Tab_Invoice_Info").style.display     = "none";
		    document.all("Tab_Shipment_Payment").style.display = "";
		    document.all("Tab_License_BL").style.display       = "none";
 		    
		    document.all("Invoice_Info").style.color     = ""; 
		    document.all("Shipment_Payment").style.color = "red";
		    document.all("License_BL").style.color       = "";
         break;	
        
        case '3':
		    document.all("Tab_Invoice_Info").style.display     = "none";
		    document.all("Tab_Shipment_Payment").style.display = "none";
		    document.all("Tab_License_BL").style.display       = "";
 		    
		    document.all("Invoice_Info").style.color     = ""; 
		    document.all("Shipment_Payment").style.color = "";
		    document.all("License_BL").style.color       = "red";
         break;  
        
     } 
 }
//===================================================================================
function OnSearch(pos)
{
    switch(pos)
    {
        case 'Invoice':
            var fpath = System.RootURL + "/form/ep/im/epim00031.aspx"; //search contract
            
            aValue = System.OpenModal( fpath , 1050 , 600, 'resizable:yes;status:yes');
            
            if ( aValue != null )
            {   
                txtMasterPK.SetDataText(aValue[0]); 
                
                OnSearch('Master');
            }            
        break;
        
        case 'Master':
            data_epim00030.Call("SELECT");
        break;
        
        case 'Detail':
            data_epim00030_1.Call("SELECT");
        break;
        
        case 'Item_im':
            data_epim00030_item_im.Call("SELECT");
        break;
    }
}    
//===================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text = obj[2];
                txtStaffID.text   = obj[1];
                txtStaffPK.text   = obj[0];
            }
        break;         

        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
	            txtSupplierID.text   = object[1];
                txtSupplierName.text = object[2]; 
                
                lstPaymentMethod.value = object[34];
                lstPaymentTerm.value   = object[35];             
	         }
        break;
        
        case 'ShipTo' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtShipToPK.text   = object[0];
	            txtShipToID.text   = object[1];
                txtShipToName.text = object[2];

                txtShipAdd.SetDataText(object[37]);          
	         }
        break;     
        
        case 'PaidTo' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPaidToPK.text   = object[0];
	            txtPaidToID.text   = object[1];
                txtPaidToName.text = object[2]; 
                
                txtPaidAdd.SetDataText(object[37]);             
	         }
        break;                  
        
        case 'Carrier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtCarrierPK.text   = object[0];
	            txtCarrierID.text   = object[1];
                txtCarrierName.text = object[2];
                
                txtCarrierDesc.SetDataText(object[37]);          
	         }
        break;  
        
        case 'Notify' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtNotifyPK.text   = object[0];
	            txtNotifyID.text   = object[1];
                txtNotifyName.text = object[2]; 
                
                txtNotifyDesc.SetDataText(object[37]);            
	         }
        break;                                        
        
        case 'DeliMethod':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0250";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0250';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDeliMethod.value = object[1];      
	            }    	                
	         }                
        break;   

        case 'DomesticPort':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0230";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0230';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDomesticPort.value = object[1];      
	            }    	                
	         }                
        break; 

        case 'OverSeaPort':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0240";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0240';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstOverSeaPort.value = object[1];      
	            }    	                
	         }                
        break; 

        case 'PriceType':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0130';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPriceType.value = object[1];      
	            }    	                
	         }                
        break;   
                                                                                 
        case 'PaymentMethod':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0110';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentMethod.value = object[1];      
	            }    	                
	         }                
        break;   
        
        case 'PaymentTerms':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0120";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0120';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentTerm.value = object[1];      
	            }    	                
	         }                              
        break;    

        case 'DiscountRate':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0150";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0150';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDiscountRate.value = object[1];      
	            }    	                
	         }                              
        break;    
        
        case 'TrCCY':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0100';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstTrCCY.value = object[1];      
	            }    	                
	         }                
        break;   
        
        case 'PayCCY':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0100';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPayCCY.value = object[1];      
	            }    	                
	         }                
        break;  
        
        case 'ReportType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEIM0010";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEIM0010';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstReportType.value = object[1];      
	            }    	                
	         }                
        break;          
        
        case 'LCBank':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0010";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEBS0010';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstLCBank.value = object[1];      
	            }    	                
	         }                
        break;  
        
        case 'CustomsPort':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0020";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEBS0020';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstCustomsPort.value = object[1];      
	            }    	                
	         }                
        break;                                                                                                                          
    }	       
}
 //===================================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G_SPEC01_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_ID) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_ID) = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G_SPEC01_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_ID) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_ID) = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
} 
 //===================================================================================
function OnChangePriceBy()
{
    var dAmount = 0 ;
    
    if ( lstPriceBy.value == '1' )
    { 
        for(var i=1 ; i<grdDetail.rows; i++)
        {
            dAmount = Number(grdDetail.GetGridData( i, G_INV_QTY_01 )) * Number(grdDetail.GetGridData( i, G_UPRICE )) ;
            grdDetail.SetGridText( i, G_AMOUNT, System.Round(dAmount,arr_FormatNumber[G_AMOUNT]));           
        }
    }
    else
    {
        for(var i=1 ; i<grdDetail.rows; i++)
        {
            dAmount = Number(grdDetail.GetGridData( i, G_INV_QTY_02 )) * Number(grdDetail.GetGridData( i, G_UPRICE )) ;
            grdDetail.SetGridText( i, G_AMOUNT, System.Round(dAmount,arr_FormatNumber[G_AMOUNT]));          
        }    
    }           
    //--------------
    TotalAmount();     
}
//---------------------------------------------------------------------------------------
function OnCopy()
{
    if(txtMasterPK.text=="")
    {
        alert("Select Invoice No to Copy");
    }
    else
    {
        pro_epim00030_copy.Call();
    }
    
}
 //===================================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="pro_epim00030_copy" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00030_copy" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epim00030_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36" function="<%=l_user%>lg_SEL_EPIM00030_2"> 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstCompany" />        
                     
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierID" />
                     <inout  bind="txtSupplierName" />                              
                                 
                     <inout  bind="lstTrCCY" />            
                     <inout  bind="lstPriceBy" />            
                     <inout  bind="txtTrExRate" />                                 
                     
                     <inout  bind="txtShipToPK" />            
                     <inout  bind="txtShipToID" />            
                     <inout  bind="txtShipToName" />               
                     <inout  bind="txtShipAdd" />   
                                          
                     <inout  bind="txtPaidToPK" />            
                     <inout  bind="txtPaidToID" />            
                     <inout  bind="txtPaidToName" />
                     <inout  bind="txtPaidAdd" />                     
                     
                     <inout  bind="lstDeliMethod" />                     
                     <inout  bind="lstDomesticPort" />       
                     <inout  bind="lstOverSeaPort" />                                    
                     <inout  bind="lstPriceType" />                                 
                                                 
                     <inout  bind="txtCarrierPK" />                     
                     <inout  bind="txtCarrierID" />       
                     <inout  bind="txtCarrierName" />                                    
                     <inout  bind="txtCarrierDesc" />                    
                     
                     <inout  bind="lstLCBank" />              
                     <inout  bind="lstPaymentMethod" />
                     <inout  bind="lstPayCCY" />
                     <inout  bind="lstPaymentTerm" />
                     
                     <inout  bind="txtNotifyPK" />              
                     <inout  bind="txtNotifyID" />
                     <inout  bind="txtNotifyName" />
                     <inout  bind="txtNotifyDesc" />                     
                     
                     <inout  bind="lstDiscountRate" /> 
                     
                    <inout  bind="txtGoodsDesc" />
                    <inout  bind="txtManufactureMarks" />
                    <inout  bind="txtLCMarks" />
                    <inout  bind="txtPackingMarks" />                                                   
                                                   
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epim00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77" function="<%=l_user%>lg_sel_epim00030"  procedure="<%=l_user%>lg_upd_epim00030"> 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstCompany" />   
                     <inout  bind="lbStatus" />
                     
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffID" />
                     <inout  bind="txtStaffName" />
                     
                     <inout  bind="txtInvoiceNo" />
                     <inout  bind="dtInvoiceDate" />
                     <inout  bind="txtArrayContractPK" />            
                     <inout  bind="txtContractNo" />
                     <inout  bind="txtArraySOPK" />
                     <inout  bind="txtRefPONo" />
                     <inout  bind="lstTrCCY" />
                      
                     <inout  bind="lbBookCCY01" />
                     <inout  bind="txtTrExRate" />
                     <inout  bind="txtTrAmount" />
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierID" />               
                     <inout  bind="txtSupplierName" /> 
                     <inout  bind="txtShipToPK" /> 
                     <inout  bind="txtShipToID" />
                     <inout  bind="txtShipToName" />
                     <inout  bind="txtShipAdd" /> 
                       
                     <inout  bind="txtPaidToPK" /> 
                     <inout  bind="txtPaidToID" />                 
                     <inout  bind="txtPaidToName" />
                     <inout  bind="txtPaidAdd" /> 
                     
                     <inout  bind="txtShipNo" />
                     <inout  bind="dtShipDate" />
                     
                     <inout  bind="txtCarrierPK" />  
                     <inout  bind="txtCarrierID" />                   
                     <inout  bind="txtCarrierName" />
                     <inout  bind="txtCarrierDesc" />               
                     <inout  bind="txtNotifyPK" />
                     <inout  bind="txtNotifyID" />
                     
                     <inout  bind="txtNotifyName" />
                     <inout  bind="txtNotifyDesc" />
                     <inout  bind="lstDeliMethod" />                     
                     <inout  bind="dtETDFrom" />
                     <inout  bind="dtETDTo" />
                     <inout  bind="dtETAFrom" />
                     <inout  bind="dtETATo" />
                     <inout  bind="lstDomesticPort" /> 
                     <inout  bind="lstOverSeaPort" />
                     <inout  bind="lstPriceType" />                     
                     <inout  bind="txtLCNo" />
                     <inout  bind="txtCaseName" />
                     <inout  bind="txtLCAmount" />
                     
                     <inout  bind="dtLCDate" />
                     <inout  bind="lstLCBank" />                                          
                     
                     <inout  bind="dtLCExpiryDate" />
                     
                     <inout  bind="dtAcceptDate" />
                     <inout  bind="dtLastDate" />
                     
                     <inout  bind="lstPaymentMethod" />
                     <inout  bind="lstPayCCY" />
                     <inout  bind="lbBookCCY02" />                     
                     <inout  bind="txtPayExRate" />                     
                     <inout  bind="lstPaymentTerm" />
                     <inout  bind="lstDiscountRate" />
                     <inout  bind="txtDiscAmount" />
                     <inout  bind="txtBankAccount" />
                     
                     <inout  bind="txtLicenseNo" />
                     <inout  bind="txtBLNo" />
                     <inout  bind="lstCustomsPort" />
                     <inout  bind="txtVessel" />
                     
                     <inout  bind="dtDeclareDate" />
                     <inout  bind="dtClearingDate" />
                     
                     <inout  bind="txtBLQty" />
                     
                     <inout  bind="txtTaxExRate" />
                     <inout  bind="txtCustomsExRate" />
                     <inout  bind="txtTotalDelare" />
                     <inout  bind="txtTotalAmount" />
                     
                     <inout  bind="txtGoodsDesc" />                                          
                     <inout  bind="txtManufactureMarks" />
                     
                     <inout  bind="txtLCMarks" />
                     <inout  bind="txtPackingMarks" />
                     
                     <inout  bind="lstPriceBy" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <gw:data id="data_epim00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function="<%=l_user%>lg_sel_epim00030_1"   procedure="<%=l_user%>lg_upd_epim00030_1"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00030_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00030_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00030_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00030_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00030_3" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_epim00030_merce" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epim00030_merce" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_epim00030_item_im" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="<%=l_user%>lg_sel_epim00030_item_im"   procedure="<%=l_user%>lg_upd_epim00030_item_im"> 
                <input bind="grdDetail2">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td style="width: 30%; white-space: nowrap" align="center" colspan="10">
                <table style="width: 100%; height: 100%; background-color: CCFFFF">
                    <tr>
                        <td style="width: 96%" align="left">
                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                <span value="1" id="Invoice_Info">Invoice Info</span> 
                                <span value="2" id="Shipment_Payment">Shipment Payment</span>
                                <span value="3" id="License_BL">License B/L</span> 
                            </gw:radio>
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnConfirm" img="2" text="Confirm" onclick="OnProcess('Confirm')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="btnGenDeclaration" img="2" text="Declaration" onclick="OnProcess('Declaration')" />
                        </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                            <a title="ReportType" onclick="OnPopUp('ReportType')" href="#tips" style="color: #0000ff">
                                Report Type</a></td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                            <gw:list id="lstReportType" styles='width:150;' csstype="mandatory" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExcel" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Company
            </td>
            <td style="width: 25%">
                <gw:list id="lstCompany" styles="width:100%;"></gw:list>
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                <a onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">Charger</a>
            </td>
            <td style="width: 40%; white-space: nowrap">
                <gw:textbox id="txtStaffID" styles="width:30%" />
                <gw:textbox id="txtStaffName" styles="width:70%" />
                <gw:textbox id="txtStaffPK" styles="display:none" />
            </td>
            <td style="width: 20%" align="center">
                <gw:label id="lbStatus" text="-" styles='width:100%;color:red; font-weight:700;'
                    csstype="mandatory" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Invoice')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="OnCopy()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="15">
                <table id="Tab_Invoice_Info" style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 50%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%; background-color: CCFFFF">
                                    <tr style="height: 1%">
                                        <td style="width: 5%; white-space: nowrap">
                                            <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Supplier</a></td>
                                        <td style="width: 95%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtSupplierPK" text="" styles='display:none' />
                                            <gw:textbox id="txtSupplierID" text="" styles='width:30%;' csstype="mandatory" />
                                            <gw:textbox id="txtSupplierName" text="" styles='width:70%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="width: 5%; white-space: nowrap">
                                            Invoice No</td>
                                        <td style="width: 45%">
                                            <gw:textbox id="txtInvoiceNo" text="" styles='width:100%;' csstype="mandatory" onenterkey="dat_epei00030_3.Call('SELECT');" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Contract No</td>
                                        <td style="width: 45%">
                                            <gw:textbox id="txtContractNo" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="width: 5%; white-space: nowrap">
                                            Date</td>
                                        <td style="width: 45%">
                                            <gw:datebox id="dtInvoiceDate" lang="1" onchange="" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            P/O No</td>
                                        <td style="width: 45%">
                                            <gw:textbox id="txtRefPONo" text="" styles='width:100%;' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td style="width: 50%">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            <a title="Trans. Currency" onclick="OnPopUp('TrCCY')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Tr CCY</b></a></td>
                                        <td style="width: 25%">
                                            <gw:list id="lstTrCCY" styles="width:100%;" onchange=""></gw:list>
                                        </td>
                                        <td style="width: 20%">
                                            <gw:label id="lbBookCCY01" text="" styles='width:100%;' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Tr Amount
                                        </td>
                                        <td style="width: 45%">
                                            <gw:textbox id="txtTrAmount" type="number" format="#,###,###,###,###.##R" text=""
                                                styles='width:100%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Ex. Rate
                                        </td>
                                        <td style="width: 45%" colspan="2">
                                            <gw:textbox id="txtTrExRate" text="1" type="number" format="#,###,###,###,###.##R"
                                                styles='width:100%;' />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            BK Amount
                                        </td>
                                        <td style="width: 45%">
                                            <gw:textbox id="txtBKAmount" type="number" format="#,###,###,###,###.##R" text=""
                                                styles='width:100%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="width: 5%; white-space: nowrap">
                                            Price by
                                        </td>
                                        <td style="width: 45%" colspan="2">
                                            <gw:list id="lstPriceBy" styles='width:100%;' onchange="OnChangePriceBy()" />
                                        </td>
                                        <td style="width: 5%">
                                        </td>
                                        <td style="width: 45%">
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="2">
                            <gw:tab id="idTab" style="width: 100%; height: 100%; border6px">
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="2" id="Item"
                                    name="Item">
                                    <tr>
                                        <td colspan="2">
                                            <table style="width: 100%; height: 100%">
                                                <tr>
                                                    <td style="width: 95%" align="left">
                                                        <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                                            style="cursor: hand" onclick="OnToggleGrid()" />
                                                    </td>
                                                    <td style="width: 1%">
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn id="btnFreeItem" img="popup" alt="Free Item" text="Free Item" onclick="OnAddNew('FreeItem')" />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn id="btnPOItem" img="popup" alt="P/O Item" text="P/O Item" onclick="OnAddNew('POItem')" />
                                                    </td>
                                                    <td style="width: 3%">
                                                        <gw:icon id="btnPOMaster" img="2" text="P/O Master" onclick="OnAddNew('POMaster')" />
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn id="btnDel2" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 99%">
                                        <td colspan="2">
                                            <gw:grid id='grdDetail' header='_PK|_MST_PK|Seq|P/O No|_ST_ITEM_PK|_ITEM_PK|Item Code|Item Name|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|HS Code|Inv Qty|UOM|Qty 02|UOM|U/Price|Inv Amount|_SO_D_PK|Remark'
                                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|1|0|0|0|0|0|1|0|1|0|1|0|1|0|1|0|3|1|3|1|3|3|0|0'
                                                check='||||||||||||||||||||||||||' editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0|1|1|1|1'
                                                widths='0|0|800|1500|0|0|2000|2500|0|1500|0|1500|0|1500|0|1500|0|1500|1000|1200|1000|1200|1000|1200|1200|1200|1000'
                                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput('1')" />
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="2" id="Item_im" name="Item_IM">
                                    <tr style="height: 1%">
                                        <td colspan="2">
                                            <table style="width: 100%; height: 100%">
                                                <tr>
                                                    <td style="width: 99%" align="right">
                                                        <gw:imgbtn id="btnFreeItem1" img="popup" alt="Free Item" text="Free Item" onclick="OnAddNew('FreeItem1')"/>
                                                    </td>
                                                    <td style="width: 1%">
                                                        <gw:imgbtn id="btnDel3" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Item_im')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn id="btnSave2" img="save" alt="Save" text="Save" onclick="OnSave('Item_im')" />
                                                    </td>
                                                    <td style="width: 1%" align="right">
                                                        <gw:imgbtn id="btnMergeItem" img="process" alt="Merge Items" text="" onclick="OnProcess('MergeItem')" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height: 98%">
                                        <td colspan="2">
                                            <gw:grid id='grdDetail2' header='_PK|_MST_PK|Seq|P/O No|_ST_ITEM_PK|_ITEM_PK|Item Code|Item Name|HS Code|Inv Qty|UOM|Qty 02|UOM|U/Price|Inv Amount|_SO_D_PK|Remark'
                                                format='0|0|0|0|0|0|0|0|0|-0|0|-0|0|-2|-2|0|0' aligns='0|0|1|1|0|0|0|0|0|3|1|3|1|3|3|0|0'
                                                check='||||||||||||||||' editcol='0|0|1|0|0|0|0|0|0|1|0|1|0|1|1|1|1'
                                                widths='0|0|800|1500|0|0|2000|2500|1000|1200|1000|1200|1000|1200|1200|1200|1000'
                                                sorting='T' styles='width:100%; height:100%'onafteredit="CheckInput('2')"/>
                                        </td>
                                    </tr>
                                </table>
                            </gw:tab>
                        </td>
                    </tr>
                </table>
                <table id="Tab_Shipment_Payment" style="width: 100%; height: 100%">
                    <tr valign="top">
                        <td style="width: 48%">
                            <fieldset style="padding: 5">
                                <legend>&nbsp;&nbsp;&nbsp;Shipment Information&nbsp;&nbsp;&nbsp;</legend>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 10%; white-space: nowrap">
                                            <a title="Ship To" onclick="OnPopUp('ShipTo')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Ship To</a></td>
                                        <td style="width: 80%; white-space: nowrap">
                                            <gw:textbox id="txtShipToPK" styles="display:none" />
                                            <gw:textbox id="txtShipToID" csstype="mandatory" styles="width:30%;" />
                                            <gw:textbox id="txtShipToName" csstype="mandatory" styles="width:70%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <gw:textarea id="txtShipAdd" csstype="mandatory" rows="4" styles="width:100%;" onenterkey="alert('1')" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a title="Deli Method" onclick="OnPopUp('DeliMethod')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Deli Method</b></a></td>
                                        <td>
                                            <gw:list id="lstDeliMethod" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            ETD</td>
                                        <td style="white-space: nowrap">
                                            <gw:datebox id="dtETDFrom" lang="1" onchange="" styles="width:100%;" nullaccept="T" />
                                            ~
                                            <gw:datebox id="dtETDTo" lang="1" onchange="" styles="width:100%;" nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            ETA</td>
                                        <td style="white-space: nowrap">
                                            <gw:datebox id="dtETAFrom" lang="1" onchange="" styles="width:100%;" nullaccept="T" />
                                            ~
                                            <gw:datebox id="dtETATo" lang="1" onchange="" styles="width:100%;" nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Domestic Port" onclick="OnPopUp('DomesticPort')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Domestic Port</b></a></td>
                                        <td>
                                            <gw:list id="lstDomesticPort" csstype="mandatory" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Oversea Port" onclick="OnPopUp('OverSeaPort')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Oversea Port</b></a></td>
                                        <td>
                                            <gw:list id="lstOverSeaPort" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Price Type" onclick="OnPopUp('PriceType')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Price Type</b></a></td>
                                        <td>
                                            <gw:list id="lstPriceType" styles="width:100%;"></gw:list>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table style="width: 100%; height: 100%">
                                                <tr>
                                                    <td style="width: 10%; white-space: nowrap">
                                                        Ship No
                                                    </td>
                                                    <td style="width: 40%; white-space: nowrap">
                                                        <gw:textbox id="txtShipNo" styles="width:100%;" />
                                                    </td>
                                                    <td style="width: 10%; white-space: nowrap">
                                                        Ship Date
                                                    </td>
                                                    <td style="width: 40%; white-space: nowrap">
                                                        <gw:datebox id="dtShipDate" lang="1" styles='width:100%;' nullaccept="T" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 10%">
                                                        <a title="Carrier" onclick="OnPopUp('Carrier')" href="#tips" style="text-decoration: none;
                                                            color=#0000ff"><b>Carrier</b></a></td>
                                                    <td style="width: 90%; white-space: nowrap" colspan="3">
                                                        <gw:textbox id="txtCarrierPK" styles="width:30%;display:none" />
                                                        <gw:textbox id="txtCarrierID" styles="width:30%;" />
                                                        <gw:textbox id="txtCarrierName" styles="width:70%;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td colspan="3">
                                                        <gw:textarea id="txtCarrierDesc" rows="4" styles="width:100%;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 48%">
                            <fieldset style="padding: 5">
                                <legend>&nbsp;&nbsp;&nbsp;Payment Information&nbsp;&nbsp;&nbsp;</legend>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 10%">
                                            <a title="Paid To" onclick="OnPopUp('PaidTo')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Paid To</a>
                                        </td>
                                        <td colspan="3" style="white-space: nowrap">
                                            <gw:textbox id="txtPaidToPK" styles="display:none" />
                                            <gw:textbox id="txtPaidToID" csstype="mandatory" styles="width:30%;" />
                                            <gw:textbox id="txtPaidToName" csstype="mandatory" styles="width:70%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="3">
                                            <gw:textarea id="txtPaidAdd" csstype="mandatory" rows="4" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 10%">
                                            L/C No.</td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtLCNo" styles="width:100%;" />
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            Case Name
                                        </td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtCaseName" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 10%">
                                            <a title="Payment Method" onclick="OnPopUp('LCBank')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Issue Bank</b></a>
                                        </td>
                                        <td style="width: 40%">
                                            <gw:list id="lstLCBank" styles="width:100%;"></gw:list>
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            LC Amount
                                        </td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtLCAmount" type="number" format="#,###,###,###,###.##R" text=""
                                                styles='width:100%;' csstype="mandatory" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 10%; white-space: nowrap">
                                            L/C Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtLCDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            L/C Expiry Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtLCExpiryDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: CCFFFF">
                                        <td style="width: 10%; white-space: nowrap">
                                            Accept Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtAcceptDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            Last Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtLastDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; white-space: nowrap">
                                            <a title="Payment Method" onclick="OnPopUp('PaymentMethod')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Payment Method</b></a></td>
                                        <td style="width: 40%">
                                            <gw:list id="lstPaymentMethod" styles="width:100%;"></gw:list>
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            Bank Account</td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtBankAccount" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; white-space: nowrap">
                                            <a title="Payment Currency" onclick="OnPopUp('PayCCY')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Payment CCY</b></a></td>
                                        <td style="width: 40%; white-space: nowrap">
                                            <gw:list id="lstPayCCY" styles="width:100%;" onchange="getExRateS();"></gw:list>
                                        </td>
                                        <td style="width: 10%">
                                            <gw:label id="lbBookCCY02" styles="width:30%;" text="/USD" />
                                        </td>
                                        <td style="width: 40%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%">
                                            <a title="Payment Term" onclick="OnPopUp('PaymentTerms')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Payment Term</b></a></td>
                                        <td>
                                            <gw:list id="lstPaymentTerm" styles="width:100%;"></gw:list>
                                        </td>
                                        <td style="width: 10%">
                                            Ex. Rate</td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtPayExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%; white-space: nowrap">
                                            <a title="Discount Rate" onclick="OnPopUp('DiscountRate')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Discount Rate</b></a></td>
                                        <td style="width: 40%">
                                            <gw:list id="lstDiscountRate" onchange="onDiscountChange();" styles="width:100%;" />
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            Disc. Amount</td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtDiscAmount" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <table style="width: 100%; height: 100%">
                                                <tr>
                                                    <td style="width: 10%">
                                                        <a title="Notify" onclick="OnPopUp('Notify')" href="#tips" style="text-decoration: none;
                                                            color=#0000ff"><b>Notify</b></a></td>
                                                    <td style="width: 90%; white-space: nowrap">
                                                        <gw:textbox id="txtNotifyPK" styles="display:none" />
                                                        <gw:textbox id="txtNotifyID" styles="width:30%;" />
                                                        <gw:textbox id="txtNotifyName" styles="width:70%;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td colspan="3">
                                                        <gw:textarea id="txtNotifyDesc" rows="4" styles="width:100%;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table id="Tab_License_BL" style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td colspan="2">
                            <fieldset style="padding: 5">
                                <table style="width: 100%; height: 100%; background-color: CCFFFF">
                                    <tr style="height: 1%">
                                        <td style="width: 5%; white-space: nowrap">
                                            Im-License No
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtLicenseNo" styles="width:100%;" csstype="mandatory" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            <a title="Payment Method" onclick="OnPopUp('CustomsPort')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Customs Port</b></a>
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:list id="lstCustomsPort" styles="width:100%;" onchange=""></gw:list>
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Declare Date
                                        </td>
                                        <td style="width: 25%; white-space: nowrap">
                                            <gw:datebox id="dtDeclareDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr style="height: 1%">
                                        <td style="width: 5%; white-space: nowrap">
                                            B/L No
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtBLNo" styles="width:100%;" csstype="mandatory" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Vessel
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtVessel" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Clearing Date
                                        </td>
                                        <td style="width: 25%; white-space: nowrap">
                                            <gw:datebox id="dtClearingDate" lang="1" styles='width:100%;' nullaccept="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            B/L Qty
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtBLQty" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                        </td>
                                        <td style="width: 25%; white-space: nowrap">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Tax Ex. Rate
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtTaxExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Customs Ex. Rate
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtCustomsExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                        </td>
                                        <td style="width: 25%; white-space: nowrap">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 5%; white-space: nowrap">
                                            Total Declared
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtTotalDelare" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                            Total Amount
                                        </td>
                                        <td style="width: 30%; white-space: nowrap">
                                            <gw:textbox id="txtTotalAmount" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                        </td>
                                        <td style="width: 5%; white-space: nowrap">
                                        </td>
                                        <td style="width: 25%; white-space: nowrap">
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; white-space: nowrap">
                            Goods Remark</td>
                        <td style="width: 90%; white-space: nowrap" colspan="5">
                            <gw:textarea id="txtGoodsDesc" styles="width:100%;" rows="4" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; white-space: nowrap">
                            Producing</td>
                        <td colspan="5">
                            <gw:textarea id="txtManufactureMarks" styles="width:100%;" rows="4" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; white-space: nowrap">
                            LC Marks</td>
                        <td colspan="5">
                            <gw:textarea id="txtLCMarks" styles="width:100%;" rows="4" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; white-space: nowrap">
                            Packing Marks</td>
                        <td colspan="5">
                            <gw:textarea id="txtPackingMarks" styles="width:100%;" rows="4" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------>
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" text="" styles='display:none' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtArrayContractPK" styles='display:none;width:100%' />
<gw:textbox id="txtArraySOPK" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------->
</html>
