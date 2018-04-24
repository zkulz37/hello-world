<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Incoming Entry</title>
</head>
<%  
    ESysLib.SetUser("sale")
    Dim l_user As String
    l_user = "sale."
%>
<script>

//-----------------------------------------------------

var flag;

var GS_MASTER_PK    = 0,
    GS_SLIP_NO      = 1,
    GS_DATE         = 2,
    GS_INVOICE      = 3,
    GS_STATUS       = 4;

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1,
    G1_SEQ              = 2,
    G1_ITEM_PK          = 3,
    G1_ITEM_CODE        = 4,
    G1_ITEM_NAME        = 5,
    G1_LOT_NO           = 6,
    G1_INVOICE_BALES    = 7,
    G1_ACTUAL_BALES     = 8,
    G1_INVOICE_KG       = 9,
    G1_ACTUAL_KG        = 10,
    G1_GAP_KG           = 11,
    G1_INVOICE_LBS      = 12,     
    G1_ACTUAL_LBS       = 13,
    G1_INVOICE_AVG      = 14,
    G1_ACTUAL_AVG       = 15,
    G1_UNIT_PRICE       = 16,
    G1_INVOICE_AMT      = 17,
    G1_ACTUAL_AMT       = 18;
    
var arr_FormatNumber = new Array();    
 //===============================================================================================
function OnToggle()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //===============================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
    txtUser_PK.text = "<%=session("USER_PK")%>";
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtCompanyPK.text = "<%=session("COMPANY_PK")%>";  	
	txtLang.text = "<%=Session("SESSION_LANG")%>";
	
	txtIncomingSlip.SetEnable(false);
	//txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtSupplierName.SetEnable(false);
    txtPLName.SetEnable(false);    
    
    txtNetW_INVC_KG.SetEnable(false); 
    txtNetW_ACT_KG.SetEnable(false); 
    txtNetW_GAP_KG.SetEnable(false); 
    
    txtTotalInvBales.SetEnable(false); 
    txtTotalActBales.SetEnable(false); 
    txtSumInvAmt.SetEnable(false); 
    txtSumActAmt.SetEnable(false); 
    txtGapAmt.SetEnable(false); 
    txtGapTax.SetEnable(false);
    txtGapTotalAmt.SetEnable(false);
    
    txtNetW_INVC_LBS.SetEnable(false);
    txtNetW_ACT_LBS.SetEnable(false);
    txtNetW_GAP_LBS.SetEnable(false);
    
    txtTareW_INVC_KG.SetEnable(false);
    txtTareW_GAP_KG.SetEnable(false);
    txtTareW_INVC_LBS.SetEnable(false);
    txtTareW_ACT_LBS.SetEnable(false);
    txtTareW_GAP_LBS.SetEnable(false);  
    
    txtGrossW_INVC_KG.SetEnable(false);
    txtGrossW_ACT_KG.SetEnable(false);
    txtGrossW_GAP_KG.SetEnable(false);
    txtGrossW_INVC_LBS.SetEnable(false);
    txtGrossW_ACT_LBS.SetEnable(false);
    txtGrossW_GAP_LBS.SetEnable(false);    
    
    idBtnApprove.SetEnable(false);
    idBtnCancel.SetEnable(false);
    idBtnAutoSlip.SetEnable(false);  
    idBtnAutoClaim.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    SetGridFormat(); 
    BindingDataList();    
    //----------------------------         
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------- 
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0110' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
     lstClaimType.SetDataText(data); 
     lstClaimType.value = 'L' ;
         
     data = "<%=ESysLib.SetListDataSQL("SELECT TRANS_CODE ,TRANS_CODE || ' - ' || trans_name  FROM tlg_in_trans_code  WHERE del_if = 0 and trans_type = 'I' and TRANS_CODE = 'I10' ORDER BY trans_code" )%>";    
     lstTransType.SetDataText(data);
     //---------------------------
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCCY.SetDataText(data);               
     
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
     lstShipComp.SetDataText(data); 
     lstShipComp.value = '' ;

     data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
     cboCompanyList.SetDataText(data);	 
     cboCompanyList.value=txtCompanyPK.text;
     
     pro_kbin00060_lst.Call();  
     
 }
 //==================================================================================
 
function  OnChangeDate()
{
	var	ldate=dtVoucherDate.value ;       
    ldate = ldate.substr(2,4)  ; 
    lstInType.value = ldate;
}
 //==================================================================================
 
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
	
	ctr.ColFormat(G1_INVOICE_BALES)     = "###,###,###,###.####";
	ctr.ColFormat(G1_ACTUAL_BALES)      = "###,###,###,###.####";
	ctr.ColFormat(G1_INVOICE_KG)      	= "###,###,###,###.####";
	ctr.ColFormat(G1_ACTUAL_KG)      	= "###,###,###,###.####";
	ctr.ColFormat(G1_GAP_KG)      		= "###,###,###,###.####";
	ctr.ColFormat(G1_INVOICE_LBS)      	= "###,###,###,###.####";
	ctr.ColFormat(G1_ACTUAL_LBS)      	= "###,###,###,###.####";
	ctr.ColFormat(G1_INVOICE_AVG)      	= "###,###,###,###.####";
	ctr.ColFormat(G1_ACTUAL_AVG)      	= "###,###,###,###.####";
	
    ctr.ColFormat(G1_UNIT_PRICE)      = "###,###,###,###.####";
    ctr.ColFormat(G1_ACTUAL_AMT)      = "###,###,###,###.####";
    ctr.ColFormat(G1_INVOICE_AMT)     = "###,###,###,###.####";
    
    arr_FormatNumber[G1_INVOICE_BALES]   = 4;
    arr_FormatNumber[G1_ACTUAL_BALES]    = 4;
    arr_FormatNumber[G1_INVOICE_KG]      = 4;
    arr_FormatNumber[G1_ACTUAL_KG]       = 4;
    arr_FormatNumber[G1_GAP_KG]          = 4;
    arr_FormatNumber[G1_INVOICE_LBS]     = 4;
    arr_FormatNumber[G1_ACTUAL_LBS]      = 4;
    arr_FormatNumber[G1_INVOICE_AVG]     = 4;
    arr_FormatNumber[G1_ACTUAL_AVG]      = 4;
	
    arr_FormatNumber[G1_UNIT_PRICE]      = 4;
    arr_FormatNumber[G1_INVOICE_AMT]     = 4;
    arr_FormatNumber[G1_ACTUAL_AMT]      = 4;
 }
 //==================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_kbin00060_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
        break;  
    }
}  
//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbin00060.Call("SELECT");
        break;
    
        case 'grdMaster':
            if ( data_kbin00060_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                    }
                    flag = 'view' ;
                    data_kbin00060_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                }
                
                flag = 'view' ;
                data_kbin00060_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kbin00060_2.Call("SELECT");
        break;
    }
}

function OnCheckStatus()
{ 
    if (lblStatus.text == 'SAVED'||lblStatus.text == 'CANCEL')
    {
        idBtnAutoSlip.SetEnable(false) ;
        idBtnApprove.SetEnable(true) ;
        idBtnCancel.SetEnable(false) ;
        idBtnAutoClaim.SetEnable(false);
    }
    else
    { 
        idBtnApprove.SetEnable(false) ;
        if(txtAccSlipNo.text =="")
        {
            idBtnCancel.SetEnable(true) ;
            idBtnAutoSlip.SetEnable(true) ;
            idBtnAutoClaim.SetEnable(true);
        }
        else
        {
            idBtnCancel.SetEnable(false) ;
            idBtnAutoSlip.SetEnable(false) ;
            idBtnAutoClaim.SetEnable(false);
        }
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_kbin00060_1": 
            OnCheckStatus();
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }
        break;

        case "data_kbin00060_2":
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBgColor( 1, G1_INVOICE_BALES , grdDetail.rows - 1, G1_INVOICE_BALES , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_KG , grdDetail.rows - 1, G1_INVOICE_KG , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_AVG , grdDetail.rows - 1, G1_INVOICE_AVG , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_AMT , grdDetail.rows - 1, G1_INVOICE_AMT , 0xCCFFFF );
            }         
        break;
		
        case 'pro_kbin00060_lst':
            lstInWH.SetDataText(txtWHStr.text);
            lstInWH.value = 224;

            lstOutWH.SetDataText(txtWHStr.text);
            lstOutWH.value = 321;
            lstWH2.SetDataText(txtWHStr.text +"||");
            lstWH2.value =''
            OnAddNew('Master');
        break;    
		
		case 'data_fpab00220_2':
			 if ( txtLGGroupCodeID.text == 'LGKB0110')
			 {
				 lstClaimType.SetDataText(txtLGCodeList.text);
				 lstClaimType.value = rtnLGCode;
			 }
		break;
		
        case 'pro_kbin00060':
            alert(txtReturnValue.text);
        break; 

		case 'pro_kbin00060_1':
			alert(txtReturnValue.text);
			data_kbin00060_1.Call('SELECT');
		break;
		
		case 'pro_kbin00060_2':
			alert(txtReturnValue.text);
			data_kbin00060_1.Call('SELECT');
		break;		
   }            
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
		case 'WAREHOUSE':
            var path = System.RootURL + '/form/fp/ab/fpab00240.aspx' ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                lstWH.value = obj[0];                 
            }
        break; 
			
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text = obj[2];
                txtStaffPK.text   = obj[0];
            }
        break;            

        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
                txtSupplierName.text = object[2];                
	         }
        break;
        
        case 'G/LTYPE':
            var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0110";
	        var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
            
	        if ( object != null )
	        {	        
	            if ( object[0] == 1 )
	           {
	               txtLGGroupCodeID.text = 'LGKB0110';
	               rtnLGCode             = object[1];
                   
                   data_fpab00220_2.Call("SELECT");                                
	           }
	           else
	           {
	               lstClaimType.value = object[1];      
	           }    	                
	        }                              
        break;   
                        
        case 'PL': // PL
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[6]; 
                txtPLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;        

		case 'Shipper':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0030";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0030';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShipComp.value = object[1];      
	                }    	                
	             }                              
            break;  
        
        case 'Incoming_Slip':
             var path = System.RootURL + "/form/kb/in/kbin00061.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes',this);
	         if ( object != null )
	         {
	            var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, arrTemp[2]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        					
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,    arrTemp[3]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[4]);//item_code 
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME,   arrTemp[5]);//item_name	    
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO, arrTemp[6]);   
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_BALES, arrTemp[8]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ACTUAL_BALES, arrTemp[8]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_LBS, arrTemp[9]);
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_KG,  arrTemp[7]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_AVG,  arrTemp[12]);
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,  arrTemp[10]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_AMT,  arrTemp[11]);
                    }
	         }
        break;
        
		case 'Report':			 
			 if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/bi/ni/bini00033.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
 	        }
	        else
	        {
		        alert("Please, select one slip no to print!");
	        }	
		break;                
    }	       
}
//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'AutoClaim' :
             if ( txtMasterPK.text != '' )
             {
                 if ( confirm('Do you want to copy this slip to Claim Note?'))
                 {
                     pro_kbin00060.Call();
                 } 
             }
	        else
	        {
		        alert("PLS SELECT ONE SLIP.");
	        }			                         
        break;  
		
        case 'Approve':
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to approve this Slip?'))
                {
                    pro_kbin00060_1.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}        
        break;

        case 'Cancel':
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to cancel this Slip?'))
                {
                    pro_kbin00060_2.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}        
        break;
		
		case 'DVD_ACTUAL_WEIGHT':
			if ( confirm('Do you want to divide Actual Weight ?') )
            {
				var sumActualWeight = 0 , sumTotalBales = 0 , sumRemainWeight = 0 , divide_weight = 0 ;
				
				sumActualWeight = Number(txtDVDActualWeight.text);
				sumRemainWeight = Number(txtDVDActualWeight.text);
				
				for ( var i=1; i < grdDetail.rows; i++ )
				{			 					 
					sumTotalBales = sumTotalBales + Number(grdDetail.GetGridData( i, G1_ACTUAL_BALES )); 	 
				}
				//----------------------
				if ( Number(sumTotalBales) != 0 )  
				{
					divide_weight = Number(sumActualWeight) / Number(sumTotalBales);
				}
				else
				{
					divide_weight = Number(sumActualWeight);
				}
				//----------------------
				for ( var i=1; i < grdDetail.rows; i++ )
				{	
					if ( sumRemainWeight > 0 )
					{
						if ( Number(sumRemainWeight) > System.Round(Number(divide_weight)*Number(grdDetail.GetGridData( i, G1_ACTUAL_BALES )), arr_FormatNumber[G1_ACTUAL_KG]) )
						{										 
							grdDetail.SetGridText( i, G1_ACTUAL_KG, System.Round(Number(divide_weight)*Number(grdDetail.GetGridData( i, G1_ACTUAL_BALES )), arr_FormatNumber[G1_ACTUAL_KG])) ;					 					
						}
						else					
						{
							grdDetail.SetGridText( i, G1_ACTUAL_KG, System.Round( sumRemainWeight, arr_FormatNumber[G1_ACTUAL_KG] )) ;	
						}
					
						//InputProcess( G1_ACTUAL_KG, i );	
					
						sumRemainWeight = Number(sumRemainWeight) - Number(grdDetail.GetGridData( i, G1_ACTUAL_KG ));
					}	
				}
			}			
		break;
    }
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
                data_kbin00060_1.Call();
                flag='save';  
        break;
        
        case 'Detail':        
            data_kbin00060_2.Call();
        break;
    }
}
//=================================================================================
function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_kbin00060_1.StatusDelete();
                data_kbin00060_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_DETAIL_PK ) == '' )
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
//=================================================================================
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//=================================================================================
function Validate()
{   
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData( i, G1_NET_KG)) == 0 )
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
    }
    return true;
}
//=================================================================================
function CheckInput()
{   
    try
    {
        var col, row, InvoiceKg, ActualKg, InvoiceBales, ActualBales, InvoiceLBS, ActualLBS;
        col = event.col;
        row = event.row; 
    
        if ( col == G1_ACTUAL_KG || col == G1_UNIT_PRICE || col == G1_ACTUAL_BALES)
        {
            var dQuantiy ;
            dQuantiy =  grdDetail.GetGridData(row,col) ;
        
            if (Number(dQuantiy))
            {
                if (dQuantiy > 0)
                {
                    grdDetail.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
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
            //----------------------Calculate Amount -----
            //1KG=2.20460000186  LBS
            InvoiceKg = grdDetail.GetGridData( row, G1_INVOICE_KG) ;
            ActualKg  = System.Round(Number(grdDetail.GetGridData( row, G1_ACTUAL_KG)), 2) ;
            
            InvoiceBales = grdDetail.GetGridData( row, G1_INVOICE_BALES) ;
            ActualBales  = System.Round(Number(grdDetail.GetGridData( row, G1_ACTUAL_BALES)),2 ) ;
                   
            InvoiceLBS = grdDetail.GetGridData( row, G1_INVOICE_LBS) ;   
            ActualLBS = System.Round(Number(ActualKg) * 2.20460000186 , 2);
            grdDetail.SetGridText( row, G1_ACTUAL_LBS , ActualLBS) ;
                 
            grdDetail.SetGridText( row, G1_INVOICE_AVG , System.Round( InvoiceKg/InvoiceBales, arr_FormatNumber[G1_INVOICE_AVG] ) ) ;
            grdDetail.SetGridText( row, G1_ACTUAL_AVG , System.Round( ActualKg/ActualBales, arr_FormatNumber[G1_ACTUAL_AVG] ) ) ;
            grdDetail.SetGridText( row, G1_GAP_KG , System.Round( ActualKg-InvoiceKg, arr_FormatNumber[G1_GAP_KG] ) ) ;
            
            var UnitPrice = System.Round(Number(grdDetail.GetGridData( row, G1_UNIT_PRICE)), arr_FormatNumber[G1_UNIT_PRICE] ) ;
            grdDetail.SetGridText( row, G1_INVOICE_AMT , System.Round( Number(InvoiceLBS)*UnitPrice, arr_FormatNumber[G1_INVOICE_AMT] ) ) ;
            grdDetail.SetGridText( row, G1_ACTUAL_AMT , System.Round( ActualLBS*UnitPrice, arr_FormatNumber[G1_ACTUAL_AMT] ) ) ;
           
            TotalAmount();  
        }
        else if(col == G1_ACTUAL_LBS)
        {
            var actual_lbs = System.Round(Number(grdDetail.GetGridData( row, G1_ACTUAL_LBS)), 2) ;
            var unit_price = System.Round(Number(grdDetail.GetGridData( row, G1_UNIT_PRICE)), 4) ;
            var actual_amt = System.Round(actual_lbs * unit_price, 4);
            grdDetail.SetGridText( row, G1_ACTUAL_AMT, actual_amt);
            actual_lbs = 0;
            var sumActualAmt = 0;
            for(var i = 1; i < grdDetail.rows; i++)
            {
                actual_lbs += System.Round(Number(grdDetail.GetGridData( i, G1_ACTUAL_LBS)), 2) ;
                sumActualAmt += System.Round(Number(grdDetail.GetGridData( i, G1_ACTUAL_AMT)), 4);
            }
            txtNetW_ACT_LBS.text = actual_lbs;
            txtNetW_GAP_LBS.text = System.Round(Number(txtNetW_ACT_LBS.text),2) - System.Round(Number(txtNetW_INVC_LBS.text),2);
            txtGrossW_ACT_LBS.text = System.Round(Number(txtNetW_ACT_LBS.text),2) + System.Round(Number(txtTareW_ACT_LBS.text),2);
            txtGrossW_GAP_LBS.text = System.Round(Number(txtGrossW_ACT_LBS.text),2) - System.Round(Number(txtGrossW_INVC_LBS.text),2);
            txtSumActAmt.text = sumActualAmt;
            
            txtGapAmt.text = System.Round(Number(txtSumActAmt.text),4) - System.Round(Number(txtSumInvAmt.text),4);
            txtGapTax.text = System.Round(Number(txtGapAmt.text) * (Number(txtTax.text)/100), 2);
            txtGapTotalAmt.text = System.Round(Number(txtGapTax.text) + Number(txtGapAmt.text), 4);
        }
    }
    catch(err)
    {
        alert(err.Message);
    }
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
	var sumInvoiceBales  = 0 ;
	var sumActualBales  = 0 ;
	
	//var sumInvoiceAmt   = 0 ;
    var sumActualAmt = 0 ;
    
    var sumGap = 0;
    
    var sumInvoiceKG = 0;
    var sumActualKG = 0;
    var sumActualLBS = 0;
    var sumGapKG = 0;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumInvoiceKG = sumInvoiceKG + Number(grdDetail.GetGridData( i, G1_INVOICE_KG ));
        sumActualKG = sumActualKG + Number(grdDetail.GetGridData( i, G1_ACTUAL_KG ));
        sumGapKG = sumGapKG + Number(grdDetail.GetGridData( i, G1_GAP_KG ));
        sumActualLBS = sumActualLBS + Number(grdDetail.GetGridData( i, G1_ACTUAL_LBS ));

		sumInvoiceBales  = sumInvoiceBales  + Number(grdDetail.GetGridData( i, G1_INVOICE_BALES ));
		sumActualBales  = sumActualBales  + Number(grdDetail.GetGridData( i, G1_ACTUAL_BALES ));
		//sumInvoiceAmt = sumInvoiceAmt  + Number(grdDetail.GetGridData( i, G1_INVOICE_AMT ));
		sumActualAmt = sumActualAmt  + Number(grdDetail.GetGridData( i, G1_ACTUAL_AMT ));		
    }
	txtTotalInvBales.text  = System.Round( sumInvoiceBales,  4 ) ;
	txtTotalActBales.text   = System.Round( sumActualBales,   4 ) ;
    //txtSumInvAmt.text = System.Round( sumInvoiceAmt, 4 ) ;
    txtSumActAmt.text = System.Round( sumActualAmt, 4 ) ;
    txtGapAmt.text = Number(txtSumActAmt.text) - Number(txtSumInvAmt.text); 

    txtGapTax.text = System.Round(Number(txtGapAmt.text) * (Number(txtTax.text)/100), 2);
    txtGapTotalAmt.text = System.Round(Number(txtGapTax.text) + Number(txtGapAmt.text), 4);
    
    //-------------------------------------------------------------------------
    txtNetW_ACT_KG.text = System.Round( sumActualKG, 2 ) ;
    txtGrossW_ACT_KG.text = System.Round( sumActualKG, 2 ) + System.Round(Number(txtTareW_ACT_KG.text), 2);

    txtNetW_GAP_KG.text     = System.Round( sumActualKG, 2 ) - System.Round(Number(txtNetW_INVC_KG.text), 2);
    txtTareW_GAP_KG.text    = System.Round(Number(txtTareW_ACT_KG.text), 2) - System.Round(Number(txtTareW_INVC_KG.text), 2);
    txtGrossW_GAP_KG.text   = System.Round( sumGapKG, 2 ) + System.Round(Number(txtTareW_GAP_KG.text), 2);

    txtNetW_ACT_LBS.text    = System.Round(sumActualLBS, 2); 
    txtNetW_GAP_LBS.text    = Number(txtNetW_ACT_LBS.text) - Number(txtNetW_INVC_LBS.text);  

    txtTareW_ACT_LBS.text   = System.Round(Number(txtTareW_ACT_KG.text) * 2.20460000186 , 2);  
    txtTareW_GAP_LBS.text   = Number(txtTareW_ACT_LBS.text) - Number(txtTareW_INVC_LBS.text);   

    txtGrossW_ACT_LBS.text  = Number(txtNetW_ACT_LBS.text) + Number(txtTareW_ACT_LBS.text);  
    txtGrossW_GAP_LBS.text  = Number(txtGrossW_ACT_LBS.text) - Number(txtGrossW_INVC_LBS.text); 
    //--------------------------------------------------------------------------
    if(Number(txtGapAmt.text) < 0)
    {
        lstClaimType.value = 'L' ;
    }
    else
    {
        lstClaimType.value = 'G' ;
    }
} 
//======================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_CODE) = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_NAME) = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_QTY)       = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_UOM)       = true ;
		grdDetail.GetGridControl().ColHidden(G1_REF_QTY)       = true ;
		grdDetail.GetGridControl().ColHidden(G1_REF_UOM)       = true ;		
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_CODE) = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_NAME) = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_QTY)       = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_UOM)       = false ;	
		grdDetail.GetGridControl().ColHidden(G1_REF_QTY)       = false ;
		grdDetail.GetGridControl().ColHidden(G1_REF_UOM)       = false ;						
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
//==================================================================================
function OnReport(pos)
{
    switch(pos)
    {
        case'0':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00031.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
    }
}
//=================================================================================
function OnMaxSeq()
{
    var maxSeq = 0 ;
    if(grdDetail.rows < 1)
    {
        return maxSeq;
    }
    else
    {
        for (var i = 1; i < grdDetail.rows; i++)
        {
            if ( Number( grdDetail.GetGridData(i,G1_SEQ) ) > maxSeq )
            {
                maxSeq = Number( grdDetail.GetGridData(i,G1_SEQ) )
            }
        }
        return maxSeq;
    }
}
//=================================================================================
function OnCopy()
{
    var i, j, lNewRow;
    
    for (i = 1; i < grdDetail.rows ; i++)
    {
        if(grdDetail.GetGridControl().IsSelected(i))
        {            
            seqInit = OnMaxSeq();
            seqInit = parseInt(seqInit) + 1;
            
            grdDetail.AddRow();
            lNewRow = grdDetail.rows - 1;
            
            for ( j = 0 ; j <= G1_DESCRIPTION ; j++)
            {
                if (j != G1_SEQ && j != G1_DETAIL_PK )
                {
                    grdDetail.SetGridText(lNewRow, j, grdDetail.GetGridData(i, j));
                } 
                if(txtLotNo.text != "")
                {
                    grdDetail.SetGridText( lNewRow, G1_LOT_NO,   txtLotNo.text + "-" + lNewRow);
                }
                grdDetail.SetGridText( lNewRow, G1_SEQ, seqInit);//sequence
            }
        }
    }
}
//=================================================================================
function url_encode(s) 
{
	string = s.replace(/\r\n/g,"\n");
	var utftext = "";

	for (var n = 0; n < string.length; n++) 
	{

		var c = string.charCodeAt(n);

		if (c < 128) 
		{
			utftext += String.fromCharCode(c);
		}
		else if ((c > 127) && (c < 2048)) 
		{
			utftext += String.fromCharCode((c >> 6) | 192);
			utftext += String.fromCharCode((c & 63) | 128);
		}
		else 
		{
			utftext += String.fromCharCode((c >> 12) | 224);
			utftext += String.fromCharCode(((c >> 6) & 63) | 128);
			utftext += String.fromCharCode((c & 63) | 128);
		}
	}
	return escape(utftext);
}
//====================================================================================
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1))
	{
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
 //================================================================================================

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
    <!---------------------------------------------------------------->
    <gw:data id="pro_kbin00060_lst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_kbin00060_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Auto Claim---------------------------------------->
    <gw:data id="pro_kbin00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>LG_PRO_KBIN00060" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Approve---------------------------------------->
    <gw:data id="pro_kbin00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>LG_PRO_KBIN00060_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Cancel---------------------------------------->
    <gw:data id="pro_kbin00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>LG_PRO_KBIN00060_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbin00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_kbin00060_1" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWH2" />
                    <input bind="txtNoSearch" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />                      
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbin00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50" function="<%=l_user%>lg_sel_kbin00060_2"  procedure="<%=l_user%>lg_upd_kbin00060_1"> 
                <inout>      
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtIncomingSlip" />
                     <inout  bind="dtIncomingDate" />
                     <inout  bind="dtVoucherDate" />
                     <inout  bind="txtSlipNo" />                          
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierName" />
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="cboCompanyList" />
                     <inout  bind="txtPONo" />
                     <inout  bind="lstInWH" />
                     <inout  bind="lstOutWH" />
                     <inout  bind="txtLCNo" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtInvoiceNo" />
                     <inout  bind="lstShipComp" /> 
					 <inout  bind="txtBLNo" />
					 <inout  bind="txtTax" />
                     <inout  bind="txtMark" /> 
                     <inout  bind="lstCCY" /> 
                     <inout  bind="txtLotNo" /> 
                     <inout  bind="txtRemark" />
                     <inout  bind="txtTotalInvBales" /> 
                     <inout  bind="txtTotalActBales" /> 
                     <inout  bind="txtSumInvAmt" /> 
                     <inout  bind="txtSumActAmt" /> 
                     <inout  bind="txtGapAmt" /> 
                     <inout  bind="txtGapTax" />
                     <inout  bind="txtGapTotalAmt" />
                     <inout  bind="lstClaimType" />
                     <inout  bind="txtNetW_INVC_KG" />  
                     <inout  bind="txtNetW_ACT_KG" />
                     <inout  bind="txtNetW_GAP_KG" />
                     <inout  bind="txtTareW_INVC_KG" />  
                     <inout  bind="txtTareW_ACT_KG" />
                     <inout  bind="txtTareW_GAP_KG" />
                     <inout  bind="txtGrossW_INVC_KG" />  
                     <inout  bind="txtGrossW_ACT_KG" />
                     <inout  bind="txtGrossW_GAP_KG" />    
                     <inout  bind="txtNetW_INVC_LBS" />  
                     <inout  bind="txtNetW_ACT_LBS" />
                     <inout  bind="txtNetW_GAP_LBS" />
                     <inout  bind="txtTareW_INVC_LBS" />  
                     <inout  bind="txtTareW_ACT_LBS" />
                     <inout  bind="txtTareW_GAP_LBS" />
                     <inout  bind="txtGrossW_INVC_LBS" />  
                     <inout  bind="txtGrossW_ACT_LBS" />
                     <inout  bind="txtGrossW_GAP_LBS" />    
                     <inout  bind="lblStatus" />                                  
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbin00060_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="<%=l_user%>lg_sel_kbin00060_4"   procedure="<%=l_user%>lg_upd_kbin00060_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:list id="lstWH2" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            No.
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="3">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%">
                                        <gw:icon id="idBtnAutoClaim" img="2" text="Auto Claim" styles='width:10%' onclick="OnProcess('AutoClaim')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Date|Invoice No|Status' format='0|0|4|0|0'
                                aligns='0|0|0|0|1' check='||||' editcol='0|0|0|0|0' widths='1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 100%; height: 1%" colspan="16">
                            <table style="width: 100%; height: 100%" cellpadding="1" cellspacing="1" border="0">
                                <tr>
                                    <td align="right" style="width: 1%; white-space: nowrap">
                                        <gw:icon id="idBtnApprove" img="2" text="Approve" styles='width:100%' onclick="OnProcess('Approve')" />
                                    </td>
                                    <td style="width: 1%" align="center">
                                        <gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:100%' onclick="OnProcess('Cancel')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="idBtnAutoSlip" img="2" text="AutoSlip" styles='width:100%' onclick="OnProcess('AutoSlip')" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        ACC Slip No
                                    </td>
                                    <td>
                                        <gw:textbox id="txtAccSlipNo" csstype="mandatory" styles="width:50%;" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        <gw:label id="lblStatus" text="" styles="color:red" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Company
                        </td>
                        <td style="width: 15%" align="center" colspan="3">
                            <gw:list id="cboCompanyList" styles="width:100%" onchange="data_agci00060.Call()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            <a title="Incoming Slip" onclick="OnPopUp('Incoming_Slip')" href="#tips" style="color=#0000ff">
                                <b>Incoming Slip</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtIncomingSlip" styles="width:100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Inc Date
                        </td>
                        <td>
                            <gw:datebox id="dtIncomingDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="WareHouse" onclick="OnPopUp('WAREHOUSE')" href="#tips" style="color: #0000ff">
                                <b>Out W/H</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstOutWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="color=#0000ff">
                                <b>Supplier</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtSupplierPK" styles="display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                                <b>Charger</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="WareHouse" onclick="OnPopUp('WAREHOUSE')" href="#tips" style="color: #0000ff">
                                <b>In W/H</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstInWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/O No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtPONo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color: #0000ff"><b>P/L</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap" title="Total Invoice Bales">
                            T.I Bales
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtTotalInvBales" styles="width:100%" type="number" format="#,###,###.##R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('Shipper')" href="#tips" style="color: #0000ff"><b>Shipper</b></a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:list id="lstShipComp" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLCNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap" title="Total Actual Bales">
                            T.A Bales
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtTotalActBales" styles="width:100%" type="number" format="#,###,###.##R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Invoice No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtInvoiceNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            Tax %
                        </td>
                        <td>
                            <gw:textbox id="txtTax" styles="display:100%" type="number" format="#,###,###.##"
                                onchange="TotalAmount()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap" title="Sum Invoice Amount">
                            S.I Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtSumInvAmt" styles="width:100%" type="number" format="#,###,###.0000R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            B/L No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtBLNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            CCY
                        </td>
                        <td>
                            <gw:list id="lstCCY" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap" title="Sum Actual Amount">
                            S.A Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtSumActAmt" styles="width:100%" type="number" format="#,###,###.0000R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Lot No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLotNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Mark
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtMark" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Gap Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtGapAmt" styles="width:100%" type="number" format="#,###,###.0000R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('G/LTYPE')" href="#tips" style="color: #0000ff">Claim Type</a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:list id="lstClaimType" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Gap Tax
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtGapTax" styles="width:100%" type="number" format="#,###,###.##R" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Gap Total Amt
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtGapTotalAmt" styles="width:100%" type="number" format="#,###,###.0000R" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Remark
                        </td>
                        <td colspan="15">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="16">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td align="center" style="width: 10%; background: #FAE396">
                                        Weight
                                    </td>
                                    <td align="center" style="width: 12%; background: #FAE396">
                                        Invoice KG
                                    </td>
                                    <td align="center" style="width: 12%; background: #FAE396">
                                        Actual KG
                                    </td>
                                    <td align="center" style="width: 12%; background: #FAE396">
                                        GAP KG
                                    </td>
                                    <td align="center" style="width: 18%; background: #FAE396">
                                        Invoice LBS
                                    </td>
                                    <td align="center" style="width: 18%; background: #FAE396">
                                        Actual LBS
                                    </td>
                                    <td align="center" style="width: 18%; background: #FAE396">
                                        GAP LBS
                                    </td>
                                </tr>
                                <tr>
                                    <td style="white-space: nowrap">
                                        Net Weight
                                    </td>
                                    <td>
                                        <gw:textbox id="txtNetW_INVC_KG" styles="width:100%;" type="number" format="#,###,###.00R"
                                            onchange="OnWeightInvoice()" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtNetW_ACT_KG" styles="width:100%;" type="number" format="#,###,###.00R"
                                            onchange="OnWeightActual()" />
                                    </td>
                                    <td style="background: #FFC4DC">
                                        <gw:textbox id="txtNetW_GAP_KG" styles="width:100%;" type="number" format="#,###,###.00R"
                                            onchange="OnWeightGap()" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtNetW_INVC_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtNetW_ACT_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #FFC4DC">
                                        <gw:textbox id="txtNetW_GAP_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="white-space: nowrap">
                                        Tare Weight
                                    </td>
                                    <td>
                                        <gw:textbox id="txtTareW_INVC_KG" styles="width:100%;" type="number" format="#,###,###.00R"
                                            onchange="OnWeightInvoice()" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtTareW_ACT_KG" styles="width:100%;" type="number" format="#,###,###.00R"
                                            onchange="TotalAmount()" />
                                    </td>
                                    <td style="background: #FFC4DC">
                                        <gw:textbox id="txtTareW_GAP_KG" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtTareW_INVC_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtTareW_ACT_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #FFC4DC">
                                        <gw:textbox id="txtTareW_GAP_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="white-space: nowrap">
                                        Gross Weight
                                    </td>
                                    <td>
                                        <gw:textbox id="txtGrossW_INVC_KG" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtGrossW_ACT_KG" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="background: #FFC4DC">
                                        <gw:textbox id="txtGrossW_GAP_KG" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtGrossW_INVC_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #F5FABE">
                                        <gw:textbox id="txtGrossW_ACT_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                    <td style="width: 12%; background: #FFC4DC">
                                        <gw:textbox id="txtGrossW_GAP_LBS" styles="width:100%;" type="number" format="#,###,###.00R" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="16">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 5%" align="right">
										Actual WT
                                    </td>
                                    <td style="width: 30%; white-space: nowrap" align="center">
										<gw:textbox id="txtDVDActualWeight" type="number" format="#,###,###,###,###.###R" styles="width:100%;" onenterkey="OnProcess('DVD_ACTUAL_WEIGHT')"  />
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="16">
                            <gw:grid id='grdDetail' header='_detail_pk|_master_pk|Seq|_item_pk|Item Code|Item Name|Lot No|Invoice Bales|Actual Bales|Invoice KG|Actual KG|Gap KG|Invoice LBS|Actual LBS|Invoice AVG|Actual AVG|Unit Price|Invoice Amt|Actual Amt'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||||||' editcol='0|0|1|0|1|1|1|0|1|0|1|0|0|1|0|0|1|0|0' widths='0|0|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit='CheckInput()' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:list id="lstTransType" styles='width:100%;display: none' />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtLang" styles='width:100%;display:none' />
<gw:textbox id="txtItemCD_Search" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtItemNM_Search" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtCompanyPK" text="" style="display: none" />
<!---------------------------------------------------------------------------------->
<gw:grid id="grdItem_Search" header="pk|item_cd|item_nm" format="0|0|0" aligns="0|0|0"
    defaults="||" editcol="1|1|1" widths="0|0|0" styles="width:100%; height:200;display:none"
    sorting="F" param="0,1,2" />
<!--------------------------------------------------------------------------------->
<!--------------------------------------------------------------------------------->
</html>
