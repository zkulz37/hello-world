<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <title>Goods Delivery Request</title> 
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>
//-----------------------------------------------------
var flag;

var G_MASTER_PK = 0,
    G_STATUS    = 1,
    G_SLIP_NO   = 2,
    G_DATE      = 3,
    G_PARTNER   = 4;		 

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_SEQ              = 1,
    G1_REF_NO           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_REQ_ITEM_CODE    = 4,
    G1_REQ_ITEM_NAME    = 5,    
    G1_REQ_QTY          = 6,
    G1_REQ_UOM          = 7,    
    G1_UNIT_PRICE       = 8,
    G1_ITEM_AMOUNT      = 9,
    G1_VAT_RATE         = 10,
    G1_VAT_AMOUNT       = 11,
    G1_TOTAL_AMOUNT     = 12,
    G1_LOT_NO           = 13,
    G1_WH_PK            = 14,
    G1_WH_NAME          = 15,
    G1_REMARK           = 16,
    G1_MASTER_PK        = 17,
    G1_SO_D_PK          = 18;
    
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
	     
    txtStaffName.SetEnable(false);
    txtCustomerName.SetEnable(false);      
    txtDeliLocName.SetEnable(false); 
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    
    BindingDataList();    
    OnToggleGrid();
    //----------------------------
	txtMasterPK.text = "<%=Request.querystring("outgo_m_pk")%>";
	
	if ( Number(txtMasterPK.text) > 0 )
	{
		OnToggle();
		flag = 'view' ;
        data_dscd00020_1.Call("SELECT");
	}
	else
	{	
    	OnAddNew('Master');
	}	
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
      
     //----------------------------
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);    	 
	 //----------------------------  
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0304') FROM DUAL" )%>||";    
     lstOutType.SetDataText(data); 
	 lstOutType.value = "";
	 	 
	 var ctr = grdDetail.GetGridControl(); 
    
     ctr.ColFormat(G1_REQ_QTY) = "#,###,###,###,###,###.##";
    
     ctr.ColFormat(G1_UNIT_PRICE)   = "#,###,###,###,###,###.###";
     ctr.ColFormat(G1_ITEM_AMOUNT)  = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_VAT_RATE)     = "#,###,###,###,###,###";
     ctr.ColFormat(G1_VAT_AMOUNT)   = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_TOTAL_AMOUNT) = "#,###,###,###,###,###.##";
    
     arr_FormatNumber[G1_REQ_QTY] = 2;
     
     arr_FormatNumber[G1_UNIT_PRICE]   = 3;
     arr_FormatNumber[G1_ITEM_AMOUNT]  = 2;
     arr_FormatNumber[G1_VAT_RATE]     = 0;
     arr_FormatNumber[G1_VAT_AMOUNT]   = 2;
     arr_FormatNumber[G1_TOTAL_AMOUNT] = 2;                 
 }

 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_dscd00020_1.StatusInsert();
            
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
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM,       arrTemp[5]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,    arrTemp[7]);//Price                            
                    }	
             }        
        break;                    
        
		case 'SALEORDER':			  
			 if ( txtCustomerPK.text == '' )
			 {
			 	alert("PLS SELECT THE BUYER FIRST !!!");
			 	return;
			 }
			 
			 var path = System.RootURL + '/form/ds/cd/dscd00024.aspx';
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
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SO_D_PK, arrTemp[11]);//SO D PK	

						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[2]);//req_pk    						
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[3]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[4]);//item_name
                        
						if ( Number(arrTemp[10]) > 0 )
						{
                        	grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[10] ); 							    
						}
						else
						{
							grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[9]  );
						}
							
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[5]);   
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_REMARK, arrTemp[12]);                                                                                                                                                                    
                    }                                 
             }
			              			 
	    break;

		case 'RESULT' :
			 if ( txtCustomerPK.text == '' )
			 {
			 	alert("PLS SELECT THE BUYER FIRST !!!");
			 	return;
			 }
			 
			 var path = System.RootURL + '/form/ds/cd/dscd00026.aspx';
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
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SO_D_PK, arrTemp[11]);//SO D PK	

						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[2]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[3]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[4]);//item_name
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[10]); 	    
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[5]);   
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_REMARK, arrTemp[12]);                                                                                                                                                                    
                    }                                 
             }
			              			 
	    break;						 
		
		case 'SOSTOCK' :
			 if ( txtCustomerPK.text == '' )
			 {
			 	alert("PLS SELECT THE BUYER FIRST !!!");
			 	return;
			 }
			 
			 var path = System.RootURL + '/form/ds/cd/dscd00027.aspx?group_type=Y|Y|Y|Y|Y|Y';
             var object = System.OpenModal( path ,1050 , 600 ,  'resizable:yes;status:yes',this);
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, 	   grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,  arrTemp[1]);//SO ITEM NO
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SO_D_PK, arrTemp[13]);//SO D PK	

						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[9] );//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[10]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[11]);//item_name
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[7] ); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM, arrTemp[5] ); 						
						grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[8] ); 

						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_PK,   arrTemp[14] ); 						
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_NAME, arrTemp[15] );						
						
						grdDetail.SetGridText( grdDetail.rows-1, G1_REMARK, arrTemp[16]);                                                                                                                                                                    
                    }                                 
             }
			              			 
	    break;
		
		case 'STOCK':
             var path = System.RootURL + "/form/fp/ab/fpab00410.aspx?group_type=Y|Y|Y|Y|Y|Y";
             var object = System.OpenModal( path ,900 , 550 ,  'resizable:yes;status:yes',this);
			 
 			 if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,       grdDetail.rows-1 );
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text ); //master_pk
  
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_PK,   arrTemp[3]);//item_pk
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_CODE, arrTemp[4]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_ITEM_NAME, arrTemp[5]);//item_name
						grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_UOM,       arrTemp[6]); 
												
                        grdDetail.SetGridText( grdDetail.rows-1, G1_REQ_QTY, arrTemp[8]); 	
												
						grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  arrTemp[10]); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_PK,   arrTemp[1]);    
						grdDetail.SetGridText( grdDetail.rows-1, G1_WH_NAME, arrTemp[2]);  							                                                                                                                                               
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
            data_dscd00020.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_dscd00020_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_MASTER_PK );
                    }
                    flag = 'view' ;
                    data_dscd00020_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_MASTER_PK );
                }
                
                flag = 'view' ;
                data_dscd00020_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_dscd00020_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_dscd00020_1": 
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

        case "data_dscd00020_2":
           
            if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G1_REQ_ITEM_CODE, grdDetail.rows - 1, G1_REQ_ITEM_CODE,  true);
	            
                grdDetail.SetCellBold( 1, G1_REQ_QTY, grdDetail.rows - 1, G1_REQ_QTY, true);
                
                grdDetail.SetCellBold( 1, G1_TOTAL_AMOUNT, grdDetail.rows - 1, G1_TOTAL_AMOUNT, true);                
                
                grdDetail.SetCellBgColor( 1, G1_REQ_ITEM_CODE , grdDetail.rows - 1, G1_REQ_ITEM_NAME , 0xCCFFFF );
                
				var t_total_qty = 0;
				
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {                    
					t_total_qty = t_total_qty + Number(grdDetail.GetGridData( i, G1_REQ_QTY      ));
                }  
				
				lblTotalOutQty.text = t_total_qty;  
                //--------------------------------                
            }         
        break;

        case 'pro_dscd00020':
            alert(txtReturnValue.text);
            
			flag = 'view' ;
            data_dscd00020_1.Call("SELECT");
				
        break;   
        
        case 'pro_dscd00020_1':
            alert(txtReturnValue.text);
        break; 		
		case 'pro_dscd00020_2':
            alert(txtReturnValue.text);
        break; 
        case 'pro_dscd00020_5':
            alert(txtReturnValue.text);
        break; 
		case 'data_fpab00220_2':		 
			 if ( txtLGGroupCodeID.text == 'LGIN0301' )
			 {
				 lstOutType.SetDataText(txtLGCodeList.text);
				 lstOutType.value = rtnLGCode;
			 }
		break;	
		
		case 'pro_dscd00020_3':
            switch(txtRadValue.text)
            {
                case '0':			 
                     var url =System.RootURL + '/reports/ds/cd/rpt_dscd00020_ST.aspx?master_pk='+ txtMasterPK.text +'&print_time=1';			 
                     window.open(url); 			 
                break;
        		
                case '1':
                     var url =System.RootURL + '/reports/ds/cd/rpt_dscd00020_DW.aspx?master_pk='+ txtMasterPK.text;
                     window.open(url); 
                break;
        		
                case '2':
                    var url =System.RootURL + '/reports/ds/cd/rpt_dscd00020_DW_02.aspx?master_pk='+ txtMasterPK.text;
	                window.open(url);   
                break;
        		
                case '3':
                     var url =System.RootURL + '/reports/ds/cd/rpt_dscd00020_DW_03.aspx?master_pk='+ txtMasterPK.text;
	                 window.open(url); 
                break;
        		
                case '4':
                    var url =System.RootURL + '/reports/ds/cd/rpt_dscd00020_DW_04.aspx?master_pk='+ txtMasterPK.text;
	                window.open(url); 
                break;
        		
		        case '5':
                    var url =System.RootURL + '/reports/ds/cd/rpt_dscd00023.aspx?master_pk='+ txtMasterPK.text;
	                window.open(url); 
                break;
            }    
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
				
				
				data_dscd00020_4.Call("SELECT");              
	         }
        break; 
		
		case 'Out_Type':			 
			 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIN0301";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes'); 

	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGIN0301';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstOutType.value = object[1];      
	            }    	                
	         }   
		break;	
		
 		case 'DeliLoc' :			 
             if ( txtCustomerPK.text != '' )
             {
                 var path = System.RootURL + '/form/fp/ab/fpab00180.aspx?partner_pk=' + txtCustomerPK.text + '&partner_name=' + url_encode(txtCustomerName.text) ;
	             var object = System.OpenModal( path ,900 , 550 ,  'resizable:yes;status:yes');
				 
	             if ( object != null )
	             {
	                txtDeliLocPK.text   = object[0];
                    txtDeliLocName.text = object[4];
	             }	
	         }
	         else
	         {
	            alert('Pls Select Deliery To first !!!');
	         }         
        break;			

		case 'Report':
			var path = System.RootURL + '/form/ds/cd/dscd00025.aspx';
		    var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
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
                    pro_dscd00020.Call();
                } 
            }                          
        break;                 
        
        case 'DELI' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make Deli slip?'))
                {
                    pro_dscd00020_2.Call();
                } 
            }                  
        break;  
		
        case 'Copy' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to copy this slip?'))
                {
                    pro_dscd00020_5.Call();
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
                data_dscd00020_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_dscd00020_2.Call();
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
				 
				 if ( event_row == 0 )
				 {
				 	   return;
				 }

                 if ( event_col == G1_REQ_UOM || event_col == G1_REQ_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }
                 else if ( event_col == G1_REQ_ITEM_CODE || event_col == G1_REQ_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_REQ_ITEM_PK, object[0] );
                            grdDetail.SetGridText( event_row, G1_REQ_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G1_REQ_ITEM_NAME,   object[2] );
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
				else if ( event_col == G1_REQ_QTY )
                {
					var path = System.RootURL + '/form/fp/ab/fpab00770.aspx?p_table_pk=' + grdDetail.GetGridData( event_row, G1_DETAIL_PK ) + '&p_table_name=TLG_GD_REQ_D&p_io_type=O';
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
                data_dscd00020_1.StatusDelete();
                data_dscd00020_1.Call();
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
        if ( Number(grdDetail.GetGridData( i, G1_REQ_QTY)) == 0 )
        {
            alert("Input out qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    if(txtCustomerPK.text=="")
    {
        alert("Please Select Deli To first !")
        return false;
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
    
    if ( col == G1_REQ_QTY || col == G1_REQ_QTY || col == G1_UNIT_PRICE || col == G1_ITEM_AMOUNT || col == G1_VAT_RATE || col == G1_VAT_AMOUNT ||col == G1_TOTAL_AMOUNT )
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
            if ( col == G1_REQ_QTY || col == G1_UNIT_PRICE || col == G1_VAT_RATE )
            {
                dQuantiy = grdDetail.GetGridData( row, G1_REQ_QTY) ;
                dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
                
                var dAmount = dQuantiy * dPrice;
                
                grdDetail.SetGridText( row, G1_ITEM_AMOUNT, System.Round( dAmount, arr_FormatNumber[G1_ITEM_AMOUNT] ));
                
                var dVATAmount = 0 , dTotalAmount = 0 ;
                
                dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) * Number(grdDetail.GetGridData( row, G1_VAT_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_VAT_AMOUNT, System.Round( dVATAmount, arr_FormatNumber[G1_VAT_AMOUNT] ) ) ;
                
                dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_VAT_AMOUNT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMOUNT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMOUNT] ) ) ;               
            } 
            else if ( col == G1_ITEM_AMOUNT )
            {
                var dVATAmount   = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) * Number(grdDetail.GetGridData( row, G1_VAT_RATE )) / 100 ;                
                grdDetail.SetGridText( row, G1_VAT_AMOUNT, System.Round( dVATAmount, arr_FormatNumber[G1_VAT_AMOUNT] ) ) ;
				
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_VAT_AMOUNT )) ;
                grdDetail.SetGridText( row, G1_TOTAL_AMOUNT, System.Round( dTotalAmount, arr_FormatNumber[G1_TOTAL_AMOUNT] ) ) ;         
            }
            else if ( col == G1_VAT_AMOUNT )
            {
                var dTotalAmount = Number(grdDetail.GetGridData( row, G1_ITEM_AMOUNT )) + Number(grdDetail.GetGridData( row, G1_VAT_AMOUNT )) ;
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
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)  = true ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT) = true ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_RATE)    = true ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_AMOUNT)  = true ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT)= true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";			
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)  = false ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT) = false ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_RATE)    = false ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_AMOUNT)  = false ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT)= false ;
				
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
//=================================================================================
function OnPrint(para)
{   
	switch(para)
	{
		case '0':
			if( txtMasterPK.text != "" )
			{
				var url = System.RootURL + '/reports/ds/cd/rpt_dscd00020.aspx?master_pk='+txtMasterPK.text;
				window.open(url);	
			}
			else
			{
				alert("Please, select one delivery voucher to print!");
			}
		break;
		
		case '1':
			if( txtMasterPK.text != "" )
			{
				var url = System.RootURL + '/reports/ds/cd/rpt_dscd00020_droco.aspx?master_pk='+txtMasterPK.text;
				window.open(url);
			}
			else
			{
				alert("Please, select one delivery voucher to print!");
			}		
		break;
		
		case '2':
			if( txtMasterPK.text != "" )
			{
				var url = System.RootURL + '/reports/ds/cd/rpt_dscd00020_droco_1.aspx?master_pk='+txtMasterPK.text;
				window.open(url);	
			}
			else
			{
				alert("Please, select one delivery voucher to print!");
			}		
		break;		
		
		case '3':
			if( txtMasterPK.text != "" )
			{
				var url = System.RootURL + '/reports/ds/cd/rpt_dscd00021.aspx?master_pk='+txtMasterPK.text;
				window.open(url);	
			}
			else
			{
				alert("Please, select one delivery voucher to print!");
			}		
		break;			
	}
}
//=================================================================================
function OnReport(para1,para2)
{    
    txtReportType.text = para1 ;
    txtRadValue.text = para2 ;
    pro_dscd00020_3.Call();
}

 //==============================================================================================  

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

//=================================================================================
</script>

<body>    
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dscd00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3" function="<%=l_user%>lg_sel_dscd00020" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
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
    <gw:data id="data_dscd00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="<%=l_user%>lg_sel_dscd00020_1"  procedure="<%=l_user%>lg_upd_dscd00020_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />
					 <inout  bind="lblStatus" />
					 <inout  bind="txtRefNo" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />                                       
                     <inout  bind="txtCustomerPK" />
                     <inout  bind="txtCustomerName" />
					 <inout  bind="txtDeliLocPK" />
                     <inout  bind="txtDeliLocName" />
					 <inout  bind="txtAmount" /> 
                     <inout  bind="lstCurrency" />  
                     <inout  bind="txtExRate" />					 
                     <inout  bind="txtRemark" />   
					 <inout  bind="lstOutType" />                                                                                            
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dscd00020_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="<%=l_user%>lg_sel_dscd00020_2"   procedure="<%=l_user%>lg_upd_dscd00020_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dscd00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00020" > 
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
    <gw:data id="pro_dscd00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00020_1" > 
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
    <gw:data id="data_dscd00020_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control" function="<%=l_user%>lg_sel_dscd00020_4" > 
                <inout>
                    <inout bind="txtCustomerPK"/>
                    <inout bind="txtDeliLocPK"/>
                    <inout bind="txtDeliLocName"/> 				
					<inout bind="lstCurrency" />					 
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
    <!---------------------------------------------------------------->
    <gw:data id="pro_dscd00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00020_3" > 
                <input>
                    <input bind="txtReportType" /> 
                    <input bind="txtSlipNo" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_dscd00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00020_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="txtEmpPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
    <!------------------------------------------------------------------>
    <gw:data id="pro_dscd00020_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00020_5" > 
                <input>
                    <input bind="txtMasterPK" /> 
                    <input bind="txtEmpPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
    <!------------------------------------------------------------------>
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
						<td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtItem" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
					</tr>                   
                    <tr style="height: 1%">
                        <td style="width: 5%;white-space: nowrap" align="right">
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
					<td colspan="3">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnCopySlip" img="2" text="Copy" styles='width:100%' onclick="OnProcess('Copy')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnDeli" img="2" text="Deli" styles='width:100%' onclick="OnProcess('DELI')" />
                                    </td>                                    
                                    <td style="width: 98%">
                                    </td>
                                </tr>
                            </table>
                        </td>
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
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>						
						<td style="width: 1%" align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
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
                              <a title="Out-Type" onclick="OnPopUp('Out_Type')" href="#tips" style="color=#0000ff">
                                <b>Out-Type</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                              <gw:list id="lstOutType" styles="width:100%" onchange="" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                             <a title="Deli To" onclick="OnPopUp('Customer')" href="#tips" style="color=#0000ff">
                                <b>Deli To</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="9">
                             <gw:textbox id="txtCustomerPK" styles="display:none" />
                             <gw:textbox id="txtCustomerName" styles="width:100%" />
                        </td>
                    </tr>
					
					<tr>
						<td style="width: 10%; white-space: nowrap" align="right">
                           	  Ex-Rate
                        </td>
                        <td  style="white-space: nowrap">
                              <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
						<td colspan="2" >
							  <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />
						</td>						 
                        <td style="width: 10%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliLoc')">Deli Loc
                                        </b>
                        </td>
                        <td colspan="9">
                             <gw:textbox id="txtDeliLocPK" maxlen="100" styles='width:100%;display:none' />
                             <gw:textbox id="txtDeliLocName" csstype="mandatory" styles='width:100%' />
                        </td>
                    </tr>
										
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Total AMT							
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="#,###.###"
                                csstype="mandatory" />
                        </td>                       
                        <td style="width: 10%; white-space: nowrap" align="right">
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
                                    <td style="width: 20%" align="right">
                                    </td>
									<td style="width: 4%; white-space: nowrap" align="right">
                                        Qty :
                                    </td>
                                    <td style="width: 20%; white-space: nowrap" align="center">
                                        <gw:label id="lblTotalOutQty" styles='width:100%;color:cc0000;font:9pt' text='' type="number"
                                            format="###.###,###.##" />
                                    </td>									 
									<td style="width: 20%" align="right">
                                    </td> 
                                    <td style="width: 19%; white-space: nowrap" align="center"> 
										 <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" />
                                         Auto Cal                                        
                                    </td>
                                    <td align="right" style="width: 1%"> 
										<gw:icon id="idBtnSOSTOCK" img="2" text="SO/STOCK" styles='width:100%' onclick="OnAddNew('SOSTOCK')" />                                      
                                    </td>
                                    <td align="right" style="width: 1%">
										<gw:icon id="idBtnReSULT" img="2" text="RESULT" styles='width:100%' onclick="OnAddNew('RESULT')" />                                      
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnSaleOrder" img="2" text="S/ORDER" styles='width:100%' onclick="OnAddNew('SALEORDER')" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnStock" img="2" text="STOCK" styles='width:100%' onclick="OnAddNew('STOCK')" />
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
                            <gw:grid id='grdDetail' 
								header='_PK|Seq|Ref No|_OUTGO_ITEM_PK|Out Item Code|Out Item Name|Req Qty|UOM|U/P|Item Amt|Tax (%)|Tax Amt|Total Amt|Lot No|_WH_PK|W/H|Remark|_MASTER_PK|_SO_D_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|1|1|0|0|0|3|1|3|3|3|3|3|1|0|0|0|0|0'
                                check='||||||||||||||||||' 
							    editcol='0|1|1|0|0|0|1|0|1|1|1|1|1|1|0|0|1|0|0'
                                widths='0|800|1500|0|1500|3000|1200|800|1200|1500|1200|1500|1500|1500|0|1500|1000|0|0'
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
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtReportType" styles='display:none;width:100%' />
<gw:textbox id="txtRadValue" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
</html>
