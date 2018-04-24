<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head id="Head1" runat="server">
    <title>Export Invoice Entry</title>
</head>

<script>

   var user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
   var user_name  = "<%=Session("USER_NAME")%>" ;

var flag;
      
var G_DETAIL_PK     = 0,
    G_MASTER_PK    	= 1,
    G_SEQ       	= 2,
    G_REF_NO 		= 3,     
    G_ITEM_PK   	= 4,
    G_ITEM_CODE 	= 5,
    G_ITEM_NAME 	= 6, 
    G_SPEC01_NM 	= 7,    
    G_SPEC02_NM 	= 8,    
    G_SPEC03_NM 	= 9, 
    G_SPEC04_NM 	= 10,   
    G_SPEC05_NM 	= 11,
	G_ITEM_DESC 	= 12,
	G_CUST_ITEM		= 13,
    G_HS_CODE   	= 14,        
    G_UOM    		= 15,
	G_INV_QTY		= 16,    
    G_UPRICE    	= 17,
    G_ITEM_AMOUNT   = 18,
	G_CARTON_QTY	= 19,
	G_NET_WEIGHT	= 20,
	G_GROSS_WEIGHT	= 21,
	G_VOLUME		= 22,
    G_SO_D_PK   	= 23,
	G_TABLE_PK		= 24,
	G_TABLE_NAME	= 25,
    G_REMARK    	= 26;
       
var arr_FormatNumber  = new Array();

var detail_row = 0 ;
 
//=========================================================================  
      
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        //--------------------------------------         
        txtStaffID.SetEnable(false);
        txtStaffName.SetEnable(false);
        txtCustID.SetEnable(false);
        txtCustName.SetEnable(false);
        txtShipToID.SetEnable(false);
        txtShipToName.SetEnable(false);
        txtPaidToID.SetEnable(false);
        txtPaidToName.SetEnable(false); 
        txtCarrierName.SetEnable(false); 
        txtNotifyName.SetEnable(false);
        //--------------------------------------
        OnChangeTab();
        
        OnToggleGrid();
        //--------------------------------------
        BindingDataList();
        //--------------------------------------
        OnAddNew('Master');    
       //--------------------------------------
                         
    }
   
//=========================================================================  
      
 function BindingDataList()
 {   
      var data = "" ;
      
      data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
      lstCompany.SetDataText(data);
      
      data = "<%=ESysLib.SetListDataSQL("SELECT   pk, type_name FROM tlg_pa_packing_type a WHERE del_if = 0 ORDER BY type_code" ) %>|| ";       
      lstPackingType.SetDataText(data);      
          
      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL")%>";  
      lstTrCCY.SetDataText(data);
      lstPayCCY.SetDataText(data);
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0250') FROM DUAL")%>"; 
      lstDeliMethod.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0230') FROM DUAL")%>"; 
      lstDomesticPort.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0240') FROM DUAL")%>"; 
      lstOverSeaPort.SetDataText(data); 

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL")%>"; 
      lstPriceType.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0110') FROM DUAL")%>"; 
      lstPaymentMethod.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0120') FROM DUAL")%>"; 
      lstPaymentTerm.SetDataText(data);

      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0150') FROM DUAL")%>"; 
      lstDiscountRate.SetDataText(data); 
      
      data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('IEBS0010') FROM DUAL")%>"; 
      lstLCBank.SetDataText(data);
                 
      var ctr = grdDetail.GetGridControl(); 
	  
      ctr.ColFormat(G_INV_QTY) 		= "#,###,###,###,###,###.##";       
      ctr.ColFormat(G_UPRICE)     	= "#,###,###,###,###,###.#####";
      ctr.ColFormat(G_ITEM_AMOUNT)  = "#,###,###,###,###,###.##";
	  
	  ctr.ColFormat(G_CARTON_QTY)  	= "#,###,###,###,###,###";
	  ctr.ColFormat(G_NET_WEIGHT)  	= "#,###,###,###,###,###.##";
	  ctr.ColFormat(G_GROSS_WEIGHT) = "#,###,###,###,###,###.##";
	  ctr.ColFormat(G_VOLUME)  		= "#,###,###,###,###,###.##";
      
      arr_FormatNumber[G_INV_QTY] 		= 2; 
      arr_FormatNumber[G_UPRICE]     	= 5;
      arr_FormatNumber[G_ITEM_AMOUNT]   = 2;   

	  arr_FormatNumber[G_CARTON_QTY]   = 0;
	  arr_FormatNumber[G_NET_WEIGHT]   = 2;
	  arr_FormatNumber[G_GROSS_WEIGHT] = 2;
	  arr_FormatNumber[G_VOLUME]       = 2;	  
                                    
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
                
                data_epex00030.Call();
            }
        break;        
        
        case 'Detail':        
            data_epex00030_1.Call();
        break;
        
        case 'Items' :
            data_epex00030_2.Call();
        break;
		
        case 'Item_ex':
            if(txtMasterPK.text=="")
            {
                alert("Please choose one invoice");
            }
            else
            {
                data_epex00030_item_ex.Call();
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
            
            data_epex00030.StatusInsert();             
                     
            //-----------------------------------------------
            txtStaffPK.text   = user_pk ; 
            txtStaffName.text = user_name ;           
            
            txtInvoiceNo.text = '<< New Invoice >>';

			txtGoodsDesc.SetDataText("DORCO RAZOR AND BLADE"); 
			txtManufactureMarks.SetDataText("40D X 2"); 	
			
            grdDetail.ClearData();
            //-----------------------------------------------            
        break;
        
		case 'GDREQ':
            var fpath = System.RootURL + "/form/ep/ex/epex00036.aspx"; //search contract
            
            object = System.OpenModal( fpath , 1250 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, 	txtMasterPK.text );
                    grdDetail.SetGridText( grdDetail.rows-1, G_REF_NO, 		data[3] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, 		grdDetail.rows-1 );
					
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    	data[4]			 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  	data[5] 		 );									
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  	data[6] 		 ); 
					
					grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_DESC,   data[7] 		 );
					grdDetail.SetGridText( grdDetail.rows-1, G_CUST_ITEM,   data[8] 		 ); 					
					
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM,  		data[9] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY, 	data[11] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE,  	data[12] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_AMOUNT, data[13] 		 );  
					grdDetail.SetGridText( grdDetail.rows-1, G_SO_D_PK, 	data[17] 		 );         					
					grdDetail.SetGridText( grdDetail.rows-1, G_TABLE_PK, 	data[0] 		 );
					grdDetail.SetGridText( grdDetail.rows-1, G_TABLE_NAME, 	'TLG_GD_REQ_D'   );
                }
             }                               
        break; 
		
        case 'GDItem':
            var fpath = System.RootURL + "/form/ep/ex/epex00035.aspx"; //search contract
            
            object = System.OpenModal( fpath , 900 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, 		txtMasterPK.text );
                    grdDetail.SetGridText( grdDetail.rows-1, G_REF_NO, 	data[0] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, 		grdDetail.rows-1 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    	data[1]			 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  	data[2] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  	data[3] 		 ); 
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM,  	data[4] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY, 	data[6] 		 );
                    grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE,  	data[5] 		 );
                             
                }
             }                               
        break; 
        
        case 'POItem':
            var fpath = System.RootURL + "/form/ep/ex/epex00032.aspx"; //search contract
            
            object = System.OpenModal( fpath , 900 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, txtMasterPK.text );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_SO_D_PK,   data[1] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_REF_NO, data[0] );

                    grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, grdDetail.rows-1 );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_ST_ITEM_PK, data[3] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,    data[4] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE,  data[5] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME,  data[6] ); 
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC01_PK, data[7]  );                              
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC01_NM, data[8]  );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC02_PK, data[9]  );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC02_NM, data[10] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC03_PK, data[11] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC03_NM, data[12] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC04_PK, data[13] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC04_NM, data[14] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC05_PK, data[15] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_SPEC05_NM, data[16] );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_HS_CODE, data[17] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_UOM,  data[18] );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY, data[19] );
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE,  data[20] );
                    grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_AMOUNT,  data[21] );                     
                }
             }                               
        break;            
        
        case 'FreeItem':
            var fpath = System.RootURL + "/form/ep/ex/epex00034.aspx?group_type=2"; //search contract
            
            object = System.OpenModal( fpath , 1000 , 600, 'resizable:yes;status:yes', this); 
            
            if ( object != null )
            { 	            
                //-----------------                  
                for ( var i=0; i< object.length; i++)
                {
                    
                    data = object[i];
                    
                    grdDetail2.AddRow();
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_TEX_CO_INV_MST_PK, txtMasterPK.text );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_SEQ, grdDetail2.rows-1 );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_TIE_ITEM_PK,    data[0] );
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_ITEM_CODE,  data[1] );
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_ITEM_NAME,  data[2] );                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_HS_CODE, data[4] );
                    
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_UOM_01, data[3] );                                        
                    grdDetail2.SetGridText( grdDetail2.rows-1, G2_UOM_02, data[3] ); 
                    
                }
             }                       
        break;   

		case 'SALEORDER':			 
			 if ( txtCustPK.text == '' )
			 {
			 	alert("PLS SELECT THE CUSTOMER FIRST !!!");
			 	return;
			 }
			 
			 var path = System.RootURL + '/form/ep/ex/epex00038.aspx';
             var object = System.OpenModal( path ,1250 , 600 ,  'resizable:yes;status:yes',this);
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G_SEQ, grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G_REF_NO,  arrTemp[1] );//SO ITEM NO
                        grdDetail.SetGridText( grdDetail.rows-1, G_SO_D_PK, arrTemp[17]);//SO D PK	

						grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK,   arrTemp[2]);//req_pk    						
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE, arrTemp[3]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME, arrTemp[4]);//item_name
						
						grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_DESC, arrTemp[5]);//item_name
                        grdDetail.SetGridText( grdDetail.rows-1, G_CUST_ITEM, arrTemp[6]);//item_name
						 
						grdDetail.SetGridText( grdDetail.rows-1, G_UOM,	arrTemp[7]);
						
                        grdDetail.SetGridText( grdDetail.rows-1, G_INV_QTY, 	arrTemp[15] ); 							    
						grdDetail.SetGridText( grdDetail.rows-1, G_UPRICE, 		arrTemp[9]  );  
						grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_AMOUNT, arrTemp[10] );    
						
						grdDetail.SetGridText( grdDetail.rows-1, G_REMARK, arrTemp[18]); 
						
						grdDetail.SetGridText( grdDetail.rows-1, G_TABLE_PK, 	arrTemp[17] 		 );
						grdDetail.SetGridText( grdDetail.rows-1, G_TABLE_NAME, 	'TLG_SA_SALEORDER_D' );
						
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
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G_ITEM_AMOUNT));
    }

    txtTrAmount.text = sumAmount.toFixed(2)+"";
} 

//=========================================================================        

function CheckInput(obj)
{   
    switch(obj.id)
    {
        case 'grdDetail':
        
            var col, row
            
            col = event.col
            row = event.row  
            
            if ( col == G_INV_QTY || col == G_UPRICE || col == G_ITEM_AMOUNT || col == G_CARTON_QTY || col == G_NET_WEIGHT || col == G_GROSS_WEIGHT || col == G_VOLUME )
            {
                var dQuantiy ;
                
                dQuantiy =  grdDetail.GetGridData(row,col) ;
                
                if (Number(dQuantiy))
                {   
                    if (dQuantiy >0)
                    {
                        grdDetail.SetGridText( row, col, System.Round(dQuantiy,arr_FormatNumber[col]));
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
                if ( col == G_INV_QTY || col == G_UPRICE )
                {
                    var dAmount;
                    
                    
					
                        dAmount = Number(grdDetail.GetGridData( row, G_INV_QTY )) * Number(grdDetail.GetGridData( row, G_UPRICE )) ;
                    
					
                     
                    grdDetail.SetGridText( row, G_ITEM_AMOUNT, System.Round(dAmount,arr_FormatNumber[G_ITEM_AMOUNT]) ) ;
                }
                //------------------------        
                TotalAmount();
            }
        break;                             
    }    
}
   
//=========================================================================   
     
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case "data_epex00030" :
                if ( flag == 'save')
                {
                    for(var i=0; i < grdDetail.rows;i++)
                    {
                        if ( grdDetail.GetGridData( i, G_MASTER_PK) == '' )
                        {
                            grdDetail.SetGridText( i, G_MASTER_PK, txtMasterPK.text);
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
            
            case "data_epex00030_1" :
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBold( 1, G_ITEM_CODE,   grdDetail.rows - 1, G_ITEM_CODE,   true);                    
                    grdDetail.SetCellBold( 1, G_INV_QTY, 	 grdDetail.rows - 1, G_INV_QTY,     true);                     
                    grdDetail.SetCellBold( 1, G_ITEM_AMOUNT, grdDetail.rows - 1, G_ITEM_AMOUNT, true);
                }                                                             
            break;
			
            case "data_epex00030_2":
                {
                    if ( flag == 'save')
                    {
                        OnSave('item_ex');
                        flag = '' ;
                    }
                    else
                    {
                        OnSearch('item_ex');
                    }       
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
                 else if ( txtLGGroupCodeID.text == 'LGCM0100')
                 {
                    lstTrCCY.SetDataText(txtLGCodeList.text);
                    lstTrCCY.value = rtnLGCode;
                    lstPayCCY.SetDataText(txtLGCodeList.text);  
                    lstPayCCY.value = rtnLGCode;                     
                 }                                                                                                          
             break; 
             
             case 'pro_epex00030' :
              
               var path = System.RootURL + '/form/ds/ep/dsep00070.aspx?income_pk=' + txtReturnValue.text;
	           var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:1000px;dialogHeight:600px');
                
             break;    
             
             case 'pro_epex00030_1' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epex00030_2' :
                alert(txtReturnValue.text);
                
                OnSearch('Master');
             break;  
             
             case 'pro_epex00030_3' :
                alert(txtReturnValue.text);
             break; 
             
             case 'pro_epex00030_4' : 
                OnSearch('Items');
             break; 
			 
			 case 'pro_epex00030_5' : 			 			
                alert('Copy finish !!!');
				
				OnSearch('Master');
             break;
             
             case 'data_epex00030_2' :
                txtItemDesc.text = '';
                
                if ( grdDetail.rows > 1 )
                {
                    grdDetail.SetCellBold( 1, G_ITEM_CODE,   grdDetail.rows - 1, G_ITEM_CODE,   true);					
                    grdDetail.SetCellBold( 1, G_INV_QTY,     grdDetail.rows - 1, G_INV_QTY,     true);                                          
                    grdDetail.SetCellBold( 1, G_ITEM_AMOUNT, grdDetail.rows - 1, G_ITEM_AMOUNT, true);
                }                
             break;     
			 
             case 'pro_epex00030_merce' :   
                data_epex00030_item_ex.Call("SELECT");
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
                    data_epex00030.StatusDelete();
                    data_epex00030.Call();
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
    }
}
//========================================================================= 
function OnUnDelete(index)
{
	grdDetail.UnDelete();
}
//========================================================================= 
       
function ValidateData(index)
{
    switch(index)
    {
        case 'Master' :
            if ( txtCustPK.text == '' )
            {
                alert("You must input Customer!");
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
        case 'PackingList':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
            
            if ( confirm('Do you want to generate Packing List?') )
            {
                pro_epex00030.Call();
            }
        break;
        
        case 'Confirm':
            if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
                    
            if ( confirm('Do you want to confirm this Invoice ?') )
            {
                pro_epex00030_1.Call();                
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
                pro_epex00030_2.Call();                
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

		case 'Copy':
			if ( txtMasterPK.text == '' )
            {
                alert('Pls select one Invoice.');
                return;
            }
                    
            if ( confirm('Do you want to copy this Invoice ?') )
            {
                pro_epex00030_5.Call();                
            }        
		break;
    }    
}    

//===================================================================================   

function OnReport(pos)
{
    switch (pos)
    {
        case 'DORCO_1' :        
                                
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_SALE.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
             
        break;
        
        case 'DORCO_2' :        
                          
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_CI.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
            
        break; 

		case 'DORCO_3' :        
                          
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_PL.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
            
        break; 	

		case 'DORCO_4' :        
		
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_BK_1.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
            
        break; 

		case 'DORCO_5' :        
		
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_BK_2.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
            
        break;

		case 'DORCO_6' :        
		
                  var url =System.RootURL + "/reports/ep/ex/rpt_epex00030_DORCO_ED.aspx?p_master_pk="+txtMasterPK.text ;
	              System.OpenTargetPage(url);
            
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
            document.all("Tab_Description").style.display      = "none";
		    
            document.all("Invoice_Info").style.color     = "red"; 
            document.all("Shipment_Payment").style.color = "";
            document.all("Description").style.color      = ""; 
        break;
        
        case '2':
            document.all("Tab_Invoice_Info").style.display     = "none";
            document.all("Tab_Shipment_Payment").style.display = "";
            document.all("Tab_Description").style.display      = "none"; 
		    
            document.all("Invoice_Info").style.color     = ""; 
            document.all("Shipment_Payment").style.color = "red";
            document.all("Description").style.color      = "";       
        break;	
        
        case '3':
            document.all("Tab_Invoice_Info").style.display     = "none";
            document.all("Tab_Shipment_Payment").style.display = "none";
            document.all("Tab_Description").style.display      = "";
		    
            document.all("Invoice_Info").style.color     = ""; 
            document.all("Shipment_Payment").style.color = "";
            document.all("Description").style.color      = "red";         
        break;        
    } 

 }
 
//===================================================================================

function OnSearch(pos)
{
    switch(pos)
    {
        case 'Invoice':
            var fpath = System.RootURL + "/form/ep/ex/epex00031.aspx"; //search contract
            
            aValue = System.OpenModal( fpath , 1050 , 600, 'resizable:yes;status:yes');
            
            if ( aValue != null )
            {   
                txtMasterPK.SetDataText(aValue[0]); 
                
                OnSearch('Master');
            }            
        break;
        
        case 'Master':
            data_epex00030.Call("SELECT");
        break;
        
        case 'Detail':
            data_epex00030_1.Call("SELECT");
        break;
        
        case 'Items':
            data_epex00030_2.Call("SELECT");
        break;      
        case 'item_ex':
            data_epex00030_item_ex.Call("SELECT");
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

        case 'Customer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtCustPK.text   = object[0];
	            txtCustID.text   = object[1];
                txtCustName.text = object[2]; 
                
                lstPaymentMethod.value = object[34];
                lstPaymentTerm.value   = object[35]; 
                
                if ( txtShipToPK.text == '' )
                {
	                txtShipToPK.text   = object[0];
	                txtShipToID.text   = object[1];
                    txtShipToName.text = object[2];

                    txtShipAdd.SetDataText(object[37]);                              
                }            
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
             var path = System.RootURL + "/form/fp/ab/fpab00180.aspx?partner_pk=" + txtShipToPK.text + "&partner_id=" + txtShipToID.text + "&partner_name=" + txtShipToName.text;
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtCarrierPK.text   = object[0];	            
                txtCarrierName.text = object[4];  
				 
				txtCarrierDesc.SetDataText(object[13]); 								
	         }
        break;  
        
        case 'Notify' :
             var path = System.RootURL + "/form/fp/ab/fpab00180.aspx?partner_pk=" + txtPaidToPK.text + "&partner_id=" + txtPaidToID.text + "&partner_name=" + txtPaidToName.text;
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtNotifyPK.text   = object[0];	            
                txtNotifyName.text = object[4];  

				txtNotifyDesc.SetDataText(object[13]); 					
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

		case 'Detail' :
			 var row  = event.row;
	         var col  = event.col;
			 
			 if ( col == G_ITEM_DESC && row != 0 && grdDetail.GetGridData( row, G_ITEM_PK) > 0 )   
			 {
			 		if ( txtCustPK.text == '' )
					{
						alert("PLS SELECT CUSTOMER !");
						return;
					}
								 
                	var path = System.RootURL + '/form/ep/ex/epex00039.aspx';
	            	var obj = System.OpenModal( path , 600 , 300 , 'resizable:yes;status:yes', this);	
				
	            	if ( obj != null )
	            	{
	                	grdDetail.SetGridText( row, G_ITEM_DESC, obj);
	            	}                              			 
			 }
		break;
		
		case 'Report':			 
			if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/ep/ex/epex00037.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
 	        }
	        else
	        {
		        alert("Please, select one slip no to print!");
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

		grdDetail.GetGridControl().ColHidden(G_SPEC01_NM) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_NM) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_NM) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_NM) = true ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_NM) = true ;
		grdDetail.GetGridControl().ColHidden(G_HS_CODE)   = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G_SPEC01_NM) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC02_NM) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC03_NM) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC04_NM) = false ;
		grdDetail.GetGridControl().ColHidden(G_SPEC05_NM) = false ;
		grdDetail.GetGridControl().ColHidden(G_HS_CODE)   = false ;		
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}  

//===================================================================================

 function OnChangePriceBy()
{
    var dAmount = 0 ;
    
 
        for(var i=1 ; i<grdDetail.rows; i++)
        {
            dAmount = Number(grdDetail.GetGridData( i, G_INV_QTY )) * Number(grdDetail.GetGridData( i, G_UPRICE )) ;
            grdDetail.SetGridText( i, G_ITEM_AMOUNT, System.Round(dAmount,arr_FormatNumber[G_ITEM_AMOUNT])) ;            
        }
           
    //--------------
    TotalAmount();     
}
 
//===================================================================================
  
 function getExRate(p_param)
 {
    if(p_param =='ICCY')
    {
        dat_epex00030_5.Call()
    }
    if(p_param =='PCCY')
    {
        dat_epex00030_6.Call()
    }
    
 }
 
//====================================================================

function CellOnClick()
{
    if ( grdDetail.row > 0 )
    { 
		detail_row = grdDetail.row;
		
        txtItemDesc.SetDataText( grdDetail.GetGridData( grdDetail.row, G_ITEM_DESC ));
    }    
}

//===================================================================================
  
 function TextOnBlur()
 {     		
    grdDetail.SetGridText( detail_row, G_ITEM_DESC, txtItemDesc.GetData() );      
 }
 
//====================================================================

</script>

<body>
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
    <gw:data id="data_epex00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66" function="<%=l_user%>lg_sel_epex00030"  procedure="<%=l_user%>lg_upd_epex00030"> 
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
                     <inout  bind="txtCustPK" />
                     <inout  bind="txtCustID" />               
                     <inout  bind="txtCustName" /> 
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
                                   
                     <inout  bind="txtCarrierName" />
                     <inout  bind="txtCarrierDesc" />               
                     <inout  bind="txtNotifyPK" />
                      
                     
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
                     <inout  bind="dtLCDate" />
                     <inout  bind="lstLCBank" />
                     <inout  bind="dtLCExpiryDate" />
                     
                     <inout  bind="lstPaymentMethod" />
                     <inout  bind="lstPayCCY" />
                     <inout  bind="lbBookCCY02" />                     
                     <inout  bind="txtPayExRate" />                     
                     <inout  bind="lstPaymentTerm" />
                     <inout  bind="lstDiscountRate" />
                     <inout  bind="txtDiscAmount" />
                     <inout  bind="txtBankAccount" />
                     <inout  bind="txtGoodsDesc" />                                          
                     <inout  bind="txtManufactureMarks" />
                     
                     <inout  bind="txtLCMarks" />
                     <inout  bind="txtPackingMarks" />
                     <inout  bind="txtCartonNumber" />
                     <inout  bind="txtContainerNumber" />
                     <inout  bind="txtInvoiceRemarks" />                        
                     
                     <inout  bind="txtBankMemo" />
                     <inout  bind="lstPackingType" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <gw:data id="data_epex00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function="<%=l_user%>lg_sel_epex00030_1"   procedure="<%=l_user%>lg_upd_epex00030_1"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>     
    <!---------------------------------------------------------------->
    <gw:data id="pro_epex00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030" > 
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
    <gw:data id="pro_epex00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030_1" > 
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
    <gw:data id="pro_epex00030_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030_2" > 
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
    <gw:data id="pro_epex00030_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030_3" > 
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
    <gw:data id="pro_epex00030_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030_4" > 
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
    <gw:data id="pro_epex00030_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_epex00030_5" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>	
    <!-------------------------------get exrate----------------------------------------------->
    <gw:data id="dat_epex00030_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_get_exch_rate_S" > 
                <input>   
                    <input bind="dtInvoiceDate" />
                    <input bind="lstTrCCY" />
                </input> 
                <output>
                    <output bind="txtTrExRate" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------get payment exrate----------------------------------------------->
    <gw:data id="dat_epex00030_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_get_exch_rate_S" > 
                <input>   
                    <input bind="dtInvoiceDate" />
                    <input bind="lstPayCCY" />
                </input> 
                <output>
                    <output bind="txtPayExRate" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td style="width: 30%; white-space: nowrap" align="center" colspan="10">
                <table style="width: 100%; height: 100%; background-color: CCFFFF">
                    <tr>
                        <td style="width: 96%" align="left">
                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                <span value="1" id="Invoice_Info">Invoice Info</span> 
                                <span value="2" id="Shipment_Payment">Shipment Payment</span> 
                                <span value="3" id="Description">Description</span>
                            </gw:radio>
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
                        <td style="width: 1%">
                            <!-- <gw:icon id="btnGenPackingList" img="2" text="Packing List" onclick="OnProcess('PackingList')" />  -->
                        </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                             </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                          
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExcel" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
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
                <gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="OnProcess('Copy')" />
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
                                            <a title="Customer" onclick="OnPopUp('Customer')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Customer</a></td>
                                        <td style="width: 95%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtCustPK" text="" styles='display:none' />
                                            <gw:textbox id="txtCustID" text="" styles='width:30%;' csstype="mandatory" />
                                            <gw:textbox id="txtCustName" text="" styles='width:70%;' csstype="mandatory" />
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
                                            <gw:datebox id="dtInvoiceDate" lang="1" onchange="returnExRate();" />
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
                                            <gw:list id="lstTrCCY" styles="width:100%;" onchange="getExRate('ICCY');"></gw:list>
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
                                         
                                        </td>
                                        <td style="width: 45%" colspan="2">
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
                    <tr style="height: 1%">
                        <td colspan="2">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="left" style="width: 1%">
                                                    <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                                        style="cursor: hand" onclick="OnToggleGrid()" />
                                    </td>
                                    <td style="width: 69%">
                                    </td>
                                    <td align="right" style="width: 10%">
                                    </td>
                                    <td style="width: 16%">                                         
                                    </td>
									<td style="width: 1%">                                       
										<gw:icon id="idBtnREQ" img="2" text="GD/REQ" styles='width:100%' onclick="OnAddNew('GDREQ')" />
                                    </td>
                                    <td style="width: 1%">                                         
										<gw:icon id="idBtnSaleOrder" img="2" text="S/ORDER" styles='width:100%' onclick="OnAddNew('SALEORDER')" />
                                    </td>
                                    <td style="width: 1%">
                                        <!-- <gw:imgbtn id="btnFreeItem" img="popup" alt="Free Item" text="Free Item" onclick="OnAddNew('FreeItem')" /> -->
                                    </td>
                                    <td style="width: 1%">
                                        <!-- <gw:imgbtn id="btnPOItem" img="popup" alt="P/O Item" text="P/O Item" onclick="OnAddNew('POItem')" /> -->
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDel2" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
									 <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDel2" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 72%">
                        <td colspan="2">
							<gw:grid id='grdDetail' 
								header='_PK|_MST_PK|Seq|Ref No|_ITEM_PK|Item Code|Item Name|-|-|-|-|-|Item Desc|Virtual Code|HS Code|UOM|Inv Qty|U/Price|Item Amount|Carton Qty|Net Weight|Gross Weight|Volume|_SO_D_PK|_TABLE_PK|_TABLE_NAME|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|1|1|3|3|3|3|3|3|3|0|0|0|0'
                                editcol='0|0|1|1|0|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|0|0|0|1' 								          
								widths='0|0|500|1500|0|2000|4000|1000|1000|1000|1000|1000|1500|1500|1000|800|1500|1500|1500|1500|1500|1500|1500|0|0|0|1000'								                     
                                sorting='T' styles='width:100%; height:100%' 
								onclick="CellOnClick()"
								onafteredit="CheckInput(this)" 
								oncelldblclick="OnPopUp('Detail')" />											                                                                                                                                                                     
                        </td>
                    </tr>
                    <tr style="height: 26%" id="tab_ItemDesc">
                        <td colspan="2">
                            <gw:textarea id="txtItemDesc" styles="width:100%;height:95%" onblur="TextOnBlur()" />
                        </td>
                    </tr>                
                </table>
                <table id="Tab_Shipment_Payment" style="width: 100%; height: 100%">
                    <tr valign="top">
                        <td style="width: 48%">
                            <fieldset style="padding: 5">
                                <legend style="color: Gray">&nbsp;&nbsp;&nbsp;Shipment Information&nbsp;&nbsp;&nbsp;</legend>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 10%; white-space: nowrap">
                                            <a title="Ship To" onclick="OnPopUp('ShipTo')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Ship To</a></td>
                                        <td style="width: 90%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtShipToPK" styles="display:none" />
                                            <gw:textbox id="txtShipToID" csstype="mandatory" styles="width:30%;" />
                                            <gw:textbox id="txtShipToName" csstype="mandatory" styles="width:70%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="3">
                                            <gw:textarea id="txtShipAdd" csstype="mandatory" rows="5" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a title="Deli Method" onclick="OnPopUp('DeliMethod')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Deli Method</b></a></td>
                                        <td colspan="3">
                                            <gw:list id="lstDeliMethod" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            ETD</td>
                                        <td style="white-space: nowrap" colspan="3">
                                            <gw:datebox id="dtETDFrom" lang="1" onchange="" styles="width:100%;" acceptnulldate="T" />
                                            ~
                                            <gw:datebox id="dtETDTo" lang="1" onchange="" styles="width:100%;" acceptnulldate="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            ETA</td>
                                        <td style="white-space: nowrap" colspan="3">
                                            <gw:datebox id="dtETAFrom" lang="1" onchange="" styles="width:100%;" acceptnulldate="T" />
                                            ~
                                            <gw:datebox id="dtETATo" lang="1" onchange="" styles="width:100%;" acceptnulldate="T" />
                                        </td>
                                    </tr>
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
                                            <gw:datebox id="dtShipDate" lang="1" styles='width:100%;' acceptnulldate="T" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            Packing Type</td>
                                        <td colspan="3">
                                            <gw:list id="lstPackingType" csstype="mandatory" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Domestic Port" onclick="OnPopUp('DomesticPort')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Domestic Port</b></a></td>
                                        <td colspan="3">
                                            <gw:list id="lstDomesticPort" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Oversea Port" onclick="OnPopUp('OverSeaPort')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Oversea Port</b></a></td>
                                        <td colspan="3">
                                            <gw:list id="lstOverSeaPort" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <a title="Price Type" onclick="OnPopUp('PriceType')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Price Type</b></a></td>
                                        <td colspan="3">
                                            <gw:list id="lstPriceType" styles="width:100%;"></gw:list>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%">
                                            <a title="Carrier" onclick="OnPopUp('Carrier')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Carrier</b></a></td>
                                        <td style="width: 90%; white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtCarrierPK" styles="width:30%;display:none" />                                             
                                            <gw:textbox id="txtCarrierName" styles="width:100%;" />
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
                            </fieldset>
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 48%">
                            <fieldset style="padding: 5">
                                <legend style="color: Gray">&nbsp;&nbsp;&nbsp;Payment Information&nbsp;&nbsp;&nbsp;</legend>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="width: 10%">
                                            <a title="Bill To" onclick="OnPopUp('PaidTo')" href="#tips" style="text-decoration: none;
                                                color=#0000ff">Paid by</a>
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
                                            <gw:textarea id="txtPaidAdd" csstype="mandatory" rows="5" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%">
                                            L/C No.</td>
                                        <td style="width: 40%">
                                            <gw:textbox id="txtLCNo" styles="width:100%;" />
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            L/C Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtLCDate" lang="1" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%">
                                            <a title="Payment Method" onclick="OnPopUp('LCBank')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Issue Bank</b></a>
                                        </td>
                                        <td style="width: 40%">
                                            <gw:list id="lstLCBank" styles="width:100%;"></gw:list>
                                        </td>
                                        <td style="width: 10%; white-space: nowrap">
                                            L/C Expiry Date</td>
                                        <td style="width: 40%">
                                            <gw:datebox id="dtLCExpiryDate" lang="1" styles='width:100%;' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10%">
                                            Bank Memo
                                        </td>
                                        <td colspan="3">
                                            <gw:textarea id="txtBankMemo" rows="2" styles="width:100%;" />
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
                                            <gw:list id="lstPayCCY" styles="width:100%;" onchange="getExRate('PCCY');"></gw:list>
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
                                        <td style="width: 10%">
                                            <a title="Notify" onclick="OnPopUp('Notify')" href="#tips" style="text-decoration: none;
                                                color=#0000ff"><b>Notify</b></a></td>
                                        <td style="white-space: nowrap" colspan="3">
                                            <gw:textbox id="txtNotifyPK" styles="display:none" />                                            
                                            <gw:textbox id="txtNotifyName" styles="width:100%;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan="3">
                                            <gw:textarea id="txtNotifyDesc" rows="5" styles="width:100%;" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table id="Tab_Description" style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            Goods Remark</td>
                        <td style="width: 90%; white-space: nowrap" colspan="3">
                            <gw:textarea id="txtGoodsDesc" styles="width:100%;" rows="5" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            Manufacture Remark</td>
                        <td colspan="3">
                            <gw:textarea id="txtManufactureMarks" styles="width:100%;" rows="5" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            LC Marks</td>
                        <td colspan="3">
                            <gw:textarea id="txtLCMarks" styles="width:100%;" rows="5" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            Packing Marks</td>
                        <td colspan="3">
                            <gw:textarea id="txtPackingMarks" styles="width:100%;" rows="5" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            Carton Number</td>
                        <td>
                            <gw:textbox id="txtCartonNumber" styles="width:100%;" type="number" format="#,###,###,###,###R" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Container Number</td>
                        <td>
                            <gw:textbox id="txtContainerNumber" styles="width:100%;" type="number" format="#,###,###,###,###R" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap">
                            Invoice Remarks</td>
                        <td colspan="3">
                            <gw:textarea id="txtInvoiceRemarks" styles="width:100%;" rows="5" />
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
