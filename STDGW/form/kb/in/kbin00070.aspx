<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Incoming Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//-----------------------------------------------------

var flag;

var GS_MASTER_PK = 0,
    GS_SLIP_NO   = 1,
    GS_DATE    = 2,
    GS_INVOICE    = 3;

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
	
	txtSlipNo.SetEnable(false);
	txtIncomingSlip.SetEnable(false);
	
    txtStaffName.SetEnable(false);
    txtSupplierName.SetEnable(false);
    txtPLName.SetEnable(false);    
    
    txtW_INVC_KG.SetEnable(false);      
    txtW_INVC_LBS.SetEnable(false);  
    txtW_INVC_BALES.SetEnable(false);
    txtW_INVC_AMT.SetEnable(false);
    
    txtW_ACT_KG.SetEnable(false);      
    txtW_ACT_LBS.SetEnable(false);  
    txtW_ACT_BALES.SetEnable(false);
    txtW_ACT_AMT.SetEnable(false);
    
    txtW_GAP_KG.SetEnable(false);      
    txtW_GAP_LBS.SetEnable(false);  
    txtW_GAP_BALES.SetEnable(false);
    txtW_GAP_AMT.SetEnable(false);
    
    idBtnApprove.SetEnable(false);
    idBtnCancel.SetEnable(false);
    idBtnAutoSlip.SetEnable(false);     
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
    OnAddNew('Master');    
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0110' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
     lstClaimType.SetDataText(data); 
     lstClaimType.value = 'L' ;     
     //----------------------- 
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
    /*var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_INVOICE_BALES)     = 1;
    ctr.ColFormat(G1_ACTUAL_BALES)      = 1;
    ctr.ColFormat(G1_INVOICE_KG)        = 1;
    ctr.ColFormat(G1_ACTUAL_KG)         = 1;
    ctr.ColFormat(G1_GAP_KG)            = 1;
    ctr.ColFormat(G1_INVOICE_AVG)       = 1;
    ctr.ColFormat(G1_ACTUAL_AVG)        = 1;
    ctr.ColFormat(G1_UNIT_PRICE)        = 1;
    ctr.ColFormat(G1_INVOICE_AMT)       = 1;
    ctr.ColFormat(G1_ACTUAL_AMT)        = 1;*/
    
    arr_FormatNumber[G1_INVOICE_BALES]   = 2;
    arr_FormatNumber[G1_ACTUAL_BALES]    = 2;
    arr_FormatNumber[G1_INVOICE_KG]      = 2;
    arr_FormatNumber[G1_ACTUAL_KG]       = 2;
    arr_FormatNumber[G1_GAP_KG]          = 2;
    arr_FormatNumber[G1_INVOICE_LBS]     = 2;
    arr_FormatNumber[G1_ACTUAL_LBS]      = 2;
    arr_FormatNumber[G1_INVOICE_AVG]     = 2;
    arr_FormatNumber[G1_ACTUAL_AVG]      = 2;
    arr_FormatNumber[G1_UNIT_PRICE]      = 2;
    arr_FormatNumber[G1_INVOICE_AMT]     = 2;
    arr_FormatNumber[G1_ACTUAL_AMT]      = 2;
 }
 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_kbin00070_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
        break;  
        
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=|Y|||Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_INCOME_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_CODE,   arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_NAME,   arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_UOM,         arrTemp[5]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,     arrTemp[7]);//Price 
							
							InputProcess( G1_UNIT_PRICE, grdDetail.rows-1 );                           
                    }	
             }        
        break;                    
           
        case 'SCAN':
             var path = System.RootURL + '/form/fp/ab/fpab00680.aspx?warehouse_pk='+ lstWH.value + '&p_type=1' ;
             var object = System.OpenModal( path ,1100 , 600 ,  'resizable:yes;status:yes',this);
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TCO_ITEM_PK, arrTemp[5]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Code,   arrTemp[6]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Name,   arrTemp[7]);//item_name
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TakeIn_Qty,  arrTemp[8]);//IQC QTY - Take In Qty
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,         arrTemp[9]);//item_uom                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_No, arrTemp[4]);//PO No	 

                            grdDetail.SetGridText( grdDetail.rows-1, G1_TPR_REQIQCD_PK, arrTemp[0] );//TPR_REQIQCD_PK
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TakeIn_DT, dtVoucherDate.value );//Take In Date

                            
                    }		            
             }                                                                 
        break; 
        
        case 'InRequest':
             var path = System.RootURL + '/form/bi/ni/bini00034.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes',this);
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);  
                              	                                               
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text);  
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,         arrTemp[3]);    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_INCOME_ITEM_PK, arrTemp[7]);	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_CODE,   arrTemp[8]);
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_NAME,   arrTemp[9]);
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_QTY,         arrTemp[10]);
                            grdDetail.SetGridText( grdDetail.rows-1, G1_IN_UOM,         arrTemp[11]);                  
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,   arrTemp[12]);	 
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_AMT,     arrTemp[13]);
                            grdDetail.SetGridText( grdDetail.rows-1, G1_QC_IREQ_D_PK, arrTemp[0] );//Take In Date

                            InputProcess( G1_UNIT_PRICE, grdDetail.rows-1 );
                    }		            
             }                                                                 
        break; 
        
        case 'PO2':
             var path = System.RootURL + '/form/kb/in/kbin00052.aspx';
             var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEM_PK, arrTemp[6]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE,   arrTemp[7]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME,   arrTemp[8]);//item_name
                        
                        if(txtLotNo.text != "")
                        {
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  txtLotNo.text + "-" + (grdDetail.rows-1));//item_name
                        }
                        grdDetail.SetGridText( grdDetail.rows-1, G1_NET_KG, arrTemp[9]);//in qty 01	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,       arrTemp[13] );//Item Price
                        
                        //InputProcess( G1_UNIT_PRICE, grdDetail.rows-1 );                                                                                      
                    } 
                    //------------------- 
                               
             }                                                                 
        break;   
        
        case 'PO1':
             var path = System.RootURL + '/form/bi/ni/bini00032.aspx';
             var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
						if ( arrTemp[6] != '' )
						{
                        	grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[6]);//Ref No
						}
						else
						{
							grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[8]);//PO Seq
						}							
						
                        grdDetail.SetGridText( grdDetail.rows-1, G1_PO_D_PK, arrTemp[7]);//PO Detail PK	

                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,    arrTemp[9]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INCOME_ITEM_PK, arrTemp[9]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_CODE,   arrTemp[10]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_IN_ITEM_NAME,   arrTemp[11]);//item_name
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[16]);//in qty 01	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[12]);//item_uom
                        grdDetail.SetGridText( grdDetail.rows-1, G1_IN_QTY,  arrTemp[16]);//in qty 01
                        grdDetail.SetGridText( grdDetail.rows-1, G1_IN_UOM,  arrTemp[12]);//uom
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE, arrTemp[17] );//Item Price
                        grdDetail.SetGridText( grdDetail.rows-1, G1_TAX_RATE,   arrTemp[19] );//VAT Rate
                        
                        InputProcess( G1_UNIT_PRICE, grdDetail.rows-1 );                                                                                       
                    } 
                    //-------------------                                  
             }                                                                 
        break;                                        
    }
}  

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbin00070.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_kbin00070_1.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_kbin00070_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                }
                
                flag = 'view' ;
                data_kbin00070_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kbin00070_2.Call("SELECT");
        break;
    }
}

function OnCheckStatus()
{
            if(lblStatus.text == 'SAVED' || lblStatus.text == 'CANCEL')
            {
                idBtnApprove.SetEnable(true);
                idBtnCancel.SetEnable(false);
                idBtnAutoSlip.SetEnable(false);
            }
            else
            {
                idBtnApprove.SetEnable(false);
                if(txtAccSlipNo.text == "")
                {
                    idBtnCancel.SetEnable(true) ;
                    idBtnAutoSlip.SetEnable(true) ;
                }
                else
                {
                    idBtnCancel.SetEnable(false) ;
                    idBtnAutoSlip.SetEnable(false) ;
                }
            } 
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_kbin00070_1": 
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
                //----------------------------
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }
                            
        break;

        case "data_kbin00070_2":
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBgColor( 1, G1_INVOICE_BALES , grdDetail.rows - 1, G1_INVOICE_BALES , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_KG , grdDetail.rows - 1, G1_INVOICE_KG , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_AVG , grdDetail.rows - 1, G1_INVOICE_AVG , 0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_INVOICE_AMT , grdDetail.rows - 1, G1_INVOICE_AMT , 0xCCFFFF );
            }         
        break;

        case 'pro_kbin00070':
            alert(txtReturnValue.text);
          
		    flag = 'view' ;
            data_kbin00070_1.Call("SELECT");
        break;   
        
        case 'pro_kbin00070_1':
            alert(txtReturnValue.text);
        break; 
		
	    case 'data_fpab00220_2':
			 if ( txtLGGroupCodeID.text == 'LGKB0110')
			 {
				 lstClaimType.SetDataText(txtLGCodeList.text);
				 lstClaimType.value = rtnLGCode;
			 }
		break;
		
		case'data_fpab00110_2':
		    if ( grdItem_Search.rows > 2 || grdItem_Search.rows == 1 )
            {
                
                var queryString = "?item_cd=" + url_encode(txtItemCD_Search.text)
                                              + "&item_nm="
                                              + url_encode(txtItemNM_Search.text);

                txtItemCD_Search.text   = '' ; 
                txtItemNM_Search.text   = '' ;                                     
                                         
                GetItem(queryString); 
                //-------------------                
            }
            else if ( grdItem_Search.rows == 2 )
            {
                if ( gPreviousRow > 0 )
                {
		            grdDetail.SetGridText( gPreviousRow, G1_INCOME_ITEM_PK, grdItem_Search.GetGridData( 1, 0) );//item_pk
		            grdDetail.SetGridText( gPreviousRow, G1_IN_ITEM_CODE,   grdItem_Search.GetGridData( 1, 1) );//item_id
		            grdDetail.SetGridText( gPreviousRow, G1_IN_ITEM_NAME,   grdItem_Search.GetGridData( 1, 2) );//item_name
		        }
		        grdItem_Search.ClearData();
		        gPreviousRow = -1 ;
		        //------------
            }
		break;
		
		case 'pro_kbin00070_3':
			alert("Copy finish.");
			
			flag = 'view' ;
            data_kbin00070_1.Call("SELECT");
		break;
		case 'pro_kbin00070_4':
			alert(txtReturnValue.text);
		break;
   }            
}
//--------------------------------------------------------------------------------------------------
function GetItem(p_querystring)
{

    var fpath = System.RootURL + "/form/fp/ab/fpab00110.aspx" + p_querystring + "&group_type=Y|Y|Y|Y|Y|Y";
    var aValue  = window.showModalDialog(  fpath , this , 'resizable:yes;toolbar=no;dialogWidth:45;dialogHeight:32');	
	
	if ( aValue != null ) 
	{
	    if ( gPreviousRow > 0 ) 
	    {	
		    grdDetail.SetGridText( gPreviousRow, G1_INCOME_ITEM_PK, aValue[0] );//spec_pk
		    grdDetail.SetGridText( gPreviousRow, G1_IN_ITEM_CODE,   aValue[1] );//spec_id
		    grdDetail.SetGridText( gPreviousRow, G1_IN_ITEM_NAME,   aValue[2] );//spec_name
		    
		    gPreviousRow = -1 ;		    
		}
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
            
		case 'Invoice' :
             var path = System.RootURL + "/form/kb/in/kbin00051.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtPONo.text   = object[0];
                txtLCNo.text = object[1];                
                txtBLNo.text = object[2];                
                txtMark.text = object[3];                
                lstShipComp.value = object[4];                
	         }
        break;
        
        case 'Incoming_Slip':
             var path = System.RootURL + "/form/kb/in/kbin00061.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes',this);
	         if ( object != null )
	         {
	            var arrTemp, sumInvoiceBales = 0, sumActualBales = 0;
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
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_BALES, arrTemp[9]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_KG,  arrTemp[7]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_AVG,  arrTemp[12]);
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_INVOICE_AMT,  arrTemp[11]);
                        sumInvoiceBales += Number(arrTemp[8]);
                    } 
                    //txtW_INVC_BALES.text = System.Round(sumInvoiceBales, 2);
                    //txtW_ACT_BALES.text = System.Round(sumActualBales, 2);
                    //txtW_GAP_BALES.text = System.Round(sumActualBales - sumInvoiceBales, 2);
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
        case 'Submit' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to submit this Slip?'))
                {
                    pro_kbin00070.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                         
        break;
        
        case 'OutGo' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make outgoing slip?'))
                {
                    pro_kbin00070_1.Call();
                } 
            }
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                  
        break;   
        
        case 'Trans' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make transfer slip?'))
                {
                    pro_kbin00070_2.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                 
        break; 
		
        case 'Copy' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make a copy for this slip?'))
                {
                    pro_kbin00070_3.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                 
        break; 	
		
        case 'Return' :             
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to return supplier for this slip?'))
                {
                    pro_kbin00070_4.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                 
        break; 		
		
		case 'CAL-AMOUNT':
			if ( confirm('Do you want to auto calculate Amount ?') )
            {
                InputProcess();
				/*for ( var i=1; i < grdDetail.rows; i++ )
				{			 					 
					InputProcess( G1_UNIT_PRICE, i );			 
				}*/
			}
		break;               
    }
}
//======================================================================
function InputProcess()
{
    for(var row = 1; row < grdDetail.rows; row++)
    {
                var dQuantiy = grdDetail.GetGridData( row, G1_NET_KG) ;
                var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
                var dBales   = grdDetail.GetGridData( row, G1_BALES) ;
            
                var dAmount = Number(dQuantiy) * Number(dPrice);
                //grdDetail.SetGridText( row, G1_AMOUNT, System.Round( dAmount, arr_FormatNumber[G1_AMOUNT] ));
                grdDetail.SetGridText( row, G1_AMOUNT, dAmount);
                
                var dDverage = Number(dQuantiy)/Number(dBales);
                //grdDetail.SetGridText( row, G1_AVERAGE , System.Round( dDverage, arr_FormatNumber[G1_AVERAGE] ) ) ;
                grdDetail.SetGridText( row, G1_AVERAGE, dDverage);
                txtSumOfBales.text = Number(txtSumOfBales.text) + Number(dBales);
}
            TotalAmount();  
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
                data_kbin00070_1.Call();
                flag='save';  
        break;
        
        case 'Detail':        
            data_kbin00070_2.Call();
        break;
    }
}

//=================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                 var event_col = event.col ;
                 var event_row = event.row ;

                 if ( event_col == G1_REQ_UOM || event_col == G1_IN_UOM || event_col == G1_REF_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00640.aspx?p_item_pk=' + grdDetail.GetGridData( event_row, G1_INCOME_ITEM_PK ) + '&p_uom=' + grdDetail.GetGridData( event_row, G1_IN_UOM );
	                   var obj = System.OpenModal( path ,550 , 300, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[0]);
	                   }	
                 }
                 else if ( event_col == G1_IN_ITEM_CODE || event_col == G1_IN_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_INCOME_ITEM_PK, object[0] );
                            grdDetail.SetGridText( event_row, G1_IN_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G1_IN_ITEM_NAME,   object[2] );
                       }                       
                 }
				 else if ( event_col == G1_LOT_NO )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00690.aspx?item_pk=' + grdDetail.GetGridData( event_row, G1_INCOME_ITEM_PK ) + '&item_code=' + grdDetail.GetGridData( event_row, G1_IN_ITEM_CODE ) + '&item_name=' + grdDetail.GetGridData( event_row, G1_IN_ITEM_NAME ) + '&lot_no=' + grdDetail.GetGridData( event_row, G1_LOT_NO ) + '&partner_pk=' + txtSupplierPK.text + '&partner_name=' + txtSupplierName.text  ;
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                                                               
                 }
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
                data_kbin00070_1.StatusDelete();
                data_kbin00070_1.Call();
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
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData( i, G1_NET_KG)) == 0 )
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//=================================================================================
function CheckInput()
{   
    var col, row, InvoiceKg, ActualKg;
    col = event.col;
    row = event.row; 
    
    if ( col == G1_ACTUAL_BALES || col == G1_ACTUAL_KG || col == G1_UNIT_PRICE)
    {
        var dQuantiy ;
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {
            if (dQuantiy >0)
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
        if ( chkAutoCal.value == 'Y' )
        {
            InvoiceKg = grdDetail.GetGridData( row, G1_INVOICE_KG) ;
            ActualKg  = grdDetail.GetGridData( row, G1_ACTUAL_KG) ;
            
            InvoiceBales = grdDetail.GetGridData( row, G1_INVOICE_BALES) ;
            ActualBales  = grdDetail.GetGridData( row, G1_ACTUAL_BALES) ;
                      
            InvoiceLBS = grdDetail.GetGridData( row, G1_INVOICE_LBS) ;   
            ActualLBS = Number(ActualKg) * 2.20460000186 ;
            
            grdDetail.SetGridText( row, G1_ACTUAL_LBS , System.Round( ActualLBS, arr_FormatNumber[G1_ACTUAL_LBS] ) ) ;
                     
            grdDetail.SetGridText( row, G1_INVOICE_AVG , System.Round( InvoiceKg/InvoiceBales, arr_FormatNumber[G1_INVOICE_AVG] ) ) ;
            grdDetail.SetGridText( row, G1_ACTUAL_AVG , System.Round( ActualKg/ActualBales, arr_FormatNumber[G1_ACTUAL_AVG] ) ) ;
            grdDetail.SetGridText( row, G1_GAP_KG , System.Round( ActualKg-InvoiceKg, arr_FormatNumber[G1_GAP_KG] ) ) ;
            
            var UnitPrice = Number(grdDetail.GetGridData( row, G1_UNIT_PRICE)) ;
            grdDetail.SetGridText( row, G1_INVOICE_AMT , System.Round( Number(InvoiceLBS)*UnitPrice, arr_FormatNumber[G1_INVOICE_AMT] ) ) ;
            grdDetail.SetGridText( row, G1_ACTUAL_AMT , System.Round( ActualLBS*UnitPrice, arr_FormatNumber[G1_ACTUAL_AMT] ) ) ;
            
            //OnWeightKG();
            //OnWeightActual();
            TotalAmount();  
        } 
    }
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
	var sumActualKG = 0;
	var sumGapKG = 0;
    for ( i=1; i<grdDetail.rows; i++ )
    {
		sumActualKG  = sumActualKG  + Number(grdDetail.GetGridData( i, G1_ACTUAL_KG ));
    }
    txtW_ACT_KG.text = System.Round( sumActualKG,  2 ) ;
    txtW_GAP_KG.text = System.Round(Number(txtW_ACT_KG.text) - Number(txtW_INVC_KG.text),2);
    txtW_ACT_LBS.text  = System.Round(Number(txtW_ACT_KG.text) * 2.20460000186 ,2);   
    txtW_GAP_LBS.text  = System.Round(Number(txtW_ACT_LBS.text) - Number(txtW_INVC_LBS.text),2);
    
    txtExAmt.text = Number(txtClaimAmt.text) * Number(txtExRate.text);
    txtTaxAmt.text = Number(txtTax.text) * (Number(txtExAmt.text)/100);
    txtTotalAmt.text = Number(txtExAmt.text) + Number(txtTaxAmt.text);
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
//=================================================================================
function OnPrint()
{    
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/bi/ni/rpt_kbin00070.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_kbin00070_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
	}
}
//=================================================================================
function OnPrint1()
{    
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/bi/ni/rpt_kbin00070_1.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_kbin00070_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
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
		
        case'1':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00032.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank");			 
        break;
		
        case'2':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00033.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
        case'3':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00034.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank");
		break;	
			 
	    case'4':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00036.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
		case 'DORCO':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00031_DORCO.aspx?master_pk=' + txtMasterPK.text ;
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
function OnWeightKG()
{
     if (IsNumeric(txtW_INVC_KG.text))
     {
         txtW_GAP_KG.text  = Number(txtW_INVC_KG.text) + Number(txtW_ACT_KG.text);   
     }     
     if (IsNumeric(txtW_ACT_KG.text))
     {
         txtGrossW_INVC_KG.text = Number(txtNetW_INVC_KG.text) + Number(txtTareW_INVC_KG.text);
         txtW_ACT_LBS.text  = Number(txtW_ACT_KG.text) * 2.20460000186 ;   
     }     
}
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
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbin00070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_kbin00070_1" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtNoSearch" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />                      
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbin00070_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47" function="<%=l_user%>lg_sel_kbin00070_2"  procedure="<%=l_user%>lg_upd_kbin00070_1"> 
                <inout>      
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtIncomingSlip" />
                     <inout  bind="dtIncomingDate" />
                     <inout  bind="dtInspectionDate" />
                     <inout  bind="dtDepositDate" />
                     <inout  bind="dtClaimDate" />
                     <inout  bind="txtSlipNo" />                          
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierName" />
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="cboCompanyList" />
                     <inout  bind="txtPONo" />
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
                     <inout  bind="lstClaimType" />
                     
                     <inout  bind="lstPaymentYN" /> 
                     <inout  bind="lstPaymentType" /> 
                     <inout  bind="txtTaxAmt" /> 
                     <inout  bind="txtExRate" /> 
                     <inout  bind="txtExAmt" /> 
                     
                     <inout  bind="txtClaimAmt" />  
                     <inout  bind="txtTotalAmt" />
                     
                     <inout  bind="txtW_INVC_KG" />
                     <inout  bind="txtW_INVC_LBS" />  
                     <inout  bind="txtW_INVC_BALES" />
                     <inout  bind="txtW_INVC_AMT" />
                     <inout  bind="txtW_INVC_REMARK" />  
                     
                     <inout  bind="txtW_ACT_KG" />
                     <inout  bind="txtW_ACT_LBS" />    
                     <inout  bind="txtW_ACT_BALES" />  
                     <inout  bind="txtW_ACT_AMT" />
                     <inout  bind="txtW_ACT_REMARK" />
                     
                     <inout  bind="txtW_GAP_KG" />  
                     <inout  bind="txtW_GAP_LBS" />
                     <inout  bind="txtW_GAP_BALES" />
                     <inout  bind="txtW_GAP_AMT" />  
                     <inout  bind="txtW_GAP_REMARK" />
                     <inout  bind="lblStatus" />                                     
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbin00070_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="<%=l_user%>lg_sel_kbin00070_4"   procedure="<%=l_user%>lg_upd_kbin00070_2"> 
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
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Date|Invoice No' format='0|0|4|0' aligns='0|0|0|0'
                                check='|||' editcol='1|1|1|1' widths='1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 100%; height: 1%" colspan="15">
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
                            Inspection Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtInspectionDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Company
                        </td>
                        <td style="width: 10%" align="center" colspan="5">
                            <gw:list id="cboCompanyList" styles="width:100%" onchange="data_agci00060.Call()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Incoming Slip
                        </td>
                        <td>
                            <gw:textbox id="txtIncomingSlip" styles="width:100%" />
                        </td>
                        <td style="width: 5%" align="right">
                            Inc Date
                        </td>
                        <td>
                            <gw:datebox id="dtIncomingDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('G/LTYPE')" href="#tips" style="color: #0000ff">Claim Type</a>
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstClaimType" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Claim Date
                        </td>
                        <td>
                            <gw:datebox id="dtClaimDate" lang="1" />
                        </td>
                        <td align="right" style="width: 5%">
                            Deposit Date
                        </td>
                        <td>
                            <gw:datebox id="dtDepositDate" lang="1" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Payment Y/N
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstPaymentYN" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/O No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtSupplierPK" styles="display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                                <b>Charger</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Payment Type
                        </td>
                        <td colspan="11">
                            <gw:list id="lstPaymentType" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLCNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color: #0000ff"><b>P/L</b></a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Claim Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtClaimAmt" styles="width:100%" type="number" format="#,###,###.##" />
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
                            <a onclick="OnPopUp('Shipper')" href="#tips" style="color: #0000ff"><b>Shipper</b></a>
                        </td>
                        <td>
                            <gw:list id="lstShipComp" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            CCY
                        </td>
                        <td style="width: 10%">
                            <gw:list id="lstCCY" styles="width:100%;" />
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtExRate" styles="width:100%" type="number" format="#,###,###.##"
                                onchange="TotalAmount()" />
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
                            Tax %
                        </td>
                        <td>
                            <gw:textbox id="txtTax" styles="display:100%" onchange="TotalAmount()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Ex Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtExAmt" styles="width:100%" type="number" format="#,###,###.##"
                                onchange="TotalAmount()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Mark
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtMark" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Lot No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLotNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Tax Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtTaxAmt" styles="width:100%" type="number" format="#,###,###.##" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Remark
                        </td>
                        <td>
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                        <td align="right">
                            P/O No
                        </td>
                        <td>
                            <gw:textbox id="txtPONo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Total Amount
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtTotalAmt" styles="width:100%" type="number" format="#,###,###.##" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="15">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td align="center" style="width: 12%">
                                        &nbsp;
                                    </td>
                                    <td align="center" style="background: #FAE396">
                                        Weight KG
                                    </td>
                                    <td align="center" style="background: #FAE396">
                                        Weight LBS
                                    </td>
                                    <td align="center" style="background: #FAE396">
                                        Bales
                                    </td>
                                    <td align="center" style="background: #FAE396">
                                        Amount
                                    </td>
                                    <td align="center" style="background: #FAE396">
                                        Remark
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Invoice
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_INVC_KG" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_INVC_LBS" styles="width:100%;" type="number" format="#,###,###.##"
                                            onchange="OnWeightActual()" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_INVC_BALES" styles="width:100%;" type="number" format="#,###,###.##"
                                            onchange="OnWeightGap()" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_INVC_AMT" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_INVC_REMARK" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Actual
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_ACT_KG" styles="width:100%;" type="number" format="#,###,###.##"
                                            onchange="OnWeightKG()" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_ACT_LBS" styles="width:100%;" type="number" format="#,###,###.##"
                                            onchange="OnWeightActual()" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_ACT_BALES" styles="width:100%;" type="number" format="#,###,###.##"
                                            onchange="OnWeightGap()" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_ACT_AMT" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_ACT_REMARK" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        Gap
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_GAP_KG" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_GAP_LBS" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td>
                                        <gw:textbox id="txtW_GAP_BALES" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_GAP_AMT" styles="width:100%;" type="number" format="#,###,###.##" />
                                    </td>
                                    <td style="width: 12%">
                                        <gw:textbox id="txtW_GAP_REMARK" styles="width:100%;" />
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
                                    <td style="width: 64%" align="right">
                                        <gw:imgbtn img="process" alt="Cal Amount" id="btnCalAmount" styles='width:100%; display:none'
                                            onclick="OnProcess('CAL-AMOUNT')" />
                                    </td>
                                    <td style="width: 19%; white-space: nowrap" align="center">
                                        <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" style="display: none" />
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
                                        <gw:icon id="idBtnPO2" img="2" text="P/O" styles='width:100%; display:none' onclick="OnAddNew('PO2')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="copy" alt="Copy" styles='width:100%; display:none' id="btnCopy" onclick="OnCopy()" />
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
                                format='0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1' aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
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
