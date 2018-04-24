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
    
    
    var G1_seq = 0, 
        G1_pk            =1,         
        G1_tsa_saleorder_pk    =2,    
        G1_tco_item_pk       =3,      
        G1_item_code           =4,   
        G1_item_name              =5, 
        G1_item_unit             =6, 
        G1_item_etd              =7,
        G1_ord_qty                 =8,
        G1_takeout_qty            =9,
        G1_cancel_qty            =10,
        G1_unit_price             =11, 
        G1_amount                =12,
        G1_vat_rate               =13,
        G1_cap_print_type      =14,   
        G1_body_print_type      =15,  
        G1_size_code             =16, 
        G1_gelatin                =17,
        
        G1_cap_col               =18,   
        G1_cap_col_nm          =19, 
        G1_body_col                =20, 
        G1_body_col_nm         =21, 
        G1_cap_char               =22, 
        G1_cap_print_col         =23,
        G1_cap_print_col_desc     =24,
        G1_body_char              =25,
        G1_body_print_col         =26,
        G1_body_print_col_desc     =27,       
        G1_item_eta               =28,
        G1_ord_item_type        =29,     
        G1_cap_col_pk            =30, 
        G1_body_col_pk          =31, 
        G1_old_code               =32,
        G1_remark                 =33;
        
        
       
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
      SetStatus(1);
      OnChangeTab();
      dtFromOrderDate.SetDataText(System.AddDate(dtToOrderDate.GetData(),-5));
      BindingDataList();
      AddOnClick('Master');
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
            txtDeliToCode.SetEnable(false);
            txtDeliToName.SetEnable(false);
            txtDeliLoc.SetEnable(false);
            txtEmpCode.SetEnable(false);
            txtEmpName.SetEnable(false);
            txtDeptCode.SetEnable(false);
            txtDeptName.SetEnable(false);
            radLocalYN.value = 'N'
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

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA1010') FROM DUAL" )%>";    
        lstOrderStatus2.SetDataText(data);
        lstOrderStatus2.value = '10'
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0250') FROM DUAL" )%>";    
        lstDeliMethod.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0260') FROM DUAL" )%>";    
        lstDeliTerm.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataSQL("select pk,COUNTRY_NM from imex.tie_country a where del_if =0 order by a.COUNTRY_NM" )%>";    
        lstExNation.SetDataText(data);

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

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA40') FROM DUAL" )%>";    
        lstExPort.SetDataText(data);

        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGSA50') FROM DUAL" )%>";    
        lstDestPort.SetDataText(data); 
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0130') FROM DUAL" )%>";    
        lstPriceType.SetDataText(data); 
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0280') FROM DUAL" )%>";    
        lstRegion.SetDataText(data); 
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGIV0070') FROM DUAL" )%>";    
        lstTaxRate.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0150') FROM DUAL" )%>";   
         
        lstPackingMethod.SetDataText(data);
        lstPackingMethod.value="";
        
        data = "<%=ESysLib.SetListDataSQL("SELECT a.num_value1, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGHC0020' and a.use_if = 'Y' and def_yn ='Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord" )%>";  
        lstPriceBy.SetDataText(data);
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0030' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord" )  %>|| " ; 
        grdDetail.SetComboFormat(G1_gelatin,data);       
        
        <%=ESysLib.SetGridColumnComboFormat("grdDetail",14,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;        
        <%=ESysLib.SetGridColumnComboFormat("grdDetail",15,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
        <%=ESysLib.SetGridColumnComboFormat("grdDetail",13,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGIV0070' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;    
        //<%=ESysLib.SetGridColumnComboFormat("grdDetail",16,"SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0030' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;
        
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
                              
//            if ( grd_order_master.GetStatus() == 20 )
//            {
//                if ( confirm('Do you want to save first !!!'))
//                {
//                    OnSave(1);
//                }
//                else
//                {
//                    if ( grdSearch.row > 0 )
//                    {
//                        txtOrderPK.text = grdSearch.GetGridData(grdSearch.row,0);
//                    }                
//                    grd_order_master.Call("SELECT");
//                }                
//            } 
//            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtOrderPK.text = grdSearch.GetGridData(grdSearch.row,0);
                }
                grd_order_master.Call("SELECT");
            }                       
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
                //p_update = 0 ;
                if(lstOrderStatus2.value=='20')
                    {
                        lstOrderStatus2.SetEnable(false);
                    }
                else
                    {
                        lstOrderStatus2.SetEnable(true);
                    }
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
            //------------------------------
            //grdDetail.GetGridControl().AutoSize(0,42,false,0); 
        break;
        
        case "datGetNewCode":
             /*if(txtComCodeID.text == 'COAB0080')
             {
                lstDestNation.SetDataText(txtCodeTemp.text);  
                lstDestNation.value = iCodeID;                      
             }
             else  */
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
             /*if(txtComCodeID.text == 'COAB0080')
             {
                lstExNation.SetDataText(txtCodeTemp.text);  
                lstExNation.value = iCodeID;                      
             }         
             else */
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
             else 
             if(txtComCodeID.text == 'LGCM0260')
             {
                lstDeliTerm.SetDataText(txtCodeTemp.text);  
                lstDeliTerm.value = iCodeID;                      
             }   
             else 
             if(txtComCodeID.text == 'LGCM0280')
             {
                lstRegion.SetDataText(txtCodeTemp.text);  
                lstRegion.value = iCodeID;                      
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
            lstOrderStatus2.value = '10'
            lstOrderStatus2.SetEnable(true);
            radLocalYN.value = 'N'
            
            txtEmpPK.text = user_pk ;
            txtEmpName.text = user_name ;
            txtEmpCode.text ="<%=Session("EMP_ID")%>" ;
            
            txtSaleRep.text = '' ;
            lstPackingMethod.value='';
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
               /* var max ;
                //--------------------------------
                if(grdDetail.rows>1)
                {
                 max =Number( grdDetail.GetGridData(1,0));      
                alert(max)
                for(var j=1; j < grdDetail.rows; j++)
                {
                    if(Number(grdDetail.GetGridData(j,0))>max)
                   max =  Number(grdDetail.GetGridData(j,0));
                }
                }
                //------------------------------------
                if(max == '' || max == null)
                {
                   countSeq = 0;
                }
                else
                {
                    countSeq = max.substring(txtSoNo.text.length,max.length);
                   alert(txtSoNo.text.length)
                  alert(max) 
                  alert(max.length)  
                   alert(countSeq) 
                }*/
                //----------------------------------------
                for( var i=0; i < object.length; i++)	  
                {	
                    arrTemp = object[i];
                    grdDetail.AddRow();
                    grdDetail.SetGridText( grdDetail.rows-1, G1_tsa_saleorder_pk, txtOrderPK.text) ;//master_pk
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_tco_item_pk,    arrTemp[0]);//item_pk	    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_code,      arrTemp[2]);//item_code	    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_name,      arrTemp[3]);//item_name	    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_unit,      arrTemp[5]);//item_uom
                    grdDetail.SetGridText( grdDetail.rows-1, G1_size_code,      arrTemp[18]);
                    //countSeq++;	    
                    //grdDetail.SetGridText( grdDetail.rows-1, G1_seq,              txtSoNo.text+countSeq);	    
                    //------------------------------------
                   if(arrTemp[6] != "" || arrTemp[12] != "")
                  {  
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col,              arrTemp[6]+' / '+arrTemp[12]); // cap/body code
                   }
                  //------------------------------------ 
                  if(arrTemp[7] != "" || arrTemp[13] != "")
                  {  
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col_nm,           arrTemp[7] + ' / ' + arrTemp[13]) ; // cap/body color
                   } 
                  //------------------------------------ 
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_type,       arrTemp[8]);
                   //------------------------------------ 
                    if(arrTemp[9] != "" || arrTemp[15]!= "")
                   { 
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_col,        arrTemp[9] + ' / ' + arrTemp[15]) ;	    // cap/body print color
                   }
                  //------------------------------------ 
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_print_col_desc,   arrTemp[10]);
                   //------------------------------------ 
                   if(arrTemp[11] != "" || arrTemp[17] != "")
                  {  
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_char,             arrTemp[11] + ' / ' + arrTemp[17]); // cap/body text
                    }
                   //------------------------------------ 
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col,             arrTemp[12]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col_nm,          arrTemp[13]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_type,      arrTemp[14]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_col,       arrTemp[15]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_print_col_desc,  arrTemp[16]);                    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_char,            arrTemp[17]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_cap_col_pk,           arrTemp[22]);
                    grdDetail.SetGridText( grdDetail.rows-1, G1_body_col_pk,          arrTemp[23]);	    
                   
                    
                    grdDetail.SetGridText( grdDetail.rows-1, G1_vat_rate,         lstTaxRate.value      );//tax Rate
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_etd,         dtETD.value          );//dtETD
                    grdDetail.SetGridText( grdDetail.rows-1, G1_item_eta,         dtETA.value          );//dtETA
                    grdDetail.SetGridText( grdDetail.rows-1, G1_remark,         "New Order"          );
                    grdDetail.SetGridText( grdDetail.rows-1, G1_old_code,         arrTemp[24]          );
                    grdDetail.SetGridText( grdDetail.rows-1, G1_gelatin,         arrTemp[25]          );
                    
                    
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
                    txtDeliToCode.text = object[1];
                    txtDeliToName.text = object[2];
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
                txtDeliToCode.text = object[1];
                txtDeliToName.text = object[2];
                txtDeliToPK1.text  = object[0];
                dsbs00010_4.Call("SELECT");
	         }
	    break; 
	         
        case 'DeliLoc' :
             if ( txtDeliToPK.text != '' )
             {
                 var path = System.RootURL + '/form/fp/ab/fpab00180.aspx?partner_pk=' + txtDeliToPK.text + '&partner_id=' + txtDeliToCode.text + '&partner_name=' + txtDeliToName.text ;
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
	                txtDeliLocPK.text = object[0];
                    txtDeliLoc.text   = object[4];
	             }	
	         }
	         else
	         {
	            alert('Pls Select Deliery To first !!!');
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
          case 'Deli Term':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0260";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0260';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstDeliTerm.value = object[1];	            
	         }                
          break;  
          /*case 'Region':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0280";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'LGCM0280';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                                                  
	            }
	            else
	                lstDeliTerm.value = object[1];	            
	         }                
          break;*/                                            
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
                grd_order_master.Call();
            break;
            
            case 2 :
                for ( i = 1; i < grdDetail.rows ; i++ )
                {
                    if ( grdDetail.GetGridData(i,G1_tsa_saleorder_pk) == "" )
                    {
                        grdDetail.SetGridText( i ,G1_tsa_saleorder_pk , txtOrderPK.text ) ;
                    }
                   if( grdDetail.GetGridData(i,G1_ord_qty) == "" ) 
                  {
                    alert("Please input order quantity at " + i)
                   flag = 1; 
                  } 
                    grdDetail.SetGridText( i ,G1_ord_item_type , lstOrdType.value ) ;
                }
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
    
    if ( col == G1_ord_qty  || col == G1_unit_price  )
    {      
        var dQuantiy, dPrice
        var u_price =1;
         if (Number(lstPriceBy.value)>0)
          {
        
            u_price = lstPriceBy.value
         }
         else
         {
            u_price = 1
         }
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        dPrice =  grdDetail.GetGridData(row,G1_unit_price);
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,G1_amount,Number(dQuantiy)/u_price*Number(dPrice));
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
    if ( col == G1_ord_qty  )
    {
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        grdDetail.SetGridText(row,G1_takeout_qty,Number(dQuantiy))
    }
    
    if ( col == G1_ord_qty  || col == G1_takeout_qty  )
    {
        dQuantiy =  grdDetail.GetGridData(row,G1_ord_qty);
        dTakeOut =  grdDetail.GetGridData(row,G1_takeout_qty);
        grdDetail.SetGridText(row,G1_cancel_qty,Number(dQuantiy)-Number(dTakeOut))
    }
    TotalAmount();
 }
 //------------------------------------------------------------------
 function TotalAmount()
 {
    var sumOder,sum ,QtyCol
    sum =0
    sumOder =0
    QtyCol = G1_ord_qty;
    
    QtyCol = G1_ord_qty;
     var u_price =1;
     if (Number(lstPriceBy.value)>0)
      {
    
        u_price = lstPriceBy.value
     }
     else
     {
        u_price = 1
     }
    
    for(i=1; i<grdDetail.rows; i++ )
    {
        var dValueOder ,dValueTotal
        
       dValueTotal = grdDetail.GetGridData(i,G1_amount) ;
       
       if ( Number(dValueTotal) )
       {
            sum = sum + parseFloat(dValueTotal);
          
            dValueOder =  (grdDetail.GetGridData(i,QtyCol)/u_price )* grdDetail.GetGridData(i,G1_unit_price)
            sumOder = sumOder + dValueOder
       }
       
    }
    txtTotalAmt.text = sum.toFixed(3)+""
    txtOrdAmt.text = sumOder.toFixed(3)+""
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
    switch(pos)
    {
        case 'ETD' :
            if ( confirm('Do you want to reset ETD for grid.') )
            {
                for ( var i=1; i<grdDetail.rows; i++ )
                {
                    grdDetail.SetGridText( i, G1_item_etd, dtETD.value );
                } 
            }           
        break;
        
        case 'ETA' :
            if ( confirm('Do you want to reset ETA for grid.') )
            {        
                for ( var i=1; i<grdDetail.rows; i++ )
                {
                    grdDetail.SetGridText( i, G1_item_eta, dtETA.value );
                } 
            }           
        break;
    }
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
    <gw:data id="dsbs00010_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sale.sp_pro_dsbs00010_3" > 
                <input>
                    <input bind="txtUOM" /> 
                    <input bind="txtOrderUOM" /> 
                    <input bind="txtQtyOfOderUOM" /> 
                    <input bind="txtItem_pk" /> 
                </input> 
                <output> 
                    <output bind="txtQtyAfterConvert" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="grd_order_master" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49" function="sale.sp_sel_shex00010_sh" procedure="SALE.sp_upd_shex00010_sh"> 
                <inout> 
                    <inout bind="txtOrderPK" />
                    <inout bind="dtOrderDate" />  
                    <inout bind="txtSoNo" />
                    <inout bind="lstOrderStatus2" />
                    <inout bind="txtBillToPK" />
                    <inout bind="txtBillToCode" />
                    <inout bind="txtBillToName" />           
                    <inout bind="txtDeliToPK" />
                    <inout bind="txtDeliToCode" />
                    <inout bind="txtDeliToName" /> 
                    <inout bind="lstDeliMethod" />
                    <inout bind="lstDeliTerm" />        
                    <inout bind="txtDeliLocPK" />  
                    <inout bind="txtDeliLoc" />  
                    <inout bind="lstExNation" />  
                    <inout bind="lstDestNation" />       
                    <inout bind="txtPONum" /> 
                    <inout bind="lstExPort" />
                    <inout bind="lstDestPort" /> 
                     
                    <inout bind="txtRemark" />
                    <inout bind="txtShipMark" />
                    
                    <inout bind="lstCurrency" /> 
                    <inout bind="txtEmpPK" />
                    <inout bind="txtEmpCode"/>
                    <inout bind="txtEmpName"/>
                    <inout bind="lstTaxRate" /> 
                    <inout bind="lstOrdType" />
                    <inout bind="lstPayForm" /> 
                    <inout bind="txtSaleRep" /> 
                    <inout bind="lstPayTerm" />
                    <inout bind="txtBuyReq" />  
                    <inout bind="txtOrdAmt" />
                    <inout bind="txtTotalAmt" /> 
                    <inout bind="dtETD" />
                    <inout bind="dtETA" />
                    <inout bind="txtExchangeRate" />    
                    <inout bind="dtPODate" />
                    <inout bind="txtDeptPk" />    
                    <inout bind="txtDeptCode" />  
                    <inout bind="txtDeptName" />
                    <inout bind="radProdYN" />
                    <inout bind="lstRegion" />
                    <inout bind="radLocalYN" />
                    <inout bind="lstPackingMethod" />
                    <inout bind="txtCoA" />
                    <inout bind="txtDyeCompTable" />
                    <inout bind="dtConfirmDate" />
                    <inout bind="lstPriceType" />   
                    <inout bind="txtLCNo" />  
                    <inout bind="txtReceipt" />    
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
            <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33" function="SALE.sp_sel_shex00010_sh_2"  procedure="sale.sp_upd_shex00010_sh_2" > 
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
                    <inout bind="txtDeliLoc"/>
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
    <!------------------------------------------------------------------>
    <gw:data id="dsbs00010_5" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="control"  function="sale.sp_sel_dsbs00010_5"> 
                <inout> 
                    <inout bind="txtNumberOfDecimal" />
                    <inout bind="txtQtyFormat" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dsbs00010_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sale.sp_pro_dsbs00010_1" > 
                <input>
                     <input bind="txtOrderPK" /> 
                </input> 
                <output> 
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <%--<gw:data id="dsbs00010_7" onreceive=""> 
        <xml> 
            <dso  type="control" function="SALE.sp_pro_dsbs00010_2" > 
                <inout>
                    <inout bind="txtBillToPK" />
                    <inout bind="txtBillToCode" />
                    <inout bind="txtBillToName" />           
                    <inout bind="txtDeliToPK" />
                    <inout bind="txtDeliToCode" />
                    <inout bind="txtDeliToName" />     
                    <inout bind="txtDeliLocPK" />  
                    <inout bind="txtDeliLoc" /> 
                </inout>
            </dso> 
        </xml> 
    </gw:data>--%>
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
                                        <b>Ord Date</b>
                                    </td>
                                    <td style="width: 10%">
                                        <gw:datebox id="dtOrderDate" lang="1" onchange="dsbs00010_8.Call()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Status
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstOrderStatus2" styles='width:100' />
                                    </td>
                                    <td style="width: 5%">
                                        Confirm Date
                                    </td>
                                    <td colspan="2">
                                        <gw:datebox id="dtConfirmDate" lang="1" nullaccept />
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
                                    </td>
                                    <td style="width: 1%" align="left">
                                        <gw:imgbtn img="excel" alt="Print report" id="btnPrint2" onclick="OnPrint()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Company</b>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstCompany" styles='width:100%'>
                                            <data>
											    <%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>||
										    </data>
										</gw:list>
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <b>Ord Type</b>
                                    </td>
                                    <td style="width: 10%">
                                        <gw:list id="lstOrdType" styles='width:100%' />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Local
                                    </td>
                                    <td style="width: 25%">
                                        <gw:radio id="radLocalYN" value="N" styles="width:100%"> 
                                            <span value="Y" id="Span1">Y</span> 
                                            <span value="N" id="Span2">N</span> 
                                        </gw:radio>
                                    </td>
                                    <td colspan="8">
                                        Production Inst.
                                        <gw:radio id="radProdYN" value="Y" styles="width:100%"> 
                                            <span value="Y" id="Span3">Y</span> 
                                            <span value="N" id="Span4">N</span> 
                                        </gw:radio>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="white-space: nowrap" align="left">
                                        <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="1" id="Gen-Info">General Info</span> 
                                            <span value="2" id="Exten-Info">Extension Info</span> 
                                        </gw:radio>
                                    </td>
                                    <td align="right">
                                    </td>
                                    <td colspan="9" style="white-space: nowrap" align="right">
                                        <button onclick="CancelConfirm()">
                                            Cancel Confirm</button>
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
                                                    <gw:textbox id="txtEmpCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtEmpName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 10%" align="right">
                                                    <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('BillTo',1)">Customer </b>
                                                </td>
                                                <td style="width: 40%; white-space: nowrap">
                                                    <gw:textbox id="txtBillToCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtBillToName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                                <td style="width: 10%" align="right">
                                                    <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliTo',1)">Deli To </b>
                                                </td>
                                                <td style="width: 40%; white-space: nowrap">
                                                    <gw:textbox id="txtDeliToCode" csstype="mandatory" styles='width:30%' />
                                                    <gw:textbox id="txtDeliToName" csstype="mandatory" styles='width:70%' />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; display: none" align="right">
                                        Shipping DT
                                    </td>
                                    <td style="width: 20%; display: none">
                                        <gw:datebox id="dtETA" lang="1" nullaccept onchange="OnSetDate('ETA')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap; display: none" align="right">
                                        Release DT
                                    </td>
                                    <td style="width: 20%; display: none">
                                        <gw:datebox id="dtETD" lang="1" nullaccept onchange="OnSetDate('ETD')" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <%--<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Region',1)">Deli Region </b>--%>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstRegion" styles='width:100%;display:none' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstExNation" styles='width:100%;display:none' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <%--<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Deli Term',1)">Deli Term </b>--%>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDeliTerm" styles='width:100%;display:none' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <%--<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliLoc',1)">Deli Loc </b>--%>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtDeliLoc" csstype="mandatory" styles='width:100%;display:none' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Deli Method',1)">Deli Method
                                        </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDeliMethod" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Dest Nation
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDestNation" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>Order No.</b>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtPONum" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Dye Comp
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtDyeCompTable" styles='width:30%' type="number" format="###,###.###"
                                            csstype="mandatory" />
                                        &nbsp;&nbsp;CoA&nbsp;&nbsp;<gw:textbox id="txtCoA" styles='width:30%' type="number"
                                            format="###,###.###" csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dest Port',1)">Dest Port </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstDestPort" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <b>P/O Date</b>
                                    </td>
                                    <td style="width: 30%; white-space: nowrap" align="right">
                                        <gw:datebox id="dtPODate" nullaccept lang="1" styles='width:80%' />
                                    </td>
                                </tr>
                            </table>
                            <table id="Tab-Sale-Term" style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Price type',1)">Price type</b>
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
                                        <%--<b>Tax Rate</b>--%>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstTaxRate" styles='width:100%;display:none' csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                    </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td style="width: 10%" align="right">
                                        <%--<b>Buy Rep</b>--%>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtBuyReq" styles='width:100%;display:none' />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%" align="right">
                                        <b>Total Amt </b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTotalAmt" styles='width:100%' type="number" format="###,###.###"
                                            csstype="mandatory" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Packing Method
                                    </td>
                                    <td style="width: 20%">
                                        <gw:list id="lstPackingMethod" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap">
                                        Unit Price By
                                    </td>
                                    <td>
                                        <gw:list id="lstPriceBy" styles='width:100%' />
                                        <%--<gw:textbox id="txtDyeCompTable" styles='width:100%' type="number" format="###,###.###"
                                            csstype="mandatory" />&nbsp;&nbsp;CoA&nbsp;&nbsp; --%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Order Amt</b>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtOrdAmt" styles='width:100%' csstype="mandatory" type="number"
                                            format="###,###.###" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        LC No
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtLCNo" styles='width:100%' />
                                    </td>
                                    <td style="white-space: nowrap" align="right">
                                        <b>Receipt </b>
                                    </td>
                                    <td style="white-space: nowrap">
                                        <gw:textbox id="txtReceipt" />
                                        <gw:textbox id="txtSaleRep" styles='width:100%;display:none' />
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
                                        <!-- <gw:imgbtn img="new_sub" alt="Select Item" id="btnSelectItem" onclick="AddOnClick('Add-Item')" />-->
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
                                        <%--<gw:grid id='grdDetail' header='_pk|_tsa_saleorder_pk|_tco_item_pk|Item Code|Item Name|Unit|Size|Ord Qty|Supply Qty|Cancelle Qty|Unit Price|Amount|Vat Rate|Cap Col|Cap Col NM|Cap Print Type|Cap Print Col|Cap Print Col Desc|Cap Text|Body Col|Body Col Nm|Body Print Type|Body Print Col|Body Print Col Desc|Body Text|Release DT|Shipping DT|_ord_item_type|_cap_col_pk|_body_col_pk|_Old Code|Remark'
                                            format='0|0|0|0|0|0|0|-0|-0|-0|-2|-2|2|0|0|2|0|0|0|2|0|0|0|0|0|4|4|0|0|0|0|0'
                                            aligns='0|0|0|0|0|0|0|3|3|3|3|3|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||0n|n|n|n|||||||||||||||||||||'
                                            editcol='0|0|0|0|0|0|0|1|1|0|1|0|1|0|0|0|1|1|1|0|0|0|1|1|1|1|1|0|0|0|0|1' widths='0|0|0|1200|2000|600|1000|1000|1000|1000|1200|1200|1000|700|1000|1000|700|1000|1000|1000|700|1000|700|1000|1000|1000|1000|0|1000|1000|1000|1000'
                                            sorting='T' autosize='T' styles='width:100%; height:100%' acceptnulldate="T"
                                            onafteredit="CheckInput()" oncelldblclick="OnPopUp('Detail')" />--%>
                                        <gw:grid id='grdDetail' 
                                            header='Seq|_PK|_TSA_SALEORDER_PK|_TCO_ITEM_PK|Item Code|Item Name|_Unit|Releasing Date|Order Quantity|Supply Qty
                                            |Cancel Qty|Unit Price|Amount|Vat Rate|_Cap Printing Type|Printing Type|Size|Gelatin|Cap/Body Code|Cap/Body Color
                                            |_Body Code|_Body Color|Cap/Body Text|Cap/Body Print Color|_CAP_PRINT_DESC|_Body Text|_Body Print color|_BODY_PRINT_DESC|Shipping Date|_ORD_ITEM_TYPE
                                            |_CAP_COLOR_PK|_BODY_COLOR_PK|_OLD_MAT_CODE|Remark'
                                            format='0|0|0|0|0|0|0|4|-0|-0|-0|-2|-2|2|2|2|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0'
                                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                            check='||||||||-1||||||||||||||||||||||||||' 
                                            editcol='0|0|0|0|0|0|0|1|1|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|1'
                                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                            sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="CheckInput()"
                                            acceptnulldate="T" />
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
    <gw:textbox id="txtBillToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK1" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliLocPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtEmpPK" maxlen="100" styles='width:100%;display:none' />
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
