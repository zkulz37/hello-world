<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>INSURANCE</title>
</head>
<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_Insurance_pk = 0;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";
     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
    txtACCSlipNo.SetEnable(false)
   //---------------------------- 
    OnChangeTab();
    BindingDataList();  
    data_kblc00020_1.StatusInsert();
    txtSlipNo.text   = '***New Voucher***';
    txtPremiumRate.text = '110';
    txtVatRate.text = '10'
    txInsRate.text = '0.12' 
    data_kblc00020.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	 var data1= "";    
	      	
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0020' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCondition.SetDataText(data1); 
    lstCondition.value = '' ; 
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy.SetDataText(data1); 
    lstCCy.value = 'USD' ;        
 } 
 //====================================================================================
function OnChangeTab()
 {
    var strRad = radTab.GetData();
    
    var tab_Clear      = document.all("Insurance");    
    var tab_Invoice    = document.all("Invoice");    
	
	switch (strRad)
	{
		case '1':
		    tab_Clear.style.display      	= "";
		    tab_Invoice.style.display      	= "none";		 
		    
		    document.all("Insurance").style.color      	= "cc0000"; 
		    document.all("Invoice").style.color      	= "";
        break;
        case '2':
		    tab_Clear.style.display      	= "none";
		    tab_Invoice.style.display      	= "";		 
		    
		    document.all("Insurance").style.color      	= ""; 
		    document.all("Invoice").style.color      	= "cc0000";
        break;
     }
 }
//====================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'COMPANY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0010";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                alert(object[0])	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0010';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstCompany.value = object[1];      
	                }    	                
	             }                              
            break;    
            case 'CONDITION':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0020";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0020';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstCondition.value = object[1];      
	                }    	                
	             }                              
            break;  
             case 'SHIPMENT':
                 var path = System.RootURL + "/form/kb/lc/kblc00021.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');       	                   
                 if ( object != null )
                 {	         
                    txtShipPK.text   = object[0];
                    txtShipNo.text   = object[1];
                    txtBLNo.text = object[2];
                    txtComInvNo.text = object[3];               
                    txtLCNo.text = object[4];
                    txtInvValue.text = object[13]; 
                    txtNumOfRod.text = object[21];
                    
                    OnCalInsured();
                    OnCalPremium(); 
                    OnCalVat();                                       
                 }          
	       break;
	       case 'PARTNER' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPK.text   = object[0];
                txtPartnerName.text = object[2];
               
                txtCustomerPK.text   = object[0];
                txtCustomerNM.text = object[2];
                txtTaxCode.text =  object[6];
                txtCustomerID.text = object[1];
                
                txtBillToNM.text = object[2];
	         }
	         break;    
	        case 'INVOICE':
                 var path = System.RootURL + "/form/kb/in/kbin00051.aspx";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                    txtLCNo.text = object[1];                
                    txtBLNo.text = object[2];        
                    txtComInvNo.text = object[5];           
	             }	       
	        break;                
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdInsurance':
            data_kblc00020.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdInsurance.GetGridData(grdInsurance.row,G_Insurance_pk);
            data_kblc00020_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0010')
             {
                lstCompany.SetDataText(txtLGCodeList.text);
                lstCompany.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0020')
             {
                lstCondition.SetDataText(txtLGCodeList.text);  
                lstCondition.value = rtnLGCode;                      
             }
      break;
      
      case 'data_kblc00020_1':
            if (lblStatus.text == 'SAVE'||lblStatus.text == 'CANCEL')
            {
               btnAutoSlip.SetEnable(false) ;
               btnApprove.SetEnable(true) ;
               btnACancel.SetEnable(false) ;
               btnACopy.SetEnable(false) ;
            }else
            { 
               btnApprove.SetEnable(false) ;
               if(txtACCSlipNo.text =="")
               {
                btnACancel.SetEnable(true) ;
                btnAutoSlip.SetEnable(true) ;
                btnACopy.SetEnable(false) ;
               }else
               {
                 btnACancel.SetEnable(false) ;
                 btnAutoSlip.SetEnable(false) ;
                 btnACopy.SetEnable(true) ;
               }
            }
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00020.Call('SELECT');
            }
      break;
      
      case 'data_kblc00020':
            lblRecord.text  = ( grdInsurance.rows -1 )+ " record(s)."
      break;
      
      case 'pro_kblc00020':
        alert(txtReturnValue.text);
        data_kblc00020_1.Call('SELECT')
      break;
      case 'pro_kblc00020_1':
        alert(txtReturnValue.text);
        data_kblc00020_1.Call('SELECT')
      break;
      
       case 'pro_kblc00020_2':
	    data_kblc00020_1.Call('SELECT')
       break;	
        
        case 'pro_kblc00020_3':
            alert(txtReturnValue.text);
            data_kblc00020_1.Call('SELECT')
        break;
    }
}
//====================================================================================

function Validate()
{   
    if(txtPolicyNo.text =="")
    {
        alert("Please, input Policy No!")
        return false;
    }
    else  if(txInsAMT.text =="" || txInsAMT.text =="0")
    {
        alert("Please, input Insurance Amount!");
        return false;
    }  
    else if(txtVatRate.text != "")
    {
        var tmp = parseFloat(txtVatRate.text);
        if(tmp >= 0)
            return true;
        else
        {    
            alert("Vat rate is number!");
            return false;
        }
    } 
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00020_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00020_1.Call();  
        }
           
    }else
    {    
        data_kblc00020_1.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00020_1.StatusInsert();
     txtSlipNo.text   = '***New Voucher***';
    txtPremiumRate.text = '110';
    txtVatRate.text = '10'
    txInsRate.text = '0.12'  
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00020_1.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function OnProcess(obj)
{
    switch(obj)
     {   
        case "APPROVE" :
           
                if(txtMasterPK.text !="")
                {
                    pro_kblc00020.Call();
                }else
                {
                    alert("Please, select an insurance slip to approve!");
                }
           
       break;
       case "CANCEL":       
         if(txtMasterPK.text !="")
        {
            pro_kblc00020_1.Call();
        }else
        {
            alert("Please, select an insurance slip to Cancel!");
        }
      break;
      
      case "SLIP":
        if(txtMasterPK.text !="")
        {
            pro_kblc00020_2.Call();
        }else
        {
            alert("Please, select an insurance slip to Auto Slip!");
        }
     break;
      
      case "COPY":
        if(txtMasterPK.text !="")
        {
            pro_kblc00020_3.Call();
        }else
        {
            alert("Please, select an insurance slip to copy slip!");
        }
      break;
      
    }
    
}
//====================================================================================
function OnCalInsured()
{
	txInsAMT.text = txtInvValue.text * txtPremiumRate.text/100; 
    //--input auto Net AMT to tab Invoice
    //--txtNetAMT.text = txtPremium.text;
    //--OnCalTotal()
}
//====================================================================================
function OnCalPremium()
{	
    txtPremium.text = txInsAMT.text * txInsRate.text/100;
    //--input auto Net AMT to tab Invoice
    txtNetAMT.text = txtPremium.text;
    OnCalTotal();
}

//====================================================================================
function OnCalVat()
{   
    if(txtVatRate.text == "")
        txtVatAMT.text = "";
    else
        txtVatAMT.text = System.Round(parseFloat(txtVatRate.text) * parseFloat(txtPremium.text)/100,2);
    //--update auto Vat Rate, Vat AMT to tab Invoice
    txtVatRate_inv.text = txtVatRate.text;
    txtVatAMT_Inv.text = txtVatAMT.text;         
    OnCalTotal();  
}
//====================================================================================
function OnCalTotal()
{   
    if(txtVatAMT.text != "")
        txtTotalAMT.text = parseFloat(txtPremium.text)+ parseFloat(txtVatAMT.text);
    else
        txtTotalAMT.text = parseFloat(txtPremium.text);
    //--update auto Total AMT to tab Invoice
    txtTotalAMT_inv.text = txtTotalAMT.text;
    //--update auto Exchange AMT to tab Invoice  
   txtExchangeAMT.text = parseFloat(txtTotalAMT_inv.text)*parseFloat(txtExRate.text);    
}
//====================================================================================         
 function OnCalExAmt()
{     
   txtExchangeAMT.text = parseFloat(txtTotalAMT_inv.text)*parseFloat(txtExRate.text);    
}
//====================================================================================       
</script>
<body>
    <!-----------------------------LOGISTIC CODE------------------------------------->
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00020" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00020"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtSlipNoSearch"	/>	
					<input	bind="txtPolicySearch"	/>	
				</input>	
				<output	bind="grdInsurance"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00020_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,14,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40"	function="<%=l_user%>lg_sel_kblc00020_1"	procedure="<%=l_user%>lg_upd_kblc00020_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtPolicyNo"	/>
						<inout	bind="dtInsurDate"	/>
				
						<inout	bind="lstCondition"	/>
						<inout	bind="txtPremiumRate"	/>
						<inout	bind="txtNumOfRod"	/>
                        <inout	bind="txInsAMT"	/>
						<inout	bind="txInsRate"	/>
									
						<inout	bind="txtExRate"	/>	
						<inout	bind="txtPremium"	/>	
						<inout	bind="lstCCy"	/>	
						<inout	bind="lblStatus"	/>			
						<inout	bind="txtACCSlipNo"	/>
						
						<inout	bind="txtShipPK"	/>
						<inout	bind="txtShipNo"	/>
						
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtVatRate"/>	
						<inout	bind="txtVatAMT"	/>			
						<inout	bind="txtTotalAMT"	/>
						<inout	bind="txtPartnerPK"	/>	
						<inout	bind="txtPartnerName"	/>
						
						<inout	bind="txtCustomerPK"	/>	
						<inout	bind="txtCustomerNM"	/>
						<inout	bind="txtInvoiceNo"	/>
						<inout	bind="dtInvoiceDT"	/>
						<inout	bind="txtSerialNo"	/>
						<inout	bind="txtProdName"	/>
						<inout	bind="txtNetAMT"	/>
						<inout	bind="txtVatRate_inv"	/>
						<inout	bind="txtVatAMT_Inv"	/>
						<inout	bind="txtTotalAMT_inv"	/>		
						<inout	bind="txtBillToNM"	/>
						<inout	bind="txtTaxCode"	/>
						<inout	bind="txtCustomerID"	/>	
						<inout	bind="txtDesc"	/>	
						<inout	bind="txtSEQ"	/>
						<inout	bind="txtInvValue"	/>
						<inout	bind="txtBLNo"	/>
                        <inout	bind="txtExchangeAMT"	/>
                        <inout	bind="txtComInvNo"	/> 
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00020" > 
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
    <gw:data id="pro_kblc00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00020_1" > 
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
    <gw:data id="pro_kblc00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00020_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="txtCompany_PK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien copy ------------------------------->
    <gw:data id="pro_kblc00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00020_3" > 
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
        <tr style="height: 1%">
            <td style="width: 12%" colspan="11">
                <table>
                    <tr>
                        <td style="width: 30%">
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('APPROVE')" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:icon id="btnACancel" img="2" text="Cancel" onclick="OnProcess('CANCEL')" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:icon id="btnAutoSlip" img="2" text="Auto Slip" onclick="OnProcess('SLIP')" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:icon id="btnACopy" img="2" text="Copy" onclick="OnProcess('COPY')" />
                        </td>
                        <td align="right" style="width: 10%;">
                            ACC SlipNo
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtACCSlipNo" styles="width:100%;" />
                        </td>
                        <td style="width: 15%" align="center">
                            <gw:label id="lblStatus" text="" styles="color:red" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                        </td>
                        <td style="width: 2%" align="right">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 4%" align="right">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 5%">
            <td style="background-color: #B4E7FF">
                <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                        <span value="1" id="Deli-Info">Insurance</span> 
                        <span value="2" id="Sale-Term">Invoice Info</span>                        
                    </gw:radio>
            </td>
        </tr>
        <tr style="height: 20%" id="Insurance">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 12%;">
                            Slip No
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory" readonly="true" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Policy No
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtPolicyNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <a title="Invoice No" onclick="OnShowPopup('INVOICE')" href="#tips" style="color: #0000ff">
                                <b>B/L No</b></a>
                        </td>
                        <td style="width: 28%">
                            <gw:textbox id="txtBLNo" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Comercial Inv No
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtComInvNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Invoice value
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtInvValue" styles="width:100%;" type="number" format="###,###,###.##R"
                                onblur="OnCalInsured()" onchange="OnCalInsured()" onenterkey="OnCalInsured()" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Premium Rate(%)
                        </td>
                        <td style="width: 28%">
                            <gw:textbox id="txtPremiumRate" styles="width:100%;" type="number" format="###,###,###.##R"
                                onblur="OnCalInsured()" onchange="OnCalInsured()" onenterkey="OnCalInsured()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnShowPopup('PARTNER')" href="#tips" style="color: #0000ff">Insurance Company
                            </a>
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtPartnerPK" maxlen="100" styles='width:100%;display:none' />
                            <gw:textbox id="txtPartnerName" csstype="mandatory" styles='width:100%' />
                        </td>
                        <td align="right" style="width: 12%;">
                            Insured
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txInsAMT" styles="width:100%;" type="number" format="###,###,###,###.##R"
                                onblur="OnCalPremium()" onchange="OnCalPremium()" onenterkey="OnCalPremium()" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Insurance Rate(%)
                        </td>
                        <td style="width: 28%">
                            <gw:textbox id="txInsRate" styles="width:100%;" type="number" format="###,###,###.##R"
                                onblur="OnCalPremium()" onchange="OnCalPremium()" onenterkey="OnCalPremium()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnShowPopup('CONDITION')" href="#tips" style="color: #0000ff">Insurance
                                Condition </a>
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:list id="lstCondition" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Insurance Date
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:datebox id="dtInsurDate" lang="1" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Premium
                        </td>
                        <td style="width: 28%">
                            <gw:textbox id="txtPremium" styles="width:100%;" type="number" format="###,###,###,###.##R"
                                onblur="OnCalTotal()" onchange="OnCalTotal()" onenterkey="OnCalTotal()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnShowPopup('SHIPMENT')" href="#tips" style="color: #0000ff">Shipment</a>
                        </td>
                        <td style="width: 18%" colspan="2">
                            <gw:textbox id="txtShipPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtShipNo" styles="width:100%;" csstype="mandatory" readonly="true" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Vat Rate
                        </td>
                        <td colspan="2" style="width: 18%">
                            <gw:textbox align="right" id="txtVatRate" styles="width:100%;" onblur="OnCalVat()"
                                onenterkey="OnCalVat()" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Vat AMT
                        </td>
                        <td align="right" style="width: 28%">
                            <gw:textbox align="right" id="txtVatAMT" styles="width:100%;" onblur="OnCalTotal()"
                                onchange="OnCalTotal()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            L/C No
                        </td>
                        <td style="width: 13%">
                            <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />
                        </td>
                        <td style="width: 5%">
                            <gw:textbox id="txtSEQ" styles="width:100%;" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Bale
                        </td>
                        <td colspan="2" style="width: 18%">
                            <gw:textbox id="txtNumOfRod" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Total AMT
                        </td>
                        <td style="width: 28%">
                            <gw:textbox id="txtTotalAMT" styles="width:100%;" type="number" format="###,###,###,###.##R" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="Invoice" style="height: 20%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('PARTNER')">Customer</b>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtCustomerPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtCustomerNM" styles="width:100%;" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Customer ID
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtCustomerID" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Tax Code
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtTaxCode" styles="width:100%;" csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            Invoice No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtInvoiceNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Serial No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSerialNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Invoice Date
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:datebox id="dtInvoiceDT" lang="1" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            Prod Item
                        </td>
                        <td style="width: 60%" colspan="3">
                            <gw:textbox id="txtProdName" styles="width:100%; " />
                        </td>
                        <td align="right" style="width: 10%;">
                            Net AMT
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtNetAMT" styles="width:100%;" type="number" format="###,###,###.##R" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            VAT Rate
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtVatRate_inv" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            VAT AMT
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtVatAMT_Inv" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Total AMT
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtTotalAMT_inv" styles="width:100%;" type="number" format="###,###,###.##R"
                                onblur="OnCalExAmt()" onchange="OnCalExAmt()" />
                        </td>
                    </tr>
                    <tr style="height: 20%">
                    </tr>
                    <tr style="height: 20%">
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            <b style="color: #1b2ff2; cursor: hand">Customer Name</b>
                        </td>
                        <td style="width: 60%" colspan="3">
                            <gw:textbox id="txtBillToNM" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Exchange Rate
                        </td>
                        <td style="width: 8%">
                            <gw:list id="lstCCy" styles="width:100%;" />
                        </td>
                        <td style="width: 12%">
                            <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="###,###,###"
                                onblur="OnCalExAmt()" onchange="OnCalExAmt()" onenterkey="OnCalExAmt()" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 10%;">
                            Description
                        </td>
                        <td style="width: 60%" colspan="3">
                            <gw:textbox id="txtDesc" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Exchange AMT
                        </td>
                        <td style="width: 20%" colspan="2">
                            <gw:textbox id="txtExchangeAMT" styles="width:100%;" type="number" format="###,###,###.##R" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 5%;">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 10%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Slip No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSlipNoSearch" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%;">
                            Policy No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtPolicySearch" styles="width:100%;" />
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:label id="lblRecord" text="" styles="color:red" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdInsurance')" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 60%">
            <td>
                <gw:grid id='grdInsurance' header='_PK|Slip No|Policy No|PL No|Comer. Inv No|_TLG_KB_RAW_LC_PK|Insur. Date|Insur. Company|Insur. Condition|Premium Rate|Num of Rod|Insur. Amt|Insur. Rate|Ex Rate|Premium|Vat AMT|Total AMT|Status|ACC Slip'
                    format='0|0|0|0|0|1|4|0|0|1|0|1|1|1|1|1|1|1|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1500|1500|1300|1300|0|1200|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1200|1200'
                    sorting='T' autosize='T' oncellclick="OnSearch('Master')" styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtLCNoPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
</html>
