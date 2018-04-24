<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 
<script>

var click_tab0   = true;
var click_tab1   = true;
var click_tab2   = true;

function BodyInit()
{
    System.Translate(document);
    var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);	
	var ls_date_fr     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
	var ls_Type        = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE('EACAB001') FROM DUAL")%>";
	
	<%=ESysLib.SetGridColumnComboFormat("grid_amount", 2,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACBG0130' AND A.USE_IF = 1")%>;
	<%=ESysLib.SetGridColumnComboFormat("grid_invoice", 1,"SELECT TRIM(A.CODE), A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACBG0130' AND A.USE_IF = 1")%>;
	
	ls_data        = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACBG0040' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.DEF_YN = 'Y'")%>";
	lstBookCcy.SetDataText(ls_data);
    
    dtPay_duefr.SetDataText(ls_date_fr);
    dtPay_fr.SetDataText(ls_date_fr);
    lstType.SetDataText(ls_Type);
	lstType.value = 'AL';
    txtcust_nm.SetEnable(false);
    txtpl_nm.SetEnable(false);
    lblRecord.SetDataText("0");
    txtchk.SetDataText("0");
    txttab.text = 0;
    SetGridData();
    Control_Menu();
    txtseq.GetControl().focus();
}

function SetGridData()
{
    var fg  = grid_amount.GetGridControl();
    var fg1 = grid_pay.GetGridControl();
    fg.ColFormat(9)     = "#,###,###,###,###,###,###,###,###.##R";	
	if(lstBookCcy.value == "VND")
		fg.ColFormat(10)    = "#,###,###,###,###,###,###,###,###R";	
	else
		fg.ColFormat(10)    = "#,###,###,###,###,###,###,###,###.##R";	
    fg1.ColFormat(5)    = "#,###,###,###,###,###,###,###,###.##R";
	if(lstBookCcy.value == "VND")
		fg1.ColFormat(6)    = "#,###,###,###,###,###,###,###,###R";
	else
		fg1.ColFormat(6)    = "#,###,###,###,###,###,###,###,###.##R";
    fg1.ColFormat(7)    = "#,###,###,###,###,###,###,###,###.##R";
	if(lstBookCcy.value == "VND")
		fg1.ColFormat(8)    = "#,###,###,###,###,###,###,###,###R";
	else
		fg1.ColFormat(8)    = "#,###,###,###,###,###,###,###,###.##R";
    fg1.ColFormat(9)    = "#,###,###,###,###,###,###,###,###.##R";
	if(lstBookCcy.value == "VND")
		fg1.ColFormat(10)   = "#,###,###,###,###,###,###,###,###R";
	else
		fg1.ColFormat(10)   = "#,###,###,###,###,###,###,###,###.##R";
}

function Reset_Cust()
{
    txtcust_cd.SetDataText("");
    txtcust_nm.SetDataText("");
    txtcust_pk.SetDataText("");
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}

function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}

function OnChkAll()
{
    if (grid_amount.rows > 1)
    {
        if (txtchk.GetData() == 0)
        {
            btnChk.text="UnChk";
            txtchk.SetDataText("1");
            for (i = 1; i< grid_amount.rows; i++)
            {
                grid_amount.SetGridText(i, 0, -1);
            }
        }
        else
        {
            btnChk.text="ChkAll";
            txtchk.SetDataText("0");
            for (i = 1; i< grid_amount.rows; i++)
            {
                grid_amount.SetGridText(i, 0, 0);
            }
        }
    }
}

function OnCheck()
{
    var std_dt, etd_dt ;
    std_dt = dtPay_duefr.GetData();
	etd_dt = dtPay_dueto.GetData();
	if (parseInt(etd_dt) < parseInt(std_dt))
	{
		alert(' End Pay Due Date can’t be earlier than start date!!!'+'\n'+'Ngày kết thúc không thể nhỏ hơn ngày bắt đầu!!!');
		return false;
	}
	std_dt = dtPay_fr.GetData();
	etd_dt = dtPay_to.GetData();
	if (parseInt(etd_dt) < parseInt(std_dt))
	{
		alert(' End Pay Date can’t be earlier than start date!!!'+'\n'+'Ngày kết thúc không thể nhỏ hơn ngày bắt đầu!!!');
		return false;
	}
	return true;
}

function OnSearch()
{
    OnChangeStatus();
    grid_amount.ClearData();
    grid_invoice.ClearData();
    grid_pay.ClearData();
    if (OnCheck())
    {
        if (txttab.GetData() == 0)
        {
            dso_sel_grd_payable_amount.Call('SELECT');
        }
        else if (txttab.GetData() == 1)
        {
            dso_sel_grd_payable_payment.Call('SELECT');
        }
        else if (txttab.GetData() == 2)
        {
            dso_sel_grd_payable_invoice.Call('SELECT');
        }
    }
}

function Popup_Cust()
{
    var fpath   = System.RootURL + '/form/gf/co/ffbp00031.aspx';
    var object  = System.OpenModal(fpath , 800 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null )
    {
        if (object[1] != 0)
        {
            txtcust_pk.text    = object[0];
            txtcust_nm.text    = object[2];
            txtcust_cd.text    = object[1];
        }
    }
}

function Control_Menu()
{
    btnConfirm.SetEnable(false);
    btnCancel.SetEnable(false);
    btnUpdate.SetEnable(false);
    btnChk.SetEnable(false);
    if (!click_tab0)
    {
        if (rbstatus.GetData() == 1)
        {
            btnConfirm.SetEnable(true);
        }
        else
        {
            btnCancel.SetEnable(true);
        }
        btnChk.SetEnable(true);
    }
    else if (!click_tab2)
    {
        btnUpdate.SetEnable(true);
    }
    SetTotal();
}

function EnableTab(bool)
{
    click_tab0 = bool;
    click_tab1 = bool;
    click_tab2 = bool;
}

function onSearchTab()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        if (click_tab0 == true)
        {
            EnableTab(true);
            click_tab0 = false;
            txttab.text = 0;
            OnSearch();
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        if (click_tab1 == true)
        {
            EnableTab(true);
            click_tab1 = false;
            txttab.text = 1;
            OnSearch();
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        if (click_tab2 == true)
        {
            EnableTab(true);
            click_tab2 = false;
            txttab.text = 2;
            OnSearch();
        }
    }
    Control_Menu();
}

function OnChangeStatus()
{
    if (rbstatus.GetData() == 1)
    {
        lblDate.text = 'Trans Date';
    }
    else
    {
        lblDate.text = 'Pay Date';
    }
}

function OnUpdate()
{
    dso_sel_grd_payable_invoice.Call();
}

function OnConfirm()
{
    txtseq_str.text = "";
    txtindex.text   = "";
    var data;
	data = "";
	var ctrl 	= grid_amount.GetGridControl();
	var rows 	= ctrl.Rows;
	var index;
	index  = 0;
	
	for (i=1; i<ctrl.Rows; i++)
	{
		var tmp = grid_amount.GetGridData(i, 0);
		if (tmp == "-1")
		{
			data  = grid_amount.GetGridData(i, 11)+ "," + data ;
			index = index + 1 ;
		}
	}
	if(index == 0)
	{
		alert('Please select check SEQ for confirm!!!'+'\n'+'  Bạn hãy chọn số SEQ để Confirm!!!')
		return;
	}
	else
	{
		if(confirm('Are you sure you want to confirm?'+'\n'+'Bạn có chắc Confirm số SEQ này?'))
		{
	        
	        txtseq_str.text = data;
	        txtindex.text   = index;
	        dso_upd_confirm_cancel.Call();	
        }
    }
}

function OnConfirmCancel()
{
    txtseq_str.text = "";
    txtindex.text   = "";
    var data;
    var data1;
	data    = "";
	data1   = "";
	
	var ctrl 	= grid_amount.GetGridControl();
	var rows 	= ctrl.Rows;
	var index;
	index  = 0;
	
	for (i=1; i<ctrl.Rows; i++)
	{
		var tmp = grid_amount.GetGridData(i, 0);
		if (tmp == "-1")
		{
			data  = grid_amount.GetGridData(i, 11)+ "," + data;
			data1 = grid_amount.GetGridData(i, 1)+ "," + data;
			index = index + 1;
		}
	}
	if(index == 0)
	{
		alert('Please select check SEQ for cancel confirm!!!'+'\n'+'  Bạn hãy chọn số SEQ để Cancel Confirm!!!');
		return;
	}
	else
	{
		if(confirm('Are you sure you want to cancel confirm?'+'\n'+'Bạn có chắc Cancel Confirm số SEQ này?'))
		{
	        txtseq_str.text = data;
	        txtseq1_str.text = data1;
	        txtindex.text   = index;
	        dso_upd_confirm_cancel.Call();
        }
    }
}

function SetTotal()
{
    if (grid_amount.rows > 1)
    {
        var ctrl = grid_amount.GetGridControl();
	    var i = ctrl.rows - 1;
	    lblRecord.SetDataText(i);
	    btnChk.SetEnable(true);
    }
    else
    {
        lblRecord.SetDataText(0);
    }
    btnChk.text="ChkAll";
    txtchk.SetDataText("0");
}

function OnPrint()
{
    alert("Not Yet");
    return;
}

function Popup_Type()
{
    var fpath   = System.RootURL + '/form/ag/ga/agga00090.aspx';
	var wWidth  = 950;
	var wHeight = 580;
	var x = Math.round((screen.availWidth - wWidth)/2);
	var y = Math.round((screen.availHeight - wHeight)/2);
	
	var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
	   "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
	   "lef="+ x +",top=" + y;
			
    var object = System.OpenModal(fpath, wWidth, wHeight, features);
}


</script>
<body style="margin:0; padding:0;">

    <gw:data id="dso_sel_grd_payable_amount" onreceive="Control_Menu()">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_PAYABLE">
                <input bind="grid_amount">
                    <input bind="lstCompany"/>
                    <input bind="rbstatus"/>
                    <input bind="txtseq"/>
                    <input bind="dtPay_duefr"/>
                    <input bind="dtPay_dueto"/>
                    <input bind="dtPay_fr"/>
                    <input bind="dtPay_to"/>
                    <input bind="txtcust_pk"/>
                    <input bind="txtvoucher_no"/>
                    <input bind="txtpl_pk"/>
                    <input bind="lstType"/>
                    <input bind="txttab"/>
					<input bind="txtBalOpt"/>
					<input bind="dtPay_Date"/>
                </input>
                <output bind="grid_amount"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_payable_payment" onreceive="Control_Menu()">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_PAYABLE">
                <input bind="grid_pay">
                    <input bind="lstCompany"/>
                    <input bind="rbstatus"/>
                    <input bind="txtseq"/>
                    <input bind="dtPay_duefr"/>
                    <input bind="dtPay_dueto"/>
                    <input bind="dtPay_fr"/>
                    <input bind="dtPay_to"/>
                    <input bind="txtcust_pk"/>
                    <input bind="txtvoucher_no"/>
                    <input bind="txtpl_pk"/>
                    <input bind="lstType"/>
                    <input bind="txttab"/>
					<input bind="txtBalOpt"/>
					<input bind="dtPay_Date"/>					
                </input>
                <output bind="grid_pay"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_sel_grd_payable_invoice" onreceive="Control_Menu()">
        <xml>
            <dso type="grid" parameter="7,9,10" function="acnt.SP_SEL_GRD_PAYABLE" procedure="ACNT.SP_UPD_GRD_PAYABLE">
                <input bind="grid_invoice">
                    <input bind="lstCompany"/>
                    <input bind="rbstatus"/>
                    <input bind="txtseq"/>
                    <input bind="dtPay_duefr"/>
                    <input bind="dtPay_dueto"/>
                    <input bind="dtPay_fr"/>
                    <input bind="dtPay_to"/>
                    <input bind="txtcust_pk"/>
                    <input bind="txtvoucher_no"/>
                    <input bind="txtpl_pk"/>
                    <input bind="lstType"/>
                    <input bind="txttab"/>
					<input bind="txtBalOpt"/>
					<input bind="dtPay_Date"/>					
                </input>
                <output bind="grid_invoice"/>
            </dso>
        </xml>
    </gw:data>
    
    <gw:data id="dso_upd_confirm_cancel" onreceive="OnSearch()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_PAYABLE_CONFIRM_CANCEL" > 
                <input> 
                     <input bind="txtseq_str"/>
                     <input bind="lstCompany"/>
                     <input bind="rbstatus"/>
                     <input bind="txtindex"/>
                     <input bind="dtPay_Date"/>
                     <input bind="txtseq1_str"/>
                </input>
                <output>
                     <output bind="rbstatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    
<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
    <td width="100%">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
            <td width="100%">
	            <table width="100%" cellpadding="0" cellspacing="0" border="0">
		        <tr>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="2%"></td>
                    <td width="10%"></td>
                    <td width="8%"></td>
                    <td width="12%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="8%"></td>
                    <td width="10%"></td>
                    <td width="5%"></td>
                    <td width="5%"></td>
                </tr>
                <tr>
                    <td align="right">Company&nbsp;</td>
                    <td colspan="3"><gw:list id="lstCompany" onChange="OnSearch()" styles='width:100%'></gw:list></td>
                    <td align="center">Status&nbsp;</td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td><gw:datebox id="dtPay_Date" onchange="" styles='width:85%' lang="1"/></td>
                            <td align="left"><gw:radio id="rbstatus" value="2" onchange="OnSearch()"> 
					                <span value="1">UnConfirmed&nbsp;</span>
					                <span value="2">Confirmed</span>
                            </gw:radio>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td align="right">SEQ&nbsp;</td>
                    <td><gw:textbox id="txtseq" styles="width:100%" onenterkey="OnSearch()" onkeypress="CheckNumeric()"/></td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="50%"><gw:icon id="btnSearch" img="in" text="Search"  styles='width:100%' onclick="OnSearch()"/></td>
                            <td width="50%"><gw:icon id="btnPrint"  img="in" text="Print"   styles='width:100%' onclick="OnPrint()"/></td>
                        </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="right">Pay Due Date&nbsp;</td>
                    <td><gw:datebox id="dtPay_duefr" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtPay_dueto" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center"><a title="Click here to select Customer" onclick="Popup_Cust()" href="#tips">Customer&nbsp;</td>
                    <td colspan="3">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="30%"><gw:textbox id="txtcust_cd" styles='width:100%' onenterkey="OnSearchTrans()" onkeypress="Upcase()"/></td>
                            <td width="60%"><gw:textbox id="txtcust_nm" styles='width:100%'/></td>
                            <td width="0%"><gw:textbox  id="txtcust_pk" styles='display:none'/></td>
                            <td width="5%"><gw:imgBtn   img="reset"	id="idResetTr"  alt="Reset" onclick="Reset_Cust()"/></td>
                        </tr>
                        </table>
                    </td>
                    <td align="right">Voucher No&nbsp;</td>
                    <td><gw:textbox id="txtvoucher_no" styles="width:100%" onenterkey="OnSearch()"/></td>
			        <td><gw:icon id="btnConfirm"    img="in" text="Confirm"     styles='width:100%' onclick="OnConfirm()"/></td>
                    <td><gw:icon id="btnCancel"     img="in" text="Cancel"      styles='width:100%' onclick="OnConfirmCancel()"/></td>
                    <td><gw:icon id="btnUpdate"     img="in" text="Update"      styles='width:100%' onclick="OnUpdate()"/></td>
                </tr>
                <tr>
                    <td align="right"><gw:label id="lblDate" text="Pay Date" />&nbsp;</td>
                    <td><gw:datebox id="dtPay_fr" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtPay_to" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center"><a title="Click here to select Profit & Loss(PL)" onclick="Popup_PL()" href="#tips">Profit & Loss(PL)&nbsp;</td>
                    <td colspan="3">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="30%"><gw:textbox id="txtpl_cd" styles='width:100%' onenterkey="OnSearchTrans()" onkeypress="Upcase()"/></td>
                            <td width="60%"><gw:textbox id="txtpl_nm" styles='width:100%'/></td>
                            <td width="0%"><gw:textbox  id="txtpl_pk" styles='display:none'/></td>
                            <td width="5%"><gw:imgBtn   img="reset"	id="idResetPL"  alt="Reset" onclick="Reset_PL()"/></td>
                        </tr>
                        </table>
                    </td>
			        <td align="right"><a title="Click here to select Type" onclick="Popup_Type()" href="#tips">Type&nbsp;</td>
                    <td><gw:list id="lstType" onChange="" value ="" styles='width:100%'></gw:list></td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td align="center"  width="5%">Total&nbsp;</td>
                            <td align="center"  width="5%"><gw:label id="lblRecord" text="" styles="color:red;width:90%;font-weight: bold;font-size:15"/></td> 
					        <td align="left"    width="5%">vouchers&nbsp;</td>
					        <td                 width="5%"><gw:icon id="btnChk"     img="in" text="ChkAll" styles='width:100%' onclick="OnChkAll()"/></td>
                        </tr>
                        </table>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td width="100%">
        <table border=0 width="100%" cellpadding=0 cellspacing=0 >
        <tr>
            <td>
                <gw:tab id="idTab_Child"  onclick ="onSearchTab()">
                    <table name="Amount Infor" width ="100%" cellpadding ="0" cellspacing ="0" border="1" >
                        <tr>
                            <td width ="100%">
                                <gw:grid   
		                            id="grid_amount"
		                            header  ="Chk|Seq|Voucher Type|Voucher No|Prps Date|Appr.Date|Appr.No|Customer Name|Pay Date|Amount Trans|Amount Books|_pk"
		                            format  ="3|0|0|0|4|4|0|0|0|0|0|0"
		                            aligns  ="1|1|1|1|1|1|0|0|0|3|3|0"
		                            defaults="|||||||||||"
		                            editcol ="0|0|0|0|0|0|0|0|0|0|0|0"
		                            acceptNullDate="T"
		                            widths  ="500|800|1500|1500|1200|1200|1200|2500|1200|1700|0|0"
		                            styles  ="width:100%; height:380"
		                            sorting ="F"
		                            />
                            </td>
                        </tr>
                    </table>
                    <table name="Payment & Balance" width ="100%" cellpadding ="0" cellspacing ="0" border="1" >
                            <tr>
				                <td width ="100%">
                                    <gw:grid   
		                                id="grid_pay"
		                                header  ="Seq|Voucher No|P/L Name|Desc|Desc Local|Amount Trans|Amount Books|Pay Trans|Pay Books|Balance Trans|Balance Books"
		                                format  ="0|0|0|0|0|0|0|0|0|0|0"
		                                aligns  ="1|1|0|0|0|3|3|3|3|3|3"
		                                defaults="||||||||||"
		                                editcol ="0|0|0|0|0|0|0|0|0|0|0"  
		                                widths  ="600|1500|1300|1500|1500|1500|1500|1300|1300|1500|0"  
		                                styles  ="width:100%; height:380"
		                                sorting ="F"
		                                />
                                </td>
                            </tr>
                    </table>
                    <table name="Invoice & Plan" width ="100%" cellpadding ="0" cellspacing ="0" border="1" >
                            <tr>
				                <td width ="100%">
                                    <gw:grid   
		                                id="grid_invoice"
		                                header  ="Seq|Voucher Type|Voucher No|Customer Name|Invoice Trans|Invoice Books|Due Date|Plan Due Date|Contract No|Remark|_pk"
		                                format  ="0|0|0|0|0|0|0|4|0|0|0"  
		                                aligns  ="1|1|1|0|0|0|0|1|0|0|0" 
		                                defaults="||||||||||"  
		                                acceptNullDate="T"
		                                editcol ="0|0|0|0|0|0|0|1|0|1|0"
		                                widths  ="800|1500|1500|2500|1500|1500|1000|1500|1500|0|0"  
		                                styles  ="width:100%; height:380"
		                                sorting ="F"
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

<gw:textbox id="txtchk"                 style="display:none" />
<gw:textbox id="txttab"                 style="display:none" />
<gw:textbox id="txtseq_str"             style="display:none" />
<gw:textbox id="txtseq1_str"             style="display:none" />
<gw:textbox id="txtBalOpt" text="0" style="display:none" />
<gw:textbox id="txtindex"               style="display:none" />
<gw:textbox id="txtStatus"              style="display:none" />
<gw:list id="lstBookCcy"         style="display:none"     />
</body>
</html>
