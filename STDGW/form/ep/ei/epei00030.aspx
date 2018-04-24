<%@ Page Language="C#" AutoEventWireup="true" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<script LANGUAGE="JavaScript" SRC="/ESYS/system/lib/ajax.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Export Invoice Entry</title>
</head>
<%  ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
   var action, rowchange, is_unit_change=0 ;
   
   var  G_pk             = 0, 
        G_contr_no      = 1, 
        G_order_no      = 2, 
        G_item_code     = 3,
        G_item_name     = 4,
        G_hs_code       = 5,
        G_unit_cd       = 6,
        G_unit_packing  = 7, 
        G_unit_weight   = 8, 
        G_u_price       = 9, 
        G_qty           = 10, 
        G_qty_packing   = 11,
        G_net_weight    = 12,
        G_ex_price      = 13, 
        G_retouch_amt   = 14,
        G_tr_amt        = 15, 
        G_tex_cinv_mst_a_pk     = 16,
        G_tex_contr_dtl_pk      = 17, 
        G_tco_item_pk           = 18,
        G_tex_contr_mst_pk      = 19,
        G_tex_order_pk          = 20,
        G_order_yn              = 21,
        G_remain                = 22,
        G_cnv_ratio             = 23, 
        G_tran_rate             = 24,
        G_weight_rate           = 25;
//=========================================================================        
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        
        BindingDataList();        
        onNew(0);
        SetGridFormat();
        
        getCurrBooking();
        
        txtCom_pk.text= "<%=Session["COMPANY_PK"] %>"
        txtMasterPK.text="<%=Request["invoice_pk"]%>" 
        if(txtMasterPK.text!='')
        {        
            action='view';
            dat_epei00030_1.Call('SELECT');
        }
        dat_epei00030_11.Call();
    }
//=========================================================================        
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
         var data2 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0020','','') FROM DUAL")%>";  //trade term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0140','','') FROM DUAL")%>";  // payment method
         var data6 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEBD0050','','') FROM DUAL")%>";  // payment method
         var data7 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0020','','') FROM DUAL")%>";  //status
         var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0010','','') FROM DUAL")%>";  // payment term
                  
         cboCompany.SetDataText(data1);         
         cboPaymentTermS.SetDataText(data5); 
         cboCurrency.SetDataText(data2);  
         cboPaymentTerm.SetDataText(data3);   
         cboCurrencyS.SetDataText(data2); 
         cboPaymentMethod.SetDataText(data4);               
         cboDiscount.SetDataText(data6); 
         cboTransport.SetDataText(data7);  
         
         cboCurrency.value='USD'; 
         cboCurrencyS.value='USD';
         <%=ESysLib.SetGridColumnComboFormat("grdInvItem", 6, "select a.UOM_CODE,  decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0")%>; 
         <%=ESysLib.SetGridColumnComboFormat("grdInvItem", 7, "select a.UOM_CODE,  decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0")%>; 
         <%=ESysLib.SetGridColumnComboFormat("grdInvItem", 8, "select a.UOM_CODE,  decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0 and upper(DIMENSION_TYPE)='WET'")%>; 
     }
//=========================================================================        
     function SetGridFormat()
     {
        grdInvItem.GetGridControl().FrozenCols = 5;
        var ctr = grdInvItem.GetGridControl(); 
        ctr.ColFormat(G_u_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_qty) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_qty_packing) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_net_weight) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_ex_price) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_retouch_amt) = "#,###,###,###,###,###.##";
        ctr.ColFormat(G_tr_amt) = "#,###,###,###,###,###.##";
     }
//=========================================================================        
    function SetStatus(index)
    {
        txtPLCofLoading.SetEnable(false);  
        txtPLCofDischarge.SetEnable(false);
        
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
                btnPopup.style.display="none";
                btnSave1.style.display="none";
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
//=========================================================================        
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {	        
	         
           case 0:// Customer 
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP"; //customs
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
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
	                var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?"; //customs
                    aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
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
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
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
	            var fpath = System.RootURL + "/form/ep/ac/epac00010_SearchContract.aspx"; //search contract
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {   
	                txtMasterPK.SetDataText(aValue[0]); 
	                flag=0; // chua goi order
	                dat_epac00010_1.Call('SELECT');
	            }	
	        break;
	        case 4:// items
	            if (txtCusPK.text=="") 
	            {
	                alert("Please chose vendor first!");
	                return;
	            }
	            
	            fpath = System.RootURL + '/form/ep/ei/epei00030_GetContract.aspx?vendor='+ txtCusPK.text;
	            var arrValue  = System.OpenModal(  fpath , 900 , 650 , 'resizable:yes;status:yes');
	            var aValue , isAlready;
	            isAlready=0;
	            
	            if ( arrValue != null )
	            {       
	                var rows;
	                rows=arrValue.length;
	                aValue=arrValue[rows-2];
	                
	                txtContractNo.text=aValue[0];
	                txtOrderNo.text=aValue[1];
	                txtCtrPKtmp.text=aValue[2];
	                
	                aValue=arrValue[rows-1];	
	                if(aValue!=null)
	                {
	                    cboCurrency.value = aValue[6];
	                    txtExRate.text = aValue[12];
	                    txtExRateS.text = aValue[25];
                        cboTransport.value = aValue[22];
                        dtShipDate.value = aValue[15];
                        txtLocation.text = aValue[23];
                        txtPLCofLoadingCD.text = aValue[14];
                        txtPLCofDischargeCD.text = aValue[13];
                        cboPaymentTermS.value = aValue[16];
                        cboPaymentMethod.value = aValue[17];
                        cboCurrencyS.value = aValue[6];
                        cboPaymentTerm.value = aValue[19];
                        cboDiscount.value = aValue[21];
                        onDiscountChange()
                        txtPLCofLoading.text = aValue[26];   
                        txtPLCofDischarge.text = aValue[27];
                        txtCtrPK.text = aValue[10];                        
                    }
                    
	                for(var i=0; i<=rows-3; i++)   
	                {
	                    aValue=arrValue[i];
	                    
	                    for(var k=0; k<grdInvItem.rows;k++)
	                        if (grdInvItem.GetGridData(k , G_tex_contr_dtl_pk)== aValue[14]) // da co
					        {
						        isAlready=1;
						        break;	
					        }			 
	                    //1 2 3 4 5 6 7 8  13 14 15 16 17
                        //2 3 4 5 6 7 8 11 14 15 12 13 16

	                    if(isAlready==0) 
	                    {
	                        grdInvItem.AddRow();
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_contr_no ,aValue[2]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_order_no ,aValue[3]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_item_code ,aValue[4]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_item_name ,aValue[5]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_hs_code ,aValue[7]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_unit_cd ,aValue[6]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_u_price ,aValue[8]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_qty ,aValue[11]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_remain ,aValue[11]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tex_contr_dtl_pk ,aValue[14]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tco_item_pk ,aValue[15]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tex_contr_mst_pk ,aValue[12]); 
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tex_order_pk ,aValue[13]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_order_yn ,aValue[16]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_cnv_ratio ,aValue[18]);
	                        
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tran_rate ,aValue[22]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_unit_packing ,aValue[20]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_unit_weight ,'KG');
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_qty_packing ,aValue[21]);
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_weight_rate ,aValue[23]);
	                        
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_net_weight ,Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_weight_rate))*Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_qty)));
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_ex_price ,Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_u_price))*Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_qty)));
	                        grdInvItem.SetGridText(grdInvItem.rows-1, G_tr_amt ,Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_ex_price))+Number(grdInvItem.GetGridData(grdInvItem.rows-1,G_retouch_amt)));
	                    }                   
	                } 
	               Total();	
	               grdInvItem.Subtotal(0,2,2,"13!14!15","",true,13,"Total");
	               grdInvItem.GetGridControl().AutoSize(0,24,false,0);
	               grdInvItem.SetGridText(grdInvItem.rows-1,1,'');
	            } 	
	            var strCtrPK = txtCtrPKtmp.text.split(",");
	            if 	(strCtrPK.length >1) 
	                btnSearchCtr.SetEnable(true);
	            else
	                btnSearchCtr.SetEnable(false);
	        break;
	        case 5:
	            var fpath = System.RootURL + "/form/ep/ei/epei00030_SearchInvoice.aspx"; //search contract
                aValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {   
	                txtMasterPK.SetDataText(aValue[0]); 
	                dat_epei00030_1.Call('SELECT');
	            }	
	        break;
	        case 9:        
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 540, 'resizable:yes;status:yes');
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
	                txtPLCofDischarge.SetDataText(aValue[3]); 
	                txtPLCofDischargeCD.SetDataText(aValue[2]);  
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
	        case 12:// Notify
	            var desc;
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP"; //customs
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            { 
	                txtNotifyName.SetDataText(aValue[2]); 
	                txtNotifyCode.SetDataText(aValue[1]);  
	                txtNotifyPK.SetDataText(aValue[0]);  
	            }	
	        break
	        case 13:
	            var fpath = System.RootURL + "/form/ep/ei/epei00030_Get_Contract_info.aspx?CtrPKs=" + txtCtrPKtmp.text + "&Vendor=" + txtCusPK.text; //search contract
                aValue = System.OpenModal( fpath , 900 , 550, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {   
	                cboCurrency.value = aValue[4];
                    txtExRate.text = aValue[5];
                    txtExRateS.text = aValue[15];
                    cboTransport.value = aValue[14];
                    dtShipDate.value = aValue[8];
                    txtLocation.text = aValue[16];
                    txtPLCofLoadingCD.text = aValue[32];
                    txtPLCofDischargeCD.text = aValue[31];
                    cboPaymentTermS.value = aValue[9];
                    cboPaymentMethod.value = aValue[10];
                    cboCurrencyS.value = aValue[11];
                    cboPaymentTerm.value = aValue[10];
                    cboDiscount.value = aValue[13];
                    onDiscountChange()
                    txtCusName.value = aValue[20]; 
                    txtCusCode.value = aValue[19]; 
                    txtCusPK.value = aValue[30]; 
                    txtPaidName.value = aValue[24]; 
                    txtPaidCode.value = aValue[23]; 
                    txtPaidPK.value = aValue[38]; 
                    txtPaidAdd.value = aValue[13];
                    txtShipName.value = aValue[22];  
                    txtShipCode.value = aValue[21]; 
                    txtShipPK.value = aValue[37]; 
                    txtShipAdd.value = aValue[35];
                    txtCtrPK.text=aValue[0];
	            }	
	        break;
	    }
    }    
//=========================================================================        
    function onSave(index)
    {
        switch (index)
        {
            case 0:
                if (ValidateData(0)) 
                {
                    action='save';
                    dat_epei00030_1.Call('');
                }
            break;
            case 1:  // confirm
                if(ValidateDataConfirm(0))
                {
                    action ='confirm';
                    txtStatusNum.text=2; 
                    dat_epei00030_6.Call();
                }
            break;
        }
    }
//=========================================================================        
    function onNew(index)
    {
        switch(index)
        {    
            case 0:
                txtMasterPK.SetDataText("-1");
                dat_epei00030_1.StatusInsert(); 
                var s_name;
                s_name="<%=Session["USER_NAME"]%>";
                txtFullName.SetDataText(s_name);
                txtUserName.SetDataText("<%=Session["User_ID"]%>");  
                txtDept.SetDataText("<%=Session["DEPT_NAME"]%>");
                txtDeptPK.SetDataText("<%=Session["DEPT_PK"]%>");
                txtStatusNum.text="1";
                SetStatus("1");
                onChangeShipType();
                getExRate();
                txtStatus.text='';
                grdInvItem.ClearData();
                //dat_epei00030_4.Call('SELECT');
            break;           
        }        
    }
//=========================================================================        
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case 'dat_epei00030_1':
                txtStatus.text=txtTmp.text;
               
                if(action=='view')
                    SetStatus("4");
                else
                    SetStatus(txtStatusNum.text);
                
                if(action=='save')    
                    for(var i=1; i<grdInvItem.rows;i++)
                        if (grdInvItem.GetGridData(i,0)=='')
                            grdInvItem.SetGridText(i,G_tex_cinv_mst_a_pk,txtMasterPK.text);
                grdInvItem.SetRowStatus(grdInvItem.rows-1,'_');                     
                dat_epei00030_4.Call('');
            break;
            case 'dat_epei00030_3':
                dat_epei00030_1.Call('SELECT');
            break;  
            case 'dat_epei00030_4':
                grdInvItem.Subtotal(0,2,2,"13!14!15","",true,13,"Total");
                grdInvItem.SetGridText(grdInvItem.rows-1,1,'');
                grdInvItem.SetRowStatus(grdInvItem.rows-1,'_');   
                grdInvItem.GetGridControl().AutoSize(0,24,false,0);     
            break;    
            case 'dat_epei00030_5':            
                dat_epei00030_1.Call('SELECT');                
            break;     
            case 'dat_epei00030_6': 
                SetStatus(txtStatusNum.text);
                if(txtStatusNum.text=="2")
                    txtStatus.text="Approved";
                else
                    if(txtStatusNum.text=="3")
                        txtStatus.text="Cancelled";
                
                dat_epei00030_4.Call();
            break;
            case 'dat_epei00030_7':
                grdInvItem.SetGridText(rowchange, G_cnv_ratio, txtCnvRatio.text);
                onAfterEditting(G_u_price);
                if(is_unit_change==1) 
                    onAfterEditting(G_unit_packing);
            break; 
            case 'dat_epei00030_8':
                grdInvItem.SetGridText(rowchange, G_tran_rate, txtTran_rate.text);
                grdInvItem.SetGridText(rowchange,G_qty_packing,Number(grdInvItem.GetGridData(rowchange,G_qty))*Number(grdInvItem.GetGridData(rowchange,G_tran_rate)));                                   
                if(is_unit_change==1) 
                    onAfterEditting(G_unit_weight);
            break; 
            case 'dat_epei00030_9':
                is_unit_change=0;
                grdInvItem.SetGridText(rowchange, G_weight_rate, txtTran_rate.text);
                grdInvItem.SetGridText(rowchange,G_net_weight,Number(grdInvItem.GetGridData(rowchange,G_qty))*Number(grdInvItem.GetGridData(rowchange,G_weight_rate)));                   
            break; 
            case 'datGetNewCode':
                var strdata = txtCodeTemp.text;
                
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
                        getExRate();
                    break;  
                    case 4:
                        cboCurrencyS.SetDataText(strdata);
                        cboCurrencyS.value=strcodereturn; // cboCurrencyS
                        getExRateS();
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
                        cboDiscount.SetDataText(strdata);
                        cboDiscount.value=strcodereturn; // cboDiscount
                    break;                            
                }
            break;         
        }    
    }
//=========================================================================        
     function onAfterEditting(colidx)
     {
//        var colidx;
//   
//        colidx= grdInvItem.col;
        
        if(colidx==G_unit_cd)
        {
            is_unit_change=1;
            rowchange=grdInvItem.row;
            txtUnit.text= grdInvItem.GetGridData(grdInvItem.row,G_unit_cd);
            dat_epei00030_7.Call();            
        }  
        
        if(colidx==G_unit_packing)
        {
            if(is_unit_change ==0) 
                rowchange=grdInvItem.row;
            txtItemPK.text = grdInvItem.GetGridData(grdInvItem.row,G_tco_item_pk);
            txtUnit.text= grdInvItem.GetGridData(grdInvItem.row,G_unit_cd);
            txtUnitTran.text= grdInvItem.GetGridData(grdInvItem.row,G_unit_packing);
            dat_epei00030_8.Call();
        }  
        
        if(colidx==G_unit_weight)
        {
            if(is_unit_change ==0)
                rowchange=grdInvItem.row;
            txtItemPK.text = grdInvItem.GetGridData(grdInvItem.row,G_tco_item_pk);
            txtUnit.text= grdInvItem.GetGridData(grdInvItem.row,G_unit_cd);
            txtUnitTran.text= grdInvItem.GetGridData(grdInvItem.row,G_unit_weight);
            dat_epei00030_9.Call();
        }  
        
        if (colidx==G_qty)
        {
            if (!isNaN(grdInvItem.GetGridData(grdInvItem.row,G_qty)))
            {
                if (Number(grdInvItem.GetGridData(grdInvItem.row,G_qty))>Number(grdInvItem.GetGridData(grdInvItem.row,G_remain)))
                {
                    alert("The remain number just " + grdInvItem.GetGridData(grdInvItem.row,G_remain));
                    grdInvItem.SetGridText(grdInvItem.row,G_qty,grdInvItem.GetGridData(grdInvItem.row,G_remain))
                }
                grdInvItem.SetGridText(grdInvItem.row,G_qty_packing,Number(grdInvItem.GetGridData(grdInvItem.row,G_qty))*Number(grdInvItem.GetGridData(grdInvItem.row,G_tran_rate)));                                   
                grdInvItem.SetGridText(grdInvItem.row,G_net_weight,Number(grdInvItem.GetGridData(grdInvItem.row,G_qty))*Number(grdInvItem.GetGridData(grdInvItem.row,G_weight_rate)));                   
            }
        }
        
        if ((colidx==G_u_price)||(colidx==G_qty)) //Price, Qty.
        {               
           if ((!isNaN(grdInvItem.GetGridData(grdInvItem.row,G_qty))) && (!isNaN(grdInvItem.GetGridData(grdInvItem.row,G_u_price))) )
              if (!isNaN(grdInvItem.GetGridData(grdInvItem.row,G_cnv_ratio)))
               {
                   grdInvItem.SetGridText(grdInvItem.row,G_ex_price,Number(grdInvItem.GetGridData(grdInvItem.row,G_u_price))*Number(grdInvItem.GetGridData(grdInvItem.row,G_qty))/Number(grdInvItem.GetGridData(grdInvItem.row,G_cnv_ratio)));
                   grdInvItem.SetGridText(grdInvItem.row,G_tr_amt,Number(grdInvItem.GetGridData(grdInvItem.row,G_retouch_amt))+Number(grdInvItem.GetGridData(grdInvItem.row,G_ex_price)));
               }
              else
               {
                   grdInvItem.SetGridText(grdInvItem.row,G_ex_price,Number(grdInvItem.GetGridData(grdInvItem.row,G_u_price))*Number(grdInvItem.GetGridData(grdInvItem.row,G_qty)));
                   grdInvItem.SetGridText(grdInvItem.row,G_tr_amt,Number(grdInvItem.GetGridData(grdInvItem.row,G_retouch_amt))+Number(grdInvItem.GetGridData(grdInvItem.row,G_ex_price)));
               }
        } 
        if (colidx==G_retouch_amt) //	Retouch Amt 
        {                
           if(!isNaN(grdInvItem.GetGridData(grdInvItem.row,G_retouch_amt)))
           {           
               grdInvItem.SetGridText(grdInvItem.row,G_tr_amt,Number(grdInvItem.GetGridData(grdInvItem.row,G_retouch_amt))+Number(grdInvItem.GetGridData(grdInvItem.row,G_ex_price)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdInvItem.SetGridText(grdInvItem.row,G_retouch_amt,'')
              grdInvItem.SetGridText(grdInvItem.row,G_tr_amt,Number(grdInvItem.GetGridData(grdInvItem.row,G_retouch_amt))+Number(grdInvItem.GetGridData(grdInvItem.row,G_ex_price)));
           }           
        } 
        Total();
        grdInvItem.Subtotal(0,2,2,"13!14!15","",true,13,"Total");
        grdInvItem.SetGridText(grdInvItem.rows-1,1,'');
        grdInvItem.GetGridControl().AutoSize(0,24,false,0);
     }
//=========================================================================        
    function onDelete(index)
    {
        switch (index)
        {
            case 0:
                if(confirm('Do you want to delete this invoice ?'))
	            {
	                dat_epei00030_1.StatusDelete();
	                dat_epei00030_1.Call('');
	            }    
            break;
        }
    }
//=========================================================================        
    function ValidateData(index)
    {
        switch(index)
        {
            case 0:
                if(txtCusPK.text=='' )
                {
                    alert("You must input Vendor!");
                    return false;
                }
                if(txtInvoiceNo.text=='')
                {
                    alert("You must input Invoice No!");
                    return false;
                }
                return true;
            break;
        }
    }
//=========================================================================        
    function ValidateDataConfirm(index)
    {
        switch(index)
        {
            case 0:
                if(grdInvItem.rows<=1)
                {
                    alert("You must input detail!");
                    return false;
                }
                for(i=0; i<grdInvItem.rows;i++)
                {
                    if((grdInvItem.GetGridData(i,10)=='')&& (i!=grdInvItem.rows-1))
                    {
                        alert("You must input qty at row " + (i));
                        return false;
                    }
                    if((grdInvItem.GetGridData(i,9)=='')&& (i!=grdInvItem.rows-1))
                    {
                        alert("You must input price at row " + (i));
                        return false;
                    }
                }
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
                 if(txtPLCofLoadingCD.text=='')
                 {
                    alert("You must input place of loading!");
                    return false;
                 }
                 if(txtPLCofDischargeCD.text=='')
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
    //--------------------------------------------------------------------------------------
    function onChangeShipType()
    {
        if (radShipType.value=='a')
            dat_epei00030_2.Call('SELECT');
    }
    //--------------------------------------------------------------------------------------
    function Total()
    {
        var tlvalue;
        tlvalue=0;
        for (var i=1; i< grdInvItem.rows; i++)
           tlvalue = tlvalue + Number(grdInvItem.GetGridData(i,15));
            
        txtTrAmount.SetDataText('' + tlvalue);
    }    
    //----------------------------------------------------------
    function OnCheckTab()
    {
        var index;
        index=idTab.GetCurrentPageNo();   
        if(index==1)         
            dat_epei00030_12.Call();
    }
    //--------------------------------------------------------------
    function onCopy()
    {                      
        action='Copy';
        txtType.text=1;
        dat_epei00030_5.Call();
    }
   //-----------------------------------------------------------------------
    function onRegenerate()
    {
        action='Regenerate';
        txtType.text=2;
        
        dat_epei00030_5.Call();
    }
    //-----------------------------------------------------------------------
    function onCancel()
    {
        txtStatusNum.text='3';
        
	    dat_epei00030_6.Call();
    }
    //-----------------------------------------------------------------------
    function getExRate()
    {    
	    dat_epei00030_11.Call();
    }
    //-----------------------------------------------------------------------
    function getExRateS()
    {    
	    dat_epei00030_12.Call();
    }
    //--------------------------------------------------------------
    function getCurrBooking()
    {    
	    var url =  System.RootURL + "/form/ep/ac/AjaxFile.aspx?type=1" ;
	    ajax_test2 = null;
	   
	    ajax_test2 = GetXmlHttpRequest(returnCurrBooking);
	    ajax_test2.open("GET", url , true);
	    ajax_test2.send(null); 
    }
    //-------------------------------------------------------------
    function returnCurrBooking()
    {
        if(GetRequestState(ajax_test2))
	    {		   
	        strdata = ajax_test2.responseText;	 		         
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
                scode='IEBD0050'; // cboDiscount
            break;                 
        }
        txtComCodeID.text = scode;
        var fpath = System.RootURL + "/form/fp/ab/PopUpChangeCommonCode.aspx?code=" + scode ;
       
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
                        getExRate();
                    break;  
                    case 4:
                        cboCurrencyS.value=strcodereturn; // cboCurrencyS
                        getExRateS();
                    break;  
                    case 5:
                        cboPaymentMethod.value=strcodereturn; // cboPaymentMethod
                    break;
                    case 6:
                        cboTransport.value=strcodereturn; // cboTransport
                    break; 
                    case 7:
                        cboDiscount.value=strcodereturn; // cboDiscount
                    break;               
                }            
            }
        }	     
    }
    //------------------------------------------------------------------------------------------    
    function OnLoadNew(scode)
    {	
        datGetNewCode.Call('SELECT');
//	    var t=new Date()
//	    var url =  System.RootURL + "/form/ep/bp/epbp00020_searchidcode.aspx?id=" + scode;
//	    ajax_test3 = null;
//	    ajax_test3 = GetXmlHttpRequest(return_result);
//	    ajax_test3.open("GET", url , true);
//	    ajax_test3.send(null);
    }
    //--------------------------------------------------------------------------------------------
    function return_result()
    {	        
	    if(GetRequestState(ajax_test3))
	    {
	        strdata = ajax_test3.responseText;	
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
                    getExRate();
                break;  
                case 4:
                    cboCurrencyS.SetDataText(strdata);
                    cboCurrencyS.value=strcodereturn; // cboCurrencyS
                    getExRateS();
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
                    cboDiscount.SetDataText(strdata);
                    cboDiscount.value=strcodereturn; // cboDiscount
                break;                            
            }
	    }
    }
    //------------------------------------------------------------------------------------------
    function onPrint()
    {
//        var  url= System.RootURL + "/reports/ep/ei/rpt_epei00030_invc.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value;
        if(cboPaymentMethod.value=='03')
            var  url= System.RootURL + "/reports/ep/ei/samil_epei00030_lc.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value; // samil
        else             
            var  url= System.RootURL + "/reports/ep/ei/samil_rpt_imvoice_00030.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value; // samil
        System.OpenTargetPage( url, "_blank" );
    }
    //------------------------------------------------------------------------------------------
    function onDiscountChange()
    {
        var tmp;
        tmp = (Number(cboDiscount.value)/100)*Number(txtTrAmount.text);
        txtDiscAmount.SetDataText("'"+tmp);
    }
</script>  
<body >
  <!--------------------------------------------------------------------------->
<gw:data id="dat_epei00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,35,36,37,38,39,40,43,44,45,46,47,48,49" function="imex.sp_sel_tex_cinv_mst_a"  procedure="IMEX.sp_upd_tex_cinv_mst_a"> 
            <inout> 
                 <inout  bind="txtMasterPK" />
                 <inout  bind="txtShipAdd" />   
                 <inout  bind="txtPaidAdd" />
                 <inout  bind="dtInvoiceDate" />
                 <inout  bind="txtInvoiceNo" />
                 <inout  bind="txtContractNo" />            
                 <inout  bind="txtExRate" />
                 <inout  bind="txtItemOrigin" />
                 <inout  bind="txtOrderNo" />
                 <inout  bind="cboCurrencyS" /> 
                 <inout  bind="txtExRateS" />
                 <inout  bind="cboPaymentMethod" />
                 <inout  bind="cboPaymentTerm" />
                 <inout  bind="txtPLCofDischargeCD" />
                 <inout  bind="txtPLCofLoadingCD" />  
                 <inout  bind="dtShipDate" />               
                 <inout  bind="txtStatusNum" /> 
                 <inout  bind="txtCusPK" /> 
                 <inout  bind="txtShipPK" />
                 <inout  bind="txtPaidPK" />
                 <inout  bind="txtTrAmount" />   
                 <inout  bind="cboCurrency" />
                 <inout  bind="txtLocation" />  
                 <inout  bind="cboPaymentTermS" />                 
                 <inout  bind="cboTransport" />
                 <inout  bind="cboCompany" />
                 <inout  bind="txtTmp" />  
                 <inout  bind="txtCusCode" />               
                 <inout  bind="txtCusName" />
                 <inout  bind="txtShipCode" />               
                 <inout  bind="txtShipName" /> 
                 <inout  bind="txtPaidCode" />               
                 <inout  bind="txtPaidName" />
                 <inout  bind="txtPLCofDischarge" />
                 <inout  bind="txtPLCofLoading" />  
                 <inout  bind="txtLCNo" />                   
                 <inout  bind="dtLCDate" />
                 <inout  bind="txtCarrierCode" />               
                 <inout  bind="txtCarrierName" />
                 <inout  bind="txtNotifyPK" />
                 <inout  bind="txtRemark" />
                 <inout  bind="txtNotifyCode" />
                 <inout  bind="txtNotifyName" />
                 <inout  bind="txtDescofgood" />
                 <inout  bind="txtManMarks" />
                 <inout  bind="txtLCMarks" />
                 <inout  bind="txtPackingMarks" /> 
                 <inout  bind="txtMarks" />
                 <inout  bind="txtDiscAmount" />
                 <inout  bind="txtCtrPK" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------Get Company Info -------------------------------------->
<gw:data id="dat_epei00030_2"  onreceive="OnDataReceive(this)" > 
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
<!------------------------Get Invoice PK -------------------------------------->
<gw:data id="dat_epei00030_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,43" function="imex.sp_sel_get_ex_invoice_pk"  > 
            <inout> 
                 <inout  bind="txtInvoiceNo" />
                 <inout  bind="txtMasterPK" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------->
<gw:data id="dat_epei00030_4"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24" function="IMEX.sp_sel_ex_cinvoice_dtl"   procedure="imex.sp_upd_tex_cinv_dtl_master_b"> 
                <input bind="grdInvItem">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdInvItem" /> 
            </dso> 
        </xml> 
</gw:data>
 <!-------------------------------Copy/Regenarate------------------------------------>
<gw:data id="dat_epei00030_5" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_tex_inv_mst_copy_regen" > 
            <input>
                <input bind="txtMasterPK" />
            </input> 
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Confirm/Cancel------------------------------------>
<gw:data id="dat_epei00030_6" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_tex_inv_mst_action" > 
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
<!-------------------------------get current ratio------------------------------------>
<gw:data id="dat_epei00030_7" onreceive="OnDataReceive(this)"> 
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
<!-------------------------------get packing unit tran ----------------------------------------------->
<gw:data id="dat_epei00030_8" onreceive="OnDataReceive(this)"> 
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
<!-------------------------------get weight unit tran ----------------------------------------------->
<gw:data id="dat_epei00030_9" onreceive="OnDataReceive(this)"> 
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
<!-------------------------------get exrate----------------------------------------------->
<gw:data id="dat_epei00030_11" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_epac00010_get_rate" > 
            <input>   
                <input bind="dtInvoiceDate" />
                <input bind="cboCurrency" />
            </input> 
            <output>
                <output bind="txtExRate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get exrate----------------------------------------------->
<gw:data id="dat_epei00030_12" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_epac00010_get_rate" > 
            <input>   
                <input bind="dtInvoiceDate" />
                <input bind="cboCurrencyS" />
            </input> 
            <output>
                <output bind="txtExRateS" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
    <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_new_commoncode" > 
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
    <form id="form1" runat="server">
        <gw:tab id="idTab" onpageactivate="return OnCheckTab()"  style="width: 100%; height: 220; border1px">
            <table id="InvoiceInfo" name="Invoice Info" width="100%" cellpadding="0" cellspacing="0" border=0>
                <tr>
                    <td colspan="13">
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>                                
                                <td width="11%">Company</td>
                                <td width="15%"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                                <td width="7%" align="center">Status</td>
                                <td width="15%"><gw:label id="txtStatus"  text=""  styles='width:100%;color:red; font-weight:700;' csstype="mandatory" /></td>
                                <td width="40%"> &nbsp;</td>
                                <td width="1%"><gw:imgbtn id="btnSearch" img="popup" alt="Open form to search" text="Search" onclick="openPopup(5)" /></td>
                                <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" /></td>
                                <td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                                <td width="1%"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                                <td width="1%"><gw:imgbtn id="btnExcel" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                                <td width="1%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onSave(1)" /></td>
                                <td width="1%"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onCancel()" /></td>
                                <td width="1%"><gw:imgbtn id="btnRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate()" /></td>
                                <td width="1%"><gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy()" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr> 
                    <td width="8%"><a title="Click here to select Vendor" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF">Vendor Name</a></td>
                    <td width="15%"><gw:textbox id="txtCusCode"  text=""  styles='width:100%;' csstype="mandatory" /><gw:textbox id="txtCusPK"  text=""  styles='display:none'  /></td>
                    <td colspan="5"><gw:textbox id="txtCusName"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                    <td width="1%"></td>
                    <td width="10%"><a title="Click here to select Trans. Currency" onclick="AddCommonCode(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Trans. Currency</b></a></td>
                    <td width="1%"></td>
                    <td width="10%"><gw:list id="cboCurrency" styles="width:100%;" onchange="getExRate();"></gw:list></td> 
                    <td width="5%"><gw:label id="lbCurr"  text=""  styles='width:100%;'/></td>
                    <td width="10%"></td>
                </tr>
                <tr>
                    <td nowrap>Contract No</td>
                    <td width="20%" colspan="2" ><gw:textbox id="txtContractNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                    <td width="1%"></td>
                    <td width="8%">Invoice No</td>
                    <td width="1%"></td>
                    <td width="15%"><gw:textbox id="txtInvoiceNo"  text=""  styles='width:100%;' csstype="mandatory" onenterkey="dat_epei00030_3.Call('SELECT');" /></td>
                    <td width="1%"></td>
                    <td width="6%">Ex. Rate</td>
                    <td width="1%"></td>
                    <td width="7%"><gw:textbox id="txtEachCur"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;display:none'/></td>
                    <td colspan="2"><gw:textbox id="txtExRate"  text="1" type="number" format="#,###,###,###,###.##R" styles='width:100%;'/></td>
                </tr>
                <tr>
                    <td>Order No</td>
                    <td colspan="2"><gw:textbox id="txtOrderNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                    <td width="1%"></td>
                    <td width="8%">Invoice Date</td>
                    <td width="1%"></td>
                    <td width="5%"><gw:datebox id="dtInvoiceDate" lang="1" onchange="returnExRate();"/></td>
                    <td width="1%"></td>
                    <td width="6%">Trans. Amount </td>
                    <td width="1%"></td>
                    <td colspan="3" width="6%"><gw:textbox id="txtTrAmount" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>                    
                </tr>
                <tr>
                    <td>Remark</td>
                    <td colspan="12"><gw:textbox id="txtRemark"  text=""  styles='width:100%;' /></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td width="15%"></td>
                    <td></td>
                    <td width="1%"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td width="1%"></td>
                    <td width="1%"></td>
                    <td width="1%"></td>
                    <td width="8%"></td>
                    <td align="right" width="2%"><gw:imgbtn id="btnPopup" img="popup" alt="Click to select Item" text="Click to select Item" onclick="openPopup(4)" /></td>
                </tr>
                <tr>
                    <td colspan="13">
                        <%--'0._Pk|1.Contr No|2.Order No|3.Item Code|4.Item Name|5.Hs Code|6.Unit|7.U/Price|8.Qty
                        |9.Ext. Price|10.Retouch Amt|11.Tr Amt|12._Tim_Cinv_Mst_A_Pk|13._Tim_Contr_Dtl_Pk
                        |14._Tco_Item_Pk|15._Tim_Contr_Mst_Pk|16._Tim_Order_Pk|17._Order_Yn|18._remain|19._cnv_ratio'--%>
                        <gw:grid id='grdInvItem'
                            header='_Pk|Contr No|Order No|Item Code|Item Name|Hs Code|Unit|Unit Packing|Unit Wt|U/Price|Qty|Qty. Packing|Net Wt|Ext. Price|Retouch Amt|Tr Amt|_Tim_Cinv_Mst_A_Pk|_Tim_Contr_Dtl_Pk|_Tco_Item_Pk|_Tim_Contr_Mst_Pk|_Tim_Order_Pk|_Order_Yn|_remain|_cnv_ratio|_pack_tran_rate|_weight_tran_rate'
                            format='0|0|0|0|0|0|2|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            aligns='0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0'
                            defaults='|||||||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|1|1|1|0|1|1|1|0|1|0|1|1|1|1|1|0|0|0|0|0'
                            widths='0|1500|1500|1500|2000|1300|1000|1500|1000|1000|1000|1000|1500|1300|1500|1000|0|0|0|0|0|0|0|0|0|0'
                            sorting='T'
                            onafteredit="onAfterEditting(this.col)"
                            styles='width:100%; height:280'
                        />
                    </td>
                </tr>
            </table>  
            <table id="Shipment/Payment" name="Shipment/Payment" cellpadding=0 cellspacing=0 width="100%">
                 <tr>
                    <td colspan="3">
                        <table width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="98%"></td>
                                <td align=right><gw:imgbtn id="btnSearchCtr" img="popup" alt="Search Contract info" text="Search Contract info" onclick="openPopup(13)" /></td>
                                <td align=right><gw:imgbtn id="btnSave1" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>            
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr valign="top">
                    <td width="48%">
                    <fieldset style="padding: 5">
                        <legend ><font color="black"  >&nbsp;&nbsp;&nbsp;Shipment Information</font></legend>
                        <table width="100%" border=0 cellpadding=0 cellspacing=0>                           
                            <tr>
                                <td height="10"></td>
                                <td colspan="2">
                                    <gw:radio id="radShipType" value="a" styles="width:100%" onchange="onChangeShipType()"> 
                                        <span value="a">Us/Customer </span> 
                                        <span value="b">Consignee</span> 
                                    </gw:radio>
                                </td>
                                <td> </td>
                            </tr>
                            <tr> 
                                <td width="27%"><a title="Click here to select" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF">Ship To</a></td>
                                <td width="10%"><gw:textbox id="txtShipCode" csstype="mandatory"  styles="width:100%;" /><gw:textbox id="txtShipPK"   styles="display:none" /></td>
                                <td colspan="2" width="60%"><gw:textbox id="txtShipName"  csstype="mandatory" styles="width:100%;" /></td>
                            </tr>
                            <tr>  
                                <td>&nbsp;</td>
                                <td colspan="3"><gw:textarea id="txtShipAdd" csstype="mandatory" rows="5" styles="width:100%;" /></td>
                            </tr>
                            <tr>
                                <td><a title="Click here to select Transportation By" onclick="AddCommonCode(6)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Transportation By</b></a></td>
                                <td colspan="3"><gw:list id="cboTransport"   styles="width:100%;" /></td>
                            </tr>
                            <tr>
                                <td>Shipment Date</td>
                                <td><gw:datebox id="dtShipDate" lang="1" onchange=""  styles="width:100%;" /></td>
                                <td> </td>
                                <td> </td>
                            </tr>
                            <tr>
                                <td><a title="Click here to select Location" onclick="openPopup(11)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Location</b></a></td>
                                <td colspan="3"><gw:textbox id="txtLocation"   styles="width:100%;" /></td>
                            </tr>
                            <tr>
                                <td><a title="Click here to select Place of Loading" onclick="openPopup(9)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Loading</b></a></td>
                                <td colspan="3"><gw:textbox id="txtPLCofLoading"  csstype="mandatory" styles="width:100%;" /><gw:textbox id="txtPLCofLoadingCD"  csstype="mandatory" styles="display:none" /></td>
                            </tr>
                            <tr> 
                                <td><a title="Click here to select Place of Discharge" onclick="openPopup(10)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Discharge</b></a></td>
                                <td colspan="3"><gw:textbox id="txtPLCofDischarge" styles="width:100%;" /><gw:textbox id="txtPLCofDischargeCD" styles="display:none" /></td>
                            </tr>  
                            <tr>
                                <td><a title="Click here to select Trade Terms" onclick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Trade Terms</b></a></td>
                                <td colspan="3"><gw:list id="cboPaymentTermS" styles="width:100%;"></gw:list></td>
                            </tr>
                        </table>
                    </fieldset> 
                    </td>
                    <td width="2%"></td>
                    <td width="50%">
                    <fieldset style="padding: 5">
                        <legend ><font color="black"  >Payment Information</font></legend>
                        <table width="100%" cellpadding=0 cellspacing=0 border=0>
                            <tr>
                                <td height="10"></td>
                                <td colspan="5">
                                    <gw:radio id="radPayType" value="a" styles="width:100%" onchange=""> 
                                        <span value="a">Vendor </span> 
                                        <span value="b">Other</span> 
                                    </gw:radio>
                                </td>
                            </tr> 
                            <tr> 
                                <td width="25%"><a title="Click here to select" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF">Paid To</a> </td>
                                <td width="25%"><gw:textbox id="txtPaidCode"  csstype="mandatory" styles="width:100%;" /><gw:textbox id="txtPaidPK"   styles="display:none" /></td>
                                <td colspan="4" width="20%"><gw:textbox id="txtPaidName" csstype="mandatory"  styles="width:100%;" /></td>                                            
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td colspan="5" ><gw:textarea id="txtPaidAdd" csstype="mandatory" rows="5" styles="width:100%;" /></td>
                            </tr> 
                            <tr>
                                <td>L/C No.</td>    
                                <td><gw:textbox id="txtLCNo"   styles="width:100%;" /></td>                                
                                <td></td>
                                <td width="16%">L/C Date</td>
                                <td colspan="2"><gw:datebox id="dtLCDate" lang="1"  styles='width:100%;'/></td>
                            </tr>
                            <tr>
                                <td><a title="Click here to select Payment Method" onclick="AddCommonCode(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Method</b></a></td>
                                <td><gw:list id="cboPaymentMethod" styles="width:100%;"></gw:list></td>                                
                                <td></td>
                                <td width="16%">Bank Account</td>
                                <td colspan="2"><gw:textbox id="txtAccountBank"   styles="width:100%;" /></td>
                            </tr>
                            <tr>
                                <td><a title="Click here to select Payment Currency" onclick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Currency</b></a></td>
                                <td><gw:list id="cboCurrencyS" styles="width:100%;" onchange="getExRateS();"></gw:list></td>
                                <td width="8%"><gw:label id="lbCurrS"   styles="width:100%;" /></td>
                                <td>Ex. Rate</td>
                                <td width="10%"><gw:textbox id="txtEachCurS" text="1"  styles="width:100%;display:none" /></td>
                                <td width="15%"><gw:textbox id="txtExRateS" type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td> 
                            </tr>
                            <tr>
                                 <td><a title="Click here to select Payment Term" onclick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Term</b></a></td>
                                 <td colspan="5"><gw:list id="cboPaymentTerm" styles="width:100%;"></gw:list></td>                                             
                            </tr>
                             
                            <tr>
                                <td><a title="Click here to select Discount on Payment" onclick="AddCommonCode(7)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Discount on Payment</b></a></td>
                                <td><gw:list id="cboDiscount" onchange="onDiscountChange();" styles="width:100%;" /></td>
                                <td></td>
                                <td>Disc. Amount</td>
                                <td colspan="2"><gw:textbox id="txtDiscAmount"  type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td>
                            </tr>                                       
                        </table>
                    </fieldset> 
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="padding: 5">
                            <legend >Carrier</legend>
                            <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                <tr> 
                                    <td width=23%>Code</td> 
                                    <td width=76%><gw:textbox id="txtCarrierCode"   styles="width:100%;" /></td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td width=70%><gw:textbox id="txtCarrierName"   styles="width:100%;" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <td></td>
                    <td>
                        <fieldset style="padding: 5">
                            <legend ><a title="Click here to select Notify Party" onclick="openPopup(11)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Notify Party</b></a></legend>
                            <table width=100% cellpadding=0 cellspacing=0 border=0 >
                                <tr> 
                                    <td width=25%>Code</td> 
                                    <td width=75%><gw:textbox id="txtNotifyCode"   styles="width:100%;" /><gw:textbox id="txtNotifyPK"   styles="display:none" /></td>
                                </tr>
                                <tr>
                                    <td>Name</td>
                                    <td width=70%><gw:textbox id="txtNotifyName"   styles="width:100%;" /></td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding=0 cellspacing=0 name="Descriptions">
                <tr>
                    <td colspan="2">
                        <table width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="99%"></td>
                                <td width="1%"><gw:imgbtn id="btnSaveDesc" img="save" alt="Save" text="Save" onclick="onSave(1)" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="12%" nowrap >Description of good</td>
                    <td width="93%"><gw:textarea id="txtDescofgood" styles="width:100%;" rows="2"  /></td>
                </tr>  
                <tr>
                    <td>Manufacture Marks</td>
                    <td><gw:textarea id="txtManMarks" styles="width:100%;" rows="4"  /></td>
                </tr>
                <tr>
                    <td>LC Marks</td>
                    <td><gw:textarea id="txtLCMarks" styles="width:100%;" rows="3"  /></td>
                </tr>
                <tr>
                    <td>Packing Marks</td>
                    <td><gw:textarea id="txtPackingMarks" styles="width:100%;" rows="2"  /></td>
                </tr>
                <tr>
                    <td>Marks</td>
                    <td><gw:textarea id="txtMarks" styles="width:100%;" rows="5"  /></td>
                </tr>
            </table>
        </gw:tab> 
    </form> 
</body>
<gw:textbox id="txtStatusNum"  text="1"  styles='display:none' />
<gw:textbox id="txtMasterPK"  text=""  styles='display:none' />
<gw:textbox id="txtItemOrigin"  text=""  styles='display:none' /> 
<gw:textbox id="txtCom_pk"  text=""  styles='display:none' /> 
<gw:textbox id="txtType"  text=""  styles='display:none' /> 
<gw:textbox id="txtDept"  text=""  styles='display:none;'/>
<gw:textbox id="txtDeptPK"  text=""  styles='display:none;' />
<gw:textbox id="txtUserName"  text=""  styles='display:none' />
<gw:textbox id="txtFullName"  text=""  styles='display:none' /> 
<gw:textbox id="txtTmp"  text=""  styles='display:none' />
<gw:textbox id="txtUnit"  text=""  styles='display:none' />
<gw:textbox id="txtCnvRatio"  text=""  styles='display:none' /> 
<gw:textbox id="txtCtrPK"  text=""  styles='display:none' />
<gw:textbox id="txtCtrPKtmp"  text=""  styles='display:none' />
<gw:textbox id="txtUnitTran"  text=""  styles='display:none'  />  
<gw:textbox id="txtTran_rate"  text=""  styles='display:none'  />
<gw:textbox id="txtItemPK"  text=""  styles='display:none'  />
<gw:textbox id="txtComCodeID"  text=""  styles='display:none'  />
<gw:textbox id="txtCodeTemp"  text=""  styles='display:none'  />
</html>
