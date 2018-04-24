<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Import Declaration Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">

var user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var user_name  = "<%=Session("USER_NAME")%>" ;

var flag;

var G0_PK                      =   0,
    G0_RECEP_NO                =   1,
    G0_RECEP_YMD               =   2,
    G0_DECL_NO                 =   3,
    G0_REG_YMD                 =   4,
    G0_DECL_FORM               =   5,
    G0_BOL                     =   6,
    G0_CONTRACT_NO             =   7,
    G0_DECL_STATUS             =   8,
    G0_RAMIFICATION_CONTENT    =   9,
    G0_DECL_PROFILE_NO         =   10,
    G0_COM_INV_NO              =   11,
    G0_COM_INV_YMD             =   12,
    G0_LICENSE_NO              =   13,
    G0_LICENSE_YMD             =   14,
    G0_KDT_REFERENCES          =   15;

    var G1_DHANGMDDKID     =      0,
        G1_STTHANG     =      1,
        G1_MA_NPL_SP     =      2,
        G1_TEN_HANG     =      3,
        G1_MA_HANGKB     =      4,
        G1_NUOC_XX     =      5,
        G1_MA_TINH_TRANG     =      6,
        G1_LUONG     =      7,
        G1_MA_DVT     =      8,
        G1_DGIA_KB     =      9,
        G1_TRIGIA_KB     =      10,
        G1_TGKB_VND     =      11,
        G1_TS_XNK_MA_BT     =      12,
        G1_TS_XNK_TD     =      13,
        G1_TS_XNK     =      14,
        G1_THUE_XNK     =      15,
        G1_TS_TTDB_MA_BTTS_TTDB     =      16,
        G1_TS_TTDB_TD     =      17,
        G1_THUE_TTDB     =      18,
        G1_TS_VAT_MA_BT     =      19,
        G1_TS_VAT     =      20,
        G1_THUE_VAT     =      21,
        G1_TS_MT_MA_BT     =      22,
        G1_TS_MT     =      23,
        G1_TS_MT_TD     =      24,
        G1_THUE_MT     =      25,
        G1_TYLE_THUKHAC     =      26,
        G1_TRIGIA_THUKHAC     =      27,
        G1_CHE_DO_UU_DAI     =      28,
        G1_IS_HANG_DONG_BO     =      29,
        G1_MIENTHUE     =      30,
        G1_MIENTHUE_SOVB     =      31,
        G1_MIENTHUE_TS     =      32,
        G1_MIENTHUE_TS_GIAM     =      33,
        G1_MAHANGSX     =      34,
        G1_TENHANGSX     =      35,
        G1_MAHSMORONG     =      36,
        G1_NHANHIEU     =      37,
        G1_QUYCACH_PC     =      38,
        G1_MA_HTS     =      39,
        G1_MA_DVT_HTS     =      40,
        G1_LUONG_HTS     =      41,
        G1_DONGIA_HTS     =      42;	   
    
var arr_FormatNumber = new Array();    
//================================================================================	    
function BodyInit()
 {       
    System.Translate(document);  // Translate to language session
    //--------------------------------------
    
   
    txtDeclSeq.SetEnable(false);
    
    txtExporterID.SetEnable(false);
    txtExporterName.SetEnable(false);
    txtImporterID.SetEnable(false);
    txtImporterName.SetEnable(false);
    txtConsignorID.SetEnable(false);
    txtConsignorName.SetEnable(false);
    txtForwarderID.SetEnable(false);
    txtForwarderName.SetEnable(false);
    
    txtDeclType.SetEnable(false);
    txtExCountry.SetEnable(false);
//    txtImportGate.SetEnable(false);
//    txtExportGate.SetEnable(false);
    //--------------------------------------
    chkBL_T3.SetEnable(false);
    chkDonXinCCK_T3.SetEnable(false);
    chkCO_T3.SetEnable(false);
    chkChungtuno_T3.SetEnable(false);
    chkGP_T3.SetEnable(false);
    chkGiapKTCL_T3.SetEnable(false);
    chkHD_T3.SetEnable(false);
    chkGiapDKKTCL_T3.SetEnable(false);
    chkHDTM_T3.SetEnable(false);
    chkCTGD_T3.SetEnable(false);
    chkCTDK_T3.SetEnable(false);
    chkCTBS_T3.SetEnable(false);
    radTab.SetEnable(false);
    chk_chukydientu.SetEnable(false);
    
    //--------------------------------------
    
    txtHCom_Pk.text = "<%=Session("COMPANY_PK")%>";
    
    //--------------------------------------
    BindingDataList(); 
    //data_epim00050_Get_Cus.Call('SELECT');
    //--------------------------------------    
    txt_PopType.text = "<%=Request.querystring("pop_type")%>";
    txtMasterPK.text = "<%=Request.querystring("decl_id")%>";
   if(txtMasterPK.text != '')
   {
        data_epim00050.Call('SELECT');
   }
   else
   {
        OnAddNew('Master');
        tab_content.HideTab(4);
        var m=document.all("tbl_ProcsessResult");
			m.style.display="none";  
	}
 }
//================================================================================	
    
 function BindingDataList()
 {   
      var data = "" ;

      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IEEX0030') FROM DUAL")%>";  
      lstDeclType.SetDataText(data);  
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0250') FROM DUAL")%>"; 
      lstDeliMethod.SetDataText(data); 
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IEBS0080') FROM DUAL")%>"; 
      lstPaymentMethod.SetDataText(data);  
      lstPaymentMethod.value = '';
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('IECU0201') FROM DUAL")%>"; 
      lstDeliCondi.SetDataText(data);  
      lstDeliCondi.value = '';  
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT LG_f_logistic_code('LGCM0220') FROM DUAL")%>"; 
      lstExCountry.SetDataText(data); 
      
      var ctr = grdDeclItems.GetGridControl(); 
      ctr.ColFormat(G1_STTHANG)             = "#,###,###,###,###,###";
      ctr.ColFormat(G1_LUONG)             = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_DGIA_KB)             = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_TRIGIA_KB)          = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_TGKB_VND)     = "#,###,###,###,###,###.##";
            
      ctr.ColFormat(G1_TS_XNK_TD)         = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_TS_XNK)     = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_THUE_XNK)     = "#,###,###,###,###,###.##";
      
      ctr.ColFormat(G1_TS_TTDB_TD)  = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_THUE_TTDB)    = "#,###,###,###,###,###.##";      
      ctr.ColFormat(G1_TS_VAT_MA_BT) = "#,###,###,###,###,###.##";
      ctr.ColFormat(G1_TS_VAT)     = "#,###,###,###,###,###.##"; 
      
      ctr.ColFormat(G1_THUE_VAT)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_TS_MT_MA_BT)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_TS_MT)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_TS_MT_TD)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_THUE_MT)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_TYLE_THUKHAC)  = "#,###,###,###,###,###.##"; 
      
      ctr.ColFormat(G1_MIENTHUE_TS)  = "#,###,###,###,###,###.##"; 
      ctr.ColFormat(G1_MIENTHUE_TS_GIAM)  = "#,###,###,###,###,###.##"; 
      
      arr_FormatNumber[G1_STTHANG]                = 0;
      arr_FormatNumber[G1_LUONG]                = 2;
      arr_FormatNumber[G1_DGIA_KB]                = 2;
      arr_FormatNumber[G1_TRIGIA_KB]             = 2;
      arr_FormatNumber[G1_TGKB_VND]        = 2;
      
      arr_FormatNumber[G1_TS_XNK_TD]            = 2;
      arr_FormatNumber[G1_TS_XNK]        = 2;
      arr_FormatNumber[G1_THUE_XNK]        = 2;
      
      arr_FormatNumber[G1_TS_TTDB_TD]     = 2;
      arr_FormatNumber[G1_THUE_TTDB]       = 2;
      arr_FormatNumber[G1_TS_VAT_MA_BT]    = 2;
      arr_FormatNumber[G1_TS_VAT]        = 2;
      
      arr_FormatNumber[G1_THUE_VAT]     = 2;
      arr_FormatNumber[G1_TS_MT_MA_BT]     = 2;
      arr_FormatNumber[G1_TS_MT]     = 2;
      arr_FormatNumber[G1_TS_MT_TD]     = 2;
      arr_FormatNumber[G1_THUE_MT]     = 2;
      arr_FormatNumber[G1_TYLE_THUKHAC]     = 2;
      
      arr_FormatNumber[G1_MIENTHUE_TS]     = 2;
      arr_FormatNumber[G1_MIENTHUE_TS_GIAM]     = 2;
      
 }
 

//===================================================================================
    
function CheckInput()
{   
    var col, row
    
    col = event.col;
    row = event.row ; 
    
    if ( col == G_QTY_01 || col == G_QTY_02 || col == G_UPRICE || col == G_TR_AMOUNT || 
         col == G_FREIGHT_AMOUNT || col == G_THC_AMOUNT || col == G_CAL_TAX_AMOUNT || 
         
         col == G_IMP_TAX_AMOUNT || col == G_AF_IMP_TAX_AMOUNT || 
         col == G_CONS_TAX_AMOUNT || col == G_AF_CONS_TAX_AMOUNT ||
         col == G_VAT_TAX_AMOUNT || col == G_AF_VAT_TAX_AMOUNT  )
    {
        var dQuantiy, dAmount;
        
        dQuantiy =  grdDeclItems.GetGridData(row,col) ;

        if (Number(dQuantiy) >0)
        {   
            grdDeclItems.SetGridText( row, col, System.Round(grdDeclItems.GetGridData(row, col), arr_FormatNumber[col])); 
        }
        else
        {
            grdDeclItems.SetGridText( row, col, "");
        }
        
        if ( col == G_QTY_01 || col == G_QTY_02 || col == G_UPRICE )
        {
            //-----------------------------------
            if ( lstPriceBy.value == '1' )
            {             
                dAmount = Number(grdDeclItems.GetGridData( row, G_QTY_01 )) * Number(grdDeclItems.GetGridData( row, G_UPRICE )) ;
            }
            else
            {
                dAmount = Number(grdDeclItems.GetGridData( row, G_QTY_02 )) * Number(grdDeclItems.GetGridData( row, G_UPRICE )) ;
            }    
             
            grdDeclItems.SetGridText( row, G_TR_AMOUNT, System.Round(dAmount,G_TR_AMOUNT)) ;        
        }
    }
    
    //------------------------        
    //---------CALCULATE AMOUNT---------------- 
    var TrAmount = 0 ;

    for ( i=1; i<grdDeclItems.rows; i++ )
    {
        TrAmount = TrAmount + Number(grdDeclItems.GetGridData( i, G_TR_AMOUNT));
    }

    txtTransAmount.text = TrAmount.toFixed(2)+"";
}
 
//====================================================
function CalculateTax()
{
    SetFreightFee();
    SetTHCFee();
        
    var dAmount = 0, pTax = 0;
    
    for ( var row = 1; row < grdDeclItems.rows ; row++ )
    {        
        dAmount = Number(grdDeclItems.GetGridData( row, G_TR_AMOUNT ));
        dAmount = dAmount + Number(grdDeclItems.GetGridData( row, G_FREIGHT_AMOUNT )) + Number(grdDeclItems.GetGridData( row, G_THC_AMOUNT )) ;
        dAmount = dAmount * Number(txtExRate.text);
        
        grdDeclItems.SetGridText( row, G_CAL_TAX_AMOUNT, System.Round( dAmount, arr_FormatNumber[G_CAL_TAX_AMOUNT] ) ) ;
        //-----------------------------------  
        dAmount = Number(grdDeclItems.GetGridData( row, G_CAL_TAX_AMOUNT ));
        pTax = parseFloat((dAmount * Number(grdDeclItems.GetGridData( row, G_IMP_TAX_RATIO )) / 100)+"").toFixed(2);        
        grdDeclItems.SetGridText( row, G_IMP_TAX_AMOUNT, pTax ) ;
        
        dAmount = Number(dAmount) + Number(pTax) ;   
        grdDeclItems.SetGridText( row, G_AF_IMP_TAX_AMOUNT, System.Round(dAmount,G_AF_IMP_TAX_AMOUNT)) ;  
        //----------------------------------- 
        dAmount = Number(grdDeclItems.GetGridData( row, G_AF_IMP_TAX_AMOUNT ));
        pTax = parseFloat((dAmount * Number(grdDeclItems.GetGridData( row, G_CONS_TAX_RATIO )) / 100)+"").toFixed(2);        
        grdDeclItems.SetGridText( row, G_CONS_TAX_AMOUNT, pTax ) ;
        
        dAmount = Number(dAmount) + Number(pTax) ;   
        grdDeclItems.SetGridText( row, G_AF_CONS_TAX_AMOUNT, System.Round(dAmount,G_AF_CONS_TAX_AMOUNT)) ;   
        //----------------------------------- 
        dAmount = Number(grdDeclItems.GetGridData( row, G_AF_CONS_TAX_AMOUNT ));
        pTax = parseFloat((dAmount * Number(grdDeclItems.GetGridData( row, G_VAT_TAX_RATIO )) / 100)+"").toFixed(2);        
        grdDeclItems.SetGridText( row, G_VAT_TAX_AMOUNT, pTax ) ;
        
        dAmount = Number(dAmount) + Number(pTax) ;   
        grdDeclItems.SetGridText( row, G_AF_VAT_TAX_AMOUNT, System.Round(dAmount,G_AF_VAT_TAX_AMOUNT)) ; 
        //-----------------------------------              
    } 
    
    //------------------------        
    TotalAmount();   
} 
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var TrAmount = 0 , ImpAmount = 0 , ImportTaxAmount = 0 , VATAmount = 0 , ConsTaxAmount = 0 ;

    for ( i=1; i<grdDeclItems.rows; i++ )
    {
        TrAmount        = TrAmount        + Number(grdDeclItems.GetGridData( i, G_TR_AMOUNT));
        ImpAmount       = ImpAmount       + Number(grdDeclItems.GetGridData( i, G_CAL_TAX_AMOUNT));
        ImportTaxAmount = ImportTaxAmount + Number(grdDeclItems.GetGridData( i, G_IMP_TAX_AMOUNT));
        VATAmount       = VATAmount       + Number(grdDeclItems.GetGridData( i, G_VAT_TAX_AMOUNT));
        ConsTaxAmount   = ConsTaxAmount   + Number(grdDeclItems.GetGridData( i, G_CONS_TAX_AMOUNT));
    }

    txtTransAmount.text = TrAmount.toFixed(2)+"";
    txtImpAmount.text   = ImpAmount.toFixed(2)+"";
    txtImportTax.text   = ImportTaxAmount.toFixed(2)+"";
    txtVATTax.text      = VATAmount.toFixed(2)+"";
    txtConsTax.text     = ConsTaxAmount.toFixed(2)+"";
    
    txtTotalTax.text = ( ImportTaxAmount + VATAmount + ConsTaxAmount ).toFixed(2)+"" ;
             
} 
 
//===================================================================================
function OnSearch(obj)
{
    switch(obj.id)
    {
        case 'DECL_LIST':
            data_epim00050_decllist.Call("SELECT");
        break;
        case 'Decla':
            var fpath = System.RootURL + "/form/ep/im/epim00051.aspx"; //search contract
            
            aValue = System.OpenModal( fpath , 1050 , 600, 'resizable:yes;status:yes');
            
            if ( aValue != null )
            {   
                txtMasterPK.SetDataText(aValue[0]); 
                
                OnSearch('Master');
            }            
        break;
        
        case 'DECL':
            //data_epim00050.Call("SELECT");
        break;
        
        case 'btn_Search_T2':
            data_epim00050_1.Call("SELECT");
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
                //txtStaffName.text = obj[2];
                //txtStaffID.text   = obj[1];
                //txtStaffPK.text   = obj[0];
            }
        break;         

        case 'Exporter' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtExporterPK.text   = object[0];
	            txtExporterID.text   = object[1];
                txtExporterName.text = object[2];
                
                txtExpDesc.SetDataText(object[37]);            
	         }
        break;
        
        case 'Importer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtImporterPK.text   = object[0];
	            txtImporterID.text   = object[1];
                txtImporterName.text = object[2];

                txtImpDesc.SetDataText(object[37]);          
	         }
        break;     
        
        case 'Consignor' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtConsignorPK.text   = object[0];
	            txtConsignorID.text   = object[1];
                txtConsignorName.text = object[2]; 
                
                txtConsDesc.SetDataText(object[37]);             
	         }
        break;                  
        
        case 'Forwarder' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtForwarderPK.text   = object[0];
	            txtForwarderID.text   = object[1];
                txtForwarderName.text = object[2];
                
                txtForwarderDesc.SetDataText(object[37]);          
	         }
        break;  

        case 'Ex-Country':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0220";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0220';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstExCountry.value = object[1];      
	            }    	                
	         }                
        break; 
                       
        case 'Im-Port':        
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
	                lstImPort.value = object[1];      
	            }    	                
	         }                
        break; 
               
        case 'Ex-Port':        
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
	                lstExPort.value = object[1];      
	            }    	                
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
        
        case 'DeliCondi':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IECU0201";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IECU0201';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDeliCondi.value = object[1];      
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
        
        case 'PayTerm':
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
           
        case 'PayMethod':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0080";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEBS0080';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentMethod.value = object[1];      
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
	                lstTransCCY.value = object[1];      
	            }    	                
	         }                
        break;          
        
        case 'ReportType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEEX0040";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEEX0040';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstReportType.value = object[1];      
	            }    	                
	         }                
        break;  
        
        case 'DeclType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEEX0030";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEEX0030';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDeclType.value = object[1];      
	            }    	                
	         }                
        break;          
        
        case 'CustomsOffice':
             var path = System.RootURL + "/form/ep/bs/epbs00040.aspx?pop_type=Y";
	         var object = System.OpenModal( path ,850 ,600 ,'resizable:yes;status:yes;scroll:no;');
	         
	         if ( object != null )
	         {	        	                   
	             txtCustomsPK.text   = object[0]; 
	             txtCustomsCode.text = object[1];
	             txtCustomsName.text = object[2];	                
	         }                
        break;  
        case 'SCustomsOffice':
             var path = System.RootURL + "/form/ep/bs/epbs00040.aspx?pop_type=Y";
	         var object = System.OpenModal( path ,850 ,600 ,'resizable:yes;status:yes;scroll:no;');
	         
	         if ( object != null )
	         {	        	                   
	             lstSCustoms.value = object[1];
	         }                
        break;  
        
                                                                                                                                           
    }	       
}
//=========================================================================        
function OnSave(obj)
{
    switch (obj.id)
    {
        case 'Master':
            if ( ValidateData('Master') ) 
            {
                flag='save';
                
                data_epim00050.Call();
            }
        break;        
        case "btn_Save_T2":
            alert('function not implement!');
        break;
        case "detail":        
            data_epim00050_1.Call();
        break;
    }
}
//================================================================================	    
 function OnAddNew(pos)
 {
    switch(pos)
    {    
        case 'Master':
            
            data_epim00050.StatusInsert(); 
            
            //txtStaffPK.text   = user_pk ; 
            //txtStaffName.text = user_name ;           
      
            txtDeclNo.text = '<< New Declaration >>'; 
            grdDeclItems.ClearData();
            //--------------------------
//            txtDeclType.text = lstDeclType.value ;
//            txtExCountry.text = lstExCountry.value ;
////            txtImportGate.text = lstImPort.value ;
//            //txtExportGate.text = lstExPort.value ;
//            //--------------------------
//            //-------set thong tin mac dinh de control--------------
//            txtCustomsPK.text= txtHCus_Pk.text;
//            txtCustomsCode.text= txtHCus_Code.text;
//            txtCustomsName.text= txtHCus_Name.text;
//                    
//            txtImporterPK.text=txtHCom_Pk.text;
//            txtImporterID.text=txtHCom_Id.text;
//            txtImporterName.text=txtHCom_Name.text;
//            txtImpDesc.text= txtHCom_Code.text;
        break; 
        
        case 'CIItem':
            if ( txtExporterPK.text == '' )
            {
                alert('Pls select Exporter first.');
                return;
            }                
            //---------------------------
            var fpath = System.RootURL + "/form/ep/im/epim00052.aspx?supplier_pk=" + txtExporterPK.text ; //search contract
            
            object = System.OpenModal( fpath , 900 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDeclItems.AddRow();
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_MST_PK, txtMasterPK.text );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_PO_D_PK,   data[25] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_REF_PO_NO, data[3] );

                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SEQ, grdDeclItems.rows-1 );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ST_ITEM_PK, data[4] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_PK,    data[5] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_CODE,  data[6] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_NAME,  data[7] ); 
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC01_PK, data[8]  );                              
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC01_ID, data[9]  );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC02_PK, data[10]  );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC02_ID, data[11] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC03_PK, data[12] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC03_ID, data[13] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC04_PK, data[14] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC04_ID, data[15] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC05_PK, data[16] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SPEC05_ID, data[17] );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_HS_CODE, data[18] );
                                        
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_QTY_01, data[19] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_UOM_01, data[20] );                                        
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_QTY_02, data[21] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_UOM_02, data[22] );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_UPRICE, data[23] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_AMOUNT, data[24] );                     
                }
             }                                           
        break;  
        
        case 'FreeItem':
            var fpath = System.RootURL + "/form/ep/im/epim00053.aspx?group_type=2"; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDeclItems.AddRow();
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_MST_PK, txtMasterPK.text );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_SEQ, grdDeclItems.rows-1 );
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_PK,    data[0] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_CODE,  data[1] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_ITEM_NAME,  data[2] );                    
                    
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_HS_CODE, data[4] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_IMP_TAX_RATIO, data[5] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_VAT_TAX_RATIO, data[6] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_CONS_TAX_RATIO, data[7] );
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_UOM_01, data[3] );                                        
                    grdDeclItems.SetGridText( grdDeclItems.rows-1, G_UOM_02, data[3] ); 
                }
             }                       
        break;     
                                 
    }        
 }   

//================================================================================	    
function OnFormatGrid()
{
    var ctrl = grdDeclList.GetGridControl(); 
    ctrl.Cell( 7, 0, G0_DECL_STATUS, grdDeclList.rows - 1, G0_DECL_STATUS) = 0xFF0000;
    ctrl.Cell( 7, 0, G0_DECL_NO, grdDeclList.rows - 1, G0_DECL_NO) = 0x0000FF;

}
//====================================================================================
function OnCalc()
{
    var sum_trigiakb = 0, sum_tgtt = 0, sum_luong = 0, sum_tientheu = 0;
    for(var i = 1; i < grdDeclItems.rows; i++)
    {
        if(grdDeclItems.GetRowStatus(i) != 80 && grdDeclItems.GetRowStatus(i) != 64)
        {
            sum_trigiakb += Number(grdDeclItems.GetGridData(i, G1_TRIGIA_KB));
            sum_tgtt += Number(grdDeclItems.GetGridData(i, G1_TGKB_VND));
            sum_tientheu += Number(grdDeclItems.GetGridData(i, G1_THUE_XNK));
            sum_luong += Number(grdDeclItems.GetGridData(i, G1_LUONG));
        }
    }
    txtTGKB_T2.text = System.Round( sum_trigiakb, 2);
    txtTGTT_T2.text = System.Round( sum_tgtt, 2);
    txtTienThue_T2.text = System.Round( sum_tientheu, 2);
    txtLuong_T2.text = System.Round( sum_luong, 2);
}
//================================================================================	    
function OnDataReceive(obj)
{ 
        switch (obj.id)
        {
            case "data_epim00050" :
                if ( flag == 'save')
                {
                    for(var i=0; i < grdDeclItems.rows;i++)
                    {
                        if ( grdDeclItems.GetGridData( i, G1_DHANGMDDKID) == '' )
                        {
                            grdDeclItems.SetGridText( i, G1_DHANGMDDKID, txtMasterPK.text);
                        }    
                    }                
                    
                    OnSave('Detail');                
                }
                else
                {
                    //---------------------------- 
                    OnSearch(btn_Search_T2);   
                }            
            break;
            
            case "data_epim00050_1" :
                lbl_Record_T2.text = grdDeclItems.rows - 1 + ' row(s)';
                if ( grdDeclItems.rows > 1 )
                {
                    OnCalc();
                    
//                    grdDeclItems.SetCellBold( 1, G_ITEM_CODE, grdDeclItems.rows - 1, G_ITEM_CODE, true);
//                    grdDeclItems.SetCellBold( 1, G_REF_PO_NO, grdDeclItems.rows - 1, G_REF_PO_NO, true);
//                    grdDeclItems.SetCellBold( 1, G_QTY_01, grdDeclItems.rows - 1, G_QTY_01, true); 
//                    grdDeclItems.SetCellBold( 1, G_QTY_02, grdDeclItems.rows - 1, G_QTY_02, true);
//                    
//                    grdDeclItems.SetCellBold( 1, G_TR_AMOUNT,      grdDeclItems.rows - 1, G_TR_AMOUNT,      true);                    
//                    grdDeclItems.SetCellBold( 1, G_CAL_TAX_AMOUNT, grdDeclItems.rows - 1, G_CAL_TAX_AMOUNT, true);
//                    
//                    grdDeclItems.SetCellBold( 1, G_AF_IMP_TAX_AMOUNT,  grdDeclItems.rows - 1, G_AF_IMP_TAX_AMOUNT,  true);
//                    grdDeclItems.SetCellBold( 1, G_AF_CONS_TAX_AMOUNT, grdDeclItems.rows - 1, G_AF_CONS_TAX_AMOUNT, true);
//                    grdDeclItems.SetCellBold( 1, G_AF_VAT_TAX_AMOUNT,  grdDeclItems.rows - 1, G_AF_VAT_TAX_AMOUNT,  true);
//                    
//                    //grdDeclItems.SetCellBgColor( 1, G_FREIGHT_AMOUNT, grdDeclItems.rows-1, G_CAL_TAX_AMOUNT,    0xCCFFFF );
//                    grdDeclItems.SetCellBgColor( 1, G_IMP_TAX_RATIO,  grdDeclItems.rows-1, G_AF_IMP_TAX_AMOUNT, 0xCCFFFF );                    
//                    grdDeclItems.SetCellBgColor( 1, G_VAT_TAX_RATIO,  grdDeclItems.rows-1, G_AF_VAT_TAX_AMOUNT, 0xCCFFFF );
                }              
            break;
            
            case "data_fpab00220_2":
                 if ( txtLGGroupCodeID.text == 'LGCM0220')
                 {
                    lstExCountry.SetDataText(txtLGCodeList.text);  
                    lstExCountry.value = rtnLGCode;                      
                 }        
                 else if ( txtLGGroupCodeID.text == 'LGCM0230')
                 {
                    lstImPort.SetDataText(txtLGCodeList.text);
                    lstImPort.value = rtnLGCode;                      
                 } 
                 else if ( txtLGGroupCodeID.text == 'LGCM0240')
                 {
                    lstExPort.SetDataText(txtLGCodeList.text);
                    lstExPort.value = rtnLGCode;                      
                 }                  
                 else if ( txtLGGroupCodeID.text == 'LGCM0250')
                 {
                    lstDeliMethod.SetDataText(txtLGCodeList.text);
                    lstDeliMethod.value = rtnLGCode;                      
                 }                              
                 else if ( txtLGGroupCodeID.text == 'LGCM0130')
                 {
                    lstPriceType.SetDataText(txtLGCodeList.text);  
                    lstPriceType.value = rtnLGCode;                      
                 }   
                 else if ( txtLGGroupCodeID.text == 'LGCM0120')
                 {
                    lstPaymentTerm.SetDataText(txtLGCodeList.text);  
                    lstPaymentTerm.value = rtnLGCode;                      
                 }  
                 else if ( txtLGGroupCodeID.text == 'LGCM0100')
                 {
                    lstTransCCY.SetDataText(txtLGCodeList.text);  
                    lstTransCCY.value = rtnLGCode;                      
                 } 
                 else if ( txtLGGroupCodeID.text == 'IEEX0020')
                 {
                    lstReportType.SetDataText(txtLGCodeList.text);  
                    lstReportType.value = rtnLGCode;                      
                 }  
                 else if ( txtLGGroupCodeID.text == 'IEEX0030')
                 {
                    lstDeclType.SetDataText(txtLGCodeList.text);  
                    lstDeclType.value = rtnLGCode;                      
                 }                  
                 else if ( txtLGGroupCodeID.text == 'LGCM0100')
                 {
                    lstTransCCY.SetDataText(txtLGCodeList.text);  
                    lstTransCCY.value = rtnLGCode;                      
                 }                                                                                          
             break; 
             
             case 'pro_epim00050' :
                alert(txtReturnValue.text);
             break;    
             
             case 'pro_epim00050_1' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epim00050_3' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epim00050_3' :
                alert(txtReturnValue.text);
             break; 
             case 'epim00050_cancel' :
                alert(txtReturnValue.text);
             break;                                                                      
             case 'epim00050_confirm' :
                alert(txtReturnValue.text);
             break; 
             case 'epim00050_copy':
                OnSearch('Master');
             break;
             case 'data_epim00050_Get_Cus':
                OnAddNew('Master');
                lstSCustoms.value = txtHCus_Code.text;
             break;
        }  
}
 
//================================================================================	    

function OnDelete(index)
{
    switch (index)
    {
        case 'Master':// delete master
            if ( txtMasterPK.text != '' )
            {
                if(confirm('Do you want to delete this Declaration ?'))
                {
                    flag='delete';
                    data_epim00050.StatusDelete();
                    data_epim00050.Call();
                }   
            }
        break;

        case 'Detail':
            if ( grdDeclItems.row > 0 )
            {
                if(confirm('Do you want to delete this Item?'))
                {
                    if ( grdDeclItems.GetGridData( grdDeclItems.row, G_DETAIL_PK ) == '' )
                    {
                        grdDeclItems.RemoveRow();
                    }
                    else
                    {   
                        grdDeclItems.DeleteRow();
                    }    
                }
            }            
        break;
    }
}
  
//================================================================================	    
function ValidateData(index)
{
    switch(index)
    {
        case 'Master' :
            if ( txtImporterPK.text == '' )
            {
                alert("You must input Importer!");
                return false;
            }
            if(dtRegDate.value == "")
            {
                alert("Please input Register Date!");
                return false;                
            }            
            return true;
        break;
    }
}
 
//================================================================================	    
 function onDeclareDTChange()
{
   if (txtExRate.text =="" || txtExRate.text == 0)
   {
     getExRate();
   }  
}  

 
//---------------------------------------------------------
function getExRate()
{
   if (dtRegDate.value !="")
   {
    dso_epim_exrate.Call()
   }
}
//-------------------------------------------------------------------------------------------
function OnPrint(index)
{
    switch(Number(index))
    {
        case 1:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_declaration.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + lstCompany.value;
            System.OpenTargetPage( url, "_blank" );        
        break;
        case 2:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_packinglist.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + lstCompany.value;
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
		    document.all("Tab_Decl_Info").style.display  = "";
		    document.all("Tab_Decl_Items").style.display = "none";
 		    
		    document.all("Decl_Info").style.color   = "red"; 
		    document.all("Decl_Item").style.color   = "";
         break;
        
        case '2':
		    document.all("Tab_Decl_Info").style.display  = "none";
		    document.all("Tab_Decl_Items").style.display = "";
 		    
		    document.all("Decl_Info").style.color   = ""; 
		    document.all("Decl_Item").style.color   = "red"; 
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
                epim00050_confirm.Call();                
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
                epim00050_cancel.Call();                
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
                pro_epex00030_3.Call();                
            }          
        break;   
    }    
}    
//===================================================================================
function OnListChange(pos)
{
//    switch(pos)
//    {
//        case 'DeclType':
//            txtDeclType.text = lstDeclType.value ;
//        break;
//        
//        case 'ExCountry':
//            txtExCountry.text = lstExCountry.value ;
//        break;  
//        
//        case 'ImPort':
//            txtImportGate.text = lstImPort.value ;
//        break; 
//        
//        case 'ExPort':
//            txtExportGate.text = lstExPort.value ;
//        break;                        
//    }
} 
//===================================================================================
function SetTHCFee()
{
    var pLoadingFee = Number(txtLoadingFee.text);
    var pAVG = pLoadingFee/Number(txtTransAmount.text);
    var pFee = 0, pTotalFee = 0  ;
    
    for( var i=1; i < grdDeclItems.rows; i++ )
    {
        if ( i == grdDeclItems.rows-1 )
        {
            pFee = Number(pLoadingFee) - Number(pTotalFee);
            grdDeclItems.SetGridText( i, G_THC_AMOUNT, pFee ) ;
        } 
        else
        {
            pFee = pAVG * Number( Number(grdDeclItems.GetGridData( i, G_TR_AMOUNT)) );
            pFee = parseFloat(pFee+"").toFixed(2);
            
            pTotalFee = Number(pTotalFee) + Number(pFee);
            
            grdDeclItems.SetGridText( i, G_THC_AMOUNT, pFee ) ;
        }   
    }               
}
//=================================================================================== 
function SetFreightFee()
{    
    var pFreightFee = Number(txtFreightFee.text);
    var pAVG = pFreightFee/Number(txtTransAmount.text);
    var pFee = 0, pTotalFee = 0  ;
    
    for( var i=1; i < grdDeclItems.rows; i++ )
    {
        if ( i == grdDeclItems.rows-1 )
        {
            pFee = Number(pFreightFee) - Number(pTotalFee);
            grdDeclItems.SetGridText( i, G_FREIGHT_AMOUNT, pFee ) ;            
        } 
        else
        {
            pFee = pAVG * Number( Number(grdDeclItems.GetGridData( i, G_TR_AMOUNT)) );
            pFee = parseFloat(pFee+"").toFixed(2);
            
            pTotalFee = Number(pTotalFee) + Number(pFee);
            grdDeclItems.SetGridText( i, G_FREIGHT_AMOUNT, pFee ) ;
        }   
    }               
}
//===================================================================================
function OnCopy()
{
    if(txtMasterPK.text=="")
    {
        alert("Select Invoice No to Copy");
    }
    else
    {
        epim00050_copy.Call();
    }
    
}
//===================================================================================      
function ListSelectChanged()
{
    
}

//===================================================================================      
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 
 
    if(imgArrow.status == "expand"){
    right.style.display="";
    imgArrow.status = "collapse";
    left.style.width="25%";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    right.style.display="none";
    imgArrow.status = "expand";
    left.style.width="100%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//===================================================================================      
</script>

<body>
    <!-------------------------------Lay thong tin cua hai quan, thong tin cong ty------------------------------------------------>
    <gw:data id="data_epim00050_Get_Cus" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_epim00050_info"> 
                <inout> 
                    <inout  bind="txtHCom_Pk" /> 
                    <inout  bind="txtHCus_Pk" />
                    <inout  bind="txtHCus_Code" />
                    <inout  bind="txtHCus_Name" />
                    
                    <inout  bind="txtHCom_Pk" />                    
                    <inout  bind="txtHCom_Id" />
                    <inout  bind="txtHCom_Name" />
                    <inout  bind="txtHCom_Code" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <%--<!------------------------------------------------------------------>
    <gw:data id="epim00050_copy" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_epim00050_copy" > 
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
    </gw:data>--%>
    <!------------------------------------------------------------------------------------------>
    <gw:data id="data_epim00050" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51" function="<%=l_user%>lg_sel_epex00050"  procedure="<%=l_user%>lg_upd_epim00050"> 
            <inout> 
                <inout  bind="txtMasterPK" />                 
                <inout  bind="txtCustomsCode" /> 
                <inout  bind="txtCustomsName" />
                <inout  bind="txtDeclSeq" />
                <inout  bind="txtDeclNo" />
                <inout  bind="txtRecepNo" />                
                <inout  bind="txtProfile_No" />
                <inout  bind="radTab" />
                <inout  bind="lblDecl_Status" />
                <inout  bind="dtRegDate" />
                <inout  bind="dtRecepDate" />
                
                <inout  bind="txtImporterID" />
                <inout  bind="txtImpDesc" />
                <inout  bind="txtReceiverName" /> 
                
                <inout  bind="txtExporterID" />
                <inout  bind="txtExpDesc" />
                
                <inout  bind="txtConsignorID" />
                <inout  bind="txtConsDesc" />
                
                <inout  bind="txtForwarderID" />
                <inout  bind="txtForwarderDesc" />
                
                <inout  bind="txtDeclType" />
                <inout  bind="lstDeclType" />
                
                <inout  bind="txtLicenseNo" />
                <inout  bind="dtLicenseDate" />
                <inout  bind="dtLicenseExpDate" />
                
                <inout  bind="txtContractNo" />   
                <inout  bind="dtContractDate" />
                <inout  bind="dtContractExpDate" />
                
                <inout  bind="txtInvoceNo" />
                <inout  bind="dtInvoiceDate" />
                
                <inout  bind="lstDeliMethod" />  
                <inout  bind="txtDeliNo" />                  
                <inout  bind="dtETA" />     
                
                <inout  bind="txtBOL_NO" /> 
                <inout  bind="dtBOLDate" />                     
                <inout  bind="chBOLDate" />    
                
                <inout  bind="txtExCountry" />  
                <inout  bind="lstExCountry" />
                
                <inout  bind="txtLoadingPort" />   
                <inout  bind="lstLoadingPort" /> 
                
                <inout  bind="txtUnloadingPort" />   
                <inout  bind="lstUnloadingPort" />       
                
                <inout  bind="lstDeliCondi" />   
                
                <inout  bind="txtPayCCYCode" />   
                <inout  bind="lstPayCcy" />                 
                <inout  bind="txtCCYRate" />
                
                <inout  bind="lstPaymentMethod" />
                
                <inout  bind="txtweight_G" />
                <inout  bind="txtweight_N" />                
                <inout  bind="txtPackage_Num" />
                <inout  bind="txtContainer20_Num" />
                <inout  bind="txtContainer40_Num" />                
                <inout  bind="txtContainer45_Num" />
                <inout  bind="txtContainer_Other_Num" />
                
                <inout  bind="txPhiBH_T2" />
                <inout  bind="txtPhiVC_T2" />                
                <inout  bind="chkTuDongPhanBo_T2" />
                
                <inout  bind="chkBL_T3" />
                <inout  bind="chkDonXinCCK_T3" />
                <inout  bind="chkCO_T3" />
                <inout  bind="chkChungtuno_T3" />
                <inout  bind="chkGP_T3" />
                <inout  bind="chkGiapKTCL_T3" />
                <inout  bind="chkHD_T3" />
                <inout  bind="chkGiapDKKTCL_T3" />
                <inout  bind="chkHDTM_T3" />
                <inout  bind="chkCTGD_T3" />
                <inout  bind="chkCTDK_T3" />
                <inout  bind="chkCTBS_T3" />                
                
                <inout  bind="txtDeXuat" />
                
                <inout  bind="chkAnHanThue" />
                <inout  bind="txtSoNgayAnHan" />
                <inout  bind="txtLydoAnHan" />
                
                <inout  bind="chkDamBaoThue" />
                <inout  bind="txtHinhThucDamBaoThue" />
                <inout  bind="txtTrgiaDBT" />
                <inout  bind="dtNgayBatDau_T4" />
                <inout  bind="dtNgayKetThuc_T4" />
                
                <inout  bind="txt_sothamchieu" />
                <inout  bind="txt_lydosuatk" />
                <inout  bind="chk_chukydientu" />
                <inout  bind="txt_chukydientu" />
                
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------------------->
    <gw:data id="data_epim00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41" function="<%=l_user%>lg_sel_epex00050_1"   procedure="<%=l_user%>lg_upd_epim00050_1"> 
                <input bind="grdDeclItems">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDeclItems" /> 
            </dso> 
        </xml> 
    </gw:data>
    <%--<!---------------------------------------------------------------------------------------->
    <gw:data id="dso_epim_exrate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_epim00050_3" > 
                <input>
                    <input bind="lstTransCCY" /> 
                    <input bind="dtRegDate" /> 
                </input> 
                <output>
                    <output bind="txtExRate" />
                </output>
            </dso>  
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------>
    <gw:data id="epim00050_cancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_epim00050_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso>  
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------------------->
    <gw:data id="epim00050_confirm" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_epim00050_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso>  
        </xml> 
    </gw:data>--%>
    <!---------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%" align="right">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                        </td>
                        <td style="width: 40%; white-space: nowrap">
                        </td>
                        <td style="width: 25%" align="center">
                            <gw:label id="lbStatus" text="-" styles='width:100%;color:red; font-weight:700;'
                                csstype="mandatory" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="search" text="Search" onclick="OnSearch('Decla')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="OnCopy()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td>
                <!--<gw:tab> -->
                <gw:tab id="tab_content">
                <table id="tbl_DeclarationInfo" style="width: 100%; height: 100%" name="Declaration Info" border="1" >
                    <tr style="height: 1%">
                        <td colspan="2">
                                <table style="width: 100%; height: 100%" border="0" >
                                    <tr>
                                        <td style="width: 2%; white-space: nowrap"  align="right">
                                            <a onclick="OnPopUp('CustomsOffice')" href="#tips" style="color: #0000ff">Customs</a>
                                        </td>
                                        <td style="width: 20%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtCustomsPK" styles='display:none;' />
                                            <gw:textbox id="txtCustomsCode" text="" styles='width:20%;' />
                                            <gw:textbox id="txtCustomsName" text="" styles='width:80%;' />
                                        </td>
                                        
                                        
                                        <td style="width: 2%; white-space: nowrap" align="right">
                                        Decl No
                                        </td>
                                        <td style="width: 10%; white-space: nowrap" >
                                            <gw:textbox id="txtDeclNo" text="" styles='width:100%;' csstype="mandatory" />
                                        </td>
                                        <td style="width: 2%; white-space: nowrap" align="right">
                                        Recep No
                                        </td>
                                        <td style="width: 7%">
                                            <gw:textbox id="txtRecepNo" text="" styles='width:100%;' csstype="mandatory" />
                                        </td>
                                        <td style="width: 1%; white-space: nowrap" align="right">
                                            Ramif
                                        </td>
                                        <td style="width: 15%; white-space: nowrap" >
                                            <gw:radio id="radTab" value="1" style="width:100%;white-space: nowrap"> 
                                                <span value="Xanh" id="Ramification_G">Green</span> 
                                                <span value="Vang" id="Ramification_Y">Yellow</span>
                                                <span value="Do" id="Ramification_R">Red</span> 
                                            </gw:radio>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 2%; white-space: nowrap"  align="right">
                                            Profile No
                                        </td>
                                         <td style="width: 10%; ">
                                            <gw:textbox id="txtProfile_No" text="" styles='width:100%;' />
                                        </td>
                                        <td style="width: 1%; white-space: nowrap" align="right">
                                            Seq
                                        </td>
                                        <td style="width: 15%;white-space: nowrap">
                                            <gw:textbox id="txtDeclSeq" text="" styles='width:100%;' csstype="mandatory" />
                                        </td>
                                        
                                        <td style="width: 2%; white-space: nowrap" align="right">
                                            Reg Date
                                        </td>
                                        <td style="width: 7%">
                                            <gw:datebox id="dtRegDate" lang="1" onchange="onDeclareDTChange()" csstype="mandatory"
                                                nullaccept="T" />
                                        </td>
                                        <td style="width: 2%; white-space: nowrap"  align="right">
                                            Recep Date
                                        </td>
                                        <td style="width: 5%">
                                            <gw:datebox id="dtRecepDate" lang="1" onchange="" nullaccept="T" />
                                        </td>
                                        <td style="width: 15%; white-space: nowrap" colspan="2" align="center">
                                             <gw:label id="lblDecl_Status" text="" styles="width:100%;color:red; font-weight:700;" csstype="mandatory" />
                                        
                                        </td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td style="width: 25%">
                            <table style="width: 100%; height: 100%;" border="0" cellpadding="0"
                                cellspacing="0">
                                <tr >
                                    <td>
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 5%; white-space: nowrap">
                                                    <span style="color: #B22222; font-weight: bold;">1. </span>
                                                    Importer
                                                </td>
                                                <td style="width: 95%; white-space: nowrap">
                                                    <gw:textbox id="txtImporterPK" text="" styles='width:100%;display:none;' csstype="mandatory" />
                                                    <gw:textbox id="txtImporterID" text="" styles='width:100%;' csstype="mandatory" />
                                                    <gw:textbox id="txtImporterName" text="" styles='width:100%;display:none;' csstype="mandatory" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <gw:textarea id="txtImpDesc" styles="width:100%;" rows="4" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 5%; white-space: nowrap">
                                                    Receiver
                                                </td>
                                                <td style="width: 95%; white-space: nowrap">
                                                    <gw:textbox id="txtReceiverName" text="" styles='width:100%;' csstype="mandatory" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr >
                                    <td>
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 5%; white-space: nowrap">
                                                    <span style="color: #B22222; font-weight: bold;">2. </span><a onclick="OnPopUp('Exporter')"
                                                        href="#tips" style="color: #0000ff">Exporter</a>
                                                </td>
                                                <td style="width: 35%; white-space: nowrap">
                                                    <gw:textbox id="txtExporterPK" styles='display:none;' />
                                                    <gw:textbox id="txtExporterID" text="" styles='width:100%;' csstype="mandatory" />
                                                    <gw:textbox id="txtExporterName" text="" styles='width:70%;display:none;' csstype="mandatory" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <gw:textarea id="txtExpDesc" styles="width:100%;" rows="4" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr >
                                    <td>
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 5%; white-space: nowrap">
                                                    <span style="color: #B22222; font-weight: bold;">3. </span><a onclick="OnPopUp('Consignor')"
                                                        href="#tips" style="color: #0000ff">Consignor</a>
                                                </td>
                                                <td style="width: 95% ;white-space: nowrap">
                                                    <gw:textbox id="txtConsignorPK" styles='display:none;' />
                                                    <gw:textbox id="txtConsignorID" text="" styles='width:100%;' />
                                                    <gw:textbox id="txtConsignorName" text="" styles='width:70%;display:none;' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <gw:textarea id="txtConsDesc" styles="width:100%;" rows="3" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr >
                                    <td>
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 5%; white-space: nowrap">
                                                    <span style="color: #B22222; font-weight: bold;">4. </span><a onclick="OnPopUp('Forwarder')"
                                                        href="#tips" style="color: #0000ff">Forwarder</a>
                                                </td>
                                                <td style="width: 35%; white-space: nowrap">
                                                    <gw:textbox id="txtForwarderPK" styles='display:none;' />
                                                    <gw:textbox id="txtForwarderID" text="" styles='width:100%;' />
                                                    <gw:textbox id="txtForwarderName" text="" styles='width:70%;display:none;' />
                                                </td>
                                            </tr>
                                            <tr valign="top">
                                                <td colspan="2">
                                                    <gw:textarea id="txtForwarderDesc" styles="width:100%;" rows="3" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 75%; ">
                        <table style="width: 100%; height: 100%; background-color: #CCFFFF; vertical-align:top;" cellpadding="0" cellspacing="0" border="1" >
                            <tr style="height:1%" >
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;" >
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap;">
                                                <span style="color: #B22222; font-weight: bold;">5. </span> 
                                                <a onclick="OnPopUp('DeclType')" href="#tips" style="color: #0000ff">Decl type
                                                </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 15%; white-space: nowrap">
                                                <gw:textbox id="txtDeclType" text="" styles='width:100%' />
                                            </td>
                                            <td style="width: 80%; white-space: nowrap" colspan="3">
                                                <gw:list id="lstDeclType" styles="width:100%" onchange="OnListChange('DeclType')"
                                                    csstype="mandatory"></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height:1%" >
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap;" align="right">
                                                <span style="color: #B22222; font-weight: bold;">6. </span> 
                                                License No
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 55%">
                                                <gw:textbox id="txtLicenseNo" text="" styles='width:100%;' />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Date
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtLicenseDate" lang="1" onchange="" nullaccept="T" />
                                            </td>
                                            <td style="width: 5%" align="right">
                                                Expire
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtLicenseExpDate" lang="1" onchange="" nullaccept="T" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                              </tr>
                            <tr style="height:1%" >                                        
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="width: 5%; white-space:nowrap;" align="right">
                                                <span style="color: #B22222; font-weight: bold;">7. </span>
                                                Contract No
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 55%">
                                                <gw:textbox id="txtContractNo" text="" styles='width:100%;' />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Date
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtContractDate" lang="1" onchange="" />
                                            </td>
                                            <td style="width: 5%" align="right">
                                                Expire
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtContractExpDate" lang="1" onchange="" nullaccept="T" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap;" align="right">
                                                <span style="color: #B22222; font-weight: bold;">8. </span>
                                                Invoice No
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 80%;white-space: nowrap;" colspan="3">
                                                <gw:textbox id="txtInvoceNo" text="" styles='width:98%;' />
                                                &nbsp;&nbsp;
                                            </td>
                                            <td style="width: 5%" align="right">
                                                Date
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtInvoiceDate" lang="1" onchange="" nullaccept="T" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap">
                                                <span style="color: #B22222; font-weight: bold;">9. </span>
                                                <a onclick="OnPopUp('DeliMethod')" href="#tips" style="color: #0000ff">Deli Method</a>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 25%">
                                                <gw:list id="lstDeliMethod" styles="width:100%;" onchange=""></gw:list>
                                            </td>
                                            <td style="width: 5%; white-space:nowrap;">
                                                Deli No
                                            </td>
                                            <td colspan="2" style="width: 25%">
                                                <gw:textbox id="txtDeliNo" styles='width:98%;' />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                ETA
                                            </td>
                                            <td style="width: 10%">
                                                <gw:datebox id="dtETA" lang="1" onchange="" nullaccept="T" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;" >
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap;">
                                                <span style="color: #B22222; font-weight: bold;">10. </span>
                                                <a onclick="OnPopUp('Ex-Country')" href="#tips" style="color: #0000ff">Bill Of Lading</a>
                                                    &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 55%; white-space: nowrap;">
                                                <gw:textbox id="txtBOL_NO" styles="width:100%;" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Date
                                            </td>
                                            <td style="width: 15%">
                                                <gw:datebox id="dtBOLDate" lang="1" onchange="" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Not BL
                                            </td>
                                            <td style="width: 10%; white-space:nowrap;">
                                                <gw:checkbox id="chBOLDate"  />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                             </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap;">
                                                <span style="color: #B22222; font-weight: bold;">11. </span><a onclick="OnPopUp('Ex-Country')"
                                                    href="#tips" style="color: #0000ff">Ex-Country</a>
                                                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 20%; white-space: nowrap;">
                                                <gw:textbox id="txtExCountry" styles="width:100%;" />
                                            </td>
                                            <td style="width: 75%; white-space: nowrap;">
                                                <gw:list id="lstExCountry" styles="width:100%;" onchange="OnListChange('ExCountry')"></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                
                            </tr>
                            <tr style="height: 1%">
                                <td>
                                    <table style="width: 100%; height: 100%;">
                                        <tr>
                                            <td style="white-space: nowrap; width: 5%">
                                                <span style="color: #B22222; font-weight: bold;">12.  </span><a onclick="OnPopUp('Ex-Port')"
                                                    href="#tips" style="color: #0000ff">Loading Port</a>
                                                    &nbsp;&nbsp; &nbsp;
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtLoadingPort" styles='width:100%;' />
                                            </td>
                                            <td style="width: 75%">
                                                <gw:list id="lstLoadingPort" styles="width:100%;" onchange="OnListChange('ExPort')"></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td>
                                    <table style="width: 100%; height: 100%; background-color: #CCFFFF" >
                                        <tr>
                                            <td style="white-space: nowrap; width: 5%">
                                                <span style="color: #B22222; font-weight: bold;">13.  </span>
                                                <a onclick="OnPopUp('Im-Port')" href="#tips" style="color: #0000ff">Unloading Port</a>&nbsp;
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtUnloadingPort" styles='width:100%;' />
                                            </td>
                                            <td style="width: 75%">
                                                <gw:list id="lstUnloadingPort" styles="width:100%;" onchange="OnListChange('ImPort')"></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap">
                                                <span style="color: #B22222; font-weight: bold;">14.  </span><a onclick="OnPopUp('DeliCondi')"
                                                    href="#tips" style="color: #0000ff">Deli Condi</a>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 95%">
                                                <gw:list id="lstDeliCondi" styles="width:100%;" onchange=""></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap">
                                                <span style="color: #B22222; font-weight: bold;">15. </span>
                                                <a onclick="OnPopUp('PayMethod')" href="#tips" style="color: #0000ff">Pay CCY</a>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 10%">
                                                <gw:textbox id="txtPayCCYCode" styles='width:100%;' />
                                            </td>
                                            <td style="width: 40%; white-space:nowrap;">
                                                
                                                <gw:list id="lstPayCcy" styles="width:100%;" onchange=""></gw:list>
                                            </td>
                                            <td style="width: 5%">
                                                Rate
                                            </td>
                                            <td style="width: 40%">
                                                <gw:textbox id="txtCCYRate" styles='width:100%;' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>   
                            </tr>
                            <tr style="height: 1%">
                                <td colspan="2">
                                    <table style="width: 100%; height: 100%">
                                        <tr>
                                            <td style="width: 5%; white-space: nowrap">
                                                <span style="color: #B22222; font-weight: bold;">16. </span>
                                                <a onclick="OnPopUp('PayMethod')" href="#tips" style="color: #0000ff">Pay Method</a>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </td>
                                            <td style="width: 95%">
                                                <gw:list id="lstPaymentMethod" styles="width:100%;" onchange=""></gw:list>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                      </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="2"> 
                            <table style="width:100%; height:100%">
                                <tr>
                                    <td style="width:5%; white-space: nowrap" align="right">
                                        Weigth(Kg)<span style="color:blue">G</span>
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtweight_G" styles="width:100%;display:;" type="number" format="###,###,###" />
                                    </td>
                                     <td style="width:1%; white-space: nowrap" align="right">
                                        <span style="color:blue">N</span>
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtweight_N" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                    <td style="width:4%; white-space: nowrap" align="right">
                                        Pkg Num
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtPackage_Num" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                    <td style="width:5%; white-space: nowrap" align="right">
                                        Cont20
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtContainer20_Num" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                    <td style="width:5%; white-space: nowrap" align="right">
                                        Cont40
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtContainer40_Num" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                    <td style="width:5%; white-space: nowrap" align="right">
                                        Cont45
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtContainer45_Num" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                    <td style="width:5%; white-space: nowrap" align="right">
                                        Cont other
                                    </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtContainer_Other_Num" styles='width:100%;display:;'  type="number" format="###,###,###" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table  id=tbl_DeclarationItems" style="width: 100%; height: 100%" name="Declaration Items" border="1">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 5%; white-space: nowrap">
                                        Item Code/Name
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id ="txtTextSearch_T2" text="" styles="width:100%;" />
                                    </td>
                                    <td style="width: 50%" align="center">  
                                        <gw:label id="lbl_Record_T2" styles="color: blue">row(s)</gw:label>
                                    </td>
                                    <td style="width: 1%" align="center">
                                        <gw:button id="btn_Search_T2" img="search" alt="Search" onclick="OnSearch(this)" />
                                    </td>
                                    <td style="width: 1%" align="center">
                                        <gw:button id="btn_New_T2" img="new" styles="display:" alt="New" onclick="OnAddNew(this)" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:button id="btn_Dlete_T2" img="delete"  styles="display:" alt="Delete" onclick="OnDelete(this)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:button id="btn_UnDelete_T2" img="undelete"  styles="display:" alt="UnDelete" onclick="OnUnDelete(this)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:button id="btn_Save_T2" img="save"  styles="display: " alt="Save" onclick="OnSave(this)" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td >
                            <gw:grid id='grdDeclItems'
                                header='DHANGMDDKID|STTHANG|MA_NPL_SP|TEN_HANG|MA_HANGKB|NUOC_XX|MA_TINH_TRANG|LUONG|MA_DVT|DGIA_KB|TRIGIA_KB|TGKB_VND|TS_XNK_MA_BT|TS_XNK_TD|TS_XNK|THUE_XNK|TS_TTDB_MA_BTTS_TTDB|TS_TTDB_TD|THUE_TTDB|TS_VAT_MA_BT|TS_VAT|THUE_VAT|TS_MT_MA_BT|TS_MT|TS_MT_TD|THUE_MT|TYLE_THUKHAC|TRIGIA_THUKHAC|CHE_DO_UU_DAI|IS_HANG_DONG_BO|MIENTHUE|MIENTHUE_SOVB|MIENTHUE_TS|MIENTHUE_TS_GIAM|MAHANGSX|TENHANGSX|MAHSMORONG|NHANHIEU|QUYCACH_PC|MA_HTS|MA_DVT_HTS|LUONG_HTS|DONGIA_HTS'
                                format='0|1|0|0|0|2|2|1|2|1|1|1|2|1|1|1|2|1|1|1|1|2|1|1|1|1|1|2|0|3|0|1|1|0|0|0|0|0|0|2|0|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='|||||||||||||||||||||||||||||||||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T'
                                autosize='T' 
                                styles='width:100%; height:100%'
                                onafteredit='OnGridCellAfterEdit(this)'
                                />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table style="width:100%; height:100%" >
                                <tr>
                                    <td style="color: blue;width:5%; white-space:nowrap;">
                                        Tong TKGB
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtTGKB_T2" text="" styles="color: blue;font-weight:bold;" type="number" format="###,###,###.##R" readonly="T" />
                                    </td>
                                    <td style="color: blue;width:5%; white-space:nowrap;">
                                        Tong TGTT
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtTGTT_T2" text="" styles="color: blue;font-weight:bold;" type="number" format="###,###,###.##R"  readonly="T"/>
                                    </td>
                                    <td style="color: blue;width:5%; white-space:nowrap; ">
                                        Tong tien thue
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtTienThue_T2" text="" styles="color: blue;font-weight:bold;" type="number" format="###,###,###.##R" readonly="T"/>
                                    </td>
                                    <td style="color: blue;width:5%; white-space:nowrap;">
                                        Tong Luong
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtLuong_T2" text="" styles="color: blue;font-weight:bold;" type="number" format="###,###,###.##R" readonly="T"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table style="width:100%; height:100%">
                                <tr>
                                    <td style="width:5%; white-space:nowrap;">
                                        Phi VC
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtPhiVC_T2" text="" styles="color: blue;" />
                                    </td>
                                    <td style="width:5%; white-space:nowrap;">
                                        Phi BH
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txPhiBH_T2" text="" styles="color: blue;" />
                                    </td>
                                    <td style="width:5%; white-space:nowrap;">
                                        Tu Dong phan bo
                                    </td>
                                    <td style="width:20%">
                                        <gw:checkbox id="chkTuDongPhanBo_T2" styles="color: blue;" />
                                    </td>
                                    <td style="width:23%">
                                        <gw:radio id="radFunction" value="1" styles="width:100%">                      
						                    <span value="1">Cong vao</span>                       
						                    <span value="2">tru di</span>    			                                
			        			        </gw:radio>

                                    </td>
                                    <td style="width:1%">
                                        <gw:button id="btn_KtrTonNPL_T2" img=""  styles="display:" alt="Kiem tra ton npl" onclick="OnSave('grdMATDMList')" />
                                    </td>
                                    <td style="width:1%">
                                        <gw:button id="btn_InDSHang_T2" img=""  styles="display:" alt="In DS Hang" onclick="OnSave('grdMATDMList')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table  id="tbl_AttachedDocument" style="width:100%; height:100%;" border="1" name="Attached Document">
                    <tr style="height:80%;">
                        <td colspan="2" valign="middle">
                            <table style="width: 100%; height:1%" border="0">
                                <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkBL_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnBL_T3" img=""  styles="width:100%; " alt="Bill of Lading" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkDonXinCCK_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnDonXinCCK_T3" img=""  styles="display: " alt="Đơn xin chuyển cửa khẩu" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkCO_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnCO_T3" img=""  styles="width:100%; " alt="CO" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkChungtuno_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnChungtuno_T3" img=""  styles="display: " alt="Chứng từ nợ" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkGP_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnGP_T3" img=""  styles="float:left; " alt="Giấp Phép" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkGiapKTCL_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnGiapKTCL_T3" img=""  styles="display: " alt="Giấy thông báo kiểm tra chất lượng" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                                <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkHD_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnHD_T3" img=""  styles="float:left; " alt="Hợp đồng" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkGiapDKKTCL_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnGiapDKKTCL_T3" img=""  styles="display: " alt="Giấy đăng ký kiểm tra chất lượng" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                                 <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkHDTM_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnHDTM_T3" img=""  styles="float:left; " alt="Hóa đơn thương mại" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkCTGD_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnCTGD_T3" img=""  styles="display: " alt="Chứng thư giám định" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                                 <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkCTDK_T3" styles="color: blue;" checked="T" />
                                    </td>
                                    
                                    <td style="width:32%">
                                        <gw:button id="btnCTDK_T3" img=""  styles="float:left; " alt="Chứng từ đính kèm dạng ảnh" onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:6%"></td>
                                    <td style="width:5%" align="right">
                                        <gw:checkbox id="chkCTBS_T3" styles="width:100%; " checked="T" />
                                    </td>
                                    <td style="width:32%">
                                        <gw:button id="btnCTBS_T3" img=""  styles="display: " alt="Chứng từ bổ sung sau khi đã cấp số..." onclick="OnPopUp(this)" />
                                    </td>
                                    
                                    <td style="width:10%"></td>
                                </tr>
                                
                            </table>
                        </td>
                    </tr>
                    <tr style="height:20%;">
                    <td style="width:10%; white-space:nowrap;">
                    Đề xuất khác của doanh nghiệp
                    </td>
                    <td style="width:90%">
                        <gw:textarea id="txtDeXuat" styles="width:100%;" rows="6" />
                    </td>
                    </tr>
                    
                </table>
                <table id="tbl_TaxInfo" style="width:100%; height:100%;" border="1" name="Tax Info">
                    <tr>
                        <td>
                            <fieldset style="padding: 5">
                                <legend>Ân hạn thuế</legend>
                                <table style="width:100%; height:100%">
                                    <tr>
                                        <td style="width:5%" align="right">
                                            <gw:checkbox id="chkAnHanThue" />
                                        </td>
                                        <td style="width:10%" colspan="2">
                                            Tờ khai được ân hạn thuế
                                        </td>                                       
                                        <td style="width:20%">
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%; white-space:nowrap;" colspan="2" align="right">
                                            Số ngày được ân hạn thuế
                                        </td>                                       
                                        <td style="width:20%">
                                            <gw:textbox id="txtSoNgayAnHan" text ="0" type="number" format="###,###,###" />
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%" colspan="2" align="right">
                                            Lý do được ân hạn
                                        </td>                                       
                                        <td style="width:80%" colspan="2">
                                            <gw:textarea id="txtLydoAnHan" styles="width:100%;" rows="6" />
                                        
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset style="padding: 5">
                                <legend>Đảo bảo thuế</legend>
                                <table style="width:100%; height:100%">
                                    <tr>
                                        <td style="width:5%" align="right">
                                            <gw:checkbox id="chkDamBaoThue" />
                                        </td>
                                        <td style="width:10%" colspan="2">
                                            Tờ khai được đảm bảo thuế
                                        </td>                                       
                                        <td style="width:20%">
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%" colspan="2" align=right>
                                            Hình thức đảm bảo thuế
                                        </td>                                       
                                        <td style="width:80%" colspan="2">
                                            <gw:textbox id="txtHinhThucDamBaoThue" styles="width:100%;"  />
                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%" colspan="2" align="right">
                                            Trị Gia Dam Bao Thue
                                        </td>                                       
                                        <td style="width:20%">
                                            <gw:textbox id="txtTrgiaDBT" text ="0" type="number" format="###,###,###" />
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%" colspan="2" align="right">
                                            Ngay bat dau
                                        </td>                                       
                                        <td style="width:20%">
                                             <gw:datebox id="dtNgayBatDau_T4" lang="1" onchange="onDeclareDTChange()" csstype="mandatory"
                                                nullaccept="T" />
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%" colspan="2" align="right">
                                            Ngay Ket Thuc
                                        </td>                                       
                                        <td style="width:20%">
                                             <gw:datebox id="dtNgayKetThuc_T4" lang="1" onchange="onDeclareDTChange()" csstype="mandatory"
                                                nullaccept="T" />
                                        </td>
                                        <td style="width:65%">
                                        </td>
                                    </tr>
                                    
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table id="tbl_ProcsessResult" style="width:100%; height:100%;" border="1" name="Procsess Result">
                    <tr>
                    <td>
                    <table style="width:100%; height:100%">
                        <tr style="height:95%" valign="top">
                        <td style="width:5%" align="right">
                         So tham chieu
                        </td>
                         <td style="width:5%" colspan="2">
                            <gw:textbox id = "txt_sothamchieu" text="" readonly="T" />
                        </td>
                         
                         <td style="width:5%">
                         <gw:icon id="btnChon_T5" img="2" text="---" alt="---" styles='width:20px'
                                            onclick="OnPopUp(this)" />
                        </td>
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:5%">
                         
                        </td>
                         <td style="width:5%">
                            
                        </td>
                         <td style="width:10%" colspan="2">
                          <gw:icon id="btnHuongdanthutuchq" img="2" text="Huong dan thu tuc hai quan" alt="Huong dan thu tuc hai quan" styles='width:300px'
                                            onclick="OnPopUp(this)" />
                        </td>
                         
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:5%">
                         
                        </td>
                         <td style="width:5%">
                            
                        </td>
                         <td style="width:5%" colspan="2">
                          <gw:icon id="btnDieuChinhThue" img="2" text="Dieu chinh thue" alt="Dieu chinh thue" styles='width:300px'
                                            onclick="OnPopUp(this)" />
                        </td>
                         
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:5%" align="right">
                         ly do sua to khai
                        </td>
                         <td style="width:5%" colspan="5" >
                            <gw:textarea id="txt_lydosuatk" styles="width:100%;" rows="6" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width:5%; white-space:nowrap;" align="right">
                         <gw:checkbox id="chk_chukydientu" />
                         chu ky dien tu
                        </td>
                         <td style="width:5%" colspan="5">
                            <gw:textarea id="txt_chukydientu" styles="width:100%;" rows="6" />
                        </td>
                         
                    </tr>
                    <tr>
                        <td style="width:5%">
                         
                        </td>
                         <td style="width:5%">
                            
                        </td>
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                         <td style="width:5%">
                        </td>
                    </tr>
                    </table>                        
                    </td>
                    </tr>
                    
                
                </table>
                
                <table id="tbl_Decl_Proccess" style="width:100%; height:100%;" border="1" name="Decl Proccess">
                    <tr valign="middle">
                        <td >
                            <table style="width:100%;">
                            <tr>
                            <td valign="top" align="center">
                                <gw:icon id="btnKiemHoa" img="2" text="3. kiem hoa" alt="3. kiem hoa" styles='width:300px'
                                            onclick="OnPopUp(this)" />
                            </td>
                            </tr>
                            <tr>
                            <td valign="top" align="center">
                                
                                <gw:icon id="btnTinhThueSKH" img="2" text="4. tinh thue sau kiem hoa" alt="4. tinh thue sau kiem hoa" styles='width:300px'
                                            onclick="OnPopUp(this)" />
                            </td>
                            </tr>
                            <tr>
                            <td valign="top" align="center">
                                
                                <gw:icon id="btnDieuChinhThue" img="2" text="5. dieu chinh thue" alt="5. dieu chinh thue" styles='width:300px'
                                            onclick="OnPopUp(this)" />
                            </td>
                            </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                
                </gw:tab>
                <!--</gw:tab> -->
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------>
</body>
<!------------------------------------------------------------------------------------------>
<gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" text="" styles='display:none' />
<gw:textbox id="txt_PopType" text="" styles='display:none' />
<!------------------------------------------------------------------------------->
<%--<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />--%>
<!-------------------------------MAC DINH HAI QUAN & MA SO DOANH NGHIEP ------------------->
<gw:textbox id="txtHCom_Pk" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Code" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Name" styles='display:none;width:100%' />
<gw:textbox id="txtHCom_Id" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Pk" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Code" styles='display:none;width:100%' />
<gw:textbox id="txtHCus_Name" styles='display:none;width:100%' />
<!------------------------------------------------------------------------------------------>
</html>
