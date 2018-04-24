﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 
<script>
var click_tab0   = true;
var click_tab1   = true;
var click_tab2   = true;
var g_company_pk      = "<%=Request.querystring("company_pk")%>";
function BodyInit()
{
    System.Translate(document);
    var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_date_fr     = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
    ls_date_fr = dtPay_duefr.value;
    ls_date_fr = ls_date_fr.substr(0, 4) + '01' + '01'; 
	var ls_Type        = "<%=ESysLib.SetListDataFUNC("SELECT SF_A_GET_COMMONCODE('EACAB002') FROM DUAL")%>";
	
	var ls_date        = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE, 'DD/MM/YYYY') FROM DUAL")%>";
	var ls_Book_ccy    = "<%=ESysLib.SetListDataSQL("select a.code, a.code code_nm from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'ACBG0040' and a.def_yn = 'Y'")%>";
	
	lstBook_ccy.SetDataText(ls_Book_ccy);
	txt_date.SetDataText(ls_date);
	lstType.SetDataText(ls_Type);
    lstCompany.SetDataText(ls_data);
    lstCompany.value = g_company_pk ;	
    lstCompany.SetEnable(false);
    dtPay_duefr.SetDataText(ls_date_fr);
    dtPay_fr.SetDataText(ls_date_fr);
    
    txtcust_nm.SetEnable(false);
    txtpl_nm.SetEnable(false);
    
    lblRecord.SetDataText("0");
    txtchk.SetDataText("0");
    txttab.text = 0;
    SetGridData();
    OnChangeConfirm();
    dso_sel_booksrate.Call();
    txtseq.GetControl().focus();
}

function SetGridData()
{
    var fg  = grid_amount.GetGridControl();
    var fg1 = grid_pay.GetGridControl();
    
    
    fg.ColFormat(15)    = "#,###,###,###,###,###,###,###,###,###R";
    fg.ColFormat(16)    = "#,###,###,###,###,###,###,###,###.##R";
	if(lstBook_ccy.value == "VND")
	    fg.ColFormat(17)    = "#,###,###,###,###,###,###,###,###,###R";
	else
		fg.ColFormat(17)    = "#,###,###,###,###,###,###,###,###.##R";	
	
    if(lstBook_ccy.value == "VND")	
	{
		fg1.ColFormat(9)    = "#,###,###,###,###,###,###,###,###,###R";
		fg1.ColFormat(11)   = "#,###,###,###,###,###,###,###,###,###R";
		fg1.ColFormat(13)   = "#,###,###,###,###,###,###,###,###,###R";
	}
	else
	{
		fg1.ColFormat(9)    = "#,###,###,###,###,###,###,###,###.##R";
		fg1.ColFormat(11)   = "#,###,###,###,###,###,###,###,###.##R";
		fg1.ColFormat(13)   = "#,###,###,###,###,###,###,###,###.##R";	
	}
    fg1.ColFormat(8)    = "#,###,###,###,###,###,###,###,###.##R";    
    fg1.ColFormat(10)   = "#,###,###,###,###,###,###,###,###.##R";    
    fg1.ColFormat(12)   = "#,###,###,###,###,###,###,###,###.##R";
    	
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
	if (txttab.GetData() == 2)
	{
	    if (txtseq.GetData() == '')
        {
            alert('    You must input SEQ to divide!!!'+'\n'+'Bạn hãy nhập số SEQ để phân ra!!!');
            return false;
        }
	}
	return true;
}

function OnSearch()
{
//--------------------------------------------
    grid_amount.ClearData();    
    grid_pay.ClearData();
    OnCheckTab();
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
    }
}

function OnCheckTab()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        click_tab0 = false;
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        click_tab1 = false;
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        click_tab2  = false;
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

function OnDataReceive(iObj)
{
    if(iObj.id == "dso_sel_grd_payable_payment")
    {
        var i;
        var fg = grid_pay.GetGridControl();
        for(i = 1; i < grid_pay.rows; i++)
        { 
            if(grid_pay.GetGridData(i, 15)=='Y')
            {
                fg.SetCellBgColor(i, 0, i, 15, 0xA9EBD7);
            }
        }
    }
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

//function OnConfirm()
//{
//    txtseq_str.text = "";
//    txtindex.text   = "";
//    var data;
//	data = "";
//	var ctrl 	= grid_amount.GetGridControl();
//	var rows 	= ctrl.Rows;
//	var index;
//	index  = 0;
//	
//	for (i=1; i<ctrl.Rows; i++)
//	{
//		var tmp = grid_amount.GetGridData(i, 0);
//		if (tmp == "-1")
//		{
//			data  = grid_amount.GetGridData(i, 16)+ "," + data ;
//			index = index + 1 ;
//		}
//	}
//	if(index == 0)
//	{
//		alert('Please select check SEQ for confirm!!!'+'\n'+'  Bạn hãy chọn số SEQ để Confirm!!!')
//		return;
//	}
//	else
//	{
//		if(confirm('Are you sure you want to confirm?'+'\n'+'Bạn có chắc Confirm số SEQ này?'))
//		{	        
//	        txtseq_str.text = data;
//	        txtindex.text   = index;
//	        dso_upd_confirm_cancel.Call();	
//        }
//    }
//}

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
			data  = grid_amount.GetGridData(i, 16)+ "," + data;
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

function OnPrint()
{
    alert("Not Yet");
    return;
}

function Popup_PL()
{
    var fpath = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
    var object = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
    if ( object != null ) 
    {
        if (object[0] != 0)
        {
            txtpl_pk.SetDataText(object[2]); // PK
            txtpl_cd.SetDataText(object[0]); // Item Code
            txtpl_nm.SetDataText(object[1]); // Item Name Local
        }
    }
}

function Reset_PL()
{
    txtpl_pk.SetDataText("");
    txtpl_cd.SetDataText("");
    txtpl_nm.SetDataText("");
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

function OnPopupSlipEntry()
{
    var ctrl 	= grid_amount.GetGridControl();
	var rows    = ctrl.Rows
	rows = rows - 1;
	var rownum  	= ctrl.Row;
	var colnum  	= ctrl.Col;
	if (rownum > 0)		 
	{
		if (event.col > 0)
		{
			var pk      = grid_amount.GetGridData(ctrl.row, 1);
			var status  = 0;
			var ls_arr = "";
			for (i = 1; i < grid_amount.rows; i++)
			{
			    ls_arr = ls_arr + ' ' + grid_amount.GetGridData(i, 1);
			}
			
			var fpath   = System.RootURL + '/form/gf/hg/gfhg00020_popup.aspx?PK_ROW=' + pk + '&ROW=' + ctrl.row + '&ROWS=' + rows + '&APPRCANCEL=' + status + "&ARRAY_PK=" + ls_arr;
			var wWidth  = 950;
			var wHeight = 580;
			var x = Math.round((screen.availWidth - wWidth)/2);
			var y = Math.round((screen.availHeight - wHeight)/2);
			
			var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
			   "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
			   "lef="+ x +",top=" + y;
			
			var object = System.OpenModal(fpath, wWidth, wHeight, features);
	    }
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

function OnSelect()
{
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        var aValue = new Array();
        for (i = 1; i < grid_amount.rows; i++)
        {
            var v_check = grid_amount.GetGridData(i, 0)
            if (v_check == "-1")
            {
                var tmp= new Array();
                tmp[tmp.length] = grid_amount.GetGridData(i, 1);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 13);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 14);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 15);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 16);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 17);
	            tmp[tmp.length] = grid_amount.GetGridData(i, 18);// tac_carecv_pk
	            tmp[tmp.length] = grid_amount.GetGridData(i, 19);
	            aValue[aValue.length]=tmp;
            }
        }
        window.returnValue = aValue;
        window.close();
    }
}



function OnSetBookRate()
{
    if (txtBookRate.GetData() == 0)
    {
        alert('You must type in day ratio: '+ txt_date.GetData() +'\n'+'Bạn hãy nhập tỉ giá ngày: '+ txt_date.GetData());
        return;
    }
}

function Popup_Style()
{
	var i;
    var path = System.RootURL + '/form/fm/gf/PopUpGetOneItem.aspx' ;
    var aValue = System.OpenModal( path ,950 , 500 ,  'resizable:yes;status:yes') ;	
	if(aValue != null)
	{		
		txtStyleNo.text = aValue[1] ; // item name
		txtStyleNo_PK.text = aValue[0] ; // Item PK			
	}	
}

function OnConfirm()
{
    var i;
    if(confirm('Are you sure you want to confirm the checked slips?'))
    {
        for(i = 1; i < grid_amount.rows; i++)
        {
            if(grid_amount.GetGridData(i, 0)=="-1")
            {
                grid_amount.SetGridText(i, 20, 'Y');
                grid_amount.SetRowStatus(i, 0x10);
            }
        }
        dso_sel_grd_payable_amount.Call();
    }    
}

function OnChangeConfirm()
{    
    if(rbstatus.value == '1') // unconfirm
    {
        btnConfirm.SetEnable(true);
        btnCancel.SetEnable(false);
        btnSelect.SetEnable(false);              
    }
    else if(rbstatus.value == '2') // confirm
    {
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(true);        
        btnSelect.SetEnable(true);              
    }
    OnSearch();
}

function OnUnconfirm()
{
    var i;
    if(confirm('Are you sure you want to confirm the checked slips?'))
    {
        for(i = 1; i < grid_amount.rows; i++)
        {
            if(grid_amount.GetGridData(i, 0)=="-1")
            { 
                grid_amount.SetGridText(i, 20, 'N'); // confirmed
                grid_amount.SetRowStatus(i, 0x10);
            }
        }
        dso_sel_grd_payable_amount.Call();
    }    
}

</script>
<body style="margin:0; padding:0;">
<!--------------------------------------------------------------------->
    <gw:data id="dso_sel_grd_payable_amount" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_AR_COLLECTION_3" parameter="18,20" procedure="ACNT.SP_UPD_GRD_AR_COLLECTION_2" >
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
					<input bind="txtStyleNo"/>
					<input bind="txtCIInv" />
					<input bind="txtPONo" />
					<input bind="txtQuantity" />				
				    <input bind="chkAll" />						
                </input>
                <output bind="grid_amount"/>
            </dso>
        </xml>
    </gw:data>
<!--------------------------------------------------------------------->    
    <gw:data id="dso_sel_grd_payable_payment" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.SP_SEL_GRD_AR_COLLECTION">
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
					<input bind="txtStyleNo"/>
					<input bind="txtCIInv" />
					<input bind="txtPONo" />
					<input bind="txtQuantity" />	
					<input bind="chkAll" />				
                </input>
                <output bind="grid_pay"/>
            </dso>
        </xml>
    </gw:data>
<!--------------------------------------------------------------------->    
    <gw:data id="dso_sel_booksrate" onreceive="OnSetBookRate()"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_BOOKCCY">
                <input> 
                     <input bind="lstCompany" />
                     <input bind="txt_date" />
                     <input bind="lstBook_ccy" />
                </input>  
                <output>
                     <output bind="txtBookRate" />
               </output> 
            </dso> 
        </xml> 
    </gw:data>    
<!--------------------------------------------------------------------->    
<table width="100%" cellpadding="0" cellspacing="0" border="1" style="height:100%" >
<tr>
    <td width="100%">
	    <table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%" >
		<tr>
            <td width="100%">
	            <table width="100%" cellpadding="0" cellspacing="0" border="0" height="100%">
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
                <tr style="height:6%">
                    <td align="right">Company</td>
                    <td colspan="3"><gw:list id="lstCompany" onChange="OnSearch()" styles='width:100%'></gw:list></td>
                    <td align="center">Status</td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td><gw:datebox id="dtPay_Date" onchange="" styles='width:85%' lang="1"/></td>
                            <td align="left"><gw:radio id="rbstatus" value="1" onchange="OnChangeConfirm()"> 
					                <span value="1">UnConfirmed</span>
					                <span value="2">Confirmed</span>
                            </gw:radio>
                            </td>
                        </tr>
                        </table>
                    </td>
                    <td align="right">SEQ</td>
                    <td><gw:textbox id="txtseq" styles="width:100%" onenterkey="OnSearch()" onkeypress="CheckNumeric()"/></td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="80%"></td>
                            <td><gw:imgBtn  id="ibtnSearch" img="search"    alt="Search"        onclick="OnSearch()"/></td>
				            <td colspan="3"><gw:icon id="btnConfirm" img="in" styles="width:100%; " text="Confirm" alt="Confirm" onclick="OnConfirm()" /></td>
				            <td><gw:imgBtn  id="ibtnReport" img="printer"   alt="Print Acct"    onclick="OnPrint()"/></td>
                        </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height:6%" >
                    <td align="right">Recv Due Date</td>
                    <td><gw:datebox id="dtPay_duefr" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtPay_dueto" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center"><a title="Click here to select Customer" onclick="Popup_Cust()" href="#tips">Customer</td>
                    <td colspan="3">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="30%"><gw:textbox id="txtcust_cd" styles='width:100%'/></td>
                            <td width="60%"><gw:textbox id="txtcust_nm" styles='width:100%'/></td>
                            <td width="0%"><gw:textbox  id="txtcust_pk" styles='display:none'/></td>
                            <td width="5%"><gw:imgBtn   img="reset"	id="idResetTr"  alt="Reset" onclick="Reset_Cust()"/></td>
                        </tr>
                        </table>
                    </td>
                    <td align="right">Voucher No</td>
                    <td><gw:textbox id="txtvoucher_no" styles="width:100%" onkeypress="Upcase()" onenterkey="OnSearch()"/></td>
			        <td><gw:icon id="btnSelect"    img="in" text="Select"     styles='width:100%'  onclick="OnSelect()"/></td>
                    <td><gw:icon id="btnCancel"    img="in" text="Unconfirm"     styles='width:100%; '  onclick="OnUnconfirm()"/></td>
                </tr>
                <tr style="height:6%" >
                    <td align="right">Recv Date</td>
                    <td><gw:datebox id="dtPay_fr" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtPay_to" 	onchange="" styles='width:100%' lang="1"/></td>
                    <td align="center"><a title="Click here to select Profit & Loss(PL)" onclick="Popup_PL()" href="#tips">Profit & Loss(PL)</td>
                    <td colspan="3">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="30%"><gw:textbox id="txtpl_cd" styles='width:100%'/></td>
                            <td width="60%"><gw:textbox id="txtpl_nm" styles='width:100%'/></td>
                            <td width="0%"><gw:textbox  id="txtpl_pk" styles='display:none'/></td>
                            <td width="5%"><gw:imgBtn   img="reset"	id="idResetPL"  alt="Reset" onclick="Reset_PL()"/></td>
                        </tr>
                        </table>
                    </td>
			        <td align="right"><a title="Click here to select Type" onclick="Popup_Type()" href="#tips">Type</td>
                    <td><gw:list id="lstType" onChange="OnSearch()" value ="" styles='width:100%' /></td>
                    <td colspan = 3>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td align="center"  width="5%">Total</td>
                            <td align="center"  width="5%"><gw:label id="lblRecord" text="" styles="color:red;width:90%;font-weight: bold;font-size:15"/></td> 
					        <td align="left"    width="5%">vouchers</td>
					        <td                 width="5%"><gw:icon id="btnChk"     img="in" text="ChkAll" styles='width:100%' onclick="OnChkAll()"/></td>
                        </tr>
                        </table>
                    </td>
                </tr>
				<tr style="height:6%" >
					<td align="right"><a title="Click here to select Style No" onclick="Popup_Style()" href="#tips">Style No</a></td>
					<td colspan="3" align="left"><gw:textbox id="txtStyleNo" styles="width:100%" /></td>
					<td colspan="1" align="right">CI Invoice</td>
					<td align="left" colspan="1" ><gw:textbox id="txtCIInv" onkeypress="Upcase()" styles="width:100%; " /></td>
					<td align="right">Quantity</td>
					<td align="left"><gw:textbox id="txtQuantity" styles="width:100%; " /></td>
					<td align="right">PO No</td>
					<td align="left" colspan="1" ><gw:textbox id="txtPONo" styles="width:100%" /></td>					
					<td align="right">All</td>
					<td colspan="2"><gw:checkbox id="chkAll" value = "T" onchange="OnSearch()" /></td>
				</tr>
                </table>
            </td>
        </tr>
        </table>
    </td>
</tr>

<tr style="height:76%" >
    <td width="100%">
        <table border=0 width="100%" cellpadding=0 cellspacing=0 height="100%" >
        <tr style="height:66%">
            <td>
                <gw:tab id="idTab_Child"  onpageactivate="onSearchTab()">
                    <table name="Receivable" width ="100%" cellpadding ="0" cellspacing ="0" border="1" height="100%" >
                        <tr>
                            <td width ="100%">
                                <gw:grid   
		                            id="grid_amount"
		                            header  ="Chk|Seq|Invoice Date|Invoice No|Serial No|C.Invoice|PO|Contract No|Decl. No|Decl. Date|Style No|Quantity|Unit Price|A/R Date|A/R Ccy|A/R Rate|A/R Trans|A/R Books|_pk|_trd_pk|_Confirm_YN"
		                            format  ="3|0|4|0|0|0|0|0|0|4|0|0|0|4|0|0|0|0|0|0|0"
		                            aligns  ="1|1|1|1|1|1|1|1|1|1|2|3|3|1|1|1|3|3|0|0|0"
		                            defaults="||||||||||||||||||||"
		                            editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
		                            widths  ="500|800|1200|1200|1200|1200|800|1200|1200|1200|2500|1400|1400|1200|800|800|1300|1300|0|0|1000"
		                            styles  ="width:100%; height:100%"
		                            sorting ="T"
		                            acceptNullDate="T"
		                            oncelldblclick="OnPopupSlipEntry()"
		                            />
                            </td>
                        </tr>
                    </table>
                    <table name="Receive & Balance" width ="100%" cellpadding ="0" cellspacing ="0" border="1" height="100%" >
                            <tr>
                            <!--0.Seq|2.Voucher Type|2.Voucher No|3.Prps Date|4.Partner Code|5.Partner Name|6.P/L Code|7.P/L Name|8.Amount Trans|9.Amount Books|10.Recv Trans|11.Recv Books|12.Balance Trans|13.Balance Books|14.QTY|15.Approed_YN-->
				                <td width ="100%">
                                    <gw:grid   
		                                id="grid_pay"
		                                header  ="Seq|Voucher Type|Voucher No|Prps Date|Partner Code|Partner Name|P/L Code|P/L Name|Amount Trans|Amount Books|Recv Trans|Recv Books|Balance Trans|Balance Books|Qty|_Approved_YN"
		                                format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
		                                aligns  ="1|1|1|1|0|0|0|0|3|3|3|3|3|3|3|1"
		                                defaults="|||||||||||||||"
		                                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
		                                widths  ="600|1400|1500|1300|1500|2500|1300|2500|1500|1500|1500|1500|1500|1200|0|0"
		                                styles  ="width:100%; height:100%"
		                                acceptNullDate="T"
		                                sorting ="T"
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
<gw:textbox id="txtseq1_str"            style="display:none" />

<gw:textbox id="txtindex"               style="display:none" />
<gw:textbox id="txtStatus"              style="display:none" />

<gw:list    id="lstBook_ccy" 		   style="display:none" ></gw:list >
<gw:textbox id="txtBookRate"           style="display:none"  />
<gw:textbox id="txt_date"               style='display:none'/>
<gw:textbox id="txtStyleNo_PK"               style='display:none'/>
</body>
</html>