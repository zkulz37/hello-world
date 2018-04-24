<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Daily Send To Acount</title>
    <%  ESysLib.SetUser("crm")%>
<script>
function BodyInit(){	
	OnSearch();
}
function OnSearch(){
	dsoGrdData.Call('SELECT');
}
function OnDataReceive(obj)
{
    switch(obj.id){
        case "dsoGrdData":
            lblRecord.text = grdData.rows - 1 + " record(s)";
			lblVoucherNo.text = "";
			if(grdData.rows > 1){
				lblVoucherNo.text = grdData.GetGridData(2,14);
			}
            grdData.Subtotal( 1, 2, -1, '7!10');
			RecalculateSummary();
        break;
        case "dso_process":
			alert(txtReturn.text);
			OnSearch();
		break;	
        case "dso_process_send":
			alert(txtReturn.text);
			OnSearch();
		break;
        case "dso_process_cancel":
            var return_value1 = "";
	        return_value1=txtReturn.text;
	        if(return_value1 != ""){
	            alert(return_value1);
	            txtReturn.text = "";
	        }
	        dsoGrdData.Call('SELECT');
        break;
    }
}
function RecalculateSummary(){
	for(var i=2;i<grdData.rows;i++){
		if(grdData.GetGridData(i,9) == "USD"){
		    var adj_amt = -1*Number(grdData.GetGridData(i,10));
			
			var total = Number(System.RemoveComma(grdData.GetGridData(1,10)));
			//alert(total)
			grdData.SetGridText(1,10,total+adj_amt);
		}
	}
}
function OnProcess()
{   
    if (confirm("Are you sure,you want to process data "+dtDate.text+" ?"))
    {
        dso_process.Call();
    }   
}
function OnSend(){
	if(lblVoucherNo.text != ""){
		alert("This data was sent to accounting. So you can not send more.");
		return;
    }
    if (confirm("Are you sure,you send to accounting data "+dtDate.text+" ?"))
    {
        dso_process_send.Call();
    } 
}
function OnCancel(){
    if (confirm("Are you sure, cancel data "+dtDate.text+" ?"))
    {
        dso_process_cancel.Call();
    } 
}
</script>
</head>
<body style="background: white">
<gw:data id="dsoGrdData" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid"  parameter="" function="crm.sp_sel_jarc00080" procedure="">  
			<input bind="grdData" >  
				<input bind="dtDate" />
				<input bind="txtInvoice" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_process" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="crm.sp_pro_tgm_golfer_invoice" > 
            <input>
                <input bind="dtDate" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_process_send" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="crm.sp_pro_send_golf_slip" > 
            <input>
                <input bind="dtDate" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_process_cancel" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="crm.sp_pro_cancel_golf_slip" > 
            <input>
                <input bind="dtDate" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
    <table width="100%" style="height: 100%" border="0">
        <tr style="width: 100%; height: 0%">
            <td style="background: white">
                <table style="width: 100%; height: 100%" border="0">
                    <tr>
                         <td style="width: 5%" align="center">Date</td>
                        <td style="width: 7%"><gw:datebox id="dtDate" lang="1" styles='width:70%' onchange="OnSearch();"/></td>
                        <td style="width: 7%;white-space:nowrap" align="center">Invoice #</td>
                        <td style="width:20%"><gw:textbox id="txtInvoice" onenterkey="OnSearch()" /></td>
                        <td style="width: 3%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:icon id="btnProcess" img="2" text="Process" styles='width:100%' onclick="OnProcess();" />
                        </td>
                        <td style="width: 3%">
                            <gw:icon id="btnSend" img="2" text="Send To Accounting" styles='width:100%' onclick="OnSend();" />
                        </td>
                        <td style="width: 3%">
                            <gw:icon id="btnCancel" img="2" text="Cancel Send Data" styles='width:100%' onclick="OnCancel();" />
                        </td>
						<td style="width: 6%">Total:
						</td>
                        <td style="width:10%">
                            <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
                        </td>
						<td style="width:5%">Voucher#:
						</td>
                        <td style="width:10%">
                            <gw:label id="lblVoucherNo" styles="color: blue; width: 100%"></gw:label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 48%">
            <td colspan="10">
                <gw:grid id="grdData" 
                    header  ="_PK|Invoice No|Invoice Date|Golfer Name|Debit|Credit|Credit Advance|Trans AMT|Ex Rate|CCY|Book Amount|Cost Center|Description|Description (Local)|_VoucherNo"
                    format  ="0|0|0|0|0|0|0|-0|-0|0|-0|0|0|0|0" 
                    autosize="T" sorting='T' styles="width:100%; height:100%"/>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtReturn" styles="width:100%; display:none" />
    <gw:textbox id="txtReturn1" styles="width:100%; display:none" />
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
</body>
</html>
