<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <title>Goods Return Entry</title> 
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//=================================================================================

var flag;

var G_PK        = 0,
    G_Status    = 1,
    G_SLip_No   = 2,
    G_Date      = 3,
    G_PARTNER   = 4;		 

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_SEQ              = 1,
    G1_REF_NO           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_REQ_ITEM_CODE    = 4,
    G1_REQ_ITEM_NAME    = 5,
    G1_RTN_ITEM_PK      = 6,
    G1_RTN_ITEM_CODE    = 7,
    G1_RTN_ITEM_NAME    = 8,
    G1_REQ_QTY          = 9,
    G1_REQ_UOM          = 10,
    G1_RTN_QTY          = 11,
    G1_RTN_UOM          = 12,
    G1_UNIT_PRICE       = 13,
    G1_ITEM_AMOUNT      = 14,
    G1_TAX_RATE         = 15,
    G1_TAX_AMOUNT       = 16,
    G1_TOTAL_AMOUNT     = 17,
    G1_LOT_NO           = 18,
    G1_WH_PK            = 19,
    G1_WH_NAME          = 20,
    G1_RTN_TYPE         = 21,
    G1_REMARK           = 22,
    G1_MASTER_PK        = 23,
    G1_SO_D_PK          = 24,
    G1_REQ_D_PK         = 25;
    
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
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtCustomerName.SetEnable(false);      
   
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
	 
	SetGridFormat();   
    //----------------------------         
     	 
    OnToggleGrid();
    //----------------------------
    data_dscd00050_wh.Call('SELECT');
	
	
 }
 //==================================================================================
 
 function SetGridFormat()
 { 
     var data = "";       
     //---------------------------
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);   

	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0308') FROM DUAL" )%>||";    
     lstInType.SetDataText(data); 
	 lstInType.value = "";
	 	  
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID = 'LGSA7010' AND a.TLG_LG_CODE_GROUP_PK = b.PK AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.CODE, a.CODE_NM " )%>" ; 
	data = data + "|#;";
    grdDetail.SetComboFormat(G1_RTN_TYPE,data);   

    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_REQ_QTY) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_RTN_QTY) = "#,###,###,###,###,###.###";
    
    ctr.ColFormat(G1_UNIT_PRICE)   = "#,###,###,###,###,###.#####";
    ctr.ColFormat(G1_ITEM_AMOUNT)  = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_TAX_RATE)     = "#,###,###,###,###,###";
    ctr.ColFormat(G1_TAX_AMOUNT)   = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_TOTAL_AMOUNT) = "#,###,###,###,###,###.##";
      
    arr_FormatNumber[G1_REQ_QTY] = 3;
    arr_FormatNumber[G1_RTN_QTY] = 3;
     
    arr_FormatNumber[G1_UNIT_PRICE]   = 5;
    arr_FormatNumber[G1_ITEM_AMOUNT]  = 2;
    arr_FormatNumber[G1_TAX_RATE]     = 0;
    arr_FormatNumber[G1_TAX_AMOUNT]   = 2;
    arr_FormatNumber[G1_TOTAL_AMOUNT] = 2; 	
		                   
 }
 
 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_dscd00050_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;  
        
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y||Y|Y||';//purchase_yn=Y
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
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_UOM,       arrTemp[5]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,    arrTemp[7]);//Price                            
                    }	
             }        
        break;                    
        
		case 'STOCK':
             var path = System.RootURL + '/form/ds/cd/dscd00071.aspx';
             var object = System.OpenModal( path ,1050 , 600 ,  'resizable:yes;status:yes',this);
			 
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
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[1]);//SO ITEM NO
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SO_D_PK, arrTemp[14]);//SO D PK	

                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[3]);//req_pk    
						grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_PK,   arrTemp[4]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[5]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[6]);//item_name
                        
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[2]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_QTY, arrTemp[12]); 	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[7]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_UOM, arrTemp[7]); 
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[10]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_PK,   arrTemp[8]);    
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_NAME, arrTemp[9]);                                                                                                                                                                          
                    }                                 
             }                 			 
	    break;
		
		case 'OUTGO':
             var path = System.RootURL + '/form/ds/cd/dscd00052.aspx';
             var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,       grdDetail.rows-1 );
						
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,   arrTemp[2]);//SO ITEM NO
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SO_D_PK,  arrTemp[23]);//SO D PK	
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_D_PK, arrTemp[0]);//REQ D PK	-- GD_DELIVER_D_pK

                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[6]);//req_pk 
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[7]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[8]);//item_name						   
						grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_PK,   arrTemp[6]);//item_pk
						grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_CODE, arrTemp[7]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_ITEM_NAME, arrTemp[8]);//item_name						   						
                        
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[11]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_QTY, arrTemp[11]); 	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[12]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_RTN_UOM, arrTemp[12]); 
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,  arrTemp[13]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_AMOUNT, arrTemp[14]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_TAX_RATE,    arrTemp[15]);   
						grdDetail.SetGridText( grdDetail.rows-1, G1_TAX_AMOUNT,  arrTemp[16]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_TAX_AMOUNT,  arrTemp[17]);  
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[18]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_PK,   arrTemp[19]);    
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_NAME, arrTemp[20]);  							                                                                                                                                               
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
            data_dscd00050.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_dscd00050_1.GetStatus() == 20 && grdDetail.rows > 1 )
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
                    data_dscd00050_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
                }
                
                flag = 'view' ;
                data_dscd00050_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_dscd00050_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_dscd00050_1": 
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

        case "data_dscd00050_2":
           
            if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G1_RTN_ITEM_CODE, grdDetail.rows - 1, G1_RTN_ITEM_CODE,  true);	                            
                grdDetail.SetCellBold( 1, G1_RTN_QTY,       grdDetail.rows - 1, G1_RTN_QTY,        true);
                
				grdDetail.SetCellBgColor( 1, G1_TOTAL_AMOUNT ,  grdDetail.rows - 1, G1_TOTAL_AMOUNT ,  0xCCFFFF );
                grdDetail.SetCellBgColor( 1, G1_REQ_ITEM_CODE , grdDetail.rows - 1, G1_REQ_ITEM_NAME , 0xCCFFFF );
                
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    if ( Number(grdDetail.GetGridData( i, G1_REQ_ITEM_PK)) > 0 && ( grdDetail.GetGridData( i, G1_REQ_ITEM_PK) != grdDetail.GetGridData( i, G1_RTN_ITEM_PK) ) )
                    {
                        grdDetail.GetGridControl().Cell( 7, i, G1_RTN_ITEM_CODE, i, G1_RTN_ITEM_NAME ) = 0x3300cc;
                    }                    
                }        
                //--------------------------------                
            }         
        break;

        case 'pro_dscd00050':
            alert(txtReturnValue.text);
			
			flag = 'view' ;
            data_dscd00050_1.Call("SELECT");			
        break;   
        
        case 'pro_dscd00050_1':
            alert(txtReturnValue.text);
        break; 		
		
		case 'data_fpab00220_2':		 
			 if ( txtLGGroupCodeID.text == 'LGIN0301' )
			 {
				 lstInType.SetDataText(txtLGCodeList.text);
				 lstInType.value = rtnLGCode;
			 }
		break;	
		
		case 'data_dscd00050_wh':
		
            lstRtnWH.SetDataText(txtWHStr.text +"||");
			lstRtnWH.value = "";
            lstSearchRtnWH.SetDataText(txtWHStr.text +"||");
            lstSearchRtnWH.value = "";
            //-------------------
			
	        OnAddNew('Master');
        break;		            
   }            
}

//--------------------------------------------------------------------------------------------------
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
                txtStaffPK.text   = obj[0];
            }
        break;            

        case 'Customer' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtCustomerPK.text   = object[0];
                txtCustomerName.text = object[2];                
	         }
        break; 
		
		case 'In_Type':			 
			 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIN0308";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes'); 

	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGIN0308';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstInType.value = object[1];      
	            }    	                
	         }   
		break;	
        
        case 'Return_Type':			 
			 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA7010";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes'); 
		break; 

		case 'Report':			 
			 if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/ds/cd/dscd00051.aspx';
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
                    pro_dscd00050.Call();
                } 
            }                          
        break;                 
        
        case 'Return' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make transfer slip?'))
                {
                    pro_dscd00050_2.Call();
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
            if( Validate() )
            {
                data_dscd00050_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_dscd00050_2.Call();
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

                 if ( event_col == G1_REQ_UOM || event_col == G1_RTN_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
                 else if ( event_col == G1_RTN_ITEM_CODE || event_col == G1_RTN_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_RTN_ITEM_PK, object[0] );
                            grdDetail.SetGridText( event_row, G1_RTN_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G1_RTN_ITEM_NAME,   object[2] );
                       }                       
                 }
				 else if ( event_col == G1_WH_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00240.aspx';
                       var object = System.OpenModal( path , 600 , 400,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_WH_PK,   object[0] );
                            grdDetail.SetGridText( event_row, G1_WH_NAME, object[2] );
                       }                        
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
                data_dscd00050_1.StatusDelete();
                data_dscd00050_1.Call();
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
        if ( Number(grdDetail.GetGridData( i, G1_RTN_QTY)) == 0 )
        {
            alert("Input out qty. at " + i + ",pls!")
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
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_REQ_QTY || col == G1_RTN_QTY || col == G1_UNIT_PRICE || col == G1_ITEM_AMOUNT || col == G1_TAX_RATE || col == G1_TAX_AMOUNT ||col == G1_TOTAL_AMOUNT )
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
            if ( col == G1_RTN_QTY || col == G1_UNIT_PRICE || col == G1_TAX_RATE )
            {
                dQuantiy = grdDetail.GetGridData( row, G1_RTN_QTY) ;
                dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
                
                var dAmount = dQuantiy * dPrice;
                
                grdDetail.SetGridText( row, G1_ITEM_AMOUNT, System.Round( dAmount, arr_FormatNumber[G1_ITEM_AMOUNT] ));
                
                var dVATAmount = 0 , dTotalAmount = 0 ;
                
                dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) * Number(grdDetail.GetGridData( row, G1_TAX_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_TAX_AMOUNT, System.Round( dVATAmount, arr_FormatNumber[G1_TAX_AMOUNT] ) ) ;
                
                dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMOUNT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMOUNT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMOUNT] ) ) ;               
            } 
            else if ( col == G1_ITEM_AMOUNT )
            {
                var dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) * Number(grdDetail.GetGridData( row, G1_TAX_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_TAX_AMOUNT, System.Round( dVATAmount, arr_FormatNumber[G1_TAX_AMOUNT] ) ) ;
				
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMOUNT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMOUNT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMOUNT] ) ) ;         
            }
            else if ( col == G1_TAX_AMOUNT )
            {
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_TAX_AMOUNT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMOUNT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMOUNT] ) ) ;         
            }
                
            TotalAmount();  
        }                    
    }      
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
    var sumAmount = 0 ;

    for ( i=1; i<grdDetail.rows; i++ )
    {
        sumAmount = sumAmount + Number(grdDetail.GetGridData(i,G1_TOTAL_AMOUNT));
    }

    txtAmount.text = System.Round( sumAmount, 3) ;
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
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)   = true ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT)  = true ;
		grdDetail.GetGridControl().ColHidden(G1_TAX_RATE)     = true ;
		grdDetail.GetGridControl().ColHidden(G1_TAX_AMOUNT)   = true ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT) = true ;
		
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
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)   = false ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT)  = false ;
		grdDetail.GetGridControl().ColHidden(G1_TAX_RATE)     = false ;
		grdDetail.GetGridControl().ColHidden(G1_TAX_AMOUNT)   = false ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT) = false ;					
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
//=================================================================================
function OnPrint()
{    
    if(txtMasterPK.text != "")
    {
       // var url =System.RootURL + '/reports/ds/cd/rpt_dscd00050.aspx?master_pk=' + txtMasterPK.text ;
        var url =System.RootURL + '/reports/ep/fm/rpt_dscd00050_st01.aspx?master_pk=' + txtMasterPK.text ;
        System.OpenTargetPage(url); 
	}
	else
	{
	    alert("Pls select one slip.");
	}
}

//===================================================================================================
function OnReport(para)
{
    switch(para)
    {
        case '0':
           // var url =System.RootURL + '/reports/bi/as/rpt_bias00060.aspx?master_pk=' + txtMasterPK.text ;
            var url =System.RootURL + '/reports/ds/cd/rpt_dscd00050_st01.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
    }
}
 
//=================================================================================
</script>

<body>    
	<!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dscd00050_wh" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_dscd00050_wh" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dscd00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_dscd00050" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="lstSearchRtnWH" />
					<input bind="txtSearchNo" />
					<input bind="txtItem" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_dscd00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_dscd00050_1"  procedure="<%=l_user%>lg_upd_dscd00050_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />
					 <inout  bind="lblStatus" />
					 <inout  bind="txtRefNo" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstRtnWH" />                      
                     <inout  bind="txtCustomerPK" />
                     <inout  bind="txtCustomerName" />
					 <inout  bind="txtAmount" /> 
                     <inout  bind="lstCurrency" />  
                     <inout  bind="txtExRate" />					 
                     <inout  bind="txtRemark" />  
					 <inout  bind="lstInType" />                                                                                            
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dscd00050_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="<%=l_user%>lg_sel_dscd00050_2"   procedure="<%=l_user%>lg_upd_dscd00050_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dscd00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00050" > 
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
					<tr>
						<td style="width: 5%" align="right" >
							W/H
						</td>
						<td style="width: 10%" colspan=2 >
							<gw:list id="lstSearchRtnWH" styles='width:100%'  />
						</td>
					</tr>
					<tr> 
						<td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:textbox id="txtItem" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
					</tr>                   
                    <tr style="height: 1%">
                        <td style="width: 5%;white-space:nowrap" align="right">
                            Partner/No.
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtSearchNo" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
						<td>
							<gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
						</td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip/Ref No|Date|Partner" format="0|0|0|4|0"
                                aligns="0|1|0|1|0" defaults="||||" editcol="0|0|0|0|0" widths="0|1000|1200|1200|1500"
                                styles="width:100%; height:100%" sorting="T" param="0,1,2,3,4" oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                        <td align="right" style="width: 10%">
                        </td>
                        <td style="width: 40%" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 1%">
                            
                        </td>
                        <td style="width: 1%" align="right">                            
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" /> 
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
                        <td style="width: 10%" align="right">
                            Ref No
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRefNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="9">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>                    
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            W/H
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstRtnWH" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                             <a title="Customer" onclick="OnPopUp('Customer')" href="#tips" style="color=#0000ff">
                                <b>Customer</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="9">
                             <gw:textbox id="txtCustomerPK" styles="display:none" />
                             <gw:textbox id="txtCustomerName" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Total Amt
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="#,###.###"
                                csstype="mandatory" />
                        </td>
                       
                        <td style="width: 10%; white-space: nowrap" align="right">
						   Ex-Rate                             
                        </td>
                        <td>
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td colspan="8">
                        	<gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />                            
                        </td>
                    </tr>
                    <tr>	
						<td style="width: 10%; white-space: nowrap" align="right">
                            <a title="Out-Type" onclick="OnPopUp('In_Type')" href="#tips" style="color=#0000ff">
                                <b>Slip Type</b></a>
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:list id="lstInType" styles="width:100%" onchange="" />
                        </td>
												 
                        <td style="width: 10%" align="right">
                            Remark
                        </td>
                        <td colspan="9">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
											                        
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="14">
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
                                    <td style="width: 64%" align="right">
										<a title="RtnType" onclick="OnPopUp('Return_Type')" href="#tips" style="color=#0000ff">
											Return Type</a>
                                    </td>
                                    <td style="width: 19%; white-space: nowrap" align="center"> 
										 <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" />
                                         Auto Cal                                        
                                    </td>
                                    <td align="right" style="width: 1%">                                         
                                    </td>
                                    <td align="right" style="width: 1%">										                                        
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnREQ" img="2" text="G/Deli" styles='width:100%' onclick="OnAddNew('OUTGO')" />  
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:100%' onclick="OnAddNew('FreeItem')" />
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
                        <td colspan="14">
                            <gw:grid id='grdDetail' header='_PK|Seq|Ref No|_REQ_ITEM_PK|Req Item Code|Req Item Name|_OUTGO_ITEM_PK|Rtn Item Code|Rtn Item Name|Req Qty|UOM|IN Qty|UOM|U/Price|Item Amt|Tax(%)|Tax Amt|Total Amt|Lot No|_WH_PK|W/H|Return Type|Remark|_MASTER_PK|_SO_D_PK|_REQ_D_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|2|0|0|0|0' aligns='0|1|1|0|0|0|0|0|0|3|1|3|1|3|3|3|3|3|1|0|0|0|0|0|0|0'
                                check='|||||||||||||||||||||||||' editcol='0|1|1|0|0|0|0|0|0|1|0|1|0|1|1|1|1|1|1|0|0|1|1|0|0|0'
                                widths='0|800|1500|0|1500|3500|0|1500|3500|1200|800|1200|800|1200|1500|1200|1500|1500|1500|0|2000|1300|1000|0|0|0'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)" acceptnulldate='T'/>
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
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<!----------------------------------------------------------------------------------> 
</html>
