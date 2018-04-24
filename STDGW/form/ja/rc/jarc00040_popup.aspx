<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Guest Check out</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function  BodyInit()
{
  txtBuyExRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_buy_ex_rate(2,'USD') from dual")%>"; 
    
  var caller = dialogArguments;
  var arrSum = caller.GetSumaryAmount();
  SetSumData(arrSum);
  var arrGuest = caller.GetGuestInfo();
  SetGuestInfo(arrGuest);
  txtReceiptVND.GetControl().focus();
  SetPayMethod();
}
function SetPayMethod(){
	switch('<%=Request.QueryString("pay") %>'){
		case "PTYPE-01":
			rbCashCredit.value = 1;
			rbCashCredit.SetEnable(false);
		break;
		case "PTYPE-02":
			rbCashCredit.value = 2;
			rbCashCredit.SetEnable(false);
		break;
		case "PTYPE-03":
			rbCashCredit.value = 3;
			rbCashCredit.SetEnable(false);
			txtReceiptVND.text = Number(txtSumVND.text);OnChangeMoney();
		break;
	}
}
function OnPreview(){
	var arr_pk = '<%=Request.QueryString("pk") %>';
    var l_crt_by = '<%=session("user_id") %>';
    var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ja/rc/jarc0040_preview.rpt&procedure=CRM.sp_sel_jarc00040_preview&parameter="+
	arr_pk+",,,,"+l_crt_by;   
	System.OpenTargetPage(url);  
}
function OnPrintBill(){
    var arr_pk = '<%=Request.QueryString("pk") %>';
    var l_crt_by = '<%=session("user_id") %>';
    var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ja/rc/jarc0040.rpt&procedure=CRM.sp_sel_jarc00040_invoice_print&parameter="+
	arr_pk+",,,,"+l_crt_by;   
	System.OpenTargetPage(url); 
}
function SetSumData(arr){

    var tmp = new Array();
    //total txtTotalUSD
    tmp = arr[0];
    txtTotalUSD.text=tmp[0];
    txtTotalVND.text=tmp[1];
    txtTotalVAT.text=tmp[2];
   
    tmp = arr[1];
    txtGreenFeeUSD.text=tmp[0];
    txtGreenFeeVND.text=tmp[1];
    txtGreenFeeVAT.text=tmp[2];
    tmp = arr[2];
    txtFacilityUSD.text=tmp[0];
    txtFacilityVND.text=tmp[1];
    txtFacilityVAT.text=tmp[2];
    tmp = arr[3];
    txtCaddyFeeUSD.text=tmp[0];
    txtCaddyFeeVND.text=tmp[1];
    txtCaddyFeeVAT.text=tmp[2];
    tmp = arr[4]; 
    txtCardFeeUSD.text=tmp[0];
    txtCardFeeVND.text=tmp[1];
    txtCardFeeVAT.text=tmp[2];
    tmp = arr[5];
    txtF_B_FeeUSD.text=tmp[0];
    txtF_B_FeeVND.text=tmp[1];
    txtF_B_FeeVAT.text=tmp[2];
    tmp = arr[6];
    txtProshopFeeUSD.text=tmp[0];
    txtProshopFeeVND.text=tmp[1];
    txtProshopFeeVAT.text=tmp[2];
    tmp = arr[7];
    txtRentalFeeUSD.text=tmp[0];
    txtRentalFeeVND.text=tmp[1];
    txtRentalFeeVAT.text=tmp[2];
    tmp = arr[8];
    txtTeeHouseFeeUSD.text=tmp[0];
    txtTeeHouseFeeVND.text=tmp[1];
    txtTeeHouseFeeVAT.text=tmp[2];
    tmp = arr[9];
    txtTrainingFeeUSD.text=tmp[0];
    txtTrainingFeeVND.text=tmp[1];
    txtTrainingFeeVAT.text=tmp[2];
    tmp = arr[10];
    txtDiscountUSD.text=tmp[0];
    txtDiscountVND.text=tmp[1];
    txtDiscountVAT.text=tmp[2];
    tmp = arr[11];
    txtOthersFeeUSD.text=tmp[0];
    txtOthersFeeVND.text=tmp[1];
    txtOthersFeeVAT.text=tmp[2];
    
    tmp = arr[11];
    txtOthersFeeUSD.text=tmp[0];
    txtOthersFeeVND.text=tmp[1];
    txtOthersFeeVAT.text=tmp[2];
    
    tmp = arr[12];//txtAmountDueUSD
    txtAmountDueUSD.text=tmp[0];
    txtAmountDueVND.text=tmp[1];
    txtAmountDueVAT.text=tmp[2];
    txtSumUSD.text=tmp[0];//amount due in USD
    txtSumVND.text=tmp[1];//amount due in VND
    
    tmp = arr[13];//txtGolfbagFeeUSD
    txtGolfbagFeeUSD.text=tmp[0];
    txtGolfbagFeeVND.text=tmp[1];
    txtGolfbagFeeVAT.text=tmp[2];
    
    tmp = arr[14];
    txtSellExRate.text=tmp[0];//Ex_rate
    OnChangeMoney();
}
function SetGuestInfo(arr){
    var tmp = new Array();
    //alert(arr);
    tmp = arr;
    txtLocker.text=tmp[0];//locker#  
    txtGolferName.text=tmp[1]; //golfer name
}
function OnChangeMoney()
{
    var Balance_VND=0,USD_VND=0,Balance_USD=0,VND=0;
    var tmp=0,pay_vnd, pay_usd_vnd,return_vnd=0,return_usd=0, return_usd_vnd=0,return_vnd_add_usd=0;
    
        VND=Number(txtReceiptVND.GetData());
        USD_VND=System.Round(Number(txtReceiptUSD.GetData())*Number(txtSellExRate.GetData()),0);
        pay_vnd = Number(txtPaymentVND.GetData());
        pay_usd_vnd = Number(txtPaymentUSD.GetData())*Number(txtSellExRate.GetData());
        
        return_vnd = Number(txtReturnVND.GetData());
        
        return_usd = Number(txtReturnUSD.GetData());
        if(return_usd > 0)
        {
            return_usd_vnd = Number(txtReturnUSD.GetData())*Number(txtSellExRate.GetData());
        }
        return_vnd_add_usd=return_vnd + return_usd_vnd;
        tmp = Number(txtSumVND.GetData())+ pay_vnd + pay_usd_vnd -(VND+USD_VND);
        Balance_VND = System.Round(tmp/1000,0)*1000;
        Balance_USD =System.Round((Balance_VND)/Number(txtSellExRate.GetData()),2);
        
        txtBalanceVND.SetDataText(""+Balance_VND);
        txtBalanceUSD.SetDataText(""+Balance_USD);
        tmp = Number(txtSumVND.GetData());
        tmp = System.Round(tmp/1000,0)*1000 - tmp;
        txtOtherProfitLoss.text = tmp+return_vnd_add_usd;
}
function OnChangeCashCredit()
{
   
    if(rbCashCredit.value == "3")
    {
        txtReceiptVND.text = txtAmountDueVND.text;
    }
    else
    {
        
    }
}
function OnClose(){
    window.close();
}
function OnCheckOut(){
    
	if(Number(txtReceiptVND.text) > 0 && rbCashCredit.GetData() == "1"){
         if(Number(txtReceiptVND.text)%1000 > 0){
			alert("Tiền mặt phải được làm tròn đến 1000 đồng.\n Ví dụ:tiền lẻ >= 500 thì làm tròn 1000 ngược lại < 500 thì bỏ phần lẻ đó.");
			return;
		 }
    }	
	if(txtBalanceVND.text != "0"){
        alert("Balance is not zero. So you can not check out.");
        return;
    }
    if(confirm("Do you want to check out for guest '"+ txtGolferName.text +"' ?")){
        var arrReturn = new Array();
        
        arrReturn[arrReturn.length] = txtReceiptVND.text;
        arrReturn[arrReturn.length] = txtReceiptUSD.text;
        
        arrReturn[arrReturn.length] = txtPaymentVND.text;
        arrReturn[arrReturn.length] = txtPaymentUSD.text;
        
        arrReturn[arrReturn.length] = txtOtherProfitLoss.text;
        
        if(rbCashCredit.GetData() == "1" ){
            arrReturn[arrReturn.length] = "PTYPE-01";
        }
        else if(rbCashCredit.GetData() == "2" ){
            arrReturn[arrReturn.length] = "PTYPE-02";
        }
        else if(rbCashCredit.GetData() == "3" ){
            arrReturn[arrReturn.length] = "PTYPE-03";
        }
        arrReturn[arrReturn.length] = txtReturnVND.text;
        arrReturn[arrReturn.length] = txtReturnUSD.text;
        
        window.returnValue = arrReturn;
        window.close();
    }
}
</script>

<body>
    <table style="width: 100%; height: 100%" border="1">
        <tr valign="top" style="height: 2%">
            <td colspan="2">
                <table style="height: 100%; width: 100%">
                    <tr valign="top">
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <gw:icon id="btnClose" img="2" text="Not Check Out" styles='width:100%' onclick="OnClose()" />
                                    </td>
                                    <td style="width: 11%">
                                    </td>
                                    <td style="width: 12%">
                                        <gw:icon id="idBtnPreview" img="2" text="Preview" styles='width:100%' onclick="OnPreview()" />
                                    </td>
                                    <td style="width: 14%">
                                    </td>
                                    <td style="width: 12%">
                                        <gw:icon id="idBtnPrintBill" img="2" text="Print Bill" styles='width:100%' onclick="OnPrintBill()" />
                                    </td>
                                    <td style="width: 42%">
                                        <gw:icon id="idBtnCheckOut" img="2" text="Check Out" styles='width:100%' onclick="OnCheckOut()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="top" style="height: 2%">
            <td colspan="2">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width:5%" align="left">
                            Locker#
                        </td>
                        <td style="width:5%">
                            <gw:textbox id="txtLocker" />
                        </td>
                        <td style="width: 5%" align="left">
                        </td>
                        <td style="width:15%" align="right">
                            Golfer Name
                        </td>
                        <td style="width:20%">
                            <gw:textbox id="txtGolferName" />
                        </td>
                        <td style="width:13%">Sell Ex.Rate:</td>
                        <td style="width:10%"><gw:textbox id="txtSellExRate" readonly="true" styles="width:100%;border:0px;" /></td>
                        <td style="width:12%">Buy Ex.Rate:</td>
                        <td style="width:10%"><gw:textbox id="txtBuyExRate" readonly="true" styles="width:100%;border:0px;" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="top" style="height: 96%">
            <td style="width: 58%; background-color: #33CCFF">
                <table style="height: 100%; width: 100%; border: 0px;" cellspacing="1" cellpadding="1">
                    <tr style="height: 2%;" valign="top">
                        <td style="background-color: White; width: 30%">
                        </td>
                        <td align="center" style="background-color: White">
                            USD</td>
                        <td align="center" style="background-color: White">
                            VND</td>
                        <td align="center" style="background-color: White">
                            VAT</td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color:Red; padding-left: 5px;" valign="middle">
                            Amount due</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtAmountDueUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtAmountDueVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtAmountDueVAT" styles="width:100%;border:0px;font-weight:bold;" type="number"  format="###,###,###,###,###" />
                        </td>
                     </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color:Yellow; padding-left: 5px;" valign="middle">
                            Discount</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtDiscountUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtDiscountVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtDiscountVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Total</td>
                        <td style="background-color: White">
                            <gw:textbox id="txtTotalUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###.##" />
                        </td>
                        <td style="background-color: White">
                            <gw:textbox id="txtTotalVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td style="background-color: White">
                            <gw:textbox id="txtTotalVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Green Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGreenFeeUSD" type="number" format="###,###,###,###.##" styles="width:100%;border:0px;" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGreenFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGreenFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Facility Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtFacilityUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtFacilityVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtFacilityVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Caddy Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCaddyFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCaddyFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCaddyFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Cart Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCardFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCardFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtCardFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Golfbag Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGolfbagFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGolfbagFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtGolfbagFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            F&B Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtF_B_FeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtF_B_FeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtF_B_FeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Proshop Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtProshopFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtProshopFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtProshopFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Rental Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtRentalFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtRentalFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtRentalFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Tee House Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTeeHouseFeeUSD" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTeeHouseFeeVND" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTeeHouseFeeVAT" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Training Fee
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTrainingFeeUSD" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTrainingFeeVND" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtTrainingFeeVAT" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" />
                        </td>
                    </tr>
                    
                    <tr style="height: 2%" valign="top">
                        <td style="background-color: White; padding-left: 5px;" valign="middle">
                            Others Fee</td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtOthersFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtOthersFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                        <td align="right" style="background-color: White">
                            <gw:textbox id="txtOthersFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    
                    
                </table>
            </td>
            <td style="width: 40%; background-color: #33CCFF">
                <table style="height: 100%; width: 100%; border: 0px;" cellspacing="1" cellpadding="0">
                    <tr style="height: 3%">
                        <td style="background-color: #5A79A5; width: 100%" align="center" colspan="3">
                            <gw:radio id="rbCashCredit" value="1" onchange="OnChangeCashCredit()"> 
		                                <span value="1" style="color:White;">Cash</span>
		                                <span value="2" style="color:White;">Credit Card</span>
		                                <span value="3" style="color:White;">Receivable</span>
                             </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td style="background-color: #BFD9DA; width: 35%; font-size:larger" rowspan="2" align="center">
                            Amount due</td>
                        <td style="background-color: #BFD9DA; width: 15%; font-size:larger" align="center">
                            VND</td>
                        <td style="background-color: #BFD9DA;">
                            <gw:textbox id="txtSumVND" styles="width:100%;border:0px;background-color:#BFD9DA; font-size:large" type="number" format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: #BFD9DA; font-size:larger" align="center">
                            USD</td>
                        <td style="background-color: #BFD9DA">
                            <gw:textbox id="txtSumUSD" styles="width:100%;border:0px; font-size:large;background-color:#BFD9DA" type="number" format="###,###,###,###,###.##" />
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td style="background-color: White; width: 35%; font-size:larger" rowspan="2" align="center">
                            Received</td>
                        <td style="background-color: White; width: 15%; font-size:larger" align="center">
                            VND</td>
                        <td style="background-color: White;">
                            <gw:textbox id="txtReceiptVND" styles="width:100%;border:0px; font-size:large" type="number" format="###,###,###,###,###"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: White; font-size:larger" align="center">
                            USD</td>
                        <td style="background-color: White">
                            <gw:textbox id="txtReceiptUSD" styles="width:100%;border:0px; font-size:large" type="number" format="###,###,###,###,###.##"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td style="background-color: #D9D4AE; width: 35%; font-size:larger" rowspan="2" align="center">
                            Refund</td>
                        <td style="background-color: #D9D4AE; width: 15%; font-size:larger" align="center">
                            VND</td>
                        <td style="background-color: #D9D4AE;">
                            <gw:textbox id="txtPaymentVND" styles="width:100%;border:0px;background-color:#D9D4AE; font-size:large" type="number" format="###,###,###,###,###"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: #D9D4AE; font-size:larger" align="center">
                            USD</td>
                        <td style="background-color: #D9D4AE;">
                            <gw:textbox id="txtPaymentUSD" styles="width:100%;border:0px; font-size:large;background-color:#D9D4AE" type="number" format="###,###,###,###,###.##"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td style="background-color: White; width: 35%; font-size:larger" rowspan="2" align="center">
                            Tips</td>
                        <td style="background-color: White; width: 15%; font-size:larger" align="center">
                            VND</td>
                        <td style="background-color: White;">
                            <gw:textbox id="txtReturnVND" styles="width:100%;border:0px; font-size:large" type="number" format="###,###,###,###,###"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: White; font-size:larger" align="center">
                            USD</td>
                        <td style="background-color: White;">
                            <gw:textbox id="txtReturnUSD" styles="width:100%;border:0px; font-size:large" type="number" format="###,###,###,###,###.##"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 4%">
                        <td style="background-color: #BFD9DA; width: 35%; font-size:larger" rowspan="2" align="center">
                            Balance:</td>
                        <td style="background-color: #BFD9DA; width: 15%; font-size:larger" align="center">
                            VND</td>
                        <td style="background-color: #BFD9DA;">
                            <gw:textbox id="txtBalanceVND" styles="width:100%;border:0px;color:red;background-color:#BFD9DA; font-size:large" readonly="true" type="number" format="###,###,###,###,###"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: #BFD9DA; font-size:larger" align="center">
                            USD</td>
                        <td style="background-color: #BFD9DA">
                            <gw:textbox id="txtBalanceUSD" styles="width:100%;border:0px; color:red;background-color:#BFD9DA; font-size:large" readonly="true" type="number" format="###,###,###,###,###.##.##"
                                onchange="OnChangeMoney()" onenterkey="OnChangeMoney()" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="background-color: #BFD9DA;" align="center" colspan="2">
                            Other Profit/Loss</td>
                        <td style="background-color: #BFD9DA;">
                            <gw:textbox id="txtOtherProfitLoss" styles="width:100%;border:0px;background-color:#BFD9DA;" readonly="true" type="number"
                                format="###,###,###,###,###" />
                        </td>
                    </tr>
                    <tr style="height: 88%">
                        <td style="background-color: #BFD9DA; width: 100%" colspan="3">
						   
							   <b style="color:red">* Chú ý:</b>  <br>
							   1. Thu tiền mặt phải làm tròn đến 1000 đồng. <br>
							   2. Thu bằng credit card, city ledger, chuyển sang hotel phải nhập số tiền checkout đúng số tiền Total due.<br>
							   3. Cách làm tròn <br>
							     - Tiền lẻ >= 500 đồng thì làm trón đến 1000 đồng <br>
								 - Tiền lẻ < 500 đồng thì bỏ phần lẻ đó <br>
							
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPKs" styles="width:100%; display:none" />
    <gw:textbox id="txtCashUSD" styles="width:100%; display:none" />
    <gw:textbox id="txtCashVND" styles="width:100%; display:none" />
    <gw:textbox id="txtCreditUSD" styles="width:100%; display:none" />
    <gw:textbox id="txtCreditVND" styles="width:100%; display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
