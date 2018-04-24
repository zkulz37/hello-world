<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Cashbook Entry</title>
    <%ESysLib.SetUser("acnt")%>
  </head>
 <script>
 //---------------------------------------------------------
var t_Debit = 'D';
var t_Credit = 'C';

var t_master_pk = "";
var t_company_pk = "";
var t_transdate = "";
var t_acct_pk = "";
var t_bank_pk = "";
var t_acct_code = "";
var t_acct_name = "";
var t_bank_code = "";
var t_bank_name = "";
var t_ccy = "";
var t_status_control = 0;
var t_search =0;
 function BodyInit()
 { 
    System.Translate(document);  
    var ls_bookccy = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y' ")%>";
    lstBookCcy.SetDataText(ls_bookccy);   
	lstReportType.SetDataText("DATA|0|Monthly|1|Non-Book CCY|2|Internal Report|3|ALL");
    BindingDataList();
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
    var data1 = "<%= ESysLib.SetListDataSQL(" select pk,PARTNER_NAME from tco_company where del_if = 0") %>";
    //var data2 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('PRDI0020','','') FROM DUAL")%>"; 
    lstCompany.SetDataText(data1);  
    //cboAdjType.SetDataText(data2); 
    txtBankPK.SetEnable(false);
    txtBankCode.SetEnable(false);
    txtBankName.SetEnable(false);
    
    txtAccPK.SetEnable(false);
    txtAccCode.SetEnable(false);
    txtAccName.SetEnable(false);
   formatGridDetail(); 
    t_master_pk = "";
    t_company_pk = "";
    t_transdate = "";
    t_acct_pk = "";
    t_bank_pk = "";
    t_acct_code = "";
    t_acct_name = "";
    t_bank_code = "";
    t_bank_name = "";
    t_ccy = "";
   t_search = 0; 
 }

//--------------------------------------------------------------------
 function OnDataReceive(obj)
  {
        switch(obj.id)
        {
            case "datCashbook_Master":   
               //alert("datCashbook_Master " + txtCashbook_PK.text+"--"+txtAccPK.text);
                txtAccCode.text = t_acct_code;
                txtAccName.text = t_acct_name;
               if (t_status_control==0)
               { 
                    //datCashbook_Detail.Call("SELECT");
                    //datCashbook_Detail.Call();
                }
               if ( t_status_control==1) //Save
               { 
                    t_status_control =0;
                    checkGridDetail();
                }
            break;
         }
  }
  //--------------------------------------------------------------------
  function OnDataError(obj)
  {
        alert("Error !"+obj.id);
        switch(obj.id)
        {
            case "datCashbook_Master":       
           alert("Error : datCashbook_Master "+ txtCashbook_PK.text+"--");
             atemp = obj.errmsg;
               ermsg =  new Array();
               ermsg = atemp.split('#');
               alert(ermsg[1]);
            break;
         }
  }
  
  function onResetAcc()
  {
        txtAccPK.text ="";
        txtAccCode.text ="";
        txtAccName.text ="";
        t_acct_pk = "";
        t_acct_code = "";
        t_acct_name = "";
        onResetBank();
  }
  
  function onResetBank()
  {
        txtBankPK.text = "";
        txtBankCode.text = "";
        txtBankName.text = "";
        t_bank_pk = "";
		t_bank_code = "";
		t_bank_name = "";
  }
  
function formatGridDetail()
{
    if(grdCashBookDetail.rows <2)
    {
        grdCashBookDetail.AddRow();
    } 
    var fg=grdCashBookDetail.GetGridControl();

    if (t_search==1)
   { 
        fg.Cell(0, 2, 27, 2, 27) = "";
        fg.FixedRows = 3;
        t_search = 0;
     }
     else
     {
        fg.FixedRows = 2;
     }
    fg.MergeCells = 5;
    fg.MergeRow(0) = true;

    fg.Cell(0, 0, 0, 0, 0) = "_PK";    
    fg.Cell(0, 0, 1, 0, 1) = "_TAC_BGCASH_PK";
    fg.Cell(0, 0, 2, 0, 2) = "_TAC_ABACCTCODE_PK"; 
   
   fg.MergeCol(3) = true;
   fg.Cell(0, 0, 3, 1, 3) = "Trans. Date"; 
    //
    fg.Cell(0, 0, 4, 0, 5) = "Account"; 
    fg.Cell(0, 1, 4, 1, 4) = "Code"; 
    fg.Cell(0, 1, 5, 1, 5) = "Name"; 

    fg.Cell(0, 0, 6, 0, 7) = "Description"; 
    fg.Cell(0, 1, 6, 1, 6) = "Foreign"; 
    fg.Cell(0, 1, 7, 1, 7) = "Local"; 
   
    fg.MergeCol(8) = true;
    fg.Cell(0, 0, 8, 1, 8) = "Invoice No"; 
    
    fg.MergeCol(9) = true;
    fg.Cell(0, 0, 9, 1, 9) = "Detail";
    
   fg.Cell(0, 0, 10, 0, 10) = "_TCO_DCCUST_PK";  
   fg.Cell(0, 0, 11, 0, 11) = "_CUST_ID";  
   fg.MergeCol(12) = true;
   fg.Cell(0, 0, 12, 1, 12) = "Client";  
   
   fg.Cell(0, 0, 13, 0, 15) = "Transaction"; 
   fg.Cell(0, 1, 13, 1, 13) = "Receipt"; 
   fg.Cell(0, 1, 14, 1, 14) = "Payment"; 
   fg.Cell(0, 1, 15, 1, 15) = "Balance"; 
   
   fg.MergeCol(16) = true;
   fg.Cell(0, 0, 16, 1, 16) = "Voucher No";
   
   fg.Cell(0, 0, 17, 0, 17) = "_DRCR_TYPE";
   fg.Cell(0, 0, 18, 0, 18) = "_TR_CCY";
   
   fg.MergeCol(19) = true;
   fg.Cell(0, 0, 19, 1, 19) = "Ex.Rate";
   
   fg.Cell(0, 0, 20, 0, 22) = "Books"; 
   fg.Cell(0, 1, 20, 1, 20) = "Receipt"; 
   fg.Cell(0, 1, 21, 1, 21) = "Payment"; 
   fg.Cell(0, 1, 22, 1, 22) = "Balance"; 
   
   fg.Cell(0, 0, 23, 0, 24) = "PL"; 
   fg.Cell(0, 1, 23, 1, 23) = "Type"; 
   fg.Cell(0, 1, 24, 1, 24) = "Date(YYYYMM)"; 
   
   fg.Cell(0, 0, 27, 0, 28) = "Approved"; 
   fg.Cell(0, 1, 27, 1, 27) = "Y/N"; 
   fg.Cell(0, 1, 28, 1, 28) = "Date"; 
   
    fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
    fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; 
   
    fg.ColWidth(0)=0;//_PK
    fg.ColWidth(1)=0;//_TAC_BGCASH_PK
    fg.ColWidth(2)=0;//_TAC_ABACCTCODE_PK

    fg.ColWidth(3)=1100;//Trans date
    
    fg.ColWidth(4)=0;//1500;//Account Code
    fg.ColWidth(5)=0;//2000;//Account Name

    fg.ColWidth(6)=2700;//Description Foreign
    fg.ColWidth(7)=0;//1000;//Description Local

    fg.ColWidth(8)=0;//1000;//Invoice No
    fg.ColWidth(9)=0;//1000;//Detail

    fg.ColWidth(10)=0;//_TCO_DCCUST_PK
    fg.ColWidth(11)=0;//_CUST_ID

    fg.ColWidth(12)=0;//1000;//Client
   
    fg.ColWidth(16)=0;//1000;//Voucher No
    fg.ColWidth(17)=0;//_DRCR_TYPE
    fg.ColWidth(18)=0;//_TR_CCY

    fg.ColWidth(19)= 1000;//Ex.Rate   
   if (rdoAmountType.value=="2")//Books
    {
		   fg.ColWidth(13)=1500;//Receipt
		   fg.ColWidth(14)=1500;//Payment
		   fg.ColWidth(15)=1500;//Balance 
	
		   fg.ColWidth(20)=1500;//Receipt
		   fg.ColWidth(21)=1500;//Payment
		   fg.ColWidth(22)=1500;//Balance
    }
    else
    {
           fg.ColWidth(13)=2000;//Receipt
           fg.ColWidth(14)=2000;//Payment
           fg.ColWidth(15)=2000;//Balance 
            
            fg.ColWidth(20)=0;//Receipt
            fg.ColWidth(21)=0;//Payment
            fg.ColWidth(22)=0;//Balance
    } 
   
    fg.ColWidth(23)=1000;//PL Type
    fg.ColWidth(24)=1500;//PL Date(YYYYMM)
    fg.ColWidth(25)=0;//TRANS AMT
    fg.ColWidth(26)=0;//BOOKS AMT
    fg.ColWidth(27)=500;//APP_YN
    fg.ColWidth(28)=1500;//APP_DATE
   fg.ColWidth(29)=0;//TRANS DATE
    //Format data type
   if(t_ccy != "VND")
	{
		fg.ColFormat(13)   = "#,###,###.##";			
		fg.ColFormat(14)   = "#,###,###.##";		
		fg.ColFormat(15)   = "#,###,###.##";	
	}
	else
	{
		fg.ColFormat(13)   = "#,###,###,###,###";
		fg.ColFormat(14)   = "#,###,###,###,###";			
		fg.ColFormat(15)   = "#,###,###,###,###";	
	}
	if(lstBookCcy.GetData() != "VND")
	{
		fg.ColFormat(20)   = "#,###,###.##";	
		fg.ColFormat(21)   = "#,###,###.##";			
		fg.ColFormat(22)   = "#,###,###.##";		
	}
	else
	{
		fg.ColFormat(20)   = "#,###,###,###,###";			
		fg.ColFormat(21)   = "#,###,###,###,###";	
		fg.ColFormat(22)   = "#,###,###,###,###";
	}
	fg.ColFormat(19)   = "#,###,###,###,###";//Ex.Rate
	fg.ColAlignment(19) = flexAlignRightCenter;
	fg.ColAlignment(13) = flexAlignRightCenter;
	fg.ColAlignment(14) = flexAlignRightCenter;
	fg.ColAlignment(15) = flexAlignRightCenter;
	fg.ColAlignment(20) = flexAlignRightCenter;
	fg.ColAlignment(21) = flexAlignRightCenter;
	fg.ColAlignment(22) = flexAlignRightCenter;
	
}

function onChangeFormat()
{
      var fg=grdCashBookDetail.GetGridControl();
      if (rdoAmountType.value=="2")//Books
        {
               fg.ColWidth(13)=1500;//Receipt
               fg.ColWidth(14)=1500;//Payment
               fg.ColWidth(15)=1500;//Balance 
        
               fg.ColWidth(20)=1500;//Receipt
               fg.ColWidth(21)=1500;//Payment
               fg.ColWidth(22)=1500;//Balance
        }
        else
        {
               fg.ColWidth(13)=2000;//Receipt
               fg.ColWidth(14)=2000;//Payment
               fg.ColWidth(15)=2000;//Balance 
                
                fg.ColWidth(20)=0;//Receipt
                fg.ColWidth(21)=0;//Payment
                fg.ColWidth(22)=0;//Balance
        } 
}

function onGetAcc()
{
    var fpath = System.RootURL + "/form/gf/co/ffco001000.aspx?col_nm=Account Name&col_code=Account Code&company=" + lstCompany.value + '&comm_code=&comm_nm=&'+"&val1=" + '' + "&val2=" + '' + "&val3=" + '' + "&dsqlid=ACNT.sp_sel_cashb_acc";
    var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
    if (aValue != null)
    {
        if(aValue[0] != 0)
        {
                t_acct_pk =  aValue[2];
                t_acct_code = aValue[0];
                t_acct_name =  aValue[1];
                t_ccy = aValue[3];
                txtAccPK.text = aValue[2];
                txtAccCode.text = t_acct_code;
                txtAccName.text = t_acct_name;
                t_transdate = dtbFromDate.value;				
				var code = t_acct_code.substr(0, 3);
                if (code == '112')
			    {
                        onGetBank();
			    } else
			    {
			            onResetBank();
						OnSearch();
			    }		
        }
    }
}

function onChangeCompany()
{
   grdCashBookDetail.ClearData();
   formatGridDetail();  
   onResetAcc();
   onResetBank();
}
function onGetBank()
{
    t_company_pk = lstCompany.value;
    var code = t_acct_code.substr(0, 3);
    if (code != '112')
	{
		alert("This is not Cash In Bank Account Code!");
		return;
	}
	var fpath = System.RootURL + "/form/gf/co/ffco001000.aspx?col_nm=Bank Name&col_code=Bank Code&company=" + lstCompany.value + '&comm_code=&comm_nm=&'+"&val1=" + t_ccy+ "&val2=" + '' + "&val3=" + '' + "&dsqlid=acnt.sp_sel_cb_bank_info";
    var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
    if (aValue != null)
    {
        if(aValue[0] != "")
        {
            txtBankPK.text = aValue[2];
            txtBankCode.text = aValue[0];
            txtBankName.text = aValue[1];
            
            t_bank_pk = aValue[2];
            t_bank_code = aValue[0];
            t_bank_name = aValue[1];
        }
        else
        {
            onResetAcc();
        }
		OnSearch();
     }
}

function onGridDbClick()
{
    if (event.row<3)
   {
        return;
   } 
    var fpath="";
    var fg =grdCashBookDetail.GetGridControl();
    var crow = grdCashBookDetail.row;
   if (event.col==4 || event.col==5) //Account code, name,pk
   {
        fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
        var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if (aValue != null)
        {
            if(aValue[0] != "")
            {
                grdCashBookDetail.SetGridText(crow,4,aValue[0]);
                grdCashBookDetail.SetGridText(crow,5,aValue[1]);
                grdCashBookDetail.SetGridText(crow,3,aValue[3]);
            }
        }
        return;
   } 
   
   if (event.col==12) //Client
   {
        fpath = System.RootURL + "/form/gf/co/ffbp00031.aspx";
        var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if (aValue != null)
        {
            if(aValue[0] != "")
            {
                grdCashBookDetail.SetGridText(crow,10,aValue[0]);//TCO_DCCUST_PK
                grdCashBookDetail.SetGridText(crow,11,aValue[1]);//CUST_ID
                grdCashBookDetail.SetGridText(crow,12,aValue[2]);//CUST_NAME
            }
        }
        return;
   }

   if (event.col==19)//books debit amt
   {
        
   }
   
   if(event.col==18)//Exchange rate
   {
        
   }
   
   
}

function onGridAfterEdit()
{
     if(event.row==2)
     {
           if (event.col==6)//remark
          {
                 grdCashBookDetail.SetGridText(event.row, 6, "Carry Forwarded");
                 return;
          } 
          if ((event.col==15) ||(event.col==22)) 
         {
                return;
         }
         grdCashBookDetail.SetGridText(event.row, event.col, "");
         return;
   }
   
   if(event.col==27)//App YN
   {
        chk = "" + grdCashBookDetail.GetGridData(event.row,27);
        if (chk!='-1')
        {
            grdCashBookDetail.SetGridText(event.row, 28, "");
        }
        
   }
   if(event.col==28)//Approved date
   {
   }
}

function CalculateBookAmt(TranAmt, Rate)
{
	var BookAmt = 0;
	if (lstBookCcy.GetData() != "VND")
	{
		BookAmt = Math.round(TranAmt / Rate * 100) / 100;
	} else
	{
		BookAmt = Math.round(TranAmt * Rate);
	}
	return BookAmt;
}
function CalculateBalance()
{
	var ctrl         = grdCashBookDetail.GetGridControl();
	for (i = 3; i < ctrl.rows; i++ )
	{
		var BalanceAmount = 0;
		var LastBalanceAmount = Number(grdCashBookDetail.GetGridData(i - 1, 15));
		
		var DebitAmountTemp  = grdCashBookDetail.GetGridData(i, 13);
		if (DebitAmountTemp == '') 
		{
			DebitAmountTemp = 0;
		}
		DebitAmountTemp = Number(DebitAmountTemp);
		var CreditAmountTemp = grdCashBookDetail.GetGridData(i, 14);
		if (CreditAmountTemp == '') 
		{
			CreditAmountTemp = 0;
		}
		CreditAmountTemp = Number(CreditAmountTemp);
		BalanceAmount = LastBalanceAmount + DebitAmountTemp - CreditAmountTemp;
		grdCashBookDetail.SetGridText(i, 15, Number(BalanceAmount));        
	}
}

function CalculateBalanceBook()
{
	var ctrl  = grdCashBookDetail.GetGridControl();
	for (i = 3; i < ctrl.rows; i++ )
	{
		var BalanceAmount = 0;
		var LastBalanceAmount = Number(grdCashBookDetail.GetGridData(i - 1, 22));
		
		var DebitAmountTemp  = grdCashBookDetail.GetGridData(i, 20);
		if (DebitAmountTemp == '') 
		{
			DebitAmountTemp = 0;
		}
		DebitAmountTemp = Number(DebitAmountTemp);
		var CreditAmountTemp = grdCashBookDetail.GetGridData(i, 21);
		if (CreditAmountTemp == '') 
		{
			CreditAmountTemp = 0;
		}
		CreditAmountTemp = Number(CreditAmountTemp);
		BalanceAmount = LastBalanceAmount + DebitAmountTemp - CreditAmountTemp;
		grdCashBookDetail.SetGridText(i, 22, Number(BalanceAmount));        
	}
}

function isNumber(val)
{
	if (isNaN(val))
	{
		return false;
	} else
	{
		return true;
	} 
}


function OnSave()
{
       grdCashBookDetail.SetRowStatus(0,0);
        grdCashBookDetail.SetRowStatus(1,0);
        grdCashBookDetail.SetRowStatus(2,0); 
       if (confirm("Do you want to save ?"))
        {
            t_search =1;
            datCashbook_Inquiry.Call();
        }
}

function onReceiveDetail()
{
        ctrl = grdCashBookDetail.GetGridControl();
        
        grdCashBookDetail.SetGridText(2, 3, "");//Trans date
		grdCashBookDetail.SetGridText(2, 12, "");
		grdCashBookDetail.SetGridText(2, 13, "");//Trans debit
		grdCashBookDetail.SetGridText(2, 14, "");//Trans credit
		grdCashBookDetail.SetGridText(2, 18, "");
		grdCashBookDetail.SetGridText(2, 19, "");
		grdCashBookDetail.SetGridText(2, 20, "");//Book debit
		grdCashBookDetail.SetGridText(2, 21, "");//Book credit
		grdCashBookDetail.SetGridText(2, 28, "");//Book credit
		
		for (i = 3; i < ctrl.rows; i++ )
		{
			var amount = grdCashBookDetail.GetGridData(i, 25); // Get Transaction Amt
			var amountbook = grdCashBookDetail.GetGridData(i, 26); // Get Transaction Amt Book
			var dr_cr  = grdCashBookDetail.GetGridData(i, 17); // Get DR_CR Type
			if (dr_cr == 'C')
			{
				grdCashBookDetail.SetGridText(i, 13, amount);        // Set Debit Amount On Grid
				grdCashBookDetail.SetGridText(i, 14, "0");
				grdCashBookDetail.SetGridText(i, 20, amountbook);        // Set Debit Amount On Grid
				grdCashBookDetail.SetGridText(i, 21,"0");
			} else
			{
			    grdCashBookDetail.SetGridText(i, 13, "0");
				grdCashBookDetail.SetGridText(i, 14, amount);        // Set  Amount On Grid
				grdCashBookDetail.SetGridText(i, 20,"0");
				grdCashBookDetail.SetGridText(i, 21, amountbook);        // Set Credit Amount On Grid
			}
		}
		CalculateBalance();
		CalculateBalanceBook();
        formatGridDetail(); 
}

function checkGridDetail()
{
        grdCashBookDetail.SetRowStatus(0,0);
        grdCashBookDetail.SetRowStatus(1,0);
        grdCashBookDetail.SetRowStatus(2,0); 
        for(i=3;i<grdCashBookDetail.rows;i++)
        {
            //if ((grdCashBookDetail.GetGridData(i, 0) == '')&&(grdCashBookDetail.GetRowStatus(i) != 64)&&(grdCashBookDetail.GetRowStatus(i) != 96)&&(grdCashBookDetail.GetRowStatus(i) != 112)&&(grdCashBookDetail.GetRowStatus(i) != 80))
            if (grdCashBookDetail.GetGridData(i, 0) == '')
				{	
					grdCashBookDetail.SetGridText(i, 1, txtCashbook_PK.text);  
					grdCashBookDetail.SetGridText(i, 18, t_ccy);  // Set Ccy on Grid
					//grdCashBookDetail.SetRowStatus(i, 0x20);					 // status grid is ADD
				}
        }
//        datCashbook_Detail.Call();//save detail
}


function OnSearch()
{
    t_search =1;
    datCashbook_Inquiry.Call("SELECT");
}
function OnReport()
{
	if (txtAccPK.text =='')
	{
		alert("Please select an account!");
		return;
	}
	var rqt = "";
	rqt = "?company_pk="+lstCompany.value+'&from_date='+dtbFromDate.value+'&acc_pk='+txtAccPK.text+'&bank_pk='+txtBankPK.text+'&to_date='+dtbToDate.value;
	switch (lstReportType.value)
	{
		case "0" :
			url =System.RootURL + '/reports/bd/fc/bdfc0002_Month.aspx'+rqt;
			System.OpenTargetPage(url, "newform" );

			break;
		case "1" :
			url =System.RootURL + '/reports/bd/fc/bdfc0002_OtherCCy.aspx'+rqt;
			System.OpenTargetPage(url, "newform" );
			break;
		case "2" :
			url =System.RootURL + '/reports/bd/fc/bdfc0002_Internal.aspx'+rqt;
			System.OpenTargetPage(url, "newform" );
			break;
		case "3" :
			url =System.RootURL + '/reports/bd/fc/bdfc0002_All.aspx'+rqt;
			System.OpenTargetPage(url, "newform" );
			break;
	}
	
}
 </script>
<body >

<gw:data id="datCashbook_Inquiry" onreceive="onReceiveDetail()" onerror="OnDataError(this)" >
    <xml> 
    <dso id="3" type="grid" user="acnt" parameter="0,3,23,24,27,28,29"  function="acnt.SP_SEL_CASHBOOKD_INQ" procedure="acnt.SP_UPD_CASHBOOKD_INQ" > 
   <input bind="grdCashBookDetail" >
        <input bind="lstCompany" />
        <input bind="dtbFromDate" /> 
        <input bind="dtbToDate" /> 
        <input bind="txtAccPK" /> 
        <input bind="txtBankPK" />
    </input> 
    <output bind="grdCashBookDetail" />
    </dso>
    </xml>
</gw:data>

   <table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
            <td width="10%" align="right">Company</td>
            <td width="16%"><gw:list id="lstCompany" styles="width:100%;" onchange="onChangeCompany()"></gw:list></td>
            <td width="10%" align="right">Acc. Code</td>
            <td width="10%">
                        <gw:textbox id="txtAccPK" text="" maxlen = "6" styles='display:none;'/>
                        <gw:textbox id="txtAccCode" text="" maxlen = "6" styles='width:100%'/></td>
            <td width="20%"><gw:textbox id="txtAccName" text="" maxlen = "100" styles='width:100%'/></td>
          <td width="2%"><gw:imgBtn id="btnGetAcc" img="popup" alt="Get Account" onclick="onGetAcc()"/></td>
          <td width="2%"><gw:imgBtn id="btnResetAcc" img="reset" alt="Reset Account" onclick="onResetAcc()" /></td>
          <td width="10%"  align="right">Report Type</td>
         <td width="20%" align="right">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
						<td width="60%">
						<gw:list id="lstReportType" styles="width:100%;"></gw:list>
						</td>
                            <td><gw:imgBtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                           <td><gw:imgBtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" /></td>
                           <td><gw:imgBtn id="ibtnPrint" img="printer" alt="Print" onclick="OnReport()" /></td> 
                    </tr>
                </table>
         </td> 
      </tr>
         <tr>
            <td align="right">Trans Date</td>
            <td >
                <table border="0" cellpadding="0" cellspacing="0">
                   <tr>
				   <td><gw:datebox id="dtbFromDate" lang="<%=Application("Lang")%>" mode="01"  /></td>
				   <td>&nbsp;~&nbsp;</td>
				   <td><gw:datebox id="dtbToDate" lang="<%=Application("Lang")%>" mode="01" /></td>
                   </tr>
                </table>
            </td>
            <td align="right">Bank Code</td>
            <td>
                        <gw:textbox id="txtBankPK" text="" maxlen = "6" styles='display:none;'/>
                        <gw:textbox id="txtBankCode" text="" maxlen = "6" styles='width:100%'/></td>
            <td><gw:textbox id="txtBankName" text="" maxlen = "100" styles='width:100%'/></td>
          <td><gw:imgBtn id="btnGetBank" img="popup" alt="Get Bank" onclick="onGetBank()"/></td>
          <td><gw:imgBtn id="btnResetBank" img="reset" alt="Reset Bank" onclick="onResetBank()" /></td>
          <td align="right">Amount Type</td>
         <td>
         <gw:radio id="rdoAmountType" value="1" onchange="onChangeFormat()"> 
            <span value="1" > Trans</span>
            <span value="2" >Trans & Books</span>
        </gw:radio >
         </td> 
      </tr>
      <tr>
      <td colspan="9">
      <script language="javascript">
      document.writeln("<gw:grid id='grdCashBookDetail'");
document.writeln("header='_PK|_TAC_BGCASH_PK|_TAC_ABACCTCODE_PK|TR_DATE|AC_CD|AC_NM|REMARK|REMARK2|INVOICE_NO|REMARK_DETAIL|TCO_DCCUST_PK|CUST_ID|CUST_NAME|RECEIPT|PAYMENT|BALANCE|VOUCHER_NO|_DRCR_TYPE|_TR_CCY|TR_EXRATE|RECEIPT|PAYMENT|BALANCE|PL_TYPE|PL_YYYYM|_TRANS_AMT|_BOOKS_AMT|APP_YN|APP_DATE|_TRANS_DATE'");
document.writeln("format='0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|4|0'");
document.writeln("aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|2|2|2|0|0|0|0|2|2|2|0|0|0|0|0|0|0'");
document.writeln("defaults='|||||||||||||||||||||||||||||'");
document.writeln("editcol='0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1'");
document.writeln("widths='1000|1000|1000|0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0|0|0|0'");
document.writeln("sorting='F'");
document.writeln("styles='width:100%; height:420'");
document.writeln(" acceptNullDate='true'");
document.writeln(" acceptNullDate='true'");
document.writeln("oncelldblclick='onGridDbClick()'");
document.writeln("onafteredit='onGridAfterEdit()' />");
</script>
      </td>
      </tr>
    </table>
   
   <gw:textbox id="txtCheckExist" text="" styles='display:none;'/> 
   <gw:textbox id="txtCashbook_PK" text="" styles='display:none;'/> 
   <gw:textbox id="txtBalance_Trans" text="" styles='display:none;'/> 
   <gw:textbox id="txtBalance_Books" text="" styles='display:none;'/> 
   <gw:list id="lstBookCcy" styles="display:none;" ></gw:list>
</body>
</html>



