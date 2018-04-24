<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>CLAIM 청구입금</title>
</head>
<script type="text/javascript" language="javascript">

var flag;
var G_Pay_Claim_pk = 0;
var rtnLGCode = '' ;
 
var G_PK            = 0,
    G_SLIP_DATE     = 1,
    G_SLIP_NO       = 2,
    G_CHARGER_PK    = 3,
    G_BL_NO         = 4,
    G_LC_NO         = 5,
    G_PRICE_TERM    = 6,
    G_VOLUME        = 7,
    G_SHIPPER       = 8,
    G_QTY           = 9,
    G_VAT           = 10,
    G_VAT_AMT       = 11,
    G_TOTAL_AMT     = 12,
    G_DESCRIPTION   = 13;

//------------------------------------------------------------
function OnChangeTab()
 {
    var strRad = radTab.GetData();
    
    var tab_Clear      = document.all("Import");    
    var tab_Invoice    = document.all("Invoice");    
	
	switch (strRad)
	{
		case '1':
		    tab_Clear.style.display      	= "";
		    tab_Invoice.style.display      	= "none";		 
		    
		    document.all("Import").style.color      	= "cc0000"; 
		    document.all("Invoice").style.color      	= "";
        break;
        case '2':
		    tab_Clear.style.display      	= "none";
		    tab_Invoice.style.display      	= "";		 
		    
		    document.all("Import").style.color      	= ""; 
		    document.all("Invoice").style.color      	= "cc0000";
        break;
     }
 }

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";   
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";
    
    var date = dtFromSearch.value;
    date = date.substr(0,4) + date.substr(4,2) + "01";
    dtFromSearch.value = date;

    txtSlipNo.SetEnable(false);
    txtBLNo.SetEnable(false);
    txtLCNo.SetEnable(false);
    
    txtCharger.SetEnable(false);
    txtVatAmt.SetEnable(false);
    txtTotalAmt.SetEnable(false);
    txtNetAmt1.SetEnable(false);
    txtNetAmt2.SetEnable(false);
    txtTotal1.SetEnable(false);
    txtTotal2.SetEnable(false);
    txtVAT1.SetEnable(false);
    txtVAT2.SetEnable(false);
    txtSubTolAmt1.SetEnable(false);
    txtSubTolAmt2.SetEnable(false);
    
    OnChangeTab();
    BindingDataList();
    OnAddNew();
    OnSearch('grdDetail');
}

 //==================================================================================
function OnAddNew()
{
            data_kblc00230_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtCharger.text = "<%=Session("USER_NAME")%>";
            txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
}         
 //-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdDetail':
            data_kblc00230.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdDetail.GetGridData(grdDetail.row,G_PK);
            data_kblc00230_1.Call("SELECT");
        break;      
    }
}

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    right.style.display="";
    imgArrow.status = "collapse";
    left.style.width="25%";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    right.style.display="none";
    imgArrow.status = "expand";
    left.style.width="100%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
 function BindingDataList()
 {              
	var data= ""; 
	    
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    lstCompany.SetDataText(data);	 
    lstCompany.value= txtCompany_PK.text;	

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>";    
    lstPriceTerm.SetDataText(data); 
        	    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstShipper.SetDataText( data);
    lstShipper.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCY1.SetDataText(data); 
    lstCCY1.value = 'USD' ;
    
    lstCCY2.SetDataText(data); 
    lstCCY2.value = 'VND' ;
    		 
 }

function OnShowPopup(obj)
 {
    switch(obj)
        {
	      case 'LC':
                 var path = System.RootURL + "/form/kb/lc/kblc00221.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes',this);
          	                   
                 if ( object != null )
                 {	         
                    txtLCNo.text            =    object[0];
                    txtCustomerPK.text      =    object[3];
                    txtCustomerNM.text      =    object[4];
                    txtSubCustomerPK.text   =    object[3];
                    txtSubCustomerNM.text   =    object[4];
                 }          
	       break;           
	       
	       case 'Invoice':
                 var path = System.RootURL + "/form/kb/in/kbin00051.aspx";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                    txtLCNo.text = object[1];                
                    txtBLNo.text = object[2];                
	             }	       
	       break;
            case 'CUSTOMER' :
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtCustomerPK.text   = object[0];
                    txtCustomerNM.text = object[2];
                    
                    txtSubCustomerPK.text   = object[0];
                    txtSubCustomerNM.text = object[2];
                    txtTaxCode.text =  object[6];
                    txtCustomerID.text = object[1];
	             }
	         break; 
	          case 'SUBCUSTOMER' :
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
                    txtSubCustomerPK.text   = object[0];
                    txtSubCustomerNM.text = object[2];
	             }
	         break; 
       }
 } 

function OnCheckStatus()
{
    btnACopy.SetEnable(false) ;
    if (lblStatus.text == 'SAVED'||lblStatus.text == 'CANCEL')
    {
       btnAutoSlip.SetEnable(false) ;
       btnApprove.SetEnable(true) ;
       btnACancel.SetEnable(false) ;
    }
    else
    { 
       btnApprove.SetEnable(false) ;
       if(txtAccSlipNo.text =="")
       {
        btnACancel.SetEnable(true) ;
        btnAutoSlip.SetEnable(true) ;
       }else
       {
         btnACancel.SetEnable(false) ;
         btnAutoSlip.SetEnable(false) ;
         btnACopy.SetEnable(true) ;
       }
    }
} 
 //==================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0030')
             {
                lstShipComp.SetDataText(txtLGCodeList.text);
                lstShipComp.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0040')
             {
                lstStoredFact.SetDataText(txtLGCodeList.text);  
                lstStoredFact.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'IEBS0020')
             {
                lstShipPort.SetDataText(txtLGCodeList.text);  
                lstShipPort.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'IEBS0021')
             {
                lstArrivalPort.SetDataText(txtLGCodeList.text);  
                lstArrivalPort.value = rtnLGCode;                      
             }
      break;    
      case 'data_kblc00230_1':
            OnCheckStatus();
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00230_1.Call('SELECT');
            }
      break;  
      case 'data_kblc00230':
            lblRecord.text  = ( grdDetail.rows -1 )+ " record(s)."
            btnAutoSlip.SetEnable(false) ;
            btnApprove.SetEnable(false) ;
            btnACancel.SetEnable(false) ;
            btnACopy.SetEnable(false) ;
            pro_kblc00230_3.Call();
      break;
        
       case 'pro_kblc00230': //approve
        alert(txtReturnValue.text);
        data_kblc00230_1.Call('SELECT')
      break;
      
      case 'pro_kblc00230_1'://cancel
        alert(txtReturnValue.text);
        data_kblc00230_1.Call('SELECT')
      break;
      
      case 'pro_kblc00230_2'://acc 
        data_kblc00230_1.Call('SELECT')
      break;

      case 'pro_kblc00230_3'://get currency
        Total();
      break;

      case 'pro_kblc00230_4':
        alert(txtReturnValue.text);
        data_kblc00230.Call('SELECT')
      break;
    }
}
 
function OnSave()
{ 
    flag='save';
    if(data_kblc00230_1.GetStatus() == 20)  
    { 
        data_kblc00230_1.Call();  
    }
    else
    {    
        data_kblc00230_1.Call();                
    }

}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00230_1.StatusDelete();
       OnSave();
    }
 }
//====================================================================================       
function NetAmt_01()
{
    var exw_charge = 0, local_charge = 0, cleance = 0, trucking = 0, handling = 0;
    var total = Number(txtOFEXWCharge.text) + Number(txtLocalCharge.text) + Number(txtCustClce.text) + Number(txtTrucking.text) + Number(txtHandling.text) ;
    
    txtNetAmt1.text = total;
    Total();
}

function NetAmt_02()
{
    var duty_tax = 0, port_charge = 0, storage = 0, fee = 0, repairing = 0;
    var total = Number(txtPortCharge.text) + Number(txtDemDetStor.text) + Number(txtInspectFee.text) + Number(txtRepairing.text) ;
    
    txtNetAmt2.text = total;
    Total();
}
       
function Total()
{
    try
    {
        txtVatRate_INV.text = txtVAT.text;
        var net_amt = 0;
        net_amt = Number(txtNetAmt1.text) * Number(txtTaxRate.text);
        txtTotal1.text = System.Round( net_amt,2);

        txtVAT1.text = Number(txtTotal1.text) * (Number(txtVAT.text)/100);
        txtSubTolAmt1.text = Number(txtTotal1.text) + Number(txtVAT1.text);
    
        net_amt = Number(txtNetAmt2.text) * 1;
        txtTotal2.text = net_amt;
        txtExNetAMT_INV.text =Number(txtTotal1.text) + Number(txtTotal2.text);

        txtVAT2.text = Number(txtTotal2.text) * (Number(txtVAT.text)/100);
        txtSubTolAmt2.text = Number(txtTotal2.text) + Number(txtVAT2.text);
    
        txtVatAmt.text = Number(txtVAT1.text) + Number(txtVAT2.text);
        txtVatAMT_INV.text = txtVatAmt.text;
        txtTotalAmt.text = Number(txtSubTolAmt1.text) + Number(txtSubTolAmt2.text);
        txtTotalAMT_INV.text = txtTotalAmt.text;
    }
    catch(err)
    {
        alert(err.message);
    }
}      

function OnProcess(obj)
{
   switch(obj)
     {   
        case "APPROVE" :
            if(txtMasterPK.text !="")
            {
                pro_kblc00230.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
         break;
        case "CANCEL" :
             if(txtMasterPK.text !="")
            {
                pro_kblc00230_1.Call();
            }else
            {
                alert("Please, select a slip to Cancel!");
            }
       
       break;

      case "SLIP":
        if(txtMasterPK.text !="")
        {
            pro_kblc00230_2.Call();
        }else
        {
            alert("Please, select an bank charge slip to make slip!");
        }
     break;

      case "COPY":
        if(txtMasterPK.text !="")
        {
            pro_kblc00230_4.Call();
        }else
        {
            alert("Please, select an insurance slip to copy slip!");
        }
      break;     
    }
} 
</script>
<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00230" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00230"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>
					<input	bind="txtSearchNo"	/>					
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!-----------------------------MASTER------------------------------------>
    <gw:data id="data_kblc00230_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53"	function="<%=l_user%>lg_sel_kblc00230_1"	procedure="<%=l_user%>lg_upd_kblc00230_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="dtSlipDate"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtChargerPK"	/>
						<inout	bind="txtCharger"	/>
						<inout	bind="txtBLNo"	/>
						<inout	bind="txtLCNo"	/>
                        <inout	bind="txtLCNo_Seq"	/>
						<inout	bind="lstPriceTerm"	/>
						<inout	bind="txtVolume"	/>
						
						<inout	bind="lstShipper"	/>
						<inout	bind="txtQty"	/>
						<inout	bind="txtVAT"	/>
						<inout	bind="txtVatAmt"	/>
						<inout	bind="txtTotalAmt"	/>						
						<inout	bind="txtRemark"	/>
						
						<inout	bind="lstCCY1"	/>
						<inout	bind="txtTaxRate"	/>
						<inout	bind="lstCCY2"	/>
						<inout	bind="txtOFEXWCharge"	/>					
                       	<inout	bind="txtDutyTax"	/>
                       	<inout	bind="txtLocalCharge"	/>	
						<inout	bind="txtPortCharge"	/>						
						<inout	bind="txtCustClce"	/>
						<inout	bind="txtDemDetStor"	/>
						<inout	bind="txtTrucking"	/>
						<inout	bind="txtInspectFee"	/>
						<inout	bind="txtHandling"	/>
						<inout	bind="txtRepairing"	/>
						
						<inout	bind="txtNetAmt1"	/>              
						<inout	bind="txtNetAmt2"	/>	
						
						<inout	bind="txtTotal1"	/>	
						<inout	bind="txtTotal2"	/>	
						
						<inout	bind="txtVAT1"	/>		
						<inout	bind="txtVAT2"	/>
						
						<inout	bind="txtSubTolAmt1"	/>	
						<inout	bind="txtSubTolAmt2"	/>
                        <inout	bind="lblStatus"	/>
                        <inout	bind="txtAccSlipNo"	/>
						<inout	bind="txtCustomerPK"	/>
						<inout	bind="txtCustomerNM"	/>
						<inout	bind="txtCustomerID"	/>
						<inout	bind="txtTaxCode"	/>					
                       	<inout	bind="txtInvoiceNo"	/>
                       	<inout	bind="txtSerialNo"	/>	
						<inout	bind="dtInvoiceDT"	/>						
						<inout	bind="txtProdName"	/>
						<inout	bind="txtExNetAMT_INV"	/>
						<inout	bind="txtVatRate_INV"	/>
						<inout	bind="txtVatAMT_INV"	/>
						<inout	bind="txtTotalAMT_INV"	/>
						<inout	bind="txtSubCustomerPK"	/>																						
                        <inout	bind="txtSubCustomerNM"	/>	
                        <inout	bind="txtRemark_INV"	/>																					
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00230" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00230" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien cancel ------------------------------->
    <gw:data id="pro_kblc00230_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00230_1" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien auto slip ------------------------------->
    <gw:data id="pro_kblc00230_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00230_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtAccSlipNo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien auto get currency ------------------------------->
    <gw:data id="pro_kblc00230_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>sp_get_rate" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstCCY1" />
                    <input bind="dtSlipDate" />
                </input> 
                <output>
                    <output bind="txtTaxRate" />
                    <output bind="txtNull" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien Copy ------------------------------->
    <gw:data id="pro_kblc00230_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>LG_PRO_KBLC00230_3" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <td id="left" style="width: 25%">
            <table style="width: 100%; height: 100%">
                <tr style="height: 1%">
                    <td align="right" style="width: 5%;">
                        Date
                    </td>
                    <td style="white-space: nowrap; width: 10%">
                        <gw:datebox id="dtFromSearch" lang="1" />
                        ~
                        <gw:datebox id="dtToSearch" lang="1" />
                    </td>
                    <td style="width: 84%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdDetail')" />
                    </td>
                    <td style="width: 1%">
                        <img status="collapse" id="imgArrow" src="../../../system/images/button/next.gif"
                            style="cursor: hand" onclick="OnToggle()" />
                    </td>
                </tr>
                <tr style="height: 1%">
                    <td align="right" style="width: 10%; white-space: nowrap">
                        Slip No
                    </td>
                    <td style="width: 15%">
                        <gw:textbox id="txtSearchNo" styles="width:100%;" onenterkey="OnSearch('grdDetail')" />
                    </td>
                    <td style="width: 15%; white-space: nowrap" align="right">
                        <gw:label id="lblRecord" text="" styles="color:red" />
                    </td>
                </tr>
                <tr style="height: 97%">
                    <td style="width: 100%" colspan="4">
                        <gw:grid id='grdDetail' header='_pk|Date|Slip No|Charger|BL No|LC No|Price Term|Volume|Shipper|Qty|VAT|Vat Amt|Total Amt|Description'
                            format='0|4|0|0|0|0|0|1|0|1|1|1|1|0' aligns='1|0|0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||||||||'
                            editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='0|1200|1000|0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                    </td>
                </tr>
            </table>
        </td>
        <td id="right" style="width: 75%">
            <table style="width: 100%; height: 100%">
                <tr style="width: 100%; height: 1%" id="Claim">
                    <td>
                        <table style="width: 100%; height: 100%">
                            <tr>
                                <td align="right" style="width: 100%;" colspan="7">
                                    <table style="width: 100%; height: 100%">
                                        <tr>
                                            <td align="right" style="width: 26%; white-space: nowrap">
                                            </td>
                                            <td align="right" style="width: 5%; white-space: nowrap">
                                                <gw:icon id="btnApprove" img="2" text="Approve" styles='width:100%' onclick="OnProcess('APPROVE')" />
                                            </td>
                                            <td style="width: 5%" align="center">
                                                <gw:icon id="btnACancel" img="2" text="Cancel" styles='width:100%' onclick="OnProcess('CANCEL')" />
                                            </td>
                                            <td style="width: 5%" align="right">
                                                <gw:icon id="btnAutoSlip" img="2" text="AutoSlip" styles='width:100%' onclick="OnProcess('SLIP')" />
                                            </td>
                                            <td style="width: 5%" align="right">
                                                <gw:icon id="btnACopy" img="2" text="Copy" onclick="OnProcess('COPY')" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap">
                                                ACC Slip No
                                            </td>
                                            <td style="width: 25%">
                                                <gw:textbox id="txtAccSlipNo" csstype="mandatory" styles="width:100%;" />
                                            </td>
                                            <td style="width: 20%; white-space: nowrap" align="center">
                                                <gw:label id="lblStatus" text="" styles="color:red" />
                                            </td>
                                            <td style="width: 1%">
                                                <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                                            </td>
                                            <td style="width: 1%">
                                                <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                                            </td>
                                            <td style="width: 1%">
                                                <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                                            </td>
                                            <td style="width: 1%">
                                                <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 1%">
                                <td style="background-color: #B4E7FF">
                                    <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                        <span value="1" id="Ex-Import">Export</span> 
                                        <span value="2" id="Ex-Invoice">Invoice Info</span>                        
                                    </gw:radio>
                                </td>
                            </tr>
                            <tr id="Import" style="height: 5%">
                                <td style="width: 100%" colspan="7">
                                    <table style="width: 100%; height: 100%">
                                        <tr style="height: 1%">
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Slip No
                                            </td>
                                            <td style="width: 10%" colspan="">
                                                <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory" />
                                            </td>
                                            <td style="width: 1%; white-space: nowrap" align="right">
                                                Date
                                            </td>
                                            <td style="width: 5%">
                                                <gw:datebox id="dtSlipDate" lang="1" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                <a onclick="OnPopup('charger')" href="#tips" style="color: #0000ff">Charger</a>
                                            </td>
                                            <td style="width: 10%" colspan="4">
                                                <gw:textbox id="txtChargerPK" styles="width:100%;display:none" />
                                                <gw:textbox id="txtCharger" styles="width:100%;display" />
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 1%; white-space: nowrap" align="right">
                                                <a title="Invoice No" onclick="OnShowPopup('Invoice')" href="#tips" style="color: #0000ff">
                                                    <b>B/L No</b></a>
                                            </td>
                                            <td style="width: 10%" colspan="3">
                                                <gw:textbox id="txtBLNo" styles="width:100%;" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Price Term
                                            </td>
                                            <td style="width: 10%">
                                                <gw:list id="lstPriceTerm" lang="1" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Volume
                                            </td>
                                            <td style="width: 10%">
                                                <gw:textbox id="txtVolume" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 1%; white-space: nowrap" align="right">
                                                <a onclick="OnShowPopup('LC')" href="#tips" style="color: #0000ff">L/C No</a>
                                            </td>
                                            <td style="width: 10%" colspan="3">
                                                <gw:textbox id="txtLCNo" styles="width:80%;" csstype="mandatory" readonly="true" />
                                                <gw:textbox id="txtLCNo_Seq" styles="width:20%;" csstype="mandatory" type="number"
                                                    format="###,###,###" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Shipper
                                            </td>
                                            <td style="width: 10%">
                                                <gw:list id="lstShipper" styles="width:100%;" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Qty
                                            </td>
                                            <td style="width: 10%">
                                                <gw:textbox id="txtQty" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 1%; white-space: nowrap" align="right">
                                                VAT
                                            </td>
                                            <td style="width: 10%">
                                                <gw:textbox id="txtVAT" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="Total()" />
                                            </td>
                                            <td style="width: 1%; white-space: nowrap" align="right">
                                                VAT Amount
                                            </td>
                                            <td>
                                                <gw:textbox id="txtVatAmt" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                                Total Amount
                                            </td>
                                            <td style="width: 20%;" colspan="3">
                                                <gw:textbox id="txtTotalAmt" styles="width:100%" type="number" format="###,###,###.00#" />
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Remark
                                            </td>
                                            <td style="width: 25%" colspan="9">
                                                <gw:textbox id="txtRemark" styles="width:100%;" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="Invoice" style="height: 5%">
                                <td>
                                    <table style="width: 100%; height: 100%">
                                        <tr style="height: 5%">
                                            <td align="right" style="width: 10%;">
                                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('CUSTOMER')">Customer</b>
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtCustomerPK" styles="width:100%;display:none" />
                                                <gw:textbox id="txtCustomerNM" styles="width:100%;" csstype="mandatory" readonly="T" />
                                            </td>
                                            <td align="right" style="width: 10%; white-space: nowrap">
                                                Customer ID
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtCustomerID" csstype="mandatory" styles="width:100%;" readonly="T" />
                                            </td>
                                            <td align="right" style="width: 10%;">
                                                Tax Code
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtTaxCode" styles="width:100%;" csstype="mandatory" readonly="T" />
                                            </td>
                                        </tr>
                                        <tr style="height: 5%">
                                            <td align="right" style="width: 1%;">
                                                Invoice No
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtInvoiceNo" styles="width:100%;" />
                                            </td>
                                            <td align="right" style="width: 1%;">
                                                Serial No
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtSerialNo" styles="width:100%;" />
                                            </td>
                                            <td align="right" style="width: 1%; white-space: nowrap">
                                                Invoice Date
                                            </td>
                                            <td style="width: 1%">
                                                <gw:datebox id="dtInvoiceDT" lang="1" />
                                            </td>
                                        </tr>
                                        <tr style="height: 5%">
                                            <td align="right" style="width: 1%;">
                                                Prod Item
                                            </td>
                                            <td style="width: 1%" colspan="3">
                                                <gw:textbox id="txtProdName" styles="width:100%; " />
                                            </td>
                                            <td align="right" style="width: 1%;">
                                                Ex Net Amt
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtExNetAMT_INV" styles="width:100%;" readonly="true" type="number"
                                                    format="###,###.#R" />
                                            </td>
                                        </tr>
                                        <tr style="height: 5%">
                                            <td align="right" style="width: 1%;">
                                                Vat Rate
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtVatRate_INV" styles="width:100%;" readonly="true" type="number"
                                                    format="###,###.##" />
                                            </td>
                                            <td align="right" style="width: 1%;">
                                                Vat Amt
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtVatAMT_INV" styles="width:100%;" readonly="true" type="number"
                                                    format="###,###.##" />
                                            </td>
                                            <td align="right" style="width: 1%;">
                                                Total Amt
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtTotalAMT_INV" styles="width:100%;" readonly="true" type="number"
                                                    format="###,###.#R" />
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td align="right" style="width: 10%; white-space: nowrap">
                                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('SUBCUSTOMER')">Customer
                                                    Name</b>
                                            </td>
                                            <td style="width: 1%">
                                                <gw:textbox id="txtSubCustomerPK" styles="width:100%;display:none" />
                                                <gw:textbox id="txtSubCustomerNM" styles="width:100%;" csstype="mandatory" readonly="T" />
                                            </td>
                                            <td align="right" style="width: 1%;">
                                                Remark
                                            </td>
                                            <td style="width: 1%" colspan="4">
                                                <gw:textbox id="txtRemark_INV" styles="width:100%;" csstype="mandatory" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr style="height: 20%">
                                <td style="width: 100%" colspan="7">
                                    <table style="width: 100%; height: 100%">
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                CCY
                                            </td>
                                            <td style="width: 10%">
                                                <gw:list id="lstCCY1" styles="width:100%;" onchange="pro_kblc00230_3.Call()" />
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtTaxRate" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="Total()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                CCY
                                            </td>
                                            <td style="width: 20%">
                                                <gw:list id="lstCCY2" styles="width:100%;" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                O/F & EXW Charge
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtOFEXWCharge" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_01()" onenterkey="NetAmt_01()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Duty & Tax
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtDutyTax" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_02()" onenterkey="NetAmt_02()" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Local Charges
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtLocalCharge" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_01()" onenterkey="NetAmt_01()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Port Charge
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtPortCharge" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_02()" onenterkey="NetAmt_02()" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Customs Clerance
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtCustClce" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_01()" onenterkey="NetAmt_01()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Dem/Det/Storage
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtDemDetStor" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_02()" onenterkey="NetAmt_02()" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Trucking
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtTrucking" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_01()" onenterkey="NetAmt_01()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Inspection Fee
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtInspectFee" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_02()" onenterkey="NetAmt_02()" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Handling
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtHandling" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_01()" onenterkey="NetAmt_01()" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Repairing
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtRepairing" styles="width:100%;" type="number" format="###,###,###.00#"
                                                    onchange="NetAmt_02()" onenterkey="NetAmt_02()" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Net Amount
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtNetAmt1" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Net Amount
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtNetAmt2" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Exchange Net Amount
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtTotal1" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Exchange Net Amount
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtTotal2" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                VAT
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtVAT1" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                VAT
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtVAT2" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                        <tr style="height: 1%">
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Sub Total Amount VND
                                            </td>
                                            <td style="width: 20%" colspan="2">
                                                <gw:textbox id="txtSubTolAmt1" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 10%; white-space: nowrap" align="right">
                                                Sub Total Amount VND
                                            </td>
                                            <td style="width: 20%">
                                                <gw:textbox id="txtSubTolAmt2" styles="width:100%;" type="number" format="###,###,###.00#" />
                                            </td>
                                            <td style="width: 5%; white-space: nowrap" align="right">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="width: 100%; height: 5%">
                    <td>
                        <table style="width: 100%; height: 100%">
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </table>
</body>
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtNull" text="" style="display: none" />
<gw:list id="lstCompany" styles="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
</html>
