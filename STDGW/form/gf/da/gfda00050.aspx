<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1"  runat="server">
    <title>Return Material</title>
</head>

<script>
   
    var  user_pk = "<%=Session("USER_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  user_id = "<%=Session("USER_ID")%>" ;
    var  p_update = 0 ; // master inserted or not 
	var  p_delete = 0 ; // master deleted or not 
	var  p_addnew = 0 ; // master added new or not 
//-----------------------------------------------------
//grdSearch
    var iG1_pk              = 0,    
        iG1_Voucher_No      = 1,
        iG1_Trans_DT        = 2,
        iG1_ACC_Voucher_No  = 3,
        iG1_ACC_Seq_No      = 4,
        iG1_TR_STATUS       = 5;
// transaction type        
var ls_trtype_pk, ls_trtype_code, ls_trtype_nm, ls_slipremarkeng, ls_slipremarklocal ;            
//grdDetail    
var iG2_pk                  	= 0,
    iG2_tco_item_pk         	= 1,
    iG2_Item_Code           	= 2,
    iG2_Item_Name           	= 3,
    iG2_UOM                 	= 4,
	iG2_acc_pk					= 5,
    iG2_acc_code				= 6,
	iG2_acc_name				= 7,	
	iG2_qty						= 8,
    iG2_Price           		= 9,	
    iG2_net_trans_Amt           = 10,
	iG2_net_book_amt			= 11,	
	iG2_vat_trans_amt			= 12,
	iG2_vat_book_amt			= 13,
	iG2_vat_deduct_trans		= 14,
	iG2_vat_deduct_book			= 15,
	iG2_pl_cd					= 16,
	iG2_pl_nm					= 17,
	iG2_pl_pk					= 18,
	iG2_desc					= 19,
	iG2_local_desc				=20,
	iG2_mst_pk				= 21,
	iG2_tin_stocktr_pk				= 22,
	iG2_vat_rate				= 23;
//---------------------------------------------------------

function BodyInit()
{
    txtDepartment.SetEnable(false);
    txtUserID.SetEnable(false);
    txtUserName.SetEnable(false);
    txtTransCode.SetEnable(false);
    txtTransName.SetEnable(false);
    txtDebitCode.SetEnable(false);
    txtDebitName.SetEnable(false);
    txtDepartment.SetEnable(false);
    BindingDataList();
//    lstCurr.value = 'USD';
    txtVoucherNo.SetEnable(true);
    chkVoucher_Auto.value = 'F';
	idBtnCancel.SetEnable(true);
    OnFormatGrid();	
}
//-----------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("tLEFT");    
    var right = document.all("tRIGHT");   
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

//-----------------------------------------------------
 function BindingDataList()
 {
    // company
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    lstCompany_1.SetDataText(ls_data);
    // voucher type
    ls_data = "<%=ESysLib.SetListDataSQL("select A.CODE, A.CODE_NM FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TAC_COMMCODE_MASTER_PK = B.PK AND B.ID = 'ACBG0130' and ( code = 'RNL' ) " )%>|ALL|Select All"; 
    lstVoucherType.SetDataText(ls_data);
    //lstVoucherType.value = "" ;
    ls_data = "<%=ESysLib.SetListDataSQL(" select A.CODE, A.CODE_LNM FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TAC_COMMCODE_MASTER_PK = B.PK AND B.ID = 'ACBG0040' and A.DEF_YN = 'Y' " )%>"; 
    lstBOOK_CCY.SetDataText(ls_data);
    txtabemp_pk.text = user_pk ;
    txtDepartment.text = '';
    txtUserID.text = user_id;
    txtUserName.text = user_name;                
    txtDept_PK.text = "";                 
    
    ls_trtype_pk = "<%=ESysLib.SetDataSQL("select pk from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'YRTN' and del_if = 0 ")%>";
    ls_trtype_code = 'YRTN';
    ls_trtype_nm = "<%=ESysLib.SetDataSQL("select TR_TPNM from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'YRTN' and del_if = 0 ")%>";
    txtTransCode.text = ls_trtype_code;
    txtTransName.text = ls_trtype_nm;
    txtabtypetr_pk.text = ls_trtype_pk; 

    ls_slipremarkeng = "<%=ESysLib.SetDataSQL("select SLIPREMARKENG from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'YRTN' and del_if = 0 ")%>";
    ls_slipremarklocal = "<%=ESysLib.SetDataSQL("select SLIPREMARKLOCAL from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'YRTN' and del_if = 0 ")%>";
    txtDesc.text = ls_slipremarkeng ;
    txtLocalDesc.text = ls_slipremarklocal ;              
    // setup default account 627     
	var ls_account_627 = "";
    var ls_acpk_627 = "";
    var ls_acnm_627 = "";
	ls_acpk_627 = "<%=ESysLib.SetDataSQL("select pk from tac_abacctcode where del_if = 0 and ac_cd like '2101010003' and tco_company_pk = '1'")%>";
	ls_acnm_627 = "<%=ESysLib.SetDataSQL("select ac_nm from tac_abacctcode where del_if = 0 and ac_cd like '2101010003' and tco_company_pk = '1'")%>";
	ls_account_627 = '2101010003';	
    txtDebitCD.text = ls_account_627;    
    txtDebitNM.text = ls_acnm_627;
    txtDebitPK.text = ls_acpk_627;	
    var ls_first_date = dtFromDT.value ;
    ls_first_date = ls_first_date.substr(0, 4) + ls_first_date.substr(4, 2) + "01";
    dtFromDT.value = ls_first_date;   	
	ls_data = "<%=ESysLib.SetListDataFUNC("select comm.f_commoncode('ACCR0110', '', '') from dual")%>";	
	lstVatRate.SetDataText(ls_data);
	ls_data ="<%=ESysLib.SetListDataSQL("select TRIM(CODE) code, A.CODE code_nm FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'ACBG0040' and A.def_yn = 'Y' and a.use_yn = 'Y' ")%>";
	lstBookCcy.SetDataText(ls_data);
	txtTransDT.text = dtTransDt.text;
	txtRate.text = txtBKRate.text;
	dso_sel_booksrate.Call();
 }  
 //-----------------------------------------------------
 
function OnPopUp(iObject)
{
    switch(iObject)
    {
        case "Proposed By":
            var path = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx";
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            lrow = grdDetail.row ;
            lcol = grdDetail.col;
            if(object!=null)
            {
                txtabemp_pk.text    = object[0];                
                txtDepartment.text  = object[4];
                txtUserID.text      = object[1];
                txtUserName.text    = object[2];                
                txtDept_PK.text     = "";                
            }        
        break ;
        case "Credit Account":
            var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCode.text + "&val1=" + txtTransName.text + "&val2=C" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
            var object  =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	        
            if(object!=null)
            {               
                var tmp = object[0];
                if( tmp != null && Trim(tmp[1]) != '' )
                {
                    txtDebitCode.text = tmp[4];
                    txtDebitName.text = tmp[5];
                    txttac_abacctcode_pk.text = tmp[1] ;                    
                }
            }                                                    
        break ;
        case 'Trans Type':
            var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCompany.value;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if( object != null )
            {
		        var tmp = object[0];
		        if (tmp[1] != null)
		        {
		            txtTransCode.text = tmp[1];
		            txtTransName.text = tmp[2];
		            txtabtypetr_pk.text = tmp[0];
		            txtDesc.text = tmp[3];
		            txtLocalDesc.text = tmp[4];
                }                
            }
        break ;        
		case 'PL':
			var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_PL_POPUP&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" + "&val1=";
			var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
			if(object != null)
			{
				txtPLPK.text = object[2];
				txtPLCD.text = object[0];
				txtPLNM.text = object[1];
			}		
		break;
		case 'Customer':
			var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
			var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
			if ( object != null )
			{
				if (object[0] != 0)
				{
					txtCustPK.text = object[0];
					txtCustNM.text = object[2];
					txtCustID.text = object[1];
				}
			}	
		break;
		case 'VATCustom':
			var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
			var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
			if ( object != null )
			{
				if (object[0] != 0)
				{
					txtVATCustom_PK.text = object[0];
					txtVATCustom.text = object[2];					
				}
			}			
		break;
    }
}
//----------------------------------------------------------
function OnReset()
{
    txtDepartment.text          = '';
    txtDept_PK.text             = '';
    txtUserName.text            = '';    
    txtUserID.text              = '';
    txtabemp_pk.text            = '';
    txtTransCode.text           = '';
    txtTransName.text           = '';
    txtabtypetr_pk.text         = '';    
    txtDebitCode.text           = '';
    txtDebitName.text           = '';
    txttac_abacctcode_pk.text   = '';    
    txtVoucherNo.text           = '';
    txtSEQ.text                 = '';
}
//----------------------------------------------------------
function OnAddNew(iObj)
{
    var lNewRow ;
    switch(iObj)
    {
        case '1':
            if(grdMaster.GetStatus() != 20)
            {
                grdMaster.StatusInsert();
                txtVoucherNo.enabled = true;
                grdDetail.ClearData();                
                OnReset();
                txtabtypetr_pk.text = ls_trtype_pk ;
                txtTransCode.text = ls_trtype_code ;
                txtTransName.text = ls_trtype_nm ;
                txtDesc.text = ls_slipremarkeng ;
                txtLocalDesc.text = ls_slipremarklocal ;
                txtDebitCode.text = txtDebitCD.text ;
                txtDebitName.text = txtDebitNM.text ;                                
                txttac_abacctcode_pk.text = txtDebitPK.text ;
                lstVoucherType.value = "RNL" ;
                txtVoucherNo.text = '**New Slip No**';
                lblStatus.text = 'Saved';
				txtabemp_pk.text = user_pk ;
				txtDepartment.text = '';
				txtUserID.text = user_id;
				txtUserName.text = user_name;                
				txtDept_PK.text = "";                 				
                txtVoucherNo.GetControl().focus();
				txtRate.text = txtBKRate.text;
                InActiveButton();
				p_update = 1;
				p_addnew = 1;
				
            }
            else
            {
                alert("Already add new. Please input data !!!");
            }                        
        break ;
        case '2':            
           	grdDetail.AddRow();
           	grdDetail.SelectRow(grdDetail.rows - 1);                        
           	lNewRow = grdDetail.rows - 1 ;            
           	grdDetail.SetGridText(lNewRow, iG2_mst_pk, txttac_omcost_pricer_PK.text);
        break ;
    }
}
//----------------------------------------------------------
function OnSave(iObj)
{
    switch(iObj)
    {
        case '1':
            var lchk = CheckSave('master');
            if(lchk)
            {
				p_update = 1;
                grdMaster.Call();                               
            } 
            InActiveButton(); 			
        break;
        case '2':            
			if(CheckSave('detail'))
            {
                InActiveButton();
				dso_return_mat_dtl.Call();                                          
            }     
        break;
    }
}
//----------------------------------------------------------
function CheckSave(iCase)
{
    switch(iCase)
    {
        case 'master':
            if(Trim(txttac_abacctcode_pk.text) =='')
            {
                alert('Please choose the Credit Account Code');
                return false;
            }
           else if(chkVoucher_Auto.value == "F")
            {
                if(Trim(txtVoucherNo.text)=="")
                {
                    alert("Please user enter input Voucher No");
                    return false;
                }                
            }
            else if(txtabemp_pk.text == "" )
            {
                alert("Please select the Proposed by!!!");
                return false ;
            }
        return true;            
        break ;
        case 'detail':        
            for(i = 1; i < grdDetail.rows; i++)
            {
                if(Trim(grdDetail.GetGridData(i, iG2_tco_item_pk)) == "")
                {
                    alert("Please select item code for row " + i);
                    return false;                        
                }        
                else if(Trim(grdDetail.GetGridData(i, iG2_qty)) == "")
                {
                    alert("Please select quantity for row " + i);
                    return false;
                }
                else if(Trim(grdDetail.GetGridData(i, iG2_pl_pk)) == "")
                {
                    alert("Please select project for row " + i);
                    return false;
                }
                else if(Trim(grdDetail.GetGridData(i, iG2_acc_pk)) == "")
                {
                    alert("Please select credit account for row " + i);
                    return false;
                }        
            }
            return true ;        
        break ;            
    }
}
//----------------------------------------------------------


function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case "grdMaster":			
			if(p_update == 1)
			{
	            p_update = 0 ;	            
	            OnSave('2');					
			}	
			else
			{
				dso_return_mat_dtl.Call("SELECT");
			}		
        break ;
		case 'dso_return_mat_dtl':
			if(p_addnew == 1)
			{
				//alert('test');
				dso_return_mat_lst.Call("SELECT");		
				p_addnew == 0;
			}
			InActiveButton();		
		break ;
		case 'dso_confirm_return_mat':
			idBtnConfirm.SetEnable(false);
			idBtnCancel.SetEnable(false);			
			dso_return_mat_lst.Call('SELECT');
		break ;
		case 'dso_cancel_return_mat':
			idBtnConfirm.SetEnable(false);
			idBtnCancel.SetEnable(false);			
			dso_return_mat_lst.Call('SELECT');
		break ;
    }    
}

function OnSearch(pos)
{
    switch(pos)
    {
        case '1':  //grdSearch  
            dso_return_mat_lst.Call();
            grdDetail.ClearData();                        
        break;
        case '2': //master grid
            if ( grdMaster.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save firstly?'))
                {
                    OnSave('1'); //save master
                }
                else
                {
                    txttac_omcost_pricer_PK.text = grdSearch.GetGridData(grdSearch.row, iG1_pk);
                    grdMaster.Call("SELECT");                    
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txttac_omcost_pricer_PK.text = grdSearch.GetGridData(grdSearch.row, iG1_pk);
                }
				else
				{
					txttac_omcost_pricer_PK.text = "";
				}
                grdMaster.Call("SELECT");                
           }                                   
        break;
    }
}
//------------------------------------------------------------
function SetParentPKtoGrid()
{
    var i ;
    for( i = 1; i < grdDetail.rows ; i++)
    {
        grdDetail.SetGridText(i, iG2_mst_pk, txttac_omcost_pricer_PK.text);           		
    }
}
//------------------------------------------------------------
function OnVoucherAuto()
{
    if(chkVoucher_Auto.value == 'T')
        txtVoucherNo.SetEnable(false);    
    else
    {     
        txtVoucherNo.SetEnable(true);        
        txtVoucherNo.GetControl().focus();    
    }        
}
//------------------------------------------------------------
function OnGridCellDblClick(iObj)
{
	var l_vat_famt = 0, l_vat_amt = 0;
    switch(iObj.id)
    {
        case 'grdDetail':
            var lcol = event.col ;
            var lrow = event.row ;            
            if(lcol == iG2_Item_Code)
            {
                var path = System.RootURL + "/form/gf/da/gfda00050_MatRtnVendor.aspx?purchase_yn=&item_code=&item_name="   ;
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
                if(object != null)
                {
                    var atemp = object[0];
                    grdDetail.SetGridText(lrow, iG2_tco_item_pk, atemp[0]);
                    grdDetail.SetGridText(lrow, iG2_Item_Name, atemp[2]);
                    grdDetail.SetGridText(lrow, iG2_Item_Code, atemp[1]);
                    grdDetail.SetGridText(lrow, iG2_UOM, atemp[5]);
                    grdDetail.SetGridText(lrow, iG2_acc_pk, atemp[19]);
                    grdDetail.SetGridText(lrow, iG2_acc_code, atemp[20]);
                    grdDetail.SetGridText(lrow, iG2_acc_name, atemp[21]);                    
					grdDetail.SetGridText(lrow, iG2_qty, atemp[6]);
					grdDetail.SetGridText(lrow, iG2_pl_pk, atemp[10]);
					grdDetail.SetGridText(lrow, iG2_pl_cd, atemp[8]);					
					grdDetail.SetGridText(lrow, iG2_pl_nm, atemp[9]);
					grdDetail.SetGridText(lrow, iG2_Price, atemp[24]); // PRice
					grdDetail.SetGridText(lrow, iG2_net_trans_Amt, atemp[25]); // Trans Amt
					grdDetail.SetGridText(lrow, iG2_net_book_amt, atemp[26]); // Book Amt
					grdDetail.SetGridText(lrow, iG2_tin_stocktr_pk, atemp[11]); // tin_stocktr_pk
					grdDetail.SetGridText(lrow, iG2_desc, txtDesc.text); // description
					grdDetail.SetGridText(lrow, iG2_local_desc, txtLocalDesc.text); // local description
					grdDetail.SetGridText(lrow, iG2_mst_pk, txttac_omcost_pricer_PK.text);
                    if(lstVatRate.value == '01' || lstVatRate.value == 'NO')
					{
						grdDetail.SetGridText(lrow, iG2_vat_trans_amt, '');
						grdDetail.SetGridText(lrow, iG2_vat_book_amt, '');						
						grdDetail.SetGridText(lrow, iG2_vat_rate, lstVatRate.value);
					}
					else
					{
						l_vat_famt = Math.round(Number(atemp[25]) * Number(lstVatRate.value) / 100);
						l_vat_amt = Math.round(l_vat_famt / Number(txtRate.text) * 100) / 100;
						grdDetail.SetGridText(lrow, iG2_vat_trans_amt, l_vat_famt);
						grdDetail.SetGridText(lrow, iG2_vat_book_amt, l_vat_amt);
						grdDetail.SetGridText(lrow, iG2_vat_rate, lstVatRate.value);
					}
					grdDetail.SetRowStatus(lrow, 0x20);
					
                    for(var i = 1; i < object.length; i++)
                    {
                        var atemp = object[i];
                        grdDetail.AddRow();
                        grdDetail.SelectRow(grdDetail.rows - 1);       
                        lrow = grdDetail.rows - 1 ;
						grdDetail.SetGridText(lrow, iG2_tco_item_pk, atemp[0]);
						grdDetail.SetGridText(lrow, iG2_Item_Name, atemp[2]);
						grdDetail.SetGridText(lrow, iG2_Item_Code, atemp[1]);
						grdDetail.SetGridText(lrow, iG2_UOM, atemp[5]);
						grdDetail.SetGridText(lrow, iG2_acc_pk, atemp[19]);
						grdDetail.SetGridText(lrow, iG2_acc_code, atemp[20]);
						grdDetail.SetGridText(lrow, iG2_acc_name, atemp[21]);                    
						grdDetail.SetGridText(lrow, iG2_qty, atemp[6]);
						grdDetail.SetGridText(lrow, iG2_pl_pk, atemp[10]);
						grdDetail.SetGridText(lrow, iG2_pl_cd, atemp[8]);					
						grdDetail.SetGridText(lrow, iG2_pl_nm, atemp[9]);
						grdDetail.SetGridText(lrow, iG2_Price, atemp[24]); // PRice
						grdDetail.SetGridText(lrow, iG2_net_trans_Amt, atemp[25]); // Trans Amt
						grdDetail.SetGridText(lrow, iG2_net_book_amt, atemp[26]); // Book Amt
						grdDetail.SetGridText(lrow, iG2_tin_stocktr_pk, atemp[11]); // tin_stocktr_pk
						grdDetail.SetGridText(lrow, iG2_desc, txtDesc.text); // description
						grdDetail.SetGridText(lrow, iG2_local_desc, txtLocalDesc.text); // local description
						grdDetail.SetGridText(lrow, iG2_vat_rate, lstVatRate.value);
						grdDetail.SetGridText(lrow, iG2_mst_pk, txttac_omcost_pricer_PK.text);
						if(lstVatRate.value == '01' || lstVatRate.value == 'NO')
						{
							grdDetail.SetGridText(lrow, iG2_vat_trans_amt, '');
							grdDetail.SetGridText(lrow, iG2_vat_book_amt, '');						
						}
						else
						{
							l_vat_famt = Math.round(Number(atemp[25]) * Number(lstVatRate.value) / 100);
							l_vat_amt = Math.round(l_vat_famt / Number(txtRate.text) * 100) / 100;
							grdDetail.SetGridText(lrow, iG2_vat_trans_amt, l_vat_famt);
							grdDetail.SetGridText(lrow, iG2_vat_book_amt, l_vat_amt);
							grdDetail.SetGridText(lrow, iG2_vat_rate, lstVatRate.value);
						}
						grdDetail.SetRowStatus(lrow, 0x20);
                    }                                                         
                }
            }
            else if(lcol == iG2_acc_code )
            {
                var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCode.text + "&val1=" + txtTransName.text + "&val2=C" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
                var object  =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	        
                if(object!=null)
                {               
                    var tmp = object[0];
                    if( tmp != null && Trim(tmp[1]) != '' )
                    {
                        grdDetail.SetGridText(lrow, iG2_acc_code, tmp[4]);
                        grdDetail.SetGridText(lrow, iG2_acc_name, tmp[5]);
                        grdDetail.SetGridText(lrow, iG2_acc_pk, tmp[1]);
                    }
                }                                                                    
            }
            else if(lcol == iG2_pl_cd )
            {
                if(Trim(lstCompany.value)=='')
                {
                    alert('Must select Company!!!');
                    return ;
                }              
                var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_PL_POPUP&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" + "&val1="; 
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
                if(object != null)
                {
                    grdDetail.SetGridText(lrow, iG2_pl_pk, object[2] );
                    grdDetail.SetGridText(lrow, iG2_pl_cd, object[0] );
                    grdDetail.SetGridText(lrow, iG2_pl_nm, object[1] );
                }                
            }
        break ;
    case "grdSearch":
	    var lcol = event.col;
	    var lrow = event.row ;
	    if( lcol == iG1_ACC_Seq_No && Trim(grdSearch.GetGridData(lrow, lcol)) != '' )
	    {
	        var pk = grdSearch.GetGridData(lrow, iG1_ACC_Seq_No);
	        var status = grdSearch.GetGridData(lrow, iG1_TR_STATUS);
	
	        var fpath = System.RootURL + '/form/gf/br/gfbr00030_popup.aspx?PK_ROW=' + pk + '&APPRCANCEL=' + status;
	        var wWidth = 950;
	        var wHeight = 565;
	        var x = Math.round((screen.availWidth - wWidth)/2);
	        var y = Math.round((screen.availHeight - wHeight)/2);
	
	        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
	        "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
	        "lef="+ x +",top=" + y;
	        var object = System.OpenModal(fpath, wWidth, wHeight, features);                
	    }                
    break ;        
    }
}
//------------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//------------------------------------------------------------
function OnDelete(iObj)
 {
    switch(iObj)
    {
        case "2":
	        var ctrl = grdDetail.GetGridControl();
	        var n    = ctrl.rows;
	        var row  = ctrl.row;
        	
	        if ( n > 1 ) {        	
		        if ( row < 0 ) 
		        {		
		            alert('Must select a row to delete!');
		        }		
		        else 
		        {        		
			        if ( grdDetail.GetGridData( row, iG2_tco_item_pk ) == "" ) 
			        {
			            alert('Must select a row is not a total row!');
			        }
			        else 
			        {        				
				        if ( confirm ( "Do you want to delete?" ) ) 
				        {				
					        grdDetail.DeleteRow();
				        }
				        InActiveButton();
			        }
		        }
	        }        
        break;
        case "1":
            if(grdDetail.rows > 1)
                alert('Must delete all details firstly!!!');
            else
            {
                if ( confirm ( "Do you want to delete this Slip Entry?" ) )
                  {
                    grdMaster.StatusDelete();                        
                    if ( txttac_omcost_pricer_PK.text != "" )                    
                    {
                        grdMaster.Call()      
						p_delete = 1;                  
                    }
                    else                    
                        alert("Please, Select a Slip entry !")
                 }        
            }                              
        break;
    }
 }
//------------------------------------------------------------
function InActiveButton() 
{    
	var ctrl = grdDetail.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;	

	if ( n > 1 ) //detail has rows
	{
	    //button delete master
	    idBtnDelete.SetEnable(false);	
	    //processed or saved
		if ( row < 0 ) //not selected detail
		{
			idBtnDelete_2.SetEnable(false);
		}
		else //selected detail
		{			
			if ( grdDetail.GetRowStatus( ctrl.row ) >= 64 ) 
			{
				idBtnDelete_2.SetEnable(false);
			}
			else 
			{
				idBtnDelete_2.SetEnable(true);
			}
		}	
	}
	else //detail empty
	{
	    idBtnDelete.SetEnable(true);
        idBtnDelete_2.SetEnable(false);        	    
	}	
	//first priority processing
    if( Trim(lblStatus.text) == 'Saved' && n > 1 )       
    {
        idBtnSave.SetEnable(true);
        idBtnNew_2.SetEnable(true);            
		idBtnConfirm.SetEnable(true);
		idBtnCancel.SetEnable(false);
    }
    else if(Trim(lblStatus.text) == 'Processed' )
    {
        idBtnSave.SetEnable(false);
        idBtnNew_2.SetEnable(false);
        idBtnDelete.SetEnable(false);
        idBtnDelete_2.SetEnable(false);
		idBtnConfirm.SetEnable(false);
		idBtnCancel.SetEnable(true);			
    }
    else
    {
        idBtnSave.SetEnable(true);
        idBtnNew_2.SetEnable(true);
        idBtnDelete.SetEnable(true);
        idBtnDelete_2.SetEnable(false);    
		idBtnConfirm.SetEnable(false);
		idBtnCancel.SetEnable(false);						
    }
}
//------------------------------------------------------------
function OnConfirm()
{
	if(confirm("Are you sure you want to confirm this slip? (If you confirm, you could not modify information more...)"))
	{
		dso_confirm_return_mat.Call();
	}		
}
//------------------------------------------------------------
function OnCancel()
{
	if(confirm("Are you sure you want to cancel this slip?") )
	{
		dso_cancel_return_mat.Call();
	}		
}
//------------------------------------------------------------
function OnChangeAfterEdit()
{
    var lrow = event.row ;
    var lcol = event.col ;	
    var lQty, lPrice, l_trans_amt = 0, l_book_amt = 0, l_vat_famt = 0, l_vat_amt = 0 ;
    if( lcol == iG2_qty || lcol == iG2_Price )
    {
        lQty = Trim(grdDetail.GetGridData(lrow, iG2_qty));
        lPrice = Trim(grdDetail.GetGridData(lrow, iG2_Price));
		l_trans_amt = FormatCalculate(lstBOOK_CCY.value, Number(lQty) * Number(lPrice) );
		l_book_amt = Math.round(l_trans_amt / Number(txtRate.text) * 100) / 100;
        if(lQty != "" && lPrice != "" )
        {
            grdDetail.SetGridText(lrow, iG2_net_trans_Amt, l_trans_amt );
			grdDetail.SetGridText(lrow, iG2_net_book_amt, l_book_amt );
        }            
    }
	else if(lcol == iG2_net_trans_Amt)
	{
		l_trans_amt = Number(grdDetail.GetGridData(lrow, iG2_net_trans_Amt));
		l_book_amt  = Math.round(l_trans_amt / Number(txtRate.text) * 100) / 100;
		grdDetail.SetGridText(lrow, iG2_net_book_amt, l_book_amt );
		if(lstVatRate.value != '01' && lstVatRate.value != 'NO')
		{
			l_vat_famt = Math.round(l_trans_amt * lstVatRate.value / 100);	 
			l_vat_amt = Math.round(l_vat_famt / Number(txtRate.text) * 100) / 100;
			grdDetail.SetGridText(lrow, iG2_vat_book_amt, l_vat_amt );
		}		
	}	
}
//------------------------------------------------------------
function FormatCalculate(ccy, pnum)
{
	var rValue =0 ;
	if(ccy == "VND")
	{
		rValue = Math.round(Number(pnum));
	}
	else
	{
		rValue = Math.round(Number(pnum) * 100)/100;
	}	
	return rValue;
}
//------------------------------------------------------------
function OnGridCellClick(iObj)
{
    switch(iObj.id)
    {
        case "grdDetail":
            InActiveButton();            
        break ;
    }
}
//----------------------------------------------------------
function OnFormatGrid()
{
    var ctrl = grdDetail.GetGridControl();
    ctrl.ColFormat(iG2_qty)        = "###,###,###,###,###.##";
    ctrl.ColFormat(iG2_Price)     = "###,###,###,###,###.##";
    ctrl.ColFormat(iG2_net_trans_Amt)  = "###,###,###,###,###";
    ctrl.ColFormat(iG2_net_book_amt)  = "###,###,###,###,###.##";
    ctrl.ColFormat(iG2_vat_trans_amt)        = "###,###,###,###,###";
    ctrl.ColFormat(iG2_vat_book_amt)     = "###,###,###,###,###.##";
    ctrl.ColFormat(iG2_vat_deduct_trans)  = "###,###,###,###,###";
    ctrl.ColFormat(iG2_vat_deduct_book)  = "###,###,###,###,###.##";
}
//----------------------------------------------------------
function OnExcel()
{
    if(grdSearch.row > 0)
    {
        var url =System.RootURL + '/reports/fm/gf/return_mat_slip.aspx?company=' + lstCompany.value + '&voucher_pk=' + txttac_omcost_pricer_PK.text  ;
        System.OpenTargetPage(url); 
    }                
}
//--------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("tLEFT");    
    var right = document.all("tRIGHT");   
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
//------------------------------------------------------
function onSetBookRate()
{
	if(txtBKRate.text != '')
		txtRate.text = txtBKRate.text;
	else
		alert('Please enter bank rate on date ' + txtTransDT.text );
}
//------------------------------------------------------
function OnChangeVAT()
{
	var i;
	var l_vat_famt = 0, l_vat_amt = 0;
	var l_trans_amt = 0, l_book_amt = 0;
	for( i = 1; i < grdDetail.rows; i++)
	{
		if(lstVatRate.value == '01' || lstVatRate.value == 'NO')
		{
			grdDetail.SetGridText(i, iG2_vat_trans_amt, '');
			grdDetail.SetGridText(i, iG2_vat_book_amt, '');			
			grdDetail.SetGridText(i, iG2_vat_rate, lstVatRate.value);	
		}
		else
		{
			l_trans_amt = Number(grdDetail.GetGridData(i, iG2_net_trans_Amt));
			l_book_amt = Number(grdDetail.GetGridData(i, iG2_net_book_amt));
			l_vat_famt = Math.round(l_trans_amt * Number(lstVatRate.value) / 100);
			l_vat_amt = Math.round(l_book_amt * Number(lstVatRate.value) ) / 100;
			grdDetail.SetGridText(i, iG2_vat_trans_amt, l_vat_famt);
			grdDetail.SetGridText(i, iG2_vat_book_amt, l_vat_amt);
			grdDetail.SetGridText(i, iG2_vat_rate, lstVatRate.value);
		}					
	}	
}
//------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------>
    <gw:data id="dso_sel_booksrate" onreceive="onSetBookRate()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_BOOKCCY">
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="txtTransDT"/>
                     <input bind="lstBookCcy"/>
                </input>  
                <output>
                     <output bind="txtBKRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

<gw:data id="dso_return_mat_lst" onreceive=""> 
    <xml> 
        <dso type="grid" function="acnt.sp_sel_fmgf00340" > 
            <input bind="grdSearch" > 
                 <input bind="lstCompany_1" />
                 <input bind="txtVCNo" />
                 <input bind="txtSeqNo" />
                 <input bind="dtFromDT" />
                 <input bind="dtToDT" />                 
             </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="grdMaster" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,4,5,8,11,14,15,16,18,19,22,25,26,28,29,30,31,32,33" function="ACNT.SP_SEL_fmgf00340_1" procedure="ACNT.SP_UPD_fmgf00340_2" > 
            <inout>
                <inout bind="txttac_omcost_pricer_PK" />
                <inout bind="lstCompany" />
                <inout bind="txtVoucherNo" />
                <inout bind="txtSEQ" />
                <inout bind="dtTransDt" />
                <inout bind="txtabemp_pk" />                
                <inout bind="txtUserID" />
                <inout bind="txtUserName" />                
                <inout bind="txtabtypetr_pk" />                
                <inout bind="txtTransCode" />
                <inout bind="txtTransName" />
                <inout bind="txttac_abacctcode_pk" />                
                <inout bind="txtDebitCode" />
                <inout bind="txtDebitName" />                
                <inout bind="txtDesc" />
                <inout bind="txtLocalDesc" />
                <inout bind="lstVoucherType" />
                <inout bind="lblStatus" />
                <inout bind="chkVoucher_Auto" />                     
				<inout bind="txtPLPK" />		
				<inout bind="txtPLCD" />
				<inout bind="txtPLNM" />
				<inout bind="txtCustPK" />		
				<inout bind="txtCustID" />
				<inout bind="txtCustNM" />
				<inout bind="txtRate" />
				<inout bind="txtVATCustom_PK" />
				<inout bind="txtVATCustom" />
				<inout bind="txtTaxCD" />
				<inout bind="txtContractNo" />
				<inout bind="txtInvoiceNo" />
				<inout bind="dtInvoiceNo" />
				<inout bind="txtSerialNo" />
				<inout bind="lstVatRate" />
            </inout>
        </dso> 
    </xml> 
</gw:data>

<!------------------------------------------------------------------------>
<gw:data id="dso_return_mat_dtl" onreceive="OnDataReceive(this)">
    <xml> 
        <dso type="grid" parameter="0,1,4,5,8,9,10,11,12,13,14,15,18,19,20,21,22,23" function="ACNT.SP_SEL_fmgf00340_3" procedure="ACNT.SP_UPD_fmgf00340_4" > 
            <input bind="grdDetail" > 
                 <input bind="txttac_omcost_pricer_PK" />
             </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="dso_confirm_return_mat" onreceive="OnDataReceive(this)">
    <xml> 
        <dso id="1" type="process" procedure="ACNT.SP_PRO_FMGF00340_5" > 
            <input> 
                 <input bind="txttac_omcost_pricer_PK" />
				 <input bind="lstCompany" />
             </input>
			<output> 
            <output bind="txtReturn" /> 
			</output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="dso_cancel_return_mat" onreceive="OnDataReceive(this)">
    <xml> 
        <dso id="2" type="process" procedure="ACNT.SP_PRO_fmgf00340_6" > 
            <input> 
                 <input bind="txttac_omcost_pricer_PK" />
             </input>
			<output> 
            <output bind="txtReturn" /> 
			</output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<table border="1" style="width:100%" cellpadding="0" cellspacing="0" style="height:100%">
    <tr style="height:100%"> 
        <td style="width: 22%; " id="tLEFT">
            <table style="width: 100%; height:100% " border="0" cellpadding="0" cellspacing="0" >
                <tr>
                    <td style="width:40%"></td>
                    <td style="width:30%"></td>
                    <td style="width:30%"></td>
                </tr>
                <tr style="height:4%">
                    <td align="right">Company&nbsp</td>
                    <td align="left" colspan="2"><gw:list id="lstCompany_1" styles="width: 100%; " /></td>
                </tr >
                <tr style="height:4%">
                    <td align="right">Trans Date&nbsp</td>
                    <td align="left" colspan="1"><gw:datebox id="dtFromDT" styles="width: 100%; " lang="1" /></td>
                    <td align="left" colspan="1"><gw:datebox id="dtToDT" styles="width: 100%; " lang="1" /></td>
                </tr>                
                <tr style="height:4%">
                    <td align="right">Voucher No&nbsp</td>
                    <td colspan="2" align="right" ><gw:textbox id="txtVCNo" text="" styles="width:100%; " onenterkey="OnSearch('1')" /></td>                                
                </tr>
                <tr style="height:4%">
                    <td align="right">SEQ&nbsp</td>
                    <td align="left" ><gw:textbox id="txtSeqNo" text="" styles="width:100%; " onenterkey="OnSearch('1')" /></td>                                                            
                    <td align="right"><gw:imgbtn id="btnSearch" text="Search" alt="Search" img="search" onclick="OnSearch('1')" /></td>
                </tr>
                <tr style="height:84%" >
                    <td colspan="3">
                        <gw:grid id='grdSearch'
                        header='_pk|Voucher No|Trans Date|_ACC Voucher No|Seq|Status'
                        format='0|0|4|0|0|0'
                        aligns='0|0|0|0|0|0'
                        defaults='|||||' 
						editcol='0|1|1|1|1|0'                   		
                        widths='0|2000|1000|1500|800|0'
                        acceptNullDate='T'
                        sorting='T' 
						styles='width:100%; height:100%'
                        oncellclick="OnSearch('2')"
                        oncelldblclick = "OnGridCellDblClick(this)"                                                            
                        />
                 </td>
                </tr> 
            </table>                                                                                                 
        </td>
        <td id="tRIGHT" style="width: 78%; ">
            <table style="width: 100%; height:100%; " border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width: 10%"></td>
                    <td style="width: 12%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 15%" ></td>  
                    <td style="width: 10%" ></td>
                    <td style="width: 7%" ></td>
                    <td style="width: 13% " ></td>
                    <td style="width: 4%" ></td>
                    <td style="width: 7%" ></td>
                    <td style="width: 2%" ></td>
                    <td style="width: 2%" ></td>
                    <td style="width: 2%" ></td>
                    <td style="width: 2%" ></td>
                    <td style="width: 2%" ></td>
                    <td style="width: 2%" ></td>                                                         
                </tr>   
                <tr style="height:4%" >
                    <td align="right">Company&nbsp</td>
                    <td align="left"><gw:list id="lstCompany" styles="width: 100%" /></td>
                    <td align="right">Voucher Type&nbsp</td>
                    <td align="left"><gw:list id="lstVoucherType" styles="width: 100%" /></td>
                    <td align="right">Voucher No&nbsp</td>
                    <td align="left"><gw:checkbox id="chkVoucher_Auto" styles="width: 100%" onchange="OnVoucherAuto()" /></td>
                    <td align="left"><gw:textbox id="txtVoucherNo" styles="width: 100%" onkeypress="Upcase()" csstype="mandatory" /></td>
                    <td align="right">SEQ&nbsp</td>
                    <td align="left" colspan="2" ><gw:textbox id="txtSEQ" styles="width: 100%" /></td>                    
                    <td align="right" ><gw:imgbtn id="idBtnReset" img="reset" alt="Reset" text="Reset" styles="width: 100%" onclick="OnReset()" /></td>
                    <td align="right" ><gw:imgbtn id="idBtnNew" img="new" alt="New" text="New" styles="width: 100%" onclick="OnAddNew('1')" /></td>
                    <td align="right" ><gw:imgbtn id="idBtnSave" img="save" alt="Save" text="Save" styles="width: 100%" onclick="OnSave('1')" /></td>
                    <td align="right" ><gw:imgbtn id="idBtnDelete" img="delete" alt="Delete" text="Delete" styles="width: 100%" onclick="OnDelete('1')" /></td>
                    <td align="right" ><gw:imgbtn id="idBtnExcel" img="excel" alt="Excel" text="Excel" styles="width: 100%" onclick="OnExcel()" /></td>                                                                                                                            
                </tr>             
                <tr style="height:4%">
                    <td align="right" >Trans Date&nbsp</td>
                    <td align="right"><gw:datebox id="dtTransDt" styles="width: 100%" lang="1" /></td>
                    <td align="right">Department&nbsp</td>
                    <td align="left"><gw:textbox id="txtDepartment"             styles="width: 100%" /></td>
                    <td align="right"><a title="Click here to select Employee"  onclick="OnPopUp('Proposed By')" href="#tips">Proposed By</a>&nbsp</td>
                    <td align="left" colspan="1"><gw:textbox id="txtUserID"     styles="width: 100%" /></td>
                    <td colspan="4" align="left"><gw:textbox id="txtUserName"   styles="width: 100%" /></td>
                    <td colspan="2" align="right">Status:&nbsp</td>
                    <td colspan="3"><gw:label id="lblStatus" text="" styles="width:100%" /></td>
                </tr>
                <tr style="height:4%">
                    <td align="right"><a title="Click here to select transaction type" onclick="OnPopUp('Trans Type')" href="#tips">Trans Type</a></td>
                    <td align="left"><gw:textbox id="txtTransCode" styles="width: 100%" csstype="mandatory" /></td>
                    <td colspan="2" align="left"><gw:textbox id="txtTransName" styles="width: 100%" csstype="mandatory" /></td>
                    <td align="right"><a title="Click here to select credit account" onclick="OnPopUp('Credit Account')" href="#tips">Credit Account</a></td>
                    <td align="left" colspan="2" ><gw:textbox id="txtDebitCode" styles="width: 100%" csstype="mandatory" /></td>
                    <td colspan="8" align="left"><gw:textbox id="txtDebitName" styles="width: 100%" csstype="mandatory" /></td>
                </tr>                                
                <tr style="height:4%">
                    <td align="right">Desc&nbsp</td>
                    <td colspan="3" align="left"><gw:textbox id="txtDesc" styles="width: 100%" /></td>
                    <td align="right">Local Desc&nbsp</td>
                    <td colspan="10" align="left"><gw:textbox id="txtLocalDesc" styles="width: 100%" /></td>                
                </tr>
                <tr style="height:4%">
                    <td colspan="1"	align="right" >VAT Rate&nbsp;</td>
					<td colspan="1" align="left"><gw:list id="lstVatRate" styles="width:100%;" onchange="OnChangeVAT()" /></td>
				<td align="right"><a title="Click here to select VAT custom office" href="#tips" onclick="OnPopUp('VATCustom')" >VAT Custom Off.&nbsp;</a></td>
					<td align="left" colspan="1" ><gw:textbox id="txtVATCustom" styles="width:100%" />
					</td>							
					<td align="right"><a title="Click here to select PL" href="#tips" onclick="OnPopUp('PL')" >PL&nbsp;</a></td>	
					<td colspan="2" align="right" ><gw:textbox id="txtPLCD" styles="width:100%"/></td>
					<td colspan="7" align="right" ><gw:textbox id="txtPLNM" styles="width:100%"/></td>
                </tr>
                <tr style="height:4%">
					<td colspan="1" align="right" >Tax Code&nbsp;</td>
					<td colspan="1" align="left" ><gw:textbox id="txtTaxCD" styles="width:100%" /></td>
					<td colspan="1" align="right" >Contract AP&nbsp;</td>
					<td colspan="1" align="left" ><gw:textbox id="txtContractNo" styles="width:100%" /></td>
					<td colspan="1" align="right">Invoice&nbsp;</td>
					<td colspan="1" align="left" ><gw:textbox id="txtInvoiceNo" styles="width:100%" /></td>					
					<td colspan="1" align="left" ><gw:datebox id="dtInvoiceNo" lang="1" /></td>
					<td colspan="2" align="right">Serial No&nbsp;</td>
					<td colspan="5" align="right" ><gw:textbox id="txtSerialNo" styles="width:100%" /></td>
                </tr>				
                <tr style="height:4%">
					<td colspan="1" align="right" ><a title="Click here to select customer" href="#tips" onclick="OnPopUp('Customer')">Customer&nbsp;</a></td>
					<td colspan="1" ><gw:textbox id="txtCustID" styles="width:100%" /></td>
					<td colspan="2" ><gw:textbox id="txtCustNM" styles="width:100%" /></td>
					<td colspan="1" align="right" >Rate&nbsp;</td>
					<td colspan="2"><gw:textbox id="txtRate" styles="width:100%" /></td>
					<td align="left" ><gw:icon id="idBtnConfirm" text="Confirm" styles="width:100%" onclick="OnConfirm()" /></td>
					<td align="left" ><gw:icon id="idBtnCancel" text="Cancel" styles="width:100%" onclick="OnCancel()" /></td>
					<td colspan="1"></td>
                    <td align="right" ><gw:imgbtn id="idBtnNew_2" img="new" alt="Get Item" text="New" styles="width: 100%" onclick="OnAddNew('2')" /></td>                                      
                    <td align="right" ><gw:imgbtn id="idBtnDelete_2" img="delete" alt="Delete Item" text="Delete" styles="width: 100%" onclick="OnDelete('2')" /></td>                                                                  
                </tr>
                <tr style="height:80%">
                    <td colspan="15">
                        <gw:grid id="grdDetail"
                            header='_pk|_item_pk|Item Code|Item Name|UOM|_acc_pk|Account code|Account Name|Qty|Price|Trans Amt|Book Amt|Vat Trans Amt|Vat Book Amt|VAT Deduct Trans|VAT Deduct Book|PL Code|PL Name|_abplcenter_pk|Description|Local Description|_mst_pk|_tin_stocktr_pk'
                            format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            aligns='0|0|0|0|1|0|1|0|3|3|3|3|3|3|3|3|0|0|0|0|0|0|0'
                            defaults='||||||||||||||||||||||' 
							editcol='0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0'                   		
                            widths='0|0|1400|2000|800|0|1100|1500|1500|1400|1600|1600|1600|1600|1600|1600|1200|1500|0|1500|1500|0|0'
                            parameter='0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22'
                            acceptNullDate='T'
                            sorting='T' 
							styles='width:100%; height:100%' 
                            oncelldblclick = "OnGridCellDblClick(this)"
                            onafteredit="OnChangeAfterEdit()"
                            oncellclick="OnGridCellClick(this)"                            
                            />                                                                                                                               
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>
<!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />      
<!------------------------------------------------------------------------>
    
<gw:textbox id="txttac_omcost_pricer_PK" style="display:none" />
<gw:textbox id="txtabemp_pk" style="display:none" />
<gw:textbox id="txtabtypetr_pk" style="display:none" />
<gw:textbox id="txttac_abacctcode_pk" style="display:none" />
<gw:textbox id="txtDept_PK" style="display:none" />
<gw:textbox id="txtReturn" style="display:none" />

<gw:textbox id="txtDebitCD" style="display:none" />
<gw:textbox id="txtDebitNM" style="display:none" />
<gw:textbox id="txtDebitPK" style="display:none" />
<gw:list id="lstBOOK_CCY" style="display:none" />
<gw:textbox id="txtPLPK" style="display:none" />
<gw:textbox id="txtCustPK" style="display:none" />
<gw:list id="lstBookCcy" style="display:none" />
<gw:textbox id="txtTransDT" style="display:none"  />
<gw:textbox id="txtBKRate" style="display:none" />
<gw:textbox id="txtVATCustom_PK" style="display:none" />
</body>
</html>
