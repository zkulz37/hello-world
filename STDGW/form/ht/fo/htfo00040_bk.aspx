<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Check Out</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var COL_PK			    = 0,
	COL_SELECT		    = 1,
	COL_ROOM_NO		    = 2,
	COL_FROM_DATE	    = 3,
	COL_TO_DATE	        = 4,
	COL_RATE_NAME      	= 5,
	COL_DAILY_RATE      = 6,
	COL_TT_DAYS         = 7,
	COL_ROOM_CHARGE	    = 8,
	COL_GUEST_NAME	    = 9,
	COL_GENDER		    = 10,
	COL_NATION		    = 11,
	COL_INVOICE_NO      = 12,
	COL_PAY_METHOD	    = 13,
	COL_CASH_VND	    = 14,
	COL_CASH_USD	    = 15,
	COL_REMAIN_VND      = 16,
	COL_REMAIN_USD      = 17,
	COL_GUEST_RTN_VND   = 18,
	COL_GUEST_RTN_USD   = 19,
	COL_OTHER_PL_AMT    = 20,
	COL_DESCRIPTION	    = 21,
	COL_THT_ROOM_PK	    = 22,
	COL_DISCOUNT	    = 23,
	COL_DEPOSIT			= 24,
	COL_FEE_MINIBAR		= 25,
	COL_FEE_LAUNDRY		= 26,
	COL_FEE_FNB			= 27,
	COL_FEE_OTHER		= 28,
	COL_FEE_TOTAL		= 29,
	COL_TOTAL_DUE		= 30,
	COL_COMP_PK			= 31,
	COL_COMP_NAME		= 32,
	COL_COMP_TAXCODE	= 33,
	COL_COMP_ADDRESS	= 34,
	COL_CREDIT_TYPE		= 35,
	COL_GOLF_FEES		= 36,
	
    COL2_NO             = 0,
    COL2_PK             = 1,
    COL2_ROOM_NO        = 2,
    COL2_NAME           = 3,
    COL2_LOCATION       = 4,
    COL2_INVOICE_ID     = 5,
    COL2_DATE           = 6,
    COL2_AMT            = 7,
    COL2_POINT          = 8,
    COL2_BASIC_AMT      = 9,
    COL2_SERVICE_AMT    = 10,
    COL2_VAT_AMT        = 11,
    COL2_AMT_USD        = 12,
    COL2_DISCOUNT       = 13;
    
function BodyInit()
{
    //grdMST.GetGridControl().FrozenCols=12;
	
	BindingDataList();
	OnSearch(1);
	COMP_PK.text = "<%=Session("COMPANY_PK") %>";
	txtExRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_sell_ex_rate(2,'USD') from dual")%> VND";
	EMPLOYEE_PK.text = "<%=Session("EMPLOYEE_PK") %>";
	var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT code,NAME FROM comm.tco_commcode WHERE DEL_IF=0 and  parent_code='PTYPE' and use_yn='Y'")%>";
    grdMST.SetComboFormat(COL_PAY_METHOD, data);
}

function BindingDataList()
{
	var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	grdMST.SetComboFormat(COL_GENDER, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	grdMST.SetComboFormat(COL_NATION, data);
	
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-08','POINT-09','POINT-10','POINT-11','POINT-12','POINT-13','POINT-14','POINT-15','POINT-17','POINT-18') UNION SELECT '','SELECT ALL' FROM DUAL) A ORDER BY CODE DESC")%>";
	lstLocation.SetDataText(data);
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_htfo00040.Call('SELECT');
			txtCustomer.text    = "";
			txtTaxcode.text     = "";
			txtAddress.text     = "";
			grdSRV.ClearData();
		break;
		case 2:
		    if(event.col == COL_SELECT){
		        var arr_pk = "";
		        if(grdMST.GetGridData(event.row, COL_SELECT)=="-1" && grdMST.GetGridData(event.row, COL_PK)!= ''){
		                arr_pk = arr_pk + grdMST.GetGridData(event.row, COL_PK) + ',';
		        }
		    
		        for (i = 1; i < grdMST.rows; i++)
		            grdMST.SetGridText(i, COL_SELECT, "0");
		            
		        grdMST.SetGridText(event.row, COL_SELECT,(arr_pk.length>1)?"-1":"0");
		        
		        txtCustomer.text = (grdMST.GetGridData(event.row, COL_SELECT)=="-1")?grdMST.GetGridData(event.row, COL_GUEST_NAME):"";
		        var iLen = String(arr_pk).length;
		        if(iLen > 0)
		            arr_pk = String(arr_pk).substring(0, iLen - 1);
		        else{txtCustomer.text = ""; txtTaxcode.text = ""; txtAddress.text = ""; }
		        
                TABLE_PK.text = arr_pk;
				txtDiposit.text = grdMST.GetGridData(event.row, COL_DEPOSIT);
				
				OnBindDetail();
				lstLocation.value = '';
			    dso_htfo00040_srv.Call('SELECT');
		    }else if(event.col == 8){
		        //0 ~ 11
                var dtfrom = new Date(); var dtto = new Date();var one_day=1000*60*60*24;var tt_day;
                dtfrom.setFullYear(Number(grdMST.GetGridData(event.row,COL_FROM_DATE).substring(0,4)),Number(grdMST.GetGridData(event.row,COL_FROM_DATE).substring(4,6))-1,Number(grdMST.GetGridData(event.row,COL_FROM_DATE).substring(6,8)));
                dtto.setFullYear(Number(grdMST.GetGridData(event.row,COL_TO_DATE).substring(0,4)),Number(grdMST.GetGridData(event.row,COL_TO_DATE).substring(4,6))-1,Number(grdMST.GetGridData(event.row,COL_TO_DATE).substring(6,8)));
                tt_day = ((dtto-dtfrom)/one_day);
                if(tt_day < 0){alert("To date more than From date!");return;}
                tt_day++;
                
                grdMST.SetGridText(event.row, COL_TT_DAYS, tt_day);
                grdMST.SetGridText(event.row, COL_ROOM_CHARGE, tt_day*Number(grdMST.GetGridData(event.row, COL_DAILY_RATE)));
                
                dso_htfo00040_srv.Call('SELECT');
		    }
		    else return false;
		break;
		case 3:
		    var path = System.RootURL + '/form/ht/fo/htfo00041.aspx?pk=' + grdSRV.GetGridData(grdSRV.row, 1) + '&sn=' + grdSRV.GetGridData(grdSRV.row, 5)+ '&date=' + grdSRV.GetGridData(grdSRV.row, 6).substring(6,8) + '/' + grdSRV.GetGridData(grdSRV.row, 6).substring(4,6)+ '/' + grdSRV.GetGridData(grdSRV.row, 6).substring(0,4)+ '&room=' + grdSRV.GetGridData(grdSRV.row, 2);
            var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
		break;
		case 4:
		    var path = System.RootURL, obj, flag = false;
		    switch(lstLocation.value){
		        default:
		            path += '/form/ht/fo/htfo00260.aspx'; flag = true;
		        break;
				case "POINT-12":
					path += '/form/ht/fo/htfo00070.aspx'; flag = true;
				break;
		    }
		    if(flag){
		        obj = System.OpenModal( path ,900 , 800,  'resizable:yes;status:yes');
		        IsPostBack();
		    }
		break;
		case 5:
		break;
		case 6:
		    var path = System.RootURL + '/form/ht/fo/htfo00040_correct.aspx';
            var obj = System.OpenModal( path ,900 , 800,  'resizable:yes;status:yes');
            IsPostBack();
		break;
	}
}
function LisOnChange(){
	dso_htfo00040_srv.Call('SELECT');
}
function OnPreview(){
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, 1) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
    
    if(!flag){alert("Please choose customer!");return;}

    txtCustomer.text = Trim(txtCustomer.text);
    
    if(txtCustomer.text == ""){alert("Please input customer!");return;}
	
	if(grdMST.GetGridData(idx,COL_PAY_METHOD) == ''){alert("Please choose payment method!");return false;}
    DATE_TO.text = grdMST.GetGridData(idx,COL_TO_DATE);
    /*
    var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ht/fo/htfo00040.rpt&procedure=CRM.sp_rpt_htfo00040&parameter=" + TABLE_PK.GetData() +","+EMPLOYEE_PK.text+",N";
    System.OpenTargetPage(url); */
	var url = '/reports/ht/fo/htfo00040.aspx?p1=' + TABLE_PK.GetData() +"&p2="+EMPLOYEE_PK.text + "&p3=N&p4=" + grdMST.GetGridData(idx,COL_PAY_METHOD);
	System.OpenTargetPage( System.RootURL+url , "newform" );
    
}

function OnPrint(){
    if(CheckDateIsValid()){/*
        txtCustomer.text = Trim(txtCustomer.text);
        if(txtCustomer.text == ""){alert("Please input customer!");return;}
        /*
        var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ht/fo/htfo00040.rpt&procedure=CRM.sp_rpt_htfo00040&parameter=" + TABLE_PK.GetData() +"," + EMPLOYEE_PK.text + ",Y";
		System.OpenTargetPage(url); */
		var flag = false; var idx = 0;
		for (i = 1; i < grdMST.rows; i++){
			flag = (grdMST.GetGridData(i, 1) == "-1");
			if(flag){idx = i; i = grdMST.rows;}}
			
		if(grdMST.GetGridData(idx,COL_PAY_METHOD) == ''){alert("Please choose payment method!");return false;}
        var url = '/reports/ht/fo/htfo00040.aspx?p1=' + TABLE_PK.GetData() +"&p2="+EMPLOYEE_PK.text + "&p3=Y&p4=" + grdMST.GetGridData(idx,COL_PAY_METHOD);
		System.OpenTargetPage( System.RootURL+url , "newform" );
		OnSearch(1);
    }
}
function OnPrintInvoice(){
    if(CheckDateIsValid()){/*
        txtCustomer.text = Trim(txtCustomer.text);
        if(txtCustomer.text == ""){alert("Please input customer!");return;}
        /*
        var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ht/fo/htfo00040.rpt&procedure=CRM.sp_rpt_htfo00040&parameter=" + TABLE_PK.GetData() +"," + EMPLOYEE_PK.text + ",Y";
		System.OpenTargetPage(url); */
		var flag = false; var idx = 0;
		for (i = 1; i < grdMST.rows; i++){
			flag = (grdMST.GetGridData(i, 1) == "-1");
			if(flag){idx = i; i = grdMST.rows;}}
			
		if(grdMST.GetGridData(idx,COL_PAY_METHOD) == ''){alert("Please choose payment method!");return false;}
        var url = '/reports/ht/fo/Invoice.aspx?p1=' + TABLE_PK.GetData() +"&p2="+EMPLOYEE_PK.text + "&p3=Y&p4=" + grdMST.GetGridData(idx,COL_PAY_METHOD);
		System.OpenTargetPage( System.RootURL+url , "newform" );
		OnSearch(1);
    }
}
function OnUnPrint(){
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
        
    if(!flag){alert("Please choose customer!");return false;}
    
    if(grdMST.GetGridData(idx, COL_INVOICE_NO) == '0'){alert('Customer ' + grdMST.GetGridData(idx, COL_GUEST_NAME) + ' was not printed!'); return false;}
    
    dso_htfo00040_unprint.Call();
}

function OnChangeDate(){
    if(CheckDateIsValid())
        dso_jarc00040_date_to.Call();
}
/*
function CheckDateIsValid(){
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
        
    if(!flag){alert("Please choose customer!");return false;}
    if(grdMST.GetCellBgColor(idx, COL_INVOICE_NO) != ""){alert("Customer " + grdMST.GetGridData(idx, COL_GUEST_NAME) + " already print bill!");return false;}
    
    
    return true;
}*/
function CheckDateIsValid(){
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
        
    if(!flag){alert("Please choose customer!");return false;}
    //if(grdMST.GetCellBgColor(idx, COL_INVOICE_NO) != ""){alert("Customer " + grdMST.GetGridData(idx, COL_GUEST_NAME) + " already print bill!");return false;}
    var dtfrom = new Date(); var dtto = new Date();var one_day=1000*60*60*24;var tt_day;
    dtfrom.setFullYear(Number(grdMST.GetGridData(idx,COL_FROM_DATE).substring(0,4)),Number(grdMST.GetGridData(idx,COL_FROM_DATE).substring(4,6))-1,Number(grdMST.GetGridData(idx,COL_FROM_DATE).substring(6,8)));
    dtto.setFullYear(Number(grdMST.GetGridData(idx,COL_TO_DATE).substring(0,4)),Number(grdMST.GetGridData(idx,COL_TO_DATE).substring(4,6))-1,Number(grdMST.GetGridData(idx,COL_TO_DATE).substring(6,8)));
    tt_day = ((dtto-dtfrom)/one_day);
    if(tt_day < 0){alert("Departure more than Arrival!");return false;}
    
    DATE_TO.text = grdMST.GetGridData(idx,COL_TO_DATE);
    return true;
}
function OnDiscount(){
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
    
    if(!flag){alert("Haven't customer for discount!");return false;}
    if(grdMST.GetGridData(idx, COL_INVOICE_NO) != ""){alert("Customer " + grdMST.GetGridData(idx, COL_GUEST_NAME) + " already print bill can not discount!");return false;}
    
    var path = System.RootURL + '/form/ht/fo/htfo00040_discount.aspx?idx='+idx;
    var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
}
function OnCheckOut()
{
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
    
    if(!flag){alert("Haven't customer for checkout!");return false;}
    if(grdMST.GetGridData(idx, COL_INVOICE_NO) == ""){alert("Please print bill before checkout!"); return false;}
    
        var path = System.RootURL + '/form/ht/fo/htfo00040_popup.aspx?pk=' +grdMST.GetGridData(idx, COL_PK);
        var object = System.OpenModal( path , 850 , 570 ,  'resizable:yes;status:yes',window);
        if(object){
            if(object.length == 13){
                for (var i = 1; i < grdMST.rows; i++)
	            {
		            if((grdMST.GetGridData(i,COL_SELECT) == "-1") &&(grdMST.GetGridData(i, COL_PK) != ""))
		            {
		               grdMST.SetGridText(i, COL_PAY_METHOD     ,object[5]);  //payment method
		               grdMST.SetGridText(i, COL_CASH_VND       ,object[0]);  //receipt vnd
		               grdMST.SetGridText(i, COL_CASH_USD       ,object[1]);  //receipt usd
		               grdMST.SetGridText(i, COL_REMAIN_VND     ,object[2]);  //payment vnd
		               grdMST.SetGridText(i, COL_REMAIN_USD     ,object[3]);  //payment usd
		               grdMST.SetGridText(i, COL_OTHER_PL_AMT   ,object[4]);  //other profit and lost amt
		               grdMST.SetGridText(i, COL_GUEST_RTN_VND  ,object[6]);  //return vnd 
		               grdMST.SetGridText(i, COL_GUEST_RTN_USD  ,object[7]);  //return usd
					   grdMST.SetGridText(i, COL_COMP_PK  		,object[8]);  //return company pk
					   grdMST.SetGridText(i, COL_COMP_NAME  	,object[9]);  //return company name
					   grdMST.SetGridText(i, COL_COMP_TAXCODE  	,object[10]); //return company taxcode
					   grdMST.SetGridText(i, COL_COMP_ADDRESS  	,object[11]); //return compnay address
					   grdMST.SetGridText(i, COL_CREDIT_TYPE  	,object[12]); //return credit type
		               break;//exit for loop
                    }
                }    
                if(CheckDataIsValid()){
		            dso_htfo00040_checkout.Call();
	            }
            }
            
        }
}
function OnOtherFees()
{
    var flag = false; var idx = 0;
    for (i = 1; i < grdMST.rows; i++){
        flag = (grdMST.GetGridData(i, COL_SELECT) == "-1");
        if(flag){idx = i; i = grdMST.rows;}}
    
    if(!flag){alert("Haven't customer for add other fees!");return false;}
    if(grdMST.GetGridData(idx, COL_INVOICE_NO) != ""){alert("Customer " + grdMST.GetGridData(idx, COL_GUEST_NAME) + " already print bill can not add other fees!");return false;}

    if(grdMST.row != "-1")
    {
        var path = System.RootURL + "/form/ht/fo/htfo00040_popup_other_fee.aspx?encode_yn=Y&p_master_pk="+grdMST.GetGridData(idx, COL_PK)+"&p_golfer_name="+url_encode(grdMST.GetGridData(idx, COL_GUEST_NAME))+"&p_room_no="+url_encode(grdMST.GetGridData(idx, COL_ROOM_NO))+"";
        var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
        dso_htfo00040_srv.Call('SELECT');
    }   
}
function IsPostBack(){
    //Room
    txtRoomFeeUSD.text = '0';
    txtRoomFeeVND.text = '0';
    txtRoomFeeVAT.text = '0'; 
    txtRoomFeeSVC.text = '0'; 
    
    //Minibar
    txtMinibarFeeUSD.text = '0';
    txtMinibarFeeVND.text = '0';
    txtMinibarFeeVAT.text = '0'; 
    txtMinibarFeeSVC.text = '0'; 
    
    //Laundry
    txtLaundryFeeUSD.text = '0';
    txtLaundryFeeVND.text = '0';
    txtLaundryFeeVAT.text = '0'; 
    txtLaundryFeeSVC.text = '0'; 
    
    //F&B
    txtFNBFeeUSD.text = '0';
    txtFNBFeeVND.text = '0';
    txtFNBFeeVAT.text = '0'; 
    txtFNBFeeSVC.text = '0'; 
    
    //Other
    txtOtherFeeUSD.text = '0';
    txtOtherFeeVND.text = '0';
    txtOtherFeeVAT.text = '0';
    txtOtherFeeSVC.text = '0';
    
    //Total
    txtTotalUSD.text = '0';
    txtTotalVND.text = '0';
    txtTotalVAT.text = '0';
    txtTotalSVC.text = '0';
    
    OnSearch(1);
}

function GetSumaryAmount(){
    var arrSum = new Array();
    var tmp = new Array();
    //total
    tmp = new Array();
    tmp[0]=txtAmountDueUSD.text;
    tmp[1]=txtAmountDueVND.text;
    tmp[2]=txtAmountDueVAT.text;
    tmp[3]=txtAmountDueSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //Room
    tmp = new Array();
    tmp[0]=txtRoomFeeUSD.text;
    tmp[1]=txtRoomFeeVND.text;
    tmp[2]=txtRoomFeeVAT.text;
    tmp[3]=txtRoomFeeSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //Minibar
    tmp = new Array();
    tmp[0]=txtMinibarFeeUSD.text;
    tmp[1]=txtMinibarFeeVND.text;
    tmp[2]=txtMinibarFeeVAT.text;
    tmp[3]=txtMinibarFeeSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //Laundry
    tmp = new Array();
    tmp[0]=txtLaundryFeeUSD.text;
    tmp[1]=txtLaundryFeeVND.text;
    tmp[2]=txtLaundryFeeVAT.text;
    tmp[3]=txtLaundryFeeSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //F&B
    tmp = new Array();
    tmp[0]=txtFNBFeeUSD.text
    tmp[1]=txtFNBFeeVND.text
    tmp[2]=txtFNBFeeVAT.text;
    tmp[3]=txtFNBFeeSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //Other
    tmp = new Array();
    tmp[0]=txtOtherFeeUSD.text;
    tmp[1]=txtOtherFeeVND.text;
    tmp[2]=txtOtherFeeVAT.text;
    tmp[3]=txtOtherFeeSVC.text;
    arrSum[arrSum.length]=tmp;

    //Golf fees
    tmp = new Array();
    tmp[0]=txtGolfFeeUSD.text;
    tmp[1]=txtGolfFeeVND.text;
    tmp[2]=txtGolfFeeVAT.text;
    tmp[3]=txtGolfFeeSVC.text;
    arrSum[arrSum.length]=tmp;
    
    //Ex_rate
    tmp = new Array();
    tmp[0]=txtExRate.text.substring(0,txtExRate.text.length-4);    
    arrSum[arrSum.length]=tmp;
    return arrSum;
}
function GetGuestInfo(){
    for (var i = 1; i < grdMST.rows; i++)
	    {
		    if(grdMST.GetGridData(i,COL_SELECT) == "-1")
		    {
		      var arr = new Array();
		      arr[0]=grdMST.GetGridData(i, COL_ROOM_NO);
		      arr[1]=grdMST.GetGridData(i, COL_GUEST_NAME);
		      return arr;
		    }
	    }
}
function GetDiscountInfo(idx){
    var arrDisInfo  = new Array();
    arrDisInfo[0]   = grdMST.GetGridData(idx, COL_PK);
    arrDisInfo[1]   = grdMST.GetGridData(idx, COL_ROOM_NO);
    arrDisInfo[2]   = grdMST.GetGridData(idx, COL_GUEST_NAME);
    return arrDisInfo;
}
function CheckDataIsValid(){
    for (i = 1; i < grdMST.rows; i++)
	{
		if((grdMST.GetGridData(i, COL_SELECT) == "-1"))
		{
		    if(grdMST.GetGridData(i,COL_PAY_METHOD) == ""){
		        alert("Please select payment method for customer who has room# is '"+ grdMST.GetGridData(i,COL_ROOM_NO)+"'.");
		        return false;
		    }
		}
	}	
	return true;
}
function SetBGColor(){
	for(var i=1;i<grdMST.rows;i++){
		if(grdMST.GetGridData(i, COL_INVOICE_NO) != ""){
			grdMST.SetCellBgColor(i,0,i,grdMST.cols-1,0xabcdef);
		}
	}
}
function OnBindDetail(){
	var 		l_total_VND     = 0, 
				l_total_DUE     = 0, 
                l_Discount_VND  = 0,
                l_Room_VND      = 0,
                l_Minibar_VND   = 0,
                l_Laundry_VND   = 0,
                l_FNB_VND       = 0,
                l_Bar_VND       = 0,
                l_Telephone_VND = 0,
                l_Karaoke_VND   = 0,
                l_Massage_VND   = 0,
                l_Spa_VND       = 0,
                l_Other_VND     = 0,
                l_Rate          = 0,
				l_Daily			= 0,
l_Golf_Fees_VND=0
                ;
            
            l_Rate = Number(String(txtExRate.GetData()).substring(0, txtExRate.GetData().length - 4));
            for (i = 1; i < grdMST.rows; i++)
                if(grdMST.GetGridData(i,1)=="-1" && grdMST.GetGridData(i, COL_PK)!= ''){
                    l_Discount_VND  += Number(grdMST.GetGridData(i, COL_DISCOUNT));
					l_total_VND		+= Number(grdMST.GetGridData(i, COL_FEE_TOTAL));
					l_total_DUE		+= Number(grdMST.GetGridData(i, COL_TOTAL_DUE));
					l_Room_VND      += Number(grdMST.GetGridData(i, COL_ROOM_CHARGE));
					l_Minibar_VND	+= Number(grdMST.GetGridData(i, COL_FEE_MINIBAR));
					l_Laundry_VND	+= Number(grdMST.GetGridData(i, COL_FEE_LAUNDRY));
					l_FNB_VND		+= Number(grdMST.GetGridData(i, COL_FEE_FNB));
					l_Other_VND		+= Number(grdMST.GetGridData(i, COL_FEE_OTHER));
                                        l_Golf_Fees_VND		+= Number(grdMST.GetGridData(i, COL_GOLF_FEES)); 
                }
			
			//5%
			txtAmountDueSVC.text  	= Math.round(l_total_VND	*	0.05); 
			txtTotalSVC.text      	= Math.round(l_total_VND	*	0.05); 
			txtRoomFeeSVC.text    	= Math.round(l_Room_VND		*	0.05);
			txtMinibarFeeSVC.text   = Math.round(l_Minibar_VND	*	0.05);
			txtLaundryFeeSVC.text   = Math.round(l_Laundry_VND	*	0.05);
			txtFNBFeeSVC.text   	= Math.round(l_FNB_VND		*	0.05);
			txtOtherFeeSVC.text   	= Math.round(l_Other_VND	*	0.05);
			
			//10%
			txtAmountDueVAT.text    = Math.round((l_total_VND	+	Number(txtTotalSVC.text))		*	0.1);
			txtTotalVAT.text      	= Math.round((l_total_VND	+	Number(txtTotalSVC.text))		*	0.1);
			txtRoomFeeVAT.text      = Math.round((l_Room_VND	+	Number(txtRoomFeeSVC.text))		*	0.1);
			txtMinibarFeeVAT.text   = Math.round((l_Minibar_VND	+	Number(txtMinibarFeeSVC.text))	*	0.1);
			txtLaundryFeeVAT.text   = Math.round((l_Laundry_VND	+	Number(txtLaundryFeeSVC.text))	*	0.1);
			txtFNBFeeVAT.text   	= Math.round((l_FNB_VND		+	Number(txtFNBFeeSVC.text))		*	0.1);
			txtOtherFeeVAT.text   	= Math.round((l_Other_VND	+	Number(txtOtherFeeSVC.text))	*	0.1);
				
			//VND
			txtAmountDueVND.text    = l_total_DUE;
			txtDiscountVND.text		= l_Discount_VND;
			txtTotalVND.text      	= Math.round(l_total_VND	+	Number(txtTotalSVC.text)		+ 	Number(txtTotalVAT.text));
			txtRoomFeeVND.text      = Math.round(l_Room_VND		+	Number(txtRoomFeeSVC.text)		+ 	Number(txtRoomFeeVAT.text));
			txtMinibarFeeVND.text   = Math.round(l_Minibar_VND	+	Number(txtMinibarFeeSVC.text)	+ 	Number(txtMinibarFeeVAT.text));
			txtLaundryFeeVND.text   = Math.round(l_Laundry_VND	+	Number(txtLaundryFeeSVC.text)	+ 	Number(txtLaundryFeeVAT.text));
			txtFNBFeeVND.text   	= Math.round(l_FNB_VND		+	Number(txtFNBFeeSVC.text)		+ 	Number(txtFNBFeeVAT.text));
			txtOtherFeeVND.text   	= Math.round(l_Other_VND	+	Number(txtOtherFeeSVC.text)		+ 	Number(txtOtherFeeVAT.text));
			txtGolfFeeVND.text   	= Math.round(l_Golf_Fees_VND);
			
			//USD
			txtAmountDueUSD.text    = Math.round(Number(txtAmountDueVND.text)	/l_Rate*100)/100;
			txtDiscountUSD.text    	= Math.round(Number(txtDiscountVND.text)	/l_Rate*100)/100;
			txtTotalUSD.text      	= Math.round(Number(txtTotalVND.text)		/l_Rate*100)/100;
			txtRoomFeeUSD.text      = Math.round(Number(txtRoomFeeVND.text)		/l_Rate*100)/100;
			txtMinibarFeeUSD.text   = Math.round(Number(txtMinibarFeeVND.text)	/l_Rate*100)/100;
			txtLaundryFeeUSD.text   = Math.round(Number(txtLaundryFeeVND.text)	/l_Rate*100)/100;
			txtFNBFeeUSD.text   	= Math.round(Number(txtFNBFeeVND.text)		/l_Rate*100)/100;
			txtOtherFeeUSD.text   	= Math.round(Number(txtOtherFeeVND.text)	/l_Rate*100)/100;
                       	txtGolfFeeUSD.text   	= Math.round(Number(txtGolfFeeVND.text)	/l_Rate*100)/100;
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "dso_htfo00040_srv":
			if (grdSRV.rows > 1)	
				grdSRV.Subtotal( 1, 2, -1, '7');
        break;
        case "dso_htfo00040_upd":
            OnSearch(1);
            alert("Check out finish");
        break;
        case "dso_htfo00040_upd_invifo":
            var url = System.RootURL + "/system/ReportEngine.aspx?encode_yn=Y&export_pdf=Y&file=ht/fo/htfo00040.rpt&procedure=CRM.sp_rpt_htfo00040|CRM.sp_rpt_htfo00040_dt&parameter=" + TABLE_PK.GetData() + "|" + TABLE_PK.GetData();
            System.OpenTargetPage(url); 
            window.close();
            //SetBGColor();
            OnSearch(1)
        break;
        case "dso_htfo00040_checkout":
        case "dso_htfo00040_unprint":
        case "dso_jarc00040_date_to":
        case "dso_htfo00040":
            SetBGColor();
			lblTotalRoom.text = grdMST.rows - 1;
        break;
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
</script>
<body style="margin: 0 0 0 0;">
<gw:data id="dso_htfo00040" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="" function="crm.sp_sel_htfo00040" >
			<input bind="grdMST">
                <input bind="txtSlipNo" />
				<input bind="txtSearch" />
			</input> 
			<output bind="grdMST" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_htfo00040_srv" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="" function="crm.sp_sel_htfo00040_srv">
			<input bind="grdSRV">
				<input bind="TABLE_PK" />
				<input bind="COMP_PK" />
				<input bind="lstLocation" />
			</input> 
			<output bind="grdSRV" /> 
		</dso> 
	</xml> 
</gw:data>
<script>function cursor(){}</script>
<gw:data id="dso_htfo00040_checkout" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" parameter="0,1,13,14,15,16,17,18,19,20,31,32,33,34,35" function="crm.sp_sel_htfo00040" procedure="crm.sp_upd_htfo00040">
            <input>
                <input bind="txtSlipNo" />
				<input bind="txtSearch" />
            </input>
            <output bind="grdMST" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_htfo00040_unprint" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" parameter="0,1" function="crm.sp_sel_htfo00040" procedure="crm.sp_upd_htfo00040_unprint">
            <input>
                <input bind="txtSlipNo" />
				<input bind="txtSearch" />
            </input>
            <output bind="grdMST" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_jarc00040_date_to" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="grid" parameter="0,1,4" function="crm.sp_sel_htfo00040" procedure="crm.sp_upd_htfo00040_date_to">
            <input>
				<input bind="txtSlipNo" />
				<input bind="txtSearch" />
            </input>
            <output bind="grdMST" />
        </dso>
    </xml>
</gw:data>
<table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
	<tr style="width: 100%; height: 1%">
		<td style="width: 100%; background: white" valign="top" colspan="2">			
			<table style="width: 100%" border="0">
				<tr>
				    <td> 
						<table style="width: 100%" border="0">
						        <tr>
						            <td style="width: 10%" align="right" nowrap >Room : </td>
						            <td style="width: 15%" ><gw:textbox id="txtSlipNo" styles="width: 100%" onenterkey="OnSearch(1)" /></td>
						            <td style="width: 10%" align="right" nowrap >Name : </td>
						            <td style="width: 10%" ><gw:textbox id="txtSearch" styles="width: 100%" onenterkey="OnSearch(1)" /></td>
						            <td style="width: 10%" align="right" nowrap >Total Rooms : </td>
						            <td style="width: 15%"><gw:label id="lblTotalRoom" /></td>
						            <td style="width: 5%" ><gw:icon id="btnSearch" text="Search" onclick="OnSearch(1)"  styles="width: 100%"/></td>
						            <td style="width: 5%" ><gw:icon id="btnInvoice" text="Print Invoice" onclick="OnPrintInvoice()"  styles="width: 100%"/></td>
						            <td style="width: 5%" ><gw:icon id="btnOther" text="Other Fees" onclick="OnOtherFees()"  styles="width: 100%"/></td>
						            <td style="width: 5%" ><gw:icon id="btnCheckOut" text="Check Out" onclick="OnCheckOut()"  styles="width: 100%"/></td>	
						        </tr>
								<tr>
									<td style="width: 10%" align="right">Customer : </td>
									<td style="width: 15%"><gw:textbox id="txtCustomer" styles="width: 100%" /></td>
									<td style="width: 10%" align="right">Taxcode : </td>
									<td style="width: 10%"><gw:textbox id="txtTaxcode" styles="width: 100%" /></td>
									<td style="width: 10%" align="right">Address : </td>
									<td style="width: 15%"><gw:textbox id="txtAddress" styles="width: 100%" /></td>
									<td style="width: 5%"><gw:icon id="btnCheckPreview" text="Preview" onclick="OnPreview()"  styles="width: 100%" /></td>
									<td style="width: 5%"><gw:icon id="btnUnPrint" text="Set UnPrint" onclick="OnUnPrint()"  styles="width: 100%" /></td>
									<td style="width: 5%"><gw:icon id="btnDiscount" text="Discount" onclick="OnDiscount()"  styles="width: 100%" /></td>
									<td style="width: 5%"><!--gw:icon id="btnDate" text="Update" onclick="OnChangeDate()"  styles="width: 100%" /--></td>	
								</tr>
						</table>
				   </td>
				    
				</tr>
			</table>
		</td>
	</tr>
	<tr style="width: 100%; height: 30%; background: white">
		<td style="width: 100%" colspan="2">
			<gw:grid id="grdMST" 
			header  ="_PK|Select|Room|Arrival|Departure|Rate Plans|Daily Rate|Nights|Room Charge|Guest Name|Gender|Nation|Invoice No|Payment Method|_Cash VND|_Cash USD|_Remain VND|_Remain USD|_Guest Return VND|_Guest Return USD|_Other PL Amt|Description|_tht_room_pk|_Discount|_Diposit|_Minibar|_Laundry|_FNB|_Other|_Total_Fee|_Total_DUE|_COM_PK|_COM_NAME|_COM_TAXCODE|_COM_ADDRESS|_CREDIT_TYPE|Golf Fees" 
			format  ="0|3|0|4|4|0|-0|0|-0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
			aligns  ="0|0|0|0|3|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
			editcol ="0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
			widths  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
			styles  ="width:100%;height:100%"
			autosize='T'
			debug   ='false' onafteredit="OnSearch(2);"/>
		</td>
	</tr>
	<tr style="width: 100%; height: 25%; background: white">
	    <td style="width: 55%;background-color:#33CCFF" valign="top">
	        <table style="height: 100%; width: 100%;border:0px;" cellspacing="1" cellpadding="1">
	            <tr style="height: 2%;" valign="top">
                    <td align="center" style="background-color:White;width:25%;" valign="middle">Ex. RATE : <gw:textbox id="txtExRate" styles="width: 70px;border:none;color:red;font-weight:bold;" readonly="true" /></td>
                    <td align="center" style="background-color:White;width:15%;" valign="middle">Amount(USD)</td>
                    <td align="center" style="background-color:White;width:15%;" valign="middle">Amount(VND)</td>
                    <td align="center" style="background-color:White;width:15%;" valign="middle">SVC(5%)</td>
                    <td align="center" style="background-color:White;width:15%;" valign="middle">VAT(10%)</td>
                </tr>
                <tr style="height: 2%" valign="top">
                    <td style="background-color:Red;padding-left:5px;color:Black" valign="middle">Amount due</td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtAmountDueUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###.##" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtAmountDueVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtAmountDueSVC" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtAmountDueVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###"  /></td>
                </tr>
                <tr style="height: 2%" valign="top">
                    <td style="background-color:Yellow;padding-left:5px;color:Black" valign="middle">Discount</td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtDiscountUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###.##" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtDiscountVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtDiscountSVC" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtDiscountVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###"  /></td>
                </tr>
                <tr style="height: 2%" valign="top">
                    <td style="background-color:White;padding-left:5px;color:Black" valign="middle">Total</td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtTotalUSD" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###.##" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtTotalVND" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtTotalSVC" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###" /></td>
                    <td style="background-color:White" valign="middle"><gw:textbox id="txtTotalVAT" styles="width:100%;border:0px;font-weight:bold;" type="number" format="###,###,###,###,###"  /></td>
                </tr>
                <tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">Room Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtRoomFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtRoomFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtRoomFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtRoomFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
                <tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">Minibar Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtMinibarFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtMinibarFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtMinibarFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtMinibarFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
                <tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">Laundry Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtLaundryFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtLaundryFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtLaundryFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtLaundryFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
                <tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">F&B Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtFNBFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtFNBFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtFNBFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtFNBFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
                <tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">Other Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtOtherFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtOtherFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtOtherFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtOtherFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
		<tr style="height: 2%;" valign="top">
                    <td style="background-color:White;padding-left:5px;" valign="middle">Golf Fee</td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtGolfFeeUSD" styles="width:100%;border:0px;" type="number" format="###,###,###,###.##"  /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtGolfFeeVND" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtGolfFeeSVC" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                    <td align="right" style="background-color:White" valign="middle"><gw:textbox id="txtGolfFeeVAT" styles="width:100%;border:0px;" type="number" format="###,###,###,###,###" /></td>
                </tr>
	        </table>
	    </td>
		<td style="width: 45%" valign="top">
		    <table style="width: 100%;">
		        <tr>
					<td style="width:15%;" align="right">Diposit : </td>
					<td style="width:30%"><gw:textbox id="txtDiposit" styles="width: 100%;border:none;color:red;font-weight:bold;text-align:left;" readonly="true" type="number"  format="###,###,###,###,###" /></td>
					<td style="width:15%;color:red;font-weight:bold" align="left">(VND)</td>
		            <td style="width:35%"><gw:list id="lstLocation" onchange="LisOnChange()" /></td>
		            <td style="width:5%"><gw:icon id="btnSELECT" text="SHOW" onclick="OnSearch(4);" /></td>
		            <td style="width:5%" align="right"><gw:icon id="btnCORRECT" text="CORRECT BILL" onclick="OnSearch(6);" /></td>
		        </tr>
		    </table>
			<gw:grid id="grdSRV" 
			header  ="No|_PK|Room No|Name|Location|Invoice ID|Date|Amount|_POINT|_Total_AMT|_Service_AMT|_VAT_AMT|_Amount_USD|_Discount_AMT" 
			format  ="0|0|0|0|0|0|4|-0|0|0|-0|-0|-2|-0" 
			aligns  ="1|0|1|0|0|0|1|0|0|0|0|0|0|0" 
			defaults="|||||||||||||" 
			editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
 		    widths  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
			styles="width:100%;height:100%"
			autosize='T'
			debug='false'
			oncelldblclick="OnSearch(3);"/>
		</td>
	</tr>	
</table>
</body>

<!--------------------------------------------------------------------------------------->
<gw:textbox id="EMPLOYEE_PK" styles="width: 100%; display:none" />
<gw:textbox id="DATE_TO" styles="width: 100%; display:none" />
<gw:textbox id="TABLE_PK" styles="width: 100%; display:none" />
<gw:textbox id="COMP_PK" styles="width: 100%; display:none" />
</html>
