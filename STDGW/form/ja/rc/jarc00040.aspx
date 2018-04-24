<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Booking Checking</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function  BodyInit()
{
   grdVisiterfee_golfer.GetGridControl().FrozenCols=4;
   txtExRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_sell_ex_rate(2,'USD') from dual")%>";   
   l_crt_by = "<%=Session("User_ID")%>";
   txtBagNo.GetControl().focus();
   var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT code,NAME FROM comm.tco_commcode WHERE DEL_IF=0 and  parent_code='PTYPE' and use_yn='Y'")%>";
   grdVisiterfee_golfer.SetComboFormat(26, data);
   //OnSearch();
}
function OnSearch()
{
    data_jarc00040.Call("SELECT");
}
function OnDataReceive(obj)
{
    if( obj.id == "data_jarc00040" || obj.id == "data_jarc00040_unprint")
	{
		lblRows.text = grdVisiterfee_golfer.rows - 1;
		txtTaxCode.text = "";
		txtCompany.text = "";
		txtAddress.text = "";
		if(grdVisiterfee_golfer.rows == 2){
		    grdVisiterfee_golfer.SetGridData(1,2,-1);
		    grdVisiterfee_golfer.row = 1;
		    ShowDetailFees();
		}
		else{
		    dsojarc00040_count_checkout.Call();
		}
		SetBGColor();
	}
    else if( obj.id == "data_invoice" )
    {
	    
        //
    }
}

var l_green_fee_usd,l_green_fee_vnd, l_caddy_fee_usd, l_caddy_fee_vnd, l_cart_fee_usd, l_cart_fee_vnd;
var l_golfbag_fee_usd, l_golfbag_fee_vnd, l_discount_usd, l_discount_vnd,l_other_fee_usd, l_other_fee_vnd;
var l_teaching_fee_usd, l_teaching_fee_vnd, l_drv_range_fee_usd, l_drv_range_fee_vnd, l_drv_range_fee_usd, l_fnb_fee_usd, l_fnb_fee_vnd;
var l_proshop_fee_usd,l_proshop_fee_vnd, l_teehouse_fee_usd, l_teehouse_fee_vnd, l_total_fee_usd,l_total_fee_vnd;  
function  ShowDetailFees()
{
	var arr_pk ="";
	var rqt = "";
	var tmp ="",arr_master_pk="";
	var bl = 0;
	l_green_fee_usd=0;
	l_green_fee_vnd=0; 
	l_caddy_fee_usd=0; 
	l_caddy_fee_vnd=0; 
	l_cart_fee_usd=0;
	l_cart_fee_vnd=0;
	l_golfbag_fee_usd=0;
	l_golfbag_fee_vnd=0;
	l_discount_usd=0;
	l_discount_vnd=0;
	l_other_fee_usd=0;
	l_other_fee_vnd=0;
	l_teaching_fee_usd=0;
	l_teaching_fee_vnd=0;
	l_drv_range_fee_usd=0;
	l_drv_range_fee_vnd=0;
	l_drv_range_fee_usd=0;
	l_fnb_fee_usd=0;
	l_fnb_fee_vnd=0;
	l_proshop_fee_usd=0;
	l_proshop_fee_vnd=0;
	l_teehouse_fee_usd=0;
	l_teehouse_fee_vnd=0;
	l_total_fee_usd=0;
	l_total_fee_vnd=0;
	
	for (i = 1; i < grdVisiterfee_golfer.rows; i++)
	{
		if((grdVisiterfee_golfer.GetGridData(i,2)== "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0)!= ""))
		{
			arr_pk = arr_pk + tmp +grdVisiterfee_golfer.GetGridData(i, 0);
			tmp = ',';
			
			l_green_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 5));
			l_caddy_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 6));
			l_cart_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 7));
			l_golfbag_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i,10));
			l_proshop_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 12));
			l_fnb_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 13));
			l_teehouse_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 14));
			l_drv_range_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 15));
			l_teaching_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 16));
			l_discount_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 11));
			l_other_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 17));
			l_total_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 18));
		}
		txtPKs.text= arr_pk;
	}
	
	//l_other_fee_vnd = l_other_fee_usd*Number(txtExRate.GetData());
	
	txtGreenFeeUSD.text = System.Round(l_green_fee_vnd/Number(txtExRate.text),2);
	txtCaddyFeeUSD.text = System.Round(l_caddy_fee_vnd/Number(txtExRate.text),2);
	txtCardFeeUSD.text = System.Round(l_cart_fee_vnd/Number(txtExRate.text),2);
	txtGolfbagFeeUSD.text = System.Round(l_golfbag_fee_vnd/Number(txtExRate.text),2);
	txtOthersFeeUSD.text = System.Round(l_other_fee_vnd/Number(txtExRate.text),2);
	txtF_B_FeeUSD.text = System.Round(l_fnb_fee_vnd/Number(txtExRate.text),2);
	txtTeeHouseFeeUSD.text = System.Round(l_teehouse_fee_vnd/Number(txtExRate.text),2);
	txtProshopFeeUSD.text = System.Round(l_proshop_fee_vnd/Number(txtExRate.text),2);
	txtDrvRangeFeeUSD.text = System.Round(l_drv_range_fee_vnd/Number(txtExRate.text),2);
	txtTrainingFeeUSD.text = System.Round(l_teaching_fee_vnd/Number(txtExRate.text),2);
	
	txtGreenFeeVND.text = l_green_fee_vnd;
	txtCaddyFeeVND.text = l_caddy_fee_vnd;
	txtCardFeeVND.text = l_cart_fee_vnd;
	txtGolfbagFeeVND.text = l_golfbag_fee_vnd;
	txtOthersFeeVND.text = l_other_fee_vnd;
	txtF_B_FeeVND.text = l_fnb_fee_vnd;
	txtTeeHouseFeeVND.text = l_teehouse_fee_vnd;
	txtProshopFeeVND.text = l_proshop_fee_vnd;
	txtDrvRangeFeeVND.text = l_drv_range_fee_vnd;
	txtTrainingFeeVND.text = l_teaching_fee_vnd;
	
	l_discount_usd = System.Round(l_discount_vnd/Number(txtExRate.text),2);
	
	txtDiscountUSD.text = l_discount_usd;
	txtDiscountVND.text = l_discount_vnd;
	
	txtTotalUSD.text =  System.Round(l_total_fee_vnd/Number(txtExRate.text),2) + l_discount_usd;
	txtTotalVND.text = l_total_fee_vnd + l_discount_vnd;
	
	txtAmountDueUSD.text = System.Round(l_total_fee_vnd/Number(txtExRate.text),2);
	txtAmountDueVND.text = l_total_fee_vnd;
	
    //alert(txtPKs.text);
    data_invoice.Call("SELECT");
}

function  OnSelectInvoice()
{
    if(event.col != 2) return;
    
	var arr_pk ="";
	var rqt = "";
	var tmp ="",arr_master_pk="";
	var bl = 0;
	l_green_fee_usd=0;
	l_green_fee_vnd=0; 
	l_caddy_fee_usd=0; 
	l_caddy_fee_vnd=0; 
	l_cart_fee_usd=0;
	l_cart_fee_vnd=0;
	l_golfbag_fee_usd=0;
	l_golfbag_fee_vnd=0;
	l_discount_usd=0;
	l_discount_vnd=0;
	l_other_fee_usd=0;
	l_other_fee_vnd=0;
	l_teaching_fee_usd=0;
	l_teaching_fee_vnd=0;
	l_drv_range_fee_usd=0;
	l_drv_range_fee_vnd=0;
	l_drv_range_fee_usd=0;
	l_fnb_fee_usd=0;
	l_fnb_fee_vnd=0;
	l_proshop_fee_usd=0;
	l_proshop_fee_vnd=0;
	l_teehouse_fee_usd=0;
	l_teehouse_fee_vnd=0;
	l_total_fee_usd=0;
	l_total_fee_vnd=0;
	
	for (i = 1; i < grdVisiterfee_golfer.rows; i++)
	{
		if((grdVisiterfee_golfer.GetGridData(i,2)== "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0)!= ""))
		{
			arr_pk = arr_pk + tmp +grdVisiterfee_golfer.GetGridData(i, 0);
			tmp = ',';
			
			l_green_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 5));
			l_caddy_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 6));
			l_cart_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 7));
			l_golfbag_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i,10));
			l_proshop_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 12));
			l_fnb_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 13));
			l_teehouse_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 14));
			l_drv_range_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 15));
			l_teaching_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 16));
			l_discount_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 11));
			l_other_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 17));
			l_total_fee_vnd += Number(grdVisiterfee_golfer.GetGridData(i, 18));
		}
		txtPKs.text= arr_pk;
	}
	
	txtGreenFeeUSD.text = System.Round(l_green_fee_vnd/Number(txtExRate.text),2);
	txtCaddyFeeUSD.text = System.Round(l_caddy_fee_vnd/Number(txtExRate.text),2);
	txtCardFeeUSD.text = System.Round(l_cart_fee_vnd/Number(txtExRate.text),2);
	txtGolfbagFeeUSD.text = System.Round(l_golfbag_fee_vnd/Number(txtExRate.text),2);
	txtOthersFeeUSD.text = System.Round(l_other_fee_vnd/Number(txtExRate.text),2);
	txtF_B_FeeUSD.text = System.Round(l_fnb_fee_vnd/Number(txtExRate.text),2);
	txtTeeHouseFeeUSD.text = System.Round(l_teehouse_fee_vnd/Number(txtExRate.text),2);
	txtProshopFeeUSD.text = System.Round(l_proshop_fee_vnd/Number(txtExRate.text),2);
	txtDrvRangeFeeUSD.text = System.Round(l_drv_range_fee_vnd/Number(txtExRate.text),2);
	txtTrainingFeeUSD.text = System.Round(l_teaching_fee_vnd/Number(txtExRate.text),2);
	
	txtGreenFeeVND.text = l_green_fee_vnd;
	txtCaddyFeeVND.text = l_caddy_fee_vnd;
	txtCardFeeVND.text = l_cart_fee_vnd;
	txtGolfbagFeeVND.text = l_golfbag_fee_vnd;
	txtOthersFeeVND.text = l_other_fee_vnd;
	txtF_B_FeeVND.text = l_fnb_fee_vnd;
	txtTeeHouseFeeVND.text = l_teehouse_fee_vnd;
	txtProshopFeeVND.text = l_proshop_fee_vnd;
	txtDrvRangeFeeVND.text = l_drv_range_fee_vnd;
	txtTrainingFeeVND.text = l_teaching_fee_vnd;
	
	l_discount_usd = System.Round(l_discount_vnd/Number(txtExRate.text),2);
	
	txtDiscountUSD.text = l_discount_usd;
	txtDiscountVND.text = l_discount_vnd;
	
	txtTotalUSD.text =  System.Round(l_total_fee_vnd/Number(txtExRate.text),2) + l_discount_usd;
	txtTotalVND.text = l_total_fee_vnd + l_discount_vnd;
	
	txtAmountDueUSD.text = System.Round(l_total_fee_vnd/Number(txtExRate.text),2);
	txtAmountDueVND.text = l_total_fee_vnd;
	
    //alert(txtPKs.text);
    data_invoice.Call("SELECT");
}
var arr_pk ="";
function  OnPrintBill(option)
{
	var rqt = "";
	var tmp ="";
	var arr_master_pk="";
	arr_pk ="";
	var url ="";
	var cur_row;
	for (i = 1; i < grdVisiterfee_golfer.rows; i++)
	{
		if((grdVisiterfee_golfer.GetGridData(i,2) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0) != ""))
		{
		    cur_row = i;		    
		    if(grdVisiterfee_golfer.GetGridData(i,6) == "")
			{
					if(! confirm("This golfer does not have caddy fee. Do you want to print bill?")){
						return;
					}
			}
			arr_pk += tmp +grdVisiterfee_golfer.GetGridData(i, 0);
			tmp = '*';
		}
	}
	
	if(arr_pk == "")
	{
	    alert("Please check item to print.");
		return;
	 }
	
	 if(option == 1){
	    if(isNaN(arr_pk)){
			alert("One invoice for one person only. Please check your selected data(maybe you select more than one person).");
			return;
		}
		var payment_method = grdVisiterfee_golfer.GetGridData(cur_row,26);
		if(payment_method==""){
		   alert("Please select payment method firstly.");
		   return;
		}
		
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rc/jarc0040.rpt&procedure=CRM.sp_sel_jarc00040_invoice_print&parameter="+
	    arr_pk + "," + payment_method + "," +l_crt_by;   
		//alert(url);
	    System.OpenTargetPage(url); 
	    OnSearch();
    }
	else{
		url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ja/rc/jarc0040_preview.rpt&procedure=CRM.sp_sel_jarc00040_preview&parameter="+
		arr_pk+","+txtTaxCode.GetData()+","+url_encode(txtCompany.GetData())+","+url_encode(txtAddress.GetData())+","+l_crt_by;   
		System.OpenTargetPage(url); 
	}
	  
}
function ExecuteFile() {
   if(grdVisiterfee_golfer.row > 0){
        var pk=grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,0);
   }
   else{
        alert("Please select one row to print.");
        return;
   }
    var oShell = new ActiveXObject("Shell.Application");
    try{
        var arg = "checkout_inv "+ pk +" "+l_crt_by;
        
        var file = "C:\\ReportEngine\\ReportEngine.exe";
        oShell.ShellExecute(file, arg, "", "open", "1");
    }
    catch(err){
        alert(err);
    }
}
function CheckDataIsValid(){
    for (i = 1; i < grdVisiterfee_golfer.rows; i++)
	{
		if((grdVisiterfee_golfer.GetGridData(i,2) == "-1"))
		{
		    if(grdVisiterfee_golfer.GetGridData(i,26) == ""){
		        alert("Please select payment method for customer who has locker# is '"+ grdVisiterfee_golfer.GetGridData(i,1)+"'.");
		        return false;
		    }
		    
		}
	}	
	return true;
}
var check_pk="";
function OnCheckOut(){
    
        var arr_pk="", tmp="";
        var cur_row;
        for (var i = 1; i < grdVisiterfee_golfer.rows; i++)
	    {
		    if((grdVisiterfee_golfer.GetGridData(i,2) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0) != ""))
		    {
    		    cur_row = i;		    
		        if(grdVisiterfee_golfer.GetGridData(i,6) == "")
			    {
					    if(! confirm("This golfer does not have caddy fee. Do you want to check out?")){
						    return;
					    }
			    }
			    arr_pk += tmp +grdVisiterfee_golfer.GetGridData(i, 0);
			    tmp = '*';
		    }
	    }
	    //alert(arr_pk);
        if(arr_pk == "")
	    {
	        alert("Please select one guest to check out.");
		    return;
	     }
	
	    if(isNaN(arr_pk)){
			alert("Check out one by one guest. Please check your selected data(maybe you select more than one guest).");
			return;
		}
		check_pk = arr_pk;
		
		if(grdVisiterfee_golfer.GetGridData(cur_row, 20) == ""){alert("Please print bill before checkout!"); return false;}
		
		var path = System.RootURL + '/form/ja/rc/jarc00040_popup.aspx?pk='+arr_pk + '&pay=' + grdVisiterfee_golfer.GetGridData(cur_row, 26);
        var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
        if(object){
            if(object.length == 8){
                for (var i = 1; i < grdVisiterfee_golfer.rows; i++)
	            {
		            if((grdVisiterfee_golfer.GetGridData(i,2) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0) != ""))
		            {
		               grdVisiterfee_golfer.SetGridText(i,26,object[5]);//payment method
		               grdVisiterfee_golfer.SetGridText(i,27,object[0]);//receipt vnd
		               grdVisiterfee_golfer.SetGridText(i,28,object[1]);//receipt usd
		               grdVisiterfee_golfer.SetGridText(i,29,object[2]);//payment vnd
		               grdVisiterfee_golfer.SetGridText(i,30,object[3]);//payment usd
		               grdVisiterfee_golfer.SetGridText(i,31,object[4]);//other profit and lost amt
		               grdVisiterfee_golfer.SetGridText(i,32,object[6]);//return vnd 
		               grdVisiterfee_golfer.SetGridText(i,33,object[7]);//return usd
		               break;//exit for loop
                    }
                }    
                if(CheckDataIsValid()){
		            data_jarc00040.Call();
	            }    
            }
            
        }
    
}
function OnDiscount(){
    var idx = "";
    for (var i = 1; i < grdVisiterfee_golfer.rows; i++)
        if(grdVisiterfee_golfer.GetGridData(i, 2) == "-1")
            idx += i + ",";

    if(idx == ""){alert("Please select one guest to check out.");return;}
    if(idx.split(',').length == 2){
        idx = idx.substr(0,idx.length-1);
        var path = System.RootURL + '/form/ja/rc/jarc00040_discount.aspx?idx='+idx;
        var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
    }else{alert("Please select one guest to check out.");return;}
}
function GetDiscountInfo(idx){
    var arrDisInfo  = new Array();
    arrDisInfo[0]   = grdVisiterfee_golfer.GetGridData(idx, 0);
    arrDisInfo[1]   = grdVisiterfee_golfer.GetGridData(idx, 1);
    arrDisInfo[2]   = grdVisiterfee_golfer.GetGridData(idx, 3);
    arrDisInfo[3]   = grdVisiterfee_golfer.GetGridData(idx, 11);
    arrDisInfo[4]   = txtGreenFeeUSD.text;
    arrDisInfo[5]   = txtCaddyFeeUSD.text;
    arrDisInfo[6]   = txtCardFeeUSD.text;
    arrDisInfo[7]   = txtGolfbagFeeUSD.text;
    arrDisInfo[8]   = txtF_B_FeeUSD.text;
    return arrDisInfo;
}
function GetGuestInfo(){
    for (var i = 1; i < grdVisiterfee_golfer.rows; i++)
	    {
		    if((grdVisiterfee_golfer.GetGridData(i,2) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 0) == check_pk))
		    {
		      var arr = new Array();
		      arr[0]=grdVisiterfee_golfer.GetGridData(i,1);//locker number
		      arr[1]=grdVisiterfee_golfer.GetGridData(i,3);//golfer name
		      
		      arr[2]=grdVisiterfee_golfer.GetGridData(i,28);//Cash USD
		      arr[3]=grdVisiterfee_golfer.GetGridData(i,27);//Cash VND
		      
		      arr[4]=grdVisiterfee_golfer.GetGridData(i,28);//Credit USD
		      arr[5]=grdVisiterfee_golfer.GetGridData(i,27);//Credit VND
		      return arr;
		    }
	    }
}
function GetSumaryAmount(){
    var arrSum = new Array();
    var tmp = new Array();
    //total
    tmp = new Array();
    tmp[0]=txtTotalUSD.text;
    tmp[1]=txtTotalVND.text;
    tmp[2]=txtTotalVAT.text;
    arrSum[arrSum.length]=tmp;
    //green fee
    tmp = new Array();
    tmp[0]=txtGreenFeeUSD.text;
    tmp[1]=txtGreenFeeVND.text;
    tmp[2]=txtGreenFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //facility fee
    tmp = new Array();
    tmp[0]=txtFacilityUSD.text;
    tmp[1]=txtFacilityVND.text;
    tmp[2]=txtFacilityVAT.text;
    arrSum[arrSum.length]=tmp;
    //caddie fee
    tmp = new Array();
    tmp[0]=txtCaddyFeeUSD.text;
    tmp[1]=txtCaddyFeeVND.text;
    tmp[2]=txtCaddyFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee
    tmp = new Array();
    tmp[0]=txtCardFeeUSD.text
    tmp[1]=txtCardFeeVND.text
    tmp[2]=txtCardFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee F&B
    tmp = new Array();
    tmp[0]=txtF_B_FeeUSD.text;
    tmp[1]=txtF_B_FeeVND.text;
    tmp[2]=txtF_B_FeeVAT.text
    arrSum[arrSum.length]=tmp;
    //cart fee Proshop
    tmp = new Array();
    tmp[0]=txtProshopFeeUSD.text;
    tmp[1]=txtProshopFeeVND.text;
    tmp[2]=txtProshopFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee Rental
    tmp = new Array();
    tmp[0]=txtDrvRangeFeeUSD.text;
    tmp[1]=txtDrvRangeFeeVND.text;
    tmp[2]=txtDrvRangeFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee TeeHouse
    tmp = new Array();
    tmp[0]=txtTeeHouseFeeUSD.text;
    tmp[1]=txtTeeHouseFeeVND.text;
    tmp[2]=txtTeeHouseFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee Training
    tmp = new Array();
    tmp[0]=txtTrainingFeeUSD.text;
    tmp[1]=txtTrainingFeeVND.text;
    tmp[2]=txtTrainingFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //cart fee MiniBar
    tmp = new Array();
    tmp[0]=txtDiscountUSD.text;    
    tmp[1]=txtDiscountVND.text;
    tmp[2]=txtDiscountVAT.text;
    arrSum[arrSum.length]=tmp;
    // txtOthersFeeUSD 
    tmp = new Array();
    tmp[0]=txtOthersFeeUSD.text;
    tmp[1]=txtOthersFeeVND.text;
    tmp[2]=txtOthersFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    
     // txtAmountDueUSD 
    tmp = new Array();
    tmp[0]=txtAmountDueUSD.text;
    tmp[1]=txtAmountDueVND.text;
    tmp[2]=txtAmountDueVAT.text;
    arrSum[arrSum.length]=tmp;
    // txtGolfbagFeeUSD 
    tmp = new Array();
    tmp[0]=txtGolfbagFeeUSD.text;
    tmp[1]=txtGolfbagFeeVND.text;
    tmp[2]=txtGolfbagFeeVAT.text;
    arrSum[arrSum.length]=tmp;
    //Ex_rate
    tmp = new Array();
    tmp[0]=txtExRate.text;
    arrSum[arrSum.length]=tmp;
    return arrSum;
}
function OnUnprint(){
	if(confirm("Do you want to set unprint status for these person?")){
		data_jarc00040_unprint.Call();
	}
}

function OnGridClick(){
    var s = "";
	for(var i=1;i<grdVisiterfee_golfer.rows;i++){
		if(grdVisiterfee_golfer.GetGridData(i,2) == "-1"){
			s += grdVisiterfee_golfer.GetGridData(i,1)+", ";
		}
	}
	lblChecked.text = s;
}
function OnGridDblClick(){
    if(event.col == 1){
        var row = event.row;
        if(grdVisiterfee_golfer.GetCellBgColor(row,0,row,grdVisiterfee_golfer.cols-1) == 0){
            var path = System.RootURL + '/form/ja/rc/jarc00040_golfer.aspx?pk='+grdVisiterfee_golfer.GetGridData(row,0);
            var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
            OnSearch();
        }
    }
    if(event.col == 3)
    {
	        if(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,20) != ""){
				alert("This golfer was printed bill. So you can not change any data.");
				return;
			}
            var path = System.RootURL + '/form/ja/rc/jarc00040_chk_out_edit_name.aspx?pk='+grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,0);
            var object = System.OpenModal( path , 750 , 400 ,  'resizable:yes;status:yes',window);
			OnSearch();
    }
}
function SetBGColor(){
	for(var i=1;i<grdVisiterfee_golfer.rows;i++){
		if(grdVisiterfee_golfer.GetGridData(i,20) != ""){
			grdVisiterfee_golfer.SetCellBgColor(i,0,i,grdVisiterfee_golfer.cols-1,0xabcdef);
			grdVisiterfee_golfer.SetCellBold(i,0,i,3,14);
			//grdVisiterfee_golfer.SetCellFontColor(i,0,i,grdVisiterfee_golfer.cols-1,0xaaaaaa);
		}
	}
}
function url_encode(s) {
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return escape(utftext);
}
function OnOtherFees()
{
    if(grdVisiterfee_golfer.row !="-1")
    {
        var path = System.RootURL + "/form/ja/rc/jarc00040_popup_other_fee.aspx?encode_yn=Y&p_master_pk="+grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,0)+"&p_golfer_name="+url_encode(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,3))+"&p_locker="+url_encode(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,1))+"&p_bagtag="+url_encode(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,19))+"";
            var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
    }
    else
    {
        alert("Please select golfer.");
    }       
}
</script>

<body>
    <!-----search and check out--------------->    
    <gw:data id="data_jarc00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,2,26,27,28,29,30,31,32,33" function="crm.sp_sel_jarc00040" procedure="crm.sp_upd_jarc00040">  
                <input>
                    <input bind="txtBagNo" />
                </input>
                <output bind="grdVisiterfee_golfer" />
            </dso>
        </xml>
    </gw:data>
    <!-----get check out persons---------------->
    <gw:data id="dsojarc00040_count_checkout" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="process" procedure="crm.sp_upd_jarc00040_count_chkout">
                <input>
                     <input bind="lblOutCount"/>
                </input>
                <output>
                    <output bind="lblOutCount"/>
                </output>
            </dso>
        </xml>
    </gw:data>
    <!-----Search and set unprint status------------------->
	<gw:data id="data_jarc00040_unprint" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,2" function="crm.sp_sel_jarc00040" procedure="crm.sp_upd_jarc00040_unprint">
                <input>
                    <input bind="txtBagNo" />
                </input>
                <output bind="grdVisiterfee_golfer" />
            </dso>
        </xml>
    </gw:data>
	
    <gw:data id="data_invoice" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" function="crm.sp_sel_jarc00040_invoice" >
                <input>
                    <input bind="txtPKs" />
                </input>
                <output bind="grdInvoice" />
            </dso>
        </xml>
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
                    <tr>
                        <td colspan="2">
                            <table style="height: 100%; width: 100%">
                                <tr >
								    <td>
										<table width="100%"  cellpadding="0" cellspacing="0" >
											<tr>
												    <td style="width: 5%">Locker#</td>
												    <td style="width: 1%"></td>
													<td style="width:7%">
													   <gw:textbox id="txtBagNo" styles="width:100%" onenterkey="OnSearch()"  />
													</td>
													<td style="width: 1%"></td>
													<td style="width: 5%">
														 <gw:icon id="btnSearch" img="2" text="Search" styles='width:100%' onclick="OnSearch()" />
													</td>
													<td style="width: 1%"></td>
													<td style="width: 5%">
														 <gw:icon id="btnSetUnprint" img="2" text="Set Unprint" styles='width:100%' onclick="OnUnprint()" />
													</td>
													<td style="width: 1%"></td>
													<td style="width: 5%">
														 <gw:icon id="idBtnPreview" img="2" text="Preview" styles='width:100%' onclick="OnPrintBill(2)" />
													</td>
													<td style="width: 1%"></td>
													<td style="width: 5%">
														 <gw:icon id="idBtnPrintBill" img="2" text="Print Bill" styles='width:100%' onclick="OnPrintBill(1)" />
													</td>
													<td style="width: 1%"></td>
													<td style="width: 5%">
														 <gw:icon id="idBtnDisCount" img="2" text="Discount" styles='width:100%' onclick="OnDiscount();" />
													</td>
													
                                                    <td style="width:1%;">
													     <gw:icon id="idBtnPrint" img="2" text="Print" styles='width:100%;display:none;' onclick="ExecuteFile()" />
													</td>
													<td style="width:4%">Ex.Rate</td>
													<td style="width:4%">
														<gw:textbox id="txtExRate" styles="width:100%" type="number" format="###,###,###" />
													</td>
													<td style="width: 1%"></td>
													<td style="width:5%">Checked:</td>
													<td style="width:10%">
														<gw:label id="lblChecked" styles="width:100%"  />
													</td>
													<td style="width:5%">
														<gw:icon id="idBtnCheckOut" img="2" text="Check Out" styles='width:100%' onclick="OnCheckOut()" />
													</td>
											</tr>
										</table>
									</td>
                                    
                                </tr>
                                <tr>
								    <td>
										<table width="100%" cellpadding="0" cellspacing="0">	
									      <tr >
										       <td style="width:7%;"  >Taxcode </td>
												<td style="width:10%">
													 <gw:textbox id="txtTaxCode" styles="width:100%"   /> 
												</td>
												<td style="width:5%;">Customer</td>
												 <td style="width:20%">
													<gw:textbox id="txtCompany" styles="width:100%"  />
												</td>
												<td style="width:5%">Address</td>
												<td style="width:20%" align="right">
													<gw:textbox id="txtAddress" styles="width:100%"  />
												</td>
												<td style="width:5%">Remain:</td>
												<td style="width:5%">
													<gw:label id="lblRows" styles="width:100%"  />
												</td>
												<td style="width:5%">Checkout:</td>
												<td style="width:5%">
													<gw:label id="lblOutCount" styles="width:100%"  />
												</td>
												<td width="5%"></td>
												<td width="8%"><gw:icon id="idBtnOtherFees" img="2" text="Other Fees" styles='width:100%' onclick="OnOtherFees()" /></td>
											</tr>
										</table>
									</td>
									
								</tr>
                                
                                <tr>
                                        <td style="width: 100%" >
                                        <gw:grid id='grdVisiterfee_golfer' 
                                            header='_pk|Locker#|Check|Golfer Name|Member Type|Green Fee|Caddie Fee|Cart Fee|Holes|_Other Rental Fee|_Golfbag|_Discount|_Proshop|_FnB|_Teehouse|_DrvRange|_Teaching|_Other|Total|Grp#|Invoice#|Bagtag#|Check In|_Company Name|_Company Address|_Tax Code|Payment Method|_Received VND|_Received USD|_Refund VND|_Refund USD|_Other PL Amt|_Guest Tips VND|_Guest Tips USD'
                                            format='0|0|3|0|0|-0|-0|-0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|-0|-0|-2|-0|-2|-0|-0|-2|0|0' 
                                            aligns='0|0|0|0|0|0|0|3|3|3|0|0|0|3|3|3|0|0|0|0|0|0|0|0|0|3|3|3|3|3|0|0|0|0' 
                                            editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|0|0'
                                            autosize='T'  
                                            sorting='T' styles='width:100%; height:130'
                                           onafteredit="OnSelectInvoice()" oncellclick="OnGridClick()" oncelldblclick="OnGridDblClick()"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr >
                        <td style="width: 39%;background-color:#33CCFF">
                            <table style="height: 100%; width: 100%;border:0px;" cellspacing="1" cellpadding="1">
                                <tr style="height: 2%;" valign="top">
                                    <td style="background-color:White;width:25%"></td>
                                    <td align="center" style="background-color:White">USD</td>
                                    <td align="center" style="background-color:White">VND</td>
                                    <td align="center" style="background-color:White">VAT</td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:Red;padding-left:5px;" valign="middle">Total Due</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtAmountDueUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtAmountDueVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtAmountDueVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:Yellow;padding-left:5px;" valign="middle">Discount</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDiscountUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDiscountVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDiscountVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Total</td>
                                    <td style="background-color:White"><gw:textbox id="txtTotalUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###.##" /></td>
                                    <td style="background-color:White"><gw:textbox id="txtTotalVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                                    <td style="background-color:White"><gw:textbox id="txtTotalVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###"  /></td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Green Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGreenFeeUSD" type="number" format="###,###,###,###.##" styles="width:100%;border:0px;"  /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGreenFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGreenFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Facility</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtFacilityUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtFacilityVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtFacilityVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Caddie Fee</td> 
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCaddyFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCaddyFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCaddyFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Cart Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCardFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCardFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtCardFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">F&B Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtF_B_FeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtF_B_FeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtF_B_FeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Tee House</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTeeHouseFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTeeHouseFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTeeHouseFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###"/></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Proshop Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtProshopFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtProshopFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtProshopFeeVAT" styles="width:100%;border:0px;"  type="number" format="###,###,###,###,###"/></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Rental Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGolfbagFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGolfbagFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtGolfbagFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Drv.Range</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDrvRangeFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDrvRangeFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtDrvRangeFeeVAT" styles="width:100%;border:0px;"  type="number" format="###,###,###,###,###"/></td>
                                </tr>
                                
                                <tr style="height: 2%" valign="top">
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Teaching Fee </td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTrainingFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTrainingFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtTrainingFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                
                                 <tr style="height: 2%" valign="top"> 
                                    <td style="background-color:White;padding-left:5px;" valign="middle">Others Fee</td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtOthersFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtOthersFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                    <td align="right" style="background-color:White"><gw:textbox id="txtOthersFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                                </tr>
                                
                            </table>
                        </td>
                        <td style="width: 60%">
                            <table style="height: 100%; width: 100%">
                                
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id='grdInvoice' 
                                            header='No|Golfer Name|Location|Invoice#/Item|Amount|Discount|Total Due|Locker#'
                                            format='0|0|0|0|-0|-0|-0|0' aligns='0|0|0|0|3|3|3|0' 
                                            autosize="T"
                                            editcol='0|0|0|0|0|0|0|0'
                                            widths='1500|1500|1500|1500|2000|3000|1500|1000' sorting='T' styles='width:100%; height:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
    </table>
    <gw:textbox id="txtPKs" styles="width:100%; display:none" />
    
    <!------------------------------------------------------------------------>
</body>
</html>