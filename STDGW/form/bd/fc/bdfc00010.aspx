<!-- #include file="../../../system/lib/form.inc"  -->
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
 function BodyInit()
 { 
   System.Translate(document); 
    var ls_bookccy = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y' ")%>";
    lstBookCcy.SetDataText(ls_bookccy);   
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
                    datCashbook_Detail.Call("SELECT");
                    //datCashbook_Detail.Call();
                }
               if ( t_status_control==1) //Save
               { 
                    t_status_control =0;
					CalculateRaising();
                    checkGridDetail();
                }
            break;
            
            case "datCashbook_Balance":
                formatGridDetail();
                grdCashBookDetail.AddRow();
                grdCashBookDetail.SetGridText(2,5,'Carry Forwarded');
                grdCashBookDetail.SetGridText(2,14,""+txtBalance_Trans.text);
                grdCashBookDetail.SetGridText(2,21,""+txtBalance_Books.text); 
				
				//Total Row
				for(i=grdTotal.rows;i<3;i++)
				{
					grdTotal.AddRow();
				}
				grdTotal.SetGridText(2,0,""+txtBalance_Trans.text);
                grdTotal.SetGridText(2,1,""+txtBalance_Books.text);
				grdTotal.SetGridText(2,2,"0");
                grdTotal.SetGridText(2,3,"0"); 
				grdTotal.SetGridText(2,4,"0");
				grdTotal.SetGridText(2,5,"0");
				grdTotal.SetGridText(2,6,""+txtBalance_Trans.text);
				grdTotal.SetGridText(2,7,""+txtBalance_Books.text);
				
            break;
         }
  }
  //--------------------------------------------------------------------
  function OnDataError(obj)
  {
        alert("Error "+obj.id+' - ' +obj.errmsg);
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
		if ((txtAccPK.text =="")||(t_acct_code.substring(0,3)=="112"))
		{
		    txtAccPK.text ="";
            txtAccCode.text ="";
            txtAccName.text ="";
            t_acct_pk = "";
            t_acct_code = "";
            t_acct_name = "";
		    grdCashBookDetail.ClearData();
			grdTotal.ClearData();
	        formatGridDetail();
	     }
  }
  
function formatGridDetail()
{
    if(grdCashBookDetail.rows <2)
    {
        grdCashBookDetail.AddRow();
    } 
    var fg=grdCashBookDetail.GetGridControl();

    fg.FixedRows = 2;
    fg.MergeCells = 5;
    fg.MergeRow(0) = true;

    fg.Cell(0, 0, 0, 0, 0) = "_PK";    
    fg.Cell(0, 0, 1, 0, 1) = "_TAC_BGCASH_PK";
    fg.Cell(0, 0, 2, 0, 2) = "_TAC_ABACCTCODE_PK"; 
    fg.Cell(0, 0, 3, 0, 4) = "Account"; 
    fg.Cell(0, 1, 3, 1, 3) = "Code"; 
    fg.Cell(0, 1, 4, 1, 4) = "Name"; 

    fg.Cell(0, 0, 5, 0, 6) = "Description"; 
    fg.Cell(0, 1, 5, 1, 5) = "Foreign"; 
    fg.Cell(0, 1, 6, 1, 6) = "Local"; 
   
    fg.MergeCol(7) = true;
    fg.Cell(0, 0, 7, 1, 7) = "Invoice No"; 
    
    fg.MergeCol(8) = true;
    fg.Cell(0, 0, 8, 1, 8) = "Detail";
    
   fg.Cell(0, 0, 9, 0, 9) = "_TCO_DCCUST_PK";  
   fg.Cell(0, 0, 10, 0, 10) = "_CUST_ID";  
   fg.MergeCol(11) = true;
   fg.Cell(0, 0, 11, 1, 11) = "Client";  
   
   fg.Cell(0, 0, 12, 0, 14) = "Transaction"; 
   fg.Cell(0, 1, 12, 1, 12) = "Receipt"; 
   fg.Cell(0, 1, 13, 1, 13) = "Payment"; 
   fg.Cell(0, 1, 14, 1, 14) = "Balance"; 
   
   fg.MergeCol(15) = true;
   fg.Cell(0, 0, 15, 1, 15) = "Voucher No";
   
   fg.Cell(0, 0, 16, 0, 16) = "_DRCR_TYPE";
   fg.Cell(0, 0, 17, 0, 17) = "_TR_CCY";
   
   fg.MergeCol(18) = true;
   fg.Cell(0, 0, 18, 1, 18) = "Ex.Rate";
   
   fg.Cell(0, 0, 19, 0, 21) = "Books"; 
   fg.Cell(0, 1, 19, 1, 19) = "Receipt"; 
   fg.Cell(0, 1, 20, 1, 20) = "Payment"; 
   fg.Cell(0, 1, 21, 1, 21) = "Balance"; 
   
   fg.Cell(0, 0, 22, 0, 23) = "PL"; 
   fg.Cell(0, 1, 22, 1, 22) = "Type"; 
   fg.Cell(0, 1, 23, 1, 23) = "Date(YYYYMM)"; 
   
    fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
    fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; 
   
    fg.ColWidth(0)=0;//_PK
    fg.ColWidth(1)=0;//_TAC_BGCASH_PK
    fg.ColWidth(2)=0;//_TAC_ABACCTCODE_PK

    fg.ColWidth(3)=0;//1500;//Account Code
    fg.ColWidth(4)=0;//2000;//Account Name

    
    fg.ColWidth(6)=0;//1000;//Description Local

    fg.ColWidth(7)=0;//1000;//Invoice No
    fg.ColWidth(8)=0;//1000;//Detail

    fg.ColWidth(9)=0;//_TCO_DCCUST_PK
    fg.ColWidth(10)=0;//_CUST_ID

    fg.ColWidth(11)=0;//1000;//Client
   
    fg.ColWidth(15)=0;//1000;//Voucher No
    fg.ColWidth(16)=0;//_DRCR_TYPE
    fg.ColWidth(17)=0;//_TR_CCY

    fg.ColWidth(18)=1000;//Ex.Rate   
	if (rdoAmountType.value=="2")//Books
	{
		fg.ColWidth(5)=3000;//Description Foreign
		fg.ColWidth(12)=1500;//Receipt
		fg.ColWidth(13)=1500;//Payment
		fg.ColWidth(14)=1500;//Balance 

		fg.ColWidth(19)=1500;//Receipt
		fg.ColWidth(20)=1500;//Payment
		fg.ColWidth(21)=1500;//Balance
	}
	else
	{
		fg.ColWidth(5)=3500;//Description Foreign
		fg.ColWidth(12)=2700;//Receipt
		fg.ColWidth(13)=2700;//Payment
		fg.ColWidth(14)=2700;//Balance 

		fg.ColWidth(19)=0;//Receipt
		fg.ColWidth(20)=0;//Payment
		fg.ColWidth(21)=0;//Balance
	} 
   
    fg.ColWidth(22)=1000;//PL Type
    fg.ColWidth(23)=1000;//PL Date(YYYYMM)
    fg.ColWidth(24)=0;//TRANS AMT
    fg.ColWidth(25)=0;//BOOKS AMT
 
    //Format data type
   if(t_ccy != "VND")
	{
		fg.ColFormat(12)   = "#,###,###.##";			
		fg.ColFormat(13)   = "#,###,###.##";		
		fg.ColFormat(14)   = "#,###,###.##";	
	}
	else
	{
		fg.ColFormat(12)   = "#,###,###,###,###";
		fg.ColFormat(13)   = "#,###,###,###,###";			
		fg.ColFormat(14)   = "#,###,###,###,###";	
	}
	if(lstBookCcy.GetData() != "VND")
	{
		fg.ColFormat(19)   = "#,###,###.##";	
		fg.ColFormat(20)   = "#,###,###.##";			
		fg.ColFormat(21)   = "#,###,###.##";		
	}
	else
	{
		fg.ColFormat(19)   = "#,###,###,###,###";			
		fg.ColFormat(20)   = "#,###,###,###,###";	
		fg.ColFormat(21)   = "#,###,###,###,###";
	}
	fg.ColFormat(18)   = "#,###,###,###,###";//Ex.Rate
	fg.ColAlignment(18) = flexAlignRightCenter;
	fg.ColAlignment(12) = flexAlignRightCenter;
	fg.ColAlignment(13) = flexAlignRightCenter;
	fg.ColAlignment(14) = flexAlignRightCenter;
	fg.ColAlignment(19) = flexAlignRightCenter;
	fg.ColAlignment(20) = flexAlignRightCenter;
	fg.ColAlignment(21) = flexAlignRightCenter;
	
	//---------------Total-----------
	if(grdTotal.rows <2)
    {
        grdTotal.AddRow();
    } 
	var fgtotal =grdTotal.GetGridControl();
	fgtotal.FixedRows = 2;
    fgtotal.MergeCells = 5;
    fgtotal.MergeRow(0) = true;
	fgtotal.Cell(0, 0, 0, 0, 1) = "Carry Forwarded"; 
    fgtotal.Cell(0, 1, 0, 1, 0) = "Trans"; 
	fgtotal.Cell(0, 1, 1, 1, 1) = "Books"; 
	
	fgtotal.Cell(0, 0, 2, 0, 3) = "Receipt Amount"; 
    fgtotal.Cell(0, 1, 2, 1, 2) = "Trans"; 
	fgtotal.Cell(0, 1, 3, 1, 3) = "Books"; 
	
	fgtotal.Cell(0, 0, 4, 0, 5) = "Payment Amount"; 
    fgtotal.Cell(0, 1, 4, 1, 4) = "Trans"; 
	fgtotal.Cell(0, 1, 5, 1, 5) = "Books"; 
	
	fgtotal.Cell(0, 0, 6, 0, 7) = "Closing Balance"; 
    fgtotal.Cell(0, 1, 6, 1, 6) = "Trans"; 
	fgtotal.Cell(0, 1, 7, 1, 7) = "Books"; 
	
	fgtotal.Cell(2, 0, 0, 1, fgtotal.Cols - 1) = 4;
    fgtotal.Cell(13, 1, 0, 1,fgtotal.Cols - 1) = true; 
	
	if (rdoAmountType.value=="2")//Books and Trans
    {
		fgtotal.ColWidth(0)=1500;
		fgtotal.ColWidth(1)=1500;
		fgtotal.ColWidth(2)=1500;
		fgtotal.ColWidth(3)=1500;
		fgtotal.ColWidth(4)=1500;
		fgtotal.ColWidth(5)=1500;
		fgtotal.ColWidth(6)=1500;
		fgtotal.ColWidth(7)=1500;
    }
    else
    {
		fgtotal.ColWidth(0)=3000;
		fgtotal.ColWidth(1)=0;
		fgtotal.ColWidth(2)=3000;
		fgtotal.ColWidth(3)=0;
		fgtotal.ColWidth(4)=3000;
		fgtotal.ColWidth(5)=0;
		fgtotal.ColWidth(6)=3000;
		fgtotal.ColWidth(7)=0;
    } 
	
	if(t_ccy != "VND")
	{
		fgtotal.ColFormat(0)   = "#,###,###,###,###.##";			
		fgtotal.ColFormat(2)   = "#,###,###,###,###.##";
		fgtotal.ColFormat(4)   = "#,###,###,###,###.##";
		fgtotal.ColFormat(6)   = "#,###,###,###,###.##";
	}
	else
	{
		fgtotal.ColFormat(0)   = "#,###,###,###,###,###";
		fgtotal.ColFormat(2)   = "#,###,###,###,###,###";
		fgtotal.ColFormat(4)   = "#,###,###,###,###,###";
		fgtotal.ColFormat(6)   = "#,###,###,###,###,###";
	}
	
	if(lstBookCcy.GetData() != "VND")
	{
		fgtotal.ColFormat(1)   = "#,###,###,###,###.##";			
		fgtotal.ColFormat(3)   = "#,###,###,###,###.##";
		fgtotal.ColFormat(5)   = "#,###,###,###,###.##";
		fgtotal.ColFormat(7)   = "#,###,###,###,###.##";
	}
	else
	{
		fgtotal.ColFormat(1)   = "#,###,###,###,###,###";			
		fgtotal.ColFormat(3)   = "#,###,###,###,###,###";
		fgtotal.ColFormat(5)   = "#,###,###,###,###,###";
		fgtotal.ColFormat(7)   = "#,###,###,###,###,###";	
	}
	fgtotal.ColAlignment(0) = flexAlignRightCenter;
	fgtotal.ColAlignment(1) = flexAlignRightCenter;
	fgtotal.ColAlignment(2) = flexAlignRightCenter;
	fgtotal.ColAlignment(3) = flexAlignRightCenter;
	fgtotal.ColAlignment(4) = flexAlignRightCenter;
	fgtotal.ColAlignment(5) = flexAlignRightCenter;
	fgtotal.ColAlignment(6) = flexAlignRightCenter;
	fgtotal.ColAlignment(7) = flexAlignRightCenter;
	
}

function onChangeFormat()
{
    var fg=grdCashBookDetail.GetGridControl();
	var fgtotal =grdTotal.GetGridControl();
    if (rdoAmountType.value=="2")//Books
	{
		fg.ColWidth(5)=2800;//Description Foreign
		fg.ColWidth(12)=1500;//Receipt
		fg.ColWidth(13)=1500;//Payment
		fg.ColWidth(14)=1500;//Balance 

		fg.ColWidth(19)=1500;//Receipt
		fg.ColWidth(20)=1500;//Payment
		fg.ColWidth(21)=1500;//Balance
		
		fgtotal.ColWidth(0)=1500;
		fgtotal.ColWidth(1)=1500;
		fgtotal.ColWidth(2)=1500;
		fgtotal.ColWidth(3)=1500;
		fgtotal.ColWidth(4)=1500;
		fgtotal.ColWidth(5)=1500;
		fgtotal.ColWidth(6)=1500;
		fgtotal.ColWidth(7)=1500;
		
	}
	else
	{
		fg.ColWidth(5)=3500;//Description Foreign
		fg.ColWidth(12)=2700;//Receipt
		fg.ColWidth(13)=2700;//Payment
		fg.ColWidth(14)=2700;//Balance 

		fg.ColWidth(19)=0;//Receipt
		fg.ColWidth(20)=0;//Payment
		fg.ColWidth(21)=0;//Balance
		
		fgtotal.ColWidth(0)=3000;
		fgtotal.ColWidth(1)=0;
		fgtotal.ColWidth(2)=3000;
		fgtotal.ColWidth(3)=0;
		fgtotal.ColWidth(4)=3000;
		fgtotal.ColWidth(5)=0;
		fgtotal.ColWidth(6)=3000;
		fgtotal.ColWidth(7)=0;
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
                t_transdate = dtbTransDate.value;				
				var code = t_acct_code.substr(0, 3);
                if (code == '112')
			    {
                        onGetBank();
			    } else
			    {
			            onResetBank();
			            datCashbook_Exist.Call('');
			    }		
        }
    }
}

function onChangeCompany()
{
   grdCashBookDetail.ClearData();
   grdTotal.ClearData();
   formatGridDetail();  
   onResetAcc();
   onResetBank();
}

function OnChangeDate()
{
    t_company_pk = lstCompany.value;
	if (txtAccPK.text!= '')
	{
	    t_transdate = dtbTransDate.value;
		t_acct_pk = txtAccPK.text;
		t_acct_code = txtAccCode.text;
		t_acct_name = txtAccName.text;
		
		txtAccCode.text = t_acct_code;
        txtAccName.text = t_acct_name;
	    
	    if (txtBankPK.text !="")
	    {
	        t_bank_pk = txtBankPK.text;
	        t_bank_code = txtBankCode.text;
	        t_bank_name = txtBankName.text;
	    }	
		datCashbook_Exist.Call('');
	} else 
	{
	    grdCashBookDetail.ClearData();
		grdTotal.ClearData();
	    formatGridDetail();
	/*
		FormatNumberDetail();
		*/
	}
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
            
            t_transdate = dtbTransDate.value;
            
            datCashbook_Exist.Call('');
        }
        else
        {
            onResetAcc();
        }
     }
}
function OnNew()
{	
     if (txtAccPK.text=="")
        {
            alert("Please select account code!");
            return;
        } 
        var code = t_acct_code.substr(0, 3);
        if (code == '112')
        {
            if(txtBankPK.text =="")
            {
                alert("Please select Bank Account!");
                return;
            } 
      }
    grdCashBookDetail.AddRow(); 
	if((grdCashBookDetail.GetGridData(grdCashBookDetail.rows-2,18)=="")||(grdCashBookDetail.GetGridData(grdCashBookDetail.rows-2,18)==" "))
	{
		grdCashBookDetail.SetGridText(grdCashBookDetail.rows-1,18,"1");
	}
	else
	{	grdCashBookDetail.SetGridText(grdCashBookDetail.rows-1,18,""+grdCashBookDetail.GetGridData(grdCashBookDetail.rows-2,18));
	}
   
   grdCashBookDetail.SetGridText(grdCashBookDetail.rows-1,1,txtCashbook_PK.text); 
    
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
   if (event.col==3 || event.col==4) //Account code, name,pk
   {
        fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
        var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if (aValue != null)
        {
            if(aValue[0] != "")
            {
                grdCashBookDetail.SetGridText(crow,3,aValue[0]);
                grdCashBookDetail.SetGridText(crow,4,aValue[1]);
                grdCashBookDetail.SetGridText(crow,2,aValue[3]);
            }
        }
        return;
   } 
   
   if (event.col==11) //Client
   {
        fpath = System.RootURL + "/form/gf/co/ffbp00031.aspx";
        var aValue = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if (aValue != null)
        {
            if(aValue[0] != "")
            {
                grdCashBookDetail.SetGridText(crow,9,aValue[0]);//TCO_DCCUST_PK
                grdCashBookDetail.SetGridText(crow,10,aValue[1]);//CUST_ID
                grdCashBookDetail.SetGridText(crow,11,aValue[2]);//CUST_NAME
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
           if (event.col==5)//remark
          {
                 grdCashBookDetail.SetGridText(event.row, 5, "Carry Forwarded");
                 return;
          } 
          if ((event.col==14) ||(event.col==21)) 
         {
                return;
         }
         grdCashBookDetail.SetGridText(event.row, event.col, "");
         return;
     }
    if (event.col == 12) // Trans debit
	{
		var y_n = 0;
		var value = grdCashBookDetail.GetGridData(event.row, 13);//Trans credit
		var value1 = grdCashBookDetail.GetGridData(event.row, 12);//Trans debit
		if (value != '' && Number(value) != 0 && Number(value1) != 0)
		{
			alert('Can not input data here. The Credit Amount has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 12, 0);//Trans debit
			y_n = 1;
		} else

		if (isNumber(value1) && y_n != 1)
		{
			var amount    = grdCashBookDetail.GetGridData(event.row, 12);//Trans debit
			var rate      = grdCashBookDetail.GetGridData(event.row, 18);//Rate
			
			if (isNumber(amount))
			{
				
				if ( t_ccy != 'VND')
				{
					amount = Math.round(amount * 100) / 100;
				} else
				{
					amount = Math.round(amount);
				}
				grdCashBookDetail.SetGridText(event.row, 12, amount);//Trans debit
				CalculateBalance();
				grdCashBookDetail.SetGridText(event.row, 24, amount);//Trans amount
				grdCashBookDetail.SetGridText(event.row, 16, t_Credit);//DRCR_TYPE
				
				var BookAmt = CalculateBookAmt(amount, rate);
				grdCashBookDetail.SetGridText(event.row, 25, BookAmt);//TR_BOOKAMT
				grdCashBookDetail.SetGridText(event.row, 19, BookAmt);        // Set Debit Book Amount On Grid
				grdCashBookDetail.SetGridText(event.row, 20, '' + 0);        // Set Debit Book Amount On Grid
				CalculateBalanceBook();
			} else
			{
				alert('You must input number here!!!');
				grdCashBookDetail.SetGridText(event.row, 12, 0);//Trans debit
			}
		}
	}
	
	if (event.col == 13) //Trans Credit
	{
		var y_n = 0;
		var value = grdCashBookDetail.GetGridData(event.row, 12);//Trans debit
		var value1 = grdCashBookDetail.GetGridData(event.row, 13);//Trans credit
		if (value != '' && Number(value) != 0 && Number(value1) != 0)
		{
			alert('Can not input data here. The Debit Amount has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 13, 0);//Trans credit
			y_n = 1;
		} else
		if (isNumber(value1)  && y_n != 1)
		{
			var amount = grdCashBookDetail.GetGridData(event.row, 13);//Trans credit
			var rate      = grdCashBookDetail.GetGridData(event.row, 18);//Rate
			if (isNumber(amount))
			{
				if (t_ccy != 'VND')
				{
					amount = Math.round(amount * 100) / 100;
				} else
				{
					amount = Math.round(amount);
				}
				grdCashBookDetail.SetGridText(event.row, 13, amount);//Trans credit
				CalculateBalance();
				grdCashBookDetail.SetGridText(event.row, 24, amount);//Trans amount
				
				grdCashBookDetail.SetGridText(event.row, 16, t_Debit);//DRCR_TYPE
				
				var BookAmt = CalculateBookAmt(amount, rate);
				grdCashBookDetail.SetGridText(event.row, 25, BookAmt);//TR_BOOKAMT
				grdCashBookDetail.SetGridText(event.row, 19, '' + 0);        // Set Debit Book Amount On Grid
				grdCashBookDetail.SetGridText(event.row, 20, BookAmt);        // Set Debit Book Amount On Grid
				CalculateBalanceBook();
				
			} else
			{
				alert('You must input number here!!!');
				grdCashBookDetail.SetGridText(event.row, 13, 0);//Trans credit
			}
		}
	}
	
	if(event.col==19)//Book debit
	{
	    var v_1 = grdCashBookDetail.GetGridData(event.row, 12);//Trans debit
	    if((v_1=="0")||(v_1=="0.00"))
	    {
	        alert('Can not input data here. The Credit Book has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 19, 0);//Book debit
			return;
	    }
	    var y_n = 0;
		var value = grdCashBookDetail.GetGridData(event.row, 19);//Book debit
		var value1 = grdCashBookDetail.GetGridData(event.row, 20);//Book credit
		if (value != '' && Number(value) != 0 && Number(value1) != 0)
		{
			alert('Can not input data here. The Credit Book has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 19, 0);//Book debit
			y_n = 1;
		} else

		if (isNumber(value1) && y_n != 1)
		{
			var BookAmt    = grdCashBookDetail.GetGridData(event.row, 19);//Book debit
			if (isNumber(BookAmt))
			{
				
				if ( lstBookCcy.GetData() != 'VND')
				{
					BookAmt = Math.round(BookAmt * 100) / 100;
				} else
				{
					BookAmt = Math.round(BookAmt);
				}
				grdCashBookDetail.SetGridText(event.row, 19, BookAmt);//Books debit
				grdCashBookDetail.SetGridText(event.row, 20, "0");        // Set Debit Book Amount On Grid
				grdCashBookDetail.SetGridText(event.row, 25, BookAmt);//TR_BOOKAMT
				grdCashBookDetail.SetGridText(event.row, 16, t_Credit);//DRCR_TYPE
				CalculateBalanceBook();
			} else
			{
				alert('You must input number here!!!');
				grdCashBookDetail.SetGridText(event.row, 19, 0);//Books debit
			}
		}
	}
	if(event.col==20)//Book credit
	{
	    var v_1 = grdCashBookDetail.GetGridData(event.row, 13);//Trans credit
	    if((v_1=="0")||(v_1=="0.00"))
	    {
	        alert('Can not input data here. The Debit Book Amount has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 20, 0);//Book credit
			return;
	    }
	    var y_n = 0;
		var value = grdCashBookDetail.GetGridData(event.row, 19);//Book debit
		var value1 = grdCashBookDetail.GetGridData(event.row, 20);//Book credit
		if (value != '' && Number(value) != 0 && Number(value1) != 0)
		{
			alert('Can not input data here. The Debit Book Amount has already inputted!!!');
			grdCashBookDetail.SetGridText(event.row, 20, 0);//Book credit
			y_n = 1;
		} else
		if (isNumber(value1)  && y_n != 1)
		{
			var BookAmt = grdCashBookDetail.GetGridData(event.row, 20);//Book credit
			if (isNumber(BookAmt))
			{
				if (lstBookCcy.GetData() != 'VND')
				{
					BookAmt = Math.round(BookAmt * 100) / 100;
				} else
				{
					BookAmt = Math.round(BookAmt);
				}
				grdCashBookDetail.SetGridText(event.row, 20, BookAmt);//Book credit
				grdCashBookDetail.SetGridText(event.row, 25, BookAmt);//Book amount
				grdCashBookDetail.SetGridText(event.row, 16, t_Debit);//DRCR_TYPE
				CalculateBalanceBook();
			} else
			{
				alert('You must input number here!!!');
				grdCashBookDetail.SetGridText(event.row, 20, 0);//Book credit
			}
		}
	}
	//Change exchange rate
	if (event.col==18)
	{
		var Trans_D = grdCashBookDetail.GetGridData(event.row, 12);//Trans debit
		var Trans_C = grdCashBookDetail.GetGridData(event.row, 13);//Trans credit
		var rate    = grdCashBookDetail.GetGridData(event.row, 18);//Rate
		var Books_D = grdCashBookDetail.GetGridData(event.row, 19);
		var Books_C = grdCashBookDetail.GetGridData(event.row, 20);

		if (Trans_D=="")
		{
			Trans_D =0;
		}
		Trans_D= Number(Trans_D);

		if (Trans_C=="")
		{
			Trans_C =0;
		}
		Trans_C= Number(Trans_C);

		if (rate=="")
		{
			rate =0;
		}
		rate= Number(rate);
		Books_D = CalculateBookAmt(Trans_D,rate);
		Books_C = CalculateBookAmt(Trans_C,rate);

		BookAmt = Number(Books_D)-Number(Books_C);
		if (BookAmt <0)
		{
			BookAmt = Number(Books_C)-Number(Books_D);
		}
		grdCashBookDetail.SetGridText(event.row, 19, Books_D);//Books debit
		grdCashBookDetail.SetGridText(event.row, 20, Books_C); 
		grdCashBookDetail.SetGridText(event.row, 25, BookAmt);//TR_BOOKAMT

		CalculateBalance();
		CalculateBalanceBook();
	}

	CalculateRaising();
	
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
		var LastBalanceAmount = Number(grdCashBookDetail.GetGridData(i - 1, 14));
		
		var DebitAmountTemp  = grdCashBookDetail.GetGridData(i, 12);
		if (DebitAmountTemp == '') 
		{
			DebitAmountTemp = 0;
		}
		DebitAmountTemp = Number(DebitAmountTemp);
		var CreditAmountTemp = grdCashBookDetail.GetGridData(i, 13);
		if (CreditAmountTemp == '') 
		{
			CreditAmountTemp = 0;
		}
		CreditAmountTemp = Number(CreditAmountTemp);
		BalanceAmount = LastBalanceAmount + DebitAmountTemp - CreditAmountTemp;
		grdCashBookDetail.SetGridText(i, 14, Number(BalanceAmount));        
	}
}

function CalculateBalanceBook()
{
	var ctrl  = grdCashBookDetail.GetGridControl();
	for (i = 3; i < ctrl.rows; i++ )
	{
		var BalanceAmount = 0;
		var LastBalanceAmount = Number(grdCashBookDetail.GetGridData(i - 1, 21));
		
		var DebitAmountTemp  = grdCashBookDetail.GetGridData(i, 19);
		if (DebitAmountTemp == '') 
		{
			DebitAmountTemp = 0;
		}
		DebitAmountTemp = Number(DebitAmountTemp);
		var CreditAmountTemp = grdCashBookDetail.GetGridData(i, 20);
		if (CreditAmountTemp == '') 
		{
			CreditAmountTemp = 0;
		}
		CreditAmountTemp = Number(CreditAmountTemp);
		BalanceAmount = LastBalanceAmount + DebitAmountTemp - CreditAmountTemp;
		grdCashBookDetail.SetGridText(i, 21, Number(BalanceAmount));        
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
        if (txtAccPK.text=="")
        {
            alert("Please select account code!");
            return;
        } 
        var code = t_acct_code.substr(0, 3);
        if (code == '112')
        {
            if(txtBankPK.text =="")
            {
                alert("Please select Bank Account!");
                return;
            } 
        }
       if (confirm("Do you want to save ?"))
        {
            t_status_control =1;
            switch (datCashbook_Master.GetStatus())
            {
                case 10 :
                    datCashbook_Master.StatusUpdate();
                    datCashbook_Master.Call('UPDATE'); 
                break; 
                case 20 :
                    datCashbook_Master.Call('INSERT'); 
                break;
            }
        }
}

function onReceiveDetail()
{
        ctrl = grdCashBookDetail.GetGridControl();        
		grdCashBookDetail.SetGridText(2, 12, "");//Trans debit
		grdCashBookDetail.SetGridText(2, 13, "");//Trans credit
		grdCashBookDetail.SetGridText(2, 18, "");//ex rate
		grdCashBookDetail.SetGridText(2, 19, "");//Book debit
		grdCashBookDetail.SetGridText(2, 20, "");//Book credit
		for (i = 3; i < ctrl.rows; i++ )
		{
			var amount = grdCashBookDetail.GetGridData(i, 24); // Get Transaction Amt
			var amountbook = grdCashBookDetail.GetGridData(i, 25); // Get Transaction Amt Book
			var dr_cr  = grdCashBookDetail.GetGridData(i, 16); // Get DR_CR Type
			if (dr_cr == 'C')
			{
				grdCashBookDetail.SetGridText(i, 12, amount);        // Set Debit Amount On Grid
				grdCashBookDetail.SetGridText(i, 13, "0");
				grdCashBookDetail.SetGridText(i, 19, amountbook);        // Set Debit Amount On Grid
				grdCashBookDetail.SetGridText(i, 20,"0");
			} else
			{
			    grdCashBookDetail.SetGridText(i, 12, "0");
				grdCashBookDetail.SetGridText(i, 13, amount);        // Set  Amount On Grid
				grdCashBookDetail.SetGridText(i, 19,"0");
				grdCashBookDetail.SetGridText(i, 20, amountbook);        // Set Credit Amount On Grid
			}
		}
		CalculateBalance();
		CalculateBalanceBook();
		//CalculateTotal();
		CalculateRaising();
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
					grdCashBookDetail.SetGridText(i, 17, t_ccy);  // Set Ccy on Grid
					//grdCashBookDetail.SetRowStatus(i, 0x20);					 // status grid is ADD
				}
        }
        datCashbook_Detail.Call();//save detail
}



function OnDelete()
{
    var t_rowsSelected = false; 
  	for (var i = 3; i < grdCashBookDetail.rows; i++)
    {
    	if (grdCashBookDetail.GetGridControl().IsSelected(i) == true)
        {            
        	t_rowsSelected = true;        
            grdCashBookDetail.DeleteRowAt(i);                   
        }         
    } 
	
	if (t_rowsSelected == false)
    {
    	alert('You must select row to delete !');
    	return;
    }
   else
   {
        //datCashbook_Detail.Call('');
   } 
}
function OnSearch()
{
	if(txtAccPK.text!="")
	{
		datCashbook_Exist.Call();
	}
	else
	{
		alert("Please select account code!");
		return;
	}
}

function OnReport()
{
    if (txtAccPK.text !='')
    {
        var rqt = "";
        rqt = "?company_pk="+lstCompany.value+'&from_date='+dtbTransDate.value+'&acc_pk='+txtAccPK.text+'&bank_pk='+txtBankPK.text+'&to_date='+dtbTransDate.value;
        var url =System.RootURL + '/reports/bd/fc/bdfc0001.aspx'+rqt;
        System.OpenTargetPage(url, "newform" );
        return; 
    }
}

function OnReport2()
{
    if (txtAccPK.text !='')
    {
        var rqt = "";
        rqt = "?company_pk="+lstCompany.value+'&from_date='+dtbTransDate.value+'&acc_pk='+txtAccPK.text+'&bank_pk='+txtBankPK.text+'&to_date='+dtbTransDate.value;
        var url =System.RootURL + '/reports/bd/fc/bdfc0001_All.aspx'+rqt;
        System.OpenTargetPage(url, "newform" );
        return; 
    }
}

function OnDataReceiveCheckExist()
{
    if(txtCheckExist.text =="0") //not exist - get balance
   {
        t_company_pk = lstCompany.value;
        datCashbook_Master.StatusInsert(); 
        
        txtAccPK.text = t_acct_pk ;
        txtAccCode.text = t_acct_code;
        txtAccName.text = t_acct_name;
        lstCompany.value = t_company_pk;
        dtbTransDate.value = t_transdate;
        txtBankPK.text = t_bank_pk;
        txtBankCode.text = t_bank_code;
        txtBankName.text  = t_bank_name;
		grdCashBookDetail.ClearData();
	    formatGridDetail();
	    datCashbook_Balance.Call('');
   }
   else//existed - load data
   {
        txtCashbook_PK.text = txtCheckExist.text;
        grdCashBookDetail.ClearData();
	    formatGridDetail();
        //datCashbook_Master.StatusSelect(); 
        //datCashbook_Master.Call("SELECT");
		datSumCash.Call("SELECT");
   } 
   
}

function onReceiveSum()
{
	
	datCashbook_Master.StatusSelect(); 
    datCashbook_Master.Call("SELECT");
}

function CalculateTotal()
{
	var tmp = Number(grdTotal.GetGridData(2,0))+Number(grdTotal.GetGridData(2,2))-Number(grdTotal.GetGridData(2,4));
	grdTotal.SetGridText(2,6,tmp);
	tmp = Number(grdTotal.GetGridData(2,1))+Number(grdTotal.GetGridData(2,3))-Number(grdTotal.GetGridData(2,5));
	grdTotal.SetGridText(2,7,tmp); 
}
function CalculateRaising()
{
	var ctrl = grdCashBookDetail.GetGridControl();
	var Trans_Receipt =0;
	var Trans_Payment =0;
	var Book_Receipt =0;
	var Book_Payment =0;
	var Trans_Balance =0;
	var Book_Balance =0;
	Trans_Balance = Number(grdCashBookDetail.GetGridData(2, 14));
	Book_Balance  = Number(grdCashBookDetail.GetGridData(2, 21));
	
	for(i =3;i<ctrl.rows; i++ )
	{
		DebitAmountTemp  = grdCashBookDetail.GetGridData(i, 12);
		if (DebitAmountTemp == '') 
		{
			DebitAmountTemp = 0;
		}
		DebitAmountTemp = Number(DebitAmountTemp);
		Trans_Receipt = Trans_Receipt +DebitAmountTemp
		
		CreditAmountTemp = grdCashBookDetail.GetGridData(i, 13);
		if (CreditAmountTemp == '') 
		{
			CreditAmountTemp = 0;
		}
		CreditAmountTemp = Number(CreditAmountTemp);
		Trans_Payment = Trans_Payment + CreditAmountTemp;
		
		DebitBAmountTemp  = grdCashBookDetail.GetGridData(i, 19);
		if (DebitBAmountTemp == '') 
		{
			DebitBAmountTemp = 0;
		}
		DebitBAmountTemp = Number(DebitBAmountTemp);
		Book_Receipt = Book_Receipt +DebitBAmountTemp
		
		CreditBAmountTemp = grdCashBookDetail.GetGridData(i, 20);
		if (CreditBAmountTemp == '') 
		{
			CreditBAmountTemp = 0;
		}
		CreditBAmountTemp = Number(CreditBAmountTemp);
		Book_Payment = Book_Payment + CreditBAmountTemp;
	}
	
	grdTotal.SetGridText(2,2,Trans_Receipt);
	grdTotal.SetGridText(2,3,Book_Receipt); 
	grdTotal.SetGridText(2,4,Trans_Payment);
	grdTotal.SetGridText(2,5,Book_Payment);
	
	var tmp = Number(grdTotal.GetGridData(2,0))+Number(grdTotal.GetGridData(2,2))-Number(grdTotal.GetGridData(2,4));
	grdTotal.SetGridText(2,6,tmp);
	tmp = Number(grdTotal.GetGridData(2,1))+Number(grdTotal.GetGridData(2,3))-Number(grdTotal.GetGridData(2,5));
	grdTotal.SetGridText(2,7,tmp); 
}
 </script>
<body >
    <gw:data id="datCashbook_Exist" onreceive="OnDataReceiveCheckExist()" > 
    <xml> 
        <dso id="1" type="process" user="acnt" parameter="0,1,2,3" procedure = "acnt.sp_prc_cashbook_exist"> 
    <input >
        <input bind="lstCompany" />
        <input bind="dtbTransDate" /> 
        <input bind="txtAccPK" /> 
        <input bind="txtBankPK" />
    </input>
    <output>
        <output bind="txtCheckExist" /> 
    </output>
    </dso> 
    </xml> 
    </gw:data> 
   
   <gw:data id="datCashbook_Master" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso id="2" type="control" user="acnt" parameter="0,1,2,3,4" function = "acnt.sp_sel_cashbook_master" procedure="acnt.sp_upd_cashbook_master"> 
            <input >
                <input bind="txtCashbook_PK" /> 
                <input bind="lstCompany" />
                <input bind="dtbTransDate" /> 
                <input bind="txtAccPK" /> 
                <input bind="txtBankPK" />
                
            </input>
            <output>
                <output bind="txtCashbook_PK" />
                <output bind="lstCompany" />
                <output bind="dtbTransDate" /> 
                <output bind="txtAccPK" /> 
                <output bind="txtBankPK" /> 
            </output>
    </dso> 
    </xml> 
    </gw:data>  
    
<gw:data id="datCashbook_Detail" onreceive="onReceiveDetail()" onerror="OnDataError(this)" >
    <xml> 
    <dso id="3" type="grid" user="acnt" parameter="0,1,2,5,6,7,8,9,15,16,17,18,22,23,24,25"  function="acnt.SP_SEL_CASHBOOKD" procedure="acnt.SP_UPD_CASHBOOKD" > 
   <input bind="grdCashBookDetail" >
        <input bind="txtCashbook_PK" />
    </input> 
    <output bind="grdCashBookDetail" />
    </dso>
    </xml>
</gw:data>

<gw:data id="datCashbook_Balance" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso id="4" type="process" procedure="acnt.sp_sel_cashbook_balance" >
             <input >
                <input bind="lstCompany" />
                <input bind="dtbTransDate" /> 
                <input bind="txtAccPK" /> 
                <input bind="txtBankPK" />
            </input>
            <output>
                <output bind="txtBalance_Trans"/>
                <output bind="txtBalance_Books"/>                              
            </output>
        </dso>                    
    </xml>
</gw:data>

<gw:data id="datSumCash" onreceive="onReceiveSum()" onerror="OnDataError(this)" >
    <xml> 
    <dso id="5" type="grid" user="acnt" parameter="0"  function="ACNT.SP_SEL_SUM_CASHBOOKD"  > 
   <input bind="grdTotal" >
        <input bind="txtCashbook_PK" />
    </input> 
    <output bind="grdTotal" />
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
          <td width="10%"></td>
         <td width="20%" align="right">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                            <td><gw:imgBtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                            <td><gw:imgBtn id="ibtnNew" img="new" alt="New" onclick="OnNew()" /></td>
                           <td><gw:imgBtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" /></td>
                           <td><gw:imgBtn id="ibtnDelete" img="delete" alt="Delete" onclick="OnDelete()" /></td>
                           <td><gw:imgBtn id="ibtnPrint" img="printer" alt="Print" onclick="OnReport()" /></td> 
                           <td><gw:imgBtn id="ibtnPrint2" img="printer" alt="Print Non Book Currency" onclick="OnReport2()" /></td> 
                    </tr>
                </table>
         </td> 
      </tr>
         <tr>
            <td align="right">Trans Date</td>
            <td ><gw:datebox id="dtbTransDate" lang="<%=Application("Lang")%>" mode="01" onchange="OnChangeDate()" /></td>
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
document.writeln("header='_PK|_TAC_BGCASH_PK|_TAC_ABACCTCODE_PK|AC_CD|AC_NM|REMARK|REMARK2|INVOICE_NO|REMARK_DETAIL|TCO_DCCUST_PK|CUST_ID|CUST_NAME|RECEIPT|PAYMENT|BALANCE|VOUCHER_NO|_DRCR_TYPE|_TR_CCY|TR_EXRATE|RECEIPT|PAYMENT|BALANCE|PL_TYPE|PL_YYYYM|_TRANS_AMT|_BOOKS_AMT'");
document.writeln("format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'");
document.writeln("aligns='0|0|0|0|0|0|0|0|0|0|0|0|2|2|2|0|0|0|0|2|2|2|0|0|0|0'");
document.writeln("defaults='|||||||||||||||||||||||||'");
document.writeln("editcol='0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|0|1|1|1|1'");
document.writeln("widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0'");
document.writeln("sorting='F'");
document.writeln("styles='width:100%; height:340'");
document.writeln("oncelldblclick='onGridDbClick()'");
document.writeln("onafteredit='onGridAfterEdit()' />");
</script>
      </td>
      </tr>
	<tr>
      <td colspan="9">
	<script language="javascript">
		document.writeln("<gw:grid id='grdTotal'");
document.writeln("header='OPEN_TRANS|OPEN_BOOKS|RC_TRANS|RC_BOOKS|PAY_TRANS|PAY_BOOKS|CLOSE_TRANS|CLOSE_BOOKS'");
document.writeln("format='0|0|0|0|0|0|0|0'");
document.writeln("aligns='0|0|0|0|0|0|0|0'");
document.writeln("defaults='|||||||'");
document.writeln("editcol='0|0|0|0|0|0|0|0'");
document.writeln("widths='1000|1000|1000|1000|1000|1000|1000|1000'");
document.writeln("sorting='F'");
document.writeln("styles='width:100%; height:80'");
document.writeln("/>");
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
