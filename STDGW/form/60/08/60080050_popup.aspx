﻿<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>

var pk, row_index, rows_index;
var arr_pk = new Array();
row_index   = 0;
rows_index  = 0;

var click_dr = 0;
var click_cr = 0;

var flag_select = false;
var lang = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{
	System.Translate(document);
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_data1    = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.org_NM FROM TCO_org A WHERE del_if=0 ")%>";
    //var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE('ACBG0130') FROM DUAL")%>";
	var ls_data2    ="<%=ESysLib.SetListDataSQL(" SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'ACBG0130' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY CODE")%>"; 
	var data = "<%=ESysLib.SetListDataFUNC("SELECT ac_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
    arr  = data.split("|");
	txtbookccy.SetDataText(arr[1]);
	 
    lstCompany.SetDataText(ls_data);
    lstDepartment.SetDataText(ls_data1);
    lstVoucherType.SetDataText(ls_data2);
    txtLang.SetDataText(lang);
    lstCompany.SetEnable(false);
    chkauto_YN.SetEnable(false);
    lstVoucherType.SetEnable(false);
    txtvoucher_auto.SetEnable(false);
    txtvoucher_no.SetEnable(false);
    txtseq.SetEnable(false);
    dtDate.SetEnable(false);
    lstDepartment.SetEnable(false);
    txtProposedByUserID.SetEnable(false);
    txtProposedByUserName.SetEnable(false);
    
    //btnAppr.SetEnable(false);
    //btnNAppr.SetEnable(false);
    //btnCancel.SetEnable(false);
    
    txttransaction_code.SetEnable(false);
    txttransaction_name.SetEnable(false);
    txtDescription.SetEnable(false);
    txtLocalDescription.SetEnable(false);
    
    txtsum_chk_dr_famt.SetEnable(false);
    txtsum_chk_dr_amt.SetEnable(false);
    txtsum_total_dr_famt.SetEnable(false);
    txtsum_total_dr_amt.SetEnable(false);
    
    txtsum_chk_cr_famt.SetEnable(false);
    txtsum_chk_cr_amt.SetEnable(false);
    txtsum_total_cr_famt.SetEnable(false);
    txtsum_total_cr_amt.SetEnable(false);
    
    pk              = "<%=Request.querystring("PK_ROW")%>";
    row_index       = "<%=Request.querystring("ROW")%>";	
    rows_index      = "<%=Request.querystring("ROWS")%>";
    var ls_status   = "<%=Request.querystring("APPRCANCEL")%>";
    //var ls_str      = "<%=Request.querystring("ARRAY_PK")%>";
    
    //arr_pk = ls_str.split(' ');
	//var ls_temp = arr_pk[row_index];
	txtseq.SetDataText(pk);
    CheckKeySeq();
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

function OnPre()
{
	var callerWindowObj = dialogArguments;
    row_index = parseInt(row_index) - 1;
    //vi nhieu form su dung dialog nay nen minh chia ra theo truong hop
    // truong hop header grid cua form master la 2 dong
    if(callerWindowObj.name == "gfka00100_popup" || callerWindowObj.name == "gfka00030" || callerWindowObj.name == "gfka00020" || callerWindowObj.name == "gfhg00050_0" || callerWindowObj.name == "gfka00050" ) 
    {
     
	    if (row_index < 2){
		    alert("First record...");
		    row_index = 2;
        }
	    else{
	        var row_pk = callerWindowObj.GetRowPK(row_index);
            txtseq.SetDataText(row_pk);
            CheckKeySeq();
	    }
    }
    else // truong hop header grid cua form master la 1 dong
    {
       
	    if (row_index < 1){
		    alert("First record...");
		    row_index = 1;
        }
	    else{
	        var row_pk = callerWindowObj.GetRowPK(row_index);
            txtseq.SetDataText(row_pk);
            CheckKeySeq();
	    }    
    }
}

function OnNext()
{	
    var callerWindowObj = dialogArguments;
    row_index = parseInt(row_index) + 1;
    var row_pk = callerWindowObj.GetRowPK(row_index);
	if (row_pk < 0){
		alert("Last record...");
		row_index = row_index - 1;
    }
	else{
        txtseq.SetDataText(row_pk);
        CheckKeySeq();
	}
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
        idGridItem.SetEnable(false);
        flag_select = true;
        click_dr = 0;
        click_cr = 0;
        OnCtrToggleRight();
        dso_udp_ctl_mst_slip_entry.Call('SELECT');
    }
}

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_udp_ctl_mst_slip_entry":
            txttrans_code_tmp.text = txttransaction_code.GetData();
            SetButtonEnable();
            if (flag_select == true)
            {
                txt_drcr_type.SetDataText('D');
                dso_sel_grd_dtl_slip_entry_dr.Call("SELECT");
            }
        break;
        
        case "dso_sel_grd_dtl_slip_entry_dr":
            OnCloseData();
            SetNumGridDR();
            SetNumGridCR();
            if (flag_select == true)
            {
                txt_drcr_type.SetDataText('C');
                flag_select = false;
                dso_sel_grd_dtl_slip_entry_cr.Call("SELECT");
            }
        break;
        case "dso_sel_count_ctl_item":
            if (Number(txt_count.GetData()) > 0)
            {
                OnCtrToggleLeft();
                SetButtonEnable();
                dso_sel_control_new_item.Call('SELECT');
            }
            else
            {
                OnCtrToggleRight();
                SetButtonEnable();
            }                
        break;
    }
}

function SetNumGridDR()
{
    var fg=grdDebit.GetGridControl();
    fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R"; 
	if(txtbookccy.GetData()== 'VND')
	{
	    fg.ColFormat(9) = "#,###,###,###,###,###,###,###,###R"; 
	}else{
	    fg.ColFormat(9) = "#,###,###,###,###,###,###,###.##R"; 
	}
}

function SetNumGridCR()
{
    var fg=grdCredit.GetGridControl();
    fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###R"; 
	fg.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R"; 
	if(txtbookccy.GetData()== 'VND')
	{
	    fg.ColFormat(9) = "#,###,###,###,###,###,###,###,###R"; 
	}else{
	    fg.ColFormat(9) = "#,###,###,###,###,###,###,###.##R"; 
	}
}

function OnCloseData()
{
    for (i = 1; i < grdDebit.rows; i++)
    {
        grdDebit.SetRowEditable(i, false);
    }
    for (i = 1; i < grdCredit.rows; i++)
    {
        grdCredit.SetRowEditable(i, false);
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
	    if ((grdDebit.rows > 1) && (grdDebit.selrow < grdDebit.rows) && (grdDebit.selrow != click_dr))
	    {
            for (i = 1; i < grdDebit.rows; i++)
            {
                if (grdDebit.selrow == i)
                {
                    grdDebit.SetCellBold(i, 1, i, 15, true);
                }
                else
                {
                    grdDebit.SetCellBold(i, 1, i, 15, false);
                }
            }
            txtacpk.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 1));
            txthgtrd.SetDataText(grdDebit.GetGridData(grdDebit.selrow, 0));
            txt_rowclick.text = grdDebit.selrow;
            txt_drcr_type.SetDataText('D');
            idGridItem.SetData("");
            click_dr = grdDebit.selrow;
            click_cr = 0;
            dso_sel_count_ctl_item.Call();
        }
        for (i = 1; i < grdCredit.rows; i++)
        {
            grdCredit.SetCellBold(i,1,i,15,false);
            grdCredit.SetRowEditable(i, false);
            grdCredit.DeselectRow(i);
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
	    if ((grdCredit.rows > 1) && (grdCredit.selrow < grdCredit.rows) && (grdCredit.selrow != click_cr))
	    {
            for (i = 1; i < grdCredit.rows; i++)
            {
                if (grdCredit.selrow == i)
                {
	                grdCredit.SetCellBold(i, 1, i, 15, true);
	            }
                else
                {
	                grdCredit.SetCellBold(i, 1, i, 15, false);
                }
            }
            txtacpk.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 1));
            txthgtrd.SetDataText(grdCredit.GetGridData(grdCredit.selrow, 0));
            txt_rowclick.text = grdCredit.selrow;
            txt_drcr_type.SetDataText('C');
            idGridItem.SetData("");
            click_dr = 0;
            click_cr = grdCredit.selrow;
            dso_sel_count_ctl_item.Call();
        }
        for (i = 1; i < grdDebit.rows; i++)
        {
            grdDebit.SetCellBold(i,1,i,15,false);
            grdDebit.SetRowEditable(i, false);
            grdDebit.DeselectRow(i);
        }
        OnCheckSumCR();
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
	txtsum_total_cr_famt.SetDataText('' + sum_cr_famt);
	txtsum_total_cr_amt.SetDataText('' + sum_cr_amt);
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
	txtsum_total_dr_famt.SetDataText('' + sum_dr_famt);
	txtsum_total_dr_amt.SetDataText('' + sum_dr_amt);
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

function ItemStyle()
{
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
}

function SetButtonEnable()
{
   
    if (txtStatus.GetData() == " ")
    {
        btnAppr.SetEnable(false);
        btnNAppr.SetEnable(false);
        btnCancel.SetEnable(false);
    }
    else if (txtStatus.GetData() == 1)
    {
        btnAppr.SetEnable(false);
        btnNAppr.SetEnable(false);
        btnCancel.SetEnable(false);
    }
    else if (txtStatus.GetData() == 2)
    {
        btnAppr.SetEnable(true);
        btnNAppr.SetEnable(false);
        btnCancel.SetEnable(false);
    }
    else if (txtStatus.GetData() == 3)
    {
        btnAppr.SetEnable(false);
        btnNAppr.SetEnable(false);
        btnCancel.SetEnable(false);
        btnCancelCause.GetControl().style.display = '';
    }
    else if (txtStatus.GetData() == 4)
    {
        btnAppr.SetEnable(true);
        btnNAppr.SetEnable(false);
        btnCancel.SetEnable(false);
    }
    else if (txtStatus.GetData() == 0)
    {
        btnAppr.SetEnable(false);
        btnNAppr.SetEnable(true);
        btnCancel.SetEnable(true);
    }
}


function OnApprove()
{
	if(confirm('Are you sure you want to approve?'+'\n'+'Bạn có chắc Approval số SEQ này?'))
	{
        txtStatus.text  = 0;
        txtindex.text   = 1;
        txtseq_str.text = txtseq.GetData() + ',';
        dso_upd_approval_cancel.Call();
    }
}

function OnNoApp()
{
	if(confirm('Are you sure you want to No Approve?'+'\n'+'Bạn có chắc No Approval số SEQ này?'))
	{
        txtStatus.text  = 4;
        txtindex.text   = 1;
        txtseq_str.text = txtseq.GetData() + ',';
		//txtseq_str
        dso_upd_approval_cancel.Call();
    }
}

function OnCancel()
{
	if(confirm('Are you sure you want to Cancelled?'+'\n'+'Bạn có chắc Cancelled số SEQ này?'))
	{
        txtStatus.text  = 3;
        txtindex.text   = 1;
        txt_seqstr.text = txtseq.GetData() + ',';
        dso_upd_approval_cancel.Call();
    }
}
function OnReport()
{
	if (txtStatus.text =="")
	{
		alert("Please save voucher!\nChứng từ chưa được lưu!");
		return;
	}
	if (txtStatus.text =="3")
	{
		alert("Cannot print cancelled voucher!\nChứng từ đã bị hủy!");
		return;
	}
	else
	{
		var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq='+txtseq.text;
		if(confirm("Are you sure you want to report ?" ))
		{
			System.OpenTargetPage( url , 'newform' );
			return;
		}
	}
}
//-------------------------------------------------------------
function Cancelcause()
{
	var path = System.RootURL + '/form/60/08/60080050_popup_1.aspx?com_pk='+ lstCompany.GetData() + '&seq=' + txtseq.GetData() + '&status=' + txtStatus.GetData() + '&userid=' + txtProposedByUserID.GetData() + '&usernm=' + txtProposedByUserName.GetData() + '&userpk=' + txtProposedByUserPk.GetData() + '&dsqlid=ACNT.SP_PRO_CTL_MST_CONFIRM_CANCEL' + '&table=TAC_HGTRH';
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
//-------------------------------------------------------------
</script>
<body style="margin:0; padding:0;">
<!------------------------------------------------------------------------------------------------------->

 <gw:data id="dso_udp_ctl_mst_slip_entry" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" function="ac_sel_60080050_ctl_mst_slip">
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

    <gw:data id="dso_sel_grd_dtl_slip_entry_dr" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="SP_SEL_60080050_GRD_DTL_SLIP">
                <input bind="grdDebit" >
                    <input bind="txtseq"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdDebit" />
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_dtl_slip_entry_cr">
        <xml>
            <dso type="grid" function="SP_SEL_60080050_GRD_DTL_SLIP">
                <input bind="grdCredit">
                    <input bind="txtseq"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txtLang"/>
                </input>
                <output bind="grdCredit"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_count_ctl_item" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ac_Pro_60080050_Grd_Dtl_Slip" > 
                <input> 
                     <input bind="txtacpk"/>
                     <input bind="txt_drcr_type"/>
                     <input bind="txthgtrd"/>
                </input>  
                <output>  
                     <output bind="txt_count"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_sel_control_new_item" onreceive="ItemStyle()">
        <xml>
            <dso type="grid" function="ac_Sel_60080050_Grd_Item_Slip" >
                <input bind="idGridItem">
                    <input bind="txtacpk"/>
                    <input bind="txthgtrd"/>
                    <input bind="txt_drcr_type"/>
                    <input bind="txt_count"/>
                </input>
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_upd_approval_cancel" onreceive="SetButtonEnable()"> 
        <xml> 
            <dso type="process" procedure="ac_pro_60080050_appr_cancel" > 
                <input> 
                     <input bind="txtseq_str" />
                     <input bind="lstCompany"/>
                     <input bind="txtStatus"/>
                     <input bind="txtindex"/>
                     <input bind="lstApptype"/>
                     <input bind="dtApp"/>
                     <input bind="chkCombine_YN"/>
                </input>

				    
                <output>
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!------------------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td>
		<table width="100%"  border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="2">
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="13%"></td>
                    <td width="4%"></td>
                    <td width="13%"></td>
                    <td width="10%"></td>
                    <td width="6%"></td>
                    <td width="10%"></td>
                    <td width="2%"></td>
                    <td width="13%"></td>
                    <td width="8%"></td>
                    <td width="16%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                    <td width="2%"></td>
                </tr>
                <tr>
                    <td align="right">Company&nbsp;</td>
                    <td>
					    <gw:list id="lstCompany" value="" styles='width:100%'></gw:list>
				    </td>
				    <td align="right">Voucher No
					    <gw:checkbox id="chkauto_YN" value="T"  onclick="OnAutoYN()"/> 
				    </td>
                    <td colspan="2"><gw:list    id="lstVoucherType" styles="width:100%"></gw:list></td>
				    <td><gw:textbox id="txtvoucher_auto" styles="width:100%"/></td>
					<td colspan="2"><gw:textbox id="txtvoucher_no" styles="width:100%"/></td>
					<td align="right">Seq&nbsp;</td>
                    <td><gw:textbox id="txtseq" styles="width:100%" onenterkey="CheckKeySeq()" onkeypress="CheckNumeric()"/></td>
                    <td ></td>
				    <td ></td>
				    
				    <td colspan=6>
				        <table width="100%" border ="0" cellpadding ="0" cellspacing="0">
				        <tr>
				           
				            <td><gw:imgBtn    img="back" alt="Back" id="btnBack" 	onclick="OnPre()"/></td>
				            <td><gw:imgBtn    img="next" alt="Next" id="btnNext" 	onclick="OnNext()" /></td>
				            <td><gw:imgBtn    img="excel" alt="Next" id="btnexcel" 	onclick="OnReport()" /></td>
				           
				        </tr>
				        </table>
				    </td>
				    
				</tr>
                <tr>
                    <td align="right">Trans Date&nbsp;</td>
                    <td><gw:datebox id="dtDate" lang="1" /></td>
                    <td align="right">Department&nbsp;</td>
                    <td colspan="3">
					    <gw:list id="lstDepartment" styles="width:100%" value="ALL" ></gw:list>
				    </td>
				    <td></td>
                    <td align="right">Proposed By&nbsp;</td>
                    <td><gw:textbox id="txtProposedByUserID"    styles="width:100%"/></td>
                    <td><gw:textbox id="txtProposedByUserName"  styles="width:100%"/></td>
                    
                    <td colspan="2"><gw:icon id="btnAppr"       img="in" text="Approval"    onclick="OnApprove()"           styles="width:100%;display:;"/></td>
                    <td colspan="2"><gw:icon id="btnNAppr"      img="in" text="Approval(In)"onclick="OnNoApp()"             styles="width:100%;display:none;"/></td>  
				    <td colspan="2"><gw:icon id="btnCancel"     img="in" text="Cancel"      onclick="OnCancel()"            styles="width:100%;display:;"/></td>  
				    <td colspan="1"><gw:icon id="btnCancelCause"       img="in" text="Cancel cause"    onclick="Cancelcause()" styles="width:100%;display:;"/></td>  
                </tr>
                <tr>
                    <td align="right">Transaction Type&nbsp;</td>
                    <td colspan="2"><gw:textbox id="txttransaction_code" styles="width:100%" onkeypress="Upcase()" onenterkey="OnEnterTrans_Code()" csstype="mandatory"/></td>
                    <td colspan="7"><gw:textbox id="txttransaction_name" styles="width:100%"/></td>
                    <td >Enclose</td>
                    <td colspan="6">
                        <gw:textbox id="txtEnclose" styles="width:100%" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Description&nbsp;</td>
                    <td colspan="5"><gw:textbox id="txtDescription" styles="width:100%" csstype="mandatory"/></td>
                    <td></td>
                    <td align="center">Local Description&nbsp;</td>
                    <td colspan="9"><gw:textbox id="txtLocalDescription" styles="width:100%" csstype="mandatory"/></td>
                </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="60%" id="tdGrid">
                <table border=0 width="100%" cellpadding=0 cellspacing=0 >
                <tr>
                    <td>
				        <table  width ="100%" cellpadding ="0" cellspacing ="0" border="0" >
                        <tr>
				            <td>
		                        <table width ="100%" cellpadding ="0" cellspacing ="0" border="0">
		                            <tr>
	                                   <td width ="5%" align="center"><b><a onClick="OnSumDR()" href="#tips">Debit</a></td>				
	                                   <td width ="15%"><gw:textbox id="txtsum_chk_dr_famt" styles="width:100%"type="number" format="#,###,###,###,###.##R"/></td>
			                           <td width ="15%"><gw:textbox id="txtsum_chk_dr_amt" styles="width:100%"type="number" format="#,###,###,###,###.##R"/></td>
				                       <td width ="10%" align="center">Total</td>
				                       <td width ="15%"><gw:textbox id="txtsum_total_dr_famt"   styles="width:100%"  type="number" format="#,###,###,###,###.##R"/></td>
				                       <td width ="15%"><gw:textbox id="txtsum_total_dr_amt" styles="width:100%"  type="number" format="#,###,###,###,###.##R"/></td>
	                                   <td width ="3%" align ="right" ></td>
	                                   <td width ="3%" align ="right" ></td>
	                                   <td width ="3%" align ="right" ></td>
	                                   <td width ="3%" align ="right" ></td>
	                                   <td width ="3%" align ="right" ></td>
	                                   <td width ="3%"></td>
                                    </tr>
                                </table>                   
                            </td>
                        </tr>
	                    <tr>
                            <td width ="100%" >
                            <gw:grid
                                id="grdDebit"  
                                header  ="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat"
                                format  ="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0"
                                aligns  ="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0"
                                defaults="||||||VND||||||||||"
                                editcol ="0|0|1|1|0|0|1|1|1|1|1|1|1|0|0|0|0"
                                widths  ="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0"
                                styles  ="width:100%; height:210"   
                                sorting ="F"   
                                param   ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"
                                oncellclick  = "RowClick_DR()"
                                onentercell  = "RowClick_DR()"
                                />
                            </td>
                        </tr>
	                    </table>	
			        </td>
                  </tr>
                  <tr>
                    <td width="100%">
				        <table  width ="100%" cellpadding ="0" cellspacing ="0" border="0" >
				        <tr>
		                    <td>
		                        <table width ="100%" cellpadding ="0" cellspacing ="0" border="0">
		                            <tr>
	                                   <td width="5%" align="center"><b><a onClick="OnSumCR()" href="#tips">Credit</a></td>				
	                                   <td width="15%"><gw:textbox id="txtsum_chk_cr_famt" styles="width:100%"type="number" format="#,###,###,###,###.##R"/> </td>                                        
				                       <td width="15%"><gw:textbox id="txtsum_chk_cr_amt" styles="width:100%"type="number" format="#,###,###,###,###R"/> </td>                                        
				                       <td width="10%" align="center">Total</td>                    
				                       <td width="15%"><gw:textbox id="txtsum_total_cr_famt"  styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>                    
				                       <td width="15%"><gw:textbox id="txtsum_total_cr_amt" styles="width:100%"  type="number" format="#,###,###,###,###R"/></td>  
	                                   <td width="3%" align ="right" ></td>
	                                   <td width="3%" align ="right" ></td>
	                                   <td width="3%" align ="right" ></td>
	                                   <td width="3%" align ="right" ></td>
	                                   <td width="3%" align ="right" ></td>
	                                   <td width="3%" align ="right" ><img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;" onclick="OnToggle()" /></img></td>
                                    </tr>
                                </table>                   
                            </td>
                        </tr>
	                    <tr>
	                        <td width ="100%">
	                            <gw:grid
	                                id="grdCredit"
						            header  ="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat"
				                    format  ="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0"
				                    aligns  ="0|0|1|1|0|0|1|1|3|3|0|0|0|0|0|0|0"
				                    defaults="||||||VND||||||||||"
				                    editcol ="0|0|1|1|0|0|1|1|1|1|1|1|1|0|0|0|0"
				                    widths  ="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0"
				                    styles  ="width:100%; height:210"
				                    sorting ="F"
				                    param   ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"
				                    oncellclick  = "RowClick_CR()"
                                    onentercell  = "RowClick_CR()"
				                    />
                            </td>   
                        </tr>
	                    </table>	
                    </td>
                </tr>
                </table>
            </td>
            <td width="40%" id="tdControlItem" style="display:none" valign="top">
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr height=30>
                        <td width="100%">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="25%" align="Center">Control Item</td>
                                    <td width="50%" align="left"></td>
                                    <td width="25%" align="right"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%"> 
							<gw:neogrid  id="idGridItem" styles="width:100%;height:400"> 
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

										<column title="Item"  width='2500'>
											<multiple ref="7"  >
												<textbox type="number" format="###,###C" value="" />
												<textbox format="50" value="" />
												<datebox type="day" format=""  lang="1" acceptnull="T"/>
												<checkbox />	
												<htmledit value="[New]" />				
											</multiple>
										</column>
										
										<column title="Item code" width='1500'>
											<textbox/>
										</column>
										
										<column title="ITEM NM" hidden='T'>
											<textbox  />
										</column>
										
										<column title="ITEM PK" hidden='T'>
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

<!------------------------------------------Textbox ẩn ----------------------------------------------->

<gw:textbox id="txtProposedByUserPk" style="display:none" />
<gw:textbox id="txtCustomerPk"       style="display:none" />

<gw:textbox id="txt_DRCR"            style="display:none" />
<gw:textbox id="txtStatus"           style="display:none" />
<gw:textbox id="txtindex"            style="display:none" />

<gw:textbox id="txttrans_pk"         style="display:none" />
<gw:textbox id="txttrans_code_tmp"   style="display:none" />
<gw:textbox id="txtacpk"             style="display:none" />
<gw:textbox id="txt_drcr_type"       style="display:none" />
<gw:textbox id="txt_rowclick"        style="display:none" />
<gw:textbox id="txt_count"           style="display:none" />
<gw:textbox id="txthgtrd"            style="display:none" />
<gw:textbox id="txtLang"             style="display:none" />
<gw:textbox id="txtbookccy"             style="display:none" />

<gw:textbox id="txtseq_str"          style="display:none" />
<gw:textbox id="lstApptype"   text='N'          style="display:none" />
<gw:textbox id="chkCombine_YN"    text='N'       style="display:none" />
<gw:datebox id="dtApp" lang="1" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>