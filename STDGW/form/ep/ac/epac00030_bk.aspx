<%@ Page Language="C#" %> 
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<%  ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
    var flag,is_unit_change=0,  rowchange; 
    var _status="select";
    var action;
    action='create';
    
    // G1: grdContractDetail
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
        G1_retouch_amt      = 12,    
        G1_tr_amt           = 13,   
        G1_tco_item_pk      = 14,    
        G1_tex_contr_mst_pk = 15,    
        G1_tex_order_pk     = 16,    
        G1_tsa_sotakeoutd_pk = 17,    
        G1_cnv_ratio        = 18,    
        G1_pack_rate        = 19;
        
    // G2:  grdOrders;    
    var G2_select       = 0,     
    G2_view             = 1,     
    G2_tex_order_pk     = 2,     
    G2_tex_contr_mst_pk = 3,     
    G2_rownum           = 4,     
    G2_order_no         = 5,     
    G2_order_date       = 6,     
    G2_exp_date         = 7,     
    G2_ship_date        = 8,     
    G2_pay_ex_rate      = 9,     
    G2_tr_ccy           = 10,     
    G2_ex_rate          = 11,     
    G2_trade_terms      = 12,     
    G2_pay_meth         = 13,     
    G2_status_text      = 14,     
    G2_description      = 15,     
    G2_close_yn         = 16,     
    G2_close_date       = 17,     
    G2_status           = 18,
    G2_type             = 19;
    
    function BodyInit()
    {           
        System.Translate(document);  // Translate to language session
         
        txtCom_pk.text= "<%=Session["COMPANY_PK"] %>"
        BindingDataList();
        onNew(0);  
        SetGridFormat();
        onChangeOrderYN();        
        getCurrBooking();
        radStatus.value=1;
        
        grdOrders.GetGridControl().FrozenCols = 7;        
        
        txtCusCode.SetEnable(false);
        txtCusName.SetEnable(false);
        txtOrigin.SetEnable(false);
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
         cboPaymentTermS.SetDataText(data7);  //IEAB0010
         cboCurrency.SetDataText(data2);  //ACAB0110 
         cboPaymentTerm.SetDataText(data3);   //IEAB0010 
         cboCurrencyS.SetDataText(data2);  //ACAB0110
         cboPaymentMethod.SetDataText(data4);      //ACCR0140
         cboTransport.SetDataText(data5);      //IEAB0020
         cboTolerance.SetDataText(data6);  //IEBD0050
         cboDiscount.SetDataText(data6);        //IEBD0050
         
         cboCurrency.value='USD'; 
         cboCurrencyS.value='USD';
         
         var data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
         grdContractDetail.SetComboFormat(G1_unit_cd,data);
         grdContractDetail.SetComboFormat(G1_unit_packing,data);
         
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
     }
     //--------------------------------------------------------------------------------------
    function SetStatus(index)
    {
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
                dat_epac00030_1.style.display="none";
                btnGetItemFree.style.display="none";  
                btnGetItemFromPO.style.display="none"; 
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
    //--------------------------------------------------------------
    function onStatusChange()
    {
        switch(radStatus.value)
        {
            case 1:
                //Saved	Chỉ hiển thị : Popup,New,Save,Delete,Approve button

                btnOrdSearch.style.display=""; 
                btnOrdNew.style.display=""; 
                btnOrdSave.style.display=""; 
                btnOrdDel.style.display=""; 
                btnOrdConfirm.style.display=""; 
                btnOrdCancel.style.display="none"; 
                btnOrdRegenerate.style.display="none"; 
                btnOrdCopy.style.display="none"; 
            break;
            case 2:
                //Approved	Chỉ hiển thị : Popup,New,Copy,Cancel,Print button
                btnOrdSearch.style.display=""; 
                btnOrdNew.style.display=""; 
                btnOrdSave.style.display="none"; 
                btnOrdDel.style.display="none"; 
                btnOrdConfirm.style.display="none"; 
                btnOrdCancel.style.display=""; 
                btnOrdRegenerate.style.display="none"; 
                btnOrdCopy.style.display=""; 
            break;
            default:
            {
                //Cancelled	Chỉ hiển thị : Popup,New,Regenerate button
                btnOrdSearch.style.display=""; 
                btnOrdNew.style.display=""; 
                btnOrdSave.style.display="none"; 
                btnOrdDel.style.display="none"; 
                btnOrdConfirm.style.display="none"; 
                btnOrdCancel.style.display="none"; 
                btnOrdRegenerate.style.display=""; 
                btnOrdCopy.style.display="none"; 
            }
        }        
    }
    //---------------------------------------------------------------------------------------
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {	        	         
           case 0:// Customer 
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP"; //customs
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
	                var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP"; //customs
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
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP"; //customs
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
	            fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|||";
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
                    txtOrderPK.text  = grdOrders.GetGridData(row, G2_tex_order_pk);
                }
              
                    fpath = System.RootURL + "/form/ep/ac/epac00032.aspx?order_pk=" + txtOrderPK.text + "&contract_pk=" + txtMasterPK.text + "&OrderNo=" + grdOrders.GetGridData(row, G2_order_no) + "&Status=" + txtStatus.text;
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
	            var fpath = System.RootURL + "/form/ep/ac/GetOrigin.aspx"; //customs
                aValue = System.OpenModal( fpath , 600 , 400, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtOrigin.SetDataText(aValue[2]); 
	                txtOriginPK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 9:        
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPLCofLoading.SetDataText(aValue[3]); 
	                txtPLCofLoadingCD.SetDataText(aValue[2]);  
	            }	
	        break;
	        case 10: 
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
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
	            fpath = System.RootURL + "/form/ds/bs/dsbs00012.aspx?group_type=Y|Y|Y|||";
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
                var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; //customs
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
                    dat_epac00030_3.Call('');
            break;
        }
    }    
    //---------------------------------------------------------------------------------------
    function onNew(index)
    {
        switch(index)
        {    
            case 0:
                action='create';
                txtMasterPK.SetDataText("");
                dat_epac00030_1.StatusInsert(); 
                var s_name, str;
                s_name="<%=Session["USER_NAME"]%>";
                txtFullName.SetDataText(s_name);
                txtUserName.SetDataText("<%=Session["User_ID"]%>");  
                txtDept.SetDataText("<%=Session["DEPT_NAME"]%>");
                txtDeptPK.SetDataText("<%=Session["DEPT_PK"]%>");
                txtCom_pk.text= "<%=Session["COMPANY_PK"]%>";
                cboCompany.value=txtCom_pk.text;
                getNation();
                radShipType.value='b';
                onChangeShipType();
                onChangDate();
                txtStatus.text='';
                txtStatusNum.text="1";
                SetStatus(txtStatusNum.text);
                grdContractDetail.ClearData();
            //   dat_epac00030_2.Call('SELECT');
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
                txtStatus.text=txttmp.text;
                
                if(action=='view')
                    SetStatus("4");
                else
                    SetStatus(txtStatusNum.text);
                    
                if (_status=="select")
                    dat_epac00030_2.Call('SELECT');
                else
                {       
                    for (var i=1; i<grdContractDetail.rows;i++)
                        if (grdContractDetail.GetGridData(i,0)=='')
                            grdContractDetail.SetGridText(i, G1_tex_contr_mst_pk, txtMasterPK.text);
                    grdContractDetail.SetRowStatus(grdContractDetail.rows-1,'_');
                    dat_epac00030_2.Call('');
                }                         
            break;
            case 'dat_epac00030_2':    
                grdContractDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
                grdContractDetail.SetGridText(grdContractDetail.rows-1,1,'')
                for(i=1;i<grdContractDetail.rows-1;i++)
                    grdContractDetail.SetGridText(i,1, i);
                Total();
                grdContractDetail.GetGridControl().AutoSize(0,19,false,0);
            break;
            case 'dat_epac00030_3' :
                grdOrderDetail.ClearData();
                onStatusChange();
            break;
            case 'dat_epac00030_4': 
                 grdOrderDetail.Subtotal(0,2,2,"11!12!13","",true,11,"Total");
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
                onStatusChange();
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
    //---------------------------------------------------------------------------------------
    function OnEditItem()
    {
        if(grdContractDetail.GetGridData(grdContractDetail.row, G1_tsa_sotakeoutd_pk)=='')
        {
            fpath = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N";
            oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 

            if (oValue != null)
            {  
                for ( var i=0; i<oValue.length;i++)
                {                 
                    var aValue = oValue[i];                
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_item_code   ,aValue[1]); //Item code
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_item_name   ,aValue[2]); //_item name
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_unit_cd     ,aValue[5]); //Item name
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_tco_item_pk ,aValue[0]); //tco_item_pk
                    grdContractDetail.SetGridText(grdContractDetail.row, G1_hs_code     ,aValue[19]); //hs code
                }
            }  
        }
        else
        {
            fpath = System.RootURL + "/form/ep/ac/fpab00020.aspx?IsSelectItem=1";
            oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 

            if (oValue != null)
            {  
                for ( var i=0; i<oValue.length;i++)
                {                 
                    var aValue = oValue[i];  
                    
                    grdContractDetail.SetGridText(grdContractDetail.rows, G1_item_code  ,aValue[1]); //Item code
                    grdContractDetail.SetGridText(grdContractDetail.rows, G1_item_name  ,aValue[2]); //_item name
                    grdContractDetail.SetGridText(grdContractDetail.rows, G1_unit_cd    ,aValue[3]); //Item name
                    grdContractDetail.SetGridText(grdContractDetail.rows, G1_hs_code    ,aValue[4]); //Unit
                    grdContractDetail.SetGridText(grdContractDetail.rows, G1_retouch_amt,aValue[0]); //tco_item_pk                    
                }
            }        
        }  
    }
     //------------------------------------------------------------------------
    function OnGridCellClick()
    {
        txtOrderPK.text=grdOrders.GetGridData(grdOrders.row, G2_tex_order_pk);
        dat_epac00030_4.Call('SELECT');
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
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
               }
               else
               {
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_ex_price,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_u_price))*Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_qty)));
                   grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
               }
           }
        } 
        if (colidx== G1_retouch_amt) //	Retouch Amt 
        {                
           if(!isNaN(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)))
           {           
               grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdContractDetail.SetGridText(grdContractDetail.row, G1_retouch_amt,'')
              grdContractDetail.SetGridText(grdContractDetail.row, G1_tr_amt,Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_ex_price))+Number(grdContractDetail.GetGridData(grdContractDetail.row, G1_retouch_amt)));
           }           
        } 
        Total();
        grdContractDetail.GetGridControl().AutoSize(0,19,false,0);
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
            case 1: // cancel contract
                txtStatusNum.text='3';
	            dat_epac00030_1.Call('');                    
            break;
            case 2: // approved order
                for(var i=1; i<grdOrders.rows; i++ )
                    if (grdOrders.GetGridData(grdOrders.row,0)==-1)
                        grdOrders.SetGridText(grdOrders.row, G2_status, 2)
                dat_epac00030_3.Call('');
            break;
            case 3: // cancel order
                for(var i=1; i<grdOrders.rows; i++ )
                    if (grdOrders.GetGridData(grdOrders.row,0)==-1)
                    {
                        grdOrders.SetGridText(grdOrders.row, G2_status, 3)
                    }  
                    else
                        grdOrders.SetRowStatus(i, '_')                  
                dat_epac00030_10.Call('');
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
    //--------------------------------------------------------------------------------------
    function Total()
    {
        var tlvalue;
        tlvalue=0;
        for (var i=1; i< grdContractDetail.rows-1; i++)
        {
            tlvalue = Number(tlvalue) + Number(grdContractDetail.GetGridData(i, G1_tr_amt));
        }
        txtTrAmount.SetDataText('' + tlvalue);
    }
    //-------------------------------------------------------------------------------------    
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
        onStatusChange();
     }
    
    //----------------------------------------------------------
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
   
    //-----------------------------------------------------------------------
    function onChangDate()
    {
        var ldate; 
        var lyear;
        ldate=dtContractDate.value;    
        lyear= Number(ldate.substr(0,4)) +1;
        ldate = lyear + ldate.substr(4,2) + ldate.substr(6,2)   ;       
        dtExpDate.value=ldate ; 
        getExRate();
        getExRateS();
    }
    //-----------------------------------------------------------------------
    function onRegenerate(index)
    {
        switch(index)
        {
            case 0:
                _status="save";
                action='Regenerate';
                txtType.text=2;                
                dat_epac00030_5.Call();
            break;
            case 2:
                for (var i=1; i<grdOrders.rows; i++)
                    grdOrders.SetGridText(i, G2_type,2)
                dat_epac00030_6.Call('');
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
                txtType.text=1;
                dat_epac00030_5.StatusUpdate();
                dat_epac00030_5.Call('');
            break;
            case 2:
                for (var i=1; i<grdOrders.rows; i++)
                    grdOrders.SetGridText(i,G2_type,1)
                dat_epac00030_6.Call('');
            break;
        }
    }
    //-------------------------------------------------------------------
    function onPrint()
    {    
        var  url= System.RootURL + "/reports/ep/ac/rpt_epac00030.aspx?" + "contract_pk=" + txtMasterPK.text + "&Curr=" + cboCurrency.value;
        System.OpenModal( url , 300 , 100, 'resizable:yes;status:yes');
    }
     //----------------------------------------------------------------------------------------
    function returnFileName()
    {    
        if(GetRequestState(ajax_test))
	    {	
	        strdata = ajax_test.responseText;
	        if (strdata.substr(0,5)=='Error')
	            alert(strdata);
	        else
	        {
	            var  url= System.RootURL + "/reports/ep/ac/" + strdata 
	            System.OpenTargetPage( url, "window" ); 
	        }
	    }
    }
    //--------------------------------------------------------------
    function getCompanyInfo()
    {    
	    var url =  System.RootURL + "/form/ep/ac/epac00010_GetCompanyInfo.aspx?com_pk=<%=Session["COMPANY_PK"]%>" ;
	    ajax_test = null;
	    ajax_test = GetXmlHttpRequest(returnExRate);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null); 
    }
    //--------------------------------------------------------------
    function onChangeShipType()
    {   
        if (radShipType.value=='a')
            dat_epac00030_8.Call('SELECT');
    }
    //-----------------------------------------------
    function GetXmlHttpRequest(handler)
    { 
	    var objXmlHttp=null;
    	
	    if (navigator.userAgent.indexOf("Opera")>=0)
	    {
		    alert("Sorry! Ajax doesn't work in Opera"); 
		    return; 
	    }
    	
	    if (navigator.userAgent.indexOf("MSIE")>=0)
	    { 
		    var strName="Msxml2.XMLHTTP";
		    if (navigator.appVersion.indexOf("MSIE 5.5")>=0)
		    {
			    strName="Microsoft.XMLHTTP";
    			
		    } 
		    try
		    { 
			    objXmlHttp=new ActiveXObject(strName);
			    objXmlHttp.onreadystatechange=handler; 
    			
			    return objXmlHttp;
		    } 
		    catch(e)
		    { 
			    alert("Error. Scripting for ActiveX might be disabled");
			    return; 
		    } 
	    } 
    	
	    if (navigator.userAgent.indexOf("Mozilla")>=0)
	    {
		    objXmlHttp=new XMLHttpRequest();
		    objXmlHttp.onload=handler;
		    objXmlHttp.onerror=handler;
    		
		    return objXmlHttp;
	    }
    } 
    
//-------------------------------------------------------------------
    //ajax function
    function GetRequestState(obj)
    {
     
      if(obj.readyState == 4 && obj.status == 200)
      {
          return true;
      }
      return false;
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
    //---------------------------------------------------------
    function returnExRate()
    {
        if(GetRequestState(ajax_test))
	    {	
	        strdata = ajax_test.responseText;	 	  
	        txtExRate.SetDataText(''+strdata);
	    }
    }
    //--------------------------------------------------------------
    function getExRateS()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtContractDate.value +"&curr=" + cboCurrencyS.value;
	    ajax_test1 = null;
	   
	    ajax_test1 = GetXmlHttpRequest(returnExRateS);
	    ajax_test1.open("GET", url , true);
	    ajax_test1.send(null); 
    }
    //-------------------------------------------------------------
    function returnExRateS()
    {
        if(GetRequestState(ajax_test1))
	    {	
	        strdata = ajax_test1.responseText;	 	  
	        txtExRateS.SetDataText(''+strdata);
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
    //--------------------------------------------------------------
    function getCurrBooking()
    {    
	    var url =  System.RootURL + "/form/ep/ac/AjaxFile.aspx?type=1" ;
	    ajax_test3 = null;
	  
	    ajax_test3 = GetXmlHttpRequest(returnCurrBooking);
	    ajax_test3.open("GET", url , true);
	    ajax_test3.send(null); 
    }
    //-------------------------------------------------------------
    function returnCurrBooking()
    {    
        if(GetRequestState(ajax_test3))
	    {		   
	        strdata = ajax_test3.responseText;	 		         
	        lbCurr.SetDataText('/'+strdata);
	        lbCurrS.SetDataText('/'+strdata);
	    }
    }
    //-----------------------------------------------------------------------------------------
    function AddCommonCode(index)
    {     
        var scode;
        switch(index)
        {           
            case 1:
                scode='IEAB0010'; //cboPaymentTermS
            break;
            case 2:
                scode='ACCR0020'; //cboPaymentTerm
            break;
            case 3:
                scode='ACAB0110'; // cboCurrency
            break;  
            case 4:
                scode='ACAB0110'; // cboCurrencyS
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
                        cboPaymentTermS.value=strcodereturn; //cboPaymentTermS
                    break;
                    case 2:
                        cboPaymentTerm.value=strcodereturn; //cboPaymentTerm
                    break;
                    case 3:
                        cboCurrency.value=strcodereturn; // cboCurrency
                    break;  
                    case 4:
                        cboCurrencyS.value=strcodereturn; // cboCurrencyS
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
    //--------------------------------------------------------------------------------------------
    function return_result()
    {	        
	    if(GetRequestState(ajax_test4))
	    {
	        strdata = ajax_test4.responseText;	
            switch(indexCode)
            {    
                case 1:
                    cboPaymentTermS.SetDataText(strdata);
                    cboPaymentTermS.value=strcodereturn; //cboPaymentTermS                    
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
                    cboCurrencyS.SetDataText(strdata);
                    cboCurrencyS.value=strcodereturn; // cboCurrencyS
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
    //-----------------------------------------------------------------------------------    
    function onDiscountChange()
    {
        var tmp;
        tmp = (Number(cboDiscount.value)/100)*Number(txtTrAmount.text);
        txtDiscAmount.SetDataText("'"+tmp);
    }
</script>
<body>
<!------------------------------------------------------------------>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,61,62,65" function="imex.sp_sel_epac00030_1"  procedure="IMEX.sp_upd_epac00030_1"> 
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
                 <inout  bind="cboPaymentTermS" />               
                 <inout  bind="cboPaymentMethod" /> 	
                 <inout  bind="cboCurrencyS" /> 
                 <inout  bind="cboPaymentTerm" />
                 <inout  bind="chkOrderYN" />            
                 <inout  bind="chkCloseYN" />
                 <inout  bind="dtCloseDate" />
                 <inout  bind="txtShipAdd" /> 
                 <inout  bind="txtPaidAdd" />                
                 <inout  bind="txtStatusNum" /> 
                 <inout  bind="txtDeptPK" />
                 <inout  bind="radShipType" />
                 <inout  bind="radPayType" />
                 <inout  bind="cboDiscount" />
                 <inout  bind="cboTransport" />
                 <inout  bind="txtExRateS" />
                 <inout  bind="txtLocation" />
                 <inout  bind="txtDesc" />
                 <inout  bind="txtAccountBank" />
                 <inout  bind="txttmp" />
                 <inout  bind="txtCusCode" />   
                 <inout  bind="txtCusName" />
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipName" />    
                 <inout  bind="txtShipAdd" />
                 <inout  bind="txtPaidCode" />
                 <inout  bind="txtPaidName" />    
                 <inout  bind="txtPaidAdd" /> 
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
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="imex.sp_sel_epac00030_2"   procedure="imex.sp_upd_epac00030_2"> 
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
        <dso id="1" type="grid" parameter="2,3,5,6,7,8,9,10,11,12,13,15,16,17,18" function="imex.sp_sel_epac00030_3"   procedure="imex.sp_upd_epac00030_3"> 
            <input bind="grdOrders">                    
                <input bind="txtMasterPK" /> 
                <input bind="txtOrderNo" /> 
                <input bind="radStatus" />   
            </input> 
            <output bind="grdOrders" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------>
<gw:data id="dat_epac00030_4"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="2,3,5,6,7,8,9,10,11,12,13,15,16,17,18" function="imex.sp_sel_epac00030_4"   > 
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
<!-----------------------Regenerate or Copy Order------------------------------------------->
<gw:data id="dat_epac00030_6"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="2,19" function="imex.sp_sel_epac00030_6"   procedure="imex.sp_upd_epac00030_6"> 
                <input bind="grdOrders">                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtOrderNo" /> 
                    <input bind="radStatus" />   
                </input> 
                <output bind="grdOrders" /> 
            </dso> 
        </xml> 
</gw:data> 
<!------------------------Get Company Info -------------------------------------->
<gw:data id="dat_epac00030_8"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,43" function="imex.sp_sel_get_CompanyInfo"  > 
            <inout>     
                 <inout  bind="txtCom_pk" />
                 <inout  bind="txtShipName" />
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipPK" />
                 <inout  bind="txtShipAdd" />
            </inout>
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
<!------------------------Cancel Order---------------------------------------->
<gw:data id="dat_epac00030_10"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="2,18" function="imex.sp_sel_epac00030_10"   procedure="imex.sp_upd_epac00030_10"> 
            <input bind="grdOrders">                    
                <input bind="txtMasterPK" /> 
                <input bind="txtOrderNo" /> 
                <input bind="radStatus" />   
            </input> 
            <output bind="grdOrders" /> 
        </dso> 
    </xml> 
</gw:data> 
<!-------------------------------get current curency------------------------------------>
<gw:data id="dat_epac00030_11" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_get_curr_booking" > 
            <input>
                <input bind="txtMasterPK" />
            </input> 
            <output>
                <output bind="txtCurr" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get ratio----------------------------------------------->
<gw:data id="dat_epac00030_12" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_get_cnv_ratio" > 
            <input>
                <input bind="txtUnit" />
            </input> 
            <output>
                <output bind="txtCnvRatio" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get unit tran----------------------------------------------->
<gw:data id="dat_epac00030_13" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_dat_epac00030_13" > 
            <input>   
                <input bind="txtItemPK" />
                <input bind="txtUnit" />
                <input bind="txtUnitTran" />
            </input> 
            <output>
                <output bind="txtTran_rate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <table border=0 cellpadding=0 cellspacing=0 width="100%">
            <tr> 
                <td width="8%">Status</td>
                <td width="10%"><gw:label id="txtStatus"  text="Save"  styles='width:100%;color:red; font-weight:700;;' /></td>
                <td width="12%"></td>
                <td width="20%"></td> 
                <td width="40%"></td>
                <td width="1%"><gw:imgbtn id="btnSearch" img="popup" alt="Open form to search" text="Search" onclick="openPopup(3)" /></td>
                <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" /></td>
                <td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                <td width="1%"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                <td width="1%"><gw:imgbtn id="btnExcel" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                <td width="1%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm(0)" /></td>
                <td width="1%"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onCancel(1)" /></td>
                <td width="1%"><gw:imgbtn id="btnRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate(0)" /></td>
                <td width="1%"><gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy(0)" /></td>
            </tr>
            <tr>
                <td colspan="14">
                    <gw:tab id="idTab" onpageactivate="return OnCheckTab()"  style="width: 100%; height: 220; border1px">
                        <table id="Contract Info." name="Contract Info." cellpadding=0 cellspacing=0 border=0 width="100%">
                            <tr>
                                <td>Company</td>
                                <td colspan="2"><gw:list id="cboCompany" styles="width:100%;" onchange="getNation();"></gw:list></td>
                                <td colspan="14"></td>
                            </tr>
                            <tr>
                                <td  nowrap width="8%"><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Vendor Name</b></a> </td>
                                <td width="10%"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtCusPK"  text=""  styles='display:none'  /></td>
                                <td colspan="5" ><gw:textbox id="txtCusName"  text=""  styles='width:100%;' csstype="mandatory" /></td>                              
                                <td width="1%"></td>
                                <td  nowrap width="6%"> Close Y/N</td>
                                <td width="1%"></td>
                                <td width="10%" align=left><gw:checkbox id="chkCloseYN"  defaultvalue="Y|N" value="N" /></td>
                                <td width="1%"></td>
                                <td nowrap width="8%"><a title="Click here to select Trans. Currency" onclick="AddCommonCode(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Trans. Currency</b></a></td>
                                <td width="1%">&nbsp;</td>
                                <td width="15%" colspan="2" ><gw:list id="cboCurrency" styles="width:100%;" onchange="getExRate();"></gw:list></td>
                                <td width="10%"><gw:label id="lbCurr"  text=""  styles='width:100%;'/></td>
                            
                            </tr>
                            <tr>
                                <td width="8%" nowrap>Contract No</td>
                                <td width=25% colspan="2"><gw:textbox id="txtContractNo"  text=""  styles='width:100%;' csstype="mandatory" onenterkey="dat_epac00030_7.Call('SELECT');" /></td>
                                <td nowrap width="2%"></td>
                                <td width="8%" nowrap >Contract Date</td>
                                <td width="1%"></td>
                                <td width="10%"><gw:datebox id="dtContractDate" lang="1"  styles='width:100%;' onchange="onChangDate();"/></td>
                                <td width="1%"></td>
                                <td width="6%" nowrap >Close Date</td>
                                <td width="1%">&nbsp;</td>
                                <td width="1%"><gw:datebox id="dtCloseDate" lang="1" nullaccept  onchange=""/></td>
                                <td width="1%"></td>
                                <td width="8%" nowrap>Ex. Rate</td>
                                <td width="1%"></td>
                                <td width="6%"><gw:textbox id="txtEachCur"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/></td>
                                <td width="19%" colspan="2" ><gw:textbox id="txtExRate"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/></td>
                            </tr>
                            <tr>
                                <td  nowrap><a title="Click here to select Origin" onclick="openPopup(8)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Item Origin</b></a></td>                                
                                <td colspan="2" ><gw:textbox id="txtOrigin"  value=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtOriginPK"  value=""  styles='display:none;' /></td>
                                <td ></td>
                                <td  nowrap align=left> Expiry Date</td>
                                <td ></td>
                                <td ><gw:datebox id="dtExpDate" lang="1" onchange=""/></td>
                                <td ></td>
                                <td > <a title="Click here to select Tolerance" onclick="AddCommonCode(7)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Tolerance</b></a></td>
                                <td ></td>
                                <td ><gw:list id="cboTolerance"  value=""  styles='width:100%;'/></td> 
                                <td ></td>
                                <td > Trans. Amount</td>
                                <td ></td>
                                <td  colspan="3"><gw:textbox id="txtTrAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:98%;' csstype="mandatory" /></td>                                                             
                            </tr>
                            <tr>
                                <td  nowrap>Order Y/N</td>
                                <td colspan="2">
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr>
                                            <td width="30%"><gw:checkbox id="chkOrderYN" onchange="onChangeOrderYN()" defaultvalue="Y|N" value="N"/></td>
                                            <td width="70%" align="right">Quality</td>
                                        </tr>
                                    </table>
                                </td>
                                <td ></td>
                                <td  colspan="3"> <gw:textbox id="txtQuality"  onchange="" styles='width:100%;'/></td>   
                                <td ></td>
                                <td > Packing</td>
                                <td ></td>
                                <td  colspan="7"><gw:textbox id="txtPacking"  text=""  styles='width:98%;'  /></td>                                                             
                            </tr>
                            <tr>
                                <td  nowrap rowspan="2">Remark</td>                                
                                <td colspan="6" rowspan="2"><gw:textarea id="txtDesc" rows=4 text=""  styles='width:100%;'/></td>
                                <td rowspan="2"></td>
                                <td rowspan="2"><a title="Click here to select Nominated Party for goods delivered" onclick="openPopup(14)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Nominated Party for goods delivered</b></a></td>
                                <td ></td>  
                                <td><gw:textbox id="txtPartyC"  text=""  styles='width:100%;'  /><gw:textbox id="txtPartyCPK"  text=""  styles='display:none;'  /></td>
                                <td colspan="6" ><gw:textbox id="txtPartyCName"  text=""  styles='width:100%;'  /></td>                                
                            </tr> 
                            <tr>
                                <td ></td>
                                <td colspan="7" ><gw:textarea id="txtPartyCAdd" rows=3 text=""  styles='width:100%;'  /></td>
                            </tr>
                            <tr>
                                <td colspan="17">
                                    <table width="100%" cellpadding=0 cellspacing =0 id="idGridDetail">
                                        <tr >
                                            <td >
                                                <table border=0 cellpadding=0 cellspacing=0 width="100%">
                                                    <tr> 
                                                        <td width="92%" ></td>
                                                        <td width="2%"><gw:imgbtn id="btnCrtItemFree" img="new" alt="Create new Item" text="Create new Item" onclick="openPopup(13)" /></td>
                                                        <td width="2%"><gw:imgbtn id="btnGetItemFree" img="popup" alt="Get Free Item" text="Get Free Item" onclick="openPopup(4)" /></td>
                                                        <td width="2%"><gw:imgbtn id="btnGetItemFromSO"  img="popup" alt="Get Item from SO" text="Get Item from SO" onclick="openPopup(7)"  /></td>
                                                        <td width="2%"><gw:imgbtn id="btnDelItem" img="delete" alt="New" text="New" onclick="onDelete(1)" /></td>        
                                                        <td width="2%"><gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" text="Refresh" onclick="dat_epac00030_2.Call('SELECT');" /></td>        
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>                                
                                        <tr>
                                            <td >
                                                <%--'0._PK|1.No|2.Item Code|3.Item Name|4.HS Code|5.Unit|6.Apportion|7.Qty.|8.Price|9.Ext. Price|10.Retouch Amt
                                                |11.Adj. Ext. Price|12._item_pk|13._contract_master_pk|14._order_pk|15._so_pk|16._cnv_ratio'--%>
                                                <gw:grid id='grdContractDetail'
                                                    header='_PK|No|Item Code|Item Name|HS Code|Unit|Packing Unit|Apportion|Qty.|Packing Qty.|Price|Ext. Price|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_so_pk|_cnv_ratio|_tran_rate'
                                                    format='0|0|0|0|0|2|2|3|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    aligns='0|1|0|0|1|1|1|0|3|3|3|3|3|3|3|0|0|0|0|0'
                                                    defaults='||||||||||||||||||'
                                                    editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|0|0|0|0|0|0'
                                                    widths='0|555|1500|2700|1140|1000|1500|1000|1110|1200|1035|1290|1595|1500|0|0|0|0|0|0'
                                                    sorting='T'
                                                    onafteredit="onAfterEditting(this.col)"
                                                    styles='width:100%; height:300'
                                                    oncelldblclick="OnEditItem()"
                                                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"
                                                />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table id="Table1" name="Shipment/Payment Info" cellpadding=0 cellspacing=0 width="100%">                                                        
                            <tr>
                                <td width="48%">
                                <fieldset style="padding: 5">
                                    <legend ><font color="black"  >Shipment Information</font></legend>
                                    <table width="100%" border=0 cellpadding=0 cellspacing=0>                                        
                                        <tr>
                                            <td> </td>
                                            <td colspan="3">
                                                <gw:radio id="radShipType" value="a" styles="width:100%" onchange="onChangeShipType()"> 
                                                    <span value="a">Us/Customer </span> 
                                                    <span value="b">Consignee</span> 
                                                </gw:radio>
                                            </td>                                            
                                        </tr>
                                        <tr> 
                                            <td width="28%"><a title="Click here to select" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Ship To</b></a></td>
                                            <td width="10%"><gw:textbox id="txtShipCode"   styles="width:100%;" csstype="mandatory"  /><gw:textbox id="txtShipPK"   styles="display:none" /></td>
                                            <td colspan="2" width="60%"><gw:textbox id="txtShipName" styles="width:100%;" /></td>
                                        </tr>
                                        <tr> 
                                            <td>&nbsp;</td>
                                            <td colspan="3"><gw:textarea id="txtShipAdd" rows="3" styles="width:100% ;" csstype="mandatory"  /></td>
                                        </tr>
                                        <tr>
                                            <td><a title="Click here to select Transportation By" onclick="AddCommonCode(6)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Transportation By</b></a></td>
                                            <td colspan="3"><gw:list id="cboTransport"  csstype="mandatory"  styles="width:100%;" /></td>
                                        </tr>
                                        <tr>
                                            <td>Shipment Date</td>
                                            <td><gw:datebox id="dtShipDate" lang="1" onchange="" csstype="mandatory"  styles="width:100%;" /></td>
                                            <td colspan="2"> 
                                                <table width="100%"  cellpadding=0 cellspacing=0>
                                                    <tr>
                                                        <td width="7%"></td>
                                                        <td width="20%" nowrap >Ship remark</td>
                                                        <td width="3%"> </td>
                                                        <td width="70%"><gw:textbox id="txtShipRemark" styles="width:100%;" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><a title="Click here to select Location" onclick="openPopup(11)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Location</b></a></td>
                                            <td colspan="3"><gw:textbox id="txtLocation" styles="width:100%;" /></td>
                                        </tr>   
                                        <tr>
                                            <td><a title="Click here to select Place of Loading" onclick="openPopup(9)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Loading</b></a></td>
                                            <td colspan="3" nowrap >
                                                <table width="100%" cellpadding=0 cellspacing=0>
                                                    <tr>
                                                        <td width="96%">
                                                            <gw:textbox id="txtPLCofLoading" styles="width:100%;" /><gw:textbox id="txtPLCofLoadingCD"  styles="display:none;" />
                                                        </td>
                                                        <td width="4%"><gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPLCofLoading.text='';txtPLCofLoadingCD.text='';" /></td>
                                                    </tr>
                                                </table>
                                            
                                        </tr>   
                                        <tr>
                                            <td><a title="Click here to select Place of Discharge" onclick="openPopup(10)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Discharge</b></a></td>
                                            <td colspan="3" nowrap >
                                                <table width="100%" cellpadding=0 cellspacing=0>
                                                    <tr>
                                                        <td width="96%">
                                                            <gw:textbox id="txtPlaceDischarge" csstype="mandatory"   styles="width:100%;" /><gw:textbox id="txtPlaceDischargeCD"  styles="display:none;" />
                                                        </td>
                                                        <td width="4%"><gw:imgbtn id="reset2" img="Reset" alt="Reset" onclick="txtPlaceDischarge.text='';txtPlaceDischargeCD.text='';" /></td>
                                                    </tr>
                                                </table>
                                            
                                        </tr>  
                                        <tr>
                                            <td><a title="Click here to select Trade Terms" onClick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Trade Terms</b></a> </td>
                                            <td colspan="3"><gw:list id="cboPaymentTermS" styles="width:100%;"></gw:list></td>
                                        </tr>
                                        <tr> 
                                            <td>Transshipment</td>
                                            <td colspan="3"><gw:textbox id="txtTransshipment" styles="width:100%;" /></td>
                                        </tr>
                                        <tr>
                                            <td>Partial shipment</td>
                                            <td colspan="3"><gw:textbox id="txtPartialShip" styles="width:100%;" /></td>
                                        </tr>
                                    </table>
                                </fieldset> 
                                </td>
                                <td width="2%"></td>
                                <td width="50%" valign="top">
                                <fieldset style="padding: 5">
                                    <legend ><font color="black"  >Payment Information</font></legend>
                                    <table width="100%" cellpadding=0 cellspacing=0 border=0>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="5">
                                                <gw:radio id="radPayType" value="a" styles="width:100%" onchange=""> 
                                                    <span value="a">Vendor </span> 
                                                    <span value="b">Other</span> 
                                                </gw:radio>
                                            </td>
                                        </tr>
                                        <tr> 
                                            <td width="30%"><a title="Click here to select" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Paid To</b></a> </td>
                                            <td width="20%"><gw:textbox id="txtPaidCode"   styles="width:100%;" csstype="mandatory"  /><gw:textbox id="txtPaidPK"   styles="display:none" /></td>
                                            <td colspan="4" width="20%"><gw:textbox id="txtPaidName" csstype="mandatory"   styles="width:100%;" /></td>                                            
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="5" ><gw:textarea id="txtPaidAdd" styles="width:100%;" rows="3" csstype="mandatory" /></td>
                                        </tr>
                                        <tr>
                                            <td><a title="Click here to select Payment Method" onclick="AddCommonCode(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Method</b></a></td>
                                            <td><gw:list id="cboPaymentMethod" styles="width:100%;" csstype="mandatory" ></gw:list></td>                                
                                            <td width="2%"></td>
                                            <td nowrap ><a title="Click here to select Discount on Payment" onclick="AddCommonCode(8)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Disc. on Payment</b></a></td>
                                            <td colspan="2"><gw:list id="cboDiscount" onchange="onDiscountChange();" styles="width:100%;" /></td>
                                        </tr>
                                        <tr>
                                            <td>% Paid before shipment</td>
                                            <td ><gw:textbox id="txtPerPaid" styles="width:100%;" /></td>
                                            <td ></td>
                                            <td nowrap >Disc. Amount</td>
                                            <td colspan="2"><gw:textbox id="txtDiscAmount"   type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td>
                                        </tr>
                                        <tr> 
                                            <td><a title="Click here to select Payment Currency" onclick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Currency</b></a></td>
                                            <td><gw:list id="cboCurrencyS" styles="width:100%;" onchange="getExRateS()"></gw:list></td>
                                            <td width="10%"><gw:label id="lbCurrS"   styles="width:100%;" /></td>
                                            <td>Ex. Rate</td>
                                            <td width="6%"><gw:textbox id="txtEachCurS"  text="1"  styles="width:100%;" /></td>
                                            <td width="19%"><gw:textbox id="txtExRateS"   type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td> 
                                        </tr>
                                        <tr>
                                             <td><a title="Click here to select Payment Term" onclick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Term</b></a></td>
                                             <td colspan="5"><gw:list id="cboPaymentTerm" styles="width:100%;" csstype="mandatory" ></gw:list></td>                                             
                                        </tr>
                                         <tr>
                                            <td><a title="Click here to select Bank" onclick="openPopup(12)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Bank</b></a></td>
                                            <td colspan="5"><gw:textbox id="txtBank"   styles="width:100%;" /><gw:textbox id="txtBankPK"   styles="display:none;" /></td>
                                        </tr>
                                        <tr>
                                            <td width="15%" nowrap>Bank Account</td>
                                            <td colspan="5"><gw:textbox id="txtAccountBank"   styles="width:100%;" /></td>
                                        </tr>                                     
                                    </table>
                                </fieldset>  
                                <table width="100%" cellpadding=0 cellspacing=0>
                                    <tr>
                                        <td width="30%">Shipping documents</td>
                                        <td width="70%"><gw:textarea id="txtShippingDoc" styles="width:100%;" rows="3"  /></td>
                                    </tr>
                                </table>                              
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr>    
                                            <td >Insurance</td>
                                            <td colspan="4"><gw:textarea id="txtInsurance" styles="width:100%;"/></td>
                                        </tr>
                                        <tr>
                                            <td width="12%">Complaint</td>
                                            <td width="36%"><gw:textarea id="txtComplaint" styles="width:100%;" rows="3"  /></td>
                                            <td width="2%"></td>
                                            <td width="15%">Force Majeure</td>
                                            <td width="35%"><gw:textarea id="txtForceMajeure" styles="width:100%;" rows="3"  /></td>
                                        </tr>
                                        <tr>
                                            <td>Arbitration</td>
                                            <td><gw:textarea id="txtArbitration" styles="width:100%;" rows="3"  /></td>
                                            <td></td>
                                            <td>Other Clauses</td>
                                            <td><gw:textarea id="txtOtherClauses" styles="width:100%;" rows="3"  /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                       </table> 
                       <table id="OrderInformation" name="Order Info." border=0 cellpadding=0 cellspacing=0 width="100%">
                            <tr> 
                                <td width="6%" nowrap>Order No.</td>
                                <td width="25%"><gw:textbox id="txtOrderNo" styles="width:100%;" onenterkey="dat_epac00030_3.Call('');" /></td>
                                <td width="10%" align="right">Status</td>
                                <td width="50%" > 
                                    <gw:radio id="radStatus" value="1" styles="width:100%" onchange="dat_epac00030_3.Call('');"> 
                                        <span value="1">Saved </span> 
                                        <span value="2">Approved</span> 
                                        <span value="3">Cancelled</span> 
                                    </gw:radio>
                                </td>
                                <td width="1%"><gw:imgbtn id="btnOrdSearch" img="search" alt="Search" text="Search" onclick="dat_epac00030_3.Call('');" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdNew" img="new" alt="New" text="New" onclick="onNew(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdSave" img="save" alt="Save" text="Save" onclick="onSave(3)" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(3)" /></td>                                
                                <td width="1%"><gw:imgbtn id="btnOrdConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm(2)" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onConfirm(3)" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate(2)" /></td>
                                <td width="1%"><gw:imgbtn id="btnOrdCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy(2)" /></td>
                            </tr>
                            <tr>
                                <td colspan="12"></td>
                            </tr>
                            <tr>
                                <td colspan="12">
                                    <gw:grid id='grdOrders'
                                        header='Select||_PK|_TIM_CONTR_MST_PK|No|Ord. No|Ord Date|Exp Date|Ship Date|Pay Ex Rate|Trans. CCY|Ex Rate|Trade Terms|Pay method|Status|Description|Close YN|Close Date|_status|_type'
                                        format='3|0|0|0|0|0|4|4|4|0|2|0|2|2|0|0|3|4|0|0'
                                        aligns='0|1|0|0|1|0|1|1|1|3|1|3|0|0|0|0|1|1|0|0'
                                        defaults='|||||||||||||||||||'
                                        editcol='0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|1|1|1|0|0'
                                        widths='0|600|0|0|600|1290|1275|1185|1245|1440|1275|1110|1905|1725|1000|2190|1000|1000|0|0'
                                        sorting='T'
                                        acceptNullDate='true'
                                        oncelldblclick='openPopup(6)'
                                        oncellclick='OnGridCellClick()'
                                        styles='width:100%; height:180'
                                      />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="11"></td>
                                <td><gw:imgbtn id="btnOrder" img="popup" alt="Get Item to Order" text="Get Item to Order" onclick="openPopup(5)" /></td>
                            </tr>
                            <tr>
                                <td colspan="12">
                                    <gw:grid id='grdOrderDetail'
                                        header='_PK|No|Item Code|Item Name|HS Code|Unit|Packing Unit|Apportion|Qty.|Packing Qty.|Price|Ext. Price|Retouch Amt|Adj. Ext. Price|_item_pk|_contract_master_pk|_order_pk|_so_pk|_cnv_ratio|_tran_rate'
                                        format='0|0|0|0|0|2|2|3|0|0|0|0|0|0|0|0|0|0|0|0'
                                        aligns='0|1|0|0|1|1|1|0|3|3|3|3|3|3|3|0|0|0|0|0'
                                        defaults='||||||||||||||||||'
                                        editcol='1|0|0|0|0|1|1|1|1|1|1|0|1|0|0|0|0|0|0|0'
                                        widths='0|555|1500|2700|1140|1000|1500|1000|1110|1200|1035|1290|1595|1500|0|0|0|0|0|0'
                                        sorting='T'
                                        onafteredit="onAfterEditting()"
                                        styles='width:100%; height:230'
                                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13"
                                    />
                                </td>
                            </tr>
                        </table>               
                    </gw:tab>
                </td>
            </tr>
        </table>
    </form>
    <gw:textbox id="txtType" styles="display:none" />
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtOrderPK" styles="display:none" />
    <gw:textbox id="txtCom_pk" styles="display:none" />
    <gw:textbox id="txtStatusNum"  text="1"  styles='display:none;'/>
    <gw:textbox id="txtDept"  text=""  styles='display:none'/>
    <gw:textbox id="txtDeptPK"  text=""  styles='display:none;' />
    <gw:textbox id="txtUserName"  text=""  styles='display:none'/>
    <gw:textbox id="txtFullName"  text=""  styles='display:none'  />
    <gw:textbox id="txttmp"  text=""  styles='display:none'  />
    <gw:textbox id="txtCurr"  text=""  styles='display:none'  />
    <gw:textbox id="txtCnvRatio"  text=""  styles='display:none'  />
    <gw:textbox id="txtUnit"  text=""  styles='display:none'  />
    <gw:textbox id="txtUnitTran"  text=""  styles='display:none'  />  
    <gw:textbox id="txtTran_rate"  text=""  styles='display:none'  />
    <gw:textbox id="txtItemPK"  text=""  styles='display:none'  />
</body>
</html>
