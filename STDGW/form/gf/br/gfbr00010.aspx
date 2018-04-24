<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">


var click_dr = 0;
var click_cr = 0;
var _Book_CCY;
var _book_rate = 1;
var _book_col_format = "###,###.##R";
var flag_select = false;
var lang = "<%=Session("SESSION_LANG")%>";
var _company_pk = "<%=Session("COMPANY_PK")%>";

var _user_id = "<%=Session("USER_ID")%>";
var _dept_pk = "<%=Session("ORG_PK")%>";
var _user_pk = "<%=Session("USER_PK")%>";
var _user_name = "<%=Session("USER_NAME")%>";
var _employee_pk = "<%=Session("EMPLOYEE_PK")%>";

function BodyInit(){
    System.Translate(document);
    idGridItem.SetHeaderBold(true);
    dso_udp_ctl_mst_pay_pvp.StatusInsert();
    
    txtsum_chk_dr_famt.SetEnable(false);
    txtsum_chk_dr_amt.SetEnable(false);
    txtsum_chk_cr_famt.SetEnable(false);
    txtsum_chk_cr_amt.SetEnable(false);
    lstDepartment.SetEnable(false);
    lstVoucherType.SetEnable(false);
    txsetDRamt2CR.SetDataText("0");
    txtProposedByUserID.SetEnable(false);
    txtProposedByUserName.SetEnable(false);
    btnTreament.SetEnable(false);
    
    txtLang.SetDataText(lang);
    
    btnReplicate.SetEnable(false);
    btnCancel.SetEnable(false);
    btnConfirm.SetEnable(false);
    btnCopy.SetEnable(false);
    
    txtsum_diff_famt.SetEnable(false);
    txtsum_diff_amt.SetEnable(false);
    
    <%=ESysLib.SetGridColumnComboFormat("grdDebit",  6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdCredit", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;

    <%=ESysLib.SetGridColumnComboFormat("grdDebit",  10,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACCR0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdCredit", 10,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACCR0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    
    grdDebit.GetGridControl().FrozenCols = 6;
    grdCredit.GetGridControl().FrozenCols = 6;
    
    _Book_CCY = "<%=ESysLib.SetDataSQL("select b.code, b.char_1  from tac_commcode_master a, tac_commcode_detail b where a.pk = b.tac_commcode_master_pk and a.id = 'ACBG0040' and b.def_yn = 'Y' and a.del_if = 0 and b.del_if = 0")%>";
    var a = _Book_CCY.split("|");
    if(a.length <=0) alert("Please setup book currency in common code.");
    _Book_CCY = a[0];
    SetColumnFormat(a[1]);
    
    var ls_data3    = "<%=ESysLib.SetListDataFUNC("SELECT sf_a_get_default ('EACAB032')   FROM DUAL")%>";
    var arr  = ls_data3.split("|");
	txtEACAB032.SetDataText(arr[1]); 
	
	ls_data3    = "<%=ESysLib.SetListDataFUNC("SELECT sf_a_get_default ('EACAB018')   FROM DUAL")%>";
    var  arr  = ls_data3.split("|");
	txtEACAB018.SetDataText(arr[1]); 
	
    txtseq.GetControl().focus();
    ibtnPopup.SetEnable(false);
    BindingDataList();
    SetUserInfo();

    txtAc_level.text= "<%=session("ACNT_LEVEL")%>";
     txtSesion_company.text = "<%=session("company_pk")%>";
     var _company;
     if(txtAc_level.text=='6')
     {
        _company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>"; 
        lstCompany.SetDataText(_company);
        //cboOrganization.value= 'ALL';
     }
     
    dso_get_exrate_list.Call();
}
function dateChange()
{    
    dso_get_exrate_list.Call();
}
function SetColumnFormat(p_format){
    var fg = grdDebit.GetGridControl();
    fg.ColFormat(7) = "###,###.##R"; 
	fg.ColFormat(8) = "###,###.##R";
	fg.ColFormat(20) = "###,###R";
	
	if(p_format != ""){
	    fg.ColFormat(9) = p_format;
	    _book_col_format = p_format;
	} 
	else{
	    fg.ColFormat(9) = "###,###R"; 
	}
	
	fg=grdCredit.GetGridControl();
    fg.ColFormat(7) = "###,###.##R"; 
	fg.ColFormat(8) = "###,###.##R"; 
	fg.ColFormat(20) = "###,###R";
	if(p_format != ""){
	    fg.ColFormat(9) = p_format; 
	    _book_col_format = p_format;
	} 
	else{
	    fg.ColFormat(9) = "###,###R"; 
	}
}
function OnAutoYN(){
    if (chkauto_YN.GetData() != 'T'){
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
	    txtvoucher_auto.GetControl().focus();
    }
    else{
        txtvoucher_auto.SetEnable(false);
    }
}

function BindingDataList(){
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_data1    = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.org_NM FROM comm.TCO_org A WHERE a.del_if=0")%>";
    var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE('ACBG0130') FROM DUAL")%>";
    var ls_data3    = "<%=ESysLib.SetListDataSQL("SELECT NVL(NUM_3, '0'), CODE FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE D.TAC_COMMCODE_MASTER_PK = M.PK AND D.DEL_IF = 0 AND M.DEL_IF = 0 AND M.ID = 'ACBG0130'")%>";
    
    var ls_data4    = "<%=ESysLib.SetDataSQL("SELECT CODE FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACBG0130' AND B.CHAR_3 = 'RV' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    var ls_data5    = "<%=ESysLib.SetDataSQL("SELECT NUM_2 FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACBG0130' AND B.CHAR_3 = 'RV' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";

    var ls_data6    = "<%=ESysLib.SetDataSQL("SELECT NVL(NUM_3, '0') FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACBG0130' AND B.CHAR_3 = 'RV' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    var ls_data7    = "<%=ESysLib.SetDataSQL("SELECT DECODE(B.CODE, 'Y', 'T', 'F') FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB004' AND B.DEF_YN = 'Y' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    
    lstCompany.SetDataText(ls_data);
    lstCompany.SetDataText(_company_pk);
    lstDepartment.SetDataText(ls_data1);
    lstVoucherType.SetDataText(ls_data2);
	lstVoucherTypePrint.SetDataText(ls_data3);
	lstVoucherType.SetDataText(ls_data4);
    lstVoucherTypePrint.SetDataText(ls_data6);
    
    chkauto_YN.SetDataText(ls_data7);
    if (ls_data7 == 'T'){
        txtvoucher_auto.SetEnable(false);
        txtvoucher_auto.SetDataText('');
    }
    else{
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
    }
    txttax_acc.SetDataText(ls_data5);
}

function onCustPopUp(){
    if(!CanChange()) return;
    
    var path = System.RootURL + '/form/gf/co/ffbp00031.aspx?Company_Pk=' + lstCompany.value;
    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
	if ( object != null ){
		if (object[0] != 0){
            txtcustpk.text = object[0];//pk
            txtcustid.text = object[1];//cust id
            txtcustnm.text = object[2];//cust name
        }
    }
}

function onCustReset(){
    txtcustpk.text = "";
    txtcustid.text = "";
    txtcustnm.text = "";
}

function OnToggle(){
    var left  = document.all("tdGrid");
    var right = document.all("tdControlItem");
    var imgArrow = document.all("imgArrow");
    
    if(imgArrow.status == "collapse"){
        right.style.display="none";       
        imgArrow.status = "expand";
        left.style.width="100%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
    else{
        right.style.display="";
        imgArrow.status = "collapse";
        left.style.width="60%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
}

function OnCtrToggleLeft(){
    var left  = document.all("tdGrid");
    var right = document.all("tdControlItem");
    var imgArrow = document.all("imgArrow");
    
    right.style.display="";
    imgArrow.status = "collapse";
    left.style.width="60%";
    imgArrow.src = "../../../system/images/next_orange.gif";
}

function OnCtrToggleRight(){
    var left  = document.all("tdGrid");
    var right = document.all("tdControlItem");
    var imgArrow = document.all("imgArrow");
    
    if(imgArrow.status == "collapse"){
        right.style.display="none";       
        imgArrow.status = "expand";
        left.style.width="100%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

//------------------------------------- Master event ----------------------------------------------------
 
function onSearch(){
    var path    = System.RootURL + '/form/gf/br/gfbr00030_search.aspx?com_pk='+ lstCompany.GetData() + '&dsql=ACNT.SP_SEL_GRD_PAYMENT_SEARCH' + '&VoucherType=' + lstVoucherType.GetData();
    var object  = System.OpenModal( path ,950 , 600, 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no');
    if ( object != null ){
        if (object[0] != 0){
            txtseq.text     = object[1];
            txtseq1.text    = object[0];
            CheckKeySeq();
        }
    }
}

function Reset_Master(){
    txtseq.text             = "";
    txtvoucher_no.text      = "";
    txtvoucher_auto.text    = "";
    txtpay_person.text      = "";
    txtcustpk.text          = "";
    txtcustid.text          = "";
    txtcustnm.text          = "";
    txtEnclose.text         = "";
    txtDescription.text     = "";
    txtLocalDescription.text= "";
	txsetDRamt2CR.SetDataText("0");
}
 
function onNew()
{
    if (dso_udp_ctl_mst_pay_pvp.GetStatus() != 20)
    {
        dso_udp_ctl_mst_pay_pvp.StatusInsert();
    }
    Reset_Master();
    
    grdDebit.ClearData();
    grdCredit.ClearData();
    idGridItem.SetData("");
    txtStatus.SetDataText("");
    SetButtonEnable();
    SetButtonCtl(true);
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
    
    // Auto Y/N
    var ls_data7    = "<%=ESysLib.SetDataSQL("SELECT DECODE(B.CODE, 'Y', 'T', 'F') FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB004' AND B.DEF_YN = 'Y' AND A.DEL_IF = 0 AND B.DEL_IF = 0")%>";
    chkauto_YN.SetDataText(ls_data7);
    if (ls_data7 == 'T'){
        txtvoucher_auto.SetEnable(false);
        txtvoucher_auto.SetDataText('');
    }
    else{
        txtvoucher_auto.SetEnable(true);
        txtvoucher_auto.SetDataText('');
    }
    SetUserInfo();
}

function CheckKeySeq()
{
        txtDescription.SetDataText("");
        txtLocalDescription.SetDataText("");
        grdDebit.ClearData();
        grdCredit.ClearData();
        idGridItem.SetData("");
        
        txtsum_chk_dr_famt.text = 0;
        txtsum_chk_dr_amt.text = 0;
        txtsum_chk_cr_famt.text = 0;
        txtsum_chk_cr_amt.text = 0;
        txtsum_total_dr_famt.text = 0;
        txtsum_total_dr_amt.text = 0;
        txtsum_total_cr_famt.text = 0;
        txtsum_total_cr_amt.text = 0;
        txtsum_diff_famt.text = 0;
        txtsum_diff_amt.text = 0;
        
        flag_select = true;
        click_dr = 0;
        click_cr = 0;
        OnCtrToggleRight();
        
        if (txtseq.GetData() != '')
        {
            dso_sel_ctl_mst_pay_pvp.Call('SELECT');
        }
        else
        {
            dso_udp_ctl_mst_pay_pvp.Call('SELECT');
        }
}


function onDelete()
{
    if (txtStatus.GetData() == '')// Save
    {
        return;
    }
    if(!CanChange()) return;
    
    var path = System.RootURL + '/form/gf/hg/gfhg00010_causecancel.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq1.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData() + '&dsqlid=ACNT.SP_PRO_CONFIRM_CANCEL_PAYMENT' + '&table=TAC_BPRVPV';
    var object = System.OpenModal( path,  400 , 400,'resizable:yes;status:yes');
    if ( object != null )
    {
        if (object[0] !=0)
        {
            txtseq1.text = object[0];
            CheckKeySeq();
        }
    }
}
 
function onSave()
{
    if (Check_Master_Ctl())
    {
        dso_udp_ctl_mst_pay_pvp.Call();
    }
}
 
function Check_Master_Ctl()
{
    if(!CanChange()) return false;
    
    if (txtProposedByUserPk.text == '')
    {
        alert(''+'\n'+'Bạn đã hết phiên giao dịch. Hãy đăng nhập lại, cảm ơn!!!');
        return false;
    }
    if (txtDescription.GetData() == '')
    {
        alert('   Description is not null. Please check again!!!'+'\n'+'Diễn giải không được rỗng. Bạn hãy kiểm tra lại!!!');
        return false;
    }
    if (txtLocalDescription.GetData() == '')
    {
        alert('Local description is not null. Please check again'+'\n'+'Diễn giải không được rỗng. Bạn hãy kiểm tra lại!!!');
        return false;
    }
    return true;
}
 
function Popup_OnNew(p_payrec, p_drcr)
{
    var i = 0;
    var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + '' + "&val1=" + p_payrec + "&val2=" + p_drcr + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACC_DRCR_PAYREC";
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
                    if (p_drcr == 'D')
                    {
                        grdDebit.AddRow();
                        grdDebit.SetGridText( grdDebit.rows - 1, 19, 'D' );
					    grdDebit.SetGridText( grdDebit.rows - 1,  3, '1' );
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
					        grdDebit.SetGridText( grdDebit.rows - 1, 3, '1');
					    }
					    grdDebit.SetGridText( grdDebit.rows - 1, 10, "01" );                        //Desc Eng
					    grdDebit.SetGridText( grdDebit.rows - 1, 15, txtDescription.text );         //Desc Eng
					    grdDebit.SetGridText( grdDebit.rows - 1, 16, txtLocalDescription.text );    //Desc Local
					    grdDebit.SetGridText( grdDebit.rows - 1, 17, txtseq1.text );                 //SEQ
					    book_rate_sys =GetBookExRate(_Book_CCY);					    					    
                        grdDebit.SetGridText( grdDebit.rows - 1, 20, book_rate_sys);
					    //grdDebit.SetRowEditable(grdDebit.rows - 1, false);
                    }
                    else if (p_drcr == 'C')
                    {
                        grdCredit.DeselectRow(grdCredit.selrow);
	                    grdCredit.AddRow();
                        grdCredit.SelectRow(grdCredit.rows - 1);
                        grdCredit.SetGridText( grdCredit.rows - 1, 19, 'C' );
					    grdCredit.SetGridText( grdCredit.rows - 1, 1, tmp[1]);  //ACPK
					    grdCredit.SetGridText( grdCredit.rows - 1, 4, tmp[4]);  //Account Code
					    grdCredit.SetGridText( grdCredit.rows - 1, 5, tmp[5]);  //Account Name
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
                        grdCredit.SetGridText( grdCredit.rows - 1, 10, "01" );                          //Desc Eng
					    grdCredit.SetGridText( grdCredit.rows - 1, 15, txtDescription.text );           //Desc Eng
					    grdCredit.SetGridText( grdCredit.rows - 1, 16, txtLocalDescription.text );      //Desc Local
					    grdCredit.SetGridText( grdCredit.rows - 1, 17, txtseq1.text);                    //SEQ Local					   				  
                        grdCredit.SetGridText(grdCredit.rows-1, 20, GetBookExRate(_Book_CCY));
					    //grdCredit.SetRowEditable(grdCredit.rows - 1, false);
						OnSumDR();
						//alert(grdCredit.rows-1);
						if(txsetDRamt2CR.GetData()=="0")
						{
							//alert(txtsum_total_dr_famt.GetData());
							//alert(txtsum_total_dr_famt.GetData());
							grdCredit.SetGridText( 1, 8, txtsum_total_dr_famt.GetData());     //7.Amount Trans
							grdCredit.SetGridText( 1, 9, txtsum_total_dr_amt.GetData());     //8.Amount Book
						}
						txsetDRamt2CR.SetDataText("2");

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
            grdCredit.SetCellBold(i,1,i,19,true);
            grdCredit.SetRowEditable(i, true);
        }
        else
        {
            grdCredit.SetCellBold(i,1,i,19,false);
            grdCredit.SetRowEditable(i, false);
        }
    }
}
    
function OnNewCr()
{
    if (txtseq1.GetData() != '')
    {
        OnCtrToggleRight();
        Popup_OnNew('', 'C');
    }
    else
    {
        alert('master not null'+'\n'+'');
        return;
    }
}

function OnNewDr()
{
    if (txtseq1.GetData() != '')
    {
        OnCtrToggleRight();
        Popup_OnNew('RECEIPT','D');
    }
    else
    {
        alert('master not null'+'\n'+'');
        return;
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
	                grdDebit.SetCellBold(i,1,i,19,true);
	                grdDebit.SetRowEditable(i, true);
                }
                else
                {
	                grdDebit.SetCellBold(i,1,i,19,false);
	                grdDebit.SetRowEditable(i, false);
                }
            }
            txtacpk.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 1));
            txtbprvpvd.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 0));
            var dr_ratevat  = grdDebit.GetGridData(grdDebit.selrow, 10);
            if (dr_ratevat != 'NO')
            {
                if (dr_ratevat != 1)
                {
                    txt_rate.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 10));
                }
                else
                {
                    txt_rate.SetDataText('');
                }
            }
            else
            {
                txt_rate.SetDataText('');
            }
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
	                grdCredit.SetCellBold(i,1,i,19,true);
	                grdCredit.SetRowEditable(i, true);
                }
                else
                {
	                grdCredit.SetCellBold(i,1,i,19,false);
	                grdCredit.SetRowEditable(i, false);
                }
            }
            txtacpk.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 1));
            txtbprvpvd.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 0));
            var cr_ratevat  = grdCredit.GetGridData(grdCredit.selrow, 10);
            if (cr_ratevat != 'NO')
            {
                if (cr_ratevat != 1)
                {
                    txt_rate.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 10));
                }
                else
                {
                    txt_rate.SetDataText('');
                }
            }
            else
            {
                txt_rate.SetDataText('');
            }
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
	    Popup_OnSelect_Acc('','D');
    }
}

function DBPopupClick_CR()
{
    if (event.col == 4)
	{
	    Popup_OnSelect_Acc('PAYMENT','C');
    }
}

function Popup_OnSelect_Acc(p_payrec, p_drcr)
{
    if(!CanChange()) return;
    
    var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + '' + "&val1=" + p_payrec + "&val2=" + p_drcr + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACC_DRCR_PAYREC";    
    aValue      = System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	
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
                    if ((p_drcr == 'D') && (txtStatus.GetData() == 1 || txtStatus.GetData() == ''))  
                    {
                        grdDebit.SetGridText( grdDebit.selrow, 19, 'D' );
					    grdDebit.SetGridText( grdDebit.selrow,  3, '1' );
					    grdDebit.SetGridText( grdDebit.selrow, 1, tmp[1]);
					    grdDebit.SetGridText( grdDebit.selrow, 4, tmp[4]);
					    grdDebit.SetGridText( grdDebit.selrow, 5, tmp[5]);
					    click_dr = 0;
                        click_cr = 0;
					    RowClick_DR();
                    }
                    else if ((p_drcr == 'C') && (txtStatus.GetData() == 1 || txtStatus.GetData() == ''))
                    {
                        grdCredit.SetGridText( grdCredit.selrow, 19, 'C' );
					    grdCredit.SetGridText( grdCredit.selrow, 1, tmp[1]);
					    grdCredit.SetGridText( grdCredit.selrow, 4, tmp[4]);
					    grdCredit.SetGridText( grdCredit.selrow, 5, tmp[5]);
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
                        click_dr = 0;
                        click_cr = 0;
					    RowClick_CR();
                    }
                }
            }
        }
    }
}

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_get_exrate_list":
            _book_rate = GetBookExRate(_Book_CCY);
            lblBookRate.text = _book_rate;
            if(txtAc_level.text=='3')
             {
                datCompany.Call();
             }
        break;
        case "dso_sel_ctl_mst_pay_pvp":
        case "dso_udp_ctl_mst_pay_pvp":
            SetButtonEnable();
            if (flag_select == true){
                txt_drcr_type.SetDataText('D');
                dso_upd_grd_dtl_payment_dr.Call("SELECT");
            }
        break;
        
        case "dso_upd_grd_dtl_payment_dr":
            OnCloseData();
            if (flag_select == true){
                txt_drcr_type.SetDataText('C');
                dso_upd_grd_dtl_payment_cr.Call("SELECT");
            }
            else{
                click_dr = 0;
                click_cr = 0;
                SaveItemControl();
            }
            for (i=1;i<=grdDebit.rows-1;i++)
            {               
                grdDebit.SetCellBgColor(i,20,i,20,Number(0XCDFAFF));
            }              
        break;
        
        case "dso_upd_grd_dtl_payment_cr":
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
                grdCredit.SetCellBgColor(i,20,i,20,0XCDFAFF);
            }  
        break;
        
        case "dso_upd_confirm":
            SetButtonEnable();
            CheckKeySeq();
        break;
        case "dso_upd_replicate":
	        txtseq.text = "";	
            SetButtonEnable();
            CheckKeySeq();
        break;
        case "dso_upd_copy":
            txtseq.text = ""; 		
            SetButtonEnable();
            CheckKeySeq();
        break;
       
    }
}
function CanChange(){
    switch(txtStatus.GetData()){
        case "0":alert("This voucher was approved. So you can not change !.\n Số phiếu này đã được approve. Bạn không thể thay đổi !");
               return false;
        break;
        case "1": return true;
        case "2":alert("This voucher was confirmed. So you can not change !.\n Số phiếu này đã được xác nhận. Bạn không thể thay đổi !");
                 return false;
        break;
        case "3": return true;
        break;
        case "4": alert("This voucher was approved. So you can not change !.\n Số phiếu này đã được approve. Bạn không thể thay đổi !");
               return false;
        break;
    }
    return true;
}
function SetButtonEnable()
{
    if (txtStatus.GetData() == 1) // Save
    {
        btnConfirm.SetEnable(true);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        ibtnPopup.SetEnable(false);
        SetButtonCtl(true);
    }
    else if (txtStatus.GetData() == 2) // Comfirm
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(true);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        ibtnPopup.SetEnable(true);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == 3) // Cancel
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(true);
        btnCopy.SetEnable(false);
        ibtnPopup.SetEnable(true);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == '') // New
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        ibtnPopup.SetEnable(false);
        btnCopy.SetEnable(false);
        SetButtonCtl(true);
    }
    else if (txtStatus.GetData() == 0) // Approve
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(true);
        ibtnPopup.SetEnable(true);
        SetButtonCtl(false);
    }
    else if (txtStatus.GetData() == 4) // No Approve
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(false);
        btnReplicate.SetEnable(false);
        btnCopy.SetEnable(false);
        ibtnPopup.SetEnable(true);
        SetButtonCtl(false);
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

function ItemStyle()
{
	if (idGridItem.rows > 1)
	{
	    OnCtrToggleLeft();
	}
	else
	{
	    OnCtrToggleRight();
	}
	var ctrl = idGridItem.GetGridControl();
	var j = 1;
	var i = ctrl.rows - 1;
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
	for (i = 1; i < idGridItem.rows; i++)
    {
        if (idGridItem.GetGridData(i, 8) == 'CUSTOMER')
        {
            if (txtcustpk.GetData() != '')
            {
                if (idGridItem.GetGridData(i, 10) == '')
                {
                    idGridItem.SetGridText(i, 12, txtcustpk.GetData());//Customer pk
                    idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");
                    idGridItem.SetGridText(i,  10, txtcustnm.GetData());
                    idGridItem.SetGridText(i,  9, txtcustid.GetData());
                }
            }
        }
	}
	SetDetailCtlItem();	
}

function OnSaveDr()
{
    if(!CheckDataIsValid()) return;
    
    SetItemToGridTmp();
    
    if ((txt_drcr_type.GetData() == 'D') && (grdDebit.rows > 1))
    {
        for (i = 1; i < grdDebit.rows; i++)
        {
            if ((grdDebit.GetGridData(i, 17) == "") && (grdDebit.GetGridData(i, 8) != ''))
            {
                grdDebit.SetGridText(i, 17, txtseq1.GetData());
                grdDebit.SetRowStatus(i, 0x20);
            }            
            if ((grdDebit.GetGridData(i, 8) == '') && (grdDebit.GetGridData(i, 9) == ''))
            {
                grdDebit.SetGridText(i, 17, txtseq1.GetData());
                grdDebit.SetGridText(i, 8, 0);
                grdDebit.SetGridText(i, 9, 0);
            }
            grdDebit.SetGridText(i, 19, 'D');
            if (grdDebit.GetGridData(i, 15) == "")
            {
                grdDebit.SetGridText(i, 15, txtDescription.GetData());
            }
            if (grdDebit.GetGridData(i, 16) == "")
            {
                grdDebit.SetGridText(i, 16, txtLocalDescription.GetData());
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
                grdDebit.SetGridText(i, 18, i - j);
            }
        }
        txt_rowclick.text = grdDebit.selrow;
        dso_upd_grd_dtl_payment_dr.Call();
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
            if ((grdCredit.GetGridData(i, 17) == "") && (grdCredit.GetGridData(i, 8) != ''))
            {
                grdCredit.SetGridText(i, 17, txtseq1.GetData());
                grdCredit.SetRowStatus(i, 0x20);
            }
            if ((grdCredit.GetGridData(i, 8) == '') && (grdCredit.GetGridData(i, 9) == ''))
            {
                grdCredit.SetGridText(i, 17, txtseq1.GetData());
                grdCredit.SetGridText(i, 8, 0);
                grdCredit.SetGridText(i, 9, 0);
            }
            grdCredit.SetGridText(i, 19, 'C');
            if (grdCredit.GetGridData(i, 15) == "")
            {
                grdCredit.SetGridText(i, 15, txtDescription.GetData());
            }
            if (grdCredit.GetGridData(i, 16) == "")
            {
                grdCredit.SetGridText(i, 16, txtLocalDescription.GetData());
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
                grdCredit.SetGridText(i, 18, i - j);
            }
        }
        txt_rowclick.text = grdCredit.selrow;
        dso_upd_grd_dtl_payment_cr.Call();
    }
}
function CheckDataIsValid(){
    if (txtseq1.GetData() == ''){
        alert('  Save Master and then Treament'+'\n'+'Bạn lưu lại trước sau đó Treament');
        return false;
    }
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
		if(man == "Y" & item == ""){
			alert('           '+ itemtitle + ' is mandatory. Please input!!!'+'\n'+ itemtitle +' thông tin bắt buộc nhập. Vui lòng nhập vào!!!');
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

function OnCloseData()
{
    for (i = 1; i < grdDebit.rows; i++)
    {
        grdDebit.SetGridText( i, 18, i);
        grdDebit.SetRowEditable(i, false);
    }
    for (i = 1; i < grdCredit.rows; i++)
    {
        grdCredit.SetGridText( i, 18, i);
        grdCredit.SetRowEditable(i, false);
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
                if ((idGridItem.GetGridData(i, 0) == '')) // && (idGridItem.GetGridData(i, 9) !='' )
                {
                    idGridItem.SetGridText(i, 1, grdDebit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                else
                {
                    idGridItem.SetGridText(i, 1, grdDebit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x10);
                }
                txtacpk.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 1));
                txtbprvpvd.SetDataText(grdDebit.GetGridData(txt_rowclick.text, 0));
            }
            else if (txt_drcr_type.GetData() == 'C')
            {
                if ((idGridItem.GetGridData(i, 0) == '')) //&& (idGridItem.GetGridData(i, 9) !='' ) (idGridItem.GetGridData(i, 0) == '')
                {
                    idGridItem.SetGridText(i, 1, grdCredit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x20);
                }
                else
                {
                    idGridItem.SetGridText(i, 1, grdCredit.GetGridData(txt_rowclick.text, 0));
                    idGridItem.SetRowStatus(i, 0x10);
                }
                txtacpk.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 1));
                txtbprvpvd.SetDataText(grdCredit.GetGridData(txt_rowclick.text, 0));
            }
	    }
	    dso_upd_ctl_item.Call("");
    }
}

function SetDetailCtlItem()
{
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
		            /*if ((itemal == itemal2) && (item == ''))
		            {
		                idGridItem.SetGridText( i ,  9, item2);
				        idGridItem.SetGridText( i , 10, itemnm2);
				        idGridItem.SetGridText( i , 12, itempk2);
		            }*/
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

function SetNumGridDR()
{
    var fg=grdDebit.GetGridControl();
    fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(9) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(12) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(14) = "#,###,###,###,###,###,###,###,###R"; 
}

function SetNumGridCR()
{
    var fg=grdCredit.GetGridControl();
    fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(9) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(12) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R"; 
	fg.ColFormat(14) = "#,###,###,###,###,###,###,###,###R"; 
}

function OnDelDr()
{
    var ctrl = grdDebit.GetGridControl();
    if (grdDebit.rows > 1)
    {
        var j = 0;
        var i = 1;
        if (confirm('Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa Code này?'))
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
            dso_upd_grd_dtl_payment_dr.Call();
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
        if (confirm('Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa Code này?'))
        {
            for ( i=1; i < ctrl.rows; i++ )
		    {
		        if (ctrl.isSelected(i) == true)
		        {
                    grdCredit.DeleteRow();
                    idGridItem.SetData("");
                    OnCtrToggleRight();
                }
            }
            dso_upd_grd_dtl_payment_cr.Call();
        }
    }
}

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
            alert('    You must one row to move!!!'+'\n'+'Bạn chỉ chọn 1 dòng để di chuyển!!!')
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
		alert('   Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển!!!');
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
            alert('    You must one row to move!!!'+'\n'+'Bạn chỉ chọn 1 dòng để di chuyển!!!')
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
		alert('   Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển!!!');
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
            alert('    You must one row to move!!!'+'\n'+'Bạn chỉ chọn 1 dòng để di chuyển!!!')
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
		alert('  Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển!!!');
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
            alert('    You must one row to move!!!'+'\n'+'Bạn chỉ chọn 1 dòng để di chuyển!!!')
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
		alert('Please select one row to move!!!'+'\n'+'Bạn hãy chọn 1 dòng để di chuyển!!!');
		return;
	}
}

function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}

function OnConfirm()
{
    dso_upd_confirm.Call();
}

function OnReplicate()
{
    dso_upd_replicate.Call();
}

function ClickItemControl()
{    
	var flg = "0";
	var ctrl = idGridItem.GetGridControl();
	if (idGridItem.GetGridData( ctrl.row, 2) == '-1')
	{
		flg = "2";
		var path = System.RootURL + '/form/gf/co/ffbp00031.aspx?Company_Pk=' + lstCompany.GetData();
		var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		if ( object != null )
		{
		    if (object[0] != 0)
            {
		        idGridItem.SetGridText(ctrl.row, 12, object[0]);//table pk
		        idGridItem.SetGridText(ctrl.row,  9, object[1]);//item code
		        idGridItem.SetGridText(ctrl.row,  10, object[2]);//item name(customer name)
		        idGridItem.SetGridText(ctrl.row,  11, "TCO_BUSPARTNER") ;//TABLE NAME
		        for (i = 1; i < idGridItem.rows; i++)
		        {
		            if (idGridItem.GetGridData(i, 8) == 'CUSTOMER NAME')
		            {
		                idGridItem.SetGridText(i,  12, object[0]);//table pk
		                idGridItem.SetGridText(i,  9, object[1]);//item code
		                idGridItem.SetGridText(i, 10, object[2]);//item name(customer name)
		            }
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
                idGridItem.SetGridText(ctrl.row,  9, object[1]) ;//item code
				idGridItem.SetGridText(ctrl.row, 10, object[3]) ;//item name(center name)
                idGridItem.SetGridText(ctrl.row,  11, "TAC_ABPLCENTER") ;//TABLE NAME
                idGridItem.SetGridText(ctrl.row,  12, object[2]) ;//table pk
            }
        } 
	}
	else if (idGridItem.GetGridData( ctrl.row, 2) == '-3')
	{
	    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BUDGET_POPUP&col_code=' + "BUDGET CODE" + '&col_nm=' + "BUDGET NAME&val1="  + txtacpk.GetData() ;
        var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
        if ( object != null )  
        {
            if (object[0] != 0)
            {
                idGridItem.SetGridText(ctrl.row,  9, object[1]) ;//pl name
                idGridItem.SetGridText(ctrl.row, 10, object[3]) ;//cost center name
                idGridItem.SetGridText(ctrl.row,  11, "TAC_ABBUDGET") ;//
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
                if (idGridItem.GetGridData(i, 8) == 'TAX CODE'){
                    idGridItem.SetGridText(i,  9, object[9]);
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
            }
        } 
	}
	else if(idGridItem.GetGridData( idGridItem.row, 8) == 'BENEFICIARY BANK'){ //BENEFICIARY BANK
	    var fpath   = System.RootURL + "/form/gf/co/gfco002009.aspx?contract_type=BUY&company=" + lstCompany.GetData();
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object.length > 0 ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//BANK ID
            idGridItem.SetGridText(idGridItem.row, 10, object[0]) ;//BANK NAME(PARTNER NAME)
            idGridItem.SetGridText(idGridItem.row, 11, "TAC_BFBENEFICIARY") ;//TABLE NAME 
            idGridItem.SetGridText(idGridItem.row, 12, object[2]) ;//TABLE PK 
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
                if ( object != null )  
                {
                    if (object[0] != 0)
                    {
                        idGridItem.SetGridText(ctrl.row,  9, object[0]) ;//ITEM CODE
                        idGridItem.SetGridText(ctrl.row, 10, object[1]) ;//ITEM NAME
                        idGridItem.SetGridText(ctrl.row, 11, "TAC_ABITEMCODE") ;//TABLE NAME 
                        idGridItem.SetGridText(ctrl.row, 12, object[2]) ;//TABLE PK 
                        
                    }
                } 
			}
			else
			{
				if (idGridItem.GetGridData(ctrl.row, 4) != '')
				{
					//var path = System.RootURL + '/form/acnt/fc/wafc001000.asp?dsqlid=' + idGridItem.GetGridData( ctrl.row, 4)  + '&title=' + 'Item Code List' + '&col_code=' + 'Item Code'  + '&col_nm=' + 'Item Name';
					//o = System.OpenModal( path ,500 , 500 , 'resizable:yes;status:yes');
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
					/*else if(idGridItem.GetGridData( ctrl.row, 8 )=="BENEFICIARY BANK")
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
					}*/
					/*-------------------------------------------------------------------------------*/
					else
					{
						
						if (idGridItem.GetGridData( ctrl.row, 8 )== "EMPLOYEE NAME")
						{
							//var fpath   = System.RootURL + "/form/gf/co/ffco002003.aspx"; Original
							var fpath   = System.RootURL + "/form/gf/ma/gfma00010_3.aspx";
                            var object  = System.OpenModal(  fpath , 900 , 600 , 'resizable:yes;status:yes'); 
                            if ( object != null )  
                            {
                                if (object[0] != 0)
                                {
                                    idGridItem.SetGridText(ctrl.row, 9, object[1]) ; //Employee ID
                                    idGridItem.SetGridText(ctrl.row,  10, object[2]) ; //Employee Name    
                                    idGridItem.SetGridText(ctrl.row, 11, "TAC_EMPLOYEE_ADV") ; //TABLE NAME THR_EMPLOYEE Original
                                    idGridItem.SetGridText(ctrl.row, 12, object[0]) ; //TABLE PK
                                }
                            }
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT" || idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT NAME" )
						{
							flg = "-3";
//							var path = System.RootURL + '/form/acnt/fc/wafc001000.asp?dsql=' + escape(sqlsen) + '&dsqlid=' + 'dsql_slipitemcodesql' + '&title=' + 'Item Code List' + '&col_code=' + 'Item Code'  + '&col_nm=' + 'Item Name';
//							o = System.OpenModal( path ,700 , 500 , 'resizable:yes;status:yes');
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "CONTRACT NO")
						{
							flg = "-4";
//							var path = System.RootURL + '/form/acnt/fc/wafc019000_subcontract.asp?dsql=' + escape(sqlsen) + '&dsqlid=' + 'dsql_slipitemcodesql' + '&title=' + 'Item Code List' + '&col_code=' + 'Item Code'  + '&col_nm=' + 'Item Name';
//							o = System.OpenModal( path ,750 , 550 , 'resizable:yes;status:yes');
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
	     sum_cr_famt = sum_cr_famt + Number(grdCredit.GetGridData(i, 8)) + Number(grdCredit.GetGridData(i, 13));
	     sum_cr_amt  = sum_cr_amt  + Number(grdCredit.GetGridData(i, 9)) + Number(grdCredit.GetGridData(i, 14));
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
	     sum_dr_famt = Number(sum_dr_famt) + Number(grdDebit.GetGridData(i, 8))+ Number(grdDebit.GetGridData(i, 13));
	     sum_dr_amt  = Number(sum_dr_amt)  + Number(grdDebit.GetGridData(i, 9))+ Number(grdDebit.GetGridData(i, 14));
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
			sum_dr_famt = Number(sum_dr_famt) + Number(grdDebit.GetGridData(i, 8)) + Number(grdDebit.GetGridData(i, 13));
			sum_dr_amt  = Number(sum_dr_amt)  + Number(grdDebit.GetGridData(i, 9)) + Number(grdDebit.GetGridData(i, 14));
		}
	}
	txtsum_chk_dr_famt.SetDataText(''   + sum_dr_famt);
	txtsum_chk_dr_amt.SetDataText(''    + sum_dr_amt);
	OnSumDR();
	OnSumCR();
	txtsum_diff_famt.SetDataText('' + (Number(txtsum_total_dr_famt.text)-Number(txtsum_total_cr_famt.text)));
	txtsum_diff_amt.SetDataText('' + (Number(txtsum_total_dr_amt.text)-Number(txtsum_total_cr_amt.text)));
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
			sum_cr_famt = Number(sum_cr_famt) + Number(grdCredit.GetGridData(i, 8)) + Number(grdCredit.GetGridData(i, 13));
			sum_cr_amt  = Number(sum_cr_amt)  + Number(grdCredit.GetGridData(i, 9)) + Number(grdCredit.GetGridData(i, 14));
		}
	}
	txtsum_chk_cr_famt.SetDataText('' + sum_cr_famt);
	txtsum_chk_cr_amt.SetDataText(''  + sum_cr_amt);
	OnSumDR();
	OnSumCR();
	txtsum_diff_famt.SetDataText('' + (Number(txtsum_total_dr_famt.text)-Number(txtsum_total_cr_famt.text)));
	txtsum_diff_amt.SetDataText('' + (Number(txtsum_total_dr_amt.text)-Number(txtsum_total_cr_amt.text)));
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise,    
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

function RowEditDR(){
    var dr_famt = 0;
    var dr_rate = 0;
    var book_rate = 0;
    _book_rate = grdDebit.GetGridData(event.row, 20);
    if (event.col == 6 ||  event.col == 7 || event.col == 8 || event.col == 10 || event.col == 20){
        txtcur.text = grdDebit.GetGridData(event.row, 6);
        dr_famt = Number(grdDebit.GetGridData(event.row, 8));
        
        book_rate = GetBookExRate(txtcur.text);
        if(event.col == 6)
        {
         grdDebit.SetGridText(event.row, 7, book_rate);
        }  
        dr_rate = Number(grdDebit.GetGridData(event.row, 7));
         
        if(_book_col_format.indexOf(".")>0){
            var book_amt = Number(dr_famt*(dr_rate/_book_rate));
            book_amt = System.Round(book_amt,2);
            grdDebit.SetGridText(event.row, 9, book_amt);
        }
        else{
            grdDebit.SetGridText(event.row, 9, Math.round(Number(dr_famt*(dr_rate/_book_rate))));
        }
        
        dr_famt     = Number(grdDebit.GetGridData(event.row, 8));
        dr_amt      = Number(grdDebit.GetGridData(event.row, 9));
        
        dr_ratevat  = grdDebit.GetGridData(event.row, 10);
        
        dr_vatfamt  = 0;
        dr_vatamt   = 0;
        if (dr_ratevat != 'NO' && dr_ratevat != '01'){
            if(_book_col_format.indexOf(".")>0){
                dr_vatfamt  = System.Round((Number(dr_famt*dr_ratevat/100)*100)/100,2);
                dr_vatamt   = System.Round((Number(dr_amt*dr_ratevat/100)*100)/100,2);
            }
            else{
                dr_vatfamt  = Math.round((Number(dr_famt*dr_ratevat/100)*100)/100);
                dr_vatamt   = Math.round((Number(dr_amt*dr_ratevat/100)*100)/100);
            }
            txt_rate.SetDataText(dr_ratevat);
        }
        else{
            txt_rate.SetDataText('');
        }
        
        grdDebit.SetGridText(event.row, 11, dr_vatfamt);
        grdDebit.SetGridText(event.row, 12, dr_vatamt);
        grdDebit.SetGridText(event.row, 13, dr_vatfamt);
        grdDebit.SetGridText(event.row, 14, dr_vatamt);
        dso_upd_ctl_item.Call("SELECT");
    }
    
    if (event.col == 13){
        dr_vatfamt     = Number(grdDebit.GetGridData(event.row, 13));
        grdDebit.SetGridText(event.row, 14, dr_vatfamt);
    }
    OnSumDR();
}

function RowEditCR(){
    var cr_famt = 0;
    var cr_rate = 0;
    var book_rate = 1;   
    var cr_b_rate = 1; 
    var book_rate = 0;
    _book_rate = grdCredit.GetGridData(event.row, 20);
    
    if (event.col == 6 ||  event.col == 7 || event.col == 8 || event.col == 10 || event.col == 20){
        txtcur.text = grdCredit.GetGridData(event.row, 6);
        cr_famt = Number(grdCredit.GetGridData(event.row, 8));
        
        book_rate = GetBookExRate(txtcur.text);
        if(event.col == 6){
        grdCredit.SetGridText(event.row, 7, book_rate);}
        cr_rate = Number(grdCredit.GetGridData(event.row, 7));
        
        if(_book_col_format.indexOf(".")>0){
            var book_amt = Number(cr_famt*(cr_rate/_book_rate));
            book_amt = System.Round(book_amt,2);
            grdCredit.SetGridText(event.row, 9, book_amt);
        }
        else{
            grdCredit.SetGridText(event.row, 9, Math.round(Number(cr_famt*(cr_rate/_book_rate))));
        }
     
        cr_famt     = Number(grdCredit.GetGridData(event.row, 8));
        cr_amt      = Number(grdCredit.GetGridData(event.row, 9));
         
        cr_ratevat  = grdCredit.GetGridData(event.row, 10);
        cr_vatfamt  = 0;
        cr_vatamt   = 0;
        if (cr_ratevat != 'NO' && cr_ratevat != '01'){
             if(_book_col_format.indexOf(".") > 0){
                cr_vatfamt = Number(cr_famt*cr_ratevat/100);
                cr_vatfamt  = System.Round(cr_vatfamt,2);
                cr_vatamt   = System.Round(Number(cr_amt*cr_ratevat/100),2);
             }
             else{
                cr_vatfamt = Number(cr_famt*cr_ratevat/100);
                cr_vatfamt  = Math.round(cr_vatfamt);
                cr_vatamt   = Math.round(Number(cr_amt*cr_ratevat/100));
             }
                txt_rate.SetDataText(cr_ratevat);
        }
        else{
            txt_rate.SetDataText('');
        }
        grdCredit.SetGridText(event.row, 11, cr_vatfamt);
        grdCredit.SetGridText(event.row, 12, cr_vatamt);
        grdCredit.SetGridText(event.row, 13, cr_vatfamt);
        grdCredit.SetGridText(event.row, 14, cr_vatamt);
        dso_upd_ctl_item.Call("SELECT");
    }
    else if (event.col == 13){
        cr_vatfamt     = Number(grdCredit.GetGridData(event.row, 13));
        grdCredit.SetGridText(event.row, 14, cr_vatfamt);
    }
    OnSumCR();
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
        if(itemal == "SERIAL NUMBER" || itemal == "SERIAL NO" || itemal == "SERI NO")
        {
            item_value = item_value.toUpperCase();
            idGridItem.SetGridText( i , 9, item_value);
        }
    }
}

function OnChangeList()
{
    dso_get_rate_arap.Call();
}

function OnConfirmCancel()
{
    var path = System.RootURL + '/form/gf/hg/gfhg00010_causecancel.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq1.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData() + '&dsqlid=ACNT.SP_PRO_CONFIRM_CANCEL_PAYMENT';
    var object = System.OpenModal( path,  400 , 400,'resizable:yes;status:yes');
    if ( object != null )
    {
        if (object[0] !=0)
        {
            txtseq1.text = object[0];
            CheckKeySeq();
        }
    }
}

function OnReportAcct()
{
	if(txtseq.GetData() != "")
	{
		var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq=' + txtseq.GetData();
		if(confirm("Are you sure you want to report ?" ))
		{
			System.OpenTargetPage( url , 'newform' );
			return;
		}
	}
	else
	{
		alert("This voucher hasn't confirmed yet!");
		return;
	}
}

function OnReportRV()
{
    if (lstPayment.GetData() == "1")//Payment voucher - Phieu Chi
	{
		rqt = "?company_pk=" + lstCompany.GetData() + '&seq=' + txtseq.GetData()+'&pv_pk=' + txtseq1.GetData();
		url =System.RootURL + '/reports/gf/br/gfbr00030_PaymentVoucher_General.aspx' + rqt; 
		if(confirm("Are you sure you want to report ?" ))
		{
			System.OpenTargetPage( url , 'newform' );
			return;
		}
	}
	else if (lstPayment.GetData()=="2")//Receipt Voucher- Phieu Thu
	{
	    if(txtseq.text!="")
	    {
	        rqt = "?company_pk=" + lstCompany.GetData() + '&seq='+txtseq.GetData() + '&pv_pk=' + txtseq1.GetData();
		//url =System.RootURL + '/reports/gf/br/gfbr00030_ReceiptVoucher.aspx'+rqt; 
		url = System.RootURL + '/reports/gf/br/gfbr00030_ReceiptVoucher_General.aspx'+rqt; 
		
			System.OpenTargetPage( url , 'newform' );
		
	    }
	    else
	    {
	        alert("This voucher hasn't confirmed yet!!");
	    }
		
	}
	else if (lstPayment.GetData()=="3")//Receipt Voucher- Phieu Chi
	{
		rqt = "?company_pk=" + lstCompany.GetData() + '&seq='+txtseq.GetData() + '&pv_pk=' + txtseq1.GetData();
		url = System.RootURL + '/reports/gf/br/gfbr00020_PaymentVoucherA4.aspx'+rqt; 
		System.OpenTargetPage( url , 'newform' );
	}
	else if (lstPayment.GetData()=="4")//Receipt Voucher- Phieu Thu
	{
		rqt = "?company_pk=" + lstCompany.GetData() + '&seq='+txtseq.GetData() + '&pv_pk=' + txtseq1.GetData();
		url = System.RootURL + '/reports/gf/br/gfbr00020_ReceiptVoucher_A4.aspx'+rqt; 
		System.OpenTargetPage( url , 'newform' );
	}
}

function onViewTAccount()
{
    if (txtseq.GetData() !='')
    {
        var pk      = txtseq.GetData();
		var status  = txtStatus.GetData();
		
		var fpath   = System.RootURL + '/form/gf/br/gfbr00030_popup.aspx?PK_ROW=' + pk + '&APPRCANCEL=' + status;
		var wWidth  = 950;
		var wHeight = 565;
		var x = Math.round((screen.availWidth - wWidth)/2);
		var y = Math.round((screen.availHeight - wHeight)/2);
			
		var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
		   "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
		   "lef="+ x +",top=" + y;
		
		var object = System.OpenModal(fpath, wWidth, wHeight, features);
    }
}

function OnCopy()
{
    dso_upd_copy.Call();
}

function CheckKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
function SetUserInfo(){
    txtProposedByUserPk.text = _user_pk;
    txtProposedByUserID.text = _user_id;
    txtProposedByUserName.text = _user_name;
    lstDepartment.value = _dept_pk;
}
function OnReportAMB()
{
	if(txtseq.GetData() != "")
	{
		var url =System.RootURL + '/reports/gf/hg/gfhg00010.aspx?seq='+txtseq.text  ;
		
			System.OpenTargetPage( url , 'newform' );
		
	}
	else
	{
		alert("This voucher hasn't confirmed yet!");
		return;
	}
}
//--------------------------------------------------------------------------------
function onEmpPopUp()
{
	 
	var path = System.RootURL + '/form/gf/os/gfos00070_popup_2.aspx';
	var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

	if ( obj != null )
	{
		txtpay_person.text    = obj[2];
		txtpay_person_pk.text  = obj[0];
				   
	}
   
	
}
//--------------------------------------------------------------------------------
</script>

<body style="margin: 0; padding: 0;">
    <!------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_sel_ctl_mst_pay_pvp" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="ACNT.SP_SEL_PAY_VOUCHER_FR_HGTRH">
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
                <inout bind="lstPayment"/>
                <inout bind="txtpay_person"/>
                <inout bind="txtcustpk"/>
                <inout bind="txtcustid"/>
                <inout bind="txtcustnm"/>
                <inout bind="txtEnclose"/>
                <inout bind="txtDescription"/>
                <inout bind="txtLocalDescription"/>
                <inout bind="txtStatus"/>
                <inout bind="txttax_acc"/>
                <inout bind="txtseq1"/>
            </inout>
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_udp_ctl_mst_pay_pvp" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,21" function="ACNT.SP_SEL_PAYMENT_VOUCHER" procedure="ACNT.SP_UPD_PAYMENT_VOUCHER">
            <inout> 
                <inout bind="txtseq1"/>
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
                <inout bind="lstPayment"/>
                <inout bind="txtpay_person"/>
                <inout bind="txtcustpk"/>
                <inout bind="txtcustid"/>
                <inout bind="txtcustnm"/>
                <inout bind="txtEnclose"/>
                <inout bind="txtDescription"/>
                <inout bind="txtLocalDescription"/>
                <inout bind="txtStatus"/>
                <inout bind="txttax_acc"/>
				<inout bind="txtpay_person_pk"/>
            </inout>
            </dso> 
        </xml> 
    </gw:data>
     <gw:data id="dso_upd_grd_dtl_payment_dr" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,3,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="acnt.SP_SEL_GRD_DTL_PAYMENT" procedure="acnt.SP_UPD_PAYMENT_VOUCHER_DETAIL">
                <input bind="grdDebit" >
                    <input bind="txtseq1"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdDebit" />
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_grd_dtl_payment_cr" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,3,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="acnt.SP_SEL_GRD_DTL_PAYMENT" procedure="acnt.SP_UPD_PAYMENT_VOUCHER_DETAIL">
                <input bind="grdCredit">
                    <input bind="txtseq1"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdCredit"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_upd_ctl_item" onreceive="ItemStyle()">
        <xml>
            <dso type="grid" parameter="0,1,2,9,10,11,12" function="acnt.SP_SEL_GRD_CTL_ITEM_PAYMT_CALL" procedure="acnt.SP_UPD_GRD_ITEM_CTL_PAYMENT">
                <input bind="idGridItem">
                    <input bind="lstCompany"/>
                    <input bind="txtbprvpvd"/>
                    <input bind="txtacpk"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txttax_acc"/>
                    <input bind="txt_rate"/>
                </input> 
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_get_rate_arap">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE_ACC_AP_AR">
                <input> 
                     <input bind="lstVoucherType"/>
                </input>
                <output>
                     <output bind="txttax_acc"/>
               </output> 
            </dso> 
        </xml>
    </gw:data>
    <gw:data id="dso_upd_confirm" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CONFIRM_TAC_BPRVPV" > 
                <input> 
                     <input bind="txtseq1"/>
                     <input bind="lstCompany"/>
                </input>  
                <output>  
                     <output bind="txtStatus"/>
                     <output bind="txtseq"/>
                     <output bind="txtvoucher_auto"/>
                     <output bind="txtvoucher_no"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_upd_replicate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_AUTO_PAYMENT_REGENERATE"> 
                <input> 
                     <input bind="txtseq1"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtseq1"/>
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml>
    </gw:data>
    <gw:data id="dso_upd_copy" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_AUTO_PAYMENT_REGEN_COPY"> 
                <input> 
                     <input bind="txtseq1"/>
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtseq1"/>
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

<gw:data id="datCompany" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="acnt.sp_lst_get_company"  > 
                <input>
                    <input bind="txtSesion_company" />
                </input> 
                <output>
                    <output bind="lstCompany" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td>
                <table width="100%" border="1" cellspacing="0" cellpadding="0">
                    <tr>
                        <td colspan="2">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="10%">
                                                    &nbsp;Company</td>
                                                <td width="10%">
                                                    <gw:list id="lstCompany" value="" />
                                                </td>
                                                <td width="7%">
                                                    &nbsp;Voucher No</td>
                                                <td width="3%">
                                                    <gw:checkbox id="chkauto_YN" value="T" onclick="OnAutoYN()" />
                                                </td>
                                                <td width="10%">
                                                    <gw:list id="lstVoucherType" onchange="OnChangeList()" />
                                                </td>
                                                <td width="10%">
                                                    <gw:textbox id="txtvoucher_auto" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtvoucher_no" onkeypress="CheckKey()" />
                                                </td>
                                                <td width="3%">
                                                    &nbsp;Seq</td>
                                                <td width="7%">
                                                    <gw:textbox id="txtseq" onenterkey="CheckKeySeq()" onkeypress="CheckNumeric()" />
                                                </td>
                                                <td width="4%">
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnPopup" img="popup" alt="View T Account" onclick="onViewTAccount()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="onSearch()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="onNew()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="onSave()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" onclick="onDelete()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnReportAcct()" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="btnReportRV" img="printer" alt="Print RV" onclick="OnReportRV()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="10%">
                                                    &nbsp;Trans Date</td>
                                                <td width="10%">
                                                    <gw:datebox id="dtDate" lang="1" onchange="dateChange()" />
                                                </td>
                                                <td width="10%">
                                                    &nbsp;Department</td>
                                                <td width="20%">
                                                    <gw:list id="lstDepartment" value="ALL" />
                                                </td>
                                                <td width="7%" align="right">
                                                    Proposed By&nbsp;</td>
                                                <td width="5%">
                                                    <gw:textbox id="txtProposedByUserID" />
                                                </td>
                                                <td width="22%">
                                                    <gw:textbox id="txtProposedByUserName" />
                                                </td>
                                                <td width="5%">
                                                    <gw:icon id="btnConfirm" img="in" text="Confirm" onclick="OnConfirm()" styles="width:100%" />
                                                </td>
                                                <td width="5%">
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
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="10%">
                                                    &nbsp; Type
                                                </td>
                                                <td width="10%">
                                                    <gw:list id="lstPayment" value="2"><data>Data|1|Payment|2|Receipt|3|Payment-A4|4|Receipt-A4</data></gw:list>
                                                </td>
                                                <td width="10%"><a title="Nhấp vào đây để hiển thị nhân viên" onclick="onEmpPopUp()" href="#tips" >Receipt Person</a></td>
                                                <td width="20%">
                                                    <gw:textbox id="txtpay_person" />
                                                </td>
                                                <td width="7%" align="right">
                                                    <a onclick="onCustPopUp()" href="#" title="Get customer">Partner</a>
                                                </td>
                                                <td width="5%">
                                                    <gw:textbox id="txtcustid" />
                                                </td>
                                                <td width="22%">
                                                    <gw:textbox id="txtcustnm" />
                                                </td>
                                                <td width="3%">
                                                    <gw:imgbtn id="btnResetCust" img="reset" alt="Reset" onclick="onCustReset()" />
                                                </td>
                                                <td width="6%">
                                                    &nbsp;Ex.Rate (BK)</td>
                                                <td width="3%">
                                                    <gw:label id="lblBookRate" />
                                                </td>
                                                <td width="4%">
                                                    <gw:icon id="btnCopy" img="in" text="Copy" onclick="OnCopy()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="10%">
                                                    &nbsp;Enclose</td>
                                                <td width="10%">
                                                    <gw:textbox id="txtEnclose" />
                                                </td>
                                                <td width="10%">
                                                    &nbsp;Description</td>
                                                <td width="30%">
                                                    <gw:textbox id="txtDescription" csstype="mandatory" />
                                                </td>
                                                <td width="10%">
                                                    &nbsp;Description (LC)</td>
                                                <td width="30%">
                                                    <gw:textbox id="txtLocalDescription" csstype="mandatory" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="60%" id="tdGrid">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="5%" align="center">
                                                                <a onclick="OnSumDR()" href="#tips">Debit&nbsp;</a></td>
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
                                                <!--0_Pk|1_Acc_pk|2|3|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|Amount Trans|Amount Book|%VAT|VAT Trans|VAT Book|VAT Deduct Trans|VAT Deduct Book|Description|Local Description|_m_pk|_ODR|_DRCR|Book Rate"-->
                                                <td width="100%">
                                                    <gw:grid id="grdDebit" header="_Pk|_Acc_pk|||Acc. Code|Acc. Name|Ccy|Ex. Rate|Amt (Trans)|Amt (Books)|%VAT|VAT Amt (TR)|VAT Amt (BK)|VAT Amt Deduct (TR)|VAT Amt Deduct (BK)|Description|Description (LC)|_m_pk|_ODR|_DRCR|Ex.Rate (Books)"
                                                        format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0|0|2" aligns="0|0|1|1|1|0|1|1|3|3|1|3|3|3|3|0|0|0|0|0|0"
                                                        defaults="||||||VND|||||||||||||" editcol="0|0|1|1|0|0|1|1|1|1|1|0|0|1|1|1|1|0|0|0|1" widths="0|0|250|300|1000|2000|700|1000|1800|1800|700|1800|1800|1800|1800|3000|2500|1000|1000|1000|300"
                                                        styles="width:100%; height:175" sorting="F" oncellclick="RowClick_DR()" oncelldblclick="DBPopupClick_DR()"
                                                        onafteredit="RowEditDR()" onselchange="RowClick_DR()" />
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
                                                                <a onclick="OnSumCR()" href="#tips">Credit&nbsp;</a></td>
                                                            <td width="15%">
                                                                <gw:textbox id="txtsum_chk_cr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                            </td>
                                                            <td width="15%">
                                                                <gw:textbox id="txtsum_chk_cr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
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
                                                                <gw:imgbtn id="btnNew_Cr" img="New" alt="New" onclick="OnNewCr()" />
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
                                                                <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;"
                                                                    onclick="OnToggle()" /></img></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
											<!--0_Pk|1_Acc_pk|2.|3.|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.Amount Book|10.%VAT|11.VAT Trans|12.VAT Book|13.VAT Deduct Trans|14.VAT 15.Deduct Book|16.Description|17.Local Description|18._m_pk|19_ODR|20_DRCR|21.Book Rate-->
                                                <td width="100%">
                                                    <gw:grid id="grdCredit" header="_Pk|_Acc_pk|||Acc. Code|Acc. Name|Ccy|Ex. Rate|Amt (Trans)|Amt (Books)|%VAT|VAT Amt (TR)|VAT Amt (BK)|VAT Amt Deduct (TR)|VAT Amt Deduct (BK)|Description|Description (LC)|_m_pk|_ODR|_DRCR|Ex.Rate (Books)"
                                                        format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0|0|2" aligns="0|0|1|1|1|0|1|1|3|3|1|3|3|3|3|0|0|0|0|0|0"
                                                        defaults="||||||VND||||||||||||||" editcol="0|0|1|1|0|0|1|1|1|1|1|0|0|1|1|1|1|0|0|0|1" widths="0|0|250|300|1000|2000|700|1000|1800|1800|700|1800|1800|1800|1800|3000|2500|1000|1000|1000|300"
                                                        styles="width:100%; height:145" sorting="F" oncelldblclick="DBPopupClick_CR()" oncellclick="RowClick_CR()"
                                                        onafteredit="RowEditCR()" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="5%" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="15%" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="15%" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="10%" bgcolor="bde9ff" align="center">
                                                                Difference</td>
                                                            <td width="15%" bgcolor="bde9ff">
                                                                <gw:textbox id="txtsum_diff_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                            </td>
                                                            <td width="15%" bgcolor="bde9ff">
                                                                <gw:textbox id="txtsum_diff_amt" styles="width:100%" type="number" format="#,###,###,###,###R" />
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                            <td width="3%" align="right" bgcolor="bde9ff">
                                                            </td>
                                                        </tr>
                                                    </table>
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
                                                    <gw:icon id="btnTreament" img="in" text="Treament" onclick="OnTreament()" styles="width:100%" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="100%">
                                        <gw:neogrid id="idGridItem" styles="width:100%;height:360" oncelldblclick="ClickItemControl()" onafteredit="ChangeData_Upper()"> 
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
    </table>
    <!------------------------------------------Textbox ẩn -------------------------------------------------->
    <gw:list id="lstVoucherTypePrint" styles="display:none" />
    <gw:list id="lstBookExRate" styles="display:none" />
    <gw:textbox id="txtProposedByUserPk" style="display: none" />
    <gw:textbox id="txt_DRCR" style="display: none" />
    <gw:textbox id="txtStatus" style="display: none" />
    <gw:textbox id="txttrans_code_tmp" style="display: none" />
    <gw:textbox id="txtacpk" style="display: none" />
    <gw:textbox id="txt_drcr_type" style="display: none" />
    <gw:textbox id="txt_rowclick" style="display: none" />
    <gw:textbox id="txt_count" style="display: none" />
    <gw:textbox id="txtbprvpvd" style="display: none" />
    <gw:textbox id="txtcur" style="display: none" />
    <gw:textbox id="txtrate" style="display: none" />
    <gw:textbox id="txt_row" style="display: none" />
    <gw:textbox id="txttax_acc" style="display: none" />
    <gw:textbox id="txtLang" style="display: none" />
    <gw:textbox id="txt_rate" style="display: none" />
    <gw:textbox id="txtseq1" style="display: none" />
    <gw:textbox id="txtcustpk" style="display: none" />
    <gw:textbox id="txtEACAB032" style="display: none" />
    <gw:textbox id="txtEACAB018" style="display: none" />
    <gw:textbox id="txtpay_person_pk" style="display: none" />
	<gw:textbox id="txsetDRamt2CR" style="display: none" />
    <gw:textbox id="txtAc_level"  styles='display:none' />
<gw:textbox id="txtSesion_company"  styles='display:none' />
    <gw:grid style="display: none" id="idGridTempItem" header="itemacctpk|itemal|item|itemnm|table_pk" format="0|0|0|0|0"
        aligns="0|0|0|0|0" defaults="||||" editcol="0|0|0|0|0" widths="1300|3500|3500|2000|0" styles="width:100%; height:100"
        sorting="F" param="0,1,2,3,4" />
    <!---------------------------------------------------------------------------------------------------->
</body>
</html>
