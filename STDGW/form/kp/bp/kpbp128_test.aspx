﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>1.2.8 Main Contract Request</title>
</head>
<%ESysLib.SetUser("EC111")%>
<script>
var _Book_CCY = "VND";
var click_dr = 0;
var click_cr = 0;
//-----------------------------------------------------------------------------------------------------
function BodyInit()
{
	System.Translate(document);
    
	BindingDataList();
    grdDebit.GetGridControl().FrozenCols = 6;
	grdCredit.GetGridControl().FrozenCols = 6;
    
  //  var vendor5 = document.all("_5");
 //   vendor5.style.display = "none";
    OnNew('Master');
}
//=======================================================================================================
function BindingDataList()
{
	var _Company = "<%=Session("COMPANY_PK")%>"; 
	txtCompany_Pk.SetDataText(_Company);
	data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
    lstOrder_Ccy.SetDataText(data); 
    lstInvoice_Ccy.SetDataText(data); 
    lstBook_Ccy.SetDataText(data); 
    lstBook_Ccy.value='USD';
    lstOrder_Ccy.SetEnable(false);
    lstBook_Ccy.SetEnable(false);
	data = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0030' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>";
	lstReqType.SetDataText(data);
    lstReqType.value='';
	data = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('TPS0043') FROM DUAL")%>"; 
	lstPaymentMethod.SetDataText(data); 
    lstPaymentMethod.value='4';
	var _Book_CCY = "<%=ESysLib.SetDataSQL("select b.code, b.char_1  from tac_commcode_master a, tac_commcode_detail b where a.pk = b.tac_commcode_master_pk and a.id = 'ACBG0040' and b.def_yn = 'Y' and a.del_if = 0 and b.del_if = 0")%>";
    
	var a = _Book_CCY.split("|");
	if(a.length <=0) alert("Please setup book currency in common code.");
    _Book_CCY = a[0];
    txtbookccy.SetDataText(a[0]);

    lstCompany.SetDataText(data);
	lstCompany.value = "<%=session("company_pk") %>";
}
//=======================================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";

    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";

    }
}	
//=======================================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'dso_adv_deduct_can':
			if ( Number( txtAdvDeduct1_Amt.GetData()) > Number( txt_adv_deduct_can.GetData()))
			{
				alert('The advance deduct can not over ' +  txt_adv_deduct_can.GetData());
				txtAdvDeduct1_Amt.SetDataText(txt_adv_deduct_can.GetData());
				onChangemanual_amt();
			}
		break;
		case 'dso_upd_master':
            if(lblStatus.text == 'Confirm')
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				btnCancel.SetEnable(true);
				
//				btnNew_dr.SetEnable(false);	
				btnSave_dr.SetEnable(false);	
//				btnDelete_dr.SetEnable(false);	
//				btnNew_cr.SetEnable(false);	
				btnSave_cr.SetEnable(false);	
//				btnDelete_cr.SetEnable(false);	
			}
			else if(lblStatus.text == 'Cancel')
			{
				btnCancel.SetEnable(false);	
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				
//				btnNew_dr.SetEnable(false);	
				btnSave_dr.SetEnable(false);	
//				btnDelete_dr.SetEnable(false);	
//				btnNew_cr.SetEnable(false);	
				btnSave_cr.SetEnable(false);	
//				btnDelete_cr.SetEnable(false);	
			}
			else
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(true);
				btnDelete.SetEnable(true);
				btnConfirm.SetEnable(true);
				btnCancel.SetEnable(false);
				
//				btnNew_dr.SetEnable(true);	
				btnSave_dr.SetEnable(true);	
//				btnDelete_dr.SetEnable(true);	
				
//				btnNew_cr.SetEnable(true);	
				btnSave_cr.SetEnable(true);	
//				btnDelete_cr.SetEnable(true);	
			}
            DSO_ATTACH_FILE.Call('SELECT');
		break;
        case 'DSO_ATTACH_FILE':
            dso_get_rate_105.Call();
        break;
        case 'dso_get_customer_105':
            dso_get_AccountNo_auto.Call(); 
        break;
        case 'dso_get_AccountNo_auto':
            dso_get_rate_105.Call();
        break;
        
		case 'dso_dr':
            if(flag=='save'||flag=='delete')
            {
		          for(i=1;i<grdCredit.rows;i++)
                {
				    if(grdCredit.GetGridData(i,0) =='')
				    {
					    grdCredit.SetGridText(i, 0,1);
					    grdCredit.SetRowStatus(i, 0x20);
					    grdCredit.SetGridText( i, 13, txtMasterPK.GetData()); // 13 master pk
				    }
                }   
                  txtDRCRtype.text = 'C';
                  flag='save'; 
		          dso_cr.Call();
            }
            else
            {
                txtDRCRtype.text = 'C';
                dso_cr.Call('SELECT');
            }
		break;
		case 'dso_cr':
			if(flag=='save' || flag=='delete')
			{
                dso_upd_ctl_item.Call('SELECT');
			}
            
		break;
        case 'dso_upd_ctl_item':
				dso_search_master.Call('SELECT');
        break;
		case "dso_get_exrate_list":
            _book_rate = GetBookExRate(_Book_CCY);
        break;
		case 'dso_confirm':
			if(lblStatus.text == 'Confirm')
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				btnCancel.SetEnable(true);
				
//				btnNew_dr.SetEnable(false);	
				btnSave_dr.SetEnable(false);	
//				btnDelete_dr.SetEnable(false);	
//				btnNew_cr.SetEnable(false);	
				btnSave_cr.SetEnable(false);	
//				btnDelete_cr.SetEnable(false);	
			}
			else if(lblStatus.text == 'Cancel')
			{
				btnCancel.SetEnable(false);	
				btnSave.SetEnable(false);
				btnDelete.SetEnable(false);
				btnConfirm.SetEnable(false);
				
//				btnNew_dr.SetEnable(false);	
				btnSave_dr.SetEnable(false);	
//				btnDelete_dr.SetEnable(false);	
//				btnNew_cr.SetEnable(false);	
				btnSave_cr.SetEnable(false);	
//				btnDelete_cr.SetEnable(false);	
			}
			else
			{
				btnNew.SetEnable(true);
				btnSave.SetEnable(true);
				btnDelete.SetEnable(true);
				btnConfirm.SetEnable(true);
				btnCancel.SetEnable(false);
				
//				btnNew_dr.SetEnable(true);	
				btnSave_dr.SetEnable(true);	
//				btnDelete_dr.SetEnable(true);	
				
//				btnNew_cr.SetEnable(true);	
				btnSave_cr.SetEnable(true);	
//				btnDelete_cr.SetEnable(true);	
			}
		    if(flag=='save'||flag=='delete')
            {
                for(i=1;i<grdDebit.rows;i++)
                {
				    if(grdDebit.GetGridData(i,0) =='')
				    {
					    grdDebit.SetGridText(i, 0,1);
					    grdDebit.SetRowStatus(i, 0x20);
					    grdDebit.SetGridText( i, 13, txtMasterPK.GetData()); // 13 master pk
				    }
                }
                txtDRCRtype.text = 'D';
                flag='save';
                dso_dr.Call();
            }
            else
            {
                txtDRCRtype.text = 'D';
                dso_dr.Call('SELECT');
            }
		break;
        case 'dso_get_rate_Order':
            dso_get_rate_Invoice.Call();
        break;
        case 'dso_get_rate_Invoice':
		    OnCalc_Control();
            dso_get_rate_book.Call();
        break;
    }
}
//=======================================================================================================
function OnSumCR()
{
    var ctrl = grdCredit.GetGridControl();
    var sum_cr_famt = 0; 
    var sum_cr_amt  = 0;
    for (i = 1; i < ctrl.rows; i++)
	{
	     sum_cr_famt = sum_cr_famt + Number(grdCredit.GetGridData(i, 8));
	     sum_cr_amt  = sum_cr_amt  + Number(grdCredit.GetGridData(i, 9));
	}
	txtsum_total_cr_famt.text = "" + System.Round(sum_cr_famt,2);
	txtsum_total_cr_amt.text = "" + System.Round(sum_cr_amt,2);
}
//=======================================================================================================
function OnSumDR()
{
    var ctrl = grdDebit.GetGridControl();
    var sum_dr_famt = 0;
    var sum_dr_amt  = 0;
    for (i = 1; i < ctrl.rows; i++)
	{
	     sum_dr_famt = Number(sum_dr_famt) + Number(grdDebit.GetGridData(i, 8));
	     sum_dr_amt  = Number(sum_dr_amt)  + Number(grdDebit.GetGridData(i, 9));
	}
	txtsum_total_dr_famt.text = "" + System.Round(sum_dr_famt,2);
	txtsum_total_dr_amt.text = "" + System.Round(sum_dr_amt,2);
}
//=======================================================================================================
function RowEdit(obj)
{
	switch (obj)
	{
		case 'Dr':
			var dr_famt = 0;
			var dr_bamt = 0;
			var dr_rate = 0;
			var book_rate = 1;
			
			_book_rate = grdDebit.GetGridData(event.row, 24);
			if (event.col == 6 || event.col == 8 || event.col == 7)
			{
				//txtcur.text = grdDebit.GetGridData(event.row, 6);
				var ccy = grdDebit.GetGridData(event.row, 6);
				//txt_row.text = event.row;
				dr_famt = Number(grdDebit.GetGridData(event.row, 8));
				dr_bamt = Number(grdDebit.GetGridData(event.row, 9));
				book_rate = GetBookExRate(ccy);
			   if(event.col == 6)
			   {
					grdDebit.SetGridText(event.row, 7, book_rate);
			   }
				dr_rate = Number(grdDebit.GetGridData(event.row, 7));
				if(Number(grdDebit.GetGridData(grdDebit.row, 8))>0)
				{
					var book_amt = (Number(dr_famt*(dr_rate/_book_rate)));
					book_amt = System.Round(book_amt,2);
					grdDebit.SetGridText(event.row, 9, book_amt);
				}
				else
				{
					grdDebit.SetGridText(event.row, 9, Math.round(Number(dr_famt*(dr_rate/_book_rate))));
				}
			  
			}
		break;
		case 'Cr':
			var cr_famt = 0;
			var cr_bamt = 0;
			var cr_rate = 0;
			var book_rate = 1;
			
			_book_rate = grdCredit.GetGridData(event.row, 24);
			if (event.col == 6 || event.col == 8 || event.col == 7)
			{
				//txtcur.text = grdDebit.GetGridData(event.row, 6);
				var ccy = grdCredit.GetGridData(event.row, 6);
				//txt_row.text = event.row;
				dr_famt = Number(grdCredit.GetGridData(event.row, 8));
				dr_bamt = Number(grdCredit.GetGridData(event.row, 9));
				book_rate = GetBookExRate(ccy);
			   if(event.col == 6)
			   {
					grdCredit.SetGridText(event.row, 7, book_rate);
			   }
				dr_rate = Number(grdCredit.GetGridData(event.row, 7));
				if(Number(grdCredit.GetGridData(grdCredit.row, 8))>0)
				{
					var book_amt = (Number(dr_famt*(dr_rate/_book_rate)));
					book_amt = System.Round(book_amt,2);
					grdCredit.SetGridText(event.row, 9, book_amt);
				}
				else
				{
					grdCredit.SetGridText(event.row, 9, Math.round(Number(dr_famt*(dr_rate/_book_rate))));
				}
			  
			}
		break;	
	}
}
//=======================================================================================================
function OnSearch(obj)
{
	switch (obj)
	{
		case 'grid_master':
            if(txtProject_M.text!='')
            {
			    dso_search_master.Call('SELECT');
            }
            else
            {
                alert('Please select Project !!');
            }
		break;
		case 'control':
			txtMasterPK.text = grdMaster.GetGridData(grdMaster.row, 0);
			flag='search';
			dso_upd_master.Call('SELECT');
		break;	
	}
}
//=======================================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var obj = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( obj != null )
		    {
			    txtProject_Pk.text = obj[0];
                txtProject_Cd.text = obj[1];
                txtProject_Nm.text = obj[2];
                txtProject_M.text = obj[1];
                txttac_abplcenter_pk.text 		= obj[8];
                dso_get_customer_105.Call();
		    }
	    break;
        case 'Customer':
            var path = System.RootURL + '/form/kp/bp/kpbp128_popup_Customer.aspx?Project_Pk=' + txtProject_Pk.text;
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
				txtCustomer_Nm.SetDataText(obj[2]);//customer name
				txtCustomer_Pk.SetDataText(obj[0]);//customer name
				txtCustomer_Cd.SetDataText(obj[1]);
                dso_get_AccountNo_auto.Call(); 
            }
        break;   
        case 'Contract':
				var path = System.RootURL + '/form/kp/bp/kpbp128_popup_AccCont.aspx?TAC_ABPL_pk=' + txtProject_Pk.text;
				var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					txtContract.SetDataText(obj[1]);
					txtContract_Pk.SetDataText(obj[0]);
				}
		break;
        case 'RequestType':
			var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0030';
			var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (object != null )
             {
				 lstReqType.SetDataText(object[1]);
			 }

		break;
        case 'PMethod':
			var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0043';
			var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (object != null )
             {
				 lstPaymentMethod.SetDataText(object[1]);
			 }
		break;
        case 'currency':        
             var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	         var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (obj != null )
             {
				 lstOrder_Ccy.SetDataText(obj[1]);
			 }
        break; 
        case 'Edit_Dr':
			if(event.col == '4')
			{
				if(!CanChange()) return;
                var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
	            var aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');
		
	            if (aValue != null)
	            {
		            var tmp = aValue[0];
			        grdDebit.SetGridText( grdDebit.selrow, 1, tmp[1]);
			        grdDebit.SetGridText( grdDebit.selrow, 4, tmp[2]);
			        grdDebit.SetGridText( grdDebit.selrow, 5, tmp[3]);
	            }                                               
			}
		break;
		case 'Edit_Cr':
			if(event.col == '4')
			{
				if(!CanChange()) return;
                var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
	            var aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');
		
	            if (aValue != null)
	            {
		            var tmp = aValue[0];
			        grdCredit.SetGridText( grdCredit.selrow, 1, tmp[1]);//
			        grdCredit.SetGridText( grdCredit.selrow, 4, tmp[2]);//
			        grdCredit.SetGridText( grdCredit.selrow, 5, tmp[3]);//
	            }                                               
			}
		break;
		case 'PL_Unit_Dr':
			if(event.col == '12')
			{
				var fpath = System.RootURL + "/form/gf/gf/gfgf00050_1.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + txtCompany_Pk.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
				var object = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
				if ( object != null ) 
				{
					if (object[0] != 0)
					{
						grdDebit.SetGridText(grdDebit.row, 21, object[2]);
						grdDebit.SetGridText(grdDebit.row, 12, object[0] + ' - ' + object[1]);
					}
				}
			}
		break;
		case 'PL_Unit_Cr':
			if(event.col == '12')
			{
				var fpath = System.RootURL + "/form/gf/gf/gfgf00050_1.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + txtCompany_Pk.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
				var object = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
				if ( object != null ) 
				{
					if (object[0] != 0)
					{
						grdCredit.SetGridText(grdCredit.row, 21, object[2]);
						grdCredit.SetGridText(grdCredit.row, 12, object[0] + ' - ' + object[1]);
					}
				}
			}
		break;
		case 'Customer_Dr':
			if(event.col=='13')
			{
				var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
				var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					grdDebit.SetGridText(grdDebit.row, 22, obj[0]);
					grdDebit.SetGridText(grdDebit.row, 13, obj[1]+ ' - '+ obj[2]);
				}
			}
        break;   
		case 'Customer_Cr':
			if(event.col=='13')
			{
				var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
				var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					grdCredit.SetGridText(grdCredit.row, 22, obj[0]);
					grdCredit.SetGridText(grdCredit.row, 13, obj[1]+ ' - '+ obj[2]);
				}
			}
        break;   
        case 'Bank_Acc_1':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company=" + txtCompany_Pk.text + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txtBankAccNo1_Cd.text = object[3];//BANK ID
                    txtBankAccNo1_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txtBankAccNo1_Pk.text = object[2];
                }
            }
        break;
        case 'Bank_Acc_2':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company=" + txtCompany_Pk.text + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txtBankAccNo2_Cd.text = object[3];//BANK ID
                    txtBankAccNo2_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txtBankAccNo2_Pk.text = object[2];
                }
            }
        break;
        case 'BCCY':        
             var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	         var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (obj != null )
             {
				 lstBook_Ccy.SetDataText(obj[1]);
			 }
        break; 
        case 'Invoice':        
             var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	         var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (obj != null )
             {
				 lstInvoice_Ccy.SetDataText(obj[1]);
			 }
        break; 
    }
}
//------------------------------------------------------------------------------
function format_number(dec, fix) 
{
	fixValue = parseFloat(Math.pow(10,fix));
	rtn_value = parseInt(Math.round(dec * fixValue)) / fixValue;	
	return rtn_value ;
}
//=======================================================================================================
function RowClick_DR()
{
    if (grdDebit.rows < 2)
    {
        return;
    }
	else
	{
	    if (grdDebit.selrow < 1)
	    {
	        return;
	    }
	   
	    if ((grdDebit.rows > 1) && (grdDebit.selrow < grdDebit.rows) && (grdDebit.selrow != click_dr))
	    {
            for (i = 1; i < grdDebit.rows; i++)
            {
                if (grdDebit.selrow == i)
                {
	                grdDebit.SetCellBold(i,1,i,15,true);
	                grdDebit.SetRowEditable(i, true);
                }
                else
                {
	                grdDebit.SetCellBold(i,1,i,15,false);
	                grdDebit.SetRowEditable(i, false);
                }
            }
            txtacpk.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 1));
            txtTECPS_MCTREQUESTD_PK.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 0));
            txt_rowclick.text = grdDebit.selrow;
            txtDRCRtype.SetDataText('D');
            idGridItem.SetData("");
            click_dr = grdDebit.selrow;
            click_cr = 0;
            dso_upd_ctl_item.Call("SELECT");
        }
        
        OnCheckSumDR();
    }
}
//=======================================================================================================
function OnCheckSumDR()
{
	var ctrl 	    = grdDebit.GetGridControl();
	var sum_dr_famt = 0;
	var sum_dr_amt  = 0;
	for (i=1; i < ctrl.rows; i++)
	{
		var tmp = grdDebit.GetGridData(i, 2);
		if (tmp == '-1')
		{
			sum_dr_famt = Number(sum_dr_famt) + Number(grdDebit.GetGridData(i, 8));
			sum_dr_amt  = Number(sum_dr_amt)  + Number(grdDebit.GetGridData(i, 9));
		}
	}
	txtsum_chk_dr_famt.SetDataText(''   + sum_dr_famt);
	txtsum_chk_dr_amt.SetDataText(''    + sum_dr_amt);
	OnSumDR();
}
//=======================================================================================================
function OnNew(obj)
{
	switch (obj)
	{
		case 'Master':
			dso_upd_master.StatusInsert();	
            lstReqType.value='';
			btnNew.SetEnable(true);
			btnSave.SetEnable(true);
			btnDelete.SetEnable(true);
			
//			btnNew_dr.SetEnable(true);	
			btnSave_dr.SetEnable(true);	
//			btnDelete_dr.SetEnable(true);	
			
//			btnNew_cr.SetEnable(true);	
			btnSave_cr.SetEnable(true);	
//			btnDelete_cr.SetEnable(true);	
			
			btnCancel.SetEnable(false);	
			grdDebit.GridRefresh();
			grdCredit.GridRefresh();
            Grid_Attach.GridRefresh();
            dso_get_rate_Order.Call();
		break;
		case 'Debit':
			if(txtMasterPK.text != '')
			{
				var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
				var aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');
				if (aValue != null)
				{
					var tmp = aValue[0];
					grdDebit.AddRow();
					for(var i=1;i<grdDebit.rows;i++)
					{
						grdDebit.SetGridText(grdDebit.rows-1, 3, i);
					}
					grdDebit.SetGridText(grdDebit.rows-1, 1, txtMasterPK.text);
					
					grdDebit.SetGridText(grdDebit.rows-1, 23, 'D');
					grdDebit.SetGridText(grdDebit.rows-1, 22, txtCustomer_Pk.text);
					grdDebit.SetGridText(grdDebit.rows-1, 10, txtDescription.text);
					grdDebit.SetGridText(grdDebit.rows-1, 11, txtLocal_Description.text);
					grdDebit.SetGridText(grdDebit.rows-1, 2, tmp[1]);
					grdDebit.SetGridText(grdDebit.rows-1, 4, tmp[2]);
					grdDebit.SetGridText(grdDebit.rows-1, 5, tmp[3]);
					if (grdDebit.rows > 2)
					{
						var ls_curr = grdDebit.GetGridData(grdDebit.rows - 2, 6);
						var ls_rate = grdDebit.GetGridData(grdDebit.rows - 2, 7);
						grdDebit.SetGridText( grdDebit.rows - 1, 6, ls_curr);       //Rate
						grdDebit.SetGridText( grdDebit.rows - 1, 7, ls_rate);       //Rate
					}
					else
					{
						grdDebit.SetGridText( grdDebit.rows - 1, 7, '1');           //Rate
						grdDebit.SetGridText(grdDebit.rows-1, 6, lstCurrency.value);
					}    
					grdDebit.SetGridText( grdDebit.rows - 1, 24, GetBookExRate(_Book_CCY));
				}
			}
			else
			{
				alert('Please select Request No !!');	
			}
		break;
		case 'Credit':
			if(txtMasterPK.text != '')
			{
				var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
				var aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');
				if (aValue != null)
				{
					var tmp = aValue[0];
					var Sum_Amt_Tr = 0;
					var Sum_Amt_Bk = 0;
					grdCredit.AddRow();
					for(var i=1;i<grdCredit.rows;i++)
					{
						grdCredit.SetGridText(grdCredit.rows-1, 3, i);
					}
					grdCredit.SetGridText(grdCredit.rows-1, 1, txtMasterPK.text);
					
					grdCredit.SetGridText(grdCredit.rows-1, 22, txtCustomer_Pk.text);
					grdCredit.SetGridText(grdCredit.rows-1, 10, txtDescription.text);
					grdCredit.SetGridText(grdCredit.rows-1, 11, txtLocal_Description.text);
					grdCredit.SetGridText(grdCredit.rows-1, 23, 'C');
					grdCredit.SetGridText(grdCredit.rows-1, 2, tmp[1]);
					grdCredit.SetGridText(grdCredit.rows-1, 4, tmp[2]);
					grdCredit.SetGridText(grdCredit.rows-1, 5, tmp[3]);
					
					for(var i=1;i<grdDebit.rows;i++)
					{
						Sum_Amt_Tr += Number(grdDebit.GetGridData(i,8));
						Sum_Amt_Bk += Number(grdDebit.GetGridData(i,9)); 	
					}
					grdCredit.SetGridText(grdCredit.rows-1, 8, Sum_Amt_Tr);
					grdCredit.SetGridText(grdCredit.rows-1, 9, Sum_Amt_Bk);
					if (grdCredit.rows > 2)
					{
						var ls_curr = grdCredit.GetGridData(grdCredit.rows - 2, 6);
						var ls_rate = grdCredit.GetGridData(grdCredit.rows - 2, 7);
						grdCredit.SetGridText( grdCredit.rows - 1, 6, ls_curr);       //Rate
						grdCredit.SetGridText( grdCredit.rows - 1, 7, ls_rate);       //Rate
					}
					else
					{
						grdCredit.SetGridText( grdCredit.rows - 1, 7, '1');           //Rate
						grdCredit.SetGridText(grdCredit.rows-1, 6, lstCurrency.value);
					}    
					grdCredit.SetGridText( grdCredit.rows - 1, 24, GetBookExRate(_Book_CCY));
				}
			}
			else
			{
				alert('Please select Request No !!');	
			}
		break;
	}
}
//=======================================================================================================
function OnConfirm()
{
	if(txtMasterPK.text != '')
	{
        if(!OnCheckSum())
			{
		        if(confirm('Are you sure you want to confirm ?'))
		        {
			        txtConfirm.text = 'INSERT';
			        var MM = dtRequestDate.value;
			        var month = MM.substring(0,6);
			        txtMonth.text = month;
			        dso_confirm.Call();
		        }
            }
	}
	else
	{
		alert('Please select Request No to confirm !!');	
	}
}
//=======================================================================================================
function OnCancel()
{
	if(txtMasterPK.text != '')
	{
		if(confirm('Are you sure you want to cancel ?'))
		{
			txtConfirm.text = 'DELETE';
			var MM = dtRequestDate.value;
			var month = MM.substring(0,6);
			txtMonth.text = month;
			dso_confirm.Call();	
		}
	}
	else
	{
		alert('Please select Request No to cancel !!');	
	}
}
//=======================================================================================================
function OnCheckSum()
{
	var i = 0;
	var j = 0;
	var TotalTr_dr = 0;
	var TotalBk_dr = 0;
	
	var TotalTr_cr = 0;
	var TotalBk_cr = 0;
	for(i=1;i<grdDebit.rows;i++)
	{
		TotalTr_dr += format_number(Number(grdDebit.GetGridData(i, 8)),0);
		TotalBk_dr += format_number( Number(grdDebit.GetGridData(i, 9)),2);
	}
	for(i=1;i<grdCredit.rows;i++)
	{
		TotalTr_cr += format_number(Number(grdCredit.GetGridData(i, 8)),0);
		TotalBk_cr += format_number( Number(grdCredit.GetGridData(i, 9)),2);
	}
	/*var df1=  Number(TotalTr_dr) -  Number(TotalTr_cr);
	if( df1 != 0)
	{
		alert('The debit amount and credit amount must be same !!');	
        return true;
	}*/
//    return false;
}
//=======================================================================================================
function SumAmt()
{
    var i = 0;
	var VATTr_dr = 0;
	var VATBk_dr = 0;
	var Total_Tr = 0;
	var Total_Bk = 0;
	var Net_dr_tr = 0;
	var Net_dr_bk = 0;
    var _Deduc = 0;
    var _Deduc_Bk = 0;
    var _Retention = 0;
    var _Retention_Bk = 0;
    var _Whithout = 0;
    var _Whithout_Bk = 0;
	for(i=1;i<grdDebit.rows;i++)
	{
            _Deduc += Math.round(Number(grdDebit.GetGridData(i, 8)));
            _Deduc_Bk += Number(grdDebit.GetGridData(i, 9));
            _Retention += Number(grdDebit.GetGridData(i, 8));
            _Retention_Bk += Number(grdDebit.GetGridData(i, 9));
			Net_dr_tr += Math.round(Number(grdDebit.GetGridData(i, 8)));
			Net_dr_bk += Number(grdDebit.GetGridData(i, 9));
            VATTr_dr += Math.round(Number(grdDebit.GetGridData(i, 8)));
            VATBk_dr += Number(grdDebit.GetGridData(i, 9));
            _Whithout += Math.round(Number(grdDebit.GetGridData(i, 8)));
            _Whithout_Bk += Number(grdDebit.GetGridData(i, 9));
	}
        if(grdDebit.GetGridData(grdDebit.row,25) == 'Y')
        {
            txtDeduction_F.text = _Deduc; 
            txtDeduction.text = _Deduc_Bk;
        }
        else
        {
            txtDeduction_F.text = 0; 
            txtDeduction.text = 0;
        }
        if(grdDebit.GetGridData(grdDebit.row,26) == 'Y')
        {
            txtRetention_F.text = _Retention;
            txtRetention.text = _Retention_Bk;
        }  
        else
        {
            txtRetention_F.text = 0;
            txtRetention.text = 0;
        } 
        if(grdDebit.GetGridData(grdDebit.row,27) == 'Y')
        {
            txtWithholding_FTax.text = _Whithout;
            txtWithholding_Tax.text = _Whithout_Bk;
        }
        else
        {
            txtWithholding_FTax.text = 0;
            txtWithholding_Tax.text = 0;
        }
        if(grdDebit.GetGridData(grdDebit.row,28) == 'Y')
        {
            txtFVAT.text = VATTr_dr;
            txtVAT.text = VATBk_dr;
        }
        else
        {
            txtFVAT.text = 0;
            txtVAT.text = 0;
        }
        if(grdDebit.GetGridData(grdDebit.row,25) == 'N' && grdDebit.GetGridData(grdDebit.row,26) == 'N' && grdDebit.GetGridData(grdDebit.row,27) == 'N' && grdDebit.GetGridData(grdDebit.row,28) == 'N')
        {
            txtNet_FAmt.text = Net_dr_tr;
            txtNet_Amt.text = Net_dr_bk;
        }
        else
        {
            txtNet_FAmt.text = 0;
            txtNet_Amt.text = 0;
        }
   
		Total_Tr = Math.round(Number(txtNet_FAmt.text) + Number(txtDeduction_F.text) + Number(txtRetention_F.text) + Number(txtWithholding_FTax.text) + Number(txtFVAT.text));
		Total_Bk = Number(txtNet_Amt.text) + Number(txtDeduction.text) + Number(txtRetention.text) + Number(txtWithholding_Tax.text) + Number(txtVAT.text);
		txtFTotal.text = Total_Tr;
		txtTotal.text = Total_Bk;
}
//=======================================================================================================
function GetBookExRate(p_ccy){
    lstBookExRate.value = p_ccy;
	var DD = dtRequestDate.value;
	var MM = dtRequestDate.value;
	var YYYY = dtRequestDate.value;
	
	var year = YYYY.substring(0,4);
	var month = MM.substring(4,6);
	var day = DD.substring(6,8);
    var sTemp = lstBookExRate.GetText();
    if(sTemp == ""){
        alert("Please input exchange rate for this "+ p_ccy +" currency at date:"+ day+"/"+month+"/"+year +".");
        return;
    }
    var aTemp = sTemp.split("-");   
    var book_rate =  aTemp[1];
    return book_rate;
}
//=======================================================================================================
function CheckData()
{
    if(txtProject_Pk.text=='')
    {
        alert('Please input Project !!');
        return true;
    }
    else if(txtCustomer_Pk.text=='')
    {
        alert('Please input Customer !!');
        return true;
    }
    else if(txtContract_Pk.text=='')
    {
        alert('Please input Contract !!');
        return true;
    }
    else if(txtRequest_No.text=='')
    {
        alert('Please input Request No !!');
        txtRequest_No.GetControl().focus();
        return true;
    }
    else if(lstReqType.value=='01' && Number(txtProgress1_Amt.text) > Number(txtAdvance_Amt_105.text))
    {
        alert('Progress Amt(1) can not be large than main contract amount !!');return;
        txtProgress1_Amt.text = txtAdvance_Amt_105.text;
		txtThisPayment1.text = txtAdvance_Amt_105.text;
        return true;
    }
	if (txtReq_Times.GetData()=='')
	{
		alert('Please input request time.');
	    txtReq_Times.GetControl().focus();
        return ;

	}
    return false;
}
//=======================================================================================================
var flag='';
function OnSave(obj)
{
	switch (obj)
	{
		case 'Master':
			if(txtProject_Pk.text != '')
			{
				flag='save';
				    if(!CheckData())
                    {
					    dso_upd_master.Call();
                    }
			}
			else
			{
				alert('Please select Project !!');	
			}
		break;	
        case 'Attach':
            DSO_ATTACH_FILE.Call();
        break;
        case 'Dr':
            txtDRCRtype.text = 'D';
            if(!CheckDataIsValid()) return;
            if ((txtDRCRtype.GetData() == 'D') && (grdDebit.rows > 1))
            {
                for (i = 1; i < grdDebit.rows; i++)
                {
                    if ((grdDebit.GetGridData(i, 13) == "") && (grdDebit.GetGridData(i, 9) != ''))
                    {
                        grdDebit.SetGridText(i, 13, txtMasterPK.GetData());
                        grdDebit.SetRowStatus(i, 0x20);
                    }            
                    if (grdDebit.GetGridData(i, 9) == '')
                    {
                        grdDebit.SetGridText(i, 13, txtMasterPK.GetData());
                        grdDebit.SetGridText(i, 8, 0);
                        grdDebit.SetGridText(i, 9, 0);
                    }
            
                }
                var j = 0;
                for (i = 1; i < grdDebit.rows; i++)
                {
                    if (grdDebit.GetGridData(i, 9) == '')
                    {
                        grdDebit.SetRowStatus(i, 0x40);
                        j = j + 1;
                    }
                    else
                    {
                        if (grdDebit.GetGridData(i, 9) == '')
                        {
                            grdDebit.SetGridText(i, 13, txtMasterPK.GetData());
                        }
                        grdDebit.SetGridText(i, 14, i - j);
                    }
                }
                txt_rowclick.text = grdDebit.selrow;
                
                dso_dr.Call();
            }
        break;
        case 'Cr':
        txtDRCRtype.text = 'C';	
            if(!CheckDataIsValid()) return;
            if ((txtDRCRtype.GetData() == 'C') && (grdCredit.rows > 1))
            {
                for (i = 1; i < grdCredit.rows; i++)
                {
                    if ((grdCredit.GetGridData(i, 13) == "") && (grdCredit.GetGridData(i, 9) != ''))
                    {
                        grdCredit.SetGridText(i, 13, txtMasterPK.GetData());
                        grdCredit.SetRowStatus(i, 0x20);
                    }
                    if (grdCredit.GetGridData(i, 9) == '')
                    {
                        grdCredit.SetGridText(i, 13, txtMasterPK.GetData());
                        grdCredit.SetGridText(i, 8, 0);
                        grdCredit.SetGridText(i, 9, 0);
                    }
            
                }
                var j = 0;
                for (i = 1; i < grdCredit.rows; i++)
                {
                    if (grdCredit.GetGridData(i, 9) == '')
                    {
                        grdCredit.SetRowStatus(i, 0x40);
                        j = j + 1;
                    }
                    else
                    {
                        if (grdCredit.GetGridData(i, 9) == '')
                        {
                            grdCredit.SetGridText(i, 13, txtMasterPK.GetData());
                        }
                        grdCredit.SetGridText(i, 14, i - j);
                    }
                }
                txt_rowclick.text = grdCredit.selrow;
                
                dso_cr.Call();
            }
        break;
    }
}
//=======================================================================================================
function CheckDataIsValid(){
    if(!CanChange()) return false;
    
    if (txtMasterPK.GetData() == ''){
        alert('  Save Master and then Treament'+'\n'+'Bạn lưu lại trước sau đó Treament');
        return false;
    }
    //    Check Item Control
//    if ((grdDebit.selrow < 1) && (grdCredit.selrow < 1)){
//        return false;
//    }alert();
    var ctrl = idGridItem.GetGridControl();
	var j = 1;
	var i = ctrl.rows - 1;
	while (j <= i){
		var man         = idGridItem.GetGridData(j,6);
		var itemtitle   = idGridItem.GetGridData(j,8);
		var item        = idGridItem.GetGridData(j,9);
		if(man == "Y" & (item == "" || item == "-")){
			alert('           '+ itemtitle + ' is mandatory. Please input!!!'+'\n'+ itemtitle +' thông tin bắt buộc nhập. Vui lòng nhập vào!!!');
			return false;
		}
		j = j + 1;
	}
	return true;
}
//=======================================================================================================
function OnDelete(obj)
{
	switch (obj)
	{
		case 'Master':
			if(confirm('Are you sure you want to delete ?'))
			{
				dso_upd_master.StatusDelete();
				flag='delete';
				dso_upd_master.Call();	
			}
		break;	
		case 'Debit':
			if(confirm('Are you sure you want to delete ?'))
			{
				grdDebit.DeleteRow();
				dso_dr.Call();
			}
		break;
		case 'Credit':
			if(confirm('Are you sure you want to delete ?'))
			{
				grdCredit.DeleteRow();
				dso_cr.Call();
			}
		break;
        case 'Attach':
            if(confirm('Do you want to delete selected file ?'))
			{
			     Grid_Attach.DeleteRow();
			     DSO_ATTACH_FILE.Call();
			}
        break;
	}
	
}
//=======================================================================================================
function OnShow(obj) 
    {
        var vendor1 = document.all("_1");
        var vendor2 = document.all("_2");
        var vendor3 = document.all("_3");
        var vendor4 = document.all("_4");
        var vendor5 = document.all("_5");
        switch(obj)
        {
            case 1:
                if (vendor1.style.display == "none" && vendor2.style.display == "none" && vendor3.style.display == "none" && vendor4.style.display == "none" ) 
                {
                    vendor1.style.display = "";
                    vendor2.style.display = "";
                    vendor3.style.display = "";
                    vendor4.style.display = "";
                    imgup.src = "../../../system/images/up.gif";
                }
                else 
                {
                    vendor1.style.display = "none";
                    vendor2.style.display = "none";
                    vendor3.style.display = "none";
                    vendor4.style.display = "none";
                    imgup.src = "../../../system/images/down.gif";
                }
            break;
            case 2:
                if (vendor5.style.display == "none" ) 
                {
                    vendor5.style.display = "";
                    img4.src = "../../../system/images/up.gif";
                }
                else 
                {
                    vendor5.style.display = "none";
                    img4.src = "../../../system/images/down.gif";
                }
            break;
        }
        
    }
//=======================================================================================================
function OnAttach()
{
    if(txtMasterPK.text != '')
    { 
		
            imgFile.MasterPK=txtMasterPK.text;
            imgFile.ChangeImage();
		   
            if( imgFile.oid == 0 )
            {
                return false;
            }
            else
            {
				Grid_Attach.SetGridText( Grid_Attach.rows - 1, 4, txtMasterPK.text);   		
                DSO_ATTACH_FILE.Call();
            }
            imgFile.oid= "";     
    } 
    else
    {
            alert('Please select Request No!!');
    } 
}
//=======================================================================================================
function OnOpenFile()
{
        var img_pk = Grid_Attach.GetGridData(Grid_Attach.GetGridControl().row,3)	;
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=TECPS_128CONTRACT_FILE";	
        window.open(url);
}
//------------------------------------------------------------------------------------------------------
function onChangemanual_amt()
{
	//-----Caculate invoice amt
	var reten_iamt =0;
	var holding_tax_iamt =0;
	var adv_deduct_iamt = 0;
	if(Number(txtInvoice_ExRate.GetData()) !=0 )
	{
		if (lstInvoice_Ccy.GetData()== 'VND')
		{
			reten_iamt = System.Round( Number(txtRetention1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,0);
			holding_tax_iamt = System.Round( Number(txtWithholdingTax1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,0);
			adv_deduct_iamt = System.Round( Number(txtAdvDeduct1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,0);
		}else{

			reten_iamt = System.Round( Number(txtRetention1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,2);
			holding_tax_iamt = System.Round( Number(txtWithholdingTax1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,2);
			adv_deduct_iamt = System.Round( Number(txtAdvDeduct1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.GetData()) ,2);
		}
		txtRetention2_Amt.SetDataText(reten_iamt);
		txtWithholdingTax2_Amt.SetDataText(holding_tax_iamt);
		txtAdvDeduct2_Amt.SetDataText(adv_deduct_iamt);
     }
   //-----Caculate booking amt
	var reten_bamt =0;
	var holding_tax_bamt =0;
	var adv_deduct_bamt = 0;
	
	if(Number(lblBook_Rate.GetData()) !=0 )
	{
		
		if (lstBook_Ccy.GetData()== 'VND')
		{
			reten_bamt = System.Round( Number(txtRetention1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,0);
			holding_tax_bamt = System.Round( Number(txtWithholdingTax1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,0);
			adv_deduct_bamt = System.Round( Number(txtAdvDeduct1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,0);
		}else{

			reten_bamt = System.Round( Number(txtRetention1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,2);
			holding_tax_bamt = System.Round( Number(txtWithholdingTax1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,2);
			adv_deduct_bamt = System.Round( Number(txtAdvDeduct1_Amt.GetData()) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.GetData()) ,2);
			//alert(reten_iamt);
		}
		txtRetention3_Amt.SetDataText(reten_bamt);
		txtWithholdingTax3_Amt.SetDataText(holding_tax_bamt);
		txtAdvDeduct3_Amt.SetDataText(adv_deduct_bamt);
     }
	 //--- Caculate sum deduct amount 
	 var sum_deduct_oamt = Number(txtRetention1_Amt.GetData()) + Number(txtWithholdingTax1_Amt.GetData())  + Number(txtAdvDeduct1_Amt.GetData());
         txtTotalDeduct1_Amt.SetDataText(sum_deduct_oamt);
	 var sum_deduct_iamt = Number(txtRetention2_Amt.GetData()) + Number(txtWithholdingTax2_Amt.GetData())  + Number(txtAdvDeduct2_Amt.GetData());
	     txtTotalDeduct2_Amt.SetDataText(sum_deduct_iamt);
	 var sum_deduct_bamt = Number(txtRetention3_Amt.GetData()) + Number(txtWithholdingTax3_Amt.GetData())  + Number(txtAdvDeduct3_Amt.GetData());
         txtTotalDeduct3_Amt.SetDataText(sum_deduct_bamt);
    //--- Caculate sum payment amount 
     var sum_payment_oamt = Number(txtProgress1_Amt.GetData()) + Number( txtVAT1_Amt.GetData()) - Number(txtTotalDeduct1_Amt.GetData());
	     txtThisPayment1.SetDataText(sum_payment_oamt);
	 var sum_payment_iamt = Number(txtProgress2_Amt.GetData()) + Number( txtVAT2_Amt.GetData()) - Number(txtTotalDeduct2_Amt.GetData());
	     txtThisPayment2.SetDataText(sum_payment_iamt);
	 var sum_payment_bamt = Number(txtProgress3_Amt.GetData()) + Number( txtVAT3_Amt.GetData()) - Number(txtTotalDeduct3_Amt.GetData());
	     txtThisPayment3.SetDataText(sum_payment_bamt);


}
//=======================================================================================================
function OnCalc_Control()
{
    var _VAT_Rate_105 = Number(txtVAT_RATE_105.text);
    var _Advance_105 = Number(txtAdvance_105.text);
    var _Retention_105 = Number(txtRetention_105.text);
    if(lstReqType.value=='01' && Number(txtProgress1_Amt.text) > Number(txtAdvance_Amt_105.text))
    {
        alert('Progress Amt(1) can not be large than main contract amount !!');
        txtProgress1_Amt.text = txtAdvance_Amt_105.text;
		
        return;
    }       
    if(lstReqType.value=='01')
    {
	   // caculate invoice amount
       if(Number(txtInvoice_ExRate.GetData()) !=0 )
		{
			 txtProgress2_Amt.text = format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
			 txtThisPayment2.text = format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
		}	
	
	   // caculate book amount
	   if( Number( lblBook_Rate.GetData()!= 0)){
		   txtThisPayment3.text =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
		   txtProgress3_Amt.text =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);

	   }
    }
    else
    {
        
        //====================(2)============================================
        txtVAT1_Amt.text = Number(txtProgress1_Amt.text) * _VAT_Rate_105 / 100; 
   
        //====================(3)================================================
        txtRetention1_Amt.text = Number(txtProgress1_Amt.text) * _Retention_105 / 100; 
   
        //===========(5)=================
        txtAdvDeduct1_Amt.text = Number(txtProgress1_Amt.text) * _Advance_105 / 100; 
 
        //===========(6)=(3)+(4)+(5)=================
        txtTotalDeduct1_Amt.text = Number(txtRetention1_Amt.text) + Number(txtWithholdingTax1_Amt.text) + Number(txtAdvDeduct1_Amt.text);
   
        //===========(7)=(1)+(2)-(6)=================
        txtThisPayment1.text = Number(txtProgress1_Amt.text) + Number(txtVAT1_Amt.text) - Number(txtTotalDeduct1_Amt.text);
   

        //===========Calc Book Amt=================
		 // caculate book amount
	   if( Number( lblBook_Rate.GetData()!= 0)){
			if(txtbookccy.text=='VND'){
				 txtProgress3_Amt.text         =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
				 txtVAT3_Amt.text              =  format_number( Number(txtVAT1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
                 txtRetention3_Amt.text        =  format_number( Number(txtRetention1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
				 txtWithholdingTax3_Amt.text   =  format_number( Number(txtWithholdingTax1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
				 txtAdvDeduct3_Amt.text        =  format_number( Number(txtAdvDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
				 txtTotalDeduct3_Amt.text      =  format_number( Number(txtTotalDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
			     txtThisPayment3.text          =  format_number( Number(txtThisPayment1.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),0);
				
			}else{

				 txtProgress3_Amt.text         =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
				 txtVAT3_Amt.text              =  format_number( Number(txtVAT1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
                 txtRetention3_Amt.text        =  format_number( Number(txtRetention1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
				 txtWithholdingTax3_Amt.text   =  format_number( Number(txtWithholdingTax1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
				 txtAdvDeduct3_Amt.text        =  format_number( Number(txtAdvDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
				 txtTotalDeduct3_Amt.text      =  format_number( Number(txtTotalDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
			     txtThisPayment3.text          =  format_number( Number(txtThisPayment1.text) * Number(txtOrder_ExRate.GetData()) / Number(lblBook_Rate.text),2);
			
			}
       }

        //===========Calc invoice Amt=================
		
	   if( Number( txtInvoice_ExRate.GetData()!= 0)){
			if(lstInvoice_Ccy.text=='VND'){
				 txtProgress2_Amt.text         =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
				 txtVAT2_Amt.text              =  format_number( Number(txtVAT1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
                 txtRetention2_Amt.text        =  format_number( Number(txtRetention1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
				 txtWithholdingTax2_Amt.text  =  format_number( Number(txtWithholdingTax1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
				 txtAdvDeduct2_Amt.text        =  format_number( Number(txtAdvDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
				 txtTotalDeduct2_Amt.text      =  format_number( Number(txtTotalDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
			     txtThisPayment2.text          =  format_number( Number(txtThisPayment1.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),0);
				
			}else{

				 txtProgress2_Amt.text         =  format_number( Number(txtProgress1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
				 txtVAT2_Amt.text              =  format_number( Number(txtVAT1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
                 txtRetention2_Amt.text        =  format_number( Number(txtRetention1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
				 txtWithholdingTax2_Amt.text   =  format_number( Number(txtWithholdingTax1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
				 txtAdvDeduct2_Amt.text        =  format_number( Number(txtAdvDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
				 txtTotalDeduct2_Amt.text      =  format_number( Number(txtTotalDeduct1_Amt.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
			     txtThisPayment2.text          =  format_number( Number(txtThisPayment1.text) * Number(txtOrder_ExRate.GetData()) / Number(txtInvoice_ExRate.text),2);
			
			}
       }
    }
	ChangeReqType();
}
//=======================================================================================================
function OnPrint(obj)
{
    switch(obj)
    {
        case 'AR':
            if(txtMasterPK.text != '')
            {
                var url = System.RootURL + "/reports/kp/bp/kpbp128_1.aspx?Master_Pk=" + txtMasterPK.text + '&Ccy=' + lstOrder_Ccy.value;
		        System.OpenTargetPage(url);  
            }   
            else
            {
                alert('Please select Request No !!');
            }

        break;
        case 'Accounting':
            if(txtSeq.text!='')
            {
                var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq='+txtSeq.text;
			    System.OpenTargetPage( url , 'newform' );
            }

        break;
    }
}
//=======================================================================================================
function CanChange(){
    switch(lblStatus.GetData()){
       
        case "Saved": return true;
        case "Confirmed":alert("This voucher was confirmed. So you can not change !.\n Số phiếu này đã được xác nhận. Bạn không thể thay đổi !");
                 return false;
        break;
       
    }
    return true;
}
//=======================================================================================================
function ChangeReqType()
{
    if(lstReqType.value=='01')
    {
        txtProgress1_Amt.text = txtAdvance_Amt_105.text;
		txtThisPayment1.text = txtAdvance_Amt_105.text;
        txtSeq.SetReadOnly(true);
        txtDescription.text = 'Advance payment for (' + txtCustomer_Nm.GetData() + ') of (' + txtProject_Cd.GetData() + ')'  ;
		txtLocal_Description.text =  'Thanh toán tạm ứng cho (' + txtCustomer_Nm.GetData() + ') của dự án (' + txtProject_Cd.GetData() + ')'  ;
		//OnCalc_Control();
    }
    else
    {
            txtSeq.SetReadOnly(false);
			var req_time ='' ;
			switch(txtReq_Times.GetData())
			{
				case '0':
				break;
				case '1':
				case '21':
					req_time = txtReq_Times.GetData() + 'st' ;
				break;
                case '2':
				case '22':
					req_time = txtReq_Times.GetData() + 'nd' ;
				break;
				case '3':
				case '23': 
				   req_time = txtReq_Times.GetData() + 'rd' ;
				break;
				case '4':
				case '5':
				case '6':
				case '7':
				case '8':
				case '9':
				case '10':
				case '11':
				case '12':
				case '13':
				case '14':
				case '15':
				case '16':
				case '17':
				case '18':
				case '19':
				case '20':
				case '24':
				case '25':
				case '26':
				case '27':
				case '28':
				case '29':
				case '30':
					req_time = txtReq_Times.GetData() + 'th' ;
				break;
				
			}
			txtDescription.text =  req_time + ' progress payment ' + txtProject_Nm.GetData()  ;
			txtLocal_Description.text =  'Thanh toán tiến độ đợt '+ txtReq_Times.GetData() + ' CT '   + txtProject_Nm.GetData() ;
        grdDebit.ClearData();
        grdCredit.ClearData();
        //txtProgress1_Amt.text = '0';
		//-----1 progress----------------------------------------------------
        if(txtProgress1_Amt.text!='0')
        {
		    var Net_famt =0;
			var Net_amt=0;
			if (lstInvoice_Ccy.GetData()== 'VND')
			{
				 Net_famt = System.Round( Number( txtProgress2_Amt.GetData()),0) - System.Round( Number(txtRetention2_Amt.GetData()) ,0);
			}else{
                 Net_famt = System.Round( Number( txtProgress2_Amt.GetData()),2) - System.Round( Number(txtRetention2_Amt.GetData()) ,2);  
			}
             Net_amt = System.Round( Number(txtProgress3_Amt.GetData()),2)  - System.Round(Number(txtRetention3_Amt.GetData()),2);

            grdDebit.AddRow();
		    grdDebit.SetGridText( grdDebit.rows - 1, 1, '2553');
            grdDebit.SetGridText( grdDebit.rows - 1, 3, '1');
            grdDebit.SetGridText( grdDebit.rows - 1, 4, '1110410001');
            grdDebit.SetGridText( grdDebit.rows - 1, 5, 'Accounts receivable - Construction');
            grdDebit.SetGridText( grdDebit.rows - 1, 6, lstInvoice_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 7, txtInvoice_ExRate.text);
			
            grdDebit.SetGridText( grdDebit.rows - 1, 8, Net_famt);
            grdDebit.SetGridText( grdDebit.rows - 1, 9, Net_amt);
            grdDebit.SetGridText( grdDebit.rows - 1, 10, txtDescription.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 11, txtLocal_Description.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 15, 'D');
            grdDebit.SetGridText( grdDebit.rows - 1, 17, lblBook_Rate.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 19, lstBook_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 20, txtCustomer_Pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 22, txtCustomer_Cd.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 23, txtCustomer_Nm.text);
             
            if (txtRetention1_Amt.GetData()!=0 )
            {
           
				grdDebit.AddRow();
				grdDebit.SetGridText( grdDebit.rows - 1, 1, '2553');
				grdDebit.SetGridText( grdDebit.rows - 1, 3, '1');
				grdDebit.SetGridText( grdDebit.rows - 1, 4, '1110410001');
				grdDebit.SetGridText( grdDebit.rows - 1, 5, 'Accounts receivable - Construction');
				grdDebit.SetGridText( grdDebit.rows - 1, 6, lstInvoice_Ccy.value);
				grdDebit.SetGridText( grdDebit.rows - 1, 7, txtInvoice_ExRate.text);

				grdDebit.SetGridText( grdDebit.rows - 1, 8, txtRetention2_Amt.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 9, txtRetention3_Amt.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 10, txtDescription.text + '(Retention)');
				grdDebit.SetGridText( grdDebit.rows - 1, 11, txtLocal_Description.text + '(bảo hành)');
				grdDebit.SetGridText( grdDebit.rows - 1, 15, 'D');
				grdDebit.SetGridText( grdDebit.rows - 1, 17, lblBook_Rate.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 19, lstBook_Ccy.value);
				grdDebit.SetGridText( grdDebit.rows - 1, 20, txtCustomer_Pk.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 21, txttac_abplcenter_pk.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 22, txtCustomer_Cd.text);
				grdDebit.SetGridText( grdDebit.rows - 1, 23, txtCustomer_Nm.text);
            }
			
			

            grdCredit.AddRow();
		    grdCredit.SetGridText( grdCredit.rows - 1, 1, '2634');
            grdCredit.SetGridText( grdCredit.rows - 1, 2, '0');
            grdCredit.SetGridText( grdCredit.rows - 1, 3, '1');
            grdCredit.SetGridText( grdCredit.rows - 1, 4, '1110440000');
            grdCredit.SetGridText( grdCredit.rows - 1, 5, 'Progressive accounts receivable');
            grdCredit.SetGridText( grdCredit.rows - 1, 6, lstInvoice_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 7, txtInvoice_ExRate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 8, txtProgress2_Amt.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 9, txtProgress3_Amt.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 10, txtDescription.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 11, txtLocal_Description.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 15, 'C');
            grdCredit.SetGridText( grdCredit.rows - 1, 17, lblBook_Rate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 19, lstBook_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 20, txtCustomer_Pk.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 22, txtCustomer_Cd.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 23, txtCustomer_Nm.GetData());
        }
        //------2 Vat --------------------------------------------------------------------------
        if(txtVAT1_Amt.GetData() !='0')
        {
            //Retention
            grdDebit.AddRow();
		    grdDebit.SetGridText( grdDebit.rows - 1, 1, '2553');
            grdDebit.SetGridText( grdDebit.rows - 1, 2, '0');
            grdDebit.SetGridText( grdDebit.rows - 1, 3, '2');
            grdDebit.SetGridText( grdDebit.rows - 1, 4, '1110410001');
            grdDebit.SetGridText( grdDebit.rows - 1, 5, 'Accounts receivable - Construction');
            grdDebit.SetGridText( grdDebit.rows - 1, 6, lstInvoice_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 7, txtInvoice_ExRate.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 8, txtVAT2_Amt.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 9, txtVAT3_Amt.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 10, txtDescription.text + '(VAT)');
            grdDebit.SetGridText( grdDebit.rows - 1, 11, txtLocal_Description.text + '(VAT)');
            grdDebit.SetGridText( grdDebit.rows - 1, 15, 'D');
            grdDebit.SetGridText( grdDebit.rows - 1, 17, lblBook_Rate.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 19, lstBook_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 20, txtCustomer_Pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 22, txtCustomer_Cd.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 23, txtCustomer_Nm.text);
           
			grdCredit.AddRow();
		    grdCredit.SetGridText( grdCredit.rows - 1, 1, '2627');
            grdCredit.SetGridText( grdCredit.rows - 1, 2, '0');
            grdCredit.SetGridText( grdCredit.rows - 1, 3, '2');
            grdCredit.SetGridText( grdCredit.rows - 1, 4, '2112010001');
            grdCredit.SetGridText( grdCredit.rows - 1, 5, 'VAT output');
            grdCredit.SetGridText( grdCredit.rows - 1, 6, lstInvoice_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 7, txtInvoice_ExRate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 8, txtVAT2_Amt.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 9, txtVAT3_Amt.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 10, txtDescription.text + '(VAT)');
            grdCredit.SetGridText( grdCredit.rows - 1, 11, txtLocal_Description.text + '(VAT)');
            grdCredit.SetGridText( grdCredit.rows - 1, 15, 'C');
            grdCredit.SetGridText( grdCredit.rows - 1, 17, lblBook_Rate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 19, lstBook_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 20, txtCustomer_Pk.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 22, txtCustomer_Cd.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 23, txtCustomer_Nm.text);
        }
        //-------3 deduct -------------------------------------------------
        if(txtAdvDeduct1_Amt.text !='0')
        {
            grdDebit.AddRow();
		    grdDebit.SetGridText( grdDebit.rows - 1, 1, '2555');
            grdDebit.SetGridText( grdDebit.rows - 1, 2, '0');
            grdDebit.SetGridText( grdDebit.rows - 1, 3, '3');
            grdDebit.SetGridText( grdDebit.rows - 1, 4, '2104010001');
            grdDebit.SetGridText( grdDebit.rows - 1, 5, 'Advance from customer - construction');
            grdDebit.SetGridText( grdDebit.rows - 1, 6, lstInvoice_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 7, txtInvoice_ExRate.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 8, txtAdvDeduct2_Amt.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 9, txtAdvDeduct3_Amt.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 10, 'Deduct advance ' +  txtProject_Nm.GetData());
            grdDebit.SetGridText( grdDebit.rows - 1, 11, 'Cấn trừ tạm ứng ' +  txtProject_Nm.GetData());
            grdDebit.SetGridText( grdDebit.rows - 1, 15, 'D');
            grdDebit.SetGridText( grdDebit.rows - 1, 17, lblBook_Rate.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 19, lstBook_Ccy.value);
            grdDebit.SetGridText( grdDebit.rows - 1, 20, txtCustomer_Pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 22, txtCustomer_Cd.text);
            grdDebit.SetGridText( grdDebit.rows - 1, 23, txtCustomer_Nm.text);

            grdCredit.AddRow();
		    grdCredit.SetGridText( grdCredit.rows - 1, 1, '2553');
            grdCredit.SetGridText( grdCredit.rows - 1, 2, '0');
            grdCredit.SetGridText( grdCredit.rows - 1, 3, '3');
            grdCredit.SetGridText( grdCredit.rows - 1, 4, '1110410001');
            grdCredit.SetGridText( grdCredit.rows - 1, 5, 'Accounts receivable - Construction');
            grdCredit.SetGridText( grdCredit.rows - 1, 6, lstInvoice_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 7, txtInvoice_ExRate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 8, txtAdvDeduct2_Amt.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 9, txtAdvDeduct3_Amt.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 10, 'Deduct advance ' +  txtProject_Nm.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 11, 'Cấn trừ tạm ứng ' +  txtProject_Nm.GetData());
            grdCredit.SetGridText( grdCredit.rows - 1, 15, 'C');
            grdCredit.SetGridText( grdCredit.rows - 1, 17, lblBook_Rate.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 19, lstBook_Ccy.value);
            grdCredit.SetGridText( grdCredit.rows - 1, 20, txtCustomer_Pk.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 21, txttac_abplcenter_pk.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 22, txtCustomer_Cd.text);
            grdCredit.SetGridText( grdCredit.rows - 1, 23, txtCustomer_Nm.text);
        }
        //0_Pk|1_Acc_pk|2check|3 type ref|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.mount Book|10.Description|11.Local Description|12_Expense Type|13_m_pk|14_ODR|15_DRCR|16_ChkTreat|17.Book Rate|18Tmp Rate|19_bookccy|20_tco_buspartner_pk|21_tac_abplcenter_pk|22_BUS_ID|23_BUS_NM-->
    }
}
//=======================================================================================================
function OnCtrToggleLeft()
{
    var left  = document.all("tdGrid");
    var right = document.all("tdControlItem");
    var imgArrow = document.all("imgArrow");
    
    right.style.display="";
    imgArrow.status = "collapse";
    left.style.width="60%";
    imgArrow.src = "../../../system/images/next_orange.gif";
}
//=======================================================================================================
function OnCtrToggleRight()
{
    var left  = document.all("tdGrid");
    var right = document.all("tdControlItem");
    var imgArrow = document.all("imgArrow");
    
    if(imgArrow.status == "collapse")
    {
        right.style.display="none";       
        imgArrow.status = "expand";
        left.style.width="100%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//=======================================================================================================
function ItemStyle()
{
	var ctrl = idGridItem.GetGridControl();
	var j = 1;
	var i = ctrl.rows - 1;
	if(i > 0){
	    OnCtrToggleLeft();
	}
	else{
	    OnCtrToggleRight();
	}
	while (j <= i)
	{
		var man = idGridItem.GetGridData(j,6);
		if(man == "Y")
		{
			idGridItem.SetCellBold(j,8,j,8,true);
		}
	    var type = idGridItem.GetGridData(j,3);
		if(type == "T" | type == "C")
		{
			if(type == "T")
			{
				idGridItem.SetCellBgColor(j,8,j,10,0xEFFFFF);	
			}
			else
			{
				idGridItem.SetCellBgColor(j,8,j,10,0xF4E6E0);
			}
			idGridItem.SetRowEditable(j,false);
		}
		j = j + 1;
	}
	
//	   for(var i=1;i<idGridItem.rows;i++){
//		 if(idGridItem.GetGridData( i, 8) == 'CONTRACT NOAP' && idGridItem.GetGridData( i, 9) == '' ){
//			 idGridItem.SetGridText(i,  9, txt_TAC_CRSUBCONTRACT_cd.GetData()) ;//ITEM CODE
//             idGridItem.SetGridText(i, 10, txt_TAC_CRSUBCONTRACT_nm.GetData()) ;//ITEM NAME
//             idGridItem.SetGridText(i, 11, "TAC_CRSUBCONTRACT") ;//TABLE NAME 
//             idGridItem.SetGridText(i, 12, txt_TAC_CRSUBCONTRACT_pk.GetData()) ;//TABLE PK 


//		 }
//	   }
}
//=======================================================================================================
function OnToggle_dtl()
{
    var left  = document.all("tdGrid");    
    var right = document.all("tdControlItem");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "collapse")
    {
        right.style.display="none";       
        imgArrow.status = "expand";
        left.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        right.style.display="";
        imgArrow.status = "collapse";
        left.style.width="60%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//=======================================================================================================
function RowClick_CR()
{
    if (grdCredit.rows < 2)	
    {
        return;
    }
	else
	{
	    
	    
	    
        if (grdCredit.selrow < 1)
	    {
	        return;
	    }
	
	    if ((grdCredit.rows > 1) && (grdCredit.selrow < grdCredit.rows) && (grdCredit.selrow != click_cr))
	    {
            for (i = 1; i < grdCredit.rows; i++)
            {
                if (grdCredit.selrow == i)
                {
	                grdCredit.SetCellBold(i,1,i,15,true);
	                grdCredit.SetRowEditable(i, true);
                }
                else
                {
	                grdCredit.SetCellBold(i,1,i,15,false);
	                grdCredit.SetRowEditable(i, false);
                }
            }
            txtacpk.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 1));
            txtTECPS_MCTREQUESTD_PK.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 0));
            txt_rowclick.text = grdCredit.selrow;
            txtDRCRtype.SetDataText('C');
            idGridItem.SetData("");
            click_dr = 0;
            click_cr = grdCredit.selrow;
            dso_upd_ctl_item.Call("SELECT");
        }
        
        OnCheckSumCR();
    }
}

function OnCheckSumCR()
{
	var ctrl 	    = grdCredit.GetGridControl();
	var sum_cr_famt = 0;
	var sum_cr_amt  = 0;
	for (i=1; i < ctrl.rows; i++)
	{
		var tmp = grdCredit.GetGridData(i, 2);
		if (tmp == '-1')
		{
			sum_cr_famt = Number(sum_cr_famt) + Number(grdCredit.GetGridData(i, 8));
			sum_cr_amt  = Number(sum_cr_amt)  + Number(grdCredit.GetGridData(i, 9));
		}
	}
	txtsum_chk_cr_famt.SetDataText('' + sum_cr_famt);
	txtsum_chk_cr_amt.SetDataText(''  + sum_cr_amt);
	OnSumCR();
}

function ChangeData_Upper()
{
    var ctrl = idGridItem.GetGridControl(); 
    var i = ctrl.rows - 1;
    for (i=1; i< ctrl.rows; i++)
    {
        var itemal      = idGridItem.GetGridData(i, 8); 
        var item_value  = idGridItem.GetGridData(i, 9); 
        if(itemal == "SERIAL NUMBER" || itemal == "SERIAL NO" || itemal == "SERI NO" )
        {
            item_value = item_value.toUpperCase();
            idGridItem.SetGridText( i , 9, item_value);
        }
    }
}

function ClickItemControl()
{    
	var flg = "0";
	var ctrl = idGridItem.GetGridControl();
	
	if (idGridItem.GetGridData( ctrl.row, 2) == '-1')
	{
		flg = "2";
		var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		if ( object != null )
		{
		    if (object[0] != 0)
            {
                idGridItem.SetGridText(ctrl.row,  9, object[1]);//customer id
		        idGridItem.SetGridText(ctrl.row,  10, object[2]);//customer name
		        idGridItem.SetGridText(ctrl.row,  11, "TCO_BUSPARTNER");//table name
		        idGridItem.SetGridText(ctrl.row, 12, object[0]);//customer pk
		        
		        for (i = 1; i < idGridItem.rows; i++)
		        {
//		            if (idGridItem.GetGridData(i, 8) == 'CUSTOMER NAME')
//		            {
//		                idGridItem.SetGridText(i, 10, object[2]);//cuatomer name
//		                idGridItem.SetGridText(i,  9, object[1]);//cuatomer id
//		            }
		            if (idGridItem.GetGridData(i, 8) == 'SERIAL NO')
		            {
		                idGridItem.SetGridText(i,  9, object[7]);
		            }
		            if (idGridItem.GetGridData(i, 8) == 'TAX CODE')
		            {
		                idGridItem.SetGridText(i,  9, object[6]);
		            }
		        }
		    }
        }
	}
	else if (idGridItem.GetGridData( ctrl.row, 2) == '-2')
	{
	    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
        var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
        if ( object != null )  
        {
            if (object[0] != 0)
            {
                idGridItem.SetGridText(ctrl.row,  9, object[1]) ;//pl name
                idGridItem.SetGridText(ctrl.row, 10, object[3]) ;//cost center name
                idGridItem.SetGridText(ctrl.row,  11, "TAC_ABPLCENTER") ;//
                idGridItem.SetGridText(ctrl.row,  12, object[2]) ;//table pk			
            }
        } 
	}
	else if(idGridItem.GetGridData(idGridItem.row, 8) == 'CONTRACT NOAR'){
	    var fpath   = System.RootURL + "/form/gf/co/gfco002007.aspx?contract_type=SALE&company=" + lstCompany.GetData();
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object!=null ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//ITEM CODE(contract no)
            idGridItem.SetGridText(idGridItem.row, 10, object[4]) ;//ITEM NAME(customer name)
            idGridItem.SetGridText(idGridItem.row, 11, "TEX_CONTR_MST") ;//TABLE NAME 
            idGridItem.SetGridText(idGridItem.row, 12, object[0]) ;//TABLE PK 
            for(var i=1;i<idGridItem.rows;i++){
                if ((idGridItem.GetGridData(i, 8) == 'CUSTOMER') && (Trim(idGridItem.GetGridData(i, 9)) == "")){
                    idGridItem.SetGridText(i,  9, object[3]);//customer id
                    idGridItem.SetGridText(i, 10, object[4]);//customer name
                    idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");//TABLE NAME
                    idGridItem.SetGridText(i,  12, object[8]);//TABLE PK
                }
                if (idGridItem.GetGridData(i, 8) == 'SERIAL NO'){
                    idGridItem.SetGridText(i,  9, object[10]);
                }
                if (idGridItem.GetGridData(i, 8) == 'PL UNIT'){
                    idGridItem.SetGridText(i,  9, object[12]);
                    idGridItem.SetGridText(i,  10, object[13]);
                    idGridItem.SetGridText(i,  12, object[11]);
                }
             
            }
        } 
    }    
    else if(idGridItem.GetGridData( idGridItem.row, 8) == 'CONTRACT NOAR'){
	    var fpath   = System.RootURL + "/form/gf/co/gfco002007.aspx?contract_type=BUY";
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object != null ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//ITEM CODE
            idGridItem.SetGridText(idGridItem.row, 10, object[4]) ;//ITEM NAME
            idGridItem.SetGridText(idGridItem.row, 11, "TAC_CRCONTRACT") ;//TABLE NAME 
            idGridItem.SetGridText(idGridItem.row, 12, object[0]) ;//TABLE PK 
            
            for(var i=1;i<idGridItem.rows;i++){
                if ((idGridItem.GetGridData(i, 8) == 'CUSTOMER') && (Trim(idGridItem.GetGridData(i, 9)) == "")){
                    idGridItem.SetGridText(i,  9, object[3]);//customer id
                    idGridItem.SetGridText(i, 10, object[4]);//customer name
                    idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");//TABLE NAME
                    idGridItem.SetGridText(i,  12, object[8]);//TABLE PK
                }
                if (idGridItem.GetGridData(i, 8) == 'SERIAL NO'){
                    idGridItem.SetGridText(i,  9, object[10]);
                }
                if (idGridItem.GetGridData(i, 8) == 'TAX CODE'){
                    idGridItem.SetGridText(i,  9, object[9]);
                }
                if (idGridItem.GetGridData(i, 8) == 'PL UNIT'){
                    idGridItem.SetGridText(i,  9, object[12]);
                    idGridItem.SetGridText(i,  10, object[13]);
                    idGridItem.SetGridText(i,  12, object[11]);
                }
            }
        } 
	}
	else
	{
		if ((idGridItem.GetGridData( ctrl.row, 3) == 'T') || (idGridItem.GetGridData(ctrl.row, 3) == 'C'))
		{
			if (idGridItem.GetGridData( ctrl.row, 3) == 'C')
			{
				var ls_str = idGridItem.GetGridData(ctrl.row, 8);
				var temp = new Array();
                temp = ls_str.split(' ');
				var ls_temp = temp[0];
				
				var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + ls_str + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_ITEMNM_POPUP&col_code=' + ls_temp +" CODE" + '&col_nm=' + ls_temp + " NAME";
                var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                //get from TAC_ABITEMCODE
                if ( object != null )  
                {
                    if (object[0] != 0)
                    {
                        idGridItem.SetGridText(ctrl.row,  9, object[0]) ;// item code
                        idGridItem.SetGridText(ctrl.row, 10, object[1]) ;//item name
                        idGridItem.SetGridText(ctrl.row, 11, "TAC_ABITEMCODE") ; //table name
                        idGridItem.SetGridText(ctrl.row, 12, object[2]) ; //table pk
                    }
                } 
			}
			else
			{
			  
				if (idGridItem.GetGridData(ctrl.row, 4) != '')
				{
				//
				}
				else
				{
				   
					if ( idGridItem.GetGridData( ctrl.row, 8 )== "Bank Account No." || idGridItem.GetGridData( ctrl.row, 8 )== "DEPOSIT ACCOUNT NO" || idGridItem.GetGridData( ctrl.row, 8 )== "BANK ACCOUNT NUMBER" || idGridItem.GetGridData( ctrl.row, 8 )== "BANK ACCOUNT NO.")
					{
					    var ls_ccy
					    if (txtDRCRtype.GetData() == 'D')
					    {
					        ls_ccy = grdDebit.GetGridData(click_dr, 6);
					    }
					    else if (txtDRCRtype.GetData() == 'C')
					    {
					        ls_ccy = grdCredit.GetGridData(click_cr, 6);
					    }
					    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + ls_ccy + "&company="+ lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
                        var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {
                            if (object[0] != 0)
                            {
                                idGridItem.SetGridText(ctrl.row,  9, object[1]);//BANK ID
                                idGridItem.SetGridText(ctrl.row, 10, object[0]);//BANK NAME(PARTNER NAME)
                                idGridItem.SetGridText(ctrl.row, 11, "TAC_ABDEPOMT");// TABLE NAME 
                                idGridItem.SetGridText(ctrl.row, 12, object[2]);// TABLE PK 
                            }
                        }
					}
					/*-------------------------------------------------------------------------------*/
					else if(idGridItem.GetGridData( ctrl.row, 8 )=="BENEFICIARY BANK")
					{
					    
					    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + ls_ccy + "&company="+ lstCompany.GetData() + '&dsqlid=ACNT.sp_sel_BFBENEFICIARY_popup&col_code=' + ' Beneficiary Bank '  + '&col_nm=' + 'Account No';
                        var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {
                            if (object[0] != 0)
                            {
                                idGridItem.SetGridText(ctrl.row,  9, object[1]);//BANK ID
                                idGridItem.SetGridText(ctrl.row, 10, object[0]);//BANK NAME(PARTNER NAME)
                                idGridItem.SetGridText(ctrl.row, 11, "TAC_BFBENEFICIARY");// TABLE NAME 
                                idGridItem.SetGridText(ctrl.row, 12, object[2]);// TABLE PK 
                            }
                        }
					}
					/*-------------------------------------------------------------------------------*/
					else
					{
						
						if (idGridItem.GetGridData( ctrl.row, 8 )== "EMPLOYEE NAME")
						{
							//var fpath   = System.RootURL + "/form/gf/co/ffco002003.aspx";
							var fpath   = System.RootURL + "/form/gf/ma/gfma00010_3.aspx";
                            var object  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes'); 
                            if ( object != null )  
                            {
                                if (object[0] != 0)
                                {
                                    idGridItem.SetGridText(ctrl.row,  9, object[1]) ; //Employee ID
                                    idGridItem.SetGridText(ctrl.row, 10, object[2]) ; //Employee Name 
                                    idGridItem.SetGridText(ctrl.row, 11, "TAC_EMPLOYEE_ADV") ; //table name
                                    idGridItem.SetGridText(ctrl.row, 12, object[0]) ; //TABLE PK    
                                }
                            }
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT" || idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT NAME" )
						{
							flg = "-3";
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "CONTRACT NO")
						{
							flg = "-4";
						}
					}
				}
			}
		}
	}
}

function OnTreament()
{
   SaveItemControl();
}

function SaveItemControl()
{
    if (idGridItem.rows > 1)
	{
	    for (i = 1; i<idGridItem.rows; i++)
	    {
            if (txtDRCRtype.GetData() == 'D')
            {
                if ((idGridItem.GetGridData(i, 0) == '') && (idGridItem.GetGridData(i, 9) !='' ))
                {
                    idGridItem.SetGridText(i, 1, grdDebit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                txtacpk.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 1));
                txtTECPS_MCTREQUESTD_PK.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 0));
            }
            else if (txtDRCRtype.GetData() == 'C')
            {
                if (idGridItem.GetGridData(i, 0) == '')
                {
                    idGridItem.SetGridText(i, 1, grdCredit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                
                txtacpk.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 1));
                txtTECPS_MCTREQUESTD_PK.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 0));
            }
	    }
	    dso_upd_ctl_item.Call();
    }
}
</script>
<body>
<!------------1-------------------------------------------------------------------------->
<gw:data id="dso_search_master" onreceive="OnDataReceive(this)"> 
			<xml> 
				<dso id="1" type="grid"    function="ec111.sp_sel_kpbp128_search"    > 
					<input bind="grdMaster">                    
						<input bind="dtFrom" /> 
						<input bind="dtTo" /> 
						<input bind="txtProject_M" />
                        <input bind="txtReqNo_M" />
					</input> 
					<output bind="grdMaster" /> 
				</dso> 
			</xml> 
     </gw:data>
<!---------------2--------------------------------------------------------------------------------------->    

<gw:data id="dso_upd_master" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53" function="ec111.sp_sel_kpbp128" procedure="ec111.sp_upd_kpbp128">
                <input>
                     <inout bind="txtMasterPK"  />
                     <inout bind="txtProject_Pk"  />
                     <inout bind="txtProject_Cd"  />
                     <inout bind="txtProject_Nm"  />
                     <inout bind="txtCustomer_Pk"  />
                     
                     <inout bind="txtCustomer_Cd"  />
                     <inout bind="txtCustomer_Nm"  />
                     <inout bind="lblStatus"  />
                     <inout bind="txtContract_Pk"  />
                     <inout bind="txtContract"  />    

                     <inout bind="txtSeq" />
                     <inout bind="txtRequest_No"  />
                     <inout bind="lstReqType"  />
                     <inout bind="dtRequestDate"  />
                     <inout bind="dtProgressDate_Fr"  />

                     <inout bind="dtProgressDate_To"  />
                     <inout bind="txtReq_Times"  />
                     <inout bind="lstPaymentMethod"  />
                     <inout bind="txtBankAccNo1_Pk"  />
                     <inout bind="txtBankAccNo1_Cd"  />

                     <inout bind="txtBankAccNo1_Nm"  />
                     <inout bind="txtBankAccNo2_Pk"  />
                     <inout bind="txtBankAccNo2_Cd"  />
                     <inout bind="txtBankAccNo2_Nm"  />
                     <inout bind="txtDescription"  />

                     <inout bind="txtLocal_Description"  /> 
                     <inout bind="lstOrder_Ccy"  />
                     <inout bind="txtOrder_ExRate"  />
                     <inout bind="lstInvoice_Ccy"  />
                     <inout bind="txtInvoice_ExRate"  />

                     <inout bind="lstBook_Ccy"  />
                     <inout bind="lblBook_Rate"  />
                     <inout bind="txtProgress1_Amt"  />
                     <inout bind="txtProgress2_Amt"  /> 
                     <inout bind="txtProgress3_Amt"  /> 

                     <inout bind="txtVAT1_Amt"  />
                     <inout bind="txtVAT2_Amt"  />
                     <inout bind="txtVAT3_Amt"  />
                     <inout bind="txtRetention1_Amt"  />
                     <inout bind="txtRetention2_Amt"  /> 

                     <inout bind="txtRetention3_Amt"  /> 
                     <inout bind="txtWithholdingTax1_Amt"  />                   
					 <inout bind="txtWithholdingTax2_Amt"  /> 
                     <inout bind="txtWithholdingTax3_Amt"  />
                     <inout bind="txtAdvDeduct1_Amt"  />      
                                  
					 <inout bind="txtAdvDeduct2_Amt"  />    
                     <inout bind="txtAdvDeduct3_Amt"  /> 
                     <inout bind="txtTotalDeduct1_Amt"  /> 
                     <inout bind="txtTotalDeduct2_Amt"  /> 
                     <inout bind="txtTotalDeduct3_Amt"  /> 

                     <inout bind="txtThisPayment1"  /> 
                     <inout bind="txtThisPayment2"  /> 
                     <inout bind="txtThisPayment3"  /> 
                     <inout bind="dtPlanReceive"  /> 
					 <inout bind="txtSeq"  /> 
				

                     
                </input>
            </dso>
        </xml>
    </gw:data>
    

<!-----------3-------------------------------------------------------------------------------------------------------------------------------------------->    
<gw:data id="dso_get_rate_Order" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtRequestDate"/>
                     <input bind="txtCompany_Pk"/>
                     <input bind="lstOrder_Ccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtOrder_ExRate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>  
<!------------4------------------------------------------------------------------------->    
<gw:data id="dso_get_rate_Invoice" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtRequestDate"/>
                     <input bind="txtCompany_Pk"/>
                     <input bind="lstInvoice_Ccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtInvoice_ExRate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>     
<!-------------5------------------------------------------------------------------------------------------------------------------------------------------>    
<gw:data id="dso_get_rate_book" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtRequestDate"/>
                     <input bind="txtCompany_Pk"/>
                     <input bind="lstBook_Ccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="lblBook_Rate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!-------------6------------------------------------------------------------------------------------------------------------------------------------------>    
<gw:data id="dso_confirm" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ec111.sp_pro_kpbp128_confirm"> 
                <input> 
                	 <input bind="txtConfirm"/>
                     <input bind="txtMasterPK" />
                </input>
                <output>
                     <output bind="lblStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>   
<!--------7--------------------------------------------->	
<gw:data id="dso_dr" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="0,1,3,6,7,8,9,10,11,13,15,17,19,20,21,22,23"  function="ec111.sp_sel_kpbp128_dr"  procedure="ec111.sp_upd_kpbp128_detail">
          <input bind="grdDebit" >
          <input bind="txtMasterPK" />
          <input bind="txtDRCRtype" />
          </input>
          <output bind="grdDebit" />
        </dso>
      </xml>
    </gw:data>    
<!--------8----------------------------------------------------------------------------------------------------------------------------------------------->    
<gw:data id="dso_cr" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="0,1,3,6,7,8,9,10,11,13,15,17,19,20,21,22,23"  function="ec111.sp_sel_kpbp128_dr"  procedure="ec111.sp_upd_kpbp128_detail">
          <input bind="grdCredit" >
          <input bind="txtMasterPK" />
          <input bind="txtDRCRtype" />
          </input>
          <output bind="grdCredit" />
        </dso>
      </xml>
    </gw:data> 
<!--------9----------------------------------------------------------------------------------------------------------------------------------------------->    
<gw:data id="DSO_ATTACH_FILE" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="2,3"  function="ec111.sp_sel_kpbp128_Attach"  procedure="ec111.sp_upd_kpbp128_attach">
          <input bind="Grid_Attach" >
          <input bind="txtMasterPK" />
          </input>
          <output bind="Grid_Attach" />
        </dso>
      </xml>
    </gw:data>
<!------10---------------------------------------------------------->
<gw:data id="dso_get_rate_105" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="EC111.sp_pro_kpbp128_GetRate105"> 
                <input> 
                     <input bind="txtProject_Pk"/>
                     <input bind="txtCustomer_Pk"/>
                </input>
                <output>
                     <output bind="txtVAT_RATE_105"/>
                     <output bind="txtAdvance_105"/>
                     <output bind="txtRetention_105"/>
                     <output bind="txtCcy_105"/>
                     <output bind="txtAdvance_Amt_105"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!------11-------------------------------------------------------------->
<!------11-------------------------------------------------------------->
<gw:data id="dso_get_customer_105" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="EC111.sp_sel_kpbp128_getcus"> 
                <input> 
                     <input bind="txtProject_Pk"/>
					 <input bind="dtRequestDate"/>
                </input>
                <output>
                     <output bind="txtCustomer_Pk"/>
                     <output bind="txtCustomer_Cd"/>
                     <output bind="txtCustomer_Nm"/>

					 <output bind="txtBankAccNo1_Pk"/>
                     <output bind="txtBankAccNo1_Cd"/>
                     <output bind="txtBankAccNo1_Nm"/>

					  <output bind="txtBankAccNo2_Pk"/>
                     <output bind="txtBankAccNo2_Cd"/>
                     <output bind="txtBankAccNo2_Nm"/>

				     <output bind="lstOrder_Ccy"/>
					  <output bind="txtOrder_ExRate"/>
                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!-----12---------------------------------------------------------------->
<gw:data id="dso_get_AccountNo_auto" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="EC111.sp_pro_kpbp128_getAccNo"> 
                <input> 
                     <input bind="txtCustomer_Pk"/>
                     <input bind="txtProject_Pk"/>
                </input>
                <output>
                     <output bind="txtContract_Pk"/>
                     <output bind="txtContract"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!------13------------------------------------------------------------------->
<gw:data id="dso_upd_ctl_item" onreceive="">
        <xml>
            <dso type="grid" parameter="0,1,2,9,10,11,12" function="ec111.sp_sel_kpbp128_ctl_item" procedure="ec111.sp_upd_kpbp128_item_ctl">
                <input bind="idGridItem">
                    <input bind="txtTECPS_MCTREQUESTD_PK"/>
                    <input bind="txtacpk"/>
                    <input bind="txtDRCRtype"/>
                </input> 
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
<!-------------14------------------------------------------------------------------------------------------------------------------------------------------>    
<gw:data id="dso_adv_deduct_can" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ec111.sp_kpbp128_adv_deduct_can"> 
                <input> 
                	 <input bind="txtProject_Pk"/>
                 </input>
                <output>
                     <output bind="txt_adv_deduct_can"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>   

<table style="width:100%;height:100%;background:#BDE9FF" >
   		<tr height="100%">
        	<td id="left" width="25%" style="background:white" valign="top">
            	<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
                	<tr height="6%">
                    	<td>
                        	<fieldset style="padding:0">
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                         <tr style="height:">
                                                <td style="width: 10%" align="right">Date&nbsp;</td>
                                                <td style="width: 90%"><gw:datebox id="dtFrom" lang="1" onchange="OnSearch('grid_master')" />~<gw:datebox id="dtTo" onchange="OnSearch('grid_master')" lang="1" /></td>
                                                <td width=""><gw:imgbtn id="ibtnUpdte1" img="search" alt="Search" onclick="OnSearch('grid_master')" /></td>
                                            </tr>
                                            <tr style="height: " >
                                                <td style="width: 10%" align="right">Project&nbsp;</td>
                                                <td colspan="2"><gw:textbox id="txtProject_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                            </tr>
                                            <tr style="height: " >
                                                <td align="right">Req.No&nbsp;</td>
                                                <td colspan="2"><gw:textbox id="txtReqNo_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                            </tr>
                                </table>
                          </fieldset>  
                        </td>
                    </tr>
                    <tr height="94%">
                        <td colspan="">
                            <gw:grid id='grdMaster' 
                            header='_PK|Request No|Request Times|This Payment|CCY' 
                            format='0|0|0|1|0'
                            aligns='0|1|3|0|1' 
                            check='||||' 
                            editcol='0|0|0|0|0' 
                            widths='0|1200|1500|2000|1500' 
                            sorting='T'
                            styles='width:100%; height:100%' oncellclick="OnSearch('control')" />
                        </td>
                    </tr>
                </table>
            </td>
        	<td id="right" width="75%" valign="top" style="background:white">
            	<table cellpadding="1" cellspacing="0" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:" border="1">
                    <tr style="background:#C5EFF1;height:">
                        <td align="right" width="30%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project&nbsp;</a></td>
                        <td width="70%">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtProject_Cd" csstype="mandatory" readonly="true" styles='width:100%' /></td>
                                    <td width="70%"><gw:textbox id="txtProject_Nm" csstype="mandatory" readonly="true" styles='width:100%' /></td>
                                    <td width=""><gw:textbox id="txtProject_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                    <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="2" width="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="15%"><gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew('Master')" /></td>
                                    <td width="15%"><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave('Master')" /></td>
                                    <td width="15%"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete('Master')" /></td>
                                    <td width="15%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" onclick="OnConfirm()" /></td>
                                    <td width="15"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" /></td>
                                    <td width="15%"><gw:imgbtn id="btna" img="excel" alt="Print Out AR Request" onclick="OnPrint('AR')" /></td>
                                    <td width=""><gw:imgbtn id="btnb" img="excel" alt="Print Out Accounting Slip" onclick="OnPrint('Accounting')" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1;height:">
                        <td align="right" >Customer</td>
                        <td colspan="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtCustomer_Cd" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                    <td width="70%" ><gw:textbox id="txtCustomer_Nm" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                    <td width=""><gw:textbox id="txtCustomer_Pk" styles='width:0%;display:none' /></td>
                                    <!--td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtCustomer_Cd.text='';txtCustomer_Nm.text='';txtCustomer_Pk.text='';" /></td-->
                                </tr>
                            </table>
                        </td> 
                        <td align="right">Status&nbsp;</td>
                        <td width="" colspan="" style="background-color:white"><gw:label id="lblStatus" styles='width:100%'  /></td>
                    </tr>
                    
                    <tr style="background:#C5EFF1;height:">
                        <td align="right" >Contract</td>
                        <td colspan="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="100%"><gw:textbox id="txtContract" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                    <td width=""><gw:textbox id="txtContract_Pk" styles='width:0%;display:none' /></td>
                                    <!--td><gw:imgbtn id="btnonfim" img="reset" alt="Reset" onclick="txtContract.text='';txtContract_Pk.text='';" /></td-->
                                </tr>
                            </table>
                        </td>  
                        <td width="" align="right">Seq&nbsp;</td>
                        <td width="42%"><gw:textbox id="txtSeq" readonly="true" styles='width:100%' /></td>
                    </tr>
                    
                    <tr style="background:#C5EFF1;height:">
                        <td width="" align="right"><a title="Request No" style="color:#333">Req. No&nbsp;</a></td>
                        <td colspan="">
                        	<table cellpadding="0" cellspacing="0" width="100%">
                            	<tr>
                                	<td width="45%"><gw:textbox id="txtRequest_No" csstype="mandatory" styles='width:100%'  /></td>
                                	<td width="20%" align="right"><a href="#" title="Click here to show Request Type" onClick="OnPopUp('RequestType')" style="text-decoration:none" >Req.Type&nbsp;</a></td>
                        			<td width="35%" colspan=""><gw:list id="lstReqType" onchange="ChangeReqType()" styles='width:100%'  /></td>
                                    
                                </tr>
                            </table>
                        </td>
                        <td align="right"><a title="Request Date" style="color:#333">Req.Date&nbsp;</a></td>
                        <td width="" colspan=""><gw:datebox id="dtRequestDate" styles='width:100%' lang="1" /></td>
                    </tr>
                    <tr style="background:#C5EFF1;height:">
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width=""align=""><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow(1)" /></td>
                                    <td align="right" width="100%"><a title="Progress Date" style="color:#333">Pro. Date&nbsp;</a></td>
                                </tr>
                            </table>
                        </td>
                        <td width="" colspan="">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><gw:datebox id="dtProgressDate_Fr" styles='width:100%' lang="1" />~<gw:datebox id="dtProgressDate_To" styles='width:100%' lang="1" /></td>
                                    <td align="right" width="100%">Plan Receive&nbsp;</td>
                                    <td><gw:datebox id="dtPlanReceive" styles='width:100%' lang="1" /></td>
                                </tr>
                            </table>
                        </td>
                        <td align="right"><a title="Request Times" style="color:#333">Req.Times&nbsp;</a></td>
                        <td width=""><gw:textbox id="txtReq_Times" styles='width:100%'  csstype="mandatory" /></td>
                    </tr>
                    <tr id="_1" style="background:#C5EFF1;height:">
                        <td align="right"><a  title="Click here to show Payment Method"  style="text-decoration:none" href="#" onClick="OnPopUp('PMethod')" >P. Method.&nbsp;</a></td>
                        <td width="" colspan="3"><gw:list id="lstPaymentMethod"  styles='width:100%' /></td>
                        
                    </tr>
                    <tr id="_2" style="background:#C5EFF1;height:">
                        <td align="right" width="">Bank Acc.No</td>
                        <td width="" colspan="3">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtBankAccNo1_Cd"  readonly="true" styles='width:100%' /></td>
                                    <td width="70%"><gw:textbox id="txtBankAccNo1_Nm"  readonly="true" styles='width:100%' /></td>
                                    <td width=""><gw:textbox id="txtBankAccNo1_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                    <!--td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtBankAccNo1_Cd.text='';txtBankAccNo1_Nm.text='';txtBankAccNo1_Pk.text='';" /></td-->
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="_3" style="background:#C5EFF1;height:">
                        <td align="right" width="">Bank Acc.No</td>
                        <td width="" colspan="3">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtBankAccNo2_Cd"  readonly="true" styles='width:100%' /></td>
                                    <td width="70%"><gw:textbox id="txtBankAccNo2_Nm"  readonly="true" styles='width:100%' /></td>
                                    <td width=""><gw:textbox id="txtBankAccNo2_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                    <!--td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtBankAccNo2_Cd.text='';txtBankAccNo2_Nm.text='';txtBankAccNo2_Pk.text='';" /></td-->
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="_4" style="background:#C5EFF1;height:">
                            <td  align="right" style="width:">Attach File&nbsp;</td> 
                            <td colspan="3">
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="100%">
                                                <gw:grid id="Grid_Attach" 
                                                header="File Name|Size|Description|_pk|_Master_pk" 
                                                format="0|0|0|0|0"
                                                aligns="0|0|0|0|0" 
                                                defaults="||||" 
                                                editcol="0|0|1|0|0" 
                                                widths="3000|1500|1000|0|0" styles="width:100%; height:100"
                                                sorting="T" 
                                                oncelldblclick="OnOpenFile()" />
                                        </td>
                                        <td width="" valign="top">
                                            <gw:imgbtn id="btnAttach" img="attach" alt="Attach" onclick="OnAttach()" />
                                            <gw:imgbtn id="btnSaveAttach" img="save" alt="Save" onclick="OnSave('Attach')" />
                                            <gw:imgbtn id="btnDeleteAttach" img="delete" alt="Delete" onclick="OnDelete('Attach')" />
                                        </td>
                                        
                                    </tr>
                                </table>
                            </td>
                                       
                    </tr>

                    
                    <tr style="background:#C5EFF1;height:">
                        <td align="right"><a title="Description" style="color:#333">Description&nbsp;</a></td>
                        <td colspan="3"><gw:textbox id="txtDescription" styles='width:100%' /></td>
                       
                    </tr>
                    <tr style="background:#C5EFF1;height:">
                        <td align="right"><a title="Local Description" style="color:#333">L. Description&nbsp;</a></td>
                        <td colspan="3"><gw:textbox id="txtLocal_Description" styles='width:100%' /></td>
                    </tr>
                    <tr style="height:">
                                    <td colspan="4">
                                        <table cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:100%" border="1">
                                            <tr style="background:#C5EFF1;height:20">
                                                <td width="20%"></td>
                                                <td align="center" width="27%" style="">
                                                    <table cellpadding="0" cellspacing="0" >
                            	                        <tr>
                                                            <td width="" style="white-space:nowrap"><a title="Click here to show Order Currency" href="#" style="text-decoration: none" onClick="OnPopUp('currency')">Order CCY&nbsp;</a></td>
                                                            <td width="38%"><gw:list id="lstOrder_Ccy" onchange="dso_get_rate_Order.Call();" styles='width:100%'  /></td>
                                                            <td width="2%"></td>
                                                            <td width="60%"><gw:textbox id="txtOrder_ExRate" styles='width:100%' type="number"  format="###,###" /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="center" width="27%">
                                                    <table cellpadding="0" cellspacing="0" width="100%">
                            	                        <tr>
                                                            <td width="" style="white-space:nowrap"><a title="Click here to show Invoice Currency" href="#" style="text-decoration: none" onClick="OnPopUp('Invoice')">Inv. CCY&nbsp;</a></td>
                                                            <td width="38%"><gw:list id="lstInvoice_Ccy" onchange="" styles='width:100%'  /></td>
                                                            <td width="2%"></td>
                                                            <td width="60%"><gw:textbox id="txtInvoice_ExRate" type="number"  format="###,###" styles='width:100%;text-align:right'  onenterkey="OnCalc_Control()"  /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="center" width="26%">
                                                    <table cellpadding="0" cellspacing="0" width="100%">
                            	                        <tr>
                                                            <td width="" style="white-space:nowrap"><a title="Click here to show Book Currency" href="#" style="text-decoration: none" onClick="OnPopUp('BCCY')">BCCY&nbsp;</a></td>
                                                            <td width="38%"><gw:list id="lstBook_Ccy" onchange="dso_get_rate_book.Call();" styles='width:100%'  /></td>
                                                            <td width="2%"></td>
                                                            <td width="60%"><gw:textbox id="lblBook_Rate" type="number"  format="###,###" styles='width:100%;text-align:right' onenterkey="OnCalc_Control()"   /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right">Progress Amt(1)&nbsp;</td>
                                                <td width=""><gw:textbox id="txtProgress1_Amt" type="number" onenterkey="OnCalc_Control()" onblur="OnCalc_Control()" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtProgress2_Amt" type="number" onenterkey="" onblur="" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtProgress3_Amt" type="number" onenterkey="" onblur="" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right"><a title="(2) = (1) * VAT Rate(come from 1.0.5)" style="color:#333">VAT Amt(2)&nbsp;</a></td>
                                                <td width=""><gw:textbox id="txtVAT1_Amt" type="number" onenterkey="" onblur="OnCalc_Control()" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtVAT2_Amt" type="number" onenterkey="" onblur="" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtVAT3_Amt" type="number" onenterkey="" onblur="" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right"><a title="(3) = (1) * Retention(come from 1.0.5)" style="color:#333">Retention Amt(3)&nbsp;</a></td>
                                	            <td width=""><gw:textbox id="txtRetention1_Amt" type="number" onenterkey="onChangemanual_amt();ChangeReqType()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtRetention2_Amt" type="number" onenterkey="onChangemanual_amt()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtRetention3_Amt" type="number" onenterkey="onChangemanual_amt()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right">Withholding Tax Amt(4)&nbsp;</td>
                                	            <td width=""><gw:textbox id="txtWithholdingTax1_Amt" type="number" onenterkey="onChangemanual_amt()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtWithholdingTax2_Amt" type="number" onenterkey="onChangemanual_amt()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtWithholdingTax3_Amt" type="number" onenterkey="onChangemanual_amt()" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right"><a title="(5) = (1) * Advance Rate(come from 1.0.5)" style="color:#333">Adv Deduct Amt(5)&nbsp;</a></td>
                                	            <td width=""><gw:textbox id="txtAdvDeduct1_Amt" type="number" onenterkey="onChangemanual_amt();ChangeReqType;dso_adv_deduct_can.Call();" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtAdvDeduct2_Amt" type="number" onenterkey="onChangemanual_amt();dso_adv_deduct_can.Call();" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtAdvDeduct3_Amt" type="number" onenterkey="onChangemanual_amt();dso_adv_deduct_can.Call();" onblur="onChangemanual_amt()" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td align="right"><a title="(6) = (3) + (4) + (5)" style="color:#333">Total Deduct Amt(6)&nbsp;</a></td>
                                	            <td width=""><gw:textbox id="txtTotalDeduct1_Amt" type="number" readonly="T" format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtTotalDeduct2_Amt" type="number" readonly="T" format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtTotalDeduct3_Amt" type="number" readonly="T"" format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                            <tr style="background:#C5EFF1;height:2%">
                                                <td>
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width=""align=""><img status="expand" id="img4" src="../../../system/images/up.gif" style="cursor: hand;display:none"  onclick="OnShow(2)" /></td>
                                                            <td align="right" width="100%"><a title="(7) = (1) + (2) - (6)" style="color:#333">This Payment(7)&nbsp;</a></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                
                                	            <td width=""><gw:textbox id="txtThisPayment1" type="number" readonly="T"   format="###,###.##R"  styles='width:100%' /></td>
                        			            <td width=""><gw:textbox id="txtThisPayment2" type="number" readonly="T"   format="###,###.##R"  styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtThisPayment3" type="number" readonly="T"   format="###,###.##R"  styles='width:100%' /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                    <tr id="_5" style="height:">
					<td colspan="4" width="100%" >
						<table border="1" width="100%" cellpadding=0 cellspacing=0 bordercolor="#00FFFF">
							<tr>
								<td width="60%" valign=top id="tdGrid">
								  <table border="0" width="100%" cellpadding=0 cellspacing=0>
									<tr>
										<td width="5%" align="center">
                                                    <a onclick="OnSumDR()" href="#tips">Debit</a></td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_dr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_dr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="10%" align="center">
                                                    Total</td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_dr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_dr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnNew_Dr" img="new" alt="New" styles="width:100%;display:none" onclick="OnNewDr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_dr" img="save" alt="Save" onclick="OnSave('Dr')" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Dr" img="delete" styles="width:100%;display:none" alt="Delete" onclick="OnDelDr()" />
                                                </td>
                                               
                                                <td width="3%">
                                                </td>
									</tr>
									<tr >
									   <!--0_Pk|1_Acc_pk|2check|3 type ref|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.mount Book|10.Description|11.Local Description|12_Expense Type|13_m_pk|14_ODR|15_DRCR|16_ChkTreat|17.Book Rate|18Tmp Rate|19_bookccy|20_tco_buspartner_pk|21_tac_abplcenter_pk|22_BUS_ID|23_BUS_NM-->
										<td colspan="10" width="width: 100%">
											<gw:grid id="grdDebit" 
											header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|_Tmp Rate|_bookccy|_tco_buspartner_pk|_tac_abplcenter_pk|BUS_ID|BUS_NM"
											format="0|0|3|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
											aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3|0|0|0|0|0"
											defaults="||||||VND||||||||||||||||0|0" 
											editcol="1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
											widths="0|0|250|300|1500|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000|0|0|0|0|0"
											styles="width:100%; height:200" 
											sorting="F"  
											oncelldblclick="OnPopUp('Edit_Dr')" 
											oncellclick="RowClick_DR()"
											/>
										</td>
									</tr>
									<tr>
										 <td width="5%" align="center">
                                                    <b><a onclick="OnSumCR()" href="#tips">Credit</a></td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_cr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_cr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##.##R" />
                                                </td>
                                                <td width="10%" align="center">
                                                    Total</td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_cr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_cr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnNew_Cr" img="New" styles="width:100%;display:none" alt="New credit" onclick="OnNewCr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_cr" img="save" alt="Save" onclick="OnSave('Cr')" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Cr" img="delete" styles="width:100%;display:none"  alt="Delete" onclick="OnDelCr()" />
                                                </td>
                                               
                                            
                                                <td width="3%" align="right">
                                                    <img status="expand" id="img1" src="../../../system/images/next_orange.gif"
                                                        style="cursor: hand;" onclick="OnToggle_dtl()" /></img></td>
									</tr>
									<tr >
									<td colspan="10" width="width: 100%">
										<gw:grid id="grdCredit" 
										header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|_Tmp Rate|_bookccy|_tco_buspartner_pk|_tac_abplcenter_pk|BUS_ID|BUS_NM"
										format="0|0|3|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3|0|0|0|0|0"
										defaults="||||||VND|||||||||||||0|0|0|0|0" 
										editcol="1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
										widths="0|0|250|300|1500|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000|0|0|0|0|0"
										styles="width:100%; height:200" 
										sorting="F"
										oncelldblclick="OnPopUp('Edit_Cr')" 
										oncellclick="RowClick_CR()"
										/>
									</td>
								</tr>

								</table>
								
								</td>
								
								<td width="40%"  id="tdControlItem" style="height:100%" valign="top" >
									<table border="0" style="height:100%" width="100%" cellpadding=0 cellspacing=0>
										<tr height="2%">
										  <td width="100%" align="left"> Control Item</td>
										  <td width="" align="right"><gw:icon id="btnTreament" img="in" text="Treatment" onclick="OnTreament()" styles="width:100%" /></td>
										</tr>
										<tr height="98%">
											<td colspan="3" width="100%" >
												 <gw:neogrid id="idGridItem" styles="width:100%;height:100%" oncelldblclick="ClickItemControl()"
													onafteredit="ChangeData_Upper()"> 
													<XML>
														<xmlblock>
															
															<column title="itempk" hidden='T'>
																<textbox type="number" format="######"/>
															</column>

															<column title="detailpk" hidden='T'>
																<textbox type="number" format="######" />
															</column>

															<column title="acctpk" hidden='T'>
																<textbox type="number" format="######" />
															</column>

															<column title="INPUT TYPE" hidden='T'>
																<textbox  format="3" />
															</column>

															<column title="dsqlid" hidden='T'>
																<textbox  format="3" />
															</column>

															<column title="dsql" hidden='T'>
																<textbox  format="3" />
															</column>

															<column title="mandatory" hidden='T'>
																<textbox  format="3" />
															</column>

															<column title="data type" hidden='T'>
																<textbox  format="3" />
															</column>

															<column title="Item Alias" width='1500' editmode="0" >
																<textbox  format="3" />
															</column>

															<column title="Item code"  width='2500'>
																<multiple ref="7"  >
																	<textbox type="number" format="###,###C" value="" />
																	<textbox format="50" value="" />
																	<datebox type="day" format=""  lang="1" acceptnull="T"/>
																	<checkbox />	
																	<htmledit value="[New]" />				
																</multiple>
															</column>
															
															<column title="Item name" width='1500'>
																<textbox/>
															</column>
															
															<column title="TABLE NM" hidden='T'>
																<textbox  />
															</column>
															
															<column title="TABLE PK" hidden='T'>
																<textbox  />
															</column>
														</xmlblock>
													</xml>
												</gw:neogrid>
											</td>
											
										</tr>
									</table>
								
								</td>
							</tr>
						</table>

					</td>
                 </tr>
                    <tr style="display:none">
                    <td colspan="4">
                    	
                        
                        <gw:textbox id="txtCompany_Pk"        styles='display:none'/>
                         <gw:list id="lstBookExRate" styles="width:100%;display:none" />
						<gw:textbox id="txt_row" text="1"       styles='display:none'/>
                        <gw:textbox id="txtConfirm"        styles='display:none'/>
                        <gw:textbox id="txtMonth"        styles='display:none'/>
                        <gw:textbox id="txtRtn"        styles='display:none'/>
                        <gw:textbox id="txtDepositAccNo_Pk"        styles='display:none'/>
                        
						</td>
                    </tr>
                </table>
            </td>
        </tr>
   </table>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;position:absolute; left:1; top: 0;display:" onClick="OnToggle()" /> 
<gw:image id="imgFile" table_name="TECPS_128CONTRACT_FILE" view="/binary/ViewFile.aspx"  post="/binary/PostFile.aspx" styles="width:100;height:100;display:none" />
<gw:textbox id="txtVAT_RATE_105"        styles='display:none'/>
<gw:textbox id="txtAdvance_105"        styles='display:none'/>
<gw:textbox id="txtRetention_105"        styles='display:none'/>    
<gw:textbox id="txtbookccy"        styles='display:none'/> 
<gw:textbox id="txtMasterPK"        styles='display:none'/>
                        
<gw:textbox id="txtAdvance_Amt_105"        styles='display:none'/>
<gw:textbox id="txtCcy_105"        styles='display:none'/>
<gw:textbox id="txtDRCRtype"        styles='display:none'/>
<gw:textbox id="txt_rowclick" style="display: none" />
<gw:textbox id="txtacpk"  styles='display:none' />
<gw:textbox id="txtTECPS_MCTREQUESTD_PK"  styles='display:none' />
<gw:textbox id="txttac_abplcenter_pk"  styles='display:none' />
<gw:list id="lstCompany" value="" styles='width:100%;display:none' />
<gw:textbox id="txtVAT1_Amt_temp"  styles='display:none' />
<gw:textbox id="txt_adv_deduct_can"  styles='display:none' />
</body>
</html>