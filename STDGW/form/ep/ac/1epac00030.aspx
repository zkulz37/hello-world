<%@ Page Language="C#" %> 
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Export Contract</title>
</head>
<%  ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
    var action;
    var flag=0,is_unit_change=0,  rowchange; 
    action='create';
    var G1_tex_contr_dtl_pk = 0,    
        G1_rownum           = 1,    
        G1_item_code        = 2,   
        G1_item_name        = 3,    
        G1_hs_code          = 4,   
        G1_unit_cd          = 5,
        G1_unit_packing     = 6,    
        G1_apportion_yn     = 7,    
        G1_qty              = 8,
        G1_qty_packing      = 9,    
        G1_u_price          = 10,    
        G1_ex_price         = 11,   
        G1_vat_rate         = 12, 
        G1_tot_amt          = 13, 
        G1_retouch_amt      = 14,    
        G1_tr_amt           = 15,   
        G1_tco_item_pk      = 16,    
        G1_tex_contr_mst_pk = 17,    
        G1_tex_order_pk     = 18,    
        G1_tsa_sotakeoutd_pk = 19,    
        G1_cnv_ratio        = 20,    
        G1_pack_rate        = 21,
        G1_contr_status     = 22;
        
    // G2:  grdOrders;    
    var G2_view             = 0,     
        G2_tex_order_pk     = 1,     
        G2_tex_contr_mst_pk = 2,     
        G2_rownum           = 3,     
        G2_order_no         = 4,     
        G2_order_date       = 5,     
        G2_exp_date         = 6,     
        G2_ship_date        = 7,     
        G2_pay_ex_rate      = 8,     
        G2_tr_ccy           = 9,     
        G2_ex_rate          = 10,     
        G2_trade_terms      = 11,     
        G2_pay_meth         = 12,     
        G2_status_text      = 13,     
        G2_description      = 14,     
        G2_close_yn         = 15,     
        G2_close_date       = 16,     
        G2_status           = 17,
        G2_contr_status     = 18,
        G2_type             = 19;
        
    var G3_tex_payment_condition_pk = 0, 
        G3_condition        = 1, 
        G3_pay_percent      = 2, 
        G3_pay_dt           = 3,
        G3_pay_amt          = 4,
        G3_description      = 5
        G3_tex_contr_mst_pk = 6;
                
    function BodyInit()
    {           
        System.Translate(document);  // Translate to language session
        BindingDataList(); 
        getCurrBooking();   
        onAddNew(0);  
        onChangeOrderYN();
        grdContractDetail.GetGridControl().FrozenCols = G1_unit_cd;
                
        getNation();
        txtMasterPK.text="<%=Request["contract_pk"]%>" 
        if(txtMasterPK.text!='')
        {            
            action='view';
            dat_epac00030_1.Call('SELECT');
        }
    }   
    //-----------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.use_if=1 and a.del_if=0 and b.del_if=0 order by a.CODE")%>";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0020','','') FROM DUAL")%>";  //trade term
         var data7 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0010','','') FROM DUAL")%>";  //trade term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0140','','') FROM DUAL")%>";  // payment method         
         var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0020','','') FROM DUAL")%>";  //status
         var data6 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEBD0050','','') FROM DUAL")%>";  // payment method
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
                  
         cboCompany.SetDataText(data1);
         cboTradeTerm.SetDataText(data7);  //IEAB0010
         cboCurrency.SetDataText(data2);  //ACAB0110 
         cboPaymentTerm.SetDataText(data3);   //IEAB0010 
         cboPayCurrency.SetDataText(data2);  //ACAB0110
         cboPaymentMethod.SetDataText(data4); //ACCR0140
         cboTransport.SetDataText(data5);     //IEAB0020
         cboTolerance.SetDataText(data6);  //IEBD0050
         cboDiscount.SetDataText(data6);        //IEBD0050
         
         cboCurrency.value='USD'; 
         cboPayCurrency.value='USD'; 
         getExRate(); 
         getPayExRate();
         
         var data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
         grdContractDetail.SetComboFormat(G1_unit_cd,data);
         grdContractDetail.SetComboFormat(G1_unit_packing,data);
         
         data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0050' and a.use_if=1 and a.del_if=0 and b.del_if=0 order by a.CODE")%>"; 
         grdContractDetail.SetComboFormat(G1_vat_rate,data);
         grdOrderDetail.SetComboFormat(12,data);
         
         data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='LGAB0030' and a.use_if=1 and a.del_if=0 and b.del_if=0 order by a.CODE")%>"; 
         grdCondition.SetComboFormat(G3_condition,data);
         
         data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE " ) %> "; 
         grdOrders.SetComboFormat(G2_tr_ccy,data);
         data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020' and a.del_if=0 and b.del_if=0 order by a.CODE " ) %> "; 
         grdOrders.SetComboFormat(G2_trade_terms,data);
         data = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140' and a.del_if=0 and b.del_if=0 order by a.CODE " ) %> "; 
         grdOrders.SetComboFormat(G2_pay_meth,data);
    }
    //---------------------------------------------------------------------------------------
    function SetGridFormat()
     {
        var ctr = grdContractDetail.GetGridControl(); 
        ctr.ColFormat(G1_qty) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_u_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_ex_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_retouch_amt) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G1_tr_amt) = "#,###,###,###,###,###.##";
        
        ctr = grdOrderDetail.GetGridControl(); 
        ctr.ColFormat(8) = "#,###,###,###,###,###.##";
        ctr.ColFormat(10) = "#,###,###,###,###,###.##";
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
        ctr.ColFormat(12) = "#,###,###,###,###,###.##";
        ctr.ColFormat(13) = "#,###,###,###,###,###.##";
        
        ctr = grdOrders.GetGridControl(); 
        ctr.ColFormat(G2_pay_ex_rate) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G2_ex_rate) = "#,###,###,###,###,###.##";
        
        ctr = grdCondition.GetGridControl(); 
        ctr.ColFormat(G3_pay_amt ) = "#,###,###,###,###,###.##";
     }
    //--------------------------------------------------------------------------------------
    function SetStatus(index)
    {
        txtCusCode.SetEnable(false);
        txtCusName.SetEnable(false);
        txtOrigin.SetEnable(false);
        switch(Number(index))
        {
            case 4:
                //view form
                btnSearch.style.display="none";
                btnNew.style.display="none";
                btnSave.style.display="none";
                btnDel.style.display="none";
                btnExcel.style.display="none";
                btnConfirm.style.display="none";
                btnCancel.style.display="none";
                btnRegenerate.style.display="none";
                btnCopy.style.display="none";
                btnGetItemFree.style.display="none";  
                btnGetItemFromSO.style.display="none"; 
                btnDelItem.style.display="none"; 
                btnRefresh.style.display="none";
                btnOrdSearch.style.display="none"; 
                btnOrdNew.style.display="none"; 
                btnOrdSave.style.display="none"; 
                btnOrdDel.style.display="none"; 
                btnOrdConfirm.style.display="none"; 
                btnOrdCancel.style.display="none"; 
                btnOrdRegenerate.style.display="none"; 
                btnOrdCopy.style.display="none"; 
                btnOrder.style.display="none";
            break;
            case 3:
                //Cancelled	Chỉ hiển thị : Popup,New,Regenerate button

                btnSearch.style.display=""; 
                btnNew.style.display="";
                btnSave.style.display="none"; 
                btnDel.style.display="none"; 
                btnExcel.style.display="none"; 
                btnConfirm.style.display="none"; 
                btnCancel.style.display="none"; 
                btnRegenerate.style.display=""; 
                btnCopy.style.display="none";
            break;
            case 2:
                //Approved	Chỉ hiển thị : Popup,New,Copy,Cancel,Print button

                btnSearch.style.display=""; 
                btnNew.style.display="";
                btnSave.style.display="none"; 
                btnDel.style.display="none"; 
                btnExcel.style.display=""; 
                btnConfirm.style.display="none"; 
                btnCancel.style.display=""; 
                btnRegenerate.style.display="none"; 
                btnCopy.style.display="";
            break;
            case 1:
                //Saved	Chỉ hiển thị : Popup,New,Save,Delete,Approve button

                btnSearch.style.display=""; 
                btnNew.style.display="";
                btnSave.style.display=""; 
                btnDel.style.display=""; 
                btnExcel.style.display="none"; 
                btnConfirm.style.display=""; 
                btnCancel.style.display="none"; 
                btnRegenerate.style.display="none"; 
                btnCopy.style.display="none";
            break;
            
        }
    }     
    //---------------------------------------------------------------------------------------
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {	        	         
           case 0:// Customer 
	            var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AP"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtCusName.SetDataText(aValue[2]); 
	                txtCusCode.SetDataText(aValue[1]);  
	                txtCusPK.SetDataText(aValue[0]);  
	                
	                desc=aValue[7] + ' \nTel  : ' + aValue[10] + ' \nFax  : ' + aValue[12] + ' \nEmail: ' + aValue[11];
	                txtPaidName.SetDataText(aValue[2]); 
	                txtPaidCode.SetDataText(aValue[1]);  
	                txtPaidPK.SetDataText(aValue[0]);  
	                txtPaidAdd.SetDataText(desc);
	            }	
	        break;  
	        case 1:// Ship to 
	            var desc;
	            if (radShipType.value=='b')
	            {
	                var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AP"; //customs
                    aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	                if ( aValue != null )
	                {          
	                    desc=aValue[7] + ' \nTel  : ' + aValue[10] + ' \nFax  : ' + aValue[12] + ' \nEmail: ' + aValue[11];
	                    txtShipName.SetDataText(aValue[2]); 
	                    txtShipCode.SetDataText(aValue[1]);  
	                    txtShipPK.SetDataText(aValue[0]);  
	                    txtShipAdd.SetDataText(desc);
	                }
	            }	
	        break;
	        case 2:// Paid to   
	            var desc;
	            var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AP"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                desc=aValue[7] + ' \nTel  : ' + aValue[10] + ' \nFax  : ' + aValue[12] + ' \nEmail: ' + aValue[11];
	                txtPaidName.SetDataText(aValue[2]); 
	                txtPaidCode.SetDataText(aValue[1]);  
	                txtPaidPK.SetDataText(aValue[0]);  
	                txtPaidAdd.SetDataText(desc);
	            }	
	        break;
	        case 3:  // select contract No.
	            var desc;
	            var fpath = System.RootURL + "/form/ep/ac/epac00031.aspx"; //search contract
                aValue = System.OpenModal( fpath , 900 , 600, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {   
	                txtMasterPK.SetDataText(aValue[0]); 
	                flag=0; // chua goi order
	                _status="select"
                    grdOrders.ClearData();
                    grdContractDetail.ClearData();
	                dat_epac00030_1.Call('SELECT');
	            }	
	        break;
	        case 4:
	            fpath = System.RootURL + "/form/fp/ab/PopUpGetItem.aspx?purchase_yn=N";
                oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
                var isAlready;

                grdContractDetail.RemoveRowAt(grdContractDetail.rows-1)
                isAlready=0;
               
                if (oValue != null)
                {  
                    for ( var i=0; i<oValue.length;i++)
                    {                 
                        aValue=oValue[i];
	                    
	                    for(var k=0; k<grdContractDetail.rows;k++)
	                        if (grdContractDetail.GetGridData(k , G1_tco_item_pk)== aValue[0]) // da co
					        {
						        isAlready=1;
						        break;	
					        }		
					        
					    if(isAlready==0) 
	                    {    
                            var aValue = oValue[i];  
                            grdContractDetail.AddRow();
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_rownum       ,grdContractDetail.rows-1);
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_code    ,aValue[1]); //Item code
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_name    ,aValue[2]); //_item name
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_unit_cd      ,aValue[5]); //Item name
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_qty          ,aValue[7]); //Unit
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tco_item_pk  ,aValue[0]); //tco_item_pk
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_hs_code      ,aValue[22]); //hs code
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_cnv_ratio    ,aValue[23]); //cnv_ratio
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_unit_packing ,aValue[24]); // packing unit
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_pack_rate    ,aValue[25]); // transrate
                        }
                    }
                }
                grdContractDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdContractDetail.SetGridText(grdContractDetail.rows-1,1,'')
                grdContractDetail.GetGridControl().AutoSize(0,19,false,0); 
	        break;
	        case 5:
	            var row = grdOrders.row;
                if(row <=0)
                {
                    alert("Please select Order to add detail.");
                    return;
                }
                else
                {
                    if(grdOrders.GetGridData(row, G2_tex_order_pk)=='')
                    {
                        alert("Please select save Order.");
                        return;
                    }
                    else
                        txtOrderPK.text  = grdOrders.GetGridData(row, G2_tex_order_pk);
                }
              
                    fpath = System.RootURL + "/form/ep/ac/1epac00032.aspx?order_pk=" + txtOrderPK.text + "&contract_pk=" + txtMasterPK.text + "&OrderNo=" + grdOrders.GetGridData(row, G2_order_no) + "&Status=" + txtStatus.text;
                    oValue = System.OpenModal( fpath , 900 , 500 , 'resizable:yes;status:yes'); 
                    
                    //if (oValue != null)
                        dat_epac00030_4.Call('SELECT');
                	            
	        break;
	        case 6:	      
	              
                var colidx;
                colidx= grdOrders.col;
                
                if(colidx==1)
                {     
	                fpath = System.RootURL + "/form/ep/ac/epac00033.aspx?order_pk=" + txtOrderPK.text 
	                + "&order_no=" + grdOrders.GetGridData(grdOrders.row, G2_order_no) + "&order_date=" + grdOrders.GetGridData(grdOrders.row, G2_order_date) + "&Com_pk=" +txtCom_pk.text;
	                             
                    oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
               }
	        break;
	        case 7:
	            if ( Trim(txtCusPK.text)=='')
                {
                    alert("You must input Vendor first!");
                    return;
                }
	            
	            fpath = System.RootURL + "/form/ep/ac/PopUpGetItemFromSaleTakeOut.aspx?vendor_pk=" + txtCusPK.text;
                oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
                var isAlready;
                isAlready=0;
                
                if (oValue != null)
                {  
                    for ( var i=0; i<oValue.length;i++)
                    {               
                        var aValue=oValue[i];
	                    
                        for(var k=0; k<grdContractDetail.rows;k++)
                            if (grdContractDetail.GetGridData(k , G1_tsa_sotakeoutd_pk)== aValue[6]) // da co
				            {
					            isAlready=1;
					            break;	
				            }		
					        
				        if(isAlready==0) 
                        {    //2 1, 3 2, 4 4, 5 3, 6 7, 7 8, 11 0, 14 6
                            aValue = oValue[i];  
                            grdContractDetail.AddRow();
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_rownum       ,i+1);
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_code    ,aValue[1]); //Item code
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_name    ,aValue[2]); //_item name
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_unit_cd      ,aValue[3]); //Item name
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_hs_code      ,aValue[4]); //Unit
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tco_item_pk  ,aValue[0]); //tco_item_pk
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_qty          ,aValue[7]); //
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_u_price      ,aValue[8]); 
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tsa_sotakeoutd_pk,aValue[6]);
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_ex_price     ,Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_u_price))*Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_qty)));
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tr_amt       ,Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_retouch_amt)));
                        }
                    }
                }
                grdContractDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdContractDetail.SetGridText(grdContractDetail.rows-1,1,'')
	        break;
	        case 8: 
	            var fpath = System.RootURL + "/form/ep/ac/GetOrigin.aspx"; //
                aValue = System.OpenModal( fpath , 600 , 400, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtOrigin.SetDataText(aValue[2]); 
	                txtOriginPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 9:        
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPLCofLoading.SetDataText(aValue[3]); 
	                txtPLCofLoadingCD.SetDataText(aValue[2]);  
	            }	
	        break;
	        case 10: 
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPlaceDischarge.SetDataText(aValue[3]); 
	                txtPlaceDischargeCD.SetDataText(aValue[2]);  
	            }	
	        break;
	        case 11: 
	            var fpath = System.RootURL + "/form/fp/ab/PopUpGetLocation.aspx?partner_pk=" + txtCusPK.text + "&partner_id=" + txtCusCode.text + "&partner_name=" + escape( txtCusName.text); //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
              
	            if ( aValue != null )
	            {        
	                txtLocation.SetDataText(aValue[4]); 
	            }	
	        break;
	        case 12:// Bank   
	            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?partner_type=50"; //bank
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {        
	                txtBank.SetDataText(aValue[2]);   
	                txtBankPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 13:
	            fpath = System.RootURL + "/form/ds/bs/dsbs00012.aspx?type=Export Contract";
                oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
                var isAlready;

                grdContractDetail.RemoveRowAt(grdContractDetail.rows-1)
                isAlready=0;
               
                if (oValue != null)
                {  
                    for ( var i=0; i<oValue.length;i++)
                    {                 
                        aValue=oValue[i];
	                    
	                    for(var k=0; k<grdContractDetail.rows;k++)
	                        if (grdContractDetail.GetGridData(k , G1_tco_item_pk)== aValue[0]) // da co
					        {
						        isAlready=1;
						        break;	
					        }		
					    if(isAlready==0) 
	                    {    
                            var aValue = oValue[i];  
                            grdContractDetail.AddRow();
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_rownum       ,grdContractDetail.rows-1);
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_code    ,aValue[1]); //Item code
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_item_name    ,aValue[2]); //_item name
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_unit_cd      ,aValue[5]); 
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tco_item_pk  ,aValue[0]); //tco_item_pk
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_hs_code      ,aValue[20]); //hs code
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_cnv_ratio    ,aValue[19]); //_cnv_ratio                            
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_unit_packing ,aValue[21]);
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_pack_rate    ,aValue[22]);
                            
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_qty_packing  ,Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_qty))*Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_pack_rate)));
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_ex_price     ,Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_qty))*Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_u_price)));
                            grdContractDetail.SetGridText(grdContractDetail.rows-1, G1_tr_amt       ,Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.rows-1, G1_retouch_amt)));                            
                        }
                    }
                }
                grdContractDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdContractDetail.SetGridText(grdContractDetail.rows-1,1,'')
	        break;
	        case 14:// Bên chỉ định nhận hàng  
	        
	            var desc;	            
                var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AR"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
                if ( aValue != null )
                {                  
                    desc=aValue[7] + ' \nTel  : ' + aValue[10] + ' \nFax  : ' + aValue[12]; 
                    if(aValue[11]!='')
                        desc = desc + ' \nEmail: ' + aValue[11];
                    txtPartyCName.SetDataText(aValue[2]); 
                    txtPartyC.SetDataText(aValue[1]);  
                    txtPartyCPK.SetDataText(aValue[0]);  
                    txtPartyCAdd.SetDataText(desc);
                }	           	
	        break;
	        case 15: // Project
                fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
                
                if ( oValue != null )
                {
                    txtProjectPK.text = oValue[2]; 
                    txtProject.text   = oValue[1];
                }
            break;
	    }
    }
    //--------------------------------------------------------------------------------------
    function onSave(index)
    {
        switch (index)
        {
            case 0:
                if(ValidateData(0))
                {
                    _status="save"
                    dat_epac00030_1.Call('');
                }
            break;
            case 3:
                if(ValidateData(3))
                {
                    for(i=1;i<grdOrder.rows;i++)
                        grdOrder.SetGridText(i,G2_contr_status, txtStatusNum.text);
                        
                    dat_epac00030_3.Call('');
                }
            break;
        }
    }   
    //---------------------------------------------------------------------------------------
    function onAddNew(index)
    {
        switch(index)
        {    
            case 0:
                action='create';
                txtMasterPK.SetDataText("");
                dat_epac00030_1.StatusInsert(); 
                cboCompany.value="<%=Session["COMPANY_PK"]%>";
                getNation();
                radShipType.value='a';
                onChangeShipType();
                onChangDate();
                txtStatus.text='';
                txtStatusNum.text="1";
                SetStatus(txtStatusNum.text);
                grdContractDetail.ClearData();
                str= "• Signed Commercial Invoice" + "\n" 
                    + "• Detailed Packing List" + "\n"
                    + "• Insurance Policy / Certificate" + "\n"
                    + "• Certificate of Origin" + "\n"
                    + "• Certificate of Analysis issued by the manufacturer for the lot concerned" + "\n"
                    + "• Manufacturing date and Expiry date should be mentioned on COA";
                txtShippingDoc.SetDataText(str);
                
                str="In case of any complaint of the quality and quantity, the Buyer will inform to the Seller about this event. Then, within 45 days of discharging, the Buyer will lodge a formal claim with proper documents, such claim will be settled by the Seller wihtin 45 days upon receipt of the Buyer's formal claim. After the above-mentioned specified date, all claims will become null and void."
                txtComplaint.SetDataText(str);
                
                str = "To be covered by the Seller for 110% of invoice value, showing number of policy/certificate issued and claim payable in VietNam.";
                txtInsurance.SetDataText(str);
                
                str="Strike, Which may happen in original country, shall be considered as force majeure. Force majeure circumstances must be notified by fax by each party to the other party within 10 working days and confirmed by writing form within 10 days after fax message with certificate of force majeure issued by the competence government authority for acceptance. Beyond this time, force majeure shall not be taken into consideration";
                txtForceMajeure.SetDataText(str);
                
                str = "In the course of executing this contract, all disputes not reaching with amicable agreement shall be settled by the Vietnamese International Arbitration Center (VIAC) besides Chamber of Commerce and Industry to solve according to the Internal Commercial law of which awards shall be fianl and biding for bothe Parties. The fee for the arbitration and other charges will be born by the loosing Party.";
                txtArbitration.SetDataText(str);
                
                str="• This contract is subjected to Incoterms 2000." + "\n"
                    + "• This contract is made in 02 copies in English, each party hold 01 copy." + "\n"
                    + "• This contract comes into effectiveness from the duly signing date to 31st December 2008." + "\n"
                    + "• Any change of this contract shall be made in written from and subjected both parties' agreement." + "\n";
                txtOtherClauses.SetDataText(str);
            break;
            case 1:
                grdOrders.AddRow();
                grdOrders.SetGridText(grdOrders.rows-1, G2_tex_contr_mst_pk , txtMasterPK.text)
                grdOrders.SetGridText(grdOrders.rows-1, G2_rownum           , grdOrders.rows-1) 
                grdOrders.SetGridText(grdOrders.rows-1, G2_order_date       , dtContractDate.value)
                grdOrders.SetGridText(grdOrders.rows-1, G2_status           , 1) // status : save              
            break;
            case 2:
                grdCondition.AddRow();
                grdCondition.SetGridText(grdCondition.rows-1, G3_tex_contr_mst_pk , txtMasterPK.text)
            break;
        }
    }
    //--------------------------------------------------------------------------------------
    function OnDataReceive(obj)
    {        
        switch (obj.id)
        {
            case 'dat_epac00030_1' :
                flag=0;
                
                onChangeOrderYN();
                txtStatus.text=txtStatusText.text;
                
                if(action=='view')
                    SetStatus("4");
                else
                    SetStatus(txtStatusNum.text);
                    
                if (_status=="select")
                    dat_epac00030_2.Call('SELECT');
                else
                {       
                    for (var i=1; i<grdContractDetail.rows;i++)
                    {
                        grdContractDetail.SetGridText(i, G1_contr_status, txtStatusNum.text);
                        
                        if (grdContractDetail.GetGridData(i,0)=='')
                            grdContractDetail.SetGridText(i, G1_tex_contr_mst_pk, txtMasterPK.text);                        
                    }
                    grdContractDetail.SetRowStatus(grdContractDetail.rows-1,'_');
                    dat_epac00030_2.Call('');
                }                         
            break;
            case 'dat_epac00030_2':    
                grdContractDetail.Subtotal(0,2,2,"11!13!14!15","",true,11,"Total");
                grdContractDetail.SetGridText(grdContractDetail.rows-1,1,'')
                for(i=1;i<grdContractDetail.rows-1;i++)
                    grdContractDetail.SetGridText(i,1, i);
                Total();
                grdContractDetail.GetGridControl().AutoSize(0,19,false,0);
                
                if (_status=="select")
                    dat_epac00030_14.Call('SELECT');
                else
                {       
                    for (var i=1; i<grdCondition.rows;i++)
                        if (grdCondition.GetGridData(i,0)=='')
                            grdCondition.SetGridText(i, G3_tex_contr_mst_pk, txtMasterPK.text);
                    dat_epac00030_14.Call('');
                }  
            break;
            case 'dat_epac00030_3' :
                grdOrderDetail.ClearData();
            break;
            case 'dat_epac00030_4': 
                 grdOrderDetail.Subtotal(0,2,2,"11!13!14!15","",true,11,"Total");
                 grdOrderDetail.SetGridText(grdOrderDetail.rows-1,1,'')
                 for(i=1;i<grdOrderDetail.rows-1;i++)
                    grdOrderDetail.SetGridText(i,1, i);
                 grdOrderDetail.GetGridControl().AutoSize(0,19,false,0);
            break;
            case 'dat_epac00030_5' :
                txtStatus.text="Saved";
                SetStatus(1);
                dat_epac00030_1.Call('SELECT');
            break;
            case 'dat_epac00030_6' :
                radStatus.value=1;
            break;
            case 'dat_epac00030_7':
                _status="select"
                grdOrders.ClearData();
                grdContractDetail.ClearData();
                dat_epac00030_1.Call('SELECT');
            break;
            case 'dat_epac00030_9':
                if(txtStatusNum.text=="2")
                    txtStatus.text="Confirmed";
                else
                    if(txtStatusNum.text=="3")
                        txtStatus.text="Cancelled";
                    else
                        if(txtStatusNum.text=="4")
                            txtStatus.text= 'Saved';
                        
                SetStatus(txtStatusNum.text);
            break;
            case 'dat_epac00030_11':
                lbCurr.text = "/" + txtCurr.text;
                lbCurrS.text = "/" +  txtCurr.text;
            break;
            case 'dat_epac00030_12':            
                grdContractDetail.SetGridText(grdContractDetail.row, G1_cnv_ratio, txtCnvRatio.text);
                onAfterEditting(G1_u_price);
                if(is_unit_change==1) 
                    onAfterEditting(6);
            break;
            case 'dat_epac00030_13':            
                grdContractDetail.SetGridText(grdContractDetail.row, G1_pack_rate, txtTran_rate.text);
                onAfterEditting(G1_qty);                
                is_unit_change =0;
            break;
        }
        grdOrders.SetCellFontColor(0,1,grdOrders.rows-1,1,0x666666);
    }
    //--------------------------------------------------------------------------------------
     function onAfterEditting(colidx)
     {

        if(colidx== G1_unit_cd)
        {
            is_unit_change=1; 
            rowchange=grdContractDetail.row;
            txtUnit.text= grdContractDetail.GetGridData(grdContractDetail.row, G1_unit_cd);
            dat_epac00030_12.Call();
        }
        
        if(colidx== G1_unit_packing)
        {
            if(is_unit_change ==0) 
                rowchange=grdContractDetail.row;
            txtItemPK.text = grdContractDetail.GetGridData(grdContractDetail.row, G1_tco_item_pk);
            txtUnit.text= grdContractDetail.GetGridData(grdContractDetail.row, G1_unit_cd);
            txtUnitTran.text= grdContractDetail.GetGridData(grdContractDetail.row, G1_unit_packing);
            dat_epac00030_13.Call();
        }
        
        if(colidx== G1_qty)
        {
            if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty)))
                if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_pack_rate)))
                {
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_qty_packing,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty))*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_pack_rate)));                   
                }
                else
                {
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_qty_packing,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty)));                   
                }
        }
           
        if ((colidx == G1_qty)||(colidx == G1_u_price)) //Price, Qty.
        {                
           if ((!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty))) && (!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_u_price))) )
           {
               if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty)))
               {   
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_ex_price,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_u_price))*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty))/Number(grdContractDetail.GetGridData(grdContractDetail.row,G1_cnv_ratio)));
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tot_amt,(1+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_vat_rate))/100)*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price)));
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_tot_amt))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
               }
               else
               {
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_ex_price,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_u_price))*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty)));
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tot_amt,(1+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_vat_rate))/100)*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price)));
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_tot_amt))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
               }
           }
        } 
        if(colidx==G1_vat_rate)
        {
            if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_vat_rate)))
            {
                grdContractDetail.SetGridText(grdContractDetail.row, G1_tot_amt,(1+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_vat_rate))/100)*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price)));
                grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_tot_amt))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
            }
        }
        if (colidx== G1_retouch_amt) //	Retouch Amt 
        {                
           if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)))
           {           
               grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_tot_amt))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdContractDetail.SetGridText(grdContractDetail.row, G1_retouch_amt,'')
              grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_tot_amt))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
           }           
        } 
        grdContractDetail.Subtotal(0,2,2,"11!13!14!15","",true,11,"Total");
        Total();
        grdContractDetail.GetGridControl().AutoSize(0,19,false,0);
     }
    //--------------------------------------------------------------------------------------
    function onAfterConditionEditting(col)
    {
        if(col==G3_pay_percent)
            if(!isNaN(grdCondition.GetGridData(grdCondition.row,G3_pay_percent )))
                grdCondition.SetGridText(grdCondition.row, G3_pay_amt,Number(grdCondition.GetGridData(grdCondition.row,G3_pay_percent)*Number(txtTrAmount.text)/100 ));
            else
            {
                alert("The pay percent must be a number!");
                return;
            }          
    }
    //--------------------------------------------------------------------------------------
    function OnGridCellClick()
    {
        txtOrderPK.text=grdOrders.GetGridData(grdOrders.row, G2_tex_order_pk);
        dat_epac00030_4.Call('SELECT');
    }
    //--------------------------------------------------------------------------------------
    function Total()
    {
        var  amt=0, vat_amt=0, tot_amt=0, re_amt=0, trans_amt=0;
       
        for (var i=1; i< grdContractDetail.rows-1; i++)
        {
            amt = Number(amt) + Number(grdContractDetail.GetGridData(i, G1_ex_price));
            vat_amt = Number(vat_amt) + Number(grdContractDetail.GetGridData(i, G1_ex_price))*Number(grdContractDetail.GetGridData(i, G1_vat_rate))/100;
            tot_amt = Number(tot_amt) + Number(grdContractDetail.GetGridData(i, G1_tot_amt));
            re_amt = Number(re_amt) + Number(grdContractDetail.GetGridData(i, G1_retouch_amt));
            trans_amt = Number(trans_amt) + Number(grdContractDetail.GetGridData(i, G1_tr_amt));
            
        }  
        txtAmount.SetDataText('' + amt); 
        txtVATAmount.SetDataText('' + vat_amt); 
        txtTotalAmount.SetDataText('' + tot_amt);  
        txtReAmt.SetDataText('' + re_amt);  
        txtTrAmount.SetDataText('' + trans_amt);
    }
    //---------------------------------------------------------------------------------------
    function onDelete(index)
    {
        switch (index)
        {
            case 0:
                if(confirm('Do you want to delete this contract ?'))
	            {
	                _status="delete"
	                dat_epac00030_1.StatusDelete();
	                dat_epac00030_1.Call('');
	            }    
            break;
            case 1:
                if(confirm('Do you want to delete this Item?'))
                {
                    grdContractDetail.DeleteRow();
                }
            break;
            case 3:
                if(confirm('Do you want to delete this Order?'))
                {
                    grdOrders.DeleteRow();
                }
            break;
        }
    }
    //--------------------------------------------------------------
    function onChangeShipType()
    {   
        if (radShipType.value=='a')
            dat_epac00030_8.Call();
    }
    //---------------------------------------------------------------
    function getCurrBooking()
    {    
	    var url =  System.RootURL + "/form/ep/ac/AjaxFile.aspx?type=1" ;
	    ajax_test3 = null;
	  
	    ajax_test3 = GetXmlHttpRequest(returnCurrBooking);
	    ajax_test3.open("GET", url , true);
	    ajax_test3.send(null); 
    }
    //---------------------------------------------------------------
    function returnCurrBooking()
    {    
        if(GetRequestState(ajax_test3))
	    {		   
	        strdata = ajax_test3.responseText;	 		         
	        lbCurr.SetDataText('/'+strdata);
	        lbPayCurr.SetDataText('/'+strdata);
	    }
    }
    //----------------------------------------------------------------
    function AddCommonCode(index)
    {     
        var scode;
        switch(index)
        {           
            case 1:
                scode='IEAB0010'; //cboTradeTerm
            break;
            case 2:
                scode='ACCR0020'; //cboPaymentTerm
            break;
            case 3:
                scode='ACAB0110'; // cboCurrency
            break;  
            case 4:
                scode='ACAB0110'; // cboPaymentCurrency
            break;  
            case 5:
                scode='ACCR0140'; // cboPaymentMethod
            break;
            case 6:
                scode='IEAB0020'; // cboTransport
            break;
            case 7:
                scode='IEBD0050'; // cboTolerance
            break;  
            case 8:
                scode='IEBD0050'; // cboDiscount
            break;                 
        }
        var fpath = System.RootURL + "/form/ep/bp/epbp00020_com_code.aspx?code=" + scode ;
       
        var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
        if (obj!=null)
        {
            strcodereturn=obj[1];
            indexCode=index;
            
            if (obj[0]==1 ) //modify common code
                OnLoadNew(scode);
            else
            {               
                switch(index)
                {                        
                    case 1:
                        cboTradeTerm.value=strcodereturn; //cboTradeTerm
                    break;
                    case 2:
                        cboPaymentTerm.value=strcodereturn; //cboPaymentTerm
                    break;
                    case 3:
                        cboCurrency.value=strcodereturn; // cboCurrency
                    break;  
                    case 4:
                        cboPayCurrency.value=strcodereturn; // cboPayCurrency
                    break;  
                    case 5:
                        cboPaymentMethod.value=strcodereturn; // cboPaymentMethod
                    break;
                    case 6:
                        cboTransport.value=strcodereturn; // cboTransport
                    break;
                    case 7:
                        cboTolerance.value=strcodereturn; // cboTolerance
                    break;  
                    case 8:
                        cboDiscount.value=strcodereturn; // cboDiscount
                    break;               
                }            
            }
        }	     
    }
    //-----------------------------------------------------------------------------------    
    function OnLoadNew(scode)
    {	
	    var t=new Date()
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_searchidcode.aspx?id=" + scode + "&date=" + t;
	    ajax_test4 = null;
	    ajax_test4 = GetXmlHttpRequest(return_result);
	    ajax_test4.open("GET", url , true);
	    ajax_test4.send(null);
    }
    //---------------------------------------------------------------------------
    function return_result()
    {	        
	    if(GetRequestState(ajax_test4))
	    {
	        strdata = ajax_test4.responseText;	
            switch(indexCode)
            {    
                case 1:
                    cboTradeTerm.SetDataText(strdata);
                    cboTradeTerm.value=strcodereturn; //cboTradeTerm                    
                break;
                case 2:
                    cboPaymentTerm.SetDataText(strdata);
                    cboPaymentTerm.value=strcodereturn; //cboPaymentTerm
                break;
                case 3:
                    cboCurrency.SetDataText(strdata);
                    cboCurrency.value=strcodereturn; // cboCurrency
                break;  
                case 4:
                    cboPayCurrency.SetDataText(strdata);
                    cboPayCurrency.value=strcodereturn; // cboPayCurrency
                break;  
                case 5:
                    cboPaymentMethod.SetDataText(strdata);
                    cboPaymentMethod.value=strcodereturn; // cboPaymentMethod
                break;
                case 6:
                    cboTransport.SetDataText(strdata);
                    cboTransport.value=strcodereturn; // cboTransport
                break;
                case 7:
                    cboTolerance.SetDataText(strdata);
                    cboTolerance.value=strcodereturn; // cboTolerance
                break;  
                case 8:
                    cboDiscount.SetDataText(strdata);
                    cboDiscount.value=strcodereturn; // cboDiscount
                break;                            
            }
	    }
    }
    //--------------------------------------------------------------
    function getExRate()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtContractDate.value +"&curr=" + cboCurrency.value;
	    ajax_test = null;
	   
	    ajax_test = GetXmlHttpRequest(returnExRate);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null); 
    }
    //---------------------------------------------------------------
    function returnExRate()
    {
        if(GetRequestState(ajax_test))
	    {	
	        strdata = ajax_test.responseText;	 	  
	        txtExRate.SetDataText(''+strdata);
	    }
    }
    //---------------------------------------------------------------
    function getPayExRate()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtContractDate.value +"&curr=" + cboPayCurrency.value;
	    ajax_test1 = null;
	   
	    ajax_test1 = GetXmlHttpRequest(returnPayExRate);
	    ajax_test1.open("GET", url , true);
	    ajax_test1.send(null); 
    }
    //---------------------------------------------------------------
    function returnPayExRate()
    {
        if(GetRequestState(ajax_test1))
	    {	
	        strdata = ajax_test1.responseText;	 	  
	        txtPayExRate.SetDataText(''+strdata);
	    }
    }
    //--------------------------------------------------------------
    function getNation()
    {    
	    var url =  System.RootURL + "/form/ep/ac/AjaxFile.aspx?com_pk=" + cboCompany.value;
	    ajax_test2 = null;
	   
	    ajax_test2 = GetXmlHttpRequest(returnNation);
	    ajax_test2.open("GET", url , true);
	    ajax_test2.send(null); 
    }
     //-------------------------------------------------------------
    function returnNation()
    {
        if(GetRequestState(ajax_test2))
	    {		    
	        strdata = ajax_test2.responseText;	 	  
	        txtOriginPK.text = strdata.substr(0,strdata.indexOf("&")); 
	        txtOrigin.text = strdata.substr(strdata.indexOf("&")+1,strdata.length); 	        
	    }
    }
    //---------------------------------------------------------------    
    function onChangDate()
    {
        var ldate; 
        var lyear;
        ldate=dtContractDate.value;    
        lyear= Number(ldate.substr(0,4)) +1;
        ldate = lyear + ldate.substr(4,2) + ldate.substr(6,2)   ;       
        dtExpDate.value=ldate ; 
        getExRate();
        getPayExRate();
    }
    //-----------------------------------------------------------------------  
    function onDiscountChange()
    {
        var tmp;
        tmp = (Number(cboDiscount.value)/100)*Number(txtTrAmount.text);
        txtDiscAmount.SetDataText("'"+tmp);
    }
    //--------------------------------------------------------------------------
    function ValidateData(index)
    {
        switch(index)
        {
            case 0:
                if(dtContractDate.value > dtShipDate.value)
                {
                    alert("Shipment date must be greater than Contract date!");
                    return false;
                } 
                if(dtShipDate.value > dtExpDate.value)
                {
                    alert("Expire date must be greater than Shipment date!");
                    return false;
                }   
                
                if(txtCusPK.text=='' )
                {
                    alert("You must input Vendor!");
                    return false;
                }
                if(txtContractNo.text=='')
                {
                    alert("You must input Contract No!");
                    txtContractNo.GetControl().focus();
                    return false;
                }
                if (chkOrderYN.value=='Y')
                    if (txtTrAmount.text=='')
                    {
                        alert("You must input transaction Amount!");
                        return false;
                    }
            break;
            case 3:
                for (var i=1; i<grdOrders.rows;i++)
                {//                   
                    if((grdOrders.GetGridData(i,G2_order_date)>grdOrders.GetGridData(i,G2_ship_date))&& (grdOrders.GetRowStatus(i)!=64))
                    {
                        alert("Shipment date must be > Order date at row " + i);
                        return false;
                    }
                    if((grdOrders.GetGridData(i,G2_ship_date)>grdOrders.GetGridData(i,G2_exp_date))&& (grdOrders.GetRowStatus(i)!=64))
                    {
                        alert("Expire date must be > Shipment date at row " + i);
                        return false;
                    }
                }
            break;     
        } 
        return true;
    }
    //-----------------------------------------------------------------------
    function ValidateDataConfirm(index)
    {
        switch(index)
        {
            case 0:
                if(txtShipPK.text=='')
                 {
                    alert("You must input Ship to!");
                    return false;
                 }
                 
                 if(txtPaidPK.text=='')
                 {
                    alert("You must input Paid to!");
                    return false;
                 }
                 if(txtPLCofLoading.text=='')
                 {
                    alert("You must input place of loading!");
                    return false;
                 }
                 if(txtPlaceDischargeCD.text=='')
                 {
                    alert("You must input place of discharge!");
                    return false;
                 } 
                 if (cboTransport.value=='')
                 {
                    alert("You must input Transport by!");
                    return false;
                 }
                 if(cboPaymentTerm.value=='')
                 {
                    alert("You must input Payment term!");
                    return false;
                 }
                 return true;
            break;
        }         
    }
    //-----------------------------------------------------------------------
    function OnCheckTab()
    {
        var index;
        index=idTab.GetCurrentPageNo();           
        if (index==2)
            if (flag==0)
            {
                dat_epac00030_3.Call("SELECT");   
                flag=1; 
            }  
    }
    //------------------------------------------------------------------------    
     function onChangeOrderYN()
     {
     
        var idTable = document.all("OrderInformation"); 
        var idGridDtl = document.all("idGridDetail"); 
        if (chkOrderYN.value=='N')
        {
            if (grdOrders.rows<=1)
            {
                idTable.style.display="none";
                idGridDtl.style.display=""; 
                txtTrAmount.SetEnable(false);
            }
            else
            {
                alert("You must delete all orders first!")    
                chkOrderYN.value="Y";
            }                
        }          
        else
        {
            if(grdContractDetail.rows <=1)
            {
                idTable.style.display="";
                idGridDtl.style.display="none";
                idTable.style.width="100%";
                txtTrAmount.SetEnable(true);
            }
            else
            {
                alert("You must delete all items below!")    
                chkOrderYN.value="N";
            }
        }
     }
     //---------------------------------------------------------------------------------------
    function onConfirm(index)
    {
        switch (index)
        {
            case 0:
                if(ValidateDataConfirm(0))
                {
                    txtStatusNum.text='2';
                    _status="save"
	                dat_epac00030_9.Call(); 
                }                                   
            break;
        }        
    }
    //---------------------------------------------------------------------------------------
    function onDelConfirm()
    {
        txtStatusNum.text='4';
        _status="save"
        dat_epac00030_9.Call(); 
    }
    //---------------------------------------------------------------------------------------
    function onRegenerate(index)
    {
        switch(index)
        {
            case 0:
                _status="save";
                action='Regenerate';          
                dat_epac00030_5.Call();
            break;
        }        
    }
    //--------------------------------------------------------------
    function onCopy(index)
    {
        switch (index)
        {
            case 0:               
                action='Copy';
                _status="save";
                dat_epac00030_5.StatusUpdate();
                dat_epac00030_5.Call('');
            break;
        }
    }
    //---------------------------------------------------------------------------------------
    function onCancel()
    {
        txtStatusNum.text='3';
        _status="save";
	    dat_epac00030_9.Call();
    }
</script>
<body>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68" function="imex.sp_sel_1epac00030_1"  procedure="IMEX.sp_upd_1epac00030_1"> 
            <inout> 
                 <inout  bind="txtMasterPK" />
                 <inout  bind="txtContractNo" /> 
                 <inout  bind="dtContractDate" />
                 <inout  bind="dtExpDate" />
                 <inout  bind="txtCusPK" />
                 <inout  bind="txtShipPK" />            
                 <inout  bind="txtPaidPK" />
                 <inout  bind="cboCurrency" />
                 <inout  bind="txtExRate" />
                 <inout  bind="txtTrAmount" />
                 <inout  bind="cboTolerance" />
                 <inout  bind="txtOriginPK" />
                 <inout  bind="dtShipDate" />
                 <inout  bind="txtPlaceDischargeCD" />
                 <inout  bind="txtPLCofLoadingCD" />  
                 <inout  bind="cboTradeTerm" />               
                 <inout  bind="cboPaymentMethod" /> 	
                 <inout  bind="cboPayCurrency" /> 
                 <inout  bind="cboPaymentTerm" />
                 <inout  bind="chkOrderYN" />            
                 <inout  bind="chkCloseYN" />
                 <inout  bind="dtCloseDate" />
                 <inout  bind="txtShipAdd" /> 
                 <inout  bind="txtPaidAdd" />                
                 <inout  bind="txtStatusNum" /> 
                 <inout  bind="radShipType" />
                 <inout  bind="radPayType" />
                 <inout  bind="cboDiscount" />
                 <inout  bind="cboTransport" />
                 <inout  bind="txtPayExRate" />
                 <inout  bind="txtLocation" />  
                 <inout  bind="txtDesc" />
                 <inout  bind="txtAccountBank" />
                 <inout  bind="txtStatusText" />
                 <inout  bind="txtCusCode" />   
                 <inout  bind="txtCusName" />
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipName" /> 
                 <inout  bind="txtPaidCode" />
                 <inout  bind="txtPaidName" /> 
                 <inout  bind="txtOrigin" />
                 <inout  bind="cboCompany" />
                 <inout  bind="txtPLCofLoading" />
                 <inout  bind="txtPlaceDischarge" />
                 <inout  bind="txtQuality" />    
                 <inout  bind="txtPacking" />
                 <inout  bind="txtShipRemark" />
                 <inout  bind="txtTransshipment" />    
                 <inout  bind="txtPartialShip" />
                 <inout  bind="txtBankPK" />
                 <inout  bind="txtShippingDoc" />
                 <inout  bind="txtInsurance" />    
                 <inout  bind="txtComplaint" />
                 <inout  bind="txtForceMajeure" />
                 <inout  bind="txtArbitration" /> 
                 <inout  bind="txtOtherClauses" />
                 <inout  bind="txtPerPaid" /> 
                 <inout  bind="txtBank" />
                 <inout  bind="txtDiscAmount" />
                 <inout  bind="txtPartyCPK" />
                 <inout  bind="txtPartyC" /> 
                 <inout  bind="txtPartyCName" />
                 <inout  bind="txtPartyCAdd" />  
                 <inout  bind="txtVATAmount" />     
                 <inout  bind="txtTotalAmount" />       
                 <inout  bind="txtAmount" /> 
                 <inout  bind="txtReAmt" />
                 <inout  bind="txtProjectPK" /> 
                 <inout  bind="txtProject" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="imex.sp_sel_1epac00030_2"   procedure="imex.sp_upd_1epac00030_2"> 
            <input bind="grdContractDetail">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdContractDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="imex.sp_sel_1epac00030_3"   procedure="imex.sp_upd_1epac00030_3"> 
            <input bind="grdOrders">                    
                <input bind="txtMasterPK" /> 
                <input bind="txtOrderNo" /> 
            </input> 
            <output bind="grdOrders" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_4"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" function="imex.sp_sel_1epac00030_4"   > 
            <input bind="grdOrderDetail">                    
                <input bind="txtOrderPK" /> 
            </input> 
            <output bind="grdOrderDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Copy/Regenarate------------------------------------>
<gw:data id="dat_epac00030_5" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_epac00030_5" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="txtStatusNum" /> 
            </input> 
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------Get Contract PK -------------------------------------->
<gw:data id="dat_epac00030_7"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,43" function="imex.sp_sel_epac00030_7"  > 
            <inout> 
                 <inout  bind="txtContractNo" />
                 <inout  bind="txtMasterPK" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------Get Company Info -------------------------------------->
<gw:data id="dat_epac00030_8"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process"  procedure="imex.sp_pro_get_CompanyInfo"  >             
            <input>
                <input bind="cboCompany" />
            </input> 
            <output>
                <output  bind="txtShipName" />
                <output  bind="txtShipCode" />
                <output  bind="txtShipPK" />
                <output  bind="txtShipAdd" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Confirm/Cancel------------------------------------>
<gw:data id="dat_epac00030_9" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_upd_epac00030_9" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="txtStatusNum" /> 
            </input> 
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------------------------------------------------------->
<gw:data id="dat_epac00030_14"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6" function="imex.sp_sel_1epac00030_14"   procedure="imex.sp_upd_1epac00030_14"> 
            <input bind="grdCondition">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdCondition" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
<form id="form1" runat="server">
    <table border=1  style="width: 100%; height: 100%">
        <tr  style="height: 1%">
            <td style="width: 100%">
                <table border=0  style="width: 100%; height: 1%">
                    <tr style="height: 1%">
                        <td style="width: 8%">Status</td>
                        <td style="width: 10%"><gw:label id="txtStatus"  text="Save"  styles='width:100%;color:red; font-weight:700;;' /></td>
                        <td style="width: 71%"></td>
                        <td style="width: 1%"><gw:imgbtn id="btnSearch" img="popup" alt="Open form to search" text="Search" onclick="openPopup(3)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onAddNew(0)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnExcel" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm(0)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnDelConfirm" img="unchange" alt="Undo Confirm" text="Undo Confirm" onclick="onDelConfirm()" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onCancel(1)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate(0)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy(0)" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%" valign="top">
            <td style="width: 100%" valign="top"> 
                <gw:tab id="idTab" onpageactivate="return OnCheckTab()"  style="width: 100%; height: 100%; border6px">
                    <table border=0 id="ContractInfo."  name="Contract Info"  style="width: 100%; height: 100%" >
                        <tr style="height: 1%">
                            <td style="width: 100%">
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="2" >
                                    <tr >
                                        <td>Company</td>
                                        <td style="width: 1%"></td>
                                        <td ><gw:list id="cboCompany" styles="width:100%;" onchange="getNation();"></gw:list></td>
                                        <td></td>
                                        <td nowrap>Order Y/N</td>
                                        <td></td>
                                        <td>
                                            <gw:checkbox id="chkOrderYN" onchange="onChangeOrderYN()" defaultvalue="Y|N" value="N"/>
                                        </td>
                                        <td></td>
                                        <td nowrap><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Vendor Name</b></a></td>
                                        <td></td>
                                        <td colspan="7">
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr style="height: 1%">
                                                    <td style="width: 30%;"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtCusPK"  text=""  styles='display:none'  /></td>
                                                    <td style="width: 70%;"><gw:textbox id="txtCusName"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr >
                                        <td style="width: 8%" nowrap>Contract No</td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 26%"><gw:textbox id="txtContractNo"  text=""  styles='width:100%;' csstype="mandatory" onenterkey="dat_epac00030_7.Call('SELECT');" /></td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 8%" nowrap>Contract Date</td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 8%"><gw:datebox id="dtContractDate" lang="1"  styles='width:100%;' onchange="onChangDate();"/></td>
                                        <td style="width: 1%"></td>
                                        <td nowrap>Close Y/N</td>
                                        <td></td>
                                        <td><gw:checkbox id="chkCloseYN"  defaultvalue="Y|N" value="N" /></td>
                                        <td></td>
                                        <td nowrap><a title="Click here to select Trans. Currency" onclick="AddCommonCode(3)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Trans. Currency</b></a></td>
                                        <td></td>
                                        <td>
                                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                <tr style="height: 1%">
                                                    <td style="width: 100%" ><gw:list id="cboCurrency" styles="width:100%;" onchange="getExRate();"></gw:list></td>
                                                    <td  ><gw:label id="lbCurr"  text=""  styles='width:100%;'/></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><a title="Click here to select Origin" onclick="openPopup(8)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Item Origin</b></a></td>
                                        <td></td>
                                        <td><gw:textbox id="txtOrigin"  value=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtOriginPK"  value=""  styles='display:none;' /></td>
                                        <td></td>
                                        <td nowrap>Expiry Date</td>
                                        <td></td>
                                        <td><gw:datebox id="dtExpDate" lang="1" onchange=""/></td>
                                        <td></td>
                                        <td style="width: 6%" nowrap>Close Date</td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 15%"><gw:datebox id="dtCloseDate" lang="1" nullaccept  onchange=""/></td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 6%" nowrap>Ex Rate</td>
                                        <td style="width: 1%"></td>
                                        <td style="width: 15%"><gw:textbox id="txtExRate"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/></td>
                                    </tr>
                                    <tr>
                                        <td><a title="Click here to select Project" onclick="openPopup(15)" href="#tips" style="text-decoration : none; color:#0000FF"><b>PL unit</b></a></td>
                                        <td></td>
                                        <td colspan="5"><gw:textbox id="txtProject"  text=""  styles='width:100%;'/><gw:textbox id="txtProjectPK"  text=""  styles='width:100%;display:none'/></td>
                                        <td></td>  
                                        <td><a title="Click here to select Tolerance" onclick="AddCommonCode(7)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Tolerance</b></a></td>
                                        <td></td>
                                        <td><gw:list id="cboTolerance"  value=""  styles='width:100%;'/></td>
                                        <td></td>
                                        <td nowrap>Amount</td>
                                        <td></td>
                                        <td><gw:textbox id="txtAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" valign="top" ><a title="Click here to select Nominated Party for goods delivered" onclick="openPopup(14)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Nominated Party for goods delivered</b></a></td>
                                        <td></td>
                                        <td colspan="5">
                                            <table cellpadding=0 cellspacing=0  style="width: 100%; height: 100%">
                                                <tr >
                                                    <td style="width: 30%;">
                                                        <gw:textbox id="txtPartyC"  text=""  styles='width:100%;'  /><gw:textbox id="txtPartyCPK"  text=""  styles='display:none;'  />
                                                    </td>
                                                    <td style="width: 70%;"><gw:textbox id="txtPartyCName"  text=""  styles='width:100%;'  /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td>VAT Amount</td> 
                                        <td></td>
                                        <td><gw:textbox id="txtVATAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        <td></td>
                                        <td nowrap>Total. Amount</td>
                                        <td></td>
                                        <td><gw:textbox id="txtTotalAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                    </tr>
                                    <tr>  
                                        <td rowspan="2" ></td>
                                        <td rowspan="2" colspan="5"><gw:textarea id="txtPartyCAdd" rows=4 text=""  styles='width:100%;'  /></td>
                                        <td rowspan="2"></td>
                                        <td >Retouch Amt</td> 
                                        <td ></td>
                                        <td ><gw:textbox id="txtReAmt" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        <td ></td>
                                        <td nowrap>Trans. Amount</td>
                                        <td ></td>
                                        <td ><gw:textbox id="txtTrAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>                                   
                                    </tr>
                                    <tr>                                                  
                                        <td >Remark</td>
                                        <td></td>
                                        <td colspan="5"><gw:textarea id="txtDesc" rows=3 text=""  styles='width:100%;'/></td>                                               
                                    </tr>
                                </table>      
                            </td>
                        </tr>                        
                        <tr style="height: 99%">
                            <td  style="width: 100%">
                                <table  style="width: 100%; height: 100%" cellpadding=0 cellspacing =0 id="idGridDetail">
                                    <tr style="height: 1%">
                                        <td style="width: 100%">
                                            <table border=0 cellpadding=0 cellspacing=0  style="width: 100%; height: 100%">
                                                <tr> 
                                                    <td style="width: 92%" ></td>
                                                    <td width="2%"><gw:imgbtn id="btnCrtItemFree" img="new" alt="Create new Item" text="Create new Item" onclick="openPopup(13)" /></td>
                                                    <td width="2%"><gw:imgbtn id="btnGetItemFree" img="popup" alt="Get Free Item" text="Get Free Item" onclick="openPopup(4)" /></td>
                                                    <td width="2%"><gw:imgbtn id="btnGetItemFromSO"  img="popup" alt="Get Item from SO" text="Get Item from SO" onclick="openPopup(7)"  /></td>
                                                    <td width="2%"><gw:imgbtn id="btnDelItem" img="delete" alt="New" text="New" onclick="onDelete(1)" /></td>        
                                                    <td width="2%"><gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" text="Refresh" onclick="dat_epac00030_2.Call('SELECT');" /></td>        
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>                                
                                    <tr style="height: 99%">
                                        <td >
                                            <gw:grid id='grdContractDetail'
                                                    header='_PK|No|Item Code|Item Name|HS Code|Unit|Packing Unit|Apportion|Qty.|Packing Qty.|Price|Ext. Price|VAT rate|Total Amt|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_so_pk|_cnv_ratio|_tran_rate|_contr_status'
                                                    format='0|0|0|0|0|2|2|3|0|0|0|0|2|0|0|0|0|0|0|0|0|0|0'
                                                    aligns='0|1|0|0|1|1|1|0|3|3|3|3|3|3|3|3|3|0|0|0|0|0|0'
                                                    defaults='||||||||||||||||||||||'
                                                    editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|1|0|0|0|0|0|0|0|0'
                                                    widths='0|555|1500|2700|1140|1000|1500|1000|1110|1200|1035|1290|1200|1500|1595|1500|0|0|0|0|0|0|0'
                                                    sorting='T'
                                                    onafteredit="onAfterEditting(this.col)"
                                                    styles='width:100%; height:100%'
                                                    oncelldblclick="OnEditItem()"
                                                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21"
                                                />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table id="Table1" name="Ship/Pay Info" cellpadding=0 cellspacing=0 style="width: 100%; height: 100%">                                                        
                        <tr style="height: 1%">
                            <td style="width: 48%" valign="top">
                                <fieldset style="padding: 5">
                                <legend >Shipment Information</legend>
                                    <table cellpadding="0" cellspacing="3" style="width: 100%; height: 100%">
                                        <tr style="height: 1%">
                                            <td style="width: 20%;" ></td>
                                            <td style="width: 2%;" ></td>
                                            <td style="width: 78%;" >
                                                <gw:radio id="radShipType" value="a" styles="width:100%" onchange="onChangeShipType()"> 
                                                    <span value="a">Us/Customer </span> 
                                                    <span value="b">Consignee</span> 
                                                </gw:radio></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td ><a title="Click here to select" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Ship To</b></a></td>
                                            <td ></td>
                                            <td>
                                                <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                                                    <tr>
                                                        <td style="width: 30%;"><gw:textbox id="txtShipCode"   styles="width:100%;" csstype="mandatory"  /><gw:textbox id="txtShipPK"   styles="display:none" /></td>
                                                        <td style="width: 70%;"><gw:textbox id="txtShipName" styles="width:100%;" /></td>
                                                    </tr>
                                                </table>
                                            </td>                                            
                                        </tr>
                                        <tr style="height: 1%">
                                            <td></td>
                                            <td></td>
                                            <td><gw:textarea id="txtShipAdd" rows="3" styles="width:100% ;" csstype="mandatory"  /></td>
                                        </tr>
                                        <tr>
                                            <td nowrap><a title="Click here to select Transportation By" onclick="AddCommonCode(6)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Transportation By</b></a></td>
                                            <td></td>
                                            <td ><gw:list id="cboTransport"  csstype="mandatory"  styles="width:100%;" /></td>
                                        </tr>
                                        <tr>
                                            <td>Shipment Date</td>
                                            <td></td>
                                            <td > 
                                                <table width="100%"  cellpadding=0 cellspacing=0 style="width: 100%; height: 100%">
                                                    <tr>
                                                        <td style="width: 10%;"><gw:datebox id="dtShipDate" lang="1" onchange="" csstype="mandatory"  styles="width:100%;" /></td>
                                                        <td style="width: 10%;"> </td>
                                                        <td style="width: 20%;" nowrap >Ship remark</td>
                                                        <td style="width: 5%;"> </td>
                                                        <td style="width: 55%;"><gw:textbox id="txtShipRemark" styles="width:100%;" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><a title="Click here to select Location" onclick="openPopup(11)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Location</b></a></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtLocation" styles="width:100%;" /></td>
                                        </tr>   
                                        <tr>
                                            <td nowrap><a title="Click here to select Place of Loading" onclick="openPopup(9)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Place of Loading</b></a></td>
                                            <td></td>
                                            <td nowrap >
                                                <table style="width:100%;" cellpadding=0 cellspacing=0 >
                                                    <tr>
                                                        <td style="width:96%;">
                                                            <gw:textbox id="txtPLCofLoading" styles="width:100%;" /><gw:textbox id="txtPLCofLoadingCD"  styles="display:none;" />
                                                        </td>
                                                        <td style="width:4%;"><gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPLCofLoading.text='';txtPLCofLoadingCD.text='';" /></td>
                                                    </tr>
                                                </table>
                                            
                                        </tr>   
                                        <tr>
                                            <td nowrap><a title="Click here to select Place of Discharge" onclick="openPopup(10)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Place of Discharge</b></a></td>
                                            <td></td>
                                            <td   nowrap >
                                                <table style="width:100%;" cellpadding=0 cellspacing=0>
                                                    <tr>
                                                        <td style="width:96%;">
                                                            <gw:textbox id="txtPlaceDischarge" csstype="mandatory"   styles="width:100%;" /><gw:textbox id="txtPlaceDischargeCD"  styles="display:none;" />
                                                        </td>
                                                        <td style="width:4%;"><gw:imgbtn id="reset2" img="Reset" alt="Reset" onclick="txtPlaceDischarge.text='';txtPlaceDischargeCD.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td><a title="Click here to select Trade Terms" onClick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Trade Terms</b></a> </td>
                                            <td></td>
                                            <td ><gw:list id="cboTradeTerm" styles="width:100%;"></gw:list></td>
                                        </tr>
                                    </table>
                                </fieldset>                                
                            </td>
                            <td style="width: 2%"></td>
                            <td style="width: 50%" valign="top">
                                <fieldset style="padding: 5; height: 100%">
                                    <legend >Payment Information</legend>
                                    <table cellpadding="0" cellspacing="1" style="width: 100%; height: 100%">
                                        <tr style="height: 1%">
                                            <td></td>
                                            <td></td>
                                            <td colspan="6">
                                                <gw:radio id="radPayType" value="a" styles="width:100%" onchange=""> 
                                                    <span value="a">Vendor </span> 
                                                    <span value="b">Other</span> 
                                                </gw:radio>
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width:10%" ><a title="Click here to select" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Paid To</b></a></td>
                                            <td style="width:1%" ></td>
                                            <td style="width:20%" ><gw:textbox id="txtPaidCode"   styles="width:100%;" csstype="mandatory"  /><gw:textbox id="txtPaidPK"   styles="display:none" /></td>
                                            <td colspan="5"><gw:textbox id="txtPaidName" csstype="mandatory"   styles="width:100%;" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td></td>
                                            <td></td>
                                            <td colspan="6"><gw:textarea id="txtPaidAdd" styles="width:100%;" rows="3" csstype="mandatory" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width:20%"><a title="Click here to select Payment Method" onclick="AddCommonCode(5)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Payment Method</b></a></td>
                                            <td style="width:1%"></td>
                                            <td style="width:25%"><gw:list id="cboPaymentMethod" styles="width:100%;" csstype="mandatory" ></gw:list></td>
                                            <td style="width:3%"></td>
                                            <td style="width:1%"></td>
                                            <td style="width:20%"><a title="Click here to select Discount on Payment" onclick="AddCommonCode(8)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Disc. on Payment</b></a></td>
                                            <td style="width:1%"></td>
                                            <td style="width:35%"><gw:list id="cboDiscount" onchange="onDiscountChange();" styles="width:100%;" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td nowrap>% Paid before shipment</td>
                                            <td></td>
                                            <td><gw:textbox id="txtPerPaid" styles="width:100%;" /></td>
                                            <td></td>
                                            <td></td>
                                            <td nowrap>Disc. Amount</td>
                                            <td></td>
                                            <td><gw:textbox id="txtDiscAmount"   type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td><a title="Click here to select Payment Currency" onclick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Payment Currency</b></a></td>
                                            <td></td>
                                            <td><gw:list id="cboPayCurrency" styles="width:100%;" onchange="getPayExRate()"></gw:list></td>
                                            <td><gw:label id="lbPayCurr"   styles="width:100%;" /></td>
                                            <td></td>
                                            <td>Ex. Rate</td>
                                            <td></td>
                                            <td><gw:textbox id="txtPayExRate"   type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td><a title="Click here to select Payment Term" onclick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Payment Term</b></a></td>
                                            <td></td>
                                            <td colspan="6"><gw:list id="cboPaymentTerm" styles="width:100%;" csstype="mandatory" ></gw:list></td>                                            
                                        </tr>
                                        <tr style="height: 1%">
                                            <td><a title="Click here to select Bank" onclick="openPopup(12)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Bank</b></a></td>
                                            <td></td>
                                            <td colspan="6"><gw:textbox id="txtBank"   styles="width:100%;" /><gw:textbox id="txtBankPK"   styles="display:none;" /></td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td>Bank Account</td>
                                            <td></td>
                                            <td colspan="6"><gw:textbox id="txtAccountBank"   styles="width:100%;" /></td>
                                        </tr>
                                        <tr style="height: 91%" valign="top">
                                            <td colspan="8">
                                                <fieldset style="padding: 5; height: 100%">
                                                <legend >Payment Conditon</legend>
                                                    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                                                        <tr style="height: 100%">
                                                            <td style="width: 97%;">
                                                                <gw:grid id='grdCondition'
                                                                    header='_Pk|Condition|Pay Percent|Pay Date|Pay Amt|Description|_tex_contr_mst_pk'
                                                                    format='0|2|0|4|0|0|0'
                                                                    aligns='0|0|3|0|3|0|0'
                                                                    defaults='||||||'
                                                                    editcol='0|1|1|1|1|1|0'
                                                                    widths='0|1700|1300|1200|1400|1200|0'
                                                                    sorting='T'
                                                                    onafteredit="onAfterConditionEditting(this.col)"
                                                                    styles='width:100%; height:100%'
                                                                />
                                                            </td>
                                                            <td style="width: 3%;" valign="top" align="right"><gw:imgbtn id="btnAddPay" img="new" alt="Open form to Add pay condition" text="Add" onclick="onAddNew(2)" /></td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table> 
                    <table id="OrderInformation" name="Order Info." border=0 cellpadding=0 cellspacing=0 style="width: 100%; height: 100%">
                        <tr style="height: 1%"> 
                            <td width="6%" nowrap>Order No.</td>
                            <td width="25%"><gw:textbox id="txtOrderNo" styles="width:100%;" onenterkey="dat_epac00030_3.Call('');" /></td>
                            <td width="10%" align="right"></td>
                            <td width="50%" > 
                                <%--<gw:radio id="radStatus" value="1" styles="width:100%" onchange="dat_epac00030_3.Call('');"> 
                                    <span value="1">Saved </span> 
                                    <span value="2">Approved</span> 
                                    <span value="3">Cancelled</span> 
                                </gw:radio>--%>
                            </td>
                            <td width="1%"><gw:imgbtn id="btnOrdSearch" img="search" alt="Search" text="Search" onclick="dat_epac00030_3.Call('');" /></td>
                            <td width="1%"><gw:imgbtn id="btnOrdNew" img="new" alt="New" text="New" onclick="onAddNew(1)" /></td>
                            <td width="1%"><gw:imgbtn id="btnOrdSave" img="save" alt="Save" text="Save" onclick="onSave(3)" /></td>
                            <td width="1%"><gw:imgbtn id="btnOrdDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(3)" /></td>                                
                            <td width="1%"><%--<gw:imgbtn id="btnOrdConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm(2)" />--%></td>
                            <td width="1%"><%--<gw:imgbtn id="btnOrdCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onConfirm(3)" />--%></td>
                            <td width="1%"><%--<gw:imgbtn id="btnOrdRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate(2)" />--%></td>
                            <td width="1%"><%--<gw:imgbtn id="btnOrdCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy(2)" />--%></td>
                        </tr>
                        <tr style="height: 1%">
                            <td colspan="12"></td>
                        </tr>
                        <tr style="height: 45%">
                            <td colspan="12">
                                <gw:grid id='grdOrders'
                                    header='|_PK|_TIM_CONTR_MST_PK|No|Ord. No|Ord Date|Exp Date|Ship Date|Pay Ex Rate|Trans. CCY|Ex Rate|Trade Terms|Pay method|Description|Close YN|Close Date|_status|_contr_status|_type'
                                    format='0|0|0|0|0|4|4|4|0|2|0|2|2|0|3|4|0|0|0'
                                    aligns='1|0|0|1|0|1|1|1|3|1|3|0|0|0|1|1|0|0|0'
                                    defaults='||||||||||||||||||'
                                    editcol='0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0'
                                    widths='600|0|0|600|1290|1275|1185|1245|1440|1275|1110|1905|1725|2190|1000|1000|0|0|0'
                                    sorting='T'
                                    acceptNullDate='true'
                                    oncelldblclick='openPopup(6)'
                                    oncellclick='OnGridCellClick()'
                                    styles='width:100%; height:100%'
                                  />
                            </td>
                        </tr>
                        <tr style="height: 1%">
                            <td colspan="11"></td>
                            <td><gw:imgbtn id="btnOrder" img="popup" alt="Get Item to Order" text="Get Item to Order" onclick="openPopup(5)" /></td>
                        </tr>
                        <tr style="height: 52%">
                            <td colspan="12">
                                <gw:grid id='grdOrderDetail'
                                    header='_PK|No|Item Code|Item Name|HS Code|Unit|Packing Unit|Apportion|Qty.|Packing Qty.|Price|Ext. Price|VAT rate|Total Amt|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_so_pk|_cnv_ratio|_tran_rate'
                                    format='0|0|0|0|0|2|2|3|0|0|0|0|2|0|0|0|0|0|0|0|0|0'
                                    aligns='0|1|0|0|1|1|1|0|3|3|3|3|3|3|3|3|3|0|0|0|0|0'
                                    defaults='|||||||||||||||||||||'
                                    editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|1|0|0|0|0|0|0|0'
                                    widths='0|555|1500|2700|1140|1000|1500|1000|1110|1200|1035|1290|1200|1500|1595|1500|0|0|0|0|0|0'
                                    sorting='T'
                                    onafteredit="onAfterEditting()"
                                    styles='width:100%; height:100%'
                                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20"
                                />
                            </td>
                        </tr>
                    </table>
                    <table name="Condition" cellpadding=0 cellspacing=3 style="width: 100%; height: 100%">
                        <tr valign="top" style="height: 1%">
                            <td style="width:8%">Quality</td>    
                            <td style="width:2%"></td>
                            <td style="width:39%"><gw:textbox id="txtQuality"  onchange="" styles='width:100%;'/></td>
                            <td style="width:2%"></td>
                            <td style="width:8%">Packing</td>
                            <td style="width:2%"></td>
                            <td style="width:39%"><gw:textbox id="txtPacking"  text=""  styles='width:100%;'  /></td>
                        </tr>
                        <tr valign="top" style="height: 1%">
                            <td>Transshipment</td>
                            <td></td>
                            <td><gw:textbox id="txtTransshipment" styles="width:100%;" /></td>
                            <td></td>
                            <td nowrap>Partial shipment</td>
                            <td></td>
                            <td><gw:textbox id="txtPartialShip" styles="width:100%;" /></td>
                        </tr>
                        <tr valign="top" style="height: 1%">
                            <td nowrap>Shipping documents</td>
                            <td></td>
                            <td><gw:textarea id="txtShippingDoc" styles="width:100%;" rows="5"  /></td>
                            <td></td>
                            <td>Insurance</td>
                            <td></td>
                            <td><gw:textarea id="txtInsurance" styles="width:100%;" rows="5"/></td>
                        </tr>
                        <tr valign="top" style="height: 1%">
                            <td>Complaint</td>
                            <td></td>
                            <td><gw:textarea id="txtComplaint" styles="width:100%;" rows="5"  /></td>
                            <td></td>
                            <td>Force Majeure</td>
                            <td></td>
                            <td><gw:textarea id="txtForceMajeure" styles="width:100%;" rows="5"/></td>
                        </tr>
                        <tr valign="top" style="height: 96%">
                            <td>Arbitration</td>
                            <td></td>
                            <td><gw:textarea id="txtArbitration" styles="width:100%;" rows="5"  /></td>
                            <td></td>
                            <td nowrap>Other Clauses</td>
                            <td></td>
                            <td><gw:textarea id="txtOtherClauses" styles="width:100%;" rows="5"  /></td>
                        </tr>
                    </table>
                </gw:tab>
            </td>
        </tr>
    </table>
</form>
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtOrderPK" styles="display:none" />
    <gw:textbox id="txtStatusNum"  text="1"  styles='display:none;'/>
    <gw:textbox id="txtStatusText"  text="1"  styles='display:none;'/>
</body>
</html>
