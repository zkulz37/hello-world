<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>External Payment List</title>
</head>
<script>
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
    var  g_user_pk = "<%=Session("USER_PK")%>"  ;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    idCOM.SetDataText(ls_data);
	ls_data     = "<%=ESysLib.SetListDataSQL("select pk, bank_id from tac_abdepomt where del_if = 0 and use_yn = 'Y' order by bank_id asc")%>|0|Select All";
	idBankAcc.SetDataText(ls_data);
	idBankAcc.value = 0;
	if(idGrid.rows < 2)
	idGrid.AddRow();
	MergeHeaderGrid();	
	idCUST_NM.SetEnable(false);
	idCUST_CD.SetEnable(false);
	idBENEFICIARY_NM.SetEnable(false);
	idBENEFICIARY_CD.SetEnable(false);
	txtUser_PK.SetDataText(g_user_pk);
	dso_getCompany.Call();
	//search();	
	idBtnSave.SetEnable(false);
	idBtnConfirm.SetEnable(false);
}
//------------------------------------------------------------------------
function OnDataReceive(iObj)
{
	if(iObj.id == "gfep00060")
	{
		MergeHeaderGrid();
	}	
	else if(iObj.id == "gfep00060_1")
	{
		MergeHeaderGrid();
		OnRecv_search();
	}
	else if(iObj.id == "gfep00060_3")
	{
		MergeHeaderGrid();
		OnRecv_search();		
	}
	else if(iObj.id == "gfep00060_4")
	{
		MergeHeaderGrid();
		OnRecv_search();		
	}
    else if(iObj.id == 'dso_upd_paydate')
    {
        gfep00060.Call('SELECT');
    }
    else if(iObj.id == 'dso_confirm_payment')
    {
        idSTATUS.value = 'Y';
        gfep00060_1.Call('SELECT');
    }
    else if(iObj.id == 'dso_getCompany')
    {
        search();
    }
}
//------------------------------------------------------------------------
function OnPopUp(iCase)
{
	
	var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
	switch(iCase)
	{
		case '1':
			if ( object != null )
			{
				if (object[0] != 0)
				{
					idCUST_PK.text = object[0];
					idCUST_NM.text = object[2];
					idCUST_CD.text = object[1];
				}
			}		
		break;
	}	
}
//------------------------------------------------------------------------
function search()
{
	if(idSTATUS.value == "Y")
	{
		gfep00060_1.Call("SELECT");
	}	
	else 
	{
		gfep00060.Call("SELECT");
	}
}
//------------------------------------------------------------------------
function OnRecv_search()
{
	//idData_Dsql_Finished.Call("SELECT");
	var ctrl = idGrid.GetGridControl();
	var i = ctrl.rows - 2;
	lblRecord.SetDataText( i);
	//Check all
	idChkAll.value = 'T';
	CheckAll();
}
//------------------------------------------------------------------------
function MergeHeaderGrid()
{
		var fg = idGrid.GetGridControl(); 	    
        fg.FixedRows = 2
        fg.MergeCells =5	
		fg.MergeRow(0) = true
		
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "CHK"	
		
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "PPK"	
		
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Seq"	
		
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Voucher No"	
		
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "Payment Date"	
		
		fg.MergeCol(5) = true
		fg.Cell(0, 0, 5, 1, 5) = "Approved Date"	
			
		//_TAC_ABACCTCODE_PK
		fg.MergeCol(6) = true
		fg.Cell(0, 0, 6, 1, 6) = "Approved No"	
		
		//_TAC_ABACCTCODE_PK
		fg.MergeCol(7) = true
		fg.Cell(0, 0, 7, 1, 7) = "Project Name"	
		
		 //Remark	    
		 /*
	    fg.Cell(0, 0, 8, 0, 9)  = "Description"   //fg.Cell(0,row, from_col, row, to_col)		
	    fg.Cell(0, 1, 8, 1) = "Foreign"
	    fg.Cell(0, 1, 9, 1) = "Local"	
	    */
	    fg.MergeCol(8) = true
		fg.Cell(0, 0, 8, 1, 8) = "Description"	
		//Customer
		/*
		fg.Cell(0, 0, 10, 0, 11)  = "Customer"   //fg.Cell(0,row, from_col, row, to_col)		
	    fg.Cell(0, 1, 10, 1) = "Code"
	    fg.Cell(0, 1, 11, 1) = "Name"	
	    */
	    fg.MergeCol(11) = true
	    fg.Cell(0, 0, 11, 1,11) = "Customer Name"	
		//Amt
		fg.Cell(0, 0, 12, 0, 13)  = "By Tranfer"   //fg.Cell(0,row, from_col, row, to_col)		
	    fg.Cell(0, 1, 12, 1) = "USD"
	    fg.Cell(0, 1, 13, 1) = "VND"		
				
		//Amt
		fg.Cell(0, 0, 14, 0, 15)  = "By Cash"   //fg.Cell(0,row, from_col, row, to_col)		
	    fg.Cell(0, 1, 14, 1) = "USD"
	    fg.Cell(0, 1, 15, 1) = "VND"	
		
		//TRTYPE_PK
		fg.MergeCol(16) = true
		fg.Cell(0, 0, 16, 1, 16) = "Books Amount"
		
		//TRTYPE_PK
		fg.MergeCol(17) = true
		fg.Cell(0, 0, 17, 1, 17) = "Beneficicary Name"
		
		//TRTYPE_BANK
		fg.MergeCol(18) = true
		fg.Cell(0, 0, 18, 1, 18) = "Beneficicary Bank"
		
		fg.MergeCol(19) = true
		fg.Cell(0, 0, 19, 1, 19) = "Debit Account"

		fg.MergeCol(20) = true
		fg.Cell(0, 0, 20, 1, 20) = "Credit Account"
		
	   	fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4; 
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold
		
		//idData_dsql_sliprate.Call("SELECT")
		fg.ColWidth(0) = 500;//chk
		fg.ColWidth(1) = 0;	// ppk			
		fg.ColWidth(2) = 1000; //seq
		fg.ColWidth(3) = 1500; //vocuher
		fg.ColWidth(4) = 1300; //Payment Date
		fg.ColWidth(5) = 0; //Approved Date
		fg.ColWidth(6) = 0;//Approved No
		fg.ColWidth(7) = 2000; //Project Name"
		
		fg.ColWidth(8) = 2500;	 //Foreign
		fg.ColWidth(9) = 0;//Local
		
		fg.ColWidth(10) = 0; //cust id
		fg.ColWidth(11) = 2500; //cust nm
		
		fg.ColWidth(12) = 1600;		//bank usd	
		fg.ColWidth(13) = 1600;		//bank vnd		
		
		fg.ColWidth(14) = 1600;//cash usd	
		fg.ColWidth(15) = 1600;//cash vnd	
		
		fg.ColWidth(16) = 1500; // books 
		fg.ColWidth(17) = 2000; //Bene name
		fg.ColWidth(18) = 3000;//Ben Bank

		fg.ColFormat(12) = "###,###,###,###.##";	
		fg.ColFormat(13) = "###,###,###,###";	
		fg.ColFormat(14) = "###,###,###,###.##";	
		fg.ColFormat(15) = "###,###,###,###.##";	
		fg.ColFormat(16) = "###,###,###,###.##";
}
//---------------------------------------------------
function onchangeBank()
{
	idPrintType.value = "0";
	if(idSTATUS.GetData() == "N")
		gfep00060.Call("SELECT");
	else
		gfep00060_1.Call("SELECT");
}
//---------------------------------------------------
function onDomesticOversea()
{
	idGrid.ClearData();
	if (idPrintType.value =="0")
	{
		if(idSTATUS.GetData() == "N")
			gfep00060.Call("SELECT");
		else
			gfep00060_1.Call("SELECT");
		return;
	}
	var sheet_type = idBankAcc.GetData();
	if (sheet_type ==0)
	{
		alert("Please chose a bank account first");
		return;
	}
	
	var sheet_type_text = idBankAcc.GetText();
	var tmpTypeSheetArr = new Array();
	tmpTypeSheetArr = sheet_type_text.split(' ');
	bankStr = tmpTypeSheetArr[0].toString().substr(0,3);

	if (idPrintType.GetData() =="1")//Domestic
	{	
		switch(bankStr)
		{
			case "VCB":
				break;
			case "KEB":
				gfep00060_2.Call("SELECT");
				break;
			case "WRB":
				gfep00060_2.Call("SELECT");
				break;
			case "SHB":
				gfep00060_4.Call("SELECT");
				break;
		}		
	}
	else if (idPrintType.GetData() =="2")//Oversea
	{
		
		switch(bankStr)
		{
			case "VCB":
				break;
			case "KEB":
				gfep00060_3.Call("SELECT");
				break;
			case "WRB":
				gfep00060_3.Call("SELECT");
				break;
			case "SHB":
				gfep00060_5.Call("SELECT");
				break;
		}
	}
	//alert(System.RootURL+url);			
}
//---------------------------------------------------
function onDomesticOversea()
{

	idGrid.ClearData();
	if (idPrintType.value =="0")
	{
		if(idSTATUS.GetData() == "N")
			gfep00060.Call("SELECT");
		else
			gfep00060_1.Call("SELECT");
		return;
	}
	var sheet_type = idBankAcc.GetData();
	if (sheet_type ==0)
	{
		alert("Please chose a bank account first");
		return;
	}
	
	var sheet_type_text = idBankAcc.GetText();
	var tmpTypeSheetArr = new Array();
	tmpTypeSheetArr = sheet_type_text.split(' ');
	bankStr = tmpTypeSheetArr[0].toString().substr(0,3);

	if (idPrintType.GetData() =="1")//Domestic
	{	
		switch(bankStr)
		{
			case "VCB":
				break;
			case "KEB":
				gfep00060_4.Call("SELECT");
				break;
			case "WRB":
				gfep00060_2.Call("SELECT");
				break;
			case "SHB":
				gfep00060_4.Call("SELECT");
				break;
		}		
	}
	else if (idPrintType.GetData() =="2")//Oversea
	{	
		switch(bankStr)
		{
			case "VCB":
				break;
			case "KEB":
				gfep00060_3.Call("SELECT");
				break;
			case "WRB":
				gfep00060_3.Call("SELECT");
				break;
			case "SHB":
				gfep00060_5.Call("SELECT");
				break;
		}
	}
	//alert(System.RootURL+url);		
}
//---------------------------------------------------
function OnPrintVoucherSheet()
{
	var sheet_type = idBankAcc.GetData();
	var PkArr = '';
	var strComma = '';
	var i ;
	for (i=2;i<idGrid.rows;i++)
	{
		if (idGrid.GetGridData(i,0) == "-1")
		{
			PkArr = PkArr + strComma + idGrid.GetGridData(i,1);
			strComma = ',';
		}			
	}
	if (PkArr=='' )
	{
		alert("Select a payment to print");
		return;
	}	
	else if(idBankAcc.GetData() == "0" )
	{
		alert("Select a bank id to report data");
		return;	    
	}
	if(confirm("Are you sure you want to print ?" ))
	{		
		var url = System.RootURL + '/reports/gf/ep/gfep00060_voucher_rpt.aspx?compk=' + idCOM.GetData() + '&custpk=' + idCUST_PK.GetData() + '&bankpk=' + idBankAcc.GetData() + '&sdt=' + idSDT.GetData() + '&edt=' + idEDT.GetData() + "&crt_by=" + user_name ;
		//var sheet_type = idBankAcc.GetData();
		//var url = System.RootURL + '/reports/gf/ep/wabf016000_sheetType_rpt_70.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
		System.OpenTargetPage(url,'newform');
	}
}
//---------------------------------------------------
function OnPrintTransfer()
{
	var idCom = idCOM.GetData();
	var sheet_type = idBankAcc.GetData();
	var url = '';
	//if (idSTATUS.value !="Y")
	//{
		//alert("Cannot print payable voucher");
		//return;
	//}
	/*	
	if (sheet_type ==0)
	{
		alert("Please chose a bank account before printing");
		return;
	}
	*/
	if(txtACPK_CR.text != "")
	{
	    if(idBankAcc.value == '0')
	    {
	        alert('Select bank id to print out transfer list!');
	        return ;
	    }
    }
    else
    {
	    if(idBankAcc.value == '0')
	    {
	        alert('Select bank id to print out transfer list!');
	        return ;
	    }
    }	 
    var ctrl = idGrid.GetGridControl();
    var PkArr = '';
    var strComma = '';
    for (i=2;i<idGrid.rows;i++)
    {
	    if (idGrid.GetGridData(i,0) == "-1")
	    {
		    PkArr = PkArr + strComma + idGrid.GetGridData(i,2);
		    strComma = ',';
	    }		
    }
    if (PkArr=='')
    {
	    alert("Select a payment to print");
	    return;
    }
    url = '/reports/gf/ep/gfep00060_remittance_1.aspx?date_fr=' + idSDT.value + "&date_to=" + idEDT.value + "&compk=" + idCOM.GetData() + "&credit_acpk=" + txtACPK_CR.text + "&bank_id=" + idBankAcc.value ;
    System.OpenTargetPage( System.RootURL+url , 'newform' )	;	       
}
//---------------------------------------------------
function OnPrintSheet()
{
var idCom = idCOM.GetData();
var sheet_type = idBankAcc.GetData();
var url = '';
if (idSTATUS.value !="Y")
{
	alert("Cannot print payable voucher");
	return;
}
if (sheet_type ==0)
{
	alert("Please chose a bank account before printing");
	return;
}
var ctrl = idGrid.GetGridControl();
var PkArr = '';
var strComma = '';
for (i=2;i<idGrid.rows;i++)
{
	if (idGrid.GetGridData(i,0) == "-1")
	{
		PkArr = PkArr + strComma + idGrid.GetGridData(i,1);
		strComma = ',';
	}	
}
//var yourname= prompt("PK list_" ,PkArr);	
if (PkArr=='')
{
	alert("Select a payment to print");
	return;
}
var sheet_type_text = idBankAcc.GetText();
var tmpTypeSheetArr = new Array();
tmpTypeSheetArr = sheet_type_text.split(' ');
bankStr = tmpTypeSheetArr[0].toString().substr(0,3);

if (idPrintType.GetData() =="0") //Select All
{
	if (bankStr =="VCB")
	{
		url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
	}
	else
	{
		alert("Please chose a print type");
		return;
	}
}

if (idPrintType.GetData() =="1")//Domestic
		{
		
			switch(bankStr)
			{
				case "VCB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
				case "KEB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_60.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
				case "WRB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_40.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
				case "SHB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_70.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
			}
			
		}
		else if (idPrintType.GetData() =="2")//Oversea
		{
			
			switch(bankStr)
			{
				case "VCB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
				case "KEB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_20.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
				case "WRB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_30.aspx?pk=' + PkArr + '&bankPK=' + sheet_type + "&bank_usd_tp=21&bank_vnd_tp=22&cash_usd_tp=11&cash_vnd_tp=12";
					break;
				case "SHB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_50.aspx?pk=' + PkArr + '&bankPK=' + sheet_type;
					break;
			}
		}
		//alert(System.RootURL+url);
		System.OpenTargetPage( System.RootURL+url , 'newform' )	;	

/*
		if  (idSDT.value != idEDT.value)
		{
			alert('The payment date must be the same');
			return;
		}
		if (flgCust=='' || flgBank=='' )
		{
			alert('Please click on Update before printing');
			return;
		}

		//check for empty grid
		var sheet_type = idBankAcc.GetText();
		var idCom = idCOM.GetData();
		var idCust = flgCust;//idCUST_PK.text;
		var idDate = idSDT.value;
		var idBank = flgBank;//idTAC_BFBENEFICIARY_PK.text;
		var url  ;
		var bankStr = '';
		var tmpTypeSheetArr = new Array();
		tmpTypeSheetArr = sheet_type.split(' ');
		bankStr = tmpTypeSheetArr[0].toString().substr(0,3);
		//alert(bankStr+"---"+tmpTypeSheetArr[1]);
		if (tmpTypeSheetArr[1]=="VND")
		{
			switch(bankStr)
			{
				case "VCB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
				case "KEB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_20.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
				case "WRB":
					break;
				case "SHB":
					break;
			}
			
		}
		else if (tmpTypeSheetArr[1]=="USD")
		{
			switch(bankStr)
			{
				case "VCB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
				case "KEB":
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_20.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			}
		}
		
		*/
		/*
		switch (sheet_type)
		{
			case "10"://payment VCB
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_10.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case "20": //Application for overseas remittance
					 url = '/reports/gf/ep/wabf016000_sheetType_rpt_20.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case "30": // Application for remittance - Woori bank -oversea
				     url = '/reports/gf/ep/wabf016000_sheetType_rpt_30.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case "40":// Withdrawal -woori
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_40.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case "50": //Application for remittance - Shinhan bank
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_50.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case "60" ://KEB Diamond
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_60.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			case  "70" ://Widthrawal-shinhan
					url = '/reports/gf/ep/wabf016000_sheetType_rpt_70.xls?com='+idCom+'&cust='+idCust+'&dtDate='+idDate+'&Bank='+idBank;
					break;
			default :
					alert('Please choose a sheet type');
					break;
		}
		System.OpenTargetPage( System.RootURL+url , 'newform' )	;	
		*/		  	
}
//-------------------------------------------------
var chkAll =true;
function CheckAll()
{
	var ctrl = idGrid.GetGridControl();
	if (idChkAll.value=='T') //check all
	{		
		chkAll = false;
		//idChkAll.SetData("T");		
		for (i=2;i<idGrid.rows;i++)
		{
			if (idGrid.GetGridData(i,17)!="")
			{
				idGrid.SetGridData(i,0,"-1");
			}
			else
			{
				ctrl.TextMatrix(i,0) ="0";
			}
		}
	}
	else //uncheck all
	{
		chkAll = true;
		//alert('unckeck');
		//idChkAll.SetData("F");		
		for (i=2;i<idGrid.rows;i++)
		{
			ctrl.TextMatrix(i,0) ="0";
		}		
	}
}
//-------------------------------------------------
function CheckAll()
{
	var ctrl = idGrid.GetGridControl();
	if (idChkAll.value=='T') //check all
	{		
		chkAll = false;
		//idChkAll.SetData("T");		
		for (i=2;i<idGrid.rows;i++)
		{
			if (idGrid.GetGridData(i,17)!="")
			{
				idGrid.SetGridData(i,0,"-1");
			}
			else
			{
				ctrl.TextMatrix(i,0) ="0";
			}
		}
	}
	else //uncheck all
	{
		chkAll = true;
		//alert('unckeck');
		//idChkAll.SetData("F");		
		for (i=2;i<idGrid.rows;i++)
		{
			ctrl.TextMatrix(i,0) ="0";
		}		
	}	
}
//-------------------------------------------------
function OnPrintPayableList()
{
	var rqt = "?l_compk=" + idCOM.GetData() + '&l_seq=&l_paydue_fr=&l_paydue_to=&l_datefr=' + idSDT.GetData() + '&l_dateto=' + idEDT.GetData() + '&l_tco_buspartner_pk=' + idCUST_PK.GetData() + '&l_voucher_no=' + idVOUCHERNO.GetData() + '&l_tac_abplcenter_pk=&l_type=AL&l_pay_date=&bal_opt=3';
	var url =System.RootURL + '/reports/gf/ep/gfep00020_paylist_cfm.aspx' + rqt;
	if (confirm("Are you sure you want to report ?" ))
	{
		System.OpenTargetPage(url, 'newform');
		return;
	}
}
//-------------------------------------------------
function OnResetCust()
{
	idCUST_PK.text = "";
	idCUST_CD.text = "";
	idCUST_NM.text = "";
}
//-------------------------------------------------
function OnCreditAccount()
{
    var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=G35&val1=Advance To Vendor&val2=C&val3=" + idCOM.GetData() + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR";
    var object      = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');	    
    if(object != null) 
    {
        var tmp = new Array();
        tmp = object[0];
        if(tmp[1] != "0")
        {
            txtACPK_CR.SetDataText(tmp[1]);//acc_pk
            txtACCD_CR.SetDataText(tmp[4]); //acc_cd
            txtACNM_CR.SetDataText( tmp[5]);//acc_nm
        }
    }
}
//-------------------------------------------------
function Reset_CreditAcc()
{
    txtACPK_CR.SetDataText("");
    txtACCD_CR.SetDataText("");
    txtACNM_CR.SetDataText("");
}
//-------------------------------------------------
function OnPrint()
{
    if(lstReport.value == "0")
    {
        OnPrintVoucherSheet();
    }
    else if(lstReport.value == "1")
    {
        OnPrintTransfer();
    }
    else if(lstReport.value == "2")
    {
        OnPrintPayableList();
    }
    else if(lstReport.value == "3")
    {
        var i, l_seq = "";
        for(i = 2; i < idGrid.rows; i++)
        {
            if(idGrid.GetGridData(i, 0) == '-1')
            {
                l_seq = idGrid.GetGridData(i, 2);
            }
        }
        if(l_seq != "")
        {
		    var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq=' + l_seq;
		    if(confirm("Are you sure you want to report ?" ))
		    {
			    System.OpenTargetPage( url , 'newform' );
			    return;
		    }                
        }		    
    }        
}
//-------------------------------------------------
function OnSave()
{
    var i, n = 0, strComma = '', PkArr = '';
    for( i = 2; i < idGrid.rows; i++)
    {
        if(idGrid.GetGridData(i, 0) =="-1")
        {            
            n = n +1;
			PkArr = PkArr + strComma + idGrid.GetGridData(i,2);
			strComma = ',';            
        }
    }
    if(confirm("Are you sure you want to update the payment date is " + dtPayDT.text + "?" ))
    {
        if(PkArr =="")
        {
            alert("Please you select the seq to print accounting slip!");
            return ;
        }
        else
        {
            txt_index.text = n;
            //l_data = l_data.substr(0, l_data.length - 1);
            //alert(PkArr);
            txt_str.SetDataText( PkArr);
            dso_upd_paydate.Call();
        }
    }
}
//-------------------------------------------------
function OnConfirm()
{
    var i , n = 0, strComma = "", PkArr = '';
    for(i = 2; i < idGrid.rows; i++)
    {
        if(idGrid.GetGridData(i, 0) == "-1")
        {            
			PkArr = PkArr + strComma + idGrid.GetGridData(i,2);
			strComma = ',';            
            n = n + 1;
        }
    }
    if(n == 0)
    {
        alert("Please you select the seq to confirm!");
        return ;
    }
    if(confirm("Are you sure you want to confirm the selected payment slip?"))
    {
        txt_index.text = n;
        //l_data = l_data.substr(0, l_data.length - 1);
        txt_str.SetDataText( PkArr);
        dso_confirm_payment.Call();
    }
}
//-------------------------------------------------
function OnChangeStatus()
{
    if(idSTATUS.value == 'N')
    {
        idBtnConfirm.SetEnable(true);
        idBtnSave.SetEnable(true);
    }
    else if(idSTATUS.value == 'Y')
    {
        idBtnConfirm.SetEnable(false);
        idBtnSave.SetEnable(false);        
    }
    search();
}
//-------------------------------------------------
</script>

<body>    
<!--dso_payment-->
<!-------------------------------------------------------------------->
  <gw:data id="gfep00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
					<input bind="txtBank_USD_tp" />
					<input bind="txtBank_VND_tp" />
					<input bind="txtCash_USD_tp" />
					<input bind="txtCash_VND_tp" />										
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>   
	<!--dso_paid-->
<!-------------------------------------------------------------------->	
  <gw:data id="gfep00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060_1" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
					<input bind="txtBank_USD_tp" />
					<input bind="txtBank_VND_tp" />
					<input bind="txtCash_USD_tp" />
					<input bind="txtCash_VND_tp" />										
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>   
<!--dso_WR_KEB_Domestic-->    
<!-------------------------------------------------------------------->	
  <gw:data id="gfep00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060_2" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
					<input bind="txtBank_USD_tp" />
					<input bind="txtBank_VND_tp" />
					<input bind="txtCash_USD_tp" />
					<input bind="txtCash_VND_tp" />										
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
<!--dso_WR_KEB_Oversea-->	
<!-------------------------------------------------------------------->	
  <gw:data id="gfep00060_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060_3" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
					<input bind="txtBank_USD_tp" />
					<input bind="txtBank_VND_tp" />
					<input bind="txtCash_USD_tp" />
					<input bind="txtCash_VND_tp" />					
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
<!--dsql_paid_SH_Domestic-->	
<!-------------------------------------------------------------------->	
  <gw:data id="gfep00060_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060_4" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
<!--dsql_paid_SH_Domestic-->	
<!-------------------------------------------------------------------->	
  <gw:data id="gfep00060_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfep00060_5" > 
                <input bind="idGrid" >                 
                    <input bind="idCOM" />
                    <input bind="idCUST_PK" />
                    <input bind="idSDT" />
                    <input bind="idEDT" />
					<input bind="idVOUCHERNO" />
					<input bind="idBankAcc" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
<!-------------------------------------------------------------------->	
    <gw:data id="dso_confirm_payment" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_CONFIRM_PAYMENT" > 
                <input> 
                     <input bind="txt_str"/>
                     <input bind="idCOM"/>
                     <input bind="txt_index"/>
                </input>  
                <output>  
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------->	
    <gw:data id="dso_upd_paydate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_UPD_DATE_PAYMENT" > 
                <input> 
                     <input bind="txt_str"/>
                     <input bind="idCOM"/>
                     <input bind="txt_index"/>
                     <input bind="dtPayDT"/>
                </input>  
                <output>  
                     <output bind="txtStatus"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<gw:data id="dso_getCompany" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="ACNT.sp_sel_gfac00100_1" > 
                <input> 
                     <input bind="txtUser_PK"/>
                </input>
                <output>
                     <output bind="idCOM"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>    
<!-------------------------------------------------------------------->	
<table class="table" width="100%" cellpadding="0" cellspacing="0" border="1" ID="Table1">
	<tr>
		
		<td width="100%">
					<!-- Table2 contain detail buttons and text box -->
					<table id="RightBottomTB" width="100%" cellpadding="0" cellspacing="0" height="100%"  align="top"  >
						
							<tr><!------>
								<td width="10%" bgcolor="" align="right"><font color="black" ><b>Company&nbsp;</b></font></td>
								<td width="40%">
										<table  width="100%" ID="Table2">
											<tr>
												<td width="40%">
													<gw:list id="idCOM" onChange="" styles='width:100%'> 														
													</gw:list >
												</td>
												<td width="25%" bgcolor="" align="center"><font color="black" ><b>Status&nbsp;</b></font></td>
												<td width="35%">
													<gw:radio id="idSTATUS" value="Y" onchange="OnChangeStatus()"> 
														<span value="N" >Saved&nbsp;</span>
														<span value="Y" >Confirmed  &nbsp;</span>
													</gw:radio >	
											</tr>
										</table>
								</td>
								<td width="10%" bgcolor="" align="right"><font color="black" ><a title="Click to select Customer" href="#tips" onclick="OnPopUp('1')"><b>Customer&nbsp;</b></a></font></td>
								<td width="40%" >
									<table  width="100%" ID="Table3">
										<tr>
											<td width="5%" align="left"></td>										
											<td width="90%">
											<gw:textbox id="idCUST_PK" text=""  styles="display:none"/>									
											<gw:textbox id="idCUST_CD" styles='width:25%'/>
											<gw:textbox id="idCUST_NM" styles='width:74%'/>
											</td>
											<td width="5%" align="left"><gw:imgBtn id="ibtnResetClient" img="reset"  alt="reset Customer" onclick="OnResetCust()" /></td>																					
										</tr>
									</table>
								</td>
							</tr> 
							<tr>
								<td width="10%" bgcolor="" align="right"><font color="black" ><b>Payment Date&nbsp;</b></font></td>
								<td width="50%" colspan="2">
										<table  width="100%" ID="Table4">
											<tr>
												<td width="30%"><gw:datebox id="idSDT" 	onchange="" styles='width:85%'  lang="<%=Session("Lang")%>"/></td>
												<td width="10%" align="center"><font color="black" ><b>~&nbsp;</b></font></td>
												<td width="30%"><gw:datebox id="idEDT" 	onchange=""styles='width:85%'  lang="<%=Session("Lang")%>"/></td>
												<td width="30%" bgcolor="" align="right"><font color="black" ><b>Voucher No <!-- Beneficicary's Bank -->&nbsp;</b></font></td> 
											</tr>
										</table>
								</td>
								<td width="40%" >
									<gw:textbox id="idTAC_BFBENEFICIARY_PK" text=""  styles="display:none"/>									
									<gw:textbox id="idBENEFICIARY_CD" styles='width:25%;display:none;'/>
									<gw:textbox id="idBENEFICIARY_NM" styles='width:74%;display:none;'/>
								<table  width="100%" ID="Table5">
										<tr>										 
											<td width="30%" align=left><gw:textbox id="idVOUCHERNO" styles='width:90%'/></td>
											<td width="30%" align=left>
											    <gw:datebox id="dtPayDT" lang="1" />
											</td>											
											<td width="5%" align="left"><gw:imgBtn	id="idBtnSave"  	img="save" 	text="Save" style="display:none;" onclick="OnSave()" /></td>
											<td width="5%" align="right"><gw:icon 	id="idBtnConfirm" 	img="in" 	style="display:none;"	text="Confirm" onclick="OnConfirm()" /></td>
											<td width="5%" align="left"><gw:imgBtn id="idSearch"   	img="search" 	alt="search" 	text="Search" 		onclick="search()"/></td>
											<td width="5%" align=right><gw:imgBtn id="ibtnPrint" 		img="printer" 	alt="Payable List" 					onclick="OnPrint()" /></td>			
											
										</tr>
									</table>
								</td>
							</tr>	
						<tr> 
                            <td width="10%"  align="right"><font color="black" ><b>Bank Account &nbsp;</b></font></td>
                            <td width="40%" align="left">
                                <table width="100%" border="0" cellspacing="0" ID="Table6">
                                    <tr>
									    <td width="30%" align="left">
										    <gw:list id="idBankAcc" onChange="onchangeBank()" styles='width:90%' > 											
										    </gw:list >
									    </td>		
									    <td width="20%" align="right">Report&nbsp;</td>	                    
    				                    <td width="50%">
					                        <gw:list id="lstReport" >
					                            <data>DATA|0|Voucher Thanh toán|1|Transfer List|2|Payable List|3|Accounting Slip</data>
					                        </gw:list>
				                        </td>									    
                                    </tr>    
                                </table>
                          </td>
                          <td width="10%" align="left"></td>      
                          <td width="30%" align="left">
		                    <table width="100%" border="0" cellspacing="0">
			                    <tr>
									    <td width="30%" align="right"><a title="Click here to select account code" href="#tips" onclick="OnCreditAccount()">Credit Acc.</a></td>
										<td width="25%" align="left"> 
										   <gw:textbox id="txtACCD_CR" styles='width:100%' />										    
                                        </td>										   
									    <td width="35%" align="left">
									        <gw:textbox id="txtACNM_CR" styles='width:100%' />
									    </td>    
									    <td><gw:imgBtn   img="reset"	id="idResetAccCR"  alt="Reset" onclick="Reset_CreditAcc()"/></td>                                        
			                    </tr>
		                    </table>	                            
                          </td>
                          <td width="10%" align="left"></td>
                        </tr>  
				        <tr>
					        <td width="10%" bgcolor="" align="right"><font color="black" ><b>Check All&nbsp;</b></font></td>
					        <td width="70%" colspan="3" align="left"><gw:checkbox id="idChkAll" value="T" onchange="CheckAll()" /> </td>
							<td width="10%"align="right"><b><gw:label id="lblRecord" text="" style="width:80%" /></b></td>
							
							<td width="10%">&nbsp;<b>Records</b></td>					        
				        </tr>                          
					</table>		    			
					<!-- End of Table2 -->					
		</td>
	</tr>
	<tr>		
		<td width="100%">
			<!-- Table2 contain detail grid -->
			<gw:grid   
					id="idGrid"  
					header="CHK|_PPK|HPK|VOUCHER_NO|TR_DATE|SIGN_DATE|TR_DATE_SEQ|PL_NM|TR_REMARK|_TR_REMARK2 |_CUST_ID|CUST_NM|TR_FAMT|TR_AMT|INVOICE_DATE|INVOICE_NO|DUE_DATE|BEN_NAME|BEN_BANK|Debit Account|Credit Account"   
					format="3|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
					aligns="0|0|0|0|1|1|0|0|0|0|0|0|3|3|3|3|3|0|0|1|0"  
					defaults="||||||||||||||||||||"  
					editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0"  
					widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
					styles="width:100%; height:320"   
					sorting="T"   
					param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" 						
				/> 						
		</td>
	</tr>	
</table>
<gw:textbox id="txtBank_USD_tp" text="03" styles="display:none;" />
<gw:textbox id="txtBank_VND_tp" text="04" styles="display:none;" />
<gw:textbox id="txtCash_USD_tp" text="01" styles="display:none;" />
<gw:textbox id="txtCash_VND_tp" text="02" styles="display:none;" />
<gw:list id="idPrintType" onChange="onDomesticOversea()" style='width:75%; display:none;' > 
<data>DATA|0|Select All|1|Domestic|2|Oversea</data> 
</gw:list >
<gw:textbox id="txtACPK_CR" styles="display:none;" />
<gw:textbox id="txt_index" styles="display:none;" />
<gw:textbox id="txt_str" styles="display:none;" />
<gw:textbox id="txtStatus" styles="display:none;" />
<gw:textbox id="txtUser_PK" styles="display:none;" />
</body>
</html>