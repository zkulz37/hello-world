<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("sale")%>
<head id="Head1" runat="server">
    <title>SALE ORDER ENTRY</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    var G1_pk                       = 0, 
        G1_tsa_saleorder_pk         = 1,         
        G1_seq                      = 2,    
        G1_tco_item_pk              = 3, 
        G1_item_code                = 4,
        G1_customer                 = 5,
        G1_release_date             = 6,   
        G1_item_eta                 = 7,  
        G1_ord_qty                  = 8,
        G1_unit_price               = 9,
        G1_unit_price_2             =10, 
        G1_amount                   =11,
        G1_amount_2                 =12, 
        G1_comm_rate                =13, 
        G1_item_name                =14, 
        G1_gelatin                  =15,
        G1_size_code                =16, 
        G1_ptinting                 =17,
        G1_cap_col_pk               =18, 
        G1_body_col_pk              =19,
        G1_cap_col                  =20,
        G1_body_col                 =21, 
        G1_cap_col_nm               =22,
        G1_body_col_nm              =23,
        G1_cap_char                 =24, 
        G1_body_char                =25,
        G1_cap_print_type           =26, 
        G1_cap_print_col            =27,
        G1_cap_print_col_desc       =28,
        G1_body_print_type          =29, 
        G1_body_print_col           =30,
        G1_body_print_col_desc      =31, 
        G1_remark                   =32;
       
        
       
 //---------------------------------------------------------
 var iCodeID = "" ;
 
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 //---------------------------------------------------------
 function BodyInit()
 {
      
      OnChangeTab();
      dtFromOrderDate.SetDataText(System.AddDate(dtToOrderDate.GetData(),-5));
      BindingDataList();
      AddOnClick('Master');
      SetStatus(1);
 }
 //==========================================================
 function OnChangeTab()
 {
    var strRad = radTab.GetData();
    
    var tab_Deli_Info       = document.all("Tab-Deli-Info");    
    var tab_Sale_Term       = document.all("Tab-Sale-Term");    
         
	switch (strRad) 
	{  
		case '1':
		    tab_Deli_Info.style.display      = "";
		    tab_Sale_Term.style.display      = "none";
		    
		    document.all("Gen-Info").style.color      = "red"; 
		    document.all("Exten-Info").style.color      = "";
        break;
        
        case '2':
		    tab_Deli_Info.style.display      = "none";
		    tab_Sale_Term.style.display      = "";
		    
		    document.all("Gen-Info").style.color      = ""; 
		    document.all("Exten-Info").style.color      = "red";
        break;	
    } 
 }
 //---------------------------------------------------------
 function SetStatus(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            txtBillToCode.SetEnable(false);
            txtBillToName.SetEnable(false);
            txtEmpCode.SetEnable(false);
            txtEmpName.SetEnable(false);
            txtDeptCode.SetEnable(false);
            txtDeptName.SetEnable(false);
            lstPriceBy.SetEnable(false);
            txtReceipt.text="Plant Manager";
        break;
      }  
 } 
  //---------------------------------------------------------
 function BindingDataList()
 {    
        var data="";    
            
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA1010') FROM DUAL" )%>|ALL|Select ALL";    
        lstOrderStatus1.SetDataText(data);
        lstOrderStatus1.value = 'ALL' ;

        
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0250') FROM DUAL" )%>";    
        lstDeliMethod.SetDataText(data);
        
       
        data = "<%=ESysLib.SetListDataSQL("select pk,COUNTRY_NM from imex.tie_country a where del_if =0 order by a.COUNTRY_NM" )%>";    
        lstDestNation.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0100') FROM DUAL" )%>";    
        lstCurrency.SetDataText(data);
        lstCurrency.value = "USD";
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0090') FROM DUAL" )%>";    
        lstOrdType.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0110') FROM DUAL" )%>";    
        lstPayForm.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0120') FROM DUAL" )%>";    
        lstPayTerm.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("select NUM_VALUE1,code_nm  from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGHC0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 and a.DEF_YN='Y' order by a.def_yn desc, ord" )%>";    
        lstPriceBy.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA40') FROM DUAL" )%>";    
        lstExPort.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA50') FROM DUAL" )%>";    
        lstDestPort.SetDataText(data); 
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0130') FROM DUAL" )%>";    
        lstPriceType.SetDataText(data);     
       
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0150') FROM DUAL" )%>";   
         
        lstPackingMethod.SetDataText(data);
        lstPackingMethod.value="";
        
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0030' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 and code not in('10','11')  order by a.def_yn desc, ord" )  %>|| " ; 
        
        grdDetail.SetComboFormat(G1_gelatin,data);       
//        
//        <%=ESysLib.SetGridColumnComboFormat("grdDetail",14,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;        
//        <%=ESysLib.SetGridColumnComboFormat("grdDetail",15,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
//        <%=ESysLib.SetGridColumnComboFormat("grdDetail",13,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;    
        
  }        
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            dsbs00010.Call("SELECT");
        break;
        case 2 :  
            if ( grdSearch.row > 0 )
            {
                txtOrderPK.text = grdSearch.GetGridData(grdSearch.row,0);
            }
            grd_order_master.Call("SELECT");                    
        break;       
      }  
 }

 //---------------------------------------------------------
 function OnDataReceive(po_oData)
 {
      switch (po_oData.id)         
      {
        case "grd_order_master" :
            if ( p_update == 1 )
            {
                OnSave(2);
            }
            else
            {
                dsbs00010_2.Call('SELECT');
            } 
           
        break;
        case "shex00010_9":
            grd_order_master.Call("SELECT");
        break;
        case "dsbs00010_2" :
            if(p_update==1)
            {
                p_update=0;
                dsbs00010.Call("SELECT");
                if(grdDetail.rows > 1)
                {
                    grdDetail.SetCellBold( 1, G1_ord_qty, grdDetail.rows - 1, G1_ord_qty, true);
                    grdDetail.SetCellBgColor( 1, G1_item_code , grdDetail.rows - 1, G1_item_name , 0xCCFFFF );
                }
            }
        break;
        
        case "datGetNewCode":
             if(txtComCodeID.text == 'LGSA50')
             {
                lstDestPort.SetDataText(txtCodeTemp.text);  
                lstDestPort.value = iCodeID;                      
             }         
             else 
             if(txtComCodeID.text == 'LGCM0250')
             {
                lstDeliMethod.SetDataText(txtCodeTemp.text);  
                lstDeliMethod.value = iCodeID;                      
             }                          
             else 
             if(txtComCodeID.text == 'LGMF0090')
             {
                lstOrdType.SetDataText(txtCodeTemp.text);  
                lstOrdType.value = iCodeID;                      
             }         
             else 
             if(txtComCodeID.text == 'LGCM0130')
             {
                lstPriceType.SetDataText(txtCodeTemp.text);  
                lstPriceType.value = iCodeID;                      
             }         
             else
             if(txtComCodeID.text == 'LGCM0110')
             {
                lstPayForm.SetDataText(txtCodeTemp.text);  
                lstPayForm.value = iCodeID;                      
             }         
             else
             if(txtComCodeID.text == 'LGCM0120')
             {
                lstPayTerm.SetDataText(txtCodeTemp.text);  
                lstPayTerm.value = iCodeID;                      
             }         
             else
             if(txtComCodeID.text == 'LGCM0100')
             {
                lstCurrency.SetDataText(txtCodeTemp.text);  
                lstCurrency.value = iCodeID;                      
             }         
             else
             if(txtComCodeID.text == 'LGSA40')
             {
                lstExPort.SetDataText(txtCodeTemp.text);  
                lstExPort.value = iCodeID;                        
             }  
                   
         break; 
      }  
 }
  var step = 1 ;
 //---------------------------------------------------------
 function AddOnClick(pos) 
 {
    var seqInit = 0;//item sequence

      switch (pos)         
      {		        
        case 'Master' :
            grd_order_master.StatusInsert();
            txtSoNo.SetDataText("**New Slip No**") ;        
            txtEmpPK.text = user_pk ;
            txtEmpName.text = user_name ;
            txtEmpCode.text ="<%=Session("EMP_ID")%>" ;
            lstPackingMethod.value='';
            txtReceipt.text="Plant Manager";
            grdDetail.ClearData();
            //----------------
        break;
        
        case 'PopUpGetItem' :
             var path = System.RootURL + '/form/sh/ex/shex00011_sh.aspx';
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes',this);
	         
	         if ( object != null )
	         {
               
                var arrTemp;
                var countSeq = 0;
               
                //----------------------------------------
                for( var i=0; i < object.length; i++)	  
                {	
                    arrTemp = object[i];
                    grdDetail.AddRow();
                    grdDetail.SetGridText( grdDetail.rows-1, G1_tsa_saleorder_pk, txtOrderPK.text) ;//master_pk
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_tco_item_pk,    arrTemp[0]);	    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_code,      arrTemp[2]);	
                    grdDetail.SetGridText( grdDetail.rows-1, G1_customer,      arrTemp[20]);    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_name,      arrTemp[3]);	    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_gelatin,      arrTemp[25]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_size_code,      arrTemp[18]);   
                    grdDetail.SetGridText( grdDetail.rows-1, G1_ptinting,      arrTemp[21]); 
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col_pk,      arrTemp[22]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col_pk,      arrTemp[23]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col,      arrTemp[6]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col,      arrTemp[12]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col_nm,      arrTemp[7]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col_nm,      arrTemp[13]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_char,      arrTemp[11]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_char,      arrTemp[17]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_type,      arrTemp[8]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_col,      arrTemp[9]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_col_desc,      arrTemp[10]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_type,      arrTemp[14]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_col,      arrTemp[15]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_col_desc,      arrTemp[16]);         
                    grdDetail.SetGridText( grdDetail.rows-1, G1_remark,         "New Order"          );    
               } 
                	            
	         }	 	           
        break;
        case 'Add-Item' :
             var path = System.RootURL + '/form/sh/im/shim00010.aspx';
	         var object = System.OpenModal( path ,950 , 600 ,  'resizable:yes;status:yes');
        break;   
      }
 }
 
 //---------------------------------------------------------
 function OnPopUp(pos, col)
 {
      switch (pos)         
      {		  
        case 'Dept':
            var fpath = System.RootURL + "/form/sh/ab/shab00150.aspx";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[2]; 
               txtDeptPk.text  = object[0]; 
               txtDeptCode.text  = object[1]; 
            }  
        break;               
        case 'BillTo' :
            if (grdDetail.rows>1)
            {
                alert("Cannot change Customer when you have selected item!!!");
                return;
            }    
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	         
	            txtBillToPK.text   = object[0];  
                txtBillToCode.text = object[1];
                txtBillToName.text = object[2];
                
                if ( txtDeliToPK.text == '' )
                {
	                txtDeliToPK.text   = object[0];
                    txtDeliToPK1.text  = object[0];
                    dsbs00010_4.Call("SELECT");
                }
              
	         }
	    break;
	         
        case 'DeliTo' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtDeliToPK.text   = object[0];

                txtDeliToPK1.text  = object[0];
                dsbs00010_4.Call("SELECT");
	         }
	    break; 
	         
        
        
        case 'Emp' :
             
                 var path = System.RootURL +'/form/sh/ab/shab00020.aspx';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                txtEmpPK.text   = obj[0];
	                txtEmpCode.text = obj[4];
                    txtEmpName.text = obj[5];
                 }	
	    break;
	    
	    case 'Detail' :
	         var row  = event.row;
	         var col  = event.col;
	         
             if( ( col == G1_item_unit  ) &&  row!=0)
             {
                   var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	               var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
	               
	               if ( obj != null )
	               {
	                    grdDetail.SetGridText(row,col,obj[1]);
	               }	
                  CheckInput();
             }
             if(( col == G1_cap_col||col== G1_cap_col_nm ) &&  row!=0)  
             {
                   var path = System.RootURL + '/form/sh/ab/shab00030.aspx';
	               var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
	               
	               if ( obj != null )
	               {
	                    grdDetail.SetGridText(row,G1_cap_col,obj[1]);
	                    grdDetail.SetGridText(row,G1_cap_col_nm,obj[3]);
	                    grdDetail.SetGridText(row,G1_cap_col_pk,obj[0]);
	               }	
                  CheckInput();
             }           
             if(( col == G1_body_col||col== G1_body_col_nm ) &&  row!=0)  
             {
                   var path = System.RootURL + '/form/sh/ab/shab00030.aspx';
	               var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
	               
	               if ( obj != null )
	               {
	                    grdDetail.SetGridText(row,G1_body_col,obj[1]);
	                    grdDetail.SetGridText(row,G1_body_col_nm,obj[3]);
	                    grdDetail.SetGridText(row,G1_body_col_pk,obj[0]);
	               }	
                  CheckInput();
             }             
          break;
          case 'Dest Nation':
                           
          break;          
          case 'Dest Port':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA50";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGSA50';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstDestPort.value = object[1];	            
	         }                
          break;
          case "Deli Method":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0250";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0250';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                
	            }
	            else
	                lstDeliMethod.value = object[1];	            
	         }                          
          break;
          case "Ord Type":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGMF0090";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGMF0090';
	                iCodeID           = object[1];
	                
	                datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstOrdType.value = object[1];	            
	         }                          
          break;
          case "Price type":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0130';
	                iCodeID           = object[1];
                    
                    datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstPriceType.value = object[1];	            
	         }                          
          break;
          case "Pay Way":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0110';                                                    
                    iCodeID           = object[1]; 
                    
                    datGetNewCode.Call("SELECT");             
	            }
	            else
	                lstPayForm.value = object[1];	            
	         }                          
          break;
          case "Pay Term":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0120";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0120';                                                   
                    iCodeID           = object[1]; 
                    
                    datGetNewCode.Call("SELECT");              
	            }
	            else
	                lstPayTerm.value = object[1];	            
	         }                          
          break;
          case "Ex Nation":
                                    
          break;          
          case "Currency":
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0100';                                                  
                    iCodeID           = object[1];
                    
                    datGetNewCode.Call("SELECT");                                    
	            }
	            else
	                lstCurrency.value = object[1];	            
	         }                          
          break;        
          case 'Ex Port':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA40";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGSA40';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstExPort.value = object[1];	            
	         }                
          break;    
          case 'Country':
             var path = System.RootURL + "/form/fp/ab/fpab00420.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         var data = "<%=ESysLib.SetListDataSQL("select pk,COUNTRY_NM from imex.tie_country a where del_if =0 order by a.COUNTRY_NM" )%>";    
             lstDestNation.SetDataText(data);
	         
          break;    
          case 'Deli Term':
             var path = System.RootURL + "/form/fp/ab/fpab0020.aspx?code_group=LGCM0260";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0260';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                                                  
	            }
          
	         }                
          break;                                   
      }         
 }  
 //---------------------------------------------------------
 function OnDeleteDetail()
 {
    var ctrl = grdDetail.GetGridControl();

	var row  = ctrl.row;
		
	if ( row < 0 ) 
	{			
			alert("Please select one row to delete .");
	}			
	else 
	{
		if ( grdDetail.GetGridData( ctrl.row, 0 ) == "" ) 
	    {						
		
				grdDetail.RemoveRow();					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdDetail.DeleteRow();
			}
		}
	}
 }
 //------------------------------------------------------------
function OnValidate()
 {
    for(i = 1; i < grdDetail.rows ; i++)
    {
        if( Number(grdDetail.GetGridData(i,G1_ord_qty)) == 0&& grdDetail.GetRowStatus(i)!=64 ) 
        {
            alert("Please input order quantity at " + i)
            return false;
        } 
        if( Number(grdDetail.GetGridData(i,G1_unit_price)) == 0&& grdDetail.GetRowStatus(i)!=64 ) 
        {
            alert("Please input order unit price 1 at " + i)
            return false;
        } 
        if( Number(grdDetail.GetGridData(i,G1_unit_price_2)) == 0&& grdDetail.GetRowStatus(i)!=64 ) 
        {
            alert("Please input order unit price 2 at " + i)
            return false;
        } 
    }
    return true;
 }
 //---------------------------------------------------------
 function OnUnDeleteDetail() 
 {
	grdDetail.UnDeleteRow()
 }
 var p_update = 0 ;
 //---------------------------------------------------------
 function OnSave(pos)
 {
    var flag = 0;
      switch (pos)         
      {		        
            case 1 :
                p_update = 1 ;
                if(OnValidate())
                {
                    grd_order_master.Call();
                }
            break;
            
            case 2 :
                
                for ( i = 1; i < grdDetail.rows ; i++ )
                {
                    if ( grdDetail.GetGridData(i,G1_tsa_saleorder_pk) == "" )
                    {
                        grdDetail.SetGridText( i ,G1_tsa_saleorder_pk , txtOrderPK.text ) ;
                    } 
                }
                flag = 0;
                if(flag==0) dsbs00010_2.Call();    
                           
            break;
      }  
 }
 //------------------------------------------------------------------
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
    var price_lst = 1;
    price_lst = lstPriceBy.value;    
    if(price_lst=='')
    {
        price_lst = 1;
    }
    if ( col == G1_ord_qty  )
    {      
        var dQuantiy,dPrice,dPrice2
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        dPrice = grdDetail.GetGridData(row,G1_unit_price);
        dPrice2 = grdDetail.GetGridData(row,G1_unit_price_2);
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,G1_amount,Number(dQuantiy)*Number(dPrice)/price_lst);
                grdDetail.SetGridText(row,G1_amount_2,Number(dQuantiy)*Number(dPrice2)/price_lst);
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
    } 
    if (col==G1_unit_price)
    {
        var dQuantiy ,dPrice
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        dPrice = grdDetail.GetGridData(row,G1_unit_price);
        if (Number(dPrice))
        {   
            if (dPrice >0)
            {
                grdDetail.SetGridText(row,G1_amount,Number(dQuantiy)*Number(dPrice)/price_lst);
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
    }
    if (col==G1_unit_price_2)
    {
        var dQuantiy,dPrice2
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        dPrice2 = grdDetail.GetGridData(row,G1_unit_price_2);
        if (Number(dPrice2))
        {   
            if (dPrice2 >0)
            {
                grdDetail.SetGridText(row,G1_amount_2,Number(dQuantiy)*Number(dPrice2)/price_lst);
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
    }
    TotalAmount();
 }
 //------------------------------------------------------------------
 function TotalAmount()
 {
    var total_amt1=0 ;
    var total_amt2=0 ; 

    for(i=1; i<grdDetail.rows; i++ )
    {
        total_amt1=total_amt1+Number (grdDetail.GetGridData(i,G1_amount) );
        total_amt2=total_amt2+Number (grdDetail.GetGridData(i,G1_amount_2) );
    }
    txtNetAmt.text = Number(total_amt1).toFixed(3)+""
    txtGrossAmt.text = Number(total_amt2).toFixed(3)+""
    TotalAmount2();
 }
 //-------------------------------------------------------------------
 function TotalAmount2()
 {
    txtTotalAmount.text=Number(txtGrossAmt.text)+Number(txtFreightChar.text)+Number(txtInsurance.text)+Number(txtSurcharge.text)-Number(txtDiscount.text)+Number(txtOthers.text);
 }
//---------------------------------------------------------
 function OnDelete()
 {
    if ( confirm ( "Do you want to delete this order?" ) )
      {

        grd_order_master.StatusDelete();
        
        if (txtOrderPK.text!="")
        
            grd_order_master.Call()
            
        else
        
            alert("Please,Select a SO !")
     }
 }
//==============================================================================

function ShowGrid()        
{   
    this.Height        
    window.frames["ifrContent"].document.location.href = "dsbs00016.aspx?tsa_saleorder_pk="+ txtOrderPK.text ;          
}
//==============================================================================

function OnSetDate(pos)
{
}
//==============================================================================
function OnPrint()
{
    if(txtOrderPK.text!="")
    { 
         var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/ex/rpt_shex00010.rpt&export_pdf=Y&procedure=sale.sp_rpt_shex00010&parameter=" + txtOrderPK.text ;
	     System.OpenTargetPage(url);
	}
	else
	{
	    alert("Please select Order to report");
	}
}
//==============================================================================
function CancelConfirm()
{
    if(dtConfirmDate.value!="")
    {
        if ( confirm('Do you want to Cancel Confirm for this SO.') )
            {
                shex00010_9.Call();
            }  
    }
       
}
//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shex00010_9" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sale.sp_pro_shex00010_9" > 
                <input>
                    <input bind="txtOrderPK" />  
                </input> 
                <output> 
                    <output bind="txtresult1" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <!------------------------------------------------------------------>
    <gw:data id="grd_order_master" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37" function="sale.sp_sel_shex00010_sh" procedure="SALE.sp_upd_shex00010_sh"> 
                <inout> 
                    <inout bind="txtOrderPK" />
                    <inout bind="txtSoNo" />
                    <inout bind="dtOrderDate" />  
                    <inout bind="lstOrdType" />
                    <inout bind="dtConfirmDate" />
                    <inout bind="txtDeptPk" />
                    <inout bind="txtDeptCode" />  
                    <inout bind="txtDeptName" />
                    
                    <inout bind="txtEmpPK" />
                    <inout bind="txtEmpCode"/>
                    <inout bind="txtEmpName"/>
                    <inout bind="txtBillToPK" />
                    <inout bind="txtBillToCode" />
                    <inout bind="txtBillToName" /> 
                    <inout bind="txtCustCountry" />
                    <inout bind="lstDeliMethod" />
                    <inout bind="lstDestNation" />
                    <inout bind="txtPONum" />
                    <inout bind="txtDyeCompTable" />
                    <inout bind="txtCoA" />
                    <inout bind="lstDestPort" />
                    <inout bind="dtPODate" />
                    
                    <inout bind="lstPriceType" />
                    <inout bind="lstCurrency" />
                    <inout bind="lstPayTerm" />
                    <inout bind="txtGrossAmt" />
                    <inout bind="lstPackingMethod" />
                    <inout bind="txtNetAmt" />
                    <inout bind="txtLCNo" />
                    <inout bind="txtReceipt" />
                    <inout bind="txtFreightChar" />
                    <inout bind="txtDiscount" />
                    <inout bind="txtOthers" />
                    <inout bind="txtInsurance" />
                    <inout bind="txtSurcharge" />
                    <inout bind="txtTotalAmount" />
                    <inout bind="txtShipMark" />
                    <inout bind="txtRemark" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dsbs00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="sale"   parameter="0,1,2,3" function="SALE.sp_sel_shex00010_sh_list" > 
                <input> 
                    <input bind="dtFromOrderDate" /> 
                    <input bind="dtToOrderDate" /> 
                    <input bind="txtPOSONo" /> 
                    <input bind="lstOrderStatus1" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dsbs00010_2" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32" function="SALE.sp_sel_shex00010_sh_2"  procedure="sale.sp_upd_shex00010_sh_2" > 
                <input> 
                    <input bind="txtOrderPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dsbs00010_4" onreceive=""> 
        <xml> 
            <dso  type="control" function="sale.sp_sel_dsbs00010_4" > 
                <inout>
                    <inout bind="txtDeliToPK1"/>
                    <inout bind="txtDeliLocPK"/>
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtComCodeID" />
                </input>
	           <output>
	                <output bind="txtCodeTemp" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <gw:data id="dsbs00010_8" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_get_rate" > 
                <input>   
                    <input bind="dtOrderDate" />
                    <input bind="lstCurrency" />
                </input> 
                <output>
                    <output bind="txtExchangeRate" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id='left' style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 30%">
                            <b>Date</b>
                        </td>
                        <td style="width: 79%">
                            <gw:datebox id="dtFromOrderDate" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtToOrderDate" lang="1" styles="width:100%" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnOrderNoSearch" img="search" onclick='OnSearch(1)' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 20%; white-space: nowrap">
                            <b>SO No</b></td>
                        <td colspan="2">
                            <gw:textbox id="txtPOSONo" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 30%">
                            Status
                        </td>
                        <td colspan="2">
                            <gw:list id="lstOrderStatus1" styles='width:100%' onchange="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|SO No|Order DT|Order No" format="0|0|4|0" aligns="0|0|1|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1500|1200|1000" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true" param="0,1,2,3" oncellclick="OnSearch(2)" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id='right' style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Request Production No.</b>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtSoNo" styles='width:100%' csstype="mandatory" onenterkey="SetItemSequence()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Request Date</b>
                                    </td>
                                    <td style="width: 10%">
                                        <gw:datebox id="dtOrderDate" lang="1" onchange="dsbs00010_8.Call()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap">
                                    </td>
                                    <td>
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnAdd" onclick="AddOnClick('Master')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="save" alt="Save" id="btnUpdate" onclick="OnSave(1)" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="excel" alt="Print report" id="btnPrint2" onclick="OnPrint()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Company</b>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstCompany" styles='width:100%'>
                                            <data>
											    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>
										    </data>
										</gw:list>
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Type</b>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstOrdType" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap">
                                        Confirm Date
                                    </td>
                                    <td>
                                        <gw:datebox id="dtConfirmDate" lang="1" nullaccept />
                                    </td>
                                    <td colspan="4" style="white-space: nowrap" align="right">
                                        <button onclick="CancelConfirm()">
                                            Cancel Confirm</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="white-space: nowrap" align="left">
                                        <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="1" id="Gen-Info">General Info</span> 
                                            <span value="2" id="Exten-Info">Extension Info</span> 
                                        </gw:radio>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table id="Tab-Deli-Info" style="width: 100%; height: 100%">
                                <tr>
                                    <td colspan="6">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td style="white-space: nowrap" align="right">
                                                    <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dept',1)">Department </b>
                                                </td>
                                                <td style="white-space: nowrap">
                                                    <gw:textbox id="txtDeptPk" csstype="mandatory" styles='display:none' />
                                                    <gw:textbox id="txtDeptCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtDeptName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                                <td style="white-space: nowrap" align="right">
                                                    <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Emp',1)">Sale Person </b>
                                                </td>
                                                <td style="white-space: nowrap">
                                                    <gw:textbox id="txtEmpPK" maxlen="100" styles='width:100%;display:none' />
                                                    <gw:textbox id="txtEmpCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtEmpName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 10%" align="right">
                                                    <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BillTo',1)">Customer </b>
                                                </td>
                                                <td style="width: 40%; white-space: nowrap">
                                                    <gw:textbox id="txtBillToPK" maxlen="100" styles='width:100%;display:none' />
                                                    <gw:textbox id="txtBillToCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtBillToName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                                <td style="width: 10%" align="right">
                                                    Country
                                                </td>
                                                <td style="width: 40%; white-space: nowrap">
                                                    <gw:textbox id="txtCustCountry" styles='width:100%' readonly='true' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Deli Method',1)">Transport
                                        </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDeliMethod" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Country',1)">Arrival Country
                                        </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDestNation" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>PO No.</b>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtPONum" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right" colspan="2">
                                        Dying Component
                                        <gw:textbox id="txtDyeCompTable" styles='width:30%' type="number" format="###,###.###"
                                            csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dest Port',1)">Arrival Port
                                        </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDestPort" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>PO Date</b>
                                    </td>
                                    <td style="width: 30%; white-space: nowrap" align="left">
                                        <gw:datebox id="dtPODate" nullaccept lang="1" styles='width:80%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right" colspan="2">
                                        Certificate of Analysis
                                        <gw:textbox id="txtCoA" styles='width:30%' type="number" format="###,###.###" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                            <table id="Tab-Sale-Term" style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Price type',1)">Price Term</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstPriceType" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Currency',1)">Currency</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstCurrency" styles='width:100%' onchange="dsbs00010_8.Call()" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Pay Term',1)">Payment Term
                                        </b>
                                    </td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:list id="lstPayTerm" styles='width:100%' onchange="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Gross Amount </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtGrossAmt" styles='width:100%' type="number" format="###,###.###"
                                            csstype="mandatory" readonly="true" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Packing Method
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstPackingMethod" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Price by
                                    </td>
                                    <td>
                                        <gw:list id="lstPriceBy" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Net Amount</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtNetAmt" styles='width:100%' csstype="mandatory" type="number"
                                            format="###,###.###" readonly="true" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        LC No
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtLCNo" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                        <b>Recipient </b>
                                    </td>
                                    <td style="white-space: nowrap">
                                        <gw:textbox id="txtReceipt" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Freight Charges</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtFreightChar" styles='width:100%' type="number" format="###,###.##"
                                            onblur="TotalAmount2()" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Discount(-)</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtDiscount" styles='width:100%' type="number" format="###,###.##"
                                            onblur="TotalAmount2()" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Others</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtOthers" styles='width:100%' type="number" format="###,###.##"
                                            onblur="TotalAmount2()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Insurance</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtInsurance" styles='width:100%' type="number" format="###,###.##"
                                            onblur="TotalAmount2()" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Surcharge</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtSurcharge" styles='width:100%' type="number" format="###,###.##"
                                            onblur="TotalAmount2()" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Total Amount</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTotalAmount" styles='width:100%' type="number" format="###,###.##"
                                            readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="white-space: nowrap">
                                        Shipping Mark
                                    </td>
                                    <td colspan="5">
                                        <gw:textarea id="txtShipMark" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Remarks
                                    </td>
                                    <td colspan="5">
                                        <gw:textarea id="txtRemark" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 2%">
                                    <td style="width: 95%; white-space: nowrap">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="new" alt="Free Item" id="btnAddDetail" onclick="AddOnClick('PopUpGetItem')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDeleteDetail" onclick="OnDeleteDetail()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDeleteDetail" onclick="OnUnDeleteDetail()" />
                                    </td>
                                </tr>
                                <tr style="height: 99%">
                                    <td colspan="6">
                                        <%--<gw:grid id='grdDetail1' header='Seq|_PK|_TSA_SALEORDER_PK|_TCO_ITEM_PK|Item Code|Item Name|_Unit|Releasing Date|Order Quantity|Supply Qty
                                            |Cancel Qty|Unit Price|Amount|Vat Rate|_Cap Printing Type|Printing Type|Size|Gelatin|Cap/Body Code|Cap/Body Color
                                            |_Body Code|_Body Color|Cap/Body Text|Cap/Body Print Color|_CAP_PRINT_DESC|_Body Text|_Body Print color|_BODY_PRINT_DESC|Shipping Date|_ORD_ITEM_TYPE
                                            |_CAP_COLOR_PK|_BODY_COLOR_PK|_OLD_MAT_CODE|Remark' format='0|0|0|0|0|0|0|4|-0|-0|-0|-2|-2|2|2|2|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0'
                                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            check='||||||||-1||||||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|1|1|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|1'
                                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                            sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="CheckInput()"
                                            acceptnulldate="T" />--%>
                                        <gw:grid id='grdDetail' header='_PK|_TSA_SALEORDER_PK|Seq|_TCO_ITEM_PK|Item Code|Customer|Release Date|ETD|Order Quantity|Unit Price 1|Unit Price 2|Amount 1|Amount 2|Comm Rate|Product Name|Gelatin Type|Size|Print|_CAP_COLOR_PK|_BODY_COLOR_PK|Cap Color Code|Body Color Code|Cap Color Name|Body Color Name|Text of Cap Printing|Text of Body Printing|_CAP_PRINT_TYPE|_CAP_PRINT_COL|Ink of Cap|_BODY_PRINT_TYPE|_BODY_PRINT_COL|Ink of Body|Remark'
                                            format='0|0|0|0|0|0|4|4|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            check='||||||||||||||||||||||||||||||||' editcol='0|0|0|0|0|0|1|1|1|1|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1'
                                            widths='1000|1000|1000|1000|1000|1000|1000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                            sorting='T' autosize='T' styles='width:100%; height:100%' acceptnulldate="T"
                                            onafteredit="CheckInput()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------->
    <gw:textbox id="txtOrderPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK1" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliLocPK" maxlen="100" styles='width:100%;display:none' />
    <gw:list id="lstPayForm" styles='width:100%;display:none' />
    <!------------------Convert UOM------------------------->
    <gw:textbox id="txtOrderUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtQtyOfOderUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtQtyAfterConvert" styles='width:100%;display:none' />
    <!------------------------------------------->
    <gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
    <gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
    <!------------------------------------------->
    <gw:textbox id="txtQtyFormat" styles='width:100%;display:none' />
    <gw:textbox id="txtNumberOfDecimal" styles='width:100%;display:none' />
    <!-------------------------------------------->
    <gw:textbox id="txtresult" styles='width:100%;display:none' />
    <gw:textbox id="txtresult1" styles='width:100%;display:none' />
    <gw:textbox id="txtItem_pk" styles='width:100%;display:none' />
    <gw:list id="lstExPort" styles='width:100%;display:none' onchange="" />
    <gw:textbox id="txtExchangeRate" csstype="mandatory" type="number" format="###,###.###"
        styles='width:100%;display:none' text='' />
</body>
</html>
