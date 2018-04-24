<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
var curRow = 0;
var curRowDtl = 0;
var click_tab0   = true;
var click_tab1   = true;
var click_tab2   = true;
var click_tab3   = true;
var click_tab4   = true;
var new_click  = false;
var save_click = false;
var save_click_dtl = false;
function BodyInit()
{
	
    txtCUST_ID.SetEnable(false);
    txtCUST_NM.SetEnable(false);
    txtCUST_OFF_ID.SetEnable(false);
    txtCUST_OFF_NM.SetEnable(false);
    txtCUST_SHIP_ID.SetEnable(false);
    txtCUST_SHIP_NM.SetEnable(false);
    txtCUST_SHIP_ID.SetEnable(false);
    txtCUST_SHIP_NM.SetEnable(false);
    txtCUST_IMP_PK.SetEnable(false);
    txtCUST_IMP_ID.SetEnable(false);
    txtCUST_IMP_NM.SetEnable(false);
    txtCUST_PAID_ID.SetEnable(false);
    txtCUST_PAID_NM.SetEnable(false);
    txtITEM_TR_AMT.SetEnable(false);
    txtITEM_BK_AMT.SetEnable(false);
    txtITEM_DIFF_AMT.SetEnable(false);
//    txtTAX_TR_AMT.SetEnable(false);
//    txtTAX_BK_AMT.SetEnable(false);
//    txtTAX_DIFF_AMT.SetEnable(false);
    txtVAT_TR_AMT.SetEnable(false);
    txtVAT_BK_AMT.SetEnable(false);
    txtVAT_DIFF_AMT.SetEnable(false);
    new_click  = false;
	save_click = false;
    txtTR_TYPE.text ="DO";                
    BindingDataList();
    MergeMaster();
    lstVOUCHER_TYPE.SetDataText("AR");
    txtTSA_SOTAKEOUT_PK.text = "";
    txtTSA_SOTAKEOUTD_PK.text ="";
    txtFROM_DATE.text = "01" + txtTO_DATE.text.substr(2,8);
}

function BindingDataList()
{
    var ls_comp         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_ccy          = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
    var ls_voucher      = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACBG0130','','') FROM DUAL")%>";
    var ls_AP           = "<%=ESysLib.SetListDataFUNC("select SF_A_GET_COMMONCODE('EACAB014') from dual")%>";
    <%=ESysLib.SetGridColumnComboFormat("grdMaster", 3,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACBG0130' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdMaster", 8,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdMaster",20,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACCR0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdDtlVAT", 6,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACCR0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    lstCOMPANY.SetDataText(ls_comp);
    lstVOUCHER_TYPE.SetDataText(ls_voucher);
    //lstBOOK_CCY.SetDataText(ls_ccy);
    lstVAT_CCY.SetDataText(ls_ccy);
    lstGETDATA.SetDataText(ls_AP);
}
function MergeMaster()
{

    var fg=grdMaster.GetGridControl();
    fg.FixedRows = 1; 
	fg.MergeCells = 5; 
	fg.MergeRow(0) = true;
	
	fg.Cell(0, 0, 4, 0, 6) = "VOUCHER NO";
    fg.ColWidth(0) =500;
	fg.ColWidth(1) =800;
	fg.ColWidth(2) =1000;
	fg.ColWidth(3) =1000;
	
	fg.ColWidth(4) =350;
	fg.ColWidth(5) =800;
	fg.ColWidth(6) =1800;
	fg.ColWidth(7) =1500;
	fg.ColWidth(8) =800;
	fg.ColWidth(9) =1500;
	fg.ColWidth(10) =1500;
	fg.ColWidth(11) =1500;
	fg.ColWidth(12) =1500;
	fg.ColWidth(13) =1500;
	fg.ColWidth(14) =1800;
	fg.ColWidth(15) =1800;
	fg.ColWidth(16) =1800;
	fg.ColWidth(17) =1800;
	fg.ColWidth(18) =1800;
	fg.ColWidth(19) =1800;
	fg.ColWidth(20) =1000;
	fg.ColWidth(21) =1800;
	fg.ColWidth(22) =1800;
	fg.ColWidth(21) =1800;
	fg.ColWidth(25) =1000;
	fg.ColWidth(26) =2500;
	fg.ColWidth(27) =1500;
	fg.ColWidth(28) =1500;
	fg.ColWidth(29) =2500;
	fg.ColWidth(30) =2500;
	fg.ColWidth(31) =2500;
	fg.ColWidth(32) =2500;
	fg.ColFormat(14) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
	fg.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
	fg.ColFormat(17) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
	fg.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
	fg.ColFormat(21) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(22) = "#,###,###,###,###,###,###,###,###R";
	fg.ColFormat(23) = "#,###,###,###,###,###,###,###,###R";
	//grdMaster.setFixedCols(7);
	//grdMaster.setFixedRows(2);
	
}

function SetNumGridItem()
{
    var fg=grdDtlItem.GetGridControl();
    fg.ColFormat(8) = "#,###,###,###,###,###.##R";
	fg.ColFormat(9) = "###,###,###,###R";
	fg.ColFormat(10) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(11) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(12) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(13) = "#,###,###,###,###,###,###,###,##R";
	fg.ColFormat(14) = "#,###,###,###,###,###,###,###R";
	
}
//function SetNumGridTAX()
//{
//    var fg=grdDtlTAX.GetGridControl();
//    fg.ColFormat(5) = "#,###,###,###,###,###.##R";
//	fg.ColFormat(7) = "#,###,###,###,###,###,###,###.##R";
//	fg.ColFormat(8) = "#,###,###,###,###,###,###,###.##R";
//	fg.ColFormat(9) = "#,###,###,###,###,###,###,###.##R";
//	fg.ColFormat(10) = "#,###,###,###,###,###,###,###R";
//	
//	
//}
function SetNumGridVAT()
{
    var fg=grdDtlVAT.GetGridControl();
    fg.ColFormat(5) = "#,###,###,###,###,###.##R";
	fg.ColFormat(7) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(8) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(9) = "#,###,###,###,###,###,###,###.##R";
	fg.ColFormat(10) = "#,###,###,###,###,###,###,###R";
	fg.ColFormat(11) = "#,###,###,###,###,###,###,###R";	
}
function RefeshButton(id_status)
{
	if(id_status =='1')
	{
		btnNew.SetEnable(true);
		btnSave.SetEnable(true);
		btnDelete.SetEnable(true);
		btnConfirm.SetEnable(true);
		btnCancel.SetEnable(false); 
		btnReplicate.SetEnable(false);
	}
	if(id_status =='2')
	{
		btnNew.SetEnable(true);
		btnSave.SetEnable(false);
		btnDelete.SetEnable(false);
		btnConfirm.SetEnable(false);
		btnCancel.SetEnable(true); 
		btnReplicate.SetEnable(false);
	}
	if(id_status =='3')
	{
		btnNew.SetEnable(true);
		btnSave.SetEnable(false);
		btnDelete.SetEnable(true);
		btnConfirm.SetEnable(false);
		btnCancel.SetEnable(false); 
		btnReplicate.SetEnable(true);
	}
}
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}

function OnReset()
{
    
}

function OnSearch()
{
	dso_upd_tac_crca.Call("SELECT");
}

function OnNew()
{
    txtCUST_OFF_PK.SetDataText("");
	txtCUST_OFF_ID.SetDataText("");
    txtCUST_OFF_NM.SetDataText("");
    txtCUST_SHIP_PK.SetDataText("");
    txtCUST_SHIP_ID.SetDataText("");
    txtCUST_SHIP_NM.SetDataText("");
    txtCUST_IMP_PK.SetDataText("");
    txtCUST_IMP_ID.SetDataText("");
    txtCUST_IMP_NM.SetDataText("");
    txtCUST_PAID_PK.SetDataText("");
    txtCUST_PAID_ID.SetDataText("");
    txtCUST_PAID_NM.SetDataText("");
    
    grdMaster.DeselectRow(grdMaster.selrow);
	grdMaster.AddRow();
	grdMaster.SelectRow(grdMaster.rows - 1);
    var fg = grdMaster.GetGridControl();
	grdMaster.SetGridText( grdMaster.selrow , 33, lstCOMPANY.GetData());
	grdMaster.SetGridText( grdMaster.selrow , 3, 'AR');
	//grdMaster.SetGridText( grdMaster.selrow , 8, 'VND');
    curRow = grdMaster.selrow;
    new_click = true;
//    OnShowTakeOut();
//    grdMaster.SetGridText(curRow, 32, txtTSA_SOTAKEOUT_PK.text);
    
}

function OnSave()
{
	if(confirm("Do you want to save this voucher"))
	{
		if (Check_Master_Save())
		{
			
			if(grdMaster.GetGridData(curRow,1) == "")
			{
				grdMaster.SetRowStatus(curRow,0x20);
			}
			else
			{
				grdMaster.SetRowStatus(curRow,0x10);
			}
			save_click = true;
			dso_upd_tac_crca.Call();
			
		}
			
	}
}

function Check_Master_Save()
{
    var data;
    for (i = 1; i < grdMaster.rows; i++)
    {
		data = grdMaster.GetGridData(i, 4);
		if (data == '')
		{
			data = grdMaster.GetGridData(i, 6);
			if (data == '')
			{
				alert('    Voucher No is not null!!!'+'\n'+'Số chứng từ không được rỗng!!!');
				return false;
			}
        }
        data = grdMaster.GetGridData(i, 8);
		if (data == '')
		{
			alert('    Currency is not null!!!'+'\n'+'Loại tiền không được rỗng!!!');
			return false;
		}
        data = grdMaster.GetGridData(i, 9);
        if (data == '')
        {
            alert('   Date is not null!!!'+'\n'+'Tỉ giá giao dịch không được rỗng!!!');
            return false;
        }
        else
        {
            if (Number(data) <= 0) 
            {
                alert('Rate is greater than zero!!!'+'\n'+'Tỉ giá giao dịch > 0');
                return false;
            }
        }
//        data = grdMaster.GetGridData(i, 13);
//        if (data == '')
//        {
//            alert('   Date is not null!!!'+'\n'+'Tiền ghi sổ không được rỗng!!!');
//            return false;
//        }
        data = grdMaster.GetGridData(i, 24);
        if (data == '')
        {
            alert('   Transaction is not null!!!'+'\n'+'Loại giao dịch không được rỗng!!!');
            return false;
        }
        data = grdMaster.GetGridData(i, 27);
        if (data == '')
        {
            alert('   Account is not null!!!'+'\n'+'Nhập tài khoản!!!');
            return false;
        }
        
    }
    return true;
}
function OnDelete()
{
    var ctrl = grdMaster.GetGridControl();
    var count = 0
    for(i = 1; i< ctrl.rows; i++)
	{
		if(grdMaster.GetGridData(i,0)=="-1")
		{
			count++;
		}
	}
    if(count == 0)
	{
	    alert("Checking voucher to delete");
	    return;
	}
	if(confirm("Do you want to delete this voucher?"))
	{
		
		for(i = 1; i< ctrl.rows; i++)
		{
			if(grdMaster.GetGridData(i,0)=="-1")
			{
				grdMaster.SetRowStatus(curRow, 0x40);
			}
		}
		dso_upd_tac_crca.Call();
	}
}

function OnConfirm()
{
	if(confirm("Do you want to confirm this voucher?"))
	{
		if(grdMaster.selrow < 1)
		{
			alert("Select row to confirm!");
			return;
		}
		
		var ctrl = grdMaster.GetGridControl();
		txtCRCA_PK.text = '';
		var num_pk = 0;
		for(i = 1; i< ctrl.rows; i++)
		{
			if(grdMaster.GetGridData(i,0)=='-1')
			{
				txtCRCA_PK.text = txtCRCA_PK.text + grdMaster.GetGridData(i,1) + ',';
				num_pk++;
			}
			txtNUM_PK.text = num_pk;
			
		}
		dso_upd_crca_confirm.Call();
	}
}

function OnCancel()
{
    if(confirm("Do you want to cancel this voucher?"))
	{
		if(grdMaster.selrow < 1)
		{
			alert("Select row to cancel!");
			return;
		}
		
		var ctrl = grdMaster.GetGridControl();
		txtCRCA_PK.text = '';
		var num_pk = 0;
		for(i = 1; i< ctrl.rows; i++)
		{
			if(grdMaster.GetGridData(i,0)=='-1' && grdMaster.GetGridData(i,35)=='2')
			{
				txtCRCA_PK.text = txtCRCA_PK.text + grdMaster.GetGridData(i,1) + ',';
				num_pk++;
			}
			txtNUM_PK.text = num_pk;
			
		}
		dso_upd_crca_confirmcancel.Call();
	}
    
}

function OnReplicate()
{
    if(confirm("Do you want to copy this voucher?"))
	{
		if(grdMaster.selrow < 1)
		{
			alert("Select row to cancel!");
			return;
		}
		
		var ctrl = grdMaster.GetGridControl();
		txtCRCA_PK.text = '';
		var num_pk = 0;
		for(i = 1; i< ctrl.rows; i++)
		{
			if(grdMaster.GetGridData(i,0)=='-1' && grdMaster.GetGridData(i,35)=='3')
			{
				txtCRCA_PK.text = txtCRCA_PK.text + grdMaster.GetGridData(i,1) + ',';
				num_pk++;
			}
			txtNUM_PK.text = num_pk;
			
		}
		dso_upd_crca_replicate.Call();
	}
   
}

function GetCustomer(ind)
{
    var fpath   = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx";
    var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null )  
    {
        if (object[0] != "")
        {
            if(ind == "1")
            {
                txtCUST_PK.text = object[0];
                txtCUST_ID.text = object[1];
                txtCUST_NM.text = object[2];
                
            }
            if(ind == "2")
            {
                txtCUST_OFF_PK.text = object[0];
                txtCUST_OFF_ID.text = object[1];
                txtCUST_OFF_NM.text = object[2];
                if(txtCUST_SHIP_PK.text == "")
                {
                    txtCUST_SHIP_PK.text = object[0];
                    txtCUST_SHIP_ID.text = object[1];
                    txtCUST_SHIP_NM.text = object[2];
                }
                if(txtCUST_SHIP_PK.text == "")
                {
                    txtCUST_SHIP_PK.text = object[0];
                    txtCUST_SHIP_ID.text = object[1];
                    txtCUST_SHIP_NM.text = object[2];
                }
                if(txtCUST_IMP_PK.text == "")
                {
                    txtCUST_IMP_PK.text = object[0];
                    txtCUST_IMP_ID.text = object[1];
                    txtCUST_IMP_NM.text = object[2];
                }
                if(txtCUST_PAID_PK.text == "")
                {
                    txtCUST_PAID_PK.text = object[0];
                    txtCUST_PAID_ID.text = object[1];
                    txtCUST_PAID_NM.text = object[2];
                }
            }        
            if(ind == "3")
            {
                txtCUST_SHIP_PK.text = object[0];
                txtCUST_SHIP_ID.text = object[1];
                txtCUST_SHIP_NM.text = object[2];
            } 
            if(ind == "4")
            {
                txtCUST_IMP_PK.text = object[0];
                txtCUST_IMP_ID.text = object[1];
                txtCUST_IMP_NM.text = object[2];
            } 
            if(ind == "5")
            {
                txtCUST_PAID_PK.text = object[0];
                txtCUST_PAID_ID.text = object[1];
                txtCUST_PAID_NM.text = object[2];
            } 
         }
     }        
}
function OnResetCust(ind)
{
    if(ind == "1")
    {
        txtCUST_PK.text = "";
        txtCUST_ID.text = "";
        txtCUST_NM.text = "";
    }
    if(ind == "2")
    {
        txtCUST_OFF_PK.text = "";
        txtCUST_OFF_ID.text = "";
        txtCUST_OFF_NM.text = "";
    }        
    if(ind == "3")
    {
        txtCUST_SHIP_PK.text = "";
        txtCUST_SHIP_ID.text = "";
        txtCUST_SHIP_NM.text = "";
    } 
    if(ind == "4")
    {
        txtCUST_IMP_PK.text = "";
        txtCUST_IMP_ID.text = "";
        txtCUST_IMP_NM.text = "";
    } 
    if(ind == "5")
    {
        txtCUST_PAID_PK.text = "";
        txtCUST_PAID_ID.text = "";
        txtCUST_PAID_NM.text = "";
    } 
    
}

function SelectAfterEdit()
{
	curRow = grdMaster.row;
	
	if (event.col == 8)
    {
		txtcur.text = grdMaster.GetGridData(curRow, 8);
		txt_date.text = grdMaster.GetGridData(curRow, 7);
		GetRate();
				
	}
	if (event.col == 14)
    {
		var tr_famt = 0;
		var tr_amt = 0;
		var tr_rate = Number(grdMaster.GetGridData(curRow, 9));
		var bk_rate = Number(grdMaster.GetGridData(curRow, 10));
		tr_famt = Number(grdMaster.GetGridData(curRow, 14));
		if(bk_rate == 0)
		{
			bk_rate = 1;
		}
		tr_amt = Math.round(tr_famt * tr_rate / bk_rate);
		net_tax = Math.round(tr_famt * tr_rate);
		grdMaster.SetGridText(curRow, 15,"" + tr_amt);
		grdMaster.SetGridText(curRow, 16,"" + net_tax);
		
    }
    if (event.col == 17)
    {
		var ex_famt = 0;
		var ex_amt = 0;
		var tr_rate = Number(grdMaster.GetGridData(curRow, 9));
		var bk_rate = Number(grdMaster.GetGridData(curRow, 10));
		ex_famt = Number(grdMaster.GetGridData(curRow, 17));
		if(bk_rate == 0)
		{
			bk_rate = 1;
		}
		ex_amt = Math.round(ex_famt * tr_rate / bk_rate);
		ex_tax = Math.round(ex_famt * tr_rate);
		grdMaster.SetGridText(curRow, 18,"" + ex_amt);
		grdMaster.SetGridText(curRow, 19,"" + ex_tax);
		
    }
    if (event.col == 20)
    {
		var tr_rate = Number(grdMaster.GetGridData(curRow, 9));
		var bk_rate = Number(grdMaster.GetGridData(curRow, 10));
		if(bk_rate == 0)
		{
			bk_rate = 1;
		}
		var tr_famt = Number(grdMaster.GetGridData(curRow, 14));
		var ex_famt = Number(grdMaster.GetGridData(curRow, 17));
		vat_net_amt = tr_famt + ex_famt;
		vat_rate = Number(grdMaster.GetGridData(curRow, 20));
		ccy = grdMaster.GetGridData(curRow, 8);
		if(ccy == "VND")
		{
			vat_famt = Math.round(vat_net_amt * vat_rate /100);
		}
		else
		{
			vat_famt = Math.round(vat_net_amt * vat_rate)/100;
		}
		
		var vat_amt  = Math.round(vat_famt * tr_rate / bk_rate);
		var tax_vat = Math.round(vat_famt * tr_rate);
		grdMaster.SetGridText(curRow, 21,"" + vat_famt);
		grdMaster.SetGridText(curRow, 22,"" + vat_amt);
		grdMaster.SetGridText(curRow, 23,"" + tax_vat);
    }
}

function RowMasterClick()
{
	curRow = grdMaster.selrow ;
	txt_PK.text = grdMaster.GetGridData(curRow,1);
	txtTR_RATE.text = grdMaster.GetGridData(curRow,9);
	txtBK_RATE.text = grdMaster.GetGridData(curRow,10);
	RefeshButton(grdMaster.GetGridData(curRow,35));
	EnableTab(true);
	onSearchTab();
	
}
function OnPoupClick()
{
   // alert(event.col);
	curRow = grdMaster.row ;
	if (event.col == 25 || event.col == 26) 
    {
        Popup_Trans()
    }
    else if (event.col == 28 || event.col == 29) 
    {
        Popup_Acc();
    }

}
function Popup_Trans()
{
    var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCOMPANY.GetData();
    aValue = System.OpenModal( path ,850 , 500 ,  'resizable:yes;status:yes');
    if ( aValue != null )
	{
		var tmp = aValue[0];
		if (tmp[1] != null)
		{
		    grdMaster.SetGridText(curRow, 24, tmp[0]);
            grdMaster.SetGridText(curRow, 25, tmp[1]);
            grdMaster.SetGridText(curRow, 26, tmp[2]);
        }
    }
}

function Popup_Acc()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "131" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCOMPANY.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;'); 
    if (o != null)
    {
        if(o[0] != 0)
        {
            grdMaster.SetGridText(curRow, 27, o[3]);
            grdMaster.SetGridText(curRow, 28, o[0]);
            grdMaster.SetGridText(curRow, 29, o[1]);
        }
    }
}

function GetRate()
{
    dso_get_rate.Call();
        
}
function SetExRate(i)
{
	grdMaster.SetGridText(i, 9, txtTR_RATE.text);
	grdMaster.SetGridText(i, 10, txtBK_RATE.text);
}
//--Detail
function OnShowTakeOut()
{
	
	if(curRow > 0)
	{
		var wWidth = 800;
		var wHeight = 400;
		var x = Math.round((screen.availWidth - wWidth)/2);
		var y = Math.round((screen.availHeight - wHeight)/2);
		var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +"lef="+ x +",top=" + y;
	        
		var fpath = System.RootURL + '/form/gf/ca/gfca00010_takeout_popup.aspx';
		var object = System.OpenModal(fpath, wWidth, wHeight, features);     
	    if ( object != null ) 
	    {
			if ( object[0] != null )  
			{
				grdMaster.SetGridText(curRow, 34, object[0]);
				txtTSA_SOTAKEOUT_PK.text = object[0];
				txtTSA_SOTAKEOUTD_PK.text = object[1];
				txtCUST_OFF_PK.text = object[2];	
                txtCUST_OFF_ID.text = object[3];
                txtCUST_OFF_NM.text = object[4];
                txtCUST_SHIP_PK.text = object[5];
                txtCUST_SHIP_ID.text = object[6];
                txtCUST_SHIP_NM.text = object[7];
                txtCUST_IMP_PK.text = object[8];
                txtCUST_IMP_ID.text = object[9];
                txtCUST_IMP_NM.text = object[10];
                txtCUST_PAID_PK.text = object[11];
                txtCUST_PAID_ID.text = object[12];
                txtCUST_PAID_NM.text = object[13];
			}
			//dso_upd_ctl_cust.Call("SELECT");
		} 
	}
	
}

function onSearchTab()
{
    if (grdMaster.rows > 1) 
	{
	    if (curRow == 0 || curRow == grdMaster.rows)
		{
			curRow = 1;
		}
		
		grdMaster.selrow = curRow;
		txt_PK.text = grdMaster.GetGridData(curRow, 1);
		
	}
	else
	{
		curRow = 0;
		txt_PK.text = "";
	}
   if (idTab_Detail.GetCurrentPageNo() == 0)
    {
        if (click_tab0 == true)
        {
			EnableTab(true);
            click_tab0 = false;
            //if(txt_PK.text != "")
            //{
                dso_sel_ctl_cust.Call("SELECT");
			//}
        }
    }
    if (idTab_Detail.GetCurrentPageNo() == 1)
    {
		if (click_tab1 == true)
        {
            EnableTab(true);
            click_tab1 = false;
            dso_upd_tac_crcad_item.Call("SELECT");
        }
    }

    if (idTab_Detail.GetCurrentPageNo() == 2)
    {
		if (click_tab3 == true)
        {
            EnableTab(true);
            click_tab3 = false;
            dso_upd_tac_crcad_vat.Call("SELECT");
        }
    }
    if (idTab_Detail.GetCurrentPageNo() == 3)
    {
		if (click_tab4 == true)
        {
            EnableTab(true);
            click_tab4 = false;
            dso_upd_tac_crcad_abpl.Call("SELECT");
        }
    }
}
function EnableTab(bool)
{
    click_tab0 = bool;
    click_tab1 = bool;
    click_tab2 = bool;
    click_tab3 = bool;
    click_tab4 = bool;
}
function OnUpdateMasterPK(ind)
{
	if(ind == 1)
	{
		var ctrl = grdDtlItem.GetGridControl();
		for(i=1; i< ctrl.rows;i++)
		{
			grdDtlItem.SetGridText(i,0, txt_PK.text);
		}
	}

}
function OnGetItem()
{
	txtTSA_SOTAKEOUT_PK.text = grdMaster.GetGridData(curRow,34);
	
//	if(txtTSA_SOTAKEOUT_PK.text == "" && txtTSA_SOTAKEOUTD_PK.text =="")
//	{
//		alert("Please select Declare list");
//	}
//	else
//	{
		if(grdDtlItem.rows > 1)
		{
			alert("This voucher have selected item");
			return;
		}
		//if(txtTSA_SOTAKEOUT_PK.text != "")
		else
		{
			var wWidth = 900;
			var wHeight = 450;
			var x = Math.round((screen.availWidth - wWidth)/2);
			var y = Math.round((screen.availHeight - wHeight)/2);
			var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +"lef="+ x +",top=" + y;
		    var fpath = System.RootURL + '/form/gf/ca/gfca00010_takeout_popup.aspx?compk='+ lstCOMPANY.value;   
			//var fpath = System.RootURL + '/form/gf/ca/gfca00020_export_detail.aspx' + '?decl_pk=' + txtTSA_SOTAKEOUT_PK.text;
			var object = System.OpenModal(fpath, wWidth, wHeight, features);     
			if ( object != null ) 
			{
			    
//				if ( object[0] != null )  
//				{
					txtTSA_SOTAKEOUTD_PK.text = object;
					dso_new_tac_crcad_item.Call("SELECT");
//				}
				
			} 
		}

}
function OnNewItem()
{
    if(lstGETDATA.value =="ED")
    {
        //Nhập trực tiếp Item
        grdDtlItem.AddRow();
    
    }
    if(lstGETDATA.value =="PO")
    {
        //Lấy từ PO
        if(grdDtlItem.rows > 1)
		{
			alert("This voucher have selected item");
			return;
		}
		OnGetItem();
        //dso_new_tac_crcad_item.Call("SELECT");
    }
}
function OnSaveItem()
{
	var ctrl = grdDtlItem.GetGridControl();
	for(i=1; i< ctrl.rows;i++)
	{
		if(grdDtlItem.GetGridData(i,15)=="")
		{
			alert("Input account at row " + i);
			return;
		}
		if(grdDtlItem.GetGridData(i,1)=="")
		{
			grdDtlItem.SetRowStatus(i, 0x20);
		}
		else
		{
			grdDtlItem.SetRowStatus(i, 0x10);
		}
		
	}
	save_click_dtl = true;
	dso_upd_tac_crcad_item.Call();

}
function OnDeleteItem()
{
	if(confirm("Do you want to delete this item?"))
	{
		if(grdDtlItem.selrow < 1)
		{
			alert("Select item to delete!");
			return;
		}
		else
		{
			grdDtlItem.SetRowStatus(grdDtlItem.selrow, 0x40);	
			dso_upd_tac_crcad_item.Call();
		}
	}

}
function EditDtlItem()
{
	
	curRowDtl = grdDtlItem.selrow;
	var tr_rate = Number(grdMaster.GetGridData(curRow,9));
	var bk_rate = Number(grdMaster.GetGridData(curRow,10));
	if(bk_rate == 0)
	{
		bk_rate = 1;
	}
//	if(event.col == 8)
//	{
//	    var u_price = Number(grdDtlItem.GetGridData(curRowDtl,8));
//		var qty  = Number(grdDtlItem.GetGridData(curRowDtl,9));
//		var to_ccy = grdDtlItem.GetGridData(curRowDtl,21);
//		var to_ex_rate = grdDtlItem.GetGridData(curRowDtl,22);
//		
//	}
    if(event.col == 8)
	{
	    OnUpdateRowItem(curRowDtl);
	}
	if(event.col == 9)
	{
	    OnUpdateRowItem(curRowDtl);
	}
	if(event.col == 11)
	{
		var ex_price = Number(grdDtlItem.GetGridData(curRowDtl,10));
		var retouch  = Number(grdDtlItem.GetGridData(curRowDtl,11));
		var tr_amt = ex_price + retouch;
		ccy = lstBOOK_CCY.text;
		var bk_amt = FormatCalculate(ccy,(tr_amt * tr_rate /bk_rate));
		
		grdDtlItem.SetGridText(curRowDtl,12,"" + tr_amt);
		grdDtlItem.SetGridText(curRowDtl,13,"" + bk_amt);
		OnUpdateAmtItem();
	}
	
}
function OnUpdateRowItem(i)
{
    var tr_rate = Number(grdMaster.GetGridData(curRow,9));
	var bk_rate = Number(grdMaster.GetGridData(curRow,10));
	if(bk_rate == 0)
	{
		bk_rate = 1;
	}
	var price = Number(grdDtlItem.GetGridData(i,8));
	var qty = Number(grdDtlItem.GetGridData(i,9));
	var touch_amt = Number(grdDtlItem.GetGridData(i,11));
	var amount = price * qty;
	
	grdDtlItem.SetGridText(i,10,"" + amount);
	var tr_amt = touch_amt + amount;
	var bk_amt = Math.round(tr_amt * tr_rate / bk_rate);
	grdDtlItem.SetGridText(i,12,"" + tr_amt);
	grdDtlItem.SetGridText(i,13,"" + bk_amt);
	OnUpdateAmtItem();
}

function OnUpdateAmtItem()
{
	var ctrl = grdDtlItem.GetGridControl();
	var sum_tr_amt = 0;
	var sum_bk_amt = 0;
	var tr_amt = 0;
	var bk_amt = 0;
	for(i=1; i< ctrl.rows;i++)
	{
		tr_amt = Number(grdDtlItem.GetGridData(i,12));
		bk_amt = Number(grdDtlItem.GetGridData(i,13));
		sum_tr_amt = sum_tr_amt + tr_amt;
		sum_bk_amt = sum_bk_amt + bk_amt;
	}
	
	txtITEM_TR_AMT.SetDataText("" + sum_tr_amt);
	txtITEM_BK_AMT.SetDataText("" + sum_bk_amt);
	
	grdMaster.SetGridText(curRow,14,""+sum_tr_amt);
	grdMaster.SetGridText(curRow,15,""+sum_bk_amt);
	grdMaster.SetGridText(curRow,16,""+sum_bk_amt);
}

function ItemRowClick()
{
	curRowDtl = grdDtlItem.selrow;
	if(event.col == 5 || event.col == 6)
	{
		Popup_Item();
	}
    if(event.col == 16 || event.col ==17)
	{
		DetailAcc(1);
	}
}

function Popup_Item()
{
    var i = 0;
    var fpath   = System.RootURL + "/form/gf/co/gfco002006_item.aspx?comp_pk=" + lstCOMPANY.GetData();
    aValue      = System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	
    if ( aValue != null ) 
    {
        if (aValue.length > 0)
        {
            for (i = 0; i< aValue.length; ++i)
            {
                
                var tmp = Array();
                tmp = aValue[i];
                
                if (tmp[0] != 0)
                {
                    if(i != 0)
                    {
                        grdDtlItem.AddRow();
                    }
                    grdDtlItem.SetGridText(grdDtlItem.selrow + i, 4, tmp[0]);     // PK
                    grdDtlItem.SetGridText(grdDtlItem.selrow + i, 5, tmp[1]);     // Item Name
                    grdDtlItem.SetGridText(grdDtlItem.selrow + i, 6, tmp[2]);     // Item Name Local
                    grdDtlItem.SetGridText(grdDtlItem.selrow + i, 7, tmp[3]);     // Unit
                    grdDtlItem.SetGridText(grdDtlItem.selrow + i, 0, txt_PK.text);     // Unit
                }
            }

            txtSEQ.GetControl().focus();
        }
    }
    else
    {
        txtSEQ.GetControl().focus();
    }
    
}

//---------VAT proess----------------
function OnSaveVAT()
{
	var ctrl = grdDtlVAT.GetGridControl();
	for(i=1; i< ctrl.rows;i++)
	{
		if(grdDtlVAT.GetGridData(i,12)=="")
		{
			alert("Input account at row " + i);
			return;
		}
		grdDtlVAT.SetRowStatus(i, 0x10);
		
	}
	save_click_dtl = true;
	dso_upd_tac_crcad_vat.Call();

}

function EditDtlVAT()
{
	curRowDtl = grdDtlVAT.selrow;
	if(event.col == 6)
	{
		
		var net_amt = grdDtlVAT.GetGridData(curRowDtl,5);
		var tax_rate = grdDtlVAT.GetGridData(curRowDtl,6);
		ccy = lstBOOK_CCY.text;
		tr_ccy = grdMaster.GetGridData(curRow,8);
		var tr_rate = Number(grdMaster.GetGridData(curRow,9));
		var bk_rate = Number(grdMaster.GetGridData(curRow,10));
		
		if(bk_rate == 0)
		{
			bk_rate = 1;
		}
		tax_amt = FormatCalculate(tr_ccy,(net_amt * tax_rate/100));
		
		grdDtlVAT.SetGridText(curRowDtl,7,"" + tax_amt);
		var adj_amt = Number(grdDtlVAT.GetGridData(curRowDtl,8));
		var tr_amt = tax_amt + adj_amt;
		var bk_amt = FormatCalculate(ccy,(tr_amt * tr_rate /bk_rate));
		var vat = FormatCalculate("VND",(tr_amt * tr_rate));
		grdDtlVAT.SetGridText(curRowDtl,9,"" + tr_amt);
		grdDtlVAT.SetGridText(curRowDtl,10,"" + bk_amt);
		grdDtlVAT.SetGridText(curRowDtl,11,"" + vat);
	}
	if(event.col == 8)
	{
		var ccy = lstBOOK_CCY.text;
		var tr_rate = Number(grdMaster.GetGridData(curRow,9));
		var bk_rate = Number(grdMaster.GetGridData(curRow,10));
		if(bk_rate == 0)
		{
			bk_rate = 1;
		}
		var adj_amt = Number(grdDtlVAT.GetGridData(curRowDtl,8));
		var tax_amt = Number(grdDtlVAT.GetGridData(curRowDtl,7));
		var tr_amt = tax_amt + adj_amt;
		var bk_amt = FormatCalculate(ccy,(tr_amt * tr_rate /bk_rate));
		var vat = FormatCalculate("VND",(tr_amt * tr_rate));
		grdDtlVAT.SetGridText(curRowDtl,9,"" + tr_amt);
		grdDtlVAT.SetGridText(curRowDtl,10,"" + bk_amt);
		grdDtlVAT.SetGridText(curRowDtl,11,"" + vat);
	}
	OnUpdateAmtVAT();
}
function OnUpdateAmtVAT()
{

	var ctrl = grdDtlVAT.GetGridControl();
	var sum_tr_amt = 0;
	var sum_bk_amt = 0;
	var tr_amt = 0;
	var bk_amt = 0;
	var vat_rate ="";
	for(i=1; i< ctrl.rows;i++)
	{
	    vat_rate = grdDtlVAT.GetGridData(1, 6);
		tr_amt = Number(grdDtlVAT.GetGridData(i,9));
		bk_amt = Number(grdDtlVAT.GetGridData(i,10));
		sum_tr_amt = sum_tr_amt + tr_amt;
		sum_bk_amt = sum_bk_amt + bk_amt;
	}
	
	txtVAT_TR_AMT.SetDataText("" + sum_tr_amt);
	txtVAT_BK_AMT.SetDataText("" + sum_bk_amt);
	grdMaster.SetGridText(curRow,20,vat_rate);
	grdMaster.SetGridText(curRow,21,""+sum_tr_amt);
	grdMaster.SetGridText(curRow,22,""+sum_bk_amt);
	grdMaster.SetGridText(curRow,23,""+sum_bk_amt);

}
function VATRowClick()
{
	curRowDtl = grdDtlVAT.selrow;
	if(event.col == 13 || event.col ==14)
	{
		DetailAcc(3);
	}

}

// --PL Process---
function OnSavePL()
{
	var ctrl = grdDtlABPL.GetGridControl();
	for(i=1; i< ctrl.rows;i++)
	{
		
		grdDtlABPL.SetRowStatus(i, 0x10);
		
	}
	save_click_dtl = true;
	dso_upd_tac_crcad_abpl.Call();

}


function PLRowClick()
{
	curRowDtl = grdDtlABPL.selrow;
	if(event.col == 6 || event.col == 7)
	{
		var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCOMPANY.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
        var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
        if ( object != null )  
        {
            if (object[0] != 0)
            {
                grdDtlABPL.SetGridText(curRowDtl, 5, object[2]);     // PK
                grdDtlABPL.SetGridText(curRowDtl, 6, object[0]);     // Item Code
                grdDtlABPL.SetGridText(curRowDtl, 7, object[1]);     // Item Name Local
            }
            txtSEQ.GetControl().focus();
        }
        else
        {
            txtSEQ.GetControl().focus();
        }
	}

}
// Control Item Process
function OnNewCtrl()
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
	grdInfor.SetGridText(grdInfor.rows - 1, 7, txt_PK.GetData());
}

function OnSaveCtrl()
{
    var fg = grdInfor.GetGridControl();
    for (i = 1; i < grdInfor.rows; i++)
    {
        grdInfor.SetGridText(i, 7, txt_PK.GetData());
    }
	dso_upd_crca_ctrlitem.Call();
}

function OnDeleteCtrl()
{
    var ctrl = grdInfor.GetGridControl();
    if (grdInfor.rows > 1)
    {
        var i = 1;
        var j = 1;
        
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

function DBPopupClickInfor()
{
    if ((event.col == 2) || (event.col == 3))
    {
		var path   = System.RootURL + "/form/gf/co/gfco002006.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + '' + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCOMPANY.GetData() + "&dsqlid=ACNT.SP_SEL_POPUP_ITEM_N" + '&col_code=Item Name' + '&col_nm=Item Name Local';
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
        		        if (tmp[2] == 'SERIAL NO')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 11));
		                }
		                if (tmp[2] == 'INVOICE DATE')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 12));
		                }
		                if (tmp[2] == 'INVOICE NO')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 13));
		                }
		                else if (tmp[2] == 'TAX RATE')
		                {
		                    var l_tax = grdMaster.GetGridData(grdMaster.selrow, 18);
		                    if ((l_tax == '01') || (l_tax == 'NO'))
		                    {
		                        return;
                            }
                            else
                            {
                                grdInfor.SetGridText(grdInfor.selrow + i, 6, Number(grdMaster.GetGridData(grdMaster.selrow, 18)) + '%');
                            }
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
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 13));
		                }
		                if (tmp[2] == 'INVOICE DATE')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 12));
		                }
		                if (tmp[2] == 'SERIAL NO')
		                {
		                    grdInfor.SetGridText(grdInfor.selrow + i, 6, grdMaster.GetGridData(grdMaster.selrow, 11));
		                }
		                else if (tmp[2] == 'TAX RATE')
		                {
		                    var l_tax = grdMaster.GetGridData(grdMaster.selrow, 18);
		                    if ((l_tax == '01') || (l_tax == 'NO'))
		                    {
		                        return;
                            }
                            else
                            {
                                grdInfor.SetGridText(grdInfor.selrow + i, 6, Number(grdMaster.GetGridData(grdMaster.selrow, 18)) + '%');
                            }
		                }
                    }
                }
                txtSEQ.GetControl().focus();
            }
            
        }
	}
	else if (event.col == 6)
	{
	    onDBList();
	}
}

function onDBList()
{
    var ctrl = grdInfor.GetGridControl();
    if ((grdInfor.GetGridData( ctrl.row, 4) == 'M') || (grdInfor.GetGridData(ctrl.row, 4) == 'C'))
	{
		if (grdInfor.GetGridData( ctrl.row, 4) == 'C')
		{
		    var ls_str = grdInfor.GetGridData(ctrl.row, 2);
			var temp = new Array();
            temp = ls_str.split(' ');
			var ls_temp = temp[0];
			
			var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + ls_str + "&company=" + lstCOMPANY.GetData() + '&dsqlid=ACNT.SP_SEL_ITEMNM_POPUP&col_code=' + ls_temp +" CODE" + '&col_nm=' + ls_temp + " NAME";
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    grdInfor.SetGridText(ctrl.row, 6, object[0]);
                    grdInfor.SetGridText(ctrl.row, 8, object[2]);
                    //grdInfor.SetGridText(ctrl.row, 9, object[1]);
                }
            }
        }
        else
        {
			if (grdInfor.GetGridData( ctrl.row, 2) == "CUSTOMER  NAME")
	        {
				var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		        var object  = System.OpenModal( path ,800 , 550 , 'resizable:yes;status:yes');
		        if ( object != null )
		        {
		            if (object[0] != 0)
                    {
		                grdInfor.SetGridText(ctrl.row, 6,object[1] );
		                grdInfor.SetGridText(ctrl.row, 8,object[0]);
		                
		                grdInfor.SetGridText(ctrl.row, 9, object[2] );
		            }
                }
            }
            else if ( grdInfor.GetGridData(ctrl.row, 2)== "Bank Account No." || grdInfor.GetGridData( ctrl.row, 2 )== "DEPOSIT ACCOUNT NO" || grdInfor.GetGridData( ctrl.row, 2 )== "BANK ACCOUNT NUMBER" || grdInfor.GetGridData( ctrl.row, 2 )== "BANK ACCOUNT NO.")
	        {
	            var ls_ccy = txtcur.GetData();
	            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + ls_ccy + "&company="+ lstCOMPANY.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
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
///
function OnDataReceive(obj)
{
	if(obj.id =="dso_upd_tac_crca")
	{
	    lblRECORD.text = grdMaster.rows -1;
	    if(grdMaster.rows <= 1)
	    {
	        txt_PK.text = "";
	    }
	    if(save_click)
		{
			txt_PK.text = grdMaster.GetGridData(curRow,1);
			dso_sel_ctl_cust.StatusUpdate();
			dso_sel_ctl_cust.Call();
			save_click = false;
		}
		
		EnableTab(true);
		onSearchTab();
		MergeMaster();
		
	}
	if(obj.id =="dso_upd_tac_crcad_item")
	{
	    SetNumGridItem();
		OnUpdateAmtItem();
		if(save_click_dtl)
		{
			grdMaster.SetRowStatus(curRow,0x10);
			dso_upd_tac_crca.Call();
		}
		save_click_dtl = false;
	}
	if(obj.id =="dso_upd_tac_crcad_tax")
	{
	    SetNumGridTAX();
		OnUpdateAmtTAX();
		if(save_click_dtl)
		{
			grdMaster.SetRowStatus(curRow,0x10);
			dso_upd_tac_crca.Call();
		}
		save_click_dtl = false;
	}
	if(obj.id =="dso_upd_tac_crcad_vat")
	{
	    //alert(save_click_dtl);
	    SetNumGridVAT();
		OnUpdateAmtVAT();
		if(save_click_dtl)
		{
			grdMaster.SetRowStatus(curRow,0x10);
			dso_upd_tac_crca.Call();
		}
		save_click_dtl = false;
	}
	if(obj.id =="dso_sel_ctl_cust")
	{
	    if(grdMaster.rows <= 1)
	    {
	        txt_PK.text = "";
	    }
	    dso_upd_crca_ctrlitem.Call("SELECT");
	}
	if(obj.id == "dso_upd_crca_confirm")
	{
		dso_upd_tac_crca.Call("SELECT");
	}
	if(obj.id =="dso_upd_crca_confirmcancel")
	{
	    dso_upd_tac_crca.Call("SELECT");
	}
	if(obj.id =="dso_upd_crca_replicate")
	{
	    dso_upd_tac_crca.Call("SELECT");
	}
}
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
function DetailAcc(ind)
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" +  "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCOMPANY.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;'); 
    if (o != null)
    {
        if(o[0] != 0)
        {
			
			if(ind == 1)
			{
				var ctrl = grdDtlItem.GetGridControl()
				for(i=1;i<ctrl.rows;i++)
				{
					grdDtlItem.SetGridText(i, 15, o[3]);
					grdDtlItem.SetGridText(i, 16, o[0]);
					grdDtlItem.SetGridText(i, 17, o[1]);
				}
					
			}
			if(ind == 3)
			{
				var ctrl = grdDtlVAT.GetGridControl()
				for(i=1;i<ctrl.rows;i++)
				{
					grdDtlVAT.SetGridText(curRowDtl, 12, o[3]);
					grdDtlVAT.SetGridText(curRowDtl, 13, o[0]);
					grdDtlVAT.SetGridText(curRowDtl, 14, o[1]);
				}
				
			}
        }
    }
}

</script>
<body style="margin:0; padding:0;">
<gw:data id="dso_get_rate" onreceive="SetExRate(curRow)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCOMPANY"/>
                     <input bind="txtcur"/>
                     <input bind="txt_date"/>
                </input>
                <output>
                     <output bind="txtTR_RATE"/>
                     <output bind="txtBK_RATE"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
<gw:data id="dso_upd_tac_crca" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,27,30,31,32,33"  function="ACNT.SP_SELECT_TAC_CRCA_DO" procedure="ACNT.SP_PRO_UPD_TAC_CRCA_DO">
                <input bind="grdMaster">
                    <input bind="txtSEQ"/>
                    <input bind="lstCOMPANY"/>
                    <input bind="txtFROM_DATE"/>
                    <input bind="txtTO_DATE"/>
                    <input bind="lstVOUCHER_TYPE"/>
                    <input bind="txtVOUCHER_NO"/>
                    <input bind="txtINVOICE_NO"/>
                    <input bind="txtTR_TYPE"/>
                    <input bind="txtCUST_PK"/>
                    <input bind="rdoSTATUS"/>
                </input>
                <output bind="grdMaster"/>
            </dso> 
        </xml>
    </gw:data>

<gw:data id="dso_upd_crca_confirm" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CRCA_CONFIRM" > 
                <input> 
                     <input bind="txtCRCA_PK"/>
                     <input bind="txtNUM_PK"/>
                </input>
                <output>
                     <output bind="txtStatus"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>
        
<gw:data id="dso_upd_crca_confirmcancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CRCA_CONFIRMCANCEL">
                <input> 
                     <input bind="txtCRCA_PK"/>
                     <input bind="txtNUM_PK"/>
                </input>
                <output>
                     <output bind="txtStatus"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>
 <gw:data id="dso_upd_crca_replicate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CRCA_REPLCATE">
                <input> 
                     <input bind="txtCRCA_PK"/>
                     <input bind="txtNUM_PK"/>
                </input>
                <output>
                     <output bind="txtStatus"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>
     
<gw:data id="dso_upd_tac_crcad_item" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,8,9,10,11,12,13,14,15,18,19,20"  function="ACNT.SP_SELECT_TAC_CRCA_OS_ITEM" procedure="ACNT.SP_UPD_TAC_CRCA_OS_ITEM">
                <input bind="grdDtlItem">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdDtlItem"/>
            </dso> 
        </xml>
    </gw:data>
    
<gw:data id="dso_new_tac_crcad_item" onreceive="OnUpdateMasterPK(1)">
        <xml>
            <dso type="grid" function="ACNT.SP_SELECT_CRCA_FROM_TAKEOUT">
                <input bind="grdDtlItem">
                    <input bind="txtTSA_SOTAKEOUTD_PK"/>
                </input>
                <output bind="grdDtlItem"/>
            </dso> 
        </xml>
    </gw:data> 
 
 <!--gw:data id="dso_upd_tac_crcad_tax" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="1,6,7,8,9,10"  function="ACNT.SP_SELECT_TAC_CRCA_OS_TAX" procedure="ACNT.SP_UPD_TAC_CRCA_OS_TAX">
                <input bind="grdDtlTAX">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdDtlTAX"/>
            </dso> 
        </xml>
    </gw:data-->      
  <gw:data id="dso_upd_tac_crcad_vat" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="1,6,7,8,9,10,11,12"  function="ACNT.SP_SELECT_TAC_CRCA_OS_VAT" procedure="ACNT.SP_UPD_TAC_CRCA_OS_VAT">
                <input bind="grdDtlVAT">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdDtlVAT"/>
            </dso> 
        </xml>
    </gw:data> 
    
  <gw:data id="dso_sel_ctl_cust" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,4,7,10"  function="ACNT.SP_SELECT_TAC_CRCA_OS_CUST"  procedure="ACNT.SP_UPD_TAC_CRCA_OS_CUST">
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txtCUST_OFF_PK"/>
                <inout bind="txtCUST_OFF_ID"/>
                <inout bind="txtCUST_OFF_NM"/>
                <inout bind="txtCUST_SHIP_PK"/>
                <inout bind="txtCUST_SHIP_ID"/>
                <inout bind="txtCUST_SHIP_NM"/>
                <inout bind="txtCUST_IMP_PK"/>
                <inout bind="txtCUST_IMP_ID"/>
                <inout bind="txtCUST_IMP_NM"/>
                <inout bind="txtCUST_PAID_PK"/>
                <inout bind="txtCUST_PAID_ID"/>
                <inout bind="txtCUST_PAID_NM"/>
            </inout> 
        </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_upd_crca_ctrlitem" onreceive="">
        <xml>
            <dso type="grid" parameter="0,1,4,5,6,7,8,9" function="ACNT.SP_SEL_CRCA_CTRLITEM" procedure="ACNT.SP_UPD_CRCA_CTRLITEM">
                <input bind="grdInfor">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdInfor"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_upd_tac_crcad_abpl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="1,5"  function="ACNT.SP_SELECT_TAC_CRCA_OS_ABPL" procedure="ACNT.SP_UPD_TAC_CRCA_OS_ABPL">
                <input bind="grdDtlABPL">
                    <input bind="txt_PK"/>
                </input>
                <output bind="grdDtlABPL"/>
            </dso> 
        </xml>
    </gw:data> 
<!------------------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="1">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="8%"></td>
                    <td width="12%"></td>
                    <td width="8%"></td>
                    <td width="12%"></td>
                    <td width="8%"></td>
                    <td width="10%"></td>
                    <td width="7%"></td>
                    <td width="6%"></td>
                    <td width="6%"></td>
                    <td width="6%"></td>
                    <td width="6%"></td>
                    <td width="6%"></td>
                </tr>
                <tr>
                    <td align="right"><b>Company&nbsp;</b></td>
                    <td ><gw:list id="lstCOMPANY" styles='width:100%' /></td>
                    <td align="right"><b>Voucher Type&nbsp;</b></td>
                    <td ><gw:list id="lstVOUCHER_TYPE" styles='width:100%' /></td>
                    <td align="right"><b>Voucher No&nbsp;</b></td>
                    <td ><gw:textbox id="txtVOUCHER_NO"  styles='width:100%;height:22'/></td>
                    <td align="right"><b>Seq&nbsp;</b></td>
                    <td ><gw:textbox id="txtSEQ"  styles='width:100%;height:22'/></td>
                    <td align="center"><gw:imgBtn id="ibtnSearch" img="Search"  alt="Search"  onclick="OnSearch()"/></td>
                    <td><gw:icon id="btnNew"    img="in" text="New"   onclick="OnNew()"     styles='width:100%' /></td>
                    <td><gw:icon id="btnSave"   img="in" text="Save"   onclick="OnSave()"   styles='width:100%'/></td>
                    <td><gw:icon id="btnDelete" img="in" text="Delete" onclick="OnDelete()" styles='width:100%'/></td>
                </tr>
                <tr>
                    <td align="right"><b>Trans. Date&nbsp;</b></td>
                    <td ><gw:datebox id="txtFROM_DATE" styles='width:100%'  lang="<%=Session("Lang")%>"/></td>
                    <td align="center"><b>~&nbsp;</b></td>
                    <td ><gw:datebox id="txtTO_DATE" styles='width:100%'  lang="<%=Session("Lang")%>"/></td>
                    <td align="right"><b>Invoice No&nbsp;</b></td>
                    <td ><gw:textbox id="txtINVOICE_NO"  styles='width:100%;height:22'/></td>
                    <td align="right"><b>Declaration No&nbsp;</b></td>
                    <td colspan="2"><gw:textbox id="txtDECLARE_NO"  styles='width:100%;height:22'/></td>
                    <td><gw:icon id="btnConfirm"   img="in" text="Confirm" onclick="OnConfirm()" styles='width:100%;height:22' /></td>
                    <td><gw:icon id="btnCancel"    img="in" text="Cancel" onclick="OnCancel()"  styles='width:100%;height:22'/></td>
                    <td><gw:icon id="btnReplicate" img="in" text="Replicate" onclick="OnReplicate()"  styles='width:100%;height:22'/></td>
                </tr>
                <tr>
                    <td align="right"><b>Slip Status&nbsp;</b></td>
                    <td colspan="3"><gw:radio id="rdoSTATUS" value="1" onchange="OnSearch()">
                                    <span value="ALL">All</span>
                                    <span value="1">Save</span>
                                    <span value="2">Confirmed</span>
                                    <span value="0">Approved</span>
                                    <span value="4">NAPP</span>
                                    <span value="3">Cancalled</span>
                                    </gw:radio ></td>
                    <td align="right"><a title="Click here to show Customer" onclick="GetCustomer(1)" href="#tips" ><b>Customer&nbsp;</b></a></td>
                    <td colspan="4">
                        <table width="100% cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td width="95%"><gw:textbox id="txtCUST_PK"  styles='display:none'></gw:textbox>
                                                <gw:textbox id="txtCUST_ID"  styles='width=30%;height:22'></gw:textbox>
                                                <gw:textbox id="txtCUST_NM"  styles='width=70%;height:22'></gw:textbox>
                                </td>
                                <td width="4%"><gw:imgBtn id="ibtnResetCustomer" img="reset"   alt="reset"         onclick="OnResetCust(1)"/></td>
                            </tr>
                        </table>
                    </td>    
                    <td align="right"><font color="red"><b>Total:&nbsp;</b></font></td>
                    <td align="center"><font color="red"><b><gw:label id="lblRECORD" text="0" /></b></font></td>
                    <td ><font color="red"><b>&nbsp;Records</b></font></td>
                </tr>
                <tr>
                    <td align="right"><b>Person&nbsp;</b></td>
                    <td colspan="3"><gw:textbox id="txtPERSON" styles='width:100%' /></td>
                    <td></td>
                    <td></td>
                    <td align="right"><b>VAT Currency&nbsp;</b></td>
                    <td><gw:list id="lstVAT_CCY" styles='width:100%' /></td>    
                    <td><gw:textbox id="txtVAT_RATE" type="number" format="###,###R" styles="text-align:right;width:100%;height:22" /></td>
                    <td align="right"><b>Book CCY&nbsp;</b></td>
                    <td><gw:list id="lstBOOK_CCY" styles='width:100%'>
						<data><%=ESysLib.SetListDataSQL("SELECT a.code, a.code FROM comm.tco_abcode a, comm.tco_abcodegrp b WHERE a.del_if = 0 AND b.del_if = 0 AND a.tco_abcodegrp_pk = b.pk AND b.ID = 'ACBG0040' AND a.use_if = 1 and a.DEF_YN ='Y'")%></data></gw:list></td>    
                    <td><gw:textbox id="txtBK_RATE" type="number" format="###,###R" styles="text-align:right;width:100%;height:22" /></td>
                </tr>
            </table>
        
        </td>
    </tr>
    <tr>
        <td>
            <gw:grid
            id="grdMaster"
            header  ="CHK|PK|SEQ|VOU. TYPE|||VOUCHER NO|DATE|CCY|RATE|_BK RATE|SERIAL NO|INVOICE DATE|Invoice No|Trans|Books|Net Tax|_Exp TAX|_Exp TAX|_ExpTax Net|VAT Rate|VAT Trans|VAT Book|TAX VAT|_Tr_pk|Trs Code|Trs Name|_Acc_pk|AC_CD|AC_NM|English|Local|Korean|_Com_pk(33)|TSA_SOTAKEOUT_PK|_SEQ_STATUS"
            format  ="3|1|0|0|3|0|2|4|0|1|1|0|4|0|1|1|1|1|1|1|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0"
            aligns  ="0|0|0|0|0|0|0|0|0|3|3|0|0|0|3|3|3|3|3|3|0|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0"
            defaults="||||||||||||||||||||||||||||||||||||"
            editcol ="1|0|0|1|1|1|1|1|1|1|0|1|1|1|1|1|0|1|1|1|1|1|1|1|1|0|0|0|0|0|1|1|1|0|0|0"
            widths  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
            styles  ="width:100%; height:180"
            onafteredit = "SelectAfterEdit()"
            oncelldblclick="OnPoupClick()"
            oncellclick= "RowMasterClick()"
            sorting ="F"/>
        </td>
    </tr>
    
    <!--tr height="22">
        <td>&nbsp;&nbsp;<a title="Click here to list Export Declaration" onclick="OnShowTakeOut()" href="#tips" ><b>Declaration List</b></a></td>
    </tr-->
    <tr>
        <td>
            <gw:tab id="idTab_Detail"  onclick ="onSearchTab()">
                <table name="Control Item"  align ="top"  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:40;">
                    <tr>
                        <td width="10%"></td>
                        <td width="35%"></td>
                        <td width="10%"></td>
                        <td width="35%"></td>
                        <td width="4%"></td>
                        <td width="2%"></td>
                        <td width="2%"></td>
                        <td width="2%"></td>
                    </tr>        
                    <tr>
                        <td align="right"><a title="Click here to show Customer" onclick="GetCustomer(2)" href="#tips" ><b>Customer office&nbsp;</b></a></td>
                        <td>
                            <table width="100% cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="90%"><gw:textbox id="txtCUST_OFF_PK"  styles='display:none'></gw:textbox>
                                                    <gw:textbox id="txtCUST_OFF_ID"  styles='width=30%'></gw:textbox>
                                                    <gw:textbox id="txtCUST_OFF_NM"  styles='width=70%'></gw:textbox>
                                    </td>
                                    <td width="4%"><gw:imgBtn id="ibtnReset2" img="reset"   alt="reset"         onclick="OnResetCust(2)"/></td>
                                </tr>
                            </table>
                        </td>
                        <td align="right"><a title="Click here to show Customer" onclick="GetCustomer(3)" href="#tips" ><b>Ship to&nbsp;</b></a></td>
                        <td>
                            <table width="100% cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="90%"><gw:textbox id="txtCUST_SHIP_PK"  styles='display:none'></gw:textbox>
                                                    <gw:textbox id="txtCUST_SHIP_ID"  styles='width=30%'></gw:textbox>
                                                    <gw:textbox id="txtCUST_SHIP_NM"  styles='width=70%'></gw:textbox>
                                    </td>
                                    <td width="4%"><gw:imgBtn id="ibtnReset3" img="reset"   alt="reset"         onclick="OnResetCust(3)"/></td>
                                </tr>
                            </table>
                        </td>
                        <td></td>
                        <td ><gw:imgBtn id="ibtnNewCtrl"    img="new"       alt="New"           onclick="OnNewCtrl()" /></td>
						<td ><gw:imgBtn id="ibtnSaveCtrl"   img="save"      alt="Save"          onclick="OnSaveCtrl()" /></td>
						<td ><gw:imgBtn id="ibtnDeleteCtrl" img="delete"    alt="Delete"        onclick="OnDeleteCtrl()" /></td>
                    </tr>
                    <tr>
                        <td align="right"><a title="Click here to show Customer" onclick="GetCustomer(4)" href="#tips" ><b>Importer&nbsp;</b></a></td>
                        <td>
                            <table width="100% cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="90%"><gw:textbox id="txtCUST_IMP_PK"  styles='display:none'></gw:textbox>
                                                    <gw:textbox id="txtCUST_IMP_ID"  styles='width=30%'></gw:textbox>
                                                    <gw:textbox id="txtCUST_IMP_NM"  styles='width=70%'></gw:textbox>
                                    </td>
                                    <td width="4%"><gw:imgBtn id="ibtnReset2" img="reset"   alt="reset"         onclick="OnResetCust(4)"/></td>
                                </tr>
                            </table>
                        </td>
                        <td align="right"><a title="Click here to show Customer" onclick="GetCustomer(5)" href="#tips" ><b>Paid to&nbsp;</b></a></td>
                        <td>
                            <table width="100% cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td width="90%"><gw:textbox id="txtCUST_PAID_PK"  styles='display:none'></gw:textbox>
                                                    <gw:textbox id="txtCUST_PAID_ID"  styles='width=30%'></gw:textbox>
                                                    <gw:textbox id="txtCUST_PAID_NM"  styles='width=70%'></gw:textbox>
                                    </td>
                                    <td width="4%"><gw:imgBtn id="ibtnReset5" img="reset"   alt="reset"         onclick="OnResetCust(5)"/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width ="100%" colspan="8">
                            <gw:neogrid  id="grdInfor" styles="width:100%;height:153" oncelldblclick ="DBPopupClickInfor()"> 
						        <XML>
							        <xmlblock>
									
								    <column title="PK" hidden='T'>
									    <textbox type="number" format="######"/>
								    </column>

								    <column title="Item PK" hidden='T'>
									    <textbox type="number" format="######" />
								    </column>

								    <column title="Item Name" width='3500' editmode="0">
									    <textbox />
								    </column>

								    <column title="Item Local Name" width='3500' editmode="0">
									    <textbox />
								    </column>

								    <column title="InType" hidden='T'>
									    <textbox  />
								    </column>

								    <column title="DataType" hidden='T'>
									    <textbox />
								    </column>

								    <column title="Item"  width='3500'>
									    <multiple ref="5">
										    <textbox type="number" format="###,###C" value="" />
										    <textbox format="50" value="" />
										    <datebox type="day" format=""  lang="1" acceptnull="T"/>
										    <checkbox />	
										    <htmledit value="[New]" />				
									    </multiple>
								    </column>
									
								    <column title="Mst_PK" hidden='T'>
									    <textbox/>
								    </column>
									
								    <column title="Item_Table" hidden='T'>
									    <textbox  />
								    </column>
								    
								    <column title="Item_NM" width='3500' editmode="0">
									    <textbox  />
								    </column>

							    </xmlblock>
						    </xml>
					    </gw:neogrid>
                        </td>
                    </tr>
                </table>
                
                <table name="Item Information"  align ="top"  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:40;">
                    <tr>
                        <td width="50%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="11%"></td>
                        <td width="3%"></td>
                        <td width="3%"></td>
                        <td width="3%"></td>
                    </tr>
                    <tr>
                        <td align="left">&nbsp;&nbsp;<a title="Click here to list Item from PO" onclick="OnGetItem()" href="#tips" ><b>Declaration List</b></a></td>        
                        <td align="right" colspan="3"><b>Get AR from</b></td>
                        <td ><gw:list id="lstGETDATA" styles='width:100%'/></td>
						<td ><gw:imgBtn id="ibtnNewItem"    img="new"       alt="New"           onclick="OnNewItem()" /></td>
						<td ><gw:imgBtn id="ibtnSaveItem"   img="save"      alt="Save"          onclick="OnSaveItem()" /></td>
						<td ><gw:imgBtn id="ibtnDeleteItem" img="delete"    alt="Delete"        onclick="OnDeleteItem()" /></td>		
										
                    </tr>
                    <tr>
						
                        <td colspan="8">
                            <gw:grid
                            id="grdDtlItem"
                            header  ="_MST_PK|_PK|_TAKEOUT_DTL_PK|ORDER NO|_ITEM_PK|ITEM CODE|ITEM NAME|UNIT|PRICE|QTY|EX.PRICE|RETOUCH AMT.|NET Trans Amt| NET Books Amt|NET TAX AMT|_AC_PK|AC_CD|AC_NM|DESCRIPTION|LOCAL DESCRIPTION|KOREAN DESCRIPTION|_CCY|_RATE"
                            format  ="0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0|1"
                            aligns  ="0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|0|0|0|0|0|0|0|3"
                            defaults="||||||||0|0|0|0|0|0|0||||||||"
                            editcol ="0|0|0|1|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0"
                            widths  ="0|0|0|1500|0|1500|2500|1000|1500|1000|2000|2000|2000|2000|2000|0|1500|2500|2500|2500|2500|600|1500"
                            styles  ="width:100%; height:150"
                            onafteredit="EditDtlItem()"
                            onselchange="EditDtlItem()"
                            oncelldblclick = "ItemRowClick()"
                            sorting ="F"/>
                        </td>
                        
                    </tr> 
                    
                    <tr>
                        <td align="right"><b>Total&nbsp;</b></td>
                        <td ><gw:textbox id="txtITEM_TR_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                        <td ><gw:textbox id="txtITEM_BK_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                        <td align="right"><b>Diff. Amount&nbsp;</b></td>
                        <td ><gw:textbox id="txtITEM_DIFF_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                    </tr>       
                </table>
                
                               
                <table name="VAT calculation"  align ="top"  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:40;">
                    <tr>
                        <td width="50%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        
                    </tr>
                    <tr>
						<td colspan="5"></td>
                        <td align="Right"><gw:imgBtn id="ibtnSaveVat"   img="save"      alt="Save"          onclick="OnSaveVAT()" /></td>
						
                    </tr>   
                    <tr>
                        <td colspan="6">
                            <gw:grid
                            id="grdDtlVAT"
                            header  ="_MST_PK|_PK|_ITEM_PK|ITEM CODE|ITEM NAME|NET AMOUNT|VAT RATE|VAT AMOUNT|RETOUCH AMT.|VAT Trans Amt| VAT Books Amt|VAT TAX AMT|_ACC PK| ACCOUNT CODE| ACCOUNT NAME"
                            format  ="0|0|0|0|0|1|0|1|1|1|1|1|0|0|0"
                            aligns  ="0|0|0|0|0|3|0|3|3|3|3|0|0|0|0"
                            defaults="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            editcol ="0|0|0|0|0|0|1|0|1|0|0|0|0|0|0"
                            widths  ="0|0|0|1500|3500|1800|1000|2000|2000|2000|2000|2000|1000|2000|3000"
                            styles  ="width:100%; height:150"
                            onafteredit = "EditDtlVAT()"
                            oncelldblclick = "VATRowClick()"
                            sorting ="F"/>
                        </td>
                    </tr>     
                    <tr>
					    <td align="right"><b>Total&nbsp;</b></td>
                        <td ><gw:textbox id="txtVAT_TR_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                        <td ><gw:textbox id="txtVAT_BK_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                        <td align="right"><b>Diff. Amount&nbsp;</b></td>
                        <td ><gw:textbox id="txtVAT_DIFF_AMT" type="number" format="###,###,###,###.##R" styles='width:100%;height:22'/></td>
                    </tr> 
                </table>
                
                <table name="Project"  align ="top"  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:40;">
                    <tr>
                        <td width="50%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        
                    </tr>
                    <tr>
						<td colspan="5"></td>
                        <td align="Right"><gw:imgBtn id="ibtnSavePL"   img="save"      alt="Save"          onclick="OnSavePL()" /></td>
						
                    </tr>   
                    <tr>
                        <td colspan="6">
                            <gw:grid
                            id="grdDtlABPL"
                            header  ="_MST_PK|_PK|_ITEM_PK|ITEM CODE|ITEM NAME|_TAC_ABPLCENTER_PK|PL CODE| PL NAME"
                            format  ="0|0|0|0|0|0|0|0"
                            aligns  ="0|0|0|0|0|0|0|0"
                            defaults="0|0|0|0|0|0|0|0"
                            editcol ="0|0|0|0|0|0|1|0"
                            widths  ="0|0|0|2500|4500|1800|2500|4500"
                            styles  ="width:100%; height:150"
                            onafteredit = "EditDtlPL()"
                            oncelldblclick = "PLRowClick()"
                            sorting ="F"/>
                        </td>
                    </tr>     
                    
                </table>
            </gw:tab>
        </td>
    </tr>
</table>
            

<gw:textbox id="txtTR_RATE"     style="display:none"/>
<gw:textbox id="txtTR_TYPE"     style="display:none"/>
<gw:textbox id="txt_PK"         style="display:none"/>
<gw:textbox id="txtrate"        style="display:none"/>
<gw:textbox id="txt_row"        style="display:none"/>
<gw:textbox id="txt_date"       style="display:none"/>
<gw:textbox id="txtcur"         style="display:none"/>
<gw:textbox id="txtCRCA_PK"         style="display:none"/>
<gw:textbox id="txtNUM_PK"         style="display:none"/>
<gw:textbox id="txtTSA_SOTAKEOUT_PK"         style="display:none" />
<gw:textbox id="txtTSA_SOTAKEOUTD_PK"         style="display:none" />
<gw:textbox id="txtStatus"         style="display:none" />

<!---------------------------------------------------------------------------------------------------->
</body>
</html>