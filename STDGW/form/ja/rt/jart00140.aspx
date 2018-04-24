<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cash Summary Daily</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'PTYPE' and del_if=0")%>";
    grdVisiterfee_golfer.SetComboFormat(23,data);//payment method
	l_crt_by = "<%=Session("User_ID")%>";
    dat_Visiterfee_golfer.Call("SELECT");
}
function OnSearch()
{
    dat_Visiterfee_golfer.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00050.rpt&procedure=CRM.sp_sel_jart00050_report&parameter="+dtTranTo.GetData();   
     System.OpenTargetPage(url); 
}
function OnDataRec(obj)
{
    switch(obj.id)
	{
		case 'dat_Visiterfee_golfer':
		         txtCount.text=grdVisiterfee_golfer.rows-1 + " item(s).";	
		         grdVisiterfee_golfer.Subtotal( 1, 2, -1, '4!5!6!7!8!9!10!11!12!13!14!15!16!17!18!19!20!21!22');
		break;
    }
}
function GetSumaryAmount(){
   if((grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,0) == "-1") &&(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row, 24) != ""))
   {
        var arrSum = new Array();
        var tmp = new Array();
        txtExRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_buy_ex_rate(2,'USD') from dual")%>";
        var total_VND=0,total_USD=0;
        total_VND=Number(grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,18));
        total_USD=System.Round((total_VND)/Number(txtExRate.text),2);
        tmp = new Array();
        tmp[0]=total_USD;
        tmp[1]=total_VND;
        arrSum[arrSum.length]=tmp;
        return arrSum;
   }
    
}
function GetGuestInfo(){
    for (var i = 2; i < grdVisiterfee_golfer.rows; i++)
	    {
		    if((grdVisiterfee_golfer.GetGridData(i,0) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 24) == check_pk))
		    {
		      var arr = new Array();
		      arr[0]=grdVisiterfee_golfer.GetGridData(i,1);//locker number
		      arr[1]=grdVisiterfee_golfer.GetGridData(i,3);//golfer name
		      
		      arr[2]=grdVisiterfee_golfer.GetGridData(i,30);//Cash USD
		      arr[3]=grdVisiterfee_golfer.GetGridData(i,29);//Cash VND
		      
		      arr[4]=grdVisiterfee_golfer.GetGridData(i,34);//Credit USD
		      arr[5]=grdVisiterfee_golfer.GetGridData(i,33);//Credit VND
		      return arr;
		    }
	    }
}
function CheckDataIsValid(){
    for (i = 2; i < grdVisiterfee_golfer.rows; i++)
	{
		if((grdVisiterfee_golfer.GetGridData(i,0) == "-1"))
		{
		    if(grdVisiterfee_golfer.GetGridData(i,25) == ""){
		        alert("Please input description for customer '"+ grdVisiterfee_golfer.GetGridData(i,3)+"' to check out.");
		        return false;
		    }
		    
		}
	}	
	return true;
}
var check_pk="";
function OnCheckOut()
{
		var arr_pk="", tmp="";
        
        for (var i = 2; i <= grdVisiterfee_golfer.rows-1; i++)
	    {
		    if((grdVisiterfee_golfer.GetGridData(i,0) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 24) != ""))
		    {
    		    		    
		        if(grdVisiterfee_golfer.GetGridData(i,6) == "")
			    {
					    if(! confirm("This golfer does not have caddy fee. Do you want to check out?")){
						    return;
					    }
			    }
			    arr_pk += tmp +grdVisiterfee_golfer.GetGridData(i, 24);
			    tmp = '*';
		    }
	    }
	    //alert(grdVisiterfee_golfer.rows-1);
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
		if(CheckDataIsValid())
		{
		    var path = System.RootURL + '/form/ja/rt/jart00140_popup.aspx?pk='+arr_pk;
            var object = System.OpenModal( path , 750 , 600 ,  'resizable:yes;status:yes',window);
            if(object)
            {
                if(object.length == 8)
                {
                    for (var i = 2; i < grdVisiterfee_golfer.rows; i++)
	                {
		                if((grdVisiterfee_golfer.GetGridData(i,0) == "-1") &&(grdVisiterfee_golfer.GetGridData(i, 24) != ""))
		                {
		                   grdVisiterfee_golfer.SetGridText(i,27,object[0]);//receipt vnd  
		                   grdVisiterfee_golfer.SetGridText(i,28,object[1]);//receipt usd
		                   grdVisiterfee_golfer.SetGridText(i,29,object[2]);//payment vnd
		                   grdVisiterfee_golfer.SetGridText(i,30,object[3]);//payment usd
		                   grdVisiterfee_golfer.SetGridText(i,31,object[4]);//other profit and lost amt
		                   grdVisiterfee_golfer.SetGridText(i,32,object[5]);//payment method
		                   grdVisiterfee_golfer.SetGridText(i,33,object[6]);//return vnd 
		                   grdVisiterfee_golfer.SetGridText(i,34,object[7]);//return usd
		                   break;//exit for loop
                        }
                    }   
                  dat_Visiterfee_golfer.Call(); 
                }
	       } 
		 
       }
}
function OnPrintBill(){
   if(grdVisiterfee_golfer.rows > 1){
        var pk=grdVisiterfee_golfer.GetGridData(grdVisiterfee_golfer.row,24);
        var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart0050_invoice.rpt&procedure=CRM.sp_rpt_jart00050_invoice&parameter="+
	        pk+","+l_crt_by;   
	    System.OpenTargetPage(url); 
	}		 
	else{
	    alert("Please select one invoice to print.");
	    return;
	}   
}
</script>

<body>
    <gw:data id="dat_Visiterfee_golfer" onreceive="OnDataRec(this)"> 
    <xml> 
        <dso  type="grid" parameter="0,24,25,27,28,29,30,31,32,33,34"  function="crm.sp_sel_jart00140" procedure="crm.sp_upd_jart00140" > 
            <input bind="grdVisiterfee_golfer">                    
                <input bind="dtfrom" /> 
                <input bind="dtto" />
            </input> 
            <output bind="grdVisiterfee_golfer"></output>
        </dso> 
    </xml> 
</gw:data>
    <!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td align="right" width="5%">
                                                        Date</td>
                                                    <td width="7%">
                                                        <gw:datebox id="dtfrom" lang="1" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="1%">
                                                        ~</td>
                                                    <td width="7%">
                                                        <gw:datebox id="dtto" lang="1" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="2%">
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch" img="search" width="100%" img="in" text="search" onclick="OnSearch()" />
                                                    </td>
													<td style="width: 5%">
														 <gw:icon id="idBtnPrintBill" img="2" text="Print Bill" styles='width:100%' onclick="OnPrintBill()" />
													</td>
                                                    <td style="width: 3%">
                                                    </td>
                                                    <td style="width: 3%; white-space: nowrap">
                                                        <gw:icon id="ibtnCheckOut" text="Check Out" img="in" styles="width:100%" onclick="OnCheckOut()" />
                                                    </td>
                                                    <td width="5%">
                                                    </td>
                                                    <td align="right" style="width: 15%">
                                                        <b>Total Record</b></td>
                                                    <td style="width: 10%" align="center">
                                                        <gw:label id="txtCount" />
                                                    </td>
                                                    <td width="34%">
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            <gw:grid id="grdVisiterfee_golfer" header="Chk|Locker#|_Invoice#|Golfer Name|Green Fee|Cart Fee|Caddies Fee|Sub Total|SCTax|VAT|Total|Proshop|FnB|Tee House|Rental Fee|Other Fee|ORG Pay|Discount|Total Payment|Cash VND|Cash USD|Credit VND|Credit USD|_Payment_Method|_tgm_visitorfee_golfer_pk|Description|_Create Date|_receipt_vnd|_receipt_usd|_payment_vnd|_payment_usd|_other_profit_lost_amt|_payment_method|_return_vnd|_return_usd|Checkin Date"
                                format="3|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0" styles="width:100%; height:100%"
                                sorting="T" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
    <gw:textbox id="txtExRate" style="display: none" />
</body>
</html>
