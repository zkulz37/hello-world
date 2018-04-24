<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock OutGoing Entry</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//-----------------------------------------------------

var flag;

var G_PK        = 0,
    G_Status    = 1,
    G_SLip_No   = 2,
    G_Date      = 3,
	G_DEPT		= 4,
    G_LINE    	= 5;

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_SEQ              = 1,
    G1_REF_NO           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_REQ_ITEM_CODE    = 4,
    G1_REQ_ITEM_NAME    = 5,
    G1_OUTGO_ITEM_PK    = 6,
    G1_OUT_ITEM_CODE    = 7,
    G1_OUT_ITEM_NAME    = 8,
    G1_REQ_QTY          = 9,
    G1_REQ_UOM          = 10,
    G1_OUT_QTY          = 11,
    G1_OUT_UOM          = 12,
    G1_REF_QTY          = 13,
    G1_REF_UOM          = 14,
    G1_UPRICE           = 15,
    G1_ITEM_AMT         = 16,
    G1_TAX_RATE         = 17,
    G1_TAX_AMT          = 18,
    G1_TOTAL_AMT        = 19,
    G1_LOT_NO           = 20,
    G1_ITEM_BC          = 21,
    G1_REMARK           = 22,
    G1_MASTER_PK        = 23,
    G1_PO_D_PK          = 24 ,
    G1_QC_IREQ_D_PK     = 25,
	G1_TABLE_PK			= 26,
	G1_TABLE_NAME		= 27;
    
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
	
	txtLang.text = "<%=Session("SESSION_LANG")%>";
     
    txtStaffName.SetEnable(false);
    txtReceiverName.SetEnable(false);
    txtPLName.SetEnable(false);    
   
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------    
    BindingDataList();    
    //----------------------------         
    SetGridFormat();  
    OnToggleGrid();
    //----------------------------
    OnAddNew('Master');
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
	 
     //----------------------- 
	 
     //data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0 and use_yn = 'Y' ORDER BY line_id" )%>";    
     //lstLine.SetDataText(data);
	 
	 data = "<%=ESysLib.SetListDataSQL("select pk,DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where a.use_yn='Y' and del_if=0 order by DEPT_ID")%>||"; 
     lstDept.SetDataText(data);
	 lstDept.value = "";
	 
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);
     lstCurrency.value = "USD"; 
	 	 
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0302') FROM DUAL" )%>||";    
     lstOutType.SetDataText(data); 
	 lstOutType.value = ""; 
	 
     pro_bini00050_lst.Call()
                      
 }
 //==================================================================================

 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_REQ_QTY) 	= "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_OUT_QTY) 	= "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_UPRICE)    = "#,###,###,###,###,###";
    ctr.ColFormat(G1_ITEM_AMT)  = "#,###,###,###,###,###";
    ctr.ColFormat(G1_TAX_RATE)  = "#,###,###,###,###,###";
    ctr.ColFormat(G1_TAX_AMT)   = "#,###,###,###,###,###";
    ctr.ColFormat(G1_TOTAL_AMT) = "#,###,###,###,###,###";
    
    arr_FormatNumber[G1_REQ_QTY] = 3;
    arr_FormatNumber[G1_OUT_QTY] = 3;
     
    arr_FormatNumber[G1_UPRICE]    = 0;
    arr_FormatNumber[G1_ITEM_AMT]  = 0;
    arr_FormatNumber[G1_TAX_RATE]  = 0;
    arr_FormatNumber[G1_TAX_AMT]   = 0;
    arr_FormatNumber[G1_TOTAL_AMT] = 0;    
 }
 //==================================================================================

function  OnChangeDate()
{
	var	ldate=dtVoucherDate.value ;       
    ldate = ldate.substr(2,4)  ; 
    lstOutType.value = ldate;
}

 //==================================================================================

  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_bini00050_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;  
        //==========================================
		case 'DETAIL':                          
			grdDetail.AddRow();
			
			grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, 	grdDetail.rows-1   );	
			
			grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk				
        break;
		//==========================================		
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
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM,       arrTemp[5]);//item_uom
							
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UPRICE,(Number(arrTemp[7])>0?arrTemp[7]:arrTemp[6]) );//Price  

							CheckInput( grdDetail.rows-1, G1_UPRICE);	
                    }	
             }        
        break;                  

		//==========================================		
        case 'ITEM_SPEC':
             var path = System.RootURL + '/form/fp/ab/fpab00073.aspx?group_type=|Y|||Y|Y';//purchase_yn=Y
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
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM,       arrTemp[3]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UPRICE,        arrTemp[13]);//Price                            
                    }	
             }        
        break;   
		
		
        case 'PO1':
             var path = System.RootURL + '/form/bi/ni/bini00052.aspx';
             var object = System.OpenModal( path ,1200 , 600 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,       grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[4]);//PO No
                        grdDetail.SetGridText( grdDetail.rows-1, G1_PO_D_PK, arrTemp[5]);//PO Detail PK	

                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[7]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[7]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[8]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[9]);//item_name
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[13]);//in qty 01	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[10]);//item_uom
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[13]);//in qty 01
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[10]);//uom 
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_UPRICE, arrTemp[14]);//uom 

						CheckInput( grdDetail.rows-1, G1_UPRICE);
						
                    } 
                    //------------------- 
                    TotalAmount();               
             }                                                                 
        break;  
		        
        case 'PO2':
             var path = System.RootURL + '/form/bi/ni/bini00051.aspx';
             var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,       grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[2]);//PO No
                        grdDetail.SetGridText( grdDetail.rows-1, G1_PO_D_PK, arrTemp[1]);//PO Detail PK	

                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[6]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[6]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[7]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[8]);//item_name
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[9]);//in qty 01	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[10]);//item_uom
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[9]);//in qty 01
                        grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[10]);//uom
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_UPRICE,       arrTemp[13] );//Item Price
                        grdDetail.SetGridText( grdDetail.rows-1, G1_TAX_RATE, arrTemp[15] );//VAT Rate
                        
                        var row = grdDetail.rows-1;
                                                
                        dQuantiy = grdDetail.GetGridData( row, G1_REQ_QTY) ;
                        dPrice   = grdDetail.GetGridData( row, G1_UPRICE) ;
                        
                        var dAmount = dQuantiy * dPrice;
                        
                        grdDetail.SetGridText( row, G1_ITEM_AMT, System.Round(dAmount, arr_FormatNumber[G1_ITEM_AMT]) );
                        
                        var dVATAmount = 0 , dTotalAmount = 0 ;
                        
                        dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) * Number(grdDetail.GetGridData( row, G1_TAX_RATE )) / 100 ;                
                        grdDetail.SetGridText( row, G1_TAX_AMT, System.Round( dVATAmount, arr_FormatNumber[G1_TAX_AMT]) ) ;
                        
                        dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMT )) ;
                        grdDetail.SetGridText( row, G1_TOTAL_AMT, System.Round( dTotalAmount, arr_FormatNumber[G1_TAX_AMT]) ) ;                                                                                     
                    } 
                    //------------------- 
                    TotalAmount();               
             }                                                                 
        break;           
        
		case 'STOCK_SPEC':
             var path = System.RootURL + '/form/fp/ab/fpab00411.aspx?group_type=Y|Y|Y|Y|Y|Y&warehouse='+lstWH.value;
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                                                                                      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[3]); //item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[4]); //item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[5]); //item_name
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[13]); //out qty 01	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[6]); //item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[15]);                            
                    }		            
            }       		
		break;
		
        case 'Stock':
             var path = System.RootURL + '/form/fp/ab/fpab00410.aspx?group_type=Y|Y|Y|Y|Y|Y&warehouse='+lstWH.value;
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                                                                                      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[3]); //item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[4]); //item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[5]); //item_name
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[8]); //out qty 01	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[6]); //item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[10]);                            
                    }		            
            }        
        break;  
        
       case 'Req':
             var path = System.RootURL + '/form/bi/ni/bini00053.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	 
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK, arrTemp[7]); //item_pk
                                                           	                                                                                                      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[7]); //item_pk
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[8]); //item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[9]); //item_name

                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[12]);//req qty  	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[13]);//req uom
                                                        
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[12]); //out qty      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[13]); //out uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[14]);  
                    }		            
             }        
        break; 
        
        case 'Request':
             var path = System.RootURL + '/form/bi/ni/bini00055.aspx';
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
                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUTGO_ITEM_PK, arrTemp[7]);                           	                                                                                                      
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_CODE, arrTemp[8]);  
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_ITEM_NAME, arrTemp[9]); 
                                                        
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_QTY, arrTemp[10]);     
                            grdDetail.SetGridText( grdDetail.rows-1, G1_OUT_UOM, arrTemp[11]); 
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[12]);  
                    }		            
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
            data_bini00050.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_bini00050_1.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_bini00050_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                
                flag = 'view' ;
                data_bini00050_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':           
            data_bini00050_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_bini00050_1": 
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
                //---------------------------- 
                OnSearch('grdDetail');   
            }
                            
        break;

        case "data_bini00050_2":
           
            if ( grdDetail.rows > 1 )
            {	            
                grdDetail.SetCellBold( 1, G1_OUT_QTY, grdDetail.rows - 1, G1_OUT_QTY, true);
                
                grdDetail.SetCellBold( 1, G1_REF_NO, grdDetail.rows - 1, G1_REF_NO, true);
                
                grdDetail.SetCellBgColor( 1, G1_REQ_ITEM_CODE , grdDetail.rows - 1, G1_REQ_ITEM_NAME , 0xCCFFFF );
                
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    if ( Number(grdDetail.GetGridData( i, G1_REQ_ITEM_PK)) > 0 && ( grdDetail.GetGridData( i, G1_REQ_ITEM_PK) != grdDetail.GetGridData( i, G1_OUTGO_ITEM_PK) ) )
                    {
                        grdDetail.GetGridControl().Cell( 7, i, G1_OUT_ITEM_CODE, i, G1_OUT_ITEM_NAME ) = 0x3300cc;
                    }                    
                }        
                //--------------------------------                
            }     
			
			loadSum();    
        break;

        case 'pro_bini00050':
            alert(txtReturnValue.text);
            
			flag = 'view' ;
            data_bini00050_1.Call("SELECT");
        break;    
		  
        case 'pro_bini00050_lst':
            lstWH.SetDataText(txtWHStr.text);
            lstWH2.SetDataText(txtWHStr.text +"||");
            lstWH2.value ='';
            pro_bini00050_line_lst.Call();
        break;
        
        case 'pro_bini00050_line_lst':
            lstLine.SetDataText(txtLineStr.text);
        break;
		
		case 'data_fpab00220_2':		 
			 if ( txtLGGroupCodeID.text == 'LGIN0302' )
			 {
				 lstOutType.SetDataText(txtLGCodeList.text);
				 lstOutType.value = rtnLGCode;
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
		            grdDetail.SetGridText( gPreviousRow, G1_OUTGO_ITEM_PK,  grdItem_Search.GetGridData( 1, 0) );//item_pk
		            grdDetail.SetGridText( gPreviousRow, G1_OUT_ITEM_CODE,  grdItem_Search.GetGridData( 1, 1) );//item_id
		            grdDetail.SetGridText( gPreviousRow, G1_OUT_ITEM_NAME,   grdItem_Search.GetGridData( 1, 2) );//item_name
		        }
		        grdItem_Search.ClearData();
		        gPreviousRow = -1 ;
		        //------------
            }
		break;		
		
		case 'pro_bini00050_3':
			alert("Copy finish.");
			
			flag = 'view' ;
            data_bini00050_1.Call("SELECT");
		break;	
			
		case 'pro_bini00050_4':
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
		    grdDetail.SetGridText( gPreviousRow, G1_OUTGO_ITEM_PK,    aValue[0] );//spec_pk
		    grdDetail.SetGridText( gPreviousRow, G1_OUT_ITEM_CODE,  aValue[1] );//spec_id
		    grdDetail.SetGridText( gPreviousRow, G1_OUT_ITEM_NAME,  aValue[2] );//spec_name
		    
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
        case 'Receiver':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtReceiverName.text = obj[2];
                txtReceiverPK.text   = obj[0];
            }
        break;          
        
        case 'PL': // PL
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[6]; 
                txtPLName.text = oValue[2] + ' * ' + oValue[5] ;
            }
        break;
		
		case 'Out_Type':
			 
			 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIN0302";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes'); 

	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGIN0302';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstOutType.value = object[1];      
	            }    	                
	         }   
		break;	
		
		case 'Report':
			if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/bi/ni/bini00054.aspx';
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
        case 'Confirm' :
            if ( txtMasterPK.text != '' )
            {         
                if ( confirm('Do you want to submit this Slip?'))
                {
                    pro_bini00050.Call();
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
                    pro_bini00050_3.Call();
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
                if ( confirm('Do you want to return stock this slip?'))
                {
                    pro_bini00050_4.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}		
		break;	

		case 'copy_detail':
			var i, j, lNewRow;
			
			for (i = 1; i < grdDetail.rows ; i++)
			{
				if(grdDetail.GetGridControl().IsSelected(i))
				{            
					seqInit = OnMaxSeq();
					seqInit = parseInt(seqInit) + 1;
					
					grdDetail.AddRow();
					lNewRow = grdDetail.rows - 1;
					
					for ( j = 0 ; j <= G1_QC_IREQ_D_PK ; j++)
					{
						if (j != G1_SEQ && j != G1_DETAIL_PK )
						{
							grdDetail.SetGridText(lNewRow, j, grdDetail.GetGridData(i, j));
						} 
						grdDetail.SetGridText( lNewRow, G1_SEQ, seqInit);//sequence
					}
				}
			}			
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
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_bini00050_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_bini00050_2.Call();
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

                 if ( event_col == G1_REQ_UOM || event_col == G1_OUT_UOM || event_col == G1_REF_UOM )
                 {					   
						var path = System.RootURL + '/form/fp/ab/fpab00640.aspx?p_item_pk=' + grdDetail.GetGridData( event_row, G1_OUTGO_ITEM_PK ) + '&p_uom=' + grdDetail.GetGridData( event_row, event_col );
						var obj = System.OpenModal( path ,400 , 300, 'resizable:yes;status:yes');						
    	               
						if ( obj != null )
						{
	                        grdDetail.SetGridText( event_row, event_col, obj[0]);
						}	
                 }				 											 
                 else if ( event_col == G1_OUT_ITEM_CODE || event_col == G1_OUT_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_OUTGO_ITEM_PK, object[0] );
                            grdDetail.SetGridText( event_row, G1_OUT_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G1_OUT_ITEM_NAME,   object[2] );
                       }                       
                 }
				 else if ( event_col == G1_OUT_QTY )
                 {
                      var path = System.RootURL + '/form/fp/ab/fpab00770.aspx?p_table_pk=' + grdDetail.GetGridData( event_row, G1_DETAIL_PK ) + '&p_table_name=TLG_ST_OUTGO_D&p_io_type=O'  ;
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
                data_bini00050_1.StatusDelete();
                data_bini00050_1.Call();
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
        if ( Number(grdDetail.GetGridData( i, G1_OUT_QTY)) == 0 )
        {
            alert("Input Out Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//=================================================================================
var gPreviousRow = -1 ;
function CheckInput( row, col )
{        
    if ( col == G1_REQ_QTY || col == G1_OUT_QTY || col == G1_UPRICE || col == G1_ITEM_AMT || col == G1_TAX_RATE || col == G1_TAX_AMT ||col == G1_TOTAL_AMT )
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
            if ( col == G1_OUT_QTY || col == G1_UPRICE || col == G1_TAX_RATE )
            {
                dQuantiy = grdDetail.GetGridData( row, G1_OUT_QTY) ;
                dPrice   = grdDetail.GetGridData( row, G1_UPRICE) ;
                
                var dAmount = dQuantiy * dPrice;
                
                grdDetail.SetGridText( row, G1_ITEM_AMT, System.Round( dAmount, arr_FormatNumber[G1_ITEM_AMT]));
                
                var dVATAmount = 0 , dTotalAmount = 0 ;
                
                dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) * Number(grdDetail.GetGridData( row, G1_TAX_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_TAX_AMT, System.Round( dVATAmount, arr_FormatNumber[G1_TAX_AMT] ) ) ;
                
                dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMT] ) ) ;               
            } 
            else if ( col == G1_ITEM_AMT )
            {
                var dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) * Number(grdDetail.GetGridData( row, G1_TAX_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_TAX_AMT, System.Round( dVATAmount, arr_FormatNumber[G1_TAX_AMT] ) ) ;
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMT] ) ) ;         
            }
            else if ( col == G1_TAX_AMT )
            {
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMT] ) ) ;         
            }
                
            TotalAmount();   
        }                   
    } 
	
    if ( col == G1_OUT_ITEM_CODE || col == G1_OUT_ITEM_NAME)
    {
        gPreviousRow = event.row ;
		
        if(col==G1_OUT_ITEM_CODE)
        {
            txtItemCD_Search.text         = grdDetail.GetGridData(gPreviousRow, G1_OUT_ITEM_CODE);
            txtItemNM_Search.text         = "";
        }
        else
        {
            txtItemCD_Search.text         = "";
            txtItemNM_Search.text         = grdDetail.GetGridData(gPreviousRow, G1_OUT_ITEM_NAME);
        }
               
        data_fpab00110_2.Call('SELECT');
    }     
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G1_TOTAL_AMT));
    }

    txtAmount.text = System.Round( sumAmount, 3 );
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
        var url =System.RootURL + '/reports/bi/ni/rpt_bini00050.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_bini00050_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
	}
}
//=================================================================================
function OnReport(pos)
{
    switch(pos)
    {
        case'0':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00051.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank"); 
        break;
		
        case'1':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00052.aspx?master_pk=' + txtMasterPK.text ;
			window.open(url, "_blank");
			/*var url =System.RootURL + '/reports/bi/ni/rpt_bini00052_2.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank"); */
        break;
		
        case'2':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00053.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank"); 
        break;
		
        case'3':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00054.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank"); 
			
        case'4':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00056.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank");             
        break;
		
		case 'SG01':
			var url =System.RootURL + '/reports/bi/ni/rpt_bini00050.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank");   
		break;
		
		case 'ST01':
			var url =System.RootURL + '/reports/bi/ni/rpt_bini00050_ST01.aspx?master_pk=' + txtMasterPK.text ;
            window.open(url, "_blank");   
		break;		
         case'5':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00050_kb01.aspx?master_pk=' + txtMasterPK.text+'&lstOutType='+lstOutType.value ;
            window.open(url, "_blank");             
        break;
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
function loadSum()
{
		var t_item_qty      = 0  ;
		var t_temp_item_pk  = "" ;
		var t_item_count    = 0  ;
		var t_uom           = "" ;
		
		for ( var i=1; i<grdDetail.rows; i++)				
		{						 
			t_item_qty = Number(t_item_qty) + Number(grdDetail.GetGridData( i, G1_OUT_QTY)) + "" ;
				
			t_uom = grdDetail.GetGridData( i, G1_OUT_UOM);      
			 
			if ( t_temp_item_pk != grdDetail.GetGridData( i, G1_OUTGO_ITEM_PK) )
			{
				t_item_count    = t_item_count + 1 ;
				t_temp_item_pk  = grdDetail.GetGridData( i, G1_OUTGO_ITEM_PK) ;
			}						
		}
		
		lbItemNum.text = addCommas(t_item_count) + " items" ;
		lbItemQty.text = addCommas(t_item_qty)   + " (" + t_uom + ")";
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
    <gw:data id="pro_bini00050_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bini00050_3" > 
                <input>
                    <inout bind="txtMasterPK" />
					<inout bind="txtEmpPK" />
                </input> 
                <output> 
                     <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_bini00050_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bini00050_4" > 
                <input>
                    <inout bind="txtMasterPK" />
					<inout bind="txtEmpPK" />
                </input> 
                <output> 
                     <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00050_lst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bini00050_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00050_line_lst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_bini00050_4" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtLineStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>    
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_bini00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_bini00050" > 
                <input> 
                    <input bind="lstWH2" />
                    <input bind="txtNoSearch" /> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
					<input bind="txtItemSearch" />
					<input bind="txtLineDept" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bini00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="<%=l_user%>lg_sel_bini00050_1"  procedure="<%=l_user%>lg_upd_bini00050_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstLine" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtRemark" /> 
                     <inout  bind="lblStatus" />     
                     <inout  bind="txtRefNo" /> 
                     <inout  bind="txtAmount" /> 
                     <inout  bind="lstCurrency" />   
                     <inout  bind="txtExRate" />
					 <inout  bind="lstOutType" />     
					 <inout  bind="txtReceiverName" />     
					 <inout  bind="txtReceiverPK" />    
					 <inout  bind="lstDept" />	
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_bini00050_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27" function="<%=l_user%>lg_sel_bini00050_2"   procedure="<%=l_user%>lg_upd_bini00050_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtLang" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00050" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
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
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00110_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale" function="<%=l_user%>lg_sel_fpab00110_2"  > 
                <input>
                    <input bind="txtItemCD_Search" />
                    <input bind="txtItemNM_Search" />
                </input> 
                <output bind="grdItem_Search" /> 
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
                        <td style="width: 95%" colspan="2">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>                         
                    </tr>
					
					<tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Dept/Line
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:textbox id="txtLineDept" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
																			
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                           Item
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtItemSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
					<tr style="height: 1%">
						<td colspan=3 >
							<table style="width: 100%; height: 100%" >
								<tr style="height: 1%" >									
									<td style="width: 1%"><gw:icon id="idBtnReturn" img="2" text="Return" styles='width:100%' onclick="OnProcess('Return')" /></td>
									<td style="width: 1%"><gw:icon id="idBtnCopySlip" img="2" text="Copy" styles='width:100%' onclick="OnProcess('Copy')" /></td>
									<td style="width: 98%"></td>
								</tr>
							</table>
						</td>
					</tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip/Ref No|Date|Dept|Line" format="0|0|0|4|0|0"
                                aligns="0|0|0|1|0|0" defaults="|||||" editcol="0|0|0|0|0|0" widths="0|1000|1200|1200|1500|1500"
                                styles="width:100%; height:100%" sorting="T" param="0,1,2,3,4,5" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>                         
                        <td style="width: 45%" align="center" colspan=2 >
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>                     
                        <td style="width: 1%" align="right"> 
							<gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Confirm')" />                           
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
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Ref No
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRefNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
					
					<tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="WareHouse" onclick="OnPopUp('WAREHOUSE')" href="#tips" style="color: #0000ff">
                                <b>W/H</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="Charger" onclick="OnPopUp('Receiver')" href="#tips" style="color: #0000ff">
                                <b>Receiver</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="6">
                            <gw:textbox id="txtReceiverName" styles="width:100%" />
                            <gw:textbox id="txtReceiverPK" styles="display:none" />
                        </td>
                    </tr>
					
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Dept
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstDept" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Out To
                        </td>
                        <td colspan="6">
                            <gw:list id="lstLine" styles='width:100%'  />
                        </td>
                    </tr>					                  
					                    				
                    <tr style="height: 1%">
                        <td align="right">
                            <a title="Out-Type" onclick="OnPopUp('Out_Type')" href="#tips" style="color=#0000ff">
                                <b>Out-Type</b></a>
                        </td>
                        <td colspan="3">
                            <gw:list id="lstOutType" styles="width:100%" onchange="" />
                        </td>
                        <td style="width: 5%" align="right">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color: #0000ff"><b>P/L</b></a> 
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                    </tr>
					
					<tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Total AMT
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="#,###.###"
                                csstype="mandatory" />
                        </td>
                        <td style="width: 5%" align="right">
                            Ex Rate
                        </td>
                        <td>
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td colspan="5">
                            <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />
                        </td>
                    </tr>
					
					<tr style="height: 1%">
                        <td align="right">
                            Remark
                        </td>                                                
                        <td colspan="10">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
					
					
                    <tr style="height: 1%">
                        <td colspan="13">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 1%">
                                        <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                            style="cursor: hand" onclick="OnToggleGrid()" />
                                    </td>									 
									<td style="width: 30%; white-space: nowrap" align="center">
                            			<gw:label id="lbItemNum" styles='width:100%;color:cc0000;font:9pt'>-</gw:label>
                        			</td>
									<td style="width: 30%; white-space: nowrap" align="center">
                            			<gw:label id="lbItemQty" styles='width:100%;color:cc0000;font:9pt'>-</gw:label>
                        			</td>						
                                    <td style="width: 4%" align="right">
                                    </td>
                                    <td style="width: 19%; white-space: nowrap" align="center">
                                        <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" />
                                        Auto Cal
                                    </td>
									<td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStockSpec" img="2" text="STOCK/SPEC" styles='width:100%' onclick="OnAddNew('STOCK_SPEC')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStock" img="2" text="STOCK" styles='width:100%' onclick="OnAddNew('Stock')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnReq" img="2" text="Request" styles='width:100%' onclick="OnAddNew('Request')" />
                                    </td>
									<td align="right" style="width: 1%">
                                        <gw:icon id="idBtnPO" img="2" text="P/O 1" styles='width:100%' onclick="OnAddNew('PO1')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnPO" img="2" text="P/O 2" styles='width:100%' onclick="OnAddNew('PO2')" />
                                    </td>									                                    
									<td align="right" style="width: 1%">
                                        <gw:icon id="idBtnItemSpec" img="2" text="ITEM/SPEC" styles='width:100%' onclick="OnAddNew('ITEM_SPEC')" />
                                    </td>
									<td align="right" style="width: 1%">
                                        <gw:icon id="idBtnFreeItem" img="2" text="ITEM" styles='width:100%' onclick="OnAddNew('FreeItem')" />
                                    </td>
									<td style="width: 1%">
										<gw:imgbtn id="btnNewD" img="new" alt="New" text="New" onclick="OnAddNew('DETAIL')" />
									</td>
									<td style="width: 1%">
                                        <gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="OnProcess('copy_detail')" />
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
                        <td colspan="13">
                            <gw:grid id='grdDetail' header='_PK|Seq|Ref No|_REQ_ITEM_PK|Req Item Code|Req Item Name|_INCOME_ITEM_PK|Out Item Code|Out Item Name|Req Qty|UOM|Out Qty|UOM|Ref Qty|Ref UOM|U/P|Amount|VAT(%)|VAT Amount|Total Amount|Lot No|Item BC|Remark|_ST_INCOME_M_PK|_PO_PO_D_PK|_QC_IREQ_D_PK|_TABLE_PK|_Table_Name'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|1|1|0|0|0|0|0|0|3|1|3|1|3|1|3|3|3|3|3|1|1|0|0|0|0|0|0'
                                check='|||||||||||||||||||||||||||' 
								editcol='0|1|1|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0'
                                widths='0|800|1200|0|1500|2000|0|1500|2000|1200|1000|1200|1000|1200|1000|1200|1500|1200|1500|1500|1500|1500|1000|0|0|0|0|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput( event.row, event.col)" oncelldblclick="OnGridCellDoubleClick(this)" />
                            />
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
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
<gw:textbox id="txtLineStr" styles="width: 100%;display: none" />

<gw:textbox id="txtLang" styles='width:100%;display:none' />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtItemCD_Search" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtItemNM_Search" maxlen="100" styles='width:100%;display:none' />

<gw:grid id="grdItem_Search" header="pk|item_cd|item_nm" format="0|0|0" aligns="0|0|0"
    defaults="||" editcol="1|1|1" widths="0|0|0" styles="width:100%; height:200;display:none"
    sorting="F" param="0,1,2" />
<!---------------------------------------------------------------------------------->	
</html>
