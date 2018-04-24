<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
<%ESysLib.SetUser("acnt")%>

<script>

var lang = "<%=Session("SESSION_LANG")%>";
var click_tab0   = true;
var click_tab1   = true;
var click_tab2   = true;
var click_tab3   = true;
var click_tab4   = true;
var flag_d       = false;

function BodyInit()
{
    System.Translate(document);
    var ls_company  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_possum   = "DATA|Y|Posting|N|Summary||";
    var ls_date     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE, 'YYYYMM') FROM DUAL")%>";
    var ls_type     = "DATA|0|Account Code|1|Customer|2|Employee|3|Bank|4|Item Control";
    var ls_Book_ccy = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACBG0040','04','') FROM DUAL")%>";
    
    <%=ESysLib.SetGridColumnComboFormat("grid_acc", 3,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grid_cust", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grid_emp", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    <%=ESysLib.SetGridColumnComboFormat("grid_bank", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
    
    lstBook_ccy.SetDataText(ls_Book_ccy);
    
    lstCompany.SetDataText(ls_company);
    lstPostSum.SetDataText(ls_possum);
    dtmonth.SetDataText(ls_date);
    lstType.SetDataText(ls_type);
    grid_acc.GetGridControl().FrozenCols    = 4;
    grid_cust.GetGridControl().FrozenCols   = 4;
    grid_emp.GetGridControl().FrozenCols    = 4;
    txtlb_nm.SetEnable(false);
    txtac_nm.SetEnable(false);
    SetNumGrid();
    onChangType();
    txtlang.SetDataText(lang);
    var ls_trsdate  = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') FROM DUAL")%>";
    txt_date.text   = ls_trsdate;
    txtProposedByUserPk.text="<%=Session("USER_PK")%>";
	dso_getCompany.Call();
    //dso_sel_booksrate.Call();
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if (key > 47 && key < 58)
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}

function SetNumGrid()
{
    var fg  = grid_acc.GetGridControl();
    var fg1 = grid_cust.GetGridControl();
    var fg2 = grid_emp.GetGridControl();
    var fg3 = grid_bank.GetGridControl();
    var fg4 = grid_item.GetGridControl();
    if (lstBook_ccy.GetData() == 'VND')
    {
        fg.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(6) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(10) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(11) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(14) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(16) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(17) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
        // -- //
        fg1.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(8) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(9) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(12) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(13) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(14) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(15) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(17) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(18) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(19) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(20) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(21) = "#,###,###,###,###,###,###,###,###R";
        // -- //
        fg2.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(8) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(9) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(12) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(13) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(14) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(15) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(17) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(18) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(19) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(20) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(21) = "#,###,###,###,###,###,###,###,###R"; 
        // -- //
        fg3.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(8) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(9) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(12) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(13) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(14) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(15) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(17) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(18) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(19) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(20) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(21) = "#,###,###,###,###,###,###,###,###R"; 
        // -- //
        fg4.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(8) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(9) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(12) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(13) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(14) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(15) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(17) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(18) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(19) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(20) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(21) = "#,###,###,###,###,###,###,###,###R";
    }
    else
    {
        fg.ColFormat(4) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(5) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(8)= "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(9)= "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(12) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(13) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(14) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(15) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(16) = "#,###,###,###,###,###,###,###,###R";
        fg.ColFormat(17) = "#,###,###,###,###,###,###,###,###R";        
        fg.ColFormat(18) = "#,###,###,###,###,###,###,###,###.##R";
        fg.ColFormat(19) = "#,###,###,###,###,###,###,###,###.##R";
        // -- //
        fg1.ColFormat(6) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(7) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(10) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(11) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(14) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(16) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(17) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
        fg1.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
        fg1.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
        // -- //
        fg2.ColFormat(6) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(7) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(10) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(11) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(14) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(16) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(17) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
        fg2.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
        fg2.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
        // -- //
        fg3.ColFormat(6) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(7) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(10) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(11) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(14) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(16) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(17) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
        fg3.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
        fg3.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
        // -- //
        fg4.ColFormat(6) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(7) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(10) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(11) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(14) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(15) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(16) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(17) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(18) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(19) = "#,###,###,###,###,###,###,###,###R";
        fg4.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
        fg4.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
    }
}

function onNew()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        onNewAcc();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        onNewCust();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        onNewEmp();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        onNewBank();
    }
}

function onNewAcc()
{
    grid_acc.AddRow();
}

function onNewCust()
{
    grid_cust.AddRow();
    flag_d = false;
}

function onNewEmp()
{
    grid_emp.AddRow();
    flag_d = false;
}

function onNewBank()
{
    grid_bank.AddRow();
    flag_d = false;
}

function onSearch()
{
    if (txtac_cd.GetData() == '')
    {
        txtac_nm.SetDataText("");
    }
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        dso_sel_grd_open_balance.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        dso_sel_grd_open_balance_cust.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        dso_sel_grd_open_balance_emp.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        dso_sel_grd_open_balance_bank.Call('SELECT');
    }
}

function onSave()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        onSaveAcc();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        onSaveCust();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        onSaveEmp();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        onSaveBank();
    }
}

function onSaveAcc()
{
	if (onCheckAcc())
	{
	    for (i = 1; i < grid_acc.rows; i++)
        {
            grid_acc.SetGridText(i, 20, idTab_Child.GetCurrentPageNo());
            grid_acc.SetGridText(i, 21, lstCompany.GetData());
            grid_acc.SetGridText(i, 22, dtmonth.GetData());
        }
        dso_sel_grd_open_balance.Call();
	}
}

function onSaveCust()
{
	if (onCheckCust())
	{
	    for (i = 1; i < grid_cust.rows; i++)
        {
            grid_cust.SetGridText(i, 22, 1);
            grid_cust.SetGridText(i, 23, lstCompany.GetData());
            grid_cust.SetGridText(i, 24, dtmonth.GetData());
            if (grid_cust.GetGridData(i, 25) == "")
            {
                grid_cust.SetGridText(i, 25, txtac_pk.GetData());
            }
        }
        dso_sel_grd_open_balance_cust.Call();
	}
}

function onSaveEmp()
{
	if (onCheckEmp())
	{
	    for (i = 1; i < grid_emp.rows; i++)
        {
            grid_emp.SetGridText(i, 22, 2);
            grid_emp.SetGridText(i, 23, lstCompany.GetData());
            grid_emp.SetGridText(i, 24, dtmonth.GetData());
            if (grid_emp.GetGridData(i, 25) == "")
            {
                grid_emp.SetGridText(i, 25, txtac_pk.GetData());
            }
        }
        dso_sel_grd_open_balance_emp.Call();
	}
}

function onSaveBank()
{
	if (onCheckBank())
	{
	    for (i = 1; i < grid_bank.rows; i++)
        {
            grid_bank.SetGridText(i, 22, 3);
            grid_bank.SetGridText(i, 23, lstCompany.GetData());
            grid_bank.SetGridText(i, 24, dtmonth.GetData());
            if (grid_bank.GetGridData(i, 25) == "")
            {
                grid_bank.SetGridText(i, 25, txtac_pk.GetData());
            }
        }
        dso_sel_grd_open_balance_bank.Call();
	}
}


function onDelete()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        grid_acc.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        grid_cust.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        grid_emp.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        grid_bank.DeleteRow();
    }
    flag_d = true;
}

function onCheckAcc()
{
    for (i = 1; i < grid_acc.rows - 1; i++)
    {
        for (j = i + 1; j < grid_acc.rows; j++)
        {
            if (grid_acc.GetGridData(i, 1) == grid_acc.GetGridData(j, 1))
            {
                alert('Duplicate Account Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckCust()
{
    if ((txtac_pk.GetData() == '') && (!flag_d))
    {
        alert('Account Receivable is not null. Please chose Account!!!' + '\n' + '');
        return false;
    }
    for (i = 1; i < grid_cust.rows - 1; i++)
    {
        for (j = i + 1; j < grid_cust.rows; j++)
        {
            if (grid_cust.GetGridData(i, 1) == grid_cust.GetGridData(j, 1))
            {
                alert('Duplicate Custommer Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckEmp()
{
    if ((txtac_pk.GetData() == '') && (!flag_d))
    {
        alert('Account Receivable is not null. Please chose Account!!!' + '\n' + '');
        return false;
    }
    for (i = 1; i < grid_emp.rows - 1; i++)
    {
        for (j = i + 1; j < grid_emp.rows; j++)
        {
            if (grid_emp.GetGridData(i, 1) == grid_emp.GetGridData(j, 1))
            {
                alert('Duplicate Emp Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckBank()
{
    if ((txtac_pk.GetData() == '') && (!flag_d))
    {
        alert('Account Receivable is not null. Please chose Account!!!' + '\n' + '');
        return false;
    }
    for (i = 1; i < grid_bank.rows - 1; i++)
    {
        for (j = i + 1; j < grid_bank.rows; j++)
        {
            if (grid_bank.GetGridData(i, 1) == grid_bank.GetGridData(j, 1))
            {
                alert('Duplicate Bank Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function EnableTab(bool)
{
    click_tab0 = bool;
    click_tab1 = bool;
    click_tab2 = bool;
    click_tab3 = bool;
    click_tab4 = bool;
}

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
	     case "dso_getCompany":
			dso_sel_booksrate.Call();
		break;
        case "dso_sel_grd_open_balance":
            if (lstType.GetData() == 0)
            {
                if (lstPostSum.GetData() == 'Y')
                {
                    dso_pro_update_open_bl.Call();
                }
            }
        break;
        
        case "dso_sel_grd_open_balance_cust":
            if (lstType.GetData() == 1)
            {
                if (lstPostSum.GetData() == 'Y')
                {
                    dso_pro_update_open_bl.Call();
                }
            }
        break;
        
        case "dso_sel_grd_open_balance_emp":
            if (lstType.GetData() == 2)
            {
                if (lstPostSum.GetData() == 'Y')
                {
                    dso_pro_update_open_bl.Call();
                }
            }
        break;
        
        case "dso_sel_grd_open_balance_bank":
           if (lstType.GetData() == 3)
            {
                if (lstPostSum.GetData() == 'Y')
                {
                    dso_pro_update_open_bl.Call();
                }
            }
        break;
        
        case "dso_pro_update_open_bl":
            if (lstType.GetData() == 0)
            {
                dso_sel_grd_open_bl.Call('SELECT');
            }
            else if (lstType.GetData() == 1)
            {
                dso_sel_grd_open_bl_cust.Call('SELECT');
            }
            else if (lstType.GetData() == 2)
            {
                dso_sel_grd_open_bl_emp.Call('SELECT');
            }
            else if (lstType.GetData() == 3)
            {
                dso_sel_grd_open_bl_bank.Call('SELECT');
            }
        break;
    }
}

function Reset_Acc()
{
	txtac_cd.SetDataText('');
	txtac_nm.SetDataText('');
	txtac_pk.SetDataText('');
}

function Popup_Acc()
{
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
    if (o != null)
	{
		if(o[0] != 0)
		{
		    txtac_cd.SetDataText(o[0]);
			txtac_nm.SetDataText(o[1]);
			txtac_pk.SetDataText(o[3]);
		}
    }
}

function onChangType()
{
    if (lstType.GetData() == '0')
    {
        txtlb_cd.SetEnable(false);
        txtlb_pk.SetEnable(false);
        idSearchCust.SetEnable(false);
        idResetCust.SetEnable(false);
        idTab_Child.SetPage(0);
        txtlb_pk.SetDataText("");
        txtlb_cd.SetDataText("");
        txtlb_nm.SetDataText("");
        lblText.SetDataText("Customer");
    }
    else if (lstType.GetData() == '1')
    {
        txtlb_cd.SetEnable(true);
        txtlb_pk.SetEnable(true);
        idSearchCust.SetEnable(true);
        idResetCust.SetEnable(true);
        idTab_Child.SetPage(1);
        txtlb_pk.SetDataText("");
        txtlb_cd.SetDataText("");
        txtlb_nm.SetDataText("");
        lblText.SetDataText("Customer");
        txtlb_cd.GetControl().focus();
    }
    else if (lstType.GetData() == '2')
    {
        txtlb_cd.SetEnable(true);
        txtlb_pk.SetEnable(true);
        idSearchCust.SetEnable(true);
        idResetCust.SetEnable(true);
        idTab_Child.SetPage(2);
        txtlb_pk.SetDataText("");
        txtlb_cd.SetDataText("");
        txtlb_nm.SetDataText("");
        lblText.SetDataText("Employee");
        txtlb_cd.GetControl().focus();
    }
    else if (lstType.GetData() == '3')
    {
        txtlb_cd.SetEnable(true);
        txtlb_pk.SetEnable(true);
        idSearchCust.SetEnable(true);
        idResetCust.SetEnable(true);
        idTab_Child.SetPage(3);
        txtlb_pk.SetDataText("");
        txtlb_cd.SetDataText("");
        txtlb_nm.SetDataText("");
        lblText.SetDataText("Bank");
        txtlb_cd.GetControl().focus();
    }
    else if (lstType.GetData() == '4')
    {
        txtlb_cd.SetEnable(true);
        txtlb_pk.SetEnable(true);
        idSearchCust.SetEnable(true);
        idResetCust.SetEnable(true);
        idTab_Child.SetPage(4);
        txtlb_pk.SetDataText("");
        txtlb_cd.SetDataText("");
        txtlb_nm.SetDataText("");
        lblText.SetDataText("Item Control");
        txtlb_cd.GetControl().focus();
    }
}

function onSetDataList()
{
	if (idTab_Child.GetCurrentPageNo() == 0)
    {
        if (click_tab0 == true)
        {
            EnableTab(true);
            click_tab0 = false;
            lstType.SetDataText('0');
            txtlb_cd.SetEnable(false);
            txtlb_pk.SetEnable(false);
            idSearchCust.SetEnable(false);
            idResetCust.SetEnable(false);
            txtlb_pk.SetDataText("");
            txtlb_cd.SetDataText("");
            txtlb_nm.SetDataText("");
            lblText.SetDataText("Customer");
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        if (click_tab1 == true)
        {
            EnableTab(true);
            click_tab1 = false;
            lstType.SetDataText('1');
            txtlb_cd.SetEnable(true);
            txtlb_pk.SetEnable(true);
            idSearchCust.SetEnable(true);
            idResetCust.SetEnable(true);
            txtlb_pk.SetDataText("");
            txtlb_cd.SetDataText("");
            txtlb_nm.SetDataText("");
            lblText.SetDataText("Customer");
            txtlb_cd.GetControl().focus();
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        if (click_tab2 == true)
        {
            EnableTab(true);
            click_tab2 = false;
            lstType.SetDataText('2');
            txtlb_cd.SetEnable(true);
            txtlb_pk.SetEnable(true);
            idSearchCust.SetEnable(true);
            idResetCust.SetEnable(true);
            txtlb_pk.SetDataText("");
            txtlb_cd.SetDataText("");
            txtlb_nm.SetDataText("");
            lblText.SetDataText("Employee");
            txtlb_cd.GetControl().focus();
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        if (click_tab3 == true)
        {
            EnableTab(true);
            click_tab3 = false;
            lstType.SetDataText('3');
            txtlb_cd.SetEnable(true);
            txtlb_pk.SetEnable(true);
            idSearchCust.SetEnable(true);
            idResetCust.SetEnable(true);
            txtlb_pk.SetDataText("");
            txtlb_cd.SetDataText("");
            txtlb_nm.SetDataText("");
            lblText.SetDataText("Bank");
            txtlb_cd.GetControl().focus();
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 4)
    {
        if (click_tab4 == true)
        {
            EnableTab(true);
            click_tab4 = false;
            lstType.SetDataText('4');
            txtlb_cd.SetEnable(true);
            txtlb_pk.SetEnable(true);
            idSearchCust.SetEnable(true);
            idResetCust.SetEnable(true);
            txtlb_pk.SetDataText("");
            txtlb_cd.SetDataText("");
            txtlb_nm.SetDataText("");
            lblText.SetDataText("Item Control");
            txtlb_cd.GetControl().focus();
        }
    }
}

function onEnter()
{
	dso_pro_acc.Call();
}

function Popup()
{
    var path;
    var object;
    if (lstType.GetData() == '1')   //Customer
    {
        path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	    object  = System.OpenModal( path ,850 , 550 , 'resizable:yes;status:yes');
	    if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[2]);
                txtlb_pk.SetDataText(object[0]);
	        }
        }
    }
    else if (lstType.GetData() == '2') //Emp
    {
        path    = System.RootURL + "/form/gf/co/ffco002003.aspx";
        object  = System.OpenModal( path , 1000 , 600 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[2]);
                txtlb_pk.SetDataText(object[0]);
	        }
        }
    }	    
    else if (lstType.GetData() == '3') // Bank
    {
        path    = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + "" + "&company="+ lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
        object  = System.OpenModal( path , 600 , 500 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[0]);
                txtlb_pk.SetDataText(object[2]);
	        }
        }
    }
}

function Reset()
{
	txtlb_cd.SetDataText('');
    txtlb_nm.SetDataText('');
    txtlb_pk.SetDataText('');
}

function onReport()
{
    alert('Not Yet');
    return;
}

function OnChangeList()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        grid_acc.ClearData()
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        grid_cust.ClearData()
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        grid_emp.ClearData()
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        grid_bank.ClearData()
    }
    else if (idTab_Child.GetCurrentPageNo() == 4)
    {
        grid_item.ClearData()
    }
}

function OnChange_Pos()
{
    if (lstPostSum.GetData() == 'Y')
    {
        ibtnNew.SetEnable(true);
        ibtnSave.SetEnable(true);
        ibtnDelete.SetEnable(true);
        onSearch();
    }
    else 
    {
        ibtnNew.SetEnable(false);
        ibtnSave.SetEnable(false);
        ibtnDelete.SetEnable(false);
        onSearch();
    }
}

function DBPopupClick()
{
    if ((event.col == 1) || (event.col == 2)) 
    {
        Popup_Grid(event.row);
    }
}

function Popup_Grid(row)
{
    var path;
    var object;
    if (lstType.GetData() == '0')   //Acc
    {
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
        object   = System.OpenModal( path , 550 , 550 , 'resizable:yes;status:yes');	
        if (object != null)
	    {
		    if (object[0] != 0)
            {
		        grid_acc.SetGridText(row, 1, object[0]);
                grid_acc.SetGridText(row, 2, object[1]);
	        }
	    }
    }
    else if (lstType.GetData() == '1')   //Customer
    {
        path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	    object  = System.OpenModal( path ,850 , 550 , 'resizable:yes;status:yes');
	    if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_cust.SetGridText(row, 1, object[1]);
                grid_cust.SetGridText(row, 2, object[2]);
	        }
        }
    }
    else if (lstType.GetData() == '2') //Emp
    {
        //path    = System.RootURL + "/form/gf/co/ffco002003.aspx";
        path    = System.RootURL + "/form/gf/ma/gfma00010_3.aspx";
        object  = System.OpenModal(  path , 1000 , 600 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_emp.SetGridText(row, 1, object[1]);
                grid_emp.SetGridText(row, 2, object[2]);
	        }
        }
    }	    
    else if (lstType.GetData() == '3') // Bank
    {
        path    = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + "" + "&company="+ lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
        object  = System.OpenModal(  path , 600 , 500 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_bank.SetGridText(row, 1, object[1]);
                grid_bank.SetGridText(row, 2, object[0]);
	        }
        }
    }
}

function onSetBookRate()
{
    if (txtBookRate.GetData() == 0)
    {
        alert('You must type in day ratio: '+ txt_date.GetData() +'\n'+'Bạn hãy nhập tỉ giá ngày: '+ txt_date.GetData())
    }
}

function SelectAfterEdit()
{
    if (lstType.GetData() == '0')   //Acc
    {
        if (event.col == 8)
        {
            var ls_ccy = grid_acc.GetGridData(event.row, 3);
            var ls_famt = grid_acc.GetGridData(event.row, 8);
            if (ls_ccy == lstBook_ccy.GetData())
            {
                grid_acc.SetGridText(event.row, 10, ls_famt);
            }
        }
        else if (event.col == 9)
        {
            var ls_ccy = grid_acc.GetGridData(event.row, 3);
            var ls_famt = grid_acc.GetGridData(event.row, 9);
            if (ls_ccy == lstBook_ccy.GetData())
            {
                grid_acc.SetGridText(event.row, 11, ls_famt);
            }
        }
    }
    else if (lstType.GetData() == '1')   //Cust
    {
        if (event.col == 10)
        {
            
        }
    }
    else if (lstType.GetData() == '2')   //Emp
    {
        if (event.col == 10)
        {
            
        }
    }
    else if (lstType.GetData() == '3')   //Bank
    {
        if (event.col == 10)
        {
            
        }
    }
    else if (lstType.GetData() == '4')   //Control Item
    {
        if (event.col == 10)
        {
            
        }
    }
}

</script>
<body style="margin:0; padding:0;">

    <gw:data id="dso_getCompany" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="ACNT.sp_sel_gfac00100_1" > 
                <input> 
                     <input bind="txtProposedByUserPk"/>
                </input>
                <output>
                     <output bind="lstCompany"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="dso_sel_grd_open_bl" >
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRID_OPEN_BALANCE">
                <input bind="grid_acc">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_acc"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_open_bl_cust" >
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRID_OPEN_BALANCE">
                <input bind="grid_cust">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_cust"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_open_bl_emp" >
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRID_OPEN_BALANCE">
                <input bind="grid_emp">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_emp"/>
            </dso>
        </xml>
    </gw:data>

    <gw:data id="dso_sel_grd_open_bl_bank" >
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRID_OPEN_BALANCE">
                <input bind="grid_bank">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_bank"/>
            </dso>
        </xml>
    </gw:data>

    <gw:data id="dso_sel_grd_open_balance" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="acnt.SP_SEL_GRID_OPEN_BALANCE" procedure="ACNT.SP_UPD_GRID_OPEN_BALANCE">
                <input bind="grid_acc">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_acc"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_open_balance_cust" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="acnt.SP_SEL_GRID_OPEN_BALANCE" procedure="ACNT.SP_UPD_GRID_OPEN_BALANCE">
                <input bind="grid_cust">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_cust"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_open_balance_emp" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="acnt.SP_SEL_GRID_OPEN_BALANCE" procedure="ACNT.SP_UPD_GRID_OPEN_BALANCE">
                <input bind="grid_emp">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_emp"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_open_balance_bank" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="acnt.SP_SEL_GRID_OPEN_BALANCE" procedure="ACNT.SP_UPD_GRID_OPEN_BALANCE">
                <input bind="grid_bank">
                    <input bind="lstCompany"/>
                    <input bind="txtac_cd"/>
                    <input bind="lstPostSum"/>
                    <input bind="lstType"/>
                    <input bind="dtmonth"/>
                    <input bind="txtlb_pk"/>
                    <input bind="txtlang"/>
                </input>
                <output bind="grid_bank"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_pro_update_open_bl" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_UPD_GRID_OPEN_BL_UPPER_ACC" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtmonth"/>
                     <input bind="lstType"/>
                     <input bind="lstPostSum"/>
                </input>  
                <output>  
                     <output bind="txttmp"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="dso_pro_acc" onreceive="onSearch()">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_SEL_ACCOUNT" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="txtac_cd"/>
                     <input bind="txtlang"/>
                </input>
                <output>
                     <output bind="txtac_pk"/>
                     <output bind="txttmp"/>
                     <output bind="txtac_nm"/>
               </output>
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_sel_booksrate" onreceive="onSetBookRate()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_BOOKCCY">
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="txt_date"/>
                     <input bind="lstBook_ccy"/>
                </input>  
                <output>
                     <output bind="txtBookRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
    <td width="100%">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
	        <td width="8%"></td>
	        <td width="29%"></td>
	        <td width="8%"></td>
	        <td width="35%"></td>
	        <td width="20%"></td>
	    </tr>
	    <tr>
	        <td align="right">Company&nbsp;</td>
            <td><gw:list id="lstCompany" onChange="OnChangeList()" styles='width:100%;background:#FFFFAF'></gw:list></td>
            <td align="right">Account&nbsp;</td>
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="30%"><gw:textbox id="txtac_cd" styles='width:100%;background:#FFFFAF' onenterkey="onEnter()" onkeypress="CheckNumeric()"/></td>
                    <td width="60%"><gw:textbox id="txtac_nm" styles='width:100%;background:#FFFFAF' /></td>
                    <td width="0%"><gw:textbox  id="txtac_pk" styles='display:none'/></td>
                    <td width="5%"><gw:imgBtn   img="popup"	id="idSearchTr" alt="Popup" onclick="Popup_Acc()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetTr"  alt="Reset" onclick="Reset_Acc()"/></td>
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="80%"></td>
                    <td ><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
                    <td ><gw:imgBtn id="ibtnNew"    img="new"       alt="New"           onclick="onNew()"/></td>
				    <td ><gw:imgBtn id="ibtnSave"   img="save"      alt="Save"          onclick="onSave()"/></td>
				    <td ><gw:imgBtn id="ibtnDelete" img="delete"    alt="Delete"        onclick="onDelete()"/></td>
				    <td ><gw:imgBtn id="ibtnReport" img="printer"   alt="Print"         onclick="onReport()"/></td>
                </tr>
                </table>
            </td>
	    </tr>
	    <tr>
	        <td align="right">Month&nbsp;</td>
	        <td>
	            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center"><gw:datebox id="dtmonth" type="month" styles="width:50%;background:#FFFFAF"/></td>
                    <td align="right">Type&nbsp;</td>
                    <td width="60%"><gw:list id="lstType" onChange="onChangType()" styles='width:100%;background:#FFFFAF'></gw:list></td>
                </tr>
                </table>
	        </td>
            <td align="right"><gw:label id="lblText" text="Customer"/>&nbsp;</td>
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="30%"><gw:textbox id="txtlb_cd" styles='width:100%' onenterkey="onEnter()" onkeypress="CheckNumeric()"/></td>
                    <td width="60%"><gw:textbox id="txtlb_nm" styles='width:100%'/></td>
                    <td width="0%"><gw:textbox  id="txtlb_pk" styles='display:none'/></td>
                    <td width="5%"><gw:imgBtn   img="popup"	id="idSearchCust" alt="Popup" onclick="Popup()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetCust"  alt="Reset" onclick="Reset()"/></td>
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="right">Posting/Summary&nbsp;</td>
                    <td width="50%"><gw:list id="lstPostSum" onChange="OnChange_Pos()"  styles='width:100%;background:#FFFFAF'></gw:list></td>
                </tr>
                </table>
            </td>
	    </tr>
	    </table>
	</td>
</tr>
<tr>
	<td width="100%">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td width="100%">
                <gw:tab id="idTab_Child"  onclick ="onSetDataList()" >
                    <table  name="Account Code"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:380;" >    
                        <tr valign="top">
                            <td width="100%">
                                <gw:grid   
								    id="grid_acc"  
						            header="_PK|Acc Code|Acc Name|Ccy|_LAST DRFAMT|_LAST CRFAMT|_LAST DRAMT|_LAST CRAMT|Trans Amount(DR)|Trans Amount(CR)|Books Amount(DR)|Books Amount(CR)|_THIS DRFAMT|_THIS CRFAMT|_THIS DRAMT|_THIS CRAMT|_THIS DRFBAL|_THIS CRFBAL|_THIS DRBAL|_THIS CRBAL|_TYPE|_COMPK|_MONTH|_ACC_PK"
						            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
						            aligns  ="0|1|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"  
						            defaults="|||VND|||||||||||||||||||||"  
						            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
						            widths  ="0|1000|3500|1000|2000|2000|2000|2000|2500|2500|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|0|0|0|0"  
						            styles  ="width:100%; height:380"
						            sorting ="F"
						            onafteredit  = "SelectAfterEdit()"
						            oncelldblclick  = "DBPopupClick()"
						            /> 
                            </td>
                        </tr>
                    </table>
                    <table  name="Customer"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >    
                        <tr valign="top">
                            <td width="100%">
                                <gw:grid   
								    id="grid_cust"  
						            header="_PK|Cust Code|Cust Name|Acc.Code|Acc.Name|Ccy|_LAST DRFAMT|_LAST CRFAMT|_LAST DRAMT|_LAST CRAMT|Trans Amount(DR)|Trans Amount(CR)|Books Amount(DR)|Books Amount(CR)|_THIS DRFAMT|_THIS CRFAMT|_THIS DRAMT|_THIS CRAMT|_THIS DRFBAL|_THIS CRFBAL|_THIS DRBAL|_THIS CRBAL|_TYPE|_COMPK|_MONTH|_ACC_PK"
						            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
						            aligns  ="0|1|0|1|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"  
						            defaults="|||||VND|||||||||||||||||||||"  
						            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
						            widths  ="0|1000|2000|1000|2000|800|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|0|0|0|0"
						            styles="width:100%; height:380"
						            sorting ="F"
						            oncelldblclick  = "DBPopupClick()"
						            /> 
                            </td>
                        </tr>
                    </table>
                    <table  name="Employee"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >    
                        <tr valign="top">
                            <td width="100%">
                                <gw:grid   
								    id="grid_emp"  
						            header="_PK|Emp Code|Emp Name|Acc.Code|Acc.Name|Ccy|_LAST DRFAMT|_LAST CRFAMT|_LAST DRAMT|_LAST CRAMT|Trans Amount(DR)|Trans Amount(CR)|Books Amount(DR)|Books Amount(CR)|_THIS DRFAMT|_THIS CRFAMT|_THIS DRAMT|_THIS CRAMT|_THIS DRFBAL|_THIS CRFBAL|_THIS DRBAL|_THIS CRBAL|_TYPE|_COMPK|_MONTH|_ACC_PK"
						            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
						            aligns  ="0|1|0|1|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"  
						            defaults="|||||VND|||||||||||||||||||||" 
						            editcol ="0|1|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
						            widths  ="0|1000|2000|1000|2000|800|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|0|0|0|0"
						            styles="width:100%; height:380"
						            sorting ="F" 
						            oncelldblclick  = "DBPopupClick()"
						            /> 
                            </td>
                        </tr>
                    </table>
                    <table  name="Bank"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >    
                        <tr valign="top">
                            <td width="100%">
                                <gw:grid   
								    id="grid_bank"  
						            header="_PK|Bank Code|Bank Name|Acc.Code|Acc.Name|Ccy|_LAST DRFAMT|_LAST CRFAMT|_LAST DRAMT|_LAST CRAMT|Trans Amount(DR)|Trans Amount(CR)|Books Amount(DR)|Books Amount(CR)|_THIS DRFAMT|_THIS CRFAMT|_THIS DRAMT|_THIS CRAMT|_THIS DRFBAL|_THIS CRFBAL|_THIS DRBAL|_THIS CRBAL|_TYPE|_COMPK|_MONTH|_ACC_PK"
						            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
						            aligns  ="0|1|0|1|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"  
						            defaults="|||||VND|||||||||||||||||||||" 
						            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
						            widths  ="0|1000|2000|1000|2000|800|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|0|0|0|0"
						            styles="width:100%; height:380"
						            sorting ="F" 
						            oncelldblclick  = "DBPopupClick()"
						            /> 
                            </td>
                        </tr>
                    </table>
                    <table  name="Control Item" align="top" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:138;" >    
                        <tr valign="top">
                            <td width="100%">
                                <gw:grid   
								    id="grid_item"  
						            header="_PK|Item Code|Item Name|Acc.Code|Acc.Name|Ccy|_LAST DRFAMT|_LAST CRFAMT|_LAST DRAMT|_LAST CRAMT|Trans Amount(DR)|Trans Amount(CR)|Books Amount(DR)|Books Amount(CR)|_THIS DRFAMT|_THIS CRFAMT|_THIS DRAMT|_THIS CRAMT|_THIS DRFBAL|_THIS CRFBAL|_THIS DRBAL|_THIS CRBAL|_TYPE|_COMPK|_MONTH|_ACC_PK"
						            format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
						            aligns  ="0|1|0|1|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|0"  
						            defaults="|||||VND|||||||||||||||||||||"
						            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
						            widths  ="0|1000|2000|1000|2000|800|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1000|0|0|0|0"  
						            styles  ="width:100%; height:380"
						            sorting ="F"
						            oncelldblclick  = "DBPopupClick()"
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
</table>

<gw:textbox id="txttmp"             style="display:none"/>
<gw:textbox id="txtlang"            style="display:none"/>


<gw:list    id="lstBook_ccy" 		 style="width:50%;display:none"></gw:list>
<gw:textbox id="txtBookRate"         style="display:none" />
<gw:textbox id="txt_date"            style="display:none" />
<gw:textbox id="txtProposedByUserPk"            style="display:none" />

</body>
</html>