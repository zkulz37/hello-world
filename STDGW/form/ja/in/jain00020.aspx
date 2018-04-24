<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>P/O ENTRY</title>
</head>
<%  ESysLib.SetUser("PROD")%>

<script>

var flag;
//======================================================================
var G_PK         = 0 ;

var G1_1         = 0,
    G1_PO_D_PK   = 1,
    G1_Seq       = 2,
    
    G1_Req_Item_PK   = 3,
    G1_Req_Item_Code = 4,
    G1_Req_Item_name = 5,
    G1_PO_ITEM_PK    = 6,
    G1_PO_Item_Code  = 7,
    G1_PO_Item_Name  = 8,
    
    G1_PO_Qty_1  = 9,
    G1_UOM_1     = 10,
    G1_PO_Qty_2  = 11,
    G1_UOM_2     = 12,
    G1_UPrice    = 13,
    G1_PO_Amt    = 14,
    G1_VAT_Rate  = 15,
    G1_VAT_Amount  = 16,
    G1_Total_Amt = 17,
    G1_ETD_From  = 18,
    G1_ETD_To    = 19,
    G1_ETA_From  = 20,
    G1_ETA_To    = 21,
    G1_MR_Qty    = 22,
    G1_MR_No     = 23,
    G1_Remark    = 24,
    G1_PR_D_PK   = 25,
    G1_2         = 26,
    G1_3         = 27,
    G1_PO_M_PK   = 28; 
    
var rtnLGCode = '' ;
//======================================================================

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//======================================================================

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;      
    //----------------------------------            
    
    txtPONo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtDeliverName.SetEnable(false);
    txtShipToName.SetEnable(false);
    txtSupplierName.SetEnable(false);
    txtDeliverName.SetEnable(false);
    txtBillToName.SetEnable(false); 
    txtPLName.SetEnable(false);
    //---------------------------------- 
               
    FormFormat();
    
    OnChangeTab();
    OnToggleGrid();
    //------------------------- 
    OnAddNew('Master');  
}
//======================================================================

 function FormFormat()
 {      
     var data ;
     
     //----------------------- 
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0140') FROM DUAL")%>||";  //tradding 
     lstPOType.SetDataText(data);
     lstPOType.value = '' ;
     //----------------------- 
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0110') FROM DUAL")%>||";  //payment form
     lstPaymentMethod.SetDataText(data);
     lstPaymentMethod.value = '' ;  
     //----------------------- 
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0120') FROM DUAL")%>||";  //payment term
     lstPaymentTerm.SetDataText(data);
     lstPaymentTerm.value = '' ; 
     //----------------------- 
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);
     lstCurrency.value = "USD";   
     //----------------------- 
     data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0130') FROM DUAL" )%>||";    
     lstPriceType.SetDataText(data);
     lstPriceType.value = '';
     
     //-----------------------
     data ="data|1|P/O Qty 1"
     lstPriceBy.SetDataText(data);  
     lstPriceBy.value = 1; 
     
     //-----------------------
     var ctr = grdDetail.GetGridControl(); 
    
     ctr.ColFormat(G1_PO_Qty_1) = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_PO_Qty_2) = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_MR_Qty)   = "#,###,###,###,###,###.##";
     
     ctr.ColFormat(G1_UPrice)    = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_PO_Amt)    = "#,###,###,###,###,###.##";     
     ctr.ColFormat(G1_VAT_Rate)  = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_Total_Amt) = "#,###,###,###,###,###.##";  
     ctr.ColFormat(G1_VAT_Amount) = "#,###,###,###,###,###.##";
     
 }
//======================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text    = obj[2];
                txtStaffPK.text  = obj[0];
            }
        break;         

        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
                txtSupplierName.text = object[2]; 
                
                lstPaymentMethod.value = object[34];
                lstPaymentTerm.value    = object[35];
                lstPOType.value      = object[36];              
	         }
        break;
                
        case 'Deliver' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtDeliverPK.text   = object[0];
                txtDeliverName.text = object[2];                
	         }
        break;
                
        case 'Bill_To' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtBillToPK.text   = object[0];
                txtBillToName.text = object[2];  
	         }
        break;
        
        case 'Ship_To' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtShipToPK.text   = object[0];
                txtShipToName.text = object[2];  
	         }
        break;
        
        case 'PLCenter': // PL
            fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[0]; 
                txtPLName.text = oValue[2];
            }        
        break;  
                                 
        case 'PaymentMethod':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtComCodeID.text = 'LGCM0110';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentMethod.value = object[1];      
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
	                txtComCodeID.text = 'LGCM0130';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstPriceType.value = object[1];      
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
	                txtComCodeID.text = 'LGCM0120';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentTerm.value = object[1];      
	            }    	                
	         }                              
        break;    
        
        case 'Currency':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtComCodeID.text = 'LGCM0100';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstCurrency.value = object[1];      
	            }    	                
	         }                
        break;   
                     
        case 'POType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPO2001";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtComCodeID.text = 'LGPO2001';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstPOType.value = object[1];      
	            }    	                
	         }                
        break;  
        
        case 'Carrier':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPO2002";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtComCodeID.text = 'LGPO2001';
	                rtnLGCode         = object[1];
	                
                    data_jain00020.Call("SELECT");                                
	            }
	            else
	            {
	                lstCarrier.value = object[1];      
	            }    	                
	         }                
        break;                                                                         
    }	       
}
 
//======================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_jain00020_1.StatusInsert();
            
            txtPONo.text   = '***New P/O***';
            lstPriceBy.value = 1 ;
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;

        case 'PR' :
             var path = System.RootURL + '/form/ja/in/jain00021.aspx';
             var object = System.OpenModal( path ,1000 , 550 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                    
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Seq, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Req_Item_PK,  arrTemp[7]);//item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_ITEM_PK,   arrTemp[7]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Item_Code, arrTemp[8]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Item_Name, arrTemp[9]);//item_name	
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Qty_1, arrTemp[12]);//balance qty   
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM_1,    arrTemp[13]);//item_uom  
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Qty_2, arrTemp[12]);//balance qty   
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM_2,    arrTemp[13]);//item_uom   
                                                      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PR_D_PK, arrTemp[5] );//P/R Detail PK
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MR_Qty,  arrTemp[10]);//MR Qty
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MR_No,   arrTemp[6] );//MR Seq No                           
                    }		            
             }        
        break;
                
        case 'FreeItem' :
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=||Y|Y||';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Seq, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_M_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Req_Item_PK,  arrTemp[0]);//item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Item_Code, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_PO_Item_Name, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM_1,        arrTemp[5]);//item_uom                            
                    }		            
             }        
        break;        
    }
}  

//======================================================================
function OnSearch(pos)
{  
    switch (pos)
    {
        case 'grdSearch':
            data_jain00020.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_jain00020_1.GetStatus() == 20  && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                    }
                    flag = 'view' ;
                    data_jain00020_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                flag = 'view' ;
                data_jain00020_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_jain00020_2.Call("SELECT");
        break;
    }
}

//======================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_jain00020_1": 
                   
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_PO_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_PO_M_PK, txtMasterPK.text);
                    } 
                }
                //----------------------------
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }
            
        break;
        
        case "data_jain00020_2":
	        if ( grdDetail.rows > 1 )
	        {
	            grdDetail.SetCellBold( 1, G1_PO_Item_Code, grdDetail.rows - 1, G1_PO_Item_Code,  true);
	            
                grdDetail.SetCellBold( 1, G1_PO_Qty_1, grdDetail.rows - 1, G1_PO_Qty_1, true);
                grdDetail.SetCellBold( 1, G1_PO_Qty_2, grdDetail.rows - 1, G1_PO_Qty_2, true);
                grdDetail.SetCellBold( 1, G1_UPrice,   grdDetail.rows - 1, G1_Total_Amt, true);
                
                grdDetail.SetCellBold( 1, G1_MR_No, grdDetail.rows - 1, G1_MR_No, true);
                
                grdDetail.SetCellBgColor( 1, G1_Req_Item_Code , grdDetail.rows - 1, G1_Req_Item_name , 0xCCFFFF );
                
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    if ( Number(grdDetail.GetGridData( i, G1_Req_Item_PK)) > 0 && ( grdDetail.GetGridData( i, G1_Req_Item_PK) != grdDetail.GetGridData( i, G1_PO_ITEM_PK) ) )
                    {
                        grdDetail.GetGridControl().Cell( 7, i, G1_PO_Item_Code, i, G1_PO_Item_Name ) = 0x3300cc;
                    }
                }        
                //--------------------------------
	        }   
        break;
        
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGCM0110')
             {
                lstPaymentMethod.SetDataText(txtCodeTemp.text);
                lstPaymentMethod.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0130')
             {
                lstPriceType.SetDataText(txtCodeTemp.text);  
                lstPriceType.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0120')
             {
                lstPaymentTerm.SetDataText(txtCodeTemp.text);  
                lstPaymentTerm.value = rtnLGCode;                      
             } 
             else if ( txtLGGroupCodeID.text == 'LGCM0100')
             {
                lstCurrency.SetDataText(txtCodeTemp.text);  
                lstCurrency.value = rtnLGCode;                      
             } 
             else if ( txtLGGroupCodeID.text == 'LGPO2001')
             {
                lstPOType.SetDataText(txtCodeTemp.text);  
                lstPOType.value = rtnLGCode;                      
             }                            
             else if ( txtLGGroupCodeID.text == 'LGPO2002')
             {
                lstCarrier.SetDataText(txtCodeTemp.text);  
                lstCarrier.value = rtnLGCode;                      
             }                           
         break;    
         
         case 'data_jain00020_3':
            radSearchPage.value ='3';
            OnChangePage();
         break;                 
    }
}

//======================================================================

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_jain00020_1.StatusDelete();
                data_jain00020_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_PO_D_PK) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
            }            
        break;            

    }     
}
//======================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//======================================================================

function Validate()
{  
    if ( txtSupplierPK.text == '' )
    {
        alert('Pls select Supplier first !!!');
        return false ;
    } 
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData( i, G1_PO_Qty_1)) == 0)
        {
            alert("Input PO Qty. at " + i + ",pls!")
            return false;
        }
    }
    //----------------
    return true;
}

//======================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if ( Validate())
            {
                flag = 'save';
                data_jain00020_1.Call();
            }            
        break;
        
        case 'Detail':        
            data_jain00020_2.Call();
        break;
    }
}

//======================================================================

function CheckInput()
{   
    var dPOAmount = 0 , dVATAmount = 0 , dTotalAmount = 0 ;
    var col, row;
    
    col = event.col;
    row = event.row ; 
     
    if ( col == G1_PO_Qty_1 || col == G1_PO_Qty_2 || col == G1_UPrice || col == G1_PO_Amt || col == G1_VAT_Rate || col == G1_Total_Amt||col==G1_VAT_Amount )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData( row, col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {    
                grdDetail.SetGridText( row, col, parseFloat(grdDetail.GetGridData(row, col)).toFixed(2));        
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
    
    if ( col == G1_PO_Qty_1 || col == G1_PO_Qty_2 || col == G1_UPrice || col == G1_VAT_Rate )
    {  
        if ( lstPriceBy.value == '1' )
        {         
            dPOAmount = Number(grdDetail.GetGridData( row, G1_PO_Qty_1 )) * Number(grdDetail.GetGridData( row, G1_UPrice )) ;                
        }
        else
        {
            dPOAmount = Number(grdDetail.GetGridData( row, G1_PO_Qty_2 )) * Number(grdDetail.GetGridData( row, G1_UPrice )) ;                        
        }   
         
        grdDetail.SetGridText( row, G1_PO_Amt, parseFloat(dPOAmount+"").toFixed(2) ) ; 
        
        dVATAmount   = Number(dPOAmount) * Number(grdDetail.GetGridData( row, G1_VAT_Rate )) / 100 ;                
        grdDetail.SetGridText( row, G1_VAT_Amount, parseFloat(dVATAmount+"").toFixed(2) ) ;
        dTotalAmount = dPOAmount + dVATAmount ;
        grdDetail.SetGridText( row, G1_Total_Amt, parseFloat(dTotalAmount+"").toFixed(2) ) ;     
    }
    
    if ( col == G1_PO_Amt )
    {
        dVATAmount   = Number(grdDetail.GetGridData( row, G1_PO_Amt )) * Number(grdDetail.GetGridData( row, G1_VAT_Rate )) / 100 ;                
        
        dTotalAmount = Number(grdDetail.GetGridData( row, G1_PO_Amt )) + dVATAmount ;
        grdDetail.SetGridText( row, G1_Total_Amt, parseFloat(dTotalAmount+"").toFixed(2) ) ;         
    }
    //--------------   
    TotalAmount();
}

//======================================================================
function OnPrint()
{

    if(txtMasterPK.text=="")
    {
        alert("Please select PO to print");
    }
    else
    {
        var url =System.RootURL + '/reports/ja/in/rpt_jain00020_AMB.aspx?txtMasterPK='+txtMasterPK.text ;
        window.open(url);
    }
//    var url =System.RootURL + '/reports/ep/bp/epbp00030.aspx?pkList='+txtMasterPK.text ;
//    window.open(url); 
    /*        
    switch (radMatType.value)
    {
        case 'Fabric' :
            if ( txtMasterPK.text != ''  )
            {
                var url =System.RootURL + '/reports/ep/bp/jain00020_1.aspx?txtMasterPK='+txtMasterPK.text ;
                window.open(url);
            }
            else
            {
                alert('PLS SELECT ONE P/O.');
            }
        break;
        
        case 'Sub-Mat' :
            if ( chkIncludedPicture.value == 'N' )
            {
                var url =System.RootURL + '/reports/ep/bp/jain00020_2.aspx?PO_PK='+txtMasterPK.text ;
                window.open(url);           
            }
            else
            {
                var url =System.RootURL + '/reports/ep/bp/jain00020_3.aspx?PO_PK='+txtMasterPK.text ;
                window.open(url);                       
            }
        break;
        
        case 'ALL' :
            var url =System.RootURL + '/reports/ep/bp/epbp00030.aspx?pkList='+txtMasterPK.text ;
            window.open(url); 
        break; 
              
    }  */    
}

//====================================================================
function OnChangeTab()
{ 
    var info     = document.all("info"); 
    var shipment = document.all("shipment"); 
    var payment  = document.all("payment");
    
    switch (radTab.value)
    {
        case '1':
            info.style.display     = "";
            shipment.style.display = "none"; 
            payment.style.display  = "none";           
        break;
        
        case '2' :
            info.style.display     = "none";
            shipment.style.display = "";
            payment.style.display  = "none"; 
        break;
        
        case '3' :
            info.style.display     = "none";
            shipment.style.display = "none";
            payment.style.display  = ""; 
        break;        
    }
}

//======================================================================
function OnChangePriceBy()
{
    var dPOAmount = 0 , dVATAmount = 0 , dTotalAmount = 0 ;
    if ( lstPriceBy.value == '1' )
    { 
        for(var i=1 ; i<grdDetail.rows; i++)
        {
            dPOAmount = Number(grdDetail.GetGridData( i, G1_PO_Qty_1 )) * Number(grdDetail.GetGridData( i, G1_UPrice )) ;                
            grdDetail.SetGridText( i, G1_PO_Amt, parseFloat(dPOAmount+"").toFixed(2) ) ; 
            
            dVATAmount   = Number(grdDetail.GetGridData( i, G1_PO_Amt )) * Number(grdDetail.GetGridData( i, G1_VAT_Rate )) / 100 ;                
            
            dTotalAmount = dPOAmount + dVATAmount ;
            grdDetail.SetGridText( i, G1_PO_Amt, parseFloat(dTotalAmount+"").toFixed(2) ) ; 
        }
    }
    else
    {
        for(var i=1 ; i<grdDetail.rows; i++)
        {
            dPOAmount = Number(grdDetail.GetGridData( i, G1_PO_Qty_2 )) * Number(grdDetail.GetGridData( i, G1_UPrice )) ;                
            grdDetail.SetGridText( i, G1_PO_Amt, parseFloat(dPOAmount+"").toFixed(2) ) ; 
            
            dVATAmount   = Number(grdDetail.GetGridData( i, G1_PO_Amt )) * Number(grdDetail.GetGridData( i, G1_VAT_Rate )) / 100 ;                
            
            dTotalAmount = dPOAmount + dVATAmount ;
            grdDetail.SetGridText( i, G1_PO_Amt, parseFloat(dTotalAmount+"").toFixed(2) ) ; 
        }    
    }           
    //--------------
    TotalAmount();     
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumPOAmount = 0 , sumVATAmount = 0 , sumTotalAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumPOAmount    = sumPOAmount + Number(grdDetail.GetGridData(i, G1_PO_Amt));
        sumVATAmount   = sumVATAmount + Number(grdDetail.GetGridData( i, G1_PO_Amt )) * Number(grdDetail.GetGridData( i, G1_VAT_Rate )) / 100 ;
        sumTotalAmount = sumTotalAmount + Number(grdDetail.GetGridData(i, G1_Total_Amt));
    }

    txtPOAmount.text    = sumPOAmount.toFixed(2)+"";
    txtVATAmount.text   = sumVATAmount.toFixed(2)+"";
    txtTotalAmount.text = sumTotalAmount.toFixed(2)+"";
} 

//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Confirm' :
            if ( confirm('Do you want to confirm this P/O?'))
            {
                pro_jain00020.Call();
            }    
        break;
        
        case 'GroupItem' :
            if ( confirm('Do you want to group item this P/O?'))
            {        
                pro_jain00020_1.Call();
            }    
        break;
    }
}
//======================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Code) = true ;
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_name) = true ;
		grdDetail.GetGridControl().ColHidden(G1_PO_Qty_2)      = true ;
		grdDetail.GetGridControl().ColHidden(G1_UOM_2)         = true ;
		grdDetail.GetGridControl().ColHidden(G1_ETD_To)        = true ;
		grdDetail.GetGridControl().ColHidden(G1_ETA_To)        = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Code) = false;
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_name) = false ;
		grdDetail.GetGridControl().ColHidden(G1_PO_Qty_2)      = false ;
		grdDetail.GetGridControl().ColHidden(G1_UOM_2)         = false ;
		grdDetail.GetGridControl().ColHidden(G1_ETD_To)        = false ;
		grdDetail.GetGridControl().ColHidden(G1_ETA_To)        = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
//==========================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G1_UOM_1 || event_col == G1_UOM_2 )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
                 else if ( event_col == G1_PO_Item_Code || event_col == G1_PO_Item_Name )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_PO_ITEM_PK,   object[0] );
                            grdDetail.SetGridText( event_row, G1_PO_Item_Code, object[1] );
                            grdDetail.SetGridText( event_row, G1_PO_Item_Name, object[2] );
                       }                       
                 }
            break;             
      }         
}   
 //===================================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_fpab00220_2" > 
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
    <gw:data id="data_jain00020" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso id="1" type="grid" user="prod" function="crm.sp_sel_jain00020" >
                <input  bind="grdSearch">
                    <input bind="txtPONoSearch" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_jain00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34" function="crm.sp_sel_jain00020_1" procedure="crm.sp_upd_jain00020_1">
                <input>                         
                    <inout bind="txtMasterPK" />
                    <inout bind="txtPONo" />
                    <inout bind="dtPODate" />
                    <tnout bind="lblStatus" />
                    <inout bind="txtStaffPK" />
                    <inout bind="txtStaffName" />  
                    <inout bind="lstReportType" /> 
                    <inout bind="txtRemark" /> 
                    <inout bind="txtSupplierPK" /> 
                    <inout bind="txtSupplierName" />
                    <inout bind="txtBillToPK" />
                    <inout bind="txtBillToName" />                  
                    <inout bind="lstCurrency" />                    
                    <inout bind="lstPriceBy" />
                    <inout bind="txtPOAmount" />   
                    <inout bind="txtVATAmount" /> 
                    <inout bind="txtTotalAmount" />
                    <inout bind="dtETDFrom" />
                    <inout bind="dtETDTo" />  
                    <inout bind="dtETAFrom" />
                    <inout bind="dtETATo" />   
                    <inout bind="txtDeliverPK" />
                    <inout bind="txtDeliverName" />                                        
                    <inout bind="txtBuyRep" />
                    <inout bind="txtShipToPK" />
                    <inout bind="txtShipToName" />                     
                    <inout bind="txtSaleRep" />  
                    <inout bind="txtPLPK" />
                    <inout bind="txtPLName" />                                                                                                      
                    <inout bind="txtContractNo" />                                                                             
                    <inout bind="lstPaymentMethod" />
                    <inout bind="lstPaymentTerm" />
                    <inout bind="lstPriceType" />  
                    <inout bind="txtExRate" />
                    <inout bind="lstPOType" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_jain00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28" function="crm.sp_sel_jain00020_2" procedure="crm.sp_upd_jain00020_2"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_jain00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_jain00020" > 
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
    <gw:data id="pro_jain00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_jain00020_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="width: 89%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 2%" align="right">
                        <td style="width: 10%; white-space: nowrap">
                            P/O No.
                        </td>
                        <td colspan="2">
                            <gw:textbox id="txtPONoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|P/O Date|P/O No" format="0|4|0" aligns="1|1|0"
                                defaults="||" editcol="0|0|0" widths="0|1200|1500" styles="width:100%; height:100%"
                                sorting="T" oncellclick="OnSearch('grdMaster')" param="0,1,2" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%">
                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/O No
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtPONo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            P/O Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtPODate" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 20%" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%" colspan="2">
                            <a onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">Charger</a>
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td style="width: 25%" colspan="8">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 1%" valign="middle" align="left">
                        </td>
                        <td colspan="4">
                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                <span value="1" id="1">P/O Info</span> 
                                <span value="2" id="2">Delivery</span>
                                <span value="3" id="3">Payment</span>
                            </gw:radio>
                        </td>
                        <td align="right">
                            Report Type</td>
                        <td colspan="5" align="right" style="white-space: nowrap">
                            <gw:list id="lstReportType" styles='width:100%;' csstype="mandatory" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnPOSheet" img="excel" alt="PO Sheet" onclick="OnPrint()" />
                        </td>
                    </tr>
                    <tr style="height: 1%" id="info">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td align="right" style="width: 10%; white-space: nowrap">
                                                    <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="color: #0000ff">
                                                        Supplier</a>
                                                </td>
                                                <td style="width: 40%">
                                                    <gw:textbox id="txtSupplierName" styles="width:100%;" onenterkey="" />
                                                    <gw:textbox id="txtSupplierPK" styles="display:none" />
                                                </td>
                                                <td align="right" style="width: 10%; white-space: nowrap">
                                                    <a onclick="OnPopUp('Bill_To')" href="#tips" style="color: #0000ff">Bill to</a>
                                                </td>
                                                <td style="width: 40%">
                                                    <gw:textbox id="txtBillToName" styles="width:100%;" />
                                                    <gw:textbox id="txtBillToPK" styles="display=none" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a title="PLCenter" onclick="OnPopUp('PLCenter')" style="color: #0000ff; cursor: hand">
                                            P/L</a>
                                    </td>
                                    <td style="width: 25%; white-space: nowrap">
                                        <gw:textbox id="txtPLPK" styles="display: none" />
                                        <gw:textbox id="txtPLName" styles="width: 100%" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        Price by
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstPriceBy" styles='width:100%;' csstype="mandatory" onchange="OnChangePriceBy()" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('Currency')" href="#tips" style="color: #0000ff">Currency</a>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstCurrency" styles="width:100%;" onchange="getExRate();" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%">
                                        Amount
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtPOAmount" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        VAT Amount
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtVATAmount" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        Total Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTotalAmount" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%" id="shipment">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%">
                                        <a title="Deliver" onclick="OnPopUp('Deliver')" href="#tips" style="color: #0000ff">
                                            Deliver</a>
                                    </td>
                                    <td style="width: 60%" colspan="3">
                                        <gw:textbox id="txtDeliverName" styles="width:100%;" onenterkey="" />
                                        <gw:textbox id="txtDeliverPK" styles="display=none" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        Sale Rep
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtSaleRep" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%">
                                        <a title="Ship To" onclick="OnPopUp('Ship_To')" href="#tips" style="color: #0000ff">
                                            Ship to</a>
                                    </td>
                                    <td style="width: 60%" colspan="3">
                                        <gw:textbox id="txtShipToName" styles="width:100%;" onenterkey="" />
                                        <gw:textbox id="txtShipToPK" styles="display=none" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        Buy Rep
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtBuyRep" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        ETD
                                    </td>
                                    <td style="width: 25%; white-space: nowrap">
                                        <gw:datebox id="dtETDFrom" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                        ~
                                        <gw:datebox id="dtETDTo" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        ETA
                                    </td>
                                    <td style="width: 25%">
                                        <gw:datebox id="dtETAFrom" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                        ~
                                        <gw:datebox id="dtETATo" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('Carrier')" href="#tips" style="color: #0000ff">Carrier</a>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstCarrier" styles="width:100%;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%" id="payment">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('POType')" href="#tips" style="color: #0000ff">P/O Type</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstPOType" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('Pay-Terms')" href="#tips" style="color: #0000ff">Pay Term</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstPaymentTerm" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('PaymentMethod')" href="#tips" style="color: #0000ff">Pay Method</a>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstPaymentMethod" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <a onclick="OnPopUp('Incoterms')" href="#tips" style="color: #0000ff">Price Type</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstPriceType" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        Ex-Rate
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%">
                                        Contract No
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtContractNo" styles="width: 100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 1%">
                                        <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                            style="cursor: hand" onclick="OnToggleGrid()" />
                                    </td>
                                    <td style="width: 30%; white-space: nowrap" align="left">
                                    </td>
                                    <td align="right" style="width: 65%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idGetPR" img="2" text="M/R" alt="Purchasing Request" styles='width:100%'
                                            onclick="OnAddNew('PR')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:100%' onclick="OnAddNew('FreeItem')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="12">
                            <gw:grid id='grdDetail' header='_NULL|_PK|Seq|_Req_Item_PK|Req Item Code|Req Item Name|_PO_ITEM_PK|P/O Item Code|P/O Item Name|P/O Qty 1|UOM|P/O Qty 2|UOM|U/Price|P/O Amount|VAT(%)|VAT Amount|Total Amount|ETD From|ETD To|ETA From|ETA To|M/R Qty|M/R No|Remark|_PO_MR_D_PK|_NULL|_NULL|_PO_PO_M_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|4|4|4|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|0|0|3|1|3|1|3|3|3|3|3|1|1|1|1|3|0|0|0|0|0|0'
                                check='||||||||||||||||||||||||||||' editcol='0|0|1|0|0|0|0|0|0|1|0|1|0|1|1|1|0|1|1|1|1|1|0|0|1|0|0|0|0'
                                widths='1000|0|1000|0|2000|2500|0|2000|2500|1500|1000|1500|1000|1500|1500|1500|1500|1500|1200|1200|1200|1200|1500|1500|1000|0|0|0|0'
                                sorting='T' onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)"
                                styles='width:100%; height:100%' acceptnulldate='T'  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
    <gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
    <!------------------------------------------->
</body>
</html>
