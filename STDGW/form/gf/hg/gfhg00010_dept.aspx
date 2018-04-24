﻿<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">


var click_dr = 0;
var click_cr = 0;
var _book_rate = 0;
var _Book_CCY = "VND";
var _book_col_format = "###,###.##R";
var AdminYN;
var flag_select = false;
AdminYN ="<%=Session("CODEADMIN_YN")%>";
var lang = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    System.Translate(document);

    idGridItem.SetHeaderBold(true);
    dso_udp_ctl_mst_slip_entry.StatusInsert();
    
    txtsum_chk_dr_famt.SetEnable(false);
    txtsum_chk_dr_amt.SetEnable(false);
    txtsum_chk_cr_famt.SetEnable(false);
    txtsum_chk_cr_amt.SetEnable(false);
    txttransaction_name.SetEnable(false);
    txtProposedByUserID.SetEnable(false);
    txtProposedByUserName.SetEnable(false);
    btnTreament.SetEnable(false);
    txtLang.SetDataText(lang);
    
    btnReplicate.SetEnable(false);
    btnCancel.SetEnable(false);
    btnConfirm.SetEnable(false);
    btnCopy.SetEnable(false);
    
    <%=ESysLib.SetGridColumnComboFormat("grdDebit", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdCredit", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;


    <%=ESysLib.SetGridColumnComboFormat("grdDebit", 12,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0310' AND A.USE_IF = 1 UNION ALL SELECT '', '' FROM DUAL")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdCredit", 12,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0310' AND A.USE_IF = 1 UNION ALL SELECT '', '' FROM DUAL")%>;    
    
    _Book_CCY = "<%=ESysLib.SetDataSQL("select b.code, b.char_1  from tac_commcode_master a, tac_commcode_detail b where a.pk = b.tac_commcode_master_pk and a.id = 'ACBG0040' and b.def_yn = 'Y' and a.del_if = 0 and b.del_if = 0")%>";
    
    var a = _Book_CCY.split("|");
    if(a.length <=0) alert("Please setup book currency in common code.");
    _Book_CCY = a[0];
    txtseq.GetControl().focus();
	     
    BindingDataList();
    SetColumnFormat(a[1]);
}

function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_data1    = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.org_NM FROM comm.TCO_org A WHERE (A.END_DATE >= '20080101' OR A.END_DATE IS NULL)")%>";
    //var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE('ACBG0130') FROM DUAL")%>";
   var ls_data2    = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'ACBG0130' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>"; 

    //var ls_data    = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE_COL('ACBG0130', 'CODE', 'NVL(NUM_3, 0)') FROM DUAL")%>";
    var ls_data3    ="<%=ESysLib.SetListDataSQL("SELECT D.CODE, NVL(D.NUM_3,'0') FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'ACBG0130' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY CODE")%>"; 
    var ls_data7    = "<%=ESysLib.SetDataSQL("SELECT DECODE(B.CODE, 'Y', 'T', 'F') FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB004' AND B.DEF_YN = 'Y' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    lstCompany.SetDataText(ls_data);
    lstCompany.value = "<%=session("company_pk") %>";
    lstDepartment.SetDataText(ls_data1);
    lstVoucherType.SetDataText(ls_data2);
	lstVoucherTypePrint.SetDataText(ls_data3);
	chkauto_YN.SetDataText(ls_data7);
    if (ls_data7 == 'T')
    {
        txtvoucher_auto.SetEnable(false);
        txtvoucher_auto.SetDataText('');
    }
    else
    {
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
    }
    
    ls_data3    = "<%=ESysLib.SetListDataFUNC("SELECT sf_a_get_default ('EACAB018')   FROM DUAL")%>";
    var  arr  = ls_data3.split("|");
	txtEACAB018.SetDataText(arr[1]);  
	
	ls_data3    = "<%=ESysLib.SetListDataFUNC("SELECT sf_a_get_default ('EACAB032')   FROM DUAL")%>";
    arr  = ls_data3.split("|");
	txtEACAB032.SetDataText(arr[1]);  
    
    
  
	txtProposedByUserPk.text="<%=Session("USER_PK")%>";
    dso_ctl_getProposedBy.Call("SELECT");
}

function OnToggle()
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
    else
    {
        right.style.display="";
        imgArrow.status = "collapse";
        left.style.width="60%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
}

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

//------------------------------------- Master event ----------------------------------------------------
 
function onSearch()
{
    var path = System.RootURL + '/form/gf/hg/gfhg00010_search.aspx?com_pk='+ lstCompany.GetData() + '&VoucherType=' + lstVoucherType.GetData();;
    var object = System.OpenModal( path ,950 , 600, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no');
    if ( object != null )
    {
        if (object[0] !=0)
        {
            txtseq.text = object[0];
            CheckKeySeq();
        }
    }
}
 
function onNew()
{
    if (dso_udp_ctl_mst_slip_entry.GetStatus() != 20)
    {
        dso_udp_ctl_mst_slip_entry.StatusInsert();
    }
    grdDebit.ClearData();
    grdCredit.ClearData();
    idGridItem.SetData("");
    idGridTempItem.SetData("");
    txtProposedByUserPk.text="<%=Session("USER_PK")%>";
    dso_ctl_getProposedBy.Call("SELECT");
    SetButtonCtl(true);
    SetButtonEnable();
    btnTreament.SetEnable(false);
    OnCtrToggleRight();
    txtsum_chk_dr_famt.SetDataText('');
    txtsum_chk_dr_amt.SetDataText('');
    txtsum_chk_cr_famt.SetDataText('');
    txtsum_chk_cr_amt.SetDataText('');
    txtsum_total_dr_famt.SetDataText('');
    txtsum_total_dr_amt.SetDataText('');
    txtsum_total_cr_famt.SetDataText('');
    txtsum_total_cr_amt.SetDataText('');
    btnReplicate.SetEnable(false);
    txttransaction_code.SetDataText('');
    txttransaction_name.SetDataText('');
    txtDescription.SetDataText('');
    txtLocalDescription.SetDataText('');
    var ls_data7    = "<%=ESysLib.SetDataSQL("SELECT DECODE(B.CODE, 'Y', 'T', 'F') FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB004' AND B.DEF_YN = 'Y' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    chkauto_YN.SetDataText(ls_data7);
    if (ls_data7 == 'T')
    {
        txtvoucher_auto.SetEnable(false);
        txtvoucher_auto.SetDataText('');
    }
    else
    {
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
    }
    txttransaction_code.GetControl().focus();
}

function onDelete()
{
    if (txtStatus.GetData() == '') // Save
    {
        return;
    }
    if (txtStatus.GetData() == 1) // Save
    {
        //var path = System.RootURL + '/form/gf/hg/gfhg00010_causecancel.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData();
        var path = System.RootURL + '/form/gf/hg/gfhg00010_causecancel.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData() + '&dsqlid=ACNT.SP_PRO_CTL_MST_CONFIRM_CANCEL';
        var object = System.OpenModal( path,  400 , 400,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no');
        if ( object != null )
        {
            if (object[0] !=0)
            {
                txtseq.text = object[0];
                CheckKeySeq();
            }
        }
    }
    else
    {
        alert('You did not delete SEQ!!!'+'\n'+'B?n không th? xóa SEQ này!!!');
        return false;
    }
}
 
function onSave()
{
    if (Check_Master_Ctl())
    {
        dso_udp_ctl_mst_slip_entry.Call();
    }
}
 
function Check_Master_Ctl()
{
    if(!CanChange()) return false;
    
    if (txttransaction_code.GetData() == '')
    {
        alert('  Transaction Type is not null.Please check again!!!'+'\n'+'Lo?i giao d?ch không ???c r?ng. B?n hãy ki?m tra l?i!!!');
        return false;
    }
    if (txtProposedByUserPk.text == '')
    {
        alert(''+'\n'+'B?n ?ã h?t phiên giao d?ch. Hãy ??ng nh?p l?i, c?m ?n!!!');
        return false;
    }
    if (txtDescription.GetData() == '')
    {
        alert('   Description is not null. Please check again!!!'+'\n'+'Di?n gi?i không ???c r?ng. B?n hãy ki?m tra l?i!!!');
        return false;
    }
    if (txtLocalDescription.GetData() == '')
    {
        alert('Local description is not null. Please check again'+'\n'+'Di?n gi?i không ???c r?ng. B?n hãy ki?m tra l?i!!!');
        return false;
    }
    return true;
}
 
//-------------------------------------------- Detail event ----------------------------------------------
function Popup_OnNew(p_data)
{
    var i = 0;
    var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txttransaction_code.GetData() + "&val1=" + txttransaction_name.GetData() + "&val2=" + p_data + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR";
    aValue      = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');	
    if ( aValue != null ) 
    {
        if (aValue.length > 0)
        {
            for(i=0; i<aValue.length; i++)
            {
                var tmp = aValue[i];
                if (tmp[1] != 0)
                {
                    if (p_data == 'D')
                    {
                        grdDebit.AddRow();
                        grdDebit.SetGridText( grdDebit.rows - 1, 15, 'D' );
					    grdDebit.SetGridText( grdDebit.rows - 1, 1, tmp[1]);    //ACPK
					    grdDebit.SetGridText( grdDebit.rows - 1, 4, tmp[4]);    //Account Code
					    grdDebit.SetGridText( grdDebit.rows - 1, 5, tmp[5]);    //Account Name
					    if (grdDebit.rows > 2)
					    {
					        var ls_curr = grdDebit.GetGridData(grdDebit.rows - 2, 6);
					        var ls_rate = grdDebit.GetGridData(grdDebit.rows - 2, 7);
					        var ls_ref  = grdDebit.GetGridData(grdDebit.rows - 2, 3);
					        grdDebit.SetGridText( grdDebit.rows - 1, 6, ls_curr);       //Rate
					        grdDebit.SetGridText( grdDebit.rows - 1, 7, ls_rate);       //Rate
					        grdDebit.SetGridText( grdDebit.rows - 1, 3, ls_ref);
					    }
					    else
					    {
					        grdDebit.SetGridText( grdDebit.rows - 1, 7, '1');           //Rate
					        grdDebit.SetGridText( grdDebit.rows - 1, 3, '1' );
					    }
					    grdDebit.SetGridText( grdDebit.rows - 1, 10, txtDescription.text );         //Desc Eng
					    grdDebit.SetGridText( grdDebit.rows - 1, 11, txtLocalDescription.text );    //Desc Local
					    grdDebit.SetGridText( grdDebit.rows - 1, 13, txtseq.text );                 //SEQ
					    grdDebit.SetRowEditable(grdDebit.rows - 1, false);
					    click_dr = 0;					    					    					    
                        grdDebit.SetGridText( grdDebit.rows - 1, 17, GetBookExRate(_Book_CCY));
                    }
                    else if (p_data == 'C')
                    {
                        grdCredit.DeselectRow(grdCredit.selrow);
                        grdCredit.AddRow();
                        grdCredit.SelectRow(grdCredit.rows - 1);
                        grdCredit.SetGridText( grdCredit.rows - 1, 15, 'C' );
					    grdCredit.SetGridText( grdCredit.rows - 1, 1, tmp[1]);  //ACPK
					    grdCredit.SetGridText( grdCredit.rows - 1, 4, tmp[4]);  //Account Code
					    grdCredit.SetGridText( grdCredit.rows - 1, 5, tmp[5]);  //Account Name
					    if (grdCredit.rows > 2)
					    {
					        var ls_curr = grdCredit.GetGridData(grdCredit.rows - 2, 6);
					        var ls_rate = grdCredit.GetGridData(grdCredit.rows - 2, 7);
					        var ls_ref  = grdCredit.GetGridData(grdCredit.rows - 2, 3);
					        grdCredit.SetGridText( grdCredit.rows - 1, 6, ls_curr);       //Rate
					        grdCredit.SetGridText( grdCredit.rows - 1, 7, ls_rate);       //Rate
					        grdCredit.SetGridText( grdCredit.rows - 1, 3, ls_ref);
					    }
					    else
					    {
					        grdCredit.SetGridText( grdCredit.rows - 1, 7, '1');           //Rate
					        grdCredit.SetGridText( grdCredit.rows - 1, 3, '1' );
					    }
					    var ls_ref;
					    if (grdDebit.selrow != -1)
					    {
					        ls_ref = grdDebit.GetGridData(grdDebit.selrow, 3);
					    }
					    else
					    {
					        ls_ref = 1;
					    }
					    grdCredit.SetGridText( grdCredit.rows - 1, 3, ls_ref );
                        onSetData_CR(ls_ref);
					    grdCredit.SetGridText( grdCredit.rows - 1, 10, txtDescription.text );         //Desc Eng
					    grdCredit.SetGridText( grdCredit.rows - 1, 11, txtLocalDescription.text );    //Desc Local
					    grdCredit.SetGridText( grdCredit.rows - 1, 13, txtseq.text);                 //SEQ
					    grdCredit.SetRowEditable(grdCredit.rows - 1, false);
					    grdCredit.SetGridText( grdCredit.rows - 1, 17, GetBookExRate(_Book_CCY));
					    click_cr = 0;
                    }
                }
            }
        }
    }
}

function onSetData_CR(p_ref)
{
	var l_sum_dr = 0;
	var l_sum_cr = 0;
	for (i = 1; i < grdDebit.rows; i++)
	{
        if (grdDebit.GetGridData(i, 3) == p_ref)
        {
            l_sum_dr = l_sum_dr + Number(grdDebit.GetGridData(i, 9));
        }
	}
	for (i = 1; i < grdCredit.rows; i++)
	{
        if ((grdCredit.GetGridData(i, 3) == p_ref) && (grdCredit.selrow != click_cr))
        {
            l_sum_cr = l_sum_cr + Number(grdCredit.GetGridData(i, 9));
        }
	}
	//grdCredit.SetGridText( grdCredit.rows - 1, 9, l_sum_dr - l_sum_cr);
	for (i = 1; i < grdCredit.rows; i++)
    {
        if (grdCredit.selrow == i)
        {
            grdCredit.SetCellBold(i,1,i,17,true);
            grdCredit.SetRowEditable(i, true);
        }
        else
        {
            grdCredit.SetCellBold(i,1,i,17,false);
            grdCredit.SetRowEditable(i, false);
        }
    }
}
    
function OnNewDr()
{
    if (txttransaction_code.GetData() != '')
    {
        OnCtrToggleRight();
        Popup_OnNew('D');
    }
    else
    {
        alert('Please Choose Transaction Type!!!'+'\n'+'    B?n hãy ch?n lo?i giao d?ch!!!');
        return;
    }
}    

function OnNewCr()
{
    if (txttransaction_code.GetData() != '')
    {
        OnCtrToggleRight();
        Popup_OnNew('C');
    }
    else
    {
        alert('Please Choose Transaction Type!!!'+'\n'+'    B?n hãy ch?n lo?i giao d?ch!!!');
        return;
    }
}

//--------------------------------------------------------------------------------------------------------
function OnUpDr()
{
	var lb_flag
    ctrl = grdDebit.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    var j = 0;
        var i = 1;
        while ((i < ctrl.rows) && (j < 1))
        {
            if (ctrl.isSelected(i) == true)
            {
                j = j + 1;
            }
            i = i + 1;
        }

        if (j > 1)
        {
            alert('    You must one row to move!!!'+'\n'+'B?n ch? ch?n 1 dòng ?? di chuy?n!!!')
            return;
        }
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        if (grdDebit.selrow > 1)
        {
            for (i = 1; i < grdDebit.rows; i++)
            {
                grdDebit.SetCellBold(i,1,i,15,false);
                grdDebit.SetRowEditable(i, false);
            }
            grdDebit.UpRow();
        }
	}
	else
	{
		if (ctrl.rows < 3) return;
		alert('   Please select one row to move!!!'+'\n'+'B?n hãy ch?n 1 dòng ?? di chuy?n!!!');
		return;
	}
}

function OnDownDr()
{
	var lb_flag
    ctrl = grdDebit.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    var j = 0;
        var i = 1;
        while ((i < ctrl.rows) && (j < 1))
        {
            if (ctrl.isSelected(i) == true)
            {
                j = j + 1;
            }
            i = i + 1;
        }

        if (j > 1)
        {
            alert('    You must one row to move!!!'+'\n'+'B?n ch? ch?n 1 dòng ?? di chuy?n!!!')
            return;
        }
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        if (grdDebit.selrow < ctrl.rows -1 )
        {
            for (i = 1; i < grdDebit.rows; i++)
            {
                grdDebit.SetCellBold(i,1,i,15,false);
                grdDebit.SetRowEditable(i, false);
            }
            grdDebit.DownRow();
        }
	}
	else
	{
		if (ctrl.rows < 3) return;
		alert('   Please select one row to move!!!'+'\n'+'B?n hãy ch?n 1 dòng ?? di chuy?n!!!');
		return;
	}
}

function OnUpCr()
{
	var lb_flag
    ctrl = grdCredit.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    var j = 0;
        var i = 1;
        while ((i < ctrl.rows) && (j < 1))
        {
            if (ctrl.isSelected(i) == true)
            {
                j = j + 1;
            }
            i = i + 1;
        }

        if (j > 1)
        {
            alert('    You must one row to move!!!'+'\n'+'B?n ch? ch?n 1 dòng ?? di chuy?n!!!')
            return;
        }
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        if (grdCredit.selrow > 1)
        {
            for (i = 1; i < grdCredit.rows; i++)
            {
                grdCredit.SetCellBold(i,1,i,15,false);
                grdCredit.SetRowEditable(i, false);
            }
            grdCredit.UpRow();
        }
	}
	else
	{
		if (ctrl.rows < 3) return;
		alert('  Please select one row to move!!!'+'\n'+'B?n hãy ch?n 1 dòng ?? di chuy?n!!!');
		return;
	}
}

function OnDownCr()
{
	var lb_flag
    ctrl = grdCredit.GetGridControl();
	rows = ctrl.Rows  - 1;
	if (rows > 1)
	{
	    var j = 0;
        var i = 1;
        while ((i < ctrl.rows) && (j < 1))
        {
            if (ctrl.isSelected(i) == true)
            {
                j = j + 1;
            }
            i = i + 1;
        }

        if (j > 1)
        {
            alert('    You must one row to move!!!'+'\n'+'B?n ch? ch?n 1 dòng ?? di chuy?n!!!')
            return;
        } 
	    
	    i = 1;
	    lb_flag = false;
	    while ((i <= rows) && !lb_flag)
	    {
	        if (ctrl.isSelected (i) == true)
	        {
	            lb_flag = true;
	        }
	        else
	        {
	            i = i + 1;
            }
	    }
	}
	if (lb_flag)
	{
        if (grdCredit.selrow < ctrl.rows -1 )
        {
            for (i = 1; i < grdCredit.rows; i++)
            {
                grdCredit.SetCellBold(i,1,i,15,false);
                grdCredit.SetRowEditable(i, false);
            }
            grdCredit.DownRow();
        }
	}
	else
	{
		if (ctrl.rows < 3) return;
		alert('Please select one row to move!!!'+'\n'+'B?n hãy ch?n 1 dòng ?? di chuy?n!!!');
		return;
	}
}

function OnEnterTrans_Code()
{
    if (txtStatus.GetData() != '')
    {
        alert('You canot change Transaction Type!!!'+'\n'+'B?n không th? thay ??i lo?i giao d?ch');
        txttransaction_code.text = txttrans_code_tmp.GetData();
        return;
    }
    txttransaction_name.SetDataText('');
    txt_DRCR.SetDataText('D');
    dso_sel_trans_debit.Call('SELECT');
}

function OnTransactionPopUp()
{
    if (txtStatus.GetData() != '')
    {
        alert('You canot change Transaction Type!!!'+'\n'+'B?n không th? thay ??i lo?i giao d?ch');
        return;
    }
    txttransaction_code.text = "";
    txttransaction_name.text = "";
    txtDescription.text      = "";
    txtLocalDescription.text = "";
    
    grdDebit.ClearData();
    grdCredit.ClearData();
    var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCompany.GetData();
    aValue = System.OpenModal( path ,850 , 500 ,  'resizable:yes;status:yes');
    if ( aValue != null )
	{
		var tmp = aValue[0];
		if (tmp[1] != null)
		{
		    txttrans_pk.text         = tmp[0];
		    txttransaction_code.text = tmp[1];
		    txttransaction_name.text = tmp[2];
		    txtDescription.text      = tmp[3];
            txtLocalDescription.text = tmp[4];
		}
		if(aValue.length < 2)
		{
		    txt_DRCR.SetDataText('D');
			dso_sel_trans_debit.Call('SELECT');
		}
		else if (aValue.length > 1)
		{		
			for(i=1;i<aValue.length;i++)
			{
			    var tmp1= aValue[i];
			    if (tmp1[0] == "D")
				{
					grdDebit.AddRow();
					grdDebit.SetGridText( grdDebit.rows - 1,  3, '1' );
					grdDebit.SetGridText( grdDebit.rows - 1, 1, tmp1[2] ); //ACPK
					grdDebit.SetGridText( grdDebit.rows - 1, 4, tmp1[5] ); //Account Code
					grdDebit.SetGridText( grdDebit.rows - 1, 5, tmp1[6] ); //Account Name
					grdDebit.SetGridText( grdDebit.rows - 1, 10, txtDescription.text);         //Desc Eng
					grdDebit.SetGridText( grdDebit.rows - 1, 11, txtLocalDescription.text);    //Desc Local
					grdDebit.SetGridText( grdDebit.rows - 1, 13, txtseq.text);
					grdDebit.SetRowEditable(grdDebit.rows - 1, false);
					grdDebit.SetGridText( grdDebit.rows - 1, 17, GetBookExRate(_Book_CCY));
					
				}
				else if (tmp1[0] == "C")
				{
					grdCredit.AddRow();
					grdCredit.SetGridText( grdCredit.rows - 1,  3, '1' );
					grdCredit.SetGridText( grdCredit.rows - 1, 1, tmp1[2] ); //ACPK
					grdCredit.SetGridText( grdCredit.rows - 1, 4, tmp1[5] ); //Account Code
					grdCredit.SetGridText( grdCredit.rows - 1, 5, tmp1[6] ); //Account Name
					grdCredit.SetGridText( grdCredit.rows - 1, 10, txtDescription.text );       //Desc Eng
					grdCredit.SetGridText( grdCredit.rows - 1, 11, txtLocalDescription.text );  //Desc Local
					grdCredit.SetGridText( grdCredit.rows - 1, 13, txtseq.text);
					grdCredit.SetRowEditable(grdCredit.rows - 1, false);
					grdCredit.SetGridText( grdCredit.rows - 1, 17, GetBookExRate(_Book_CCY));
				}
			}
		}
	}
}

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
	    if (event.col == 9){
        
          var col_3='';
          col_3 = grdDebit.GetGridData(grdDebit.row,3);
         
          if(txtEACAB032.GetData()=='N' && col_3==1 ){
             grdDebit.row=-1;
            return;
           } 
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
            txthgtrd.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 0));
            txt_rowclick.text = grdDebit.selrow;
            txt_drcr_type.SetDataText('D');
            idGridItem.SetData("");
            click_dr = grdDebit.selrow;
            click_cr = 0;
            dso_upd_ctl_item.Call("SELECT");
        }
        
        OnCheckSumDR();
    }
}

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
	    if (event.col == 9){
        
          var col_3='';
          col_3 = grdCredit.GetGridData(grdCredit.row,3);
         
          if(txtEACAB032.GetData()=='N' && col_3==1 ){
             grdCredit.row=-1;
            return;
           } 
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
            txthgtrd.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 0));
            txt_rowclick.text = grdCredit.selrow;
            txt_drcr_type.SetDataText('C');
            idGridItem.SetData("");
            click_dr = 0;
            click_cr = grdCredit.selrow;
            dso_upd_ctl_item.Call("SELECT");
        }
        
        OnCheckSumCR();
    }
}

function DBPopupClick_DR()
{
    if (event.col == 4)
	{
	    Popup_OnSelect_Acc('D');
    }
}

function DBPopupClick_CR()
{
    if (event.col == 4)
	{
	    Popup_OnSelect_Acc('C');
    }
}


function SetColumnFormat(p_format){
    var fg = grdDebit.GetGridControl();
    fg.ColFormat(7) = "###,###R"; 
	fg.ColFormat(8) = "###,###.##R";
	fg.ColFormat(17) = "###,###R"; 
	fg.ColFormat(18) = "###,###R"; 
	
	if(p_format != ""){
	    fg.ColFormat(9) = p_format;
	    _book_col_format = p_format;
	} 
	else{
	    fg.ColFormat(9) = "###,###R"; 
	}
	
	fg=grdCredit.GetGridControl();
    fg.ColFormat(7) = "###,###R"; 
	fg.ColFormat(8) = "###,###.##R"; 
	fg.ColFormat(17) = "###,###R"; 
	fg.ColFormat(18) = "###,###R"; 
	if(p_format != ""){
	    fg.ColFormat(9) = p_format; 
	    _book_col_format = p_format;
	} 
	else{
	    fg.ColFormat(9) = "###,###R"; 
	}
}
function SetButtonCtl(p_data)
{
    btnNew_Dr.SetEnable(p_data);
    btnSave_Dr.SetEnable(p_data);
    btnDel_Dr.SetEnable(p_data);
    btnUp_Dr.SetEnable(p_data);
    btnDown_Dr.SetEnable(p_data);
        
    btnNew_Cr.SetEnable(p_data);
    btnSave_Cr.SetEnable(p_data);
    btnDel_Cr.SetEnable(p_data);
    btnUp_Cr.SetEnable(p_data);
    btnDown_Cr.SetEnable(p_data);
    btnTreament.SetEnable(p_data);
    ibtnDelete.SetEnable(p_data);
    ibtnSave.SetEnable(p_data);
}


function SetButtonEnable()
{
    if (txtStatus.GetData() == 1) // Save
    {
        //btnConfirm.SetEnable(true);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        SetButtonCtl(true);
    }
    else if (txtStatus.GetData() == 2) // Comfirm
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(true);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == 3) // Cancel
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(true);
        btnCopy.SetEnable(false);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == '') // New
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(false);
        SetButtonCtl(true);
    }
    else if (txtStatus.GetData() == 0) // Approve
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == 4) // No Approve
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(false);
        SetButtonCtl(false);
    }
}

function OnSetDescriptionDetail()
{
    for (i = 1; i < grdDebit.rows; i++)
    {
        grdDebit.SetGridText( i, 10, txtDescription.GetData());
        grdDebit.SetGridText( i, 11, txtLocalDescription.GetData());
    }
    for (i = 1; i < grdCredit.rows; i++)
    {
        grdCredit.SetGridText( i, 10, txtDescription.GetData());
        grdCredit.SetGridText( i, 11, txtLocalDescription.GetData());
    }
}

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_ctl_getProposedBy":
             dso_get_exrate_list.Call();
             break;
        case "dso_sel_trans_debit":
            txt_DRCR.SetDataText('C');
            dso_sel_trans_credit.Call('SELECT');
        break;
        
        case "dso_sel_trans_credit":
            OnCloseData();
            dso_pro_get_transname.Call();
        break;
        
        case "dso_pro_get_transname":
            OnSetDescriptionDetail();
        break;
        
        case "dso_udp_ctl_mst_slip_entry":
            txttrans_code_tmp.text = txttransaction_code.GetData();
            SetButtonEnable();
             lstVoucherTypePrint.value = lstVoucherType.value;
            if (flag_select == true){
                txt_drcr_type.SetDataText('D');
                dso_upd_grd_dtl_slip_entry_dr.Call("SELECT");
            }
        break;
        
        case "dso_upd_grd_dtl_slip_entry_dr":
            OnCloseData();
            if (flag_select == true)
            {
                txt_drcr_type.SetDataText('C');
                dso_upd_grd_dtl_slip_entry_cr.Call("SELECT");
            }
            else{
                click_dr = 0;
                click_cr = 0;
                SaveItemControl();
            }           
            for (i=1;i<=grdDebit.rows-1;i++)
            {
                grdDebit.SetCellBgColor(i,17,i,17,Number(0XCDFAFF));
            }  
        break;
        
        case "dso_upd_grd_dtl_slip_entry_cr":
            if (flag_select == true){
                flag_select = false;
                click_dr = 0;
                click_cr = 0;
                dso_get_exrate_list.Call();
            }
            else{
                SaveItemControl();
            }
            for (i=1;i<=grdCredit.rows-1;i++)
            {
                grdCredit.SetCellBgColor(i,17,i,17,Number(0XCDFAFF));
            }  
        break;
                    
        break;
        case "dso_upd_confirm_cancel":
            SetButtonEnable();
            CheckKeySeq();
        break;
        case "dso_upd_replicate":
            SetButtonEnable();
            CheckKeySeq();
        break;
        case "dso_upd_copy":
            SetButtonEnable();
            CheckKeySeq();
        break;
        case "dso_get_exrate_list":
            _book_rate = GetBookExRate(_Book_CCY);
            lblBookRate.text = _book_rate;
        break;
    }
}
function CanChange(){
    switch(txtStatus.GetData()){
        case "0":alert("This voucher was approved. So you can not change !.\n S? phi?u này ?ã ???c approve. B?n không th? thay ??i !");
               return false;
        break;
        case "1": return true;
        case "2":alert("This voucher was confirmed. So you can not change !.\n S? phi?u này ?ã ???c xác nh?n. B?n không th? thay ??i !");
                 return false;
        break;
        case "3": return true;
        break;
        case "4": alert("This voucher was approved. So you can not change !.\n S? phi?u này ?ã ???c approve. B?n không th? thay ??i !");
               return false;
        break;
    }
    return true;
}
function OnSaveDr()
{
    if(!CheckDataIsValid()) return;
    
     SetItemToGridTmp();
    
    if ((txt_drcr_type.GetData() == 'D') && (grdDebit.rows > 1))
    {
        for (i = 1; i < grdDebit.rows; i++)
        {
            if ((grdDebit.GetGridData(i, 13) == "") && (grdDebit.GetGridData(i, 9) != ''))
            {
                grdDebit.SetGridText(i, 13, txtseq.GetData());
                grdDebit.SetRowStatus(i, 0x20);
            }            
            if (grdDebit.GetGridData(i, 9) == '')
            {
                grdDebit.SetGridText(i, 13, txtseq.GetData());
                grdDebit.SetGridText(i, 8, 0);
                grdDebit.SetGridText(i, 9, 0);
            }
            grdDebit.SetGridText(i, 15, 'D');
            if (grdDebit.GetGridData(i, 10) == "")
            {
                grdDebit.SetGridText(i, 10, txtDescription.GetData());
            }
            if (grdDebit.GetGridData(i, 11) == "")
            {
                grdDebit.SetGridText(i, 11, txtLocalDescription.GetData());
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
                    grdDebit.SetGridText(i, 13, txtseq.GetData());
                }
                grdDebit.SetGridText(i, 14, i - j);
            }
        }
        txt_rowclick.text = grdDebit.selrow;
        dso_upd_grd_dtl_slip_entry_dr.Call();
    }
}

function OnSaveCr()
{
    if(!CheckDataIsValid()) return;
    
     SetItemToGridTmp();
    
    if ((txt_drcr_type.GetData() == 'C') && (grdCredit.rows > 1))
    {
        for (i = 1; i < grdCredit.rows; i++)
        {
            if ((grdCredit.GetGridData(i, 13) == "") && (grdCredit.GetGridData(i, 9) != ''))
            {
                grdCredit.SetGridText(i, 13, txtseq.GetData());
                grdCredit.SetRowStatus(i, 0x20);
            }
            if (grdCredit.GetGridData(i, 9) == '')
            {
                grdCredit.SetGridText(i, 13, txtseq.GetData());
                grdCredit.SetGridText(i, 8, 0);
                grdCredit.SetGridText(i, 9, 0);
            }
            grdCredit.SetGridText(i, 15, 'C');
            if (grdCredit.GetGridData(i, 10) == "")
            {
                grdCredit.SetGridText(i, 10, txtDescription.GetData());
            }
            if (grdCredit.GetGridData(i, 11) == "")
            {
                grdCredit.SetGridText(i, 11, txtLocalDescription.GetData());
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
                    grdCredit.SetGridText(i, 13, txtseq.GetData());
                }
                grdCredit.SetGridText(i, 14, i - j);
            }
        }
        txt_rowclick.text = grdCredit.selrow;
        dso_upd_grd_dtl_slip_entry_cr.Call();
    }
}

function OnCloseData()
{
    for (i = 1; i < grdDebit.rows; i++)
    {
        grdDebit.SetGridText( i, 14, i);
        grdDebit.SetRowEditable(i, false);
    }
    for (i = 1; i < grdCredit.rows; i++)
    {
        grdCredit.SetGridText( i, 14, i);
        grdCredit.SetRowEditable(i, false);
    }
}

function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}

function Popup_OnSelect_Acc(p_data)
{
    if(!CanChange()) return;
    
    var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txttransaction_code.GetData() + "&val1=" + txttransaction_name.GetData() + "&val2=" + p_data + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR";
    aValue      =   System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');	
    if (aValue != null)
    {
        if (aValue.length > 0)
        {
            for(i=0; i<aValue.length; i++)
            {
                var tmp = aValue[i];
                if (tmp[1] != 0)
                {
                    idGridItem.SetData("");
                    if ((p_data == 'D') && (txtStatus.GetData() == 1 || txtStatus.GetData() == ''))  
                    {
                        grdDebit.SetGridText( grdDebit.selrow, 15, 'D' );
					    grdDebit.SetGridText( grdDebit.selrow,  3, '1' );
					    grdDebit.SetGridText( grdDebit.selrow, 1, tmp[1]);
					    grdDebit.SetGridText( grdDebit.selrow, 4, tmp[4]);
					    grdDebit.SetGridText( grdDebit.selrow, 5, tmp[5]);
					    grdDebit.SetGridText( grdDebit.selrow, 16, GetBookExRate(_Book_CCY));
					    click_dr = 0;
                        click_cr = 0;
					    RowClick_DR();
                    }
                    else if ((p_data == 'C') && (txtStatus.GetData() == 1 || txtStatus.GetData() == ''))
                    {
                        grdCredit.SetGridText( grdCredit.selrow, 15, 'C' );//account type
					    grdCredit.SetGridText( grdCredit.selrow,  3, '1' );//
					    grdCredit.SetGridText( grdCredit.selrow, 1, tmp[1]);//
					    grdCredit.SetGridText( grdCredit.selrow, 4, tmp[4]);//
					    grdCredit.SetGridText( grdCredit.selrow, 5, tmp[5]);//
					    grdCredit.SetGridText( grdDebit.selrow, 16, GetBookExRate(_Book_CCY));
					    var ls_ref;
					    if (grdDebit.selrow != -1)
					    {
					        ls_ref = grdDebit.GetGridData(grdDebit.selrow, 3);
					    }
					    else
					    {
					        ls_ref = 1;
					    }
					    grdCredit.SetGridText(grdCredit.rows - 1, 3, ls_ref);
                        onSetData_CR(ls_ref);
					    click_dr = 0;
                        click_cr = 0;
					    RowClick_CR();
                    }
                }
            }
        }
    }
}

function OnAutoYN()
{
    if (chkauto_YN.GetData() != 'T')
    {
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
    }
    else
    {
        txtvoucher_auto.SetEnable(false);
    }
}

function OnReplicate()
{
    dso_upd_replicate.Call();
}

function OnCopy()
{
    dso_upd_copy.Call();
}

function OnConfirmCancel()
{
    var path = System.RootURL + '/form/gf/hg/gfhg00010_causecancel.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData() + '&dsqlid=ACNT.SP_PRO_CTL_MST_CONFIRM_CANCEL' + '&table=TAC_HGTRH';
    var object = System.OpenModal( path,  400 , 400,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no');
    if ( object != null )
    {
        if (object[0] !=0)
        {
            txtseq.text = object[0];
            CheckKeySeq();
        }
    }
}

function OnConfirm()
{
    if(!CanChange()) return;
    
    dso_upd_confirm.Call();
}

function CheckKeySeq()
{
    if (txtseq.GetData() != '')
    {
        txttransaction_code.SetDataText("");
        txttransaction_name.SetDataText("");
        txtDescription.SetDataText("");
        txtLocalDescription.SetDataText("");
        grdDebit.ClearData();
        grdCredit.ClearData();
        idGridItem.SetData("");
        flag_select = true;
        click_dr = 0;
        click_cr = 0;
        OnCtrToggleRight();
        txtsum_chk_dr_famt.text = 0;
        txtsum_chk_dr_amt.text  = 0;
        txtsum_chk_cr_famt.text = 0;
        txtsum_chk_cr_amt.text  = 0;
        txtsum_total_dr_famt.SetDataText("");
        txtsum_total_dr_amt.SetDataText("");
        txtsum_total_cr_famt.SetDataText("");
        txtsum_total_cr_amt.SetDataText("");
        dso_udp_ctl_mst_slip_entry.Call('SELECT');
    }
}

function OnCheck_DR()
{
    var flag = true;
    var i = 1;
    while ((i < grdDebit.rows) && flag)
    {
        var data = grdDebit.GetGridData(i, 1)
        if (data == '')
        {
            alert('Accout Code/Name is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'Mã/Tên tài kho?n không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdDebit.GetGridData(i, 3)
        if (data == '')
        {
            alert('REF is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'REF không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdDebit.GetGridData(i, 7)
        if (data == '')
        {
            alert('EX Rate is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'T? l? quy ??i không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdDebit.GetGridData(i, 8)
        if (!isFinite(data))
        {
            alert('Amount Transaction is number. Please check row '+ (i+1) +' again!!!'+'\n'+'Ti?n giao d?ch là s?. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdDebit.GetGridData(i, 9)
        if (!isFinite(data))
        {
            alert('Amount Book is number. Please check row '+ (i+1) +' again!!!'+'\n'+'Ti?n ghi s? là s?. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        i = i + 1;
    }
    if (flag)
    {
        return true;
    }
}

function OnCheck_CR()
{
    var flag = true;
    var i = 1;
    while ((i < grdCredit.rows) && flag)
    {
        var data = grdCredit.GetGridData(i, 1)
        if (data == '')
        {
            alert('Accout Code/Name is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'Mã/Tên tài kho?n không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdCredit.GetGridData(i, 3)
        if (data == '')
        {
            alert('REF is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'REF không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdCredit.GetGridData(i, 7)
        if (data == '')
        {
            alert('EX Rate is not null. Please check row '+ (i+1) +' again!!!'+'\n'+'T? l? quy ??i không ???c r?ng. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdCredit.GetGridData(i, 8)
        if (!isFinite(data))
        {
            alert('Amount Transaction is number. Please check row '+ (i+1) +' again!!!'+'\n'+'Ti?n giao d?ch là s?. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        var data = grdCredit.GetGridData(i, 9)
        if (!isFinite(data))
        {
            alert('Amount Book is number. Please check row '+ (i+1) +' again!!!'+'\n'+'Ti?n ghi s? là s?. B?n hãy ki?m tra l?i dòng '+ (i+1) +'!!!')
            flag = false;
            return false;
        }
        i = i + 1;
    }
    if (flag)
    {
        return true;
    }
}

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
	
	
	SetDetailCtlItem();	
	
}

function SetDetailCtlItem()
{
  // alert(idGridItem.rows)
	if (idGridItem.rows > 1)
	{
	    for (i = 1; i<idGridItem.rows; i++)
	    {
            var itemal  = idGridItem.GetGridData(i,8);
            var item    = idGridItem.GetGridData(i,9);
		     
	        for (j = 1; j<idGridTempItem.rows; j++)
	        {
	            var itemal2 = idGridTempItem.GetGridData(j,1);
	            var item2   = idGridTempItem.GetGridData(j,2);
	            var itemnm2 = idGridTempItem.GetGridData(j,3);
	            var itempk2 = idGridTempItem.GetGridData(j,4);	
	            
	         // alert('itemal=' + itemal + ',itemal2=' + itemal2 + ',item=' + item); 
	        //  alert('item2=' + item2 + ',itemnm2=' + itemnm2 + ',itempk2=' + itempk2);
	           
	            if ((itemal == itemal2) && (item == '') && (txtEACAB018.GetData()=='Y'))
	            {
	            ///    alert('ww');
	                idGridItem.SetGridText( i ,  9, item2);
			        idGridItem.SetGridText( i , 10, itemnm2);
			        idGridItem.SetGridText( i , 12, itempk2);
	            }
	        }
	    }
    }
    if (txt_drcr_type.GetData() == 'D') 
    {
        grdDebit.SelectRow(txt_rowclick.text);
    }
    else
    {
        grdCredit.SelectRow(txt_rowclick.text);
    }
}

function OnDelDr()
{
    var ctrl = grdDebit.GetGridControl();
    if (grdDebit.rows > 1)
    {
        var j = 0;
        var i = 1;
        if (confirm('Are you sure you want to delete?'+'\n'+'B?n có ch?c mu?n xóa Code này?'))
        {
            for ( i=1; i < ctrl.rows; i++ )
		    {
		        if (ctrl.isSelected(i) == true)
		        {
                    grdDebit.DeleteRow();
                    idGridItem.SetData("");
                    OnCtrToggleRight();
                }
            }
            dso_upd_grd_dtl_slip_entry_dr.Call();
        }
    }
}

function OnDelCr()
{
    var ctrl = grdCredit.GetGridControl();
    if (grdCredit.rows > 1)
    {
        var j = 0;
        var i = 1;
        if (confirm('Are you sure you want to delete?'+'\n'+'B?n có ch?c mu?n xóa Code này?'))
        {
            for ( i=1; i < ctrl.rows; i++ )
		    {
		        if (ctrl.isSelected(i) == true)
		        {
                    grdCredit.DeleteRow();
                    idGridItem.SetData("");
                    OnCtrToggleRight();
                }
                dso_upd_grd_dtl_slip_entry_cr.Call();
            }
        }
    }
}
function CheckDataIsValid(){
    if(!CanChange()) return false;
    
    if (txtseq.GetData() == ''){
        alert('  Save Master and then Treament'+'\n'+'B?n l?u l?i tr??c sau ?ó Treament');
        return false;
    }
    //    Check Item Control
    if ((grdDebit.selrow < 1) && (grdCredit.selrow < 1)){
        return false;
    }
    var ctrl = idGridItem.GetGridControl();
	var j = 1;
	var i = ctrl.rows - 1;
	while (j <= i){
		var man         = idGridItem.GetGridData(j,6);
		var itemtitle   = idGridItem.GetGridData(j,8);
		var item        = idGridItem.GetGridData(j,9);
		if(man == "Y" & (item == "" || item == "-")){
			alert('           '+ itemtitle + ' is mandatory. Please input!!!'+'\n'+ itemtitle +' thông tin b?t bu?c nh?p. Vui lòng nh?p vào!!!');
			return false;
		}
		j = j + 1;
	}
	return true;
}
function OnTreament()
{
  if(txt_drcr_type.GetData() == 'C'){
    OnSaveCr();
  }
  else{
    OnSaveDr();
  }
}

function SaveItemControl()
{
    if (idGridItem.rows > 1)
	{
	    for (i = 1; i<idGridItem.rows; i++)
	    {
            if (txt_drcr_type.GetData() == 'D')
            {
                if ((idGridItem.GetGridData(i, 0) == '') && (idGridItem.GetGridData(i, 9) !='' ))
                {
                    idGridItem.SetGridText(i, 1, grdDebit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                //idGridItem.SetGridText(i, 1, grdDebit.GetGridData(txt_rowclick.text, 0));
                txtacpk.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 1));
                txthgtrd.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 0));
            }
            else if (txt_drcr_type.GetData() == 'C')
            {
                if (idGridItem.GetGridData(i, 0) == '')
                {
                    idGridItem.SetGridText(i, 1, grdCredit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                //idGridItem.SetGridText(i, 1, grdCredit.GetGridData(txt_rowclick.text, 0));
                txtacpk.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 1));
                txthgtrd.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 0));
            }
	    }
	    dso_upd_ctl_item.Call("");
    }
}

function SetItemToGridTmp()
{
	var ctrl = idGridItem.GetGridControl();
	for (i = 1; i < ctrl.rows; i++)
	{
		var acctpk  = idGridItem.GetGridData(i,2);
		var itemal  = idGridItem.GetGridData(i,8);
		var item    = idGridItem.GetGridData(i,9);
		var itemnm  = idGridItem.GetGridData(i,10);
		var itempk  = idGridItem.GetGridData(i,12);
		var ctrl1    = idGridTempItem.GetGridControl();
		if (ctrl1.rows > 1)
		{
		    // Kiem tra xem co du lieu duoi grid tam hay khong?
		    var flag;
		    var j;
		    flag = false
		    j = 1;
		    while ((j < ctrl1.rows) && (!flag))
		    {
		        var itemal1  = idGridTempItem.GetGridData(j,1);
		        if (itemal == itemal1)
		        {
		            flag = true;
		            idGridTempItem.SetGridText(  j , 0, acctpk);
		            idGridTempItem.SetGridText(  j , 1, itemal);
		            idGridTempItem.SetGridText(  j , 2, item);
		            idGridTempItem.SetGridText(  j , 3, itemnm);
		            idGridTempItem.SetGridText(  j , 4, itempk);
		        }
		        j = j + 1;
		    }
		    if (!flag)
		    {
		        idGridTempItem.AddRow();
                idGridTempItem.SetGridText(  ctrl1.rows - 1 , 0, acctpk);
		        idGridTempItem.SetGridText(  ctrl1.rows - 1 , 1, itemal);
		        idGridTempItem.SetGridText(  ctrl1.rows - 1 , 2, item);
		        idGridTempItem.SetGridText(  ctrl1.rows - 1 , 3, itemnm);
		        idGridTempItem.SetGridText(  ctrl1.rows - 1 , 4, itempk);
		    }
		}
		else
		{
		    idGridTempItem.AddRow();
            idGridTempItem.SetGridText(  ctrl1.rows - 1 , 0, acctpk);
			idGridTempItem.SetGridText(  ctrl1.rows - 1 , 1, itemal);
			idGridTempItem.SetGridText(  ctrl1.rows - 1 , 2, item);
			idGridTempItem.SetGridText(  ctrl1.rows - 1 , 3, itemnm);
			idGridTempItem.SetGridText(  ctrl1.rows - 1 , 4, itempk);
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
        if ( object.length > 0 ){
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
    else if(idGridItem.GetGridData( idGridItem.row, 8) == 'CONTRACT NOAP'){
	    var fpath   = System.RootURL + "/form/gf/co/gfco002007.aspx?contract_type=BUY&company=" + lstCompany.GetData();
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object.length > 0 ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//ITEM CODE
            idGridItem.SetGridText(idGridItem.row, 10, object[4]) ;//ITEM NAME
            idGridItem.SetGridText(idGridItem.row, 11, "TIM_CONTR_MST") ;//TABLE NAME 
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
					    if (txt_drcr_type.GetData() == 'D')
					    {
					        ls_ccy = grdDebit.GetGridData(click_dr, 6);
					    }
					    else if (txt_drcr_type.GetData() == 'C')
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

function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise,    
}

function RowEditDR()
{
    var dr_famt = 0;
    var dr_bamt = 0;
    var dr_rate = 0;
    var book_rate = 1;
    
    _book_rate = grdDebit.GetGridData(event.row, 17);
    if (event.col == 6 || event.col == 8 || event.col == 7 || event.col == 17)
    {
        txtcur.text = grdDebit.GetGridData(event.row, 6);
        txt_row.text = event.row;
        //alert(event.col);
        dr_famt = Number(grdDebit.GetGridData(event.row, 8));
        dr_bamt = Number(grdDebit.GetGridData(event.row, 9));
        if(dr_famt != 0.00 || dr_famt != 0)
        {
            grdDebit.SetGridText(event.row, 18, Math.round(Number((dr_bamt/dr_famt))));
        }
        book_rate = GetBookExRate(txtcur.text);
       if(event.col == 6)
       {
            grdDebit.SetGridText(event.row, 7, book_rate);
       }
        dr_rate = Number(grdDebit.GetGridData(event.row, 7));
        //alert('book_rate=' + book_rate + '  ,dr_famt=' + dr_famt + ',dr_bamt=' + dr_bamt);
       
        
        if(_book_col_format.indexOf(".")>0)
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
    OnSumDR();
}
function GetBookExRate(p_ccy){
    lstBookExRate.value = p_ccy;
    var sTemp = lstBookExRate.GetText();
    
    if(sTemp == ""){
        alert("Please input exchange rate for this "+ p_ccy +" currency at date:"+ dtDate.GetData() +".");
        return;
    }
    
    var aTemp = sTemp.split("-");   
    var book_rate =  aTemp[1];
    
    return book_rate;
}
function RowEditCR()
{
    var cr_famt = 0;
    var cr_bamt = 0;
    var cr_rate = 0, book_rate = 1;
    _book_rate = grdCredit.GetGridData(event.row, 17);
    
    if (event.col == 6 || event.col == 8 || event.col == 7 || event.col == 17){
       
        cr_bamt = grdCredit.GetGridData(event.row, 9);
        cr_famt = Number(grdCredit.GetGridData(event.row, 8)); 
        if(cr_famt !=0 || cr_famt!=0.00)
        {      
            grdCredit.SetGridText(event.row, 18, Math.round(Number((cr_bamt/cr_famt))));
        }    
        ///alert(Math.round(Number((cr_bamt/cr_famt)*_book_rate)));
        txtcur.text = grdCredit.GetGridData(event.row, 6);
        txt_row.text = event.row;
        
        book_rate = GetBookExRate(txtcur.text);
        if(event.col == 6){
        grdCredit.SetGridText(event.row, 7, book_rate);}
        cr_rate = Number(grdCredit.GetGridData(event.row, 7));
         
        if(_book_col_format.indexOf(".")>0){
            var book_amt = (Number(cr_famt*(cr_rate/_book_rate)));
            book_amt = System.Round(book_amt,2);
            grdCredit.SetGridText(event.row, 9, book_amt);
        }
        else{
            grdCredit.SetGridText(event.row, 9, Math.round(Number(cr_famt*(cr_rate/_book_rate))));
        }
    }
    OnSumCR();
}
function RowChange(p_data)
{
    txtcur.text     = '';
    txt_row.text    = '';
    if (p_data == 'DR')
    {
        txtcur.text = grdDebit.GetGridData(event.row, 6);
        txt_row.text = event.row;
        //dso_get_rate_dr.Call();
        lstBookExRate.value = txtcur.text;
        lstBookExRate.GetText();
    }
    else if (p_data == 'CR')
    {
        txtcur.text = grdCredit.GetGridData(event.row, 6);
        txt_row.text = event.row;
        //dso_get_rate_cr.Call();
    }
}

function SetCurrent(p_data)
{
    var rate = 0;
    if (p_data == 'DR')
    {
        rate = txtrate.GetData();
        grdDebit.SetGridText(txt_row.text, 7, rate);
        var dr_famt = Number(grdDebit.GetGridData(txt_row.text, 8));
        grdDebit.SetGridText(txt_row.text, 9, Math.round(Number(dr_famt*rate)));
        OnSumDR();
    }
    else if (p_data == 'CR')
    {
        rate = txtrate.GetData();
        grdCredit.SetGridText(txt_row.text, 7, rate);
        var dr_famt = Number(grdCredit.GetGridData(txt_row.text, 8));
        grdCredit.SetGridText(txt_row.text, 9, Math.round(Number(dr_famt*rate)));
        OnSumCR();
    }
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

//---------------------------------------Print Report--------------------------------------------------
function OnReport()
{
	if (txtStatus.text =="")
	{
		alert("Please save voucher!\nCh?ng t? ch?a ???c l?u!");
		return;
	}
	if (txtStatus.text =="3")
	{
		alert("Cannot print cancelled voucher!\nCh?ng t? ?ã b? h?y!");
		return;
	}
	else
	{
	        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=gf/hg/60080010_envn.rpt&procedure=acnt.sp_sel_60080010_envn|sp_sel_60080010_envn1|sp_sel_60080010_envn3|sp_sel_60080010_envn2&parameter="+txtseq.text+"|"+txtseq.text+"|"+lstCompany.value+","+txtseq.text+"|"+txtseq.text;   
		//var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq='+txtseq.text;
//		if(confirm("Are you sure you want to report ?" ))
//		{
			System.OpenTargetPage( url , 'newform' );
			return;
//		}
	}
}
function OnReport2()
{


	if (txtStatus.text =="")
	{
		alert("Please save voucher!\nCh?ng t? ch?a ???c l?u!");
		return;
	}
	if (txtStatus.text =="3")
	{
		alert("Cannot print cancelled voucher!\nCh?ng t? ?ã b? h?y!");
		return;
	}
	else
	{
		var url =System.RootURL + '/reports/gf/hg/gfhg00010.aspx?seq='+txtseq.text  ;
		
			System.OpenTargetPage( url , 'newform' );
			
	}
}
function OnReport1()//Receive voucher
{
	var slip_status = txtStatus.text;
	var url = "";
	
	if(slip_status=="")
	{
		alert("Please save voucher!\nCh?ng t? ch?a ???c l?u!");
		return;
	}
	
	if(slip_status=="3")
	{
		alert("Cannot print cancelled voucher!\nCh?ng t? ?ã b? h?y!");
		return;
	}
	if ((lstVoucherTypePrint.GetText()!="1")&&(lstVoucherTypePrint.GetText()!="2"))
	{
		alert("This voucher is not payment or receipt voucher!\nKhông ph?i ch?ng t? Thu/Chi!");
		return;
	}
	if (lstVoucherTypePrint.GetText()=="2")//Payment voucher - Phieu Chi
	{
		rqt = "?company_pk="+lstCompany.value+'&seq='+txtseq.text+'&pv_pk=';
		url =System.RootURL + '/reports/gf/br/gfbr00030_PaymentVoucher.aspx'+rqt;                   
		if(confirm("Are you sure you want to report ?" ))
		{
			System.OpenTargetPage( url , 'newform' );
			return;
		}
	}
	if (lstVoucherTypePrint.GetText()=="1")//Receipt Voucher- Phieu Thu
	{
		rqt = "?company_pk="+lstCompany.value+'&seq='+txtseq.text+'&pv_pk=';
		url =System.RootURL + '/reports/gf/br/gfbr00030_ReceiptVoucher.aspx'+rqt;                   
		if(confirm("Are you sure you want to report ?" ))
		{
			System.OpenTargetPage( url , 'newform' );
			return;
		}
	}
	
	
}
function OnReport3()
{


	if (txtStatus.text =="")
	{
		alert("Please save voucher!\nCh?ng t? ch?a ???c l?u!");
		return;
	}
	if (txtStatus.text =="3")
	{
		alert("Cannot print cancelled voucher!\nCh?ng t? ?ã b? h?y!");
		return;
	}
	else
	{
	   
	    var dr = grdDebit.rows;
	    var cr = grdCredit.rows
	    var total = dr+cr;
	  
	        if(total > '5')
	        {
	            var url =System.RootURL + '/reports/gf/hg/gfhg00010_pkt.aspx?seq='+txtseq.text + '&comp=' +lstCompany.value ;
		
			    System.OpenTargetPage( url , 'newform' );
	        }
	        else
	        {
	            
			var url =System.RootURL + '/reports/gf/hg/gfhg00010_pkt1.aspx?seq='+txtseq.text + '&comp=' +lstCompany.value ;
		
			System.OpenTargetPage( url , 'newform' );
	        
	    }
		
			
	}
}
function OnChangeVoucher()
{
    if(flag_select==false)
   { 
        lstVoucherTypePrint.value==lstVoucherType.GetData();
    }
}

function CheckKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
function OnUpdateBookRate(){
    dso_get_exrate_list.Call();
}
</script>

<body style="margin: 0; padding: 0;">
    <!------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_sel_trans_debit" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3" function="acnt.SP_SEL_ACCOUNT_DRCR">
                <input bind="grdDebit">
                    <input bind="txttransaction_code"/>
                    <input bind="txttransaction_name"/>
                    <input bind="txt_DRCR"/>
                    <input bind="lstCompany"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdDebit"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_sel_trans_credit" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3" function="acnt.SP_SEL_ACCOUNT_DRCR">
                <input bind="grdCredit">
                    <input bind="txttransaction_code"/>
                    <input bind="txttransaction_name"/>
                    <input bind="txt_DRCR"/>
                    <input bind="lstCompany"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdCredit"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_pro_get_transname" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_TRANS_NAME" > 
                <input> 
                     <input bind="txttransaction_code"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txttransaction_name"/>
                     <output bind="txttrans_pk"/>
                     <output bind="txtDescription"/>
                     <output bind="txtLocalDescription"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_ctl_getProposedBy" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="control" function= "ACNT.SP_GET_PROPOSED_BY_ID_NAME">
                <inout>
                    <inout bind="txtProposedByUserPk" />
                    <inout bind="txtProposedByUserID"/>
                    <inout bind="txtProposedByUserName"/>
                    <inout bind="lstDepartment"/>
                </inout>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_udp_ctl_mst_slip_entry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="ACNT.SP_SEL_CTL_MST_SLIP_ENTRY" procedure="ACNT.SP_UDP_CTL_MST_SLIP_ENTRY">
            <inout> 
                <inout bind="txtseq"/>
                <inout bind="lstCompany"/>
                <inout bind="chkauto_YN"/>
                <inout bind="lstVoucherType"/>
                <inout bind="txtvoucher_auto"/>
                <inout bind="txtvoucher_no"/>
                <inout bind="dtDate"/>
                <inout bind="lstDepartment"/>
                <inout bind="txtProposedByUserPk"/>
                <inout bind="txtProposedByUserID"/>
                <inout bind="txtProposedByUserName"/>
                <inout bind="txttrans_pk"/>
                <inout bind="txttransaction_code"/>
                <inout bind="txttransaction_name"/>
                <inout bind="txtDescription"/>
                <inout bind="txtLocalDescription"/>
                <inout bind="txtStatus"/>
                <inout bind="txtEnclose"/>
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_upd_grd_dtl_slip_entry_dr" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18" function="acnt.SP_SEL_GRD_DTL_SLIP_ENTRY" procedure="acnt.SP_UPD_GRD_DTL_SLIP_ENTRY">
                <input bind="grdDebit" >
                    <input bind="txtseq"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdDebit" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_grd_dtl_slip_entry_cr" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18" function="acnt.SP_SEL_GRD_DTL_SLIP_ENTRY" procedure="acnt.SP_UPD_GRD_DTL_SLIP_ENTRY">
                <input bind="grdCredit">
                    <input bind="txtseq"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdCredit"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_ctl_item" onreceive="ItemStyle()">
        <xml>
            <dso type="grid" parameter="0,1,2,9,10,11,12" function="acnt.SP_SEL_GRD_CTL_ITEM_CALL" procedure="acnt.SP_UPD_GRD_ITEM_CTL_SLIP_ENTRY">
                <input bind="idGridItem">
                    <input bind="txthgtrd"/>
                    <input bind="txtacpk"/>
                    <input bind="txt_drcr_type"/>
                </input> 
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_confirm" onreceive="SetButtonEnable()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CTL_MST_CONFIRM" > 
                <input> 
                     <input bind="txtseq"/>
                     <input bind="lstCompany"/>
                </input>  
                <output>  
                     <output bind="txtStatus"/>
                     <output bind="txtvoucher_auto"/>
                     <output bind="txtvoucher_no"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_upd_confirm_cancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CTL_MST_CONFIRM_CANCEL" > 
                <input> 
                     <input bind="txtseq"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_upd_replicate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_AUTOTR_REGENERATE"> 
                <input> 
                     <input bind="txtseq"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtseq"/>
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_upd_copy" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_AUTOTR_REGENERATE_COPY"> 
                <input> 
                     <input bind="txtseq"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtseq"/>
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_get_exrate_list" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="list" procedure="acnt.sp_sel_tac_abexrates_list"> 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtDate" />
                </input>
                <output>
                     <output bind="lstBookExRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>
                <table width="100%" border="1" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="2">
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="10%">Company</td>
                                                <td width="10%"><gw:list id="lstCompany" value="" styles='width:100%' /></td>
                                                <td width="6%">Voucher No</td>
                                                <td width="2%"><gw:checkbox id="chkauto_YN" value="T" onclick="OnAutoYN()" /></td>
                                                <td width="20%"><gw:list id="lstVoucherType" onchange="OnChangeVoucher()" styles="width:100%" /></td>
                                                <td width="9%"><gw:textbox id="txtvoucher_auto" styles="width:100%" /></td>
                                                <td width="12%"><gw:textbox id="txtvoucher_no" onkeypress="CheckKey()" styles="width:100%" /></td>
                                                <td width="3%">Seq</td>
                                                <td width="10%"><gw:textbox id="txtseq" styles="width:100%" onenterkey="CheckKeySeq()" onkeypress="CheckNumeric()" /></td>
                                                <td width="3%"><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="onSearch()" /></td>
                                                <td width="3%"><gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="onNew()" /></td>
                                                <td width="3%"><gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="onSave()" /></td>
                                                <td width="3%"><gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" onclick="onDelete()" /></td>
                                                <td width="3%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnReport()" /></td>
                                                <td width="3%"><gw:imgbtn id="btnReport1" img="printer" alt="Print RV" onclick="OnReport1()" /></td>
                                                <td width="3%"><gw:imgbtn id="btnReport12" img="printer" alt="Print" onclick="OnReport2()" /></td>
                                                <td width="3%">
                                                    <gw:imgbtn id="btnReport121" img="printer" alt="Phi?u k? toán" onclick="OnReport3()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="10%">
                                                    Trans Date</td>
                                                <td width="10%">
                                                    <gw:datebox id="dtDate" lang="1" onchange="OnUpdateBookRate()" />
                                                </td>
                                                <td width="8%">
                                                    Department</td>
                                                <td width="20%">
                                                    <gw:list id="lstDepartment" styles="width:100%" value="ALL"></gw:list>
                                                </td>
                                                <td width="9%">
                                                    &nbsp;Proposed By</td>
                                                <td width="5%">
                                                    <gw:textbox id="txtProposedByUserID" styles="width:100%" />
                                                </td>
                                                <td width="20%">
                                                    <gw:textbox id="txtProposedByUserName" styles="width:100%" />
                                                </td>
                                                <td width="6%">
                                                    <gw:icon id="btnConfirm" img="in" text="Confirm" onclick="OnConfirm()" styles="width:100%" />
                                                </td>
                                                <td width="6%">
                                                    <gw:icon id="btnCancel" img="in" text="Cancel" onclick="OnConfirmCancel()" styles="width:100%" />
                                                </td>
                                                <td width="6%">
                                                    <gw:icon id="btnReplicate" img="in" text="Replicate" onclick="OnReplicate()" styles="width:100%" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="10%">
                                                    <a onclick="OnTransactionPopUp()" href="#tips" title="Get Transaction">Transaction Type</a></td>
                                                <td width="10%">
                                                    <gw:textbox id="txttransaction_code" styles="width:100%" onkeypress="Upcase()" onenterkey="OnEnterTrans_Code()"
                                                        csstype="mandatory" />
                                                </td>
                                                <td width="28%">
                                                    <gw:textbox id="txttransaction_name" styles="width:100%" />
                                                </td>
                                                <td width="9%">
                                                    &nbsp;Enclose</td>
                                                <td width="25%">
                                                    <gw:textbox id="txtEnclose" styles="width:100%" />
                                                </td>
                                                <td width="5%">
                                                    Book Rate:</td>
                                                <td width="8%">
                                                    <gw:label id="lblBookRate" styles="width:100%"/>
                                                    
                                                </td>
                                                <td width="5%">
                                                    <gw:icon id="btnCopy" img="in" text="Copy" onclick="OnCopy()" styles="width:100%" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="10%">
                                                    Description</td>
                                                <td width="38%">
                                                    <gw:textbox id="txtDescription" styles="width:100%" csstype="mandatory" />
                                                </td>
                                                <td width="9%">
                                                    &nbsp;Local Description</td>
                                                <td width="43%">
                                                    <gw:textbox id="txtLocalDescription" styles="width:100%" csstype="mandatory" />
                                                </td>
                                            </tr>
                                        </table>
                                </tr>
                        </td>
                </table>
            </td>
        </tr>
        <tr>
            <td width="60%" id="tdGrid">
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0">
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
                                                    <gw:imgbtn id="btnNew_Dr" img="new" alt="New" onclick="OnNewDr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_Dr" img="save" alt="Save" onclick="OnSaveDr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Dr" img="delete" alt="Delete" onclick="OnDelDr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:icon id="btnUp_Dr" onclick="OnUpDr()"><img src="../../../system/images/up.gif"/></gw:icon>
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:icon id="btnDown_Dr" onclick="OnDownDr()"><img src="../../../system/images/down.gif"/></gw:icon>
                                                </td>
                                                <td width="3%">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                   <!--0_Pk|1_Acc_pk|2.|3.|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.Amount Book|10.Description
                                    |11.Local Description |12_Expense Type|13_m_pk|14_ODR|15_DRCR|16_ChkTreat|17.Book Rate|18.Actual Rate-->
                                    <td width="100%">
                                        <gw:grid id="grdDebit" 
                                            header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|Tmp Rate"
                                            format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0" 
                                            aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3"
                                            defaults="||||||VND||||||||||||" 
                                            editcol="0|0|1|1|0|0|1|1|1|1|1|1|1|0|0|0|0|1|0" 
                                            widths="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000"
                                            styles="width:100%; height:188" 
                                            sorting="F" 
                                            oncelldblclick="DBPopupClick_DR()" 
                                            oncellclick="RowClick_DR()" 
                                            onafteredit="RowEditDR()"
                                            onselchange="RowClick_DR()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
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
                                                    <gw:imgbtn id="btnNew_Cr" img="New" alt="New credit" onclick="OnNewCr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_Cr" img="save" alt="Save" onclick="OnSaveCr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Cr" img="delete" alt="Delete" onclick="OnDelCr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:icon id="btnUp_Cr" onclick="OnUpCr()"><img src="../../../system/images/up.gif" /></gw:icon>
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:icon id="btnDown_Cr" onclick="OnDownCr()"><img src="../../../system/images/down.gif" /></gw:icon>
                                                </td>
                                                <td width="3%" align="right">
                                                    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
                                                        style="cursor: hand;" onclick="OnToggle()" /></img></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                <!--0_Pk|1_Acc_pk|2.|3.|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.Amount Book|10.Description|11.Local Description
                                |12_Expense Type|13_m_pk|14_ODR|15_DRCR|16_ChkTreat|17.Book Rate|18. tmp rate"
                                -->
                                    <td width="100%">
                                        <gw:grid id="grdCredit" 
                                            header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|Tmp Rate"
                                            format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0" 
                                            aligns="0|0|1|1|0|0|1|1|3|3|0|0|0|0|0|0|0|0|3"
                                            defaults="||||||VND||||||||||||" 
                                            editcol="0|0|1|1|0|0|1|1|1|1|1|1|1|0|0|0|0|1|1" 
                                            widths="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000"
                                            styles="width:100%; height:188" 
                                            sorting="F" 
                                            oncelldblclick="DBPopupClick_CR()" 
                                            oncellclick="RowClick_CR()" 
                                            onafteredit="RowEditCR()"
                                            onselchange="RowClick_CR()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="40%" id="tdControlItem" style="display: none" valign="top">
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="100%">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="25%" align="Center">
                                        Control Item</td>
                                    <td width="50%" align="left">
                                    </td>
                                    <td width="25%" align="right">
                                        <gw:icon id="btnTreament" img="in" text="Treatment" onclick="OnTreament()" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%">
                            <gw:neogrid id="idGridItem" styles="width:100%;height:360" oncelldblclick="ClickItemControl()"
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
    </td> </tr> </table>
    <!------------------------------------------Textbox ?n ----------------------------------------------->
    <gw:list id="lstVoucherTypePrint" style="display: none" />
    <gw:list id="lstBookExRate" styles="width:100%;display:none" />
    <gw:textbox id="txtProposedByUserPk" style="display: none" />
    <gw:textbox id="txtCustomerPk" style="display: none" />
    <gw:textbox id="txt_DRCR" style="display: none" />
    <gw:textbox id="txtStatus" style="display: none" />
    <gw:textbox id="txttrans_pk" style="display: none" />
    <gw:textbox id="txttrans_code_tmp" style="display: none" />
    <gw:textbox id="txtacpk" style="display: none" />
    <gw:textbox id="txt_drcr_type" style="display: none" />
    <gw:textbox id="txt_rowclick" style="display: none" />
    <gw:textbox id="txt_count" style="display: none" />
    <gw:textbox id="txthgtrd" style="display: none" />
    <gw:textbox id="txtcur" style="display: none" />
    <gw:textbox id="txtrate" style="display: none" />
    <gw:textbox id="txt_row" style="display: none" />
    <gw:textbox id="txtLang" style="display: none" />
    <gw:textbox id="txtEACAB018" style="display: none" />
    <gw:textbox id="txtEACAB032" style="display: none" />
    <gw:grid style="display: none" id="idGridTempItem" header="itemacctpk|itemal|item|itemnm|table_pk"
        format="0|0|0|0|0" aligns="0|0|0|0|0" defaults="||||" editcol="0|0|0|0|0" widths="1300|3500|3500|2000|0"
        styles="width:100%; height:100" sorting="F" param="0,1,2,3,4" />
    <!---------------------------------------------------------------------------------------------------->
</body>
</html>
