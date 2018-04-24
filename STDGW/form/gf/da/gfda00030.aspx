<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
var  g_lang   = "<%=Session("SESSION_LANG")%>"  ;
var  g_emp_pk = "<%=Session("EMPLOYEE_PK")%>" ;
var  g_user_name = "<%=Session("USER_NAME")%>" ;
var  g_user_id = "<%=Session("USER_ID")%>" ;
var  g_user_pk = "<%=Session("USER_PK")%>" ;
var  g_ins_grdMst = false ;
var  g_del_grdMst = false ;
var g_trans_pk = '', g_trans_cd = '', g_trans_nm = '';
var g_0_voucher_no		= 0,
	g_0_seq				= 1,
	g_0_trans_dte		= 2,
	g_0_invoice_no		= 3,	
	g_0_trans_amt		= 4,
	g_0_books_amt		= 5,
	g_0_allexp_accrue_pk = 6;
	
// grid grdDtl
var g_0_tac_allexp_accrued_pk  	= 0,
	g_0_tco_item_pk 			= 1,
	g_0_item_code				= 2,
	g_0_item_name				= 3,
	g_0_tac_abacctcode_pk		= 4,
	g_0_account_code			= 5,
	g_0_account_name			= 6,
	g_0_trans_org				= 7,
	g_0_books_org				= 8,
	g_0_trans_allo				= 9,
	g_0_books_allo				= 10,
	g_0_trans_act				= 11,
	g_0_books_act				= 12,
	g_0_description				= 13,
	g_0_local_desc				= 14,
	g_0_tac_crdad_pk			= 15,
	g_0_MstPK       			= 16;
function BodyInit()
{	
    System.Translate(document);
    BindingDataList();    	
}
//--------------------------------------------------
function BindingDataList()
{
    var ls_data         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 order by 1")%>";
    lstCompany.SetDataText(ls_data);
	ls_data      = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
	lstCCY.SetDataText(ls_data);
    ls_data      = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('ACBG0130') FROM DUAL")%>";
	lstVoucherType.SetDataText(ls_data);
	lstVoucherType.value = "AP";
	ls_data = "<%=ESysLib.SetListDataSQL("select TRIM(CODE) code, A.CODE code_nm FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'ACBG0040' and A.def_yn = 'Y'")%>";
	lstBook_Ccy.SetDataText(ls_data);	
	var ls_dt = dtTrans.value ;		
	txtTransDT.text = ls_dt ;
	ls_data = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL ")%>" + "|ALL|Select All";	
	lstSliStatus.SetDataText(ls_data);	
	lstSliStatus.value = "ALL";
	lstStatus.SetDataText(ls_data);
	var l_today = dtTrDatefr.value ;
	dtTrDatefr.value = l_today.substring(0, 6) + "01";
	ls_data = "<%=ESysLib.SetDataSQL("select pk from tac_abtrtype where tr_type = 'YAPF' and del_if = 0 ")%>";
	txtTransPK.SetDataText(ls_data);
	g_trans_pk = ls_data ;
	ls_data = "<%=ESysLib.SetDataSQL("select tr_type from tac_abtrtype where tr_type = 'YAPF' and del_if = 0 ")%>";
	txtTransCD.SetDataText(ls_data);
	g_trans_cd = ls_data ;
	ls_data = "<%=ESysLib.SetDataSQL("select tr_tpnm from tac_abtrtype where tr_type = 'YAPF' and del_if = 0 ")%>";
	txtTransNM.SetDataText(ls_data);
	g_trans_nm = ls_data ;
	
	OnFormatHeader();
	OnNew('Master');
	dso_get_rate.Call();
}
//--------------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//--------------------------------------------------------------
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//-----------------------------------------------------------------------
function SetExRate()
{
	if(Number(txtBookRate.text) == 0)
	{
		alert('   Rate is not null!!!'+'\n'+'Tỉ giá giao dịch không được rỗng!!!');
	}
}
//-----------------------------------------------------------------------
function OnSearch(iCase)
{
	switch(iCase)
	{
		case '1':
			dso_allexp_accrue_list.Call("SELECT");			
		break ;
		case '2':
				txttac_allexp_accrue_pk.text = grdSearch.GetGridData(grdSearch.row, g_0_allexp_accrue_pk);				
				grdMst.Call("SELECT");
		break ;
	}
}
//-----------------------------------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
		case 'dso_allexp_accrue_list':			
		break ;
		case 'grdMst':
    		OnSearchTab();
		break;
		case 'dso_allexp_dtl':
		    OnFormatHeader();
		    OnFormatGrid();
		break;
		case 'dso_confirm':
		    grdMst.Call('SELECT');
		break;
		case 'dso_cancel':
		    grdMst.Call('SELECT');
		break;
		case 'dso_replicate':
		    grdMst.Call('SELECT');
		break;
	}
}
//-----------------------------------------------------------------------
function OnNew(iCase)
{
	switch(iCase)
	{
		case 'Master':
			if(grdMst.GetStatus()==20)
			{
				alert("Already in inserted status");
			}
			else
			{
				grdMst.StatusInsert();
				g_ins_grdMst = true ;
				txtTransCD.SetDataText(g_trans_cd);
				txtTransNM.SetDataText(g_trans_nm);
				txtTransPK.SetDataText(g_trans_pk);
				txtExRate.SetDataText('1');
				lstStatus.value = '1';
			}	
		break ;
	}
}
//-----------------------------------------------------------------------
function OnValidateData(iCase)
{
	switch(iCase)
	{
		case 'grdMst':
			if(Trim(txtIssueInv.text)=="")
			{
				alert("Issued Invoice is not null" + "\n" + "Hóa đơn thì không được rỗng");
				return false ;	
			}
			else if(Trim(txtVendorPK.text) == "")
			{
				alert("Vendor is not null" + "\n" + "Nhà cung cấp thì không được rỗng");
				return false ;					
			}
			else if(Trim(txtAccPK.text)=="")
			{
				alert("Account code is not null" + "\n" + "Mã số tài khoản thì không được rỗng");
				return false;
			}
			else if(lstCCY.value == "")
			{
				alert("Currency is not null" + "\n" + "Tiền giao dịch thì không được rỗng");
				return false;				
			}
			else if(Trim(txtExRate.text)=="" || Number(txtExRate.text) == 0)
			{
				alert("Exchange rate is not null" + "\n" + "Tỷ giá giao dịch thì không được rỗng");
				return false;							
			}
			else if(Trim(txtDesc_1.text) == "")			
			{
				alert("Description is not null" + "\n" + "Diễn giải thì không được rỗng");
				return false;											
			}
			else if(Trim(txtLocalDesc_1.text) == "")			
			{
				alert("Local description is not null" + "\n" + "Diễn giải tiếng Việt thì không được rỗng");
				return false;											
			}
			else if(chkAuto.value == "F" && txtvoucher_no.GetData() == "")
			{
				alert("Voucher No is not null" + "\n" + "Mã số chứng từ thì không được rỗng");
				return false;															
			}
			return true;
		break ;
	}
}
//-----------------------------------------------------------------------
function OnSave(iCase)
{
	if(iCase=="1")
	{
		if(OnValidateData("grdMst"))
		{			
			grdMst.Call();	
		}
	}
}
//-----------------------------------------------------------------------
function OnPopUp(iCase)
{
	switch(iCase)
	{
		case 'Trans Type':
			if(txtStatus.text == '1' || txtStatus.text == '')
			{
				var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCompany.value;
				var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
				if( object != null )
				{
					var tmp = object[0];
					if (tmp[1] != null)
					{
						txtTransCD.text = tmp[1];
						txtTransNM.text = tmp[2];
						txtTransPK.text = tmp[0];
					}                
				}            					
			}
		break ;
		case 'Account':
			if(txtStatus.text == '1' || txtStatus.text == '')
			{
				var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=331" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
				o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if (o != null)
				{
					if(o[0] != 0)
					{
						txtAccPK.text = o[3];  	// account pk
						txtAccCD.text = o[0]; 	// account code
						txtAccNM.text = o[1] ; 	// account name
					}
					txtseq.GetControl().focus();
				}			
			}
		break;
		case 'Vendor':
			if(txtStatus.text == '1' || txtStatus.text == '')
			{
				var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
				var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
				if ( object != null )
				{
					if (object[0] != 0)
					{
						txtVendorPK.text = object[0];
						txtVendorNM.text = object[2];
						txtVendorCD.text = object[1];					
					}
				}	
			}
		break ;
	}
}
//-----------------------------------------------------------------------
function Add_CtrlItem()
{
    var fg = grdInfor.GetGridControl();
    if (grdInfor.selrow > 0)
    {
        for (i = 1; i < grdInfor.rows; i++)
        {
            fg.RowSel = 0;
	        fg.isSelected (i) = false;
        }
    }
	grdInfor.AddRow();
	fg.RowSel = grdInfor.rows - 1;
	fg.isSelected (grdInfor.rows - 1) = true;
	grdInfor.SetGridText(grdInfor.rows - 1, 7, txttac_allexp_accrue_pk.GetData());	
}
//-----------------------------------------------------------------------
function PopupClickCtrl_Item()
{
    if ((event.col == 2) || (event.col == 3))
    {
		var path   = System.RootURL + "/form/gf/co/gfco002006.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + '' + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_POPUP_ITEM_N" + '&col_code=Item Name' + '&col_nm=Item Name Local';
		aValue     = System.OpenModal( path, 500, 500, 'resizable:yes;status:yes');
		if (aValue != null) 
        {
            if (aValue.length > 0)
            {
                for (i = 0; i < 1; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[0] != 0)
                    {
                        grdInfor.SetGridText(grdInfor.selrow, 1, tmp[0]);     // PK
                        grdInfor.SetGridText(grdInfor.selrow, 2, tmp[2]);     // Item Name
                        grdInfor.SetGridText(grdInfor.selrow, 3, tmp[3]);     // Item Name Local
                        grdInfor.SetGridText(grdInfor.selrow, 4, tmp[4]);     // InType
                        grdInfor.SetGridText(grdInfor.selrow, 6, "");         // Item						
				        grdInfor.SetGridText(grdInfor.selrow, 9, "");         // Item NM
						
				        if (tmp[5] == 'N')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 0); // DataType
				        }
				        else if (tmp[5]== 'D')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 2); // DataType
				        }
				        else
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 1); // DataType
				        }
				        if (tmp[4] == "T" | tmp[4] == "C")
		                {
	                        if(tmp[4] == "T")
	                        {
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xEFFFFF);	
	                        }
	                        else
	                        {								
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xF4E6E0);
	                        }
	                        grdInfor.SetRowEditable(grdInfor.selrow + i, false);
		                }
        		        if (tmp[2] == 'INVOICE NO')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, txtIssueInv.text);
		                }
		                else if (tmp[2] == 'INVOICE DATE')
		                {
							grdInfor.SetGridText(grdInfor.selrow + i, 6, dtTrDatefr.value);
		                }
                    }
                }
                for(i=1; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[1] != 0)
                    {
                        grdInfor.AddRow();
                        grdInfor.SetGridText(grdInfor.selrow + i, 1, tmp[0]);     // PK
                        grdInfor.SetGridText(grdInfor.selrow + i, 2, tmp[2]);     // Item Name
                        grdInfor.SetGridText(grdInfor.selrow + i, 3, tmp[3]);     // Item Name Local
                        grdInfor.SetGridText(grdInfor.selrow + i, 4, tmp[4]);     // InType
                        grdInfor.SetGridText(grdInfor.selrow + i, 6, "");         // Item
				        grdInfor.SetGridText(grdInfor.selrow + i, 9, "");         // Item NM
				        if (tmp[5] == 'N')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 0); // DataType
				        }
				        else if (tmp[5]== 'D')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 2); // DataType
				        }
				        else
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 1); // DataType
				        }
				        if (tmp[4] == "T" || tmp[4] == "C")
		                {
	                        if(tmp[4] == "T")
	                        {
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xEFFFFF);	
	                        }
	                        else
	                        {
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xF4E6E0);
	                        }
	                        grdInfor.SetRowEditable(grdInfor.selrow + i, false);
		                }
        		        if (tmp[2] == 'INVOICE NO')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, txtIssueInv.text);
		                }
		                else if (tmp[2] == 'INVOICE DATE')
		                {
							grdInfor.SetGridText(grdInfor.selrow + i, 6, dtTrans.value);
		                }
                    }
                }
                txtseq.GetControl().focus();
            }
        }
	}
	else if (event.col == 6)
	{
	    onDBList();
	}
}
//------------------------------------------------------------
function onDBList()
{
    var ctrl = grdInfor.GetGridControl();
    if ((grdInfor.GetGridData( ctrl.row, 4) == 'T') || (grdInfor.GetGridData(ctrl.row, 4) == 'C'))
	{
		if (grdInfor.GetGridData( ctrl.row, 4) == 'C')
		{
		    var ls_str = grdInfor.GetGridData(ctrl.row, 2);
			var temp = new Array();
            temp = ls_str.split(' ');
			var ls_temp = temp[0];			
			var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + ls_str + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_ITEMNM_POPUP&col_code=' + ls_temp +" CODE" + '&col_nm=' + ls_temp + " NAME";
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {					
                    grdInfor.SetGridText(ctrl.row, 6, object[1]);
                    grdInfor.SetGridText(ctrl.row, 8, object[2]);
                    //grdInfor.SetGridText(ctrl.row, 9, object[]);
                }
            }
        }
        else
        {
            if (grdInfor.GetGridData( ctrl.row, 2) == 'CUSTOMER NAME')
	        {
	            var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		        var object  = System.OpenModal( path ,800 , 550 , 'resizable:yes;status:yes');
		        if ( object != null )
		        {
		            if (object[0] != 0)
                    {
		                grdInfor.SetGridText(ctrl.row, 6, object[0]);
		                grdInfor.SetGridText(ctrl.row, 8, object[2]);		                
		                grdInfor.SetGridText(ctrl.row, 9, object[1]);
		            }
                }
            }
            else if ( grdInfor.GetGridData(ctrl.row, 2)== "Bank Account No." || grdInfor.GetGridData( ctrl.row, 2 )== "DEPOSIT ACCOUNT NO" || grdInfor.GetGridData( ctrl.row, 2 )== "BANK ACCOUNT NUMBER" || grdInfor.GetGridData( ctrl.row, 2 )== "BANK ACCOUNT NO.")
	        {
	            var ls_ccy = txtcur.GetData();
	            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + ls_ccy + "&company="+ lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
                var object  = System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                    if (object[0] != 0)
                    {
                        grdInfor.SetGridText(ctrl.row, 6, object[0]);  // Item
                        grdInfor.SetGridText(ctrl.row, 8, object[4]);  // Table PK
                        grdInfor.SetGridText(ctrl.row, 9, object[1]);  // Table PK
                    }
                }
            } 
            else if (grdInfor.GetGridData( ctrl.row, 2)== "EMPLOYEE NAME")
            {
                var fpath   = System.RootURL + "/form/gf/co/ffco002003.aspx";
                var object  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes'); 
                if ( object != null )  
                {
                    if (object[0] != 0)
                    {
                        grdInfor.SetGridText(ctrl.row,  6, object[2]) ; //Employee ID
                        grdInfor.SetGridText(ctrl.row,  8, object[0]) ; //Employee Name    
                        grdInfor.SetGridText(ctrl.row,  9, object[1]) ; //Employee CODE    
                    }
                }
            }
        }
    }
}
//------------------------------------------------------------
function Save_CtrlItem()
{
    var i;
    if(grdInfor.rows > 1)
    {
        var mstPK = grdInfor.GetGridData(1, 7) ;
        for(i = 2; i < grdInfor.rows; i++)
        {
            grdInfor.SetGridText(i, 7, mstPK);
        }
    }        
    dso_allexp_ctrl_item.Call();
}
//------------------------------------------------------------
function OnSearchTab()
{
	if(idTab_Child.GetCurrentPageNo()==0)
	{
		dso_allexp_ctrl_item.Call("SELECT");
	}
	else if(idTab_Child.GetCurrentPageNo()==1)
	{
		dso_allexp_dtl.Call('SELECT');
	}
}
//------------------------------------------------------------
function OnAdd_Item()
{        
	var fpath   = System.RootURL + "/form/gf/da/gfda00010_popup.aspx?company=" + lstCompany.value;
	var object  = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes'); 
    if(object != null)
    {	
        var i, j ;
        for(i = 0; i < object.length; i++)
        {
            var arr = new Array();
	        grdDtl.AddRow();
	        arr = object[i];
	        j = grdDtl.rows - 1;
	        grdDtl.SetGridText(j, g_0_tco_item_pk, arr[11]); // item pk
	        grdDtl.SetGridText(j, g_0_item_code, arr[2]); // item code
	        grdDtl.SetGridText(j, g_0_item_name, arr[3]); // item name
	        grdDtl.SetGridText(j, g_0_tac_abacctcode_pk, arr[12]); // account pk
	        grdDtl.SetGridText(j, g_0_trans_org, arr[6]); // net trans amt
	        grdDtl.SetGridText(j, g_0_books_org, arr[7]); // net books amt
	        grdDtl.SetGridText(j, g_0_description, arr[8]); // description
	        grdDtl.SetGridText(j, g_0_local_desc, arr[9]); // local description
	        grdDtl.SetGridText(j, g_0_tac_crdad_pk, arr[10]); // tac_crdad_pk	        
	        grdDtl.SetGridText(j, g_0_MstPK, txttac_allexp_accrue_pk.GetData()); // tac_crdad_pk	        
	    }    
	    /////Divide Allocation Fee Amount
	    var l_tr_amt_fee = 0, l_bk_amt_fee = 0;
	    var l_tr_amt_allct = 0, l_bk_amt_allct = 0, l_net_tr_amt_total = 0, l_net_tr_amt = 0;
	    l_tr_amt_fee = Number(txtTransAlloAmt.GetData());
	    l_bk_amt_fee = Number(txtBooksAlloAmt.GetData());
	    var l_sub_tr_amt = 0, l_sub_bk_amt = 0;
	    //// calculate total net amount of items or services here
	    l_net_tr_amt_total = 0;
	    for( i = 2; i < grdDtl.rows ; i++)
	    {
    	    l_net_tr_amt_total += Number(grdDtl.GetGridData(i, g_0_trans_org));
        }        	    
	    for( i = 2; i < grdDtl.rows ; i++)
	    {
	        ////////Sub at last row 
	        if(i == grdDtl.rows - 1)  
	        {
	            l_tr_amt_allct = l_tr_amt_fee - l_sub_tr_amt ;
	            l_bk_amt_allct = l_bk_amt_fee - l_sub_bk_amt ;
	        }	
	        else
	        {    
	            l_net_tr_amt = Number(grdDtl.GetGridData(i, g_0_trans_org));
	            ////////dividing here to get allocated amount 
	            // allocated expense Trans amount     
	            l_tr_amt_allct = Number(l_tr_amt_fee * l_net_tr_amt / l_net_tr_amt_total) ;	            
	            if(lstCCY.value == "VND")
	                l_tr_amt_allct = Math.round(l_tr_amt_allct);
                else
                    l_tr_amt_allct = Math.round(l_tr_amt_allct * 100) / 100;	           
                l_sub_tr_amt += l_tr_amt_allct;                      
                // allocated expense Books amount     
	            l_bk_amt_allct = Number(l_bk_amt_fee * l_net_tr_amt / l_net_tr_amt_total) ;
	            if(lstBook_Ccy.value == "VND")
	                l_bk_amt_allct = Math.round(l_bk_amt_allct);
                else
                    l_bk_amt_allct = Math.round(l_bk_amt_allct * 100) / 100;	            	            	        	         	        
                l_sub_bk_amt += l_bk_amt_allct;                    
            }     
            grdDtl.SetGridText(i, g_0_trans_allo, l_tr_amt_allct);               
            grdDtl.SetGridText(i, g_0_books_allo, l_bk_amt_allct);
            grdDtl.SetGridText(i, g_0_trans_act, Number(l_tr_amt_allct + l_net_tr_amt)); // total trans amt
            l_net_tr_amt = Number(grdDtl.GetGridData(i, g_0_books_org));
            grdDtl.SetGridText(i, g_0_books_act, Number(l_bk_amt_allct + l_net_tr_amt)); // total books amt
	    }
	}		
}
//------------------------------------------------------------
function OnDelete(iCase)
{
	if(iCase == '1')
	{
		if(confirm("Are you sure you want to delete this slip?"))
		{
			grdMst.StatusDelete();
			g_del_grdMst = true ;
			grdMst.Call();
		}
	}
}
//------------------------------------------------------------
function Delete_CtrlItem()
{
    var ctrl = grdInfor.GetGridControl();
    if (grdInfor.rows > 1)
    {
        var i;
        if (confirm('Are you sure you want to delete this Item ?'+'\n'+'Bạn có chắc muốn xóa Item này?'))
        {
            for ( i=1; i < ctrl.rows; i++ )
		    {
		        if (ctrl.isSelected(i) == true)
		        {
                    grdInfor.DeleteRow();
                }
            }
        }
    }
}
//------------------------------------------------------------
function OnFormatHeader()
{
	if(grdDtl.rows < 2)
		grdDtl.AddRow();
	var fg = grdDtl.GetGridControl();
    fg.FixedRows = 2; 
    fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true;    
    fg.MergeCells = 5;
	fg.MergeRow(0) = true;	
	fg.Cell(0, 0, g_0_tac_allexp_accrued_pk, 0, g_0_item_name) = 'Items';
	fg.Cell(0, 1, g_0_item_code, 1, g_0_item_code) = 'Item code';
	fg.Cell(0, 1, g_0_item_name, 1, g_0_item_name) = 'Item name';
	fg.Cell(0, 0, g_0_tac_abacctcode_pk, 0, g_0_account_name) = 'Account';
	fg.Cell(0, 1, g_0_account_code, 1, g_0_account_code) = 'Account code';
	fg.Cell(0, 1, g_0_account_name, 1, g_0_account_name) = 'Account name';
	fg.Cell(0, 0, g_0_trans_org, 0, g_0_books_org) = 'Org Amount';
	fg.Cell(0, 1, g_0_trans_org, 1, g_0_trans_org) = 'Trans';
	fg.Cell(0, 1, g_0_books_org, 1, g_0_books_org) = 'Books';	
	fg.Cell(0, 0, g_0_trans_allo, 0, g_0_books_allo) = 'Allocate Amount';
	fg.Cell(0, 1, g_0_trans_allo, 1, g_0_trans_allo) = 'Trans';
	fg.Cell(0, 1, g_0_books_allo, 1, g_0_books_allo) = 'Books';	
	fg.Cell(0, 0, g_0_trans_act, 0, g_0_books_act) = 'Actual Amount';
	fg.Cell(0, 1, g_0_trans_act, 1, g_0_trans_act) = 'Trans';
	fg.Cell(0, 1, g_0_books_act, 1, g_0_books_act) = 'Books';	
	fg.MergeCol(g_0_description) = true;
	fg.Cell(0, 0, g_0_description, 1, g_0_description) = 'Description';
	fg.MergeCol(g_0_local_desc) = true;
	fg.Cell(0, 0, g_0_local_desc, 1, g_0_local_desc) = 'Local Desc';	
}
//------------------------------------------------------------
/*function OnDblClickDtlItem()
{
	var i;
	var fpath   = System.RootURL + "/form/gf/da/gfda00030_popup.aspx?compk=" + lstCompany.value;
	var object  = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes'); 
	if ( object != null )  
	{	
		var l_arr = new Array();
		l_arr = object[0];
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_tco_item_pk, l_arr[3]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_item_code, l_arr[4]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_item_name, l_arr[5]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_ccy, l_arr[6]);
	
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_trans_org, l_arr[8]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_books_org, l_arr[9]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_tac_crdad_pk, l_arr[0]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_tac_abacctcode_pk, l_arr[10]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_account_code, l_arr[11]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_account_name, l_arr[12]);		
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_description, l_arr[13]);
		grdDtl.SetGridText(grdDtl.rows - 1, g_0_local_desc, l_arr[14]);			
		for(i = 1; i < object.length; i++)
		{
			var l_arr = new Array();
			l_arr = object[i];
			grdDtl.AddRow();
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_tco_item_pk, l_arr[3]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_item_code, l_arr[4]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_item_name, l_arr[5]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_ccy, l_arr[6]);			
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_trans_org, l_arr[8]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_books_org, l_arr[9]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_tac_crdad_pk, l_arr[0]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_tac_abacctcode_pk, l_arr[10]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_account_code, l_arr[11]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_account_name, l_arr[12]);		
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_description, l_arr[13]);
			grdDtl.SetGridText(grdDtl.rows - 1, g_0_local_desc, l_arr[14]);			
		}
	}
}
*/
//------------------------------------------------------------
function OnFormatGrid()
{
	var fg = grdDtl.GetGridControl();	
	fg.ColFormat(g_0_trans_org) = "###,###,###,###,###.##";
	fg.ColFormat(g_0_trans_allo) = "###,###,###,###,###.##";
	fg.ColFormat(g_0_trans_act) = "###,###,###,###,###.##";
	if(lstBook_Ccy.value == "VND")
	{
		fg.ColFormat(g_0_books_org) = "###,###,###,###,###";
		fg.ColFormat(g_0_books_allo) = "###,###,###,###,###";
		fg.ColFormat(g_0_books_act) = "###,###,###,###,###";
	}
	else
	{
		fg.ColFormat(g_0_books_org) = "###,###,###,###,###.##";
		fg.ColFormat(g_0_books_allo) = "###,###,###,###,###.##";
		fg.ColFormat(g_0_books_act) = "###,###,###,###,###.##";
	}	
}
//------------------------------------------------------------
function OnDelete_Item()
{
    var i, n = 0;
    var fg = grdDtl.GetGridControl();
    for(i = 2; i < grdDtl.rows ; i++)
    {
        if(fg.IsSelected(i)==true)
        {
            grdDtl.SetRowStatus(i, 0x40);            
            n += 1;
        }
    }
    if(n > 0)
    {
        dso_allexp_dtl.Call();
    }    
}
//------------------------------------------------------------
function OnSave_Item()
{
    grdDtl.SetRowStatus(0, 0x00);
    grdDtl.SetRowStatus(1, 0x00);
    dso_allexp_dtl.Call();
}
//------------------------------------------------------------
function OnConfirm()
{
    if(confirm('Are you sure you want to confirm this voucher?'))        
    {
        dso_confirm.Call();
    }
}
//-------------------------------------------------------------
function OnCancel()
{
    if(confirm('Are you sure you want to cancel this voucher?'))        
    {
        dso_cancel.Call();
    }    
}
//-------------------------------------------------------------
function OnReplicate()
{
    if(confirm('Are you sure you want to replicate this voucher?'))
    {
        dso_replicate.Call();
    }
}
//-------------------------------------------------------------
function OnPrint()
{
    if(txtseq.GetData() != '')
	{
	    var url = System.RootURL + "/reports/gf/hg/60080010_envn.aspx?seq=" + txtseq.GetData();
	    System.OpenTargetPage(url);        			
    }    
}
//-------------------------------------------------------------
</script>
<body style="margin:0; padding:0;">
<!-------------------------------------------------------------------------->
		<gw:data id="dso_get_rate" onreceive="SetExRate()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany" />
                     <input bind="lstCCY" />
                     <input bind="txtTransDT" />
                </input>
                <output>
                     <output bind="txtExRate"/>
                     <output bind="txtBookRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="dso_allexp_accrue_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.sp_sel_allexp_accrue_lst" >
                <input bind="grdSearch">
                    <input bind="lstCompany"/>
                    <input bind="dtTrDatefr" />
					<input bind="dtTrDateto" />
					<input bind="lstSliStatus" />
					<input bind="txtVoucherNo_Sr" />
					<input bind="txtSeq_Sr" />
                </input>
                <output bind="grdSearch"/>
            </dso>
        </xml>
    </gw:data>	

	<gw:data id="grdMst" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso type="control" parameter="0,1,2,3,4,6,7,8,11,14,15,16,17,18,19,20,23,24,25,26,28" function="acnt.sp_sel_allexp_accrue" procedure="acnt.sp_upd_allexp_accrue" > 				
				<inout>
					<inout bind="txttac_allexp_accrue_pk" />
					<inout bind="lstCompany" />
					<inout bind="lstVoucherType" />
					<inout bind="txtvoucher_no" />
					<inout bind="txtTrSeq" />
					
					<inout bind="txtseq" />
					<inout bind="txtIssueInv" />
					<inout bind="dtTrans" />
					<inout bind="txtVendorPK" />
					<inout bind="txtVendorCD" />
					
					<inout bind="txtVendorNM" />
					<inout bind="txtAccPK" />
					<inout bind="txtAccCD" />
					<inout bind="txtAccNM" />
					<inout bind="txtBookRate" />
					
					<inout bind="lstCCY" />
					<inout bind="txtExRate" />
					<inout bind="txtTransAlloAmt" />
					<inout bind="txtBooksAlloAmt" />
					<inout bind="txtDesc_1" />
					
					<inout bind="txtLocalDesc_1" />
					<inout bind="lstStatus" />
					<inout bind="txtBooksAmt_1" />
					<inout bind="txtVATTransAmt" />
					<inout bind="txtVATBookAmt" />
					
					<inout bind="txtVATDesc" />
					<inout bind="txtLocVATDesc" />		
					<inout bind="txtStatus" />		
					<inout bind="txtTransPK" />
					<inout bind="txtTransCD" />
					
					<inout bind="txtTransNM" />
				</inout>
			</dso> 
		</xml> 
	</gw:data>	
<!--------------------------------------------------------------------------------------------------->
    <gw:data id="dso_allexp_ctrl_item" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,4,5,6,7,8,9" function="acnt.sp_sel_ctrl_allexp_accrued" procedure="ACNT.sp_upd_ctrl_allexp_accrue">
                <input bind="grdInfor">
                    <input bind="txttac_allexp_accrue_pk"/>
                </input>
                <output bind="grdInfor"/>
            </dso>
        </xml>
    </gw:data>
<!--------------------------------------------------------------------------------------------------->
    <gw:data id="dso_allexp_dtl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,4,9,10,11,12,13,14,15,16" function="acnt.sp_sel_allexp_accrue_dtl" procedure="acnt.sp_upd_allexp_accrue_dtl">
                <input bind="grdDtl">
                    <input bind="txttac_allexp_accrue_pk"/>
                </input>
                <output bind="grdDtl"/>
            </dso>
        </xml>
    </gw:data>
<!--------------------------------------------------------------------------------------------------->
		<gw:data id="dso_confirm" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CONFIRM_ALLO_EXP" > 
                <input> 
                     <input bind="txttac_allexp_accrue_pk" />
                     <input bind="lstCompany" />
                     <input bind="dtTrans" />
                     <input bind="lstVoucherType" />
                     <input bind="txtvoucher_no" />
                     <input bind="txtTrSeq" />
                     <input bind="chkAuto" />
                </input>
                <output>
                     <output bind="txtRtnMsg"/>                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!--------------------------------------------------------------------------------------------------->
		<gw:data id="dso_cancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CANCEL_ALLO_EXP" > 
                <input> 
                     <input bind="txttac_allexp_accrue_pk" />
                     <input bind="lstCompany" />
                     <input bind="dtTrans" />
                </input>
                <output>
                     <output bind="txttac_allexp_accrue_pk"/>                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!--------------------------------------------------------------------------------------------------->
		<gw:data id="dso_replicate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_REPLICATE_ALLO_EXP" > 
                <input> 
                     <input bind="txttac_allexp_accrue_pk" />
                </input>
                <output>
                     <output bind="txttac_allexp_accrue_pk"/>                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!--------------------------------------------------------------------------------------------------->

<table style="width:100%; height:100%; " border="1" cellpadding="0" cellspacing="0" >
	<tr style="height:100%">		
		<td id="idLEFT" width="20%"  >
				<table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0" >
					<tr style="height:21%">
						<td>
							<table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
								<tr style="height:2%;" >
									<td width="30%">&nbsp;</td>
									<td width="20%"></td>
									<td width="30%"></td>
									<td width="17%"></td>
									<td width="3%"></td>
								</tr>
								<tr style="height:4%;">
									<td align="right">Trans Date&nbsp;</td>
									<td align="left"><gw:datebox id="dtTrDatefr" lang="1" /></td>
									<td align="center">~</td>
									<td align="right" colspan="2"><gw:datebox id="dtTrDateto" lang="1" /></td>
								</tr>
								<tr style="height:4%;">
									<td align="right">Slip Status&nbsp;</td>
									<td align="left"><gw:list id="lstSliStatus" styles="width:100%" onchange="OnSearch('1')" /></td>
									<td align="right">Voucher No&nbsp;</td>
									<td align="right" colspan="2"><gw:textbox id="txtVoucherNo_Sr" styles="width:100%" onkeypress="Upcase()" onenterkey="OnSearch('1')" /></td>
								</tr>	
								<tr style="height:4%;">
									<td align="right">Seq&nbsp;</td>
									<td align="left"><gw:textbox id="txtSeq_Sr" styles="width:100%" onenterkey="OnSearch('1')" /></td>
									<td align="right">&nbsp;</td>
									<td align="right" colspan="2"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('1')" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="height:77%" >
							<gw:grid 
								id="grdSearch"  
								header  ="Voucher No|Seq|Trans Date|Invoice No|Trans Amount|Books Amount|_tac_allexp_accrue_pk"
								format  ="0|0|4|0|0|0|0"
								aligns  ="0|1|1|0|3|3|0"
								defaults="||||||"
								editcol ="0|0|0|0|0|0|0"
								widths  ="1500|800|1200|1500|2000|2000|0"
								styles  ="width:100%; height:100%"
								sorting ="T"
								acceptNullDate  = "T"
								oncellclick="OnSearch('2')"
							/>
						</td>
					</tr>
				</table>
			</td>
		<td id="idRIGHT" style="width:75%">
			<table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0" >			
				<tr style="width:100%;height:32%">
					<td>
					<table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
						<tr >
							<td style="width:10%"></td>
							<td style="width:10%"></td>
							<td style="width:10%"></td>
							<td style="width:8%"></td>
							<td style="width:2%"></td>
							<td style="width:10%"></td>
							<td style="width:10%"></td>
							<td style="width:10%"></td>									
							<td style="width:8%"></td>
							<td style="width:2%"></td>
							<td style="width:9%"></td>
							<td style="width:8%"></td>
							<td style="width:2%"></td>
							<td style="width:2%"></td>
						</tr>
						<tr style="height:4%;">
							<td align="right">Company&nbsp;</td>
							<td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
							<td align="right">Voucher Type&nbsp;</td>
							<td align="left" colspan="1" ><gw:list id="lstVoucherType" styles="width:100%" csstype="mandatory" /></td>
							<td align="left" colspan="1" ><gw:checkbox id="chkAuto" styles="width:100%" /></td>
							<td align="right">Voucher No&nbsp;</td>
							<td align="left" colspan="2"><gw:textbox id="txtvoucher_no" onkeypress="Upcase()" styles="width:100%" /></td>
							<td align="right" colspan="2"><gw:textbox id="txtTrSeq" styles="width:100%" /></td>
							<td align="right">Seq&nbsp;</td>
							<td align="left" colspan="3"><gw:textbox id="txtseq" styles="width:100%" onenterkey="OnShowTAccount()" /></td>
						</tr>
						<tr style="height:4%;">
							<td align="right">Issued Invoice&nbsp;</td>
							<td align="left"><gw:textbox id="txtIssueInv" csstype="mandatory" /></td>
							<td align="right">Trans Date&nbsp;</td>
							<td align="left" colspan="2"><gw:datebox id="dtTrans" lang="1" csstype="mandatory" /></td>
							<td colspan="7" align="right" >   
							    <table width="100%" style="height:100%;">
							        <tr>
							            <td align="right"><gw:imgBtn id="ibtnNew" img="new" alt="New" onclick="OnNew('Master')" /></td>
							            <td align="left"><gw:imgBtn id="ibtnSave" img="save" alt="Save" onclick="OnSave('1')" /></td>
							            <td align="right" colspan="1"><gw:imgBtn id="ibtnDelete" img="delete" alt="Delete" onclick="OnDelete('1')" /></td>							
							            <td align="right"><gw:icon id="btnConfirm" img="in" text="Confirm" styles="width:100%" onclick="OnConfirm()" /></td>
							            <td align="right"><gw:icon id="btnCancel" img="in" text="Cancel" styles="width:100%" onclick="OnCancel()" /></td>
							            <td align="right" colspan="1"><gw:icon id="btnReplicate" img="in" text="Replicate" onclick="OnReplicate()" /></td>
							            <td align="right" colspan="1"><gw:imgBtn id="ibtnPrint" img="printer" alt="Print" onclick="OnPrint()" /></td>							        
							        </tr>
							    </table>
							</td>
						</tr>
						<tr style="height:4%;">
							<td align="right"><a title="Click here to select Vendor" onclick="OnPopUp('Vendor')" href="#tips">Vendor&nbsp;</a></td>
							<td align="left"><gw:textbox id="txtVendorCD" styles="width:100%" csstype="mandatory" /></td>
							<td align="left" colspan="2"><gw:textbox id="txtVendorNM" styles="width:100%" csstype="mandatory" /></td>
							<td align="right"><gw:imgBtn id="btnResetVendor" img="reset" alt="Reset" onclick="OnReset('Vendor')" /></td>
							<td align="right"><a title="Click here to select Account code" onclick="OnPopUp('Account')" href="#tips">Account code&nbsp;</a></td>
							<td align="left"><gw:textbox id="txtAccCD" styles="width:100%" csstype="mandatory" /></td>
							<td align="left" colspan="2"><gw:textbox id="txtAccNM" styles="width:100%" csstype="mandatory" /></td>
							<td align="left"><gw:imgBtn id="btnResetAccCD" img="reset" alt="Reset" onclick="OnReset('Account')" /></td>									
							<td align="right">Book Ccy&nbsp;</td>
							<td align="left"><gw:list id="lstBook_Ccy" styles="width:100%" /></td>
							<td align="right" colspan="2"><gw:textbox id="txtBookRate" type="number" format="###,###,###.##" /></td>
						</tr>							
						<tr style="height:4%;">
							<td align="right">Currency&nbsp;</td>
							<td align="left"><gw:list id="lstCCY" styles="width:100%" csstype="mandatory" onchange="dso_get_rate.Call()" /></td>
							<td align="right" >Ex Rate&nbsp;</td>
							<td align="left" colspan="1"><gw:textbox id="txtExRate" type="number" format="###,###,###R" styles="width:100%" csstype="mandatory" /></td>							
							<td align="right" colspan="2">Trans Allocate Amt&nbsp;</td>
							<td align="left" colspan="3"><gw:textbox id="txtTransAlloAmt" type="number" format="###,###,###,###R" styles="width:100%" /></td>
							<td colspan="2" align="right" >Books Allocate Amt&nbsp;</td>
							<td align="left" colspan="3"><gw:textbox id="txtBooksAlloAmt" type="number" format="###,###,###,###,###R" /></td>
						</tr>
						<tr style="height:4%;">
							<td align="right">Description&nbsp;</td>
							<td align="left" colspan="3"><gw:textbox id="txtDesc_1" styles="width:100%" csstype="mandatory" /></td>
							<td align="right" colspan="2">Local Desc&nbsp;</td>
							<td align="left" colspan="8" ><gw:textbox id="txtLocalDesc_1"  styles="width:100%" csstype="mandatory" /></td>
						</tr>
						<tr style="height:4%;">
							<td align="right">Status&nbsp;</td>
							<td align="left" colspan="2"><gw:list id="lstStatus" styles="width:100%" type="number" format="###,###,###R" /></td>							
							<td align="left" colspan="1"><gw:textbox id="txtBooksAmt_1" styles="width:100%; display:none;" type="number" format="###,###,###,###R" /></td>
							<td align="right" colspan="2">VAT Trans Amount&nbsp;</td>
							<td align="left" colspan="1"><gw:textbox id="txtVATTransAmt" styles="width:100%" type="number" format="###,###,###,###R" /></td>
							<td align="right" colspan="2">VAT Books Amount&nbsp;</td>
							<td align="right" colspan="4"><gw:textbox id="txtVATBookAmt" type="number" format="###,###,###R" /></td>
						</tr>
						<tr style="height:4%;">
							<td align="right">VAT Description&nbsp;</td>
							<td align="left" colspan="3"><gw:textbox id="txtVATDesc" styles="width:100%" csstype="mandatory" /></td>
							<td align="right" colspan="2">Local VAT Description&nbsp;</td>
							<td align="left" colspan="7"><gw:textbox id="txtLocVATDesc" styles="width:100%" csstype="mandatory" /></td>
						</tr>
						<tr style="height:4%;">
							<td align="right"><a title="Click here to select trans type" onclick="OnPopUp('Trans Type')" href="#tips">Trans Type&nbsp;</a></td>
							<td align="left" colspan="1"><gw:textbox id="txtTransCD" styles="width:100%" csstype="mandatory" /></td>
							<td align="left" colspan="2"><gw:textbox id="txtTransNM" styles="width:100%" csstype="mandatory" /></td>
						</tr>						
						<tr style="height:2%;" >
							<td >&nbsp;</td>
						</tr>						
						<tr style="height:66%;">
						<td colspan="14" >
							<gw:tab id="idTab_Child" styles="width:100%;height:100%" onpageactivate="OnSearchTab()" >
								<table name="Control Item..." width ="100%" height="100%" cellpadding ="0" cellspacing ="0" border="0" >
									<tr style="height:8%">
										<td align ="right" width="94%" ><gw:imgBtn id="btnAdd_More" img="new" alt="Add New Item" onclick="Add_CtrlItem()"/></td>
										<td align ="right" width="3%" ><gw:imgBtn id="btnSave_More" img="save" alt="Save"         onclick="Save_CtrlItem()"/></td>
										<td align ="right" width="3%" ><gw:imgBtn id="btnDel_More" img="delete" alt="Delete"       onclick="Delete_CtrlItem()"/></td>    
									</tr>
									<tr style="height:92%" >
										<td width ="100%" colspan="3" >
											<gw:neogrid id="grdInfor" styles="width:100%;height:100%" oncelldblclick ="PopupClickCtrl_Item()"> 
												<XML>
													<xmlblock>
													
													<column title="PK" hidden='T'>
														<textbox type="number" format="######"/>
													</column>

													<column title="Item PK" hidden='T'>
														<textbox type="number" format="######" />
													</column>

													<column title="Item Code" width='3500' editmode="0">
														<textbox />
													</column>

													<column title="Item Name" width='3500' editmode="0">
														<textbox />
													</column>

													<column title="InType" hidden='T'>
														<textbox  />
													</column>

													<column title="DataType" hidden='T'>
														<textbox />
													</column>

													<column title="Item Code"  width='3500'>
														<multiple ref="5">
															<textbox type="number" format="###,###C" value="" />
															<textbox format="50" value="" />
															<datebox type="day" format=""  lang="1" acceptnull="T"/>
															<checkbox />	
															<htmledit value="[New]" />				
														</multiple>
													</column>
													
													<column title="Mst_PK" hidden='T' >
														<textbox/>
													</column>
													
													<column title="Item_Table" hidden='T'>
														<textbox  />
													</column>
													
													<column title="Item Name" width='3500' editmode="0">
														<textbox  />
													</column>

												</xmlblock>
											</xml>
										</gw:neogrid>
										</td>			
									</tr>
								</table>
				            <table name="Allocated Info" style="width:100%;height:100%" cellpadding ="0" cellspacing ="0" border="0" >
                            <tr style="height:10%;" >
				                <td >
		                            <table style="width:100%;height:100%" cellpadding ="0" cellspacing ="0" border="0">
		                                <tr >
	                                        <td width ="5%" align="right">&nbsp;</td>
	                                        <td width ="5%" align="left" ></td>
                                            <td width ="10%" align="right">Total&nbsp;&nbsp;</td>
                                            <td width ="15%" align="left" ><gw:textbox id="lblTotal_FAMT" text="" type="number" format="###,###.##R" styles="color:red;width:90%;font-weight: bold;font-size:14"/></td>
	                                        <td width ="15%" align="left" ><gw:textbox id="lblTotal_AMT" text="" type="number" format="###,###.##R" styles="color:red;width:90%;font-weight: bold;font-size:14"/></td>	                                        	                                        
	                                        <td width ="8%" align="center"></td>
                                            <td width ="24%" align="center">
                                                <table border ="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%">
                                                <tr>
                                                    <td>
                                                    </td>
                                                </tr>
                                                </table>
                                            </td>
                                            <td style="width:3%;" align="right"></td>
                                            <td style="width:5%;" align="left">													
                                            <td></td>
                                            <td>
                                                <table border ="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%">
                                                <tr>
	                                                <td width ="3%" align ="right" ><gw:imgBtn id="btnNew_D"    img="new"       alt="New" onclick="OnAdd_Item()"      /> </td>
	                                                <td width ="3%" align ="right" ><gw:imgBtn id="btnSave_D"   img="save"      alt="Save"   onclick="OnSave_Item()"   /> </td>
	                                                <td width ="3%" align ="right" ><gw:imgBtn id="btnDel_D"    img="delete"    alt="Delete" onclick="OnDelete_Item()"   /> </td>
                                                </tr>
                                                </table>
                                            </td>
                                            
                                        </tr>
                                    </table>                   
                                </td>
                            </tr>
	                        <tr>
                                <td width ="100%" >
                                    <gw:grid
                                        id      ="grdDtl"  
                                        header  ="_tac_allexp_accrued_pk|_tco_item_pk|Item code|Item name|_tac_abacctcode_pk|Account code|Account name|Trans|Books|Trans|Books|Trans|Books|Description|Local Desc|_tac_crdad_pk|_Master_PK"
                                        format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                        aligns  ="0|0|0|0|0|0|0|3|3|3|3|0|0|0|0|0|0"
                                        defaults="||||||||||||||||"
                                        editcol ="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|0|0"
                                        widths  ="0|0|1500|2500|0|1800|2500|1000|1000|1000|1000|1000|1000|2000|2000|0|0"
                                        styles  ="width:100%; height:100%"
                                        sorting ="T"  
										acceptNullDate="T"																				
                                        />
                                </td>
                            </tr>
	                        </table>
							</gw:tab>
						</td>						
						</tr>
					</table>
				</td>
			</tr>			
		</td>
	</tr>	
</table>
<!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />      
<!------------------------------------------------------------------------>	

<gw:textbox id="txtTransDT" styles="display:none;" />
<gw:textbox id="txttac_allexp_accrue_pk" styles="display:none;" />
<gw:textbox id="txtVendorPK" styles="display:none;" />
<gw:textbox id="txtAccPK" styles="display:none;" />
<gw:textbox id="txtStatus" styles="display:none;" />
<gw:textbox id="txtTransPK" styles="display:none;" />
<gw:textbox id="txtRtnMsg" styles="display:none;" />
</body>

</html>
