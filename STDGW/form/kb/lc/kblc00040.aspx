<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Bank Charge</title>
</head>
<script type="text/javascript" language="javascript">

var flag, isLoadBank;
var rtnLGCode = '' ;

var G_MASTER_PK         = 0,
    G_DETAIL_PK         = 1,
    G_CHARGE            = 2,
    G_NET_AMT           = 3,
    G_EXC_AMT           = 4,
    G_VAT               = 5,
    G_VAT_AMT           = 6,
    G_SUB_TOTAL_AMT     = 7;

var G1_PK           = 0,
    G1_PAYMENT_DT   = 1,
    G1_SLIP_NO      = 2,
    G1_LC_NO        = 3,
    G1_PARTNER      = 4,
    G1_EX_NET_AMT   = 5,
    G1_VAT_AMT      = 6,
    G1_TOTAL_AMT    = 7,
    G1_STATUS       = 8,
    G1_ACC_SLIP_NO  = 9,
    G1_DESCRIPTION  = 10;
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
    
    txtLCNo.SetEnable(false) ;
    txtStaffName.SetEnable(false) ;
    txtSlipNo.SetEnable(false) ;
    txtACCSlipNo.SetEnable(false)  ;
    txtCustomerID.SetEnable(false) ; 
    txtCustomerNM.SetEnable(false)  ;
    txtTaxCode.SetEnable(false)  ;
    txtInvoiceNo.SetEnable(false) ; 
    txtSubCustomerNM.SetEnable(false)  ;
    //----------------------------
    OnAddNew('Master');
    OnChangeTab(); 
    BindingDataList(); 
    OnSearch('grdCharge');
}
//==================================================================================
 
 function BindingDataList()
 { 
    var data = "";   
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCY.SetDataText(data); 
    lstCCY.value = 'USD' ; 
    
    //data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    //lstPartner.SetDataText(data); 
    //lstPartner.value = '' ;
        
    data = "#10;CABLE CHARGE|#20;BANK CHARGE|#30;LC CHARGE|#;-" ;	
    grdDetail.SetComboFormat(G_CHARGE,data); 
     
    //data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0010' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    //lstBank.SetDataText( data);
	
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    lstCompany.SetDataText(data);	 
    lstCompany.value= txtCompany_PK.text;	

    //data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_BUSPARTNER WHERE DEL_IF=0 AND PARTNER_TYPE = '50'")%>";
    //lstBank.SetDataText( data);
 }
 //====================================================================================
function OnChangeTab()
 {
    var strRad = radTab.GetData();
    
    var tab_Clear      = document.all("Charge");    
    var tab_Invoice    = document.all("Invoice");    
	
	switch (strRad)
	{
		case '1':
		    tab_Clear.style.display      	= "";
		    tab_Invoice.style.display      	= "none";		 
		    
		    document.all("Charge").style.color      	= "cc0000"; 
		    document.all("Invoice").style.color      	= "";
        break;
        case '2':
		    tab_Clear.style.display      	= "none";
		    tab_Invoice.style.display      	= "";		 
		    
		    document.all("Charge").style.color      	= ""; 
		    document.all("Invoice").style.color      	= "cc0000";
        break;
     }
 }
//==================================================================================== 
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
//==================================================================================== 
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'LC':
	             var path = System.RootURL + "/form/kb/lc/kblc00042.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes',this);
                 isLoadBank = "false";
                 pro_kblc00040_3.Call();	                               
            break;
            case 'FACT':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0040";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0040';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstStoredFact.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'BANK':
                 var path = System.RootURL + "/form/kb/lc/kblc00043.aspx";
	             var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {
	                txtBankPK.text      = object[0];
                    txtBankNM.text      = object[4];

	                txtCustomerPK.text  = object[0];
                    txtCustomerNM.text  = object[4];
                    txtTaxCode.text     =  object[6];
                    txtCustomerID.text  = object[3];
                                        
                    txtSubCustomerPK.text   = object[0];
                    txtSubCustomerNM.text   = object[4];

                    txtTacAbdepomtPK.text   = object[1];
                    lstCCY.value            = object[2];
                    isLoadBank              = "false";
                    pro_kblc00040_3.Call();
	             }                       
            break;
            case 'PARTNER' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPK.text   = object[0];
                txtPartnerNM.text = object[2];
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
            case 'CHARGER':
                var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
                var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                    txtStaffName.text = obj[2];
                    txtStaffPK.text   = obj[0];
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
            }else
            { 
               btnApprove.SetEnable(false) ;
               if(txtACCSlipNo.text =="")
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
//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdCharge':
            data_kblc00040.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdCharge.GetGridData(grdCharge.row,G1_PK);
            data_kblc00040_1.Call("SELECT");
        break; 
        case 'grdDetail':            
            data_kblc00040_2.Call("SELECT");
        break;              
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case 'data_kblc00040_1':
             
            OnCheckStatus();
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i,G_MASTER_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }
      break;
      
      case 'data_kblc00040_2':

      break;
      
      case 'data_kblc00040':
            btnApprove.SetEnable(false) ;
            btnACancel.SetEnable(false) ;
            btnAutoSlip.SetEnable(false) ;
            btnACopy.SetEnable(false) ;
            pro_kblc00040_3.Call();
      break;
      
       case 'pro_kblc00040':
        alert(txtReturnValue.text);
        data_kblc00040_1.Call('SELECT')
      break;
      
      case 'pro_kblc00040_1':
        alert(txtReturnValue.text);
        data_kblc00040_1.Call('SELECT')
      break;
      
      case 'pro_kblc00040_2':
        data_kblc00040_1.Call('SELECT')
      break;

      case 'pro_kblc00040_3':
        if(isLoadBank == "true")
        {
            txtBankPK.text = "";
            txtBankNM.text = "";
            txtTacAbdepomtPK.text = "";
        }
        TotalAmount();
      break;

      case 'pro_kblc00040_4':
        alert(txtReturnValue.text);
        data_kblc00040.Call('SELECT')
      break;
    }
}
//====================================================================================
function Validate()
{   
    if(txtLCNo.text =="")
    {
        alert("Please, input L/C No!")
        return false;
    }
    if(txtBankPK.text == "")
    {
        alert("Please, input Bank!")
        return false;
    }
    return true;
}
//====================================================================================
function OnSave(pos)
{
    switch(pos)
    { 
        case 'Master':
            if(Validate())
            {
                data_kblc00040_1.Call();
                flag='save';
            }
        break;
        case 'Detail':        
            data_kblc00040_2.Call();
        break;
    }
}

function OnAddNew(pos)
{
    switch (pos)
    {   
         case 'Master': 
                data_kblc00040_1.StatusInsert();
                txtSlipNo.text   = '***New Voucher***';
                txtStaffName.text = "<%=Session("USER_NAME")%>";
                txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
                //-------------------------------------------         
                grdDetail.ClearData();
                flag = "view";        
         break;
    }
}
         
function OnAddNewDetail()
{
     grdDetail.AddRow();                            
     grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK, txtMasterPK.text);
     grdDetail.SetGridText( grdDetail.rows-1, G_VAT, txtVAT.text);
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00040_1.StatusDelete();
       OnSave('Master');
    }
 }
 
 function OnDeleteDetail()
 {
      if(confirm('Do you want to delete this Item?'))
      {
          if ( grdDetail.GetGridData( grdDetail.row, G_DETAIL_PK ) == '' )
          {
              grdDetail.RemoveRow();
          }
          else
          {   
              grdDetail.DeleteRow();
          }   
          TotalAmount(); 
      } 
 }
 
 function OnUnDeleteDetail()
 {
     grdDetail.UnDeleteRow();
     TotalAmount();
 }
//====================================================================================
function OnProcess(obj)
{
   switch(obj)
     {   
        case "APPROVE" :
            if(txtMasterPK.text !="")
            {
                pro_kblc00040.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
         break;
        case "CANCEL" :
             if(txtMasterPK.text !="")
            {
                pro_kblc00040_1.Call();
            }else
            {
                alert("Please, select a slip to Cancel!");
            }
       
       break;
        case 'GET_RATE':
            isLoadBank = "true";
            pro_kblc00040_3.Call();
        break;

      case "SLIP":
        if(txtMasterPK.text !="")
        {
            pro_kblc00040_2.Call();
        }else
        {
            alert("Please, select an bank charge slip to make slip!");
        }
     break;

      case "COPY":
        if(txtMasterPK.text !="")
        {
            pro_kblc00040_4.Call();
        }else
        {
            alert("Please, select an insurance slip to copy slip!");
        }
      break;     
    }
}
//==================================================================================== 
function TotalAmount()
{
    try
    {
        var net_amt = 0, vat = 0, exc_amt = 0, ex_rate = 0, vat_amt = 0, total_net_amt = 0, total_ex_amt = 0, total_net_vat_amt = 0, 
        total_vat_amt = 0, total_amt = 0, total_net_vat_bc = 0, total_net_vat_lc_cb = 0;
        txtVatRate_INV.text = txtVAT.text;
    
        for(var i = 1; i < grdDetail.rows; i++)
        {
            if(grdDetail.GetRowStatus(i) != 80 && grdDetail.GetRowStatus(i) != 64)
            {
                net_amt = Number(grdDetail.GetGridData(i, G_NET_AMT));
                if(grdDetail.GetGridData(i, G_CHARGE) == 10 || grdDetail.GetGridData(i, G_CHARGE) == 30) // LC - CABLE CHARGE
                {
                    total_net_vat_lc_cb += (net_amt * Number(grdDetail.GetGridData(i, G_VAT)/100))
                }
                else if(grdDetail.GetGridData(i, G_CHARGE) == 20) // BANK CHARGE
                {
                    total_net_vat_bc += (net_amt * Number(grdDetail.GetGridData(i, G_VAT)/100))
                }

                vat = Number(grdDetail.GetGridData(i, G_VAT));
                ex_rate = txtExRate.text;
            
                total_net_vat_amt +=  (net_amt * Number(grdDetail.GetGridData(i, G_VAT)/100));	

                grdDetail.SetGridText(i, G_EXC_AMT, net_amt * ex_rate);	
                exc_amt = Number(grdDetail.GetGridData(i, G_EXC_AMT));
                grdDetail.SetGridText(i, G_VAT_AMT, exc_amt * (Number(grdDetail.GetGridData(i, G_VAT))/100));	
            
                vat_amt = Number(grdDetail.GetGridData(i, G_VAT_AMT));
                grdDetail.SetGridText(i, G_SUB_TOTAL_AMT, exc_amt + vat_amt);
            
                total_ex_amt += exc_amt;
                total_net_amt += net_amt;
                total_vat_amt += Number(grdDetail.GetGridData(i, G_VAT_AMT));
                total_amt += Number(grdDetail.GetGridData(i, G_SUB_TOTAL_AMT));
            }    
        }
        txtVatAmount.text = System.Round( total_vat_amt,2);
        txtExAmount.text  = System.Round( total_ex_amt, 2);
        txtTotalAmt.text  = System.Round( total_amt, 2);
        txtNetAMT.text    = System.Round( total_net_amt, 2);

        txtNetVatAMT.text       = System.Round( total_net_vat_amt, 2); 
        txtNetVatAmt_BC.text    = System.Round( total_net_vat_bc, 2); 
        txtNetVatAmt_LC_CB.text = System.Round( total_net_vat_lc_cb, 2); 

        txtExNetAMT_INV.text  = System.Round( total_ex_amt, 2);
        txtVatAMT_INV.text = System.Round( txtVatAmount.text,2);
        txtTotalAMT_INV.text = System.Round( txtTotalAmt.text,2);
    }
    catch(err)
    {
        alert(err.message);
    }
}  
//====================================================================================         
</script>
<body>
    <!-----------------------------LOGISTIC CODE-------------------------------------
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
    <gw:data id="data_kblc00040" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00040"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtProdSearch"	/>	
					<input	bind="txtSearchNo"	/>	
				</input>	
				<output	bind="grdCharge"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00040_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44"	function="<%=l_user%>lg_sel_kblc00040_1"	procedure="<%=l_user%>lg_upd_kblc00040_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtPaymentDT"	/>
						<inout	bind="txtNumOfMonth"	/>
						<inout	bind="txtTradRate"	/>
						<inout	bind="txtTotalAmt"	/>
						<inout	bind="txtBankPK"	/>
                        <inout	bind="txtBankNM"	/>
						<inout	bind="lstCompany"	/>
						<inout	bind="txtRefNo"	/>
						<inout	bind="lstPaymentType"	/>
						<inout	bind="txtStaffPK"	/>
						<inout	bind="txtStaffName"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtPartnerPK"	/>
                        <inout	bind="txtPartnerNM"	/>
						<inout	bind="lstCCY"	/>
                        <inout	bind="txtExRate"	/>
                        <inout	bind="txtExAmount"	/>
						<inout	bind="txtItemDesc"	/>
                        <inout	bind="txtNetAMT"	/>
						<inout	bind="txtVAT"	/>
                        <inout	bind="txtNetVatAMT"	/>
                        <inout	bind="txtNetVatAmt_LC_CB"	/>
                        <inout	bind="txtNetVatAmt_BC"	/>
						<inout	bind="txtVatAmount"	/>
						<inout	bind="txtRemark"	/>
						<inout	bind="txtCustomerPK"	/>
						<inout	bind="txtCustomerID"	/>
						<inout	bind="txtCustomerNM"	/>
						<inout	bind="txtTaxCode"	/>
						<inout	bind="txtInvoiceNo"	/>
						<inout	bind="txtSerialNo"	/>
						<inout	bind="dtInvoiceDT"	/>
						<inout	bind="txtProdName"	/>
						<inout	bind="txtSubCustomerPK"	/>
						<inout	bind="txtSubCustomerNM"	/>
						<inout	bind="txtVatRate_INV"	/>
						<inout	bind="txtNetAMT"	/>
						<inout	bind="txtVatAMT_INV"	/>
						<inout	bind="txtTotalAMT_INV"	/>
                        <inout	bind="txtRemark_INV"	/>
						<inout	bind="lblStatus"	/>
                        <inout	bind="txtTacAbdepomtPK"	/>
                        <inout	bind="txtACCSlipNo"	/>
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_kblc00040_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_kblc00040_2" procedure="<%=l_user%>lg_upd_kblc00040_2">
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00040" > 
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
    <gw:data id="pro_kblc00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00040_1" > 
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
    <gw:data id="pro_kblc00040_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00040_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtACCSlipNo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien auto get currency ------------------------------->
    <gw:data id="pro_kblc00040_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>sp_get_rate" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstCCY" />
                    <input bind="dtPaymentDT" />
                </input> 
                <output>
                    <output bind="txtExRate" />
                    <output bind="txtNull" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------Thuc hien Copy ------------------------------->
    <gw:data id="pro_kblc00040_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00040_3" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <table border="1" style="width: 100%; height: 100%">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
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
                                    <td style="width: 1%" align="right">
                                        <img status="collapse" id="imgArrow" src="../../../system/images/button/next.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        Slip No
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtProdSearch" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        Search No
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtSearchNo" styles="width:100%;" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdCharge')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 22%">
                        <td colspan="8">
                            <gw:grid id='grdCharge' header='_pk|Payment Date|Slip No|LC No|Partner|Ex Net Amt|Vat Amt|Total Amt|Status|Acc Slip No|Description'
                                format='0|4|0|0|0|1|1|1|0|0|0' aligns='0|0|0|0|0|0|0|0|1|0|0' check='||||||||||'
                                editcol='1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <table>
                                <tr>
                                    <td style="width: 20%">
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
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        ACC SlipNo
                                    </td>
                                    <td style="width: 35%">
                                        <gw:textbox id="txtACCSlipNo" styles="width:100%;" />
                                    </td>
                                    <td style="width: 21%" align="center">
                                        <gw:label id="lblStatus" text="" styles="color:red" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                                    </td>
                                    <td style="width: 4%" align="right">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="background-color: #B4E7FF">
                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                            <span value="1" id="Deli-Info">Charge(term,인수,기타)</span> 
                            <span value="2" id="Sale-Term">Invoice Info</span>                        
                        </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 6%" id="Charge">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        Slip No
                                    </td>
                                    <td style="width: 23%" colspan="2">
                                        <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory" readonly="true" />
                                    </td>
                                    <td align="right" style="width: 12%; white-space: nowrap">
                                        Payment Date
                                    </td>
                                    <td colspan="2" style="width: 18%">
                                        <gw:datebox id="dtPaymentDT" lang="1" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Company
                                    </td>
                                    <td colspan="30" style="width: 23%">
                                        <gw:list id="lstCompany" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        Ref No
                                    </td>
                                    <td style="width: 23%" colspan="2">
                                        <gw:textbox id="txtRefNo" styles='width:100%' />
                                    </td>
                                    <td align="right" style="width: 12%; white-space: nowrap">
                                        Payment Type
                                    </td>
                                    <td colspan="2" style="width: 18%">
                                        <gw:list id="lstPaymentType" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        <a title="Charger" onclick="OnShowPopup('CHARGER')" href="#tips" style="color: #0000ff">
                                            <b>Charger</b></a>
                                    </td>
                                    <td colspan="30" style="width: 23%">
                                        <gw:textbox id="txtStaffName" styles="width:100%" />
                                        <gw:textbox id="txtStaffPK" styles="display:none" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        <a onclick="OnShowPopup('BANK')" href="#tips" style="color: #0000ff">Bank</a>
                                    </td>
                                    <td style="width: 18%" colspan="2">
                                        <!--<gw:list id="lstBank" styles="width:100%;" />-->
                                        <gw:textbox id="txtBankPK" styles="width:100%;display:none" readonly="true" />
                                        <gw:textbox id="txtBankNM" csstype="mandatory" styles="width:100%;" readonly="true" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        <a onclick="OnShowPopup('LC')" href="#tips" style="color: #0000ff">L/C No</a>
                                    </td>
                                    <td colspan="2" style="width: 18%">
                                        <gw:textbox id="txtLCNoPK" styles="width:100%;display:none" readonly="true" />
                                        <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />
                                    </td>
                                    <td align="right" style="width: 12%; white-space: nowrap">
                                        Num of Month
                                    </td>
                                    <td colspan="30" style="width: 23%">
                                        <gw:textbox id="txtNumOfMonth" styles="width:100%;" type="number" format="###,###,###,###.#R"
                                            onblur="OnCalAuto()" onchange="OnCalAuto()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        <a onclick="OnShowPopup('PARTNER')" href="#tips" style="color: #0000ff">Partner</a>
                                    </td>
                                    <td style="width: 18%" colspan="2">
                                        <gw:textbox id="txtPartnerPK" styles="width:100%;display:none" readonly="true" />
                                        <gw:textbox id="txtPartnerNM" csstype="mandatory" styles="width:100%;" readonly="true" />
                                    </td>
                                    <td align="right" style="width: 12%; white-space: nowrap">
                                        Trading Base Rate
                                    </td>
                                    <td colspan="2" style="width: 18%">
                                        <gw:textbox id="txtTradRate" styles="width:100%;" type="number" format="###,###,###,###.##" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        CCY
                                    </td>
                                    <td colspan="10" style="width: 35%">
                                        <gw:list id="lstCCY" styles="width:100%;" onchange="OnProcess('GET_RATE')" />
                                    </td>
                                    <td colspan="30">
                                        <gw:textbox id="txtExRate" styles='width:100%' onchange="TotalAmount()" onblur="TotalAmount()"
                                            onenterkey="TotalAmount()" type="number" format="###,###,###,###.##" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        Item Desc
                                    </td>
                                    <td style="width: 23%" colspan="2">
                                        <gw:textbox id="txtItemDesc" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        VAT %
                                    </td>
                                    <td style="width: 5%" colspan="2">
                                        <gw:textbox id="txtVAT" styles="width:100%;" type="number" format="###,###,###,###.##"
                                            onchange="TotalAmount()" onblur="TotalAmount()" onenterkey="TotalAmount()" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Ex Amount
                                    </td>
                                    <td colspan="30" style="width: 100%">
                                        <gw:textbox id="txtExAmount" styles="width:100%;" readonly="true" type="number" format="###,###,###,###.##" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%;">
                                        Net Amt
                                    </td>
                                    <td style="width: 23%" colspan="2">
                                        <gw:textbox id="txtNetAMT" styles="width:100%;" readonly="true" type="number" format="###,###,###,###.##" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        VAT Amt
                                    </td>
                                    <td colspan="2" style="width: 100%">
                                        <gw:textbox id="txtVatAmount" styles="width:100%;" readonly="true" type="number"
                                            format="###,###,###,###.##" />
                                    </td>
                                    <td align="right" style="width: 12%;">
                                        Total Amount
                                    </td>
                                    <td colspan="30" style="width: 28%">
                                        <gw:textbox id="txtTotalAmt" styles="width:100%;" readonly="true" type="number" format="###,###,###,###.##" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        Net VAT Amt
                                    </td>
                                    <td style="width: 23%" colspan="2">
                                        <gw:textbox id="txtNetVatAMT" styles="width:100%;" readonly="true" type="number"
                                            format="###,###,###,###.##" />
                                    </td>
                                    <td align="right" style="width: 10%;">
                                        Remark
                                    </td>
                                    <td style="width: 23%" colspan="30">
                                        <gw:textbox id="txtRemark" styles="width:100%;" readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="29" align="right">
                                        <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNewDetail()" />
                                    </td>
                                    <td align="right">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDeleteDetail" onclick="OnDeleteDetail()" />
                                    </td>
                                    <td align="right">
                                        <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDeleteDetail" onclick="OnUnDeleteDetail()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="Invoice" style="height: 5%">
                        <td>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 5%">
                                    <td align="right" style="width: 5%;">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('CUSTOMER')">Customer</b>
                                    </td>
                                    <td style="width: 35%">
                                        <gw:textbox id="txtCustomerPK" styles="width:100%;display:none" />
                                        <gw:textbox id="txtCustomerNM" styles="width:100%;" csstype="mandatory" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        Customer ID
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtCustomerID" csstype="mandatory" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%;">
                                        Tax Code
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtTaxCode" styles="width:100%;" csstype="mandatory" />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td align="right" style="width: 10%;">
                                        Invoice No
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtInvoiceNo" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%;">
                                        Serial No
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtSerialNo" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        Invoice Date
                                    </td>
                                    <td style="width: 20%">
                                        <gw:datebox id="dtInvoiceDT" lang="1" />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td align="right" style="width: 10%;">
                                        Prod Item
                                    </td>
                                    <td style="width: 30%" colspan="3">
                                        <gw:textbox id="txtProdName" styles="width:100%; " />
                                    </td>
                                    <td align="right" style="width: 10%;">
                                        Ex Net Amt
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtExNetAMT_INV" styles="width:100%;" readonly="true" type="number"
                                            format="###,###.#R" />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td align="right" style="width: 10%;">
                                        Vat Rate
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtVatRate_INV" styles="width:100%;" readonly="true" type="number"
                                            format="###,###.##" />
                                    </td>
                                    <td align="right" style="width: 10%;">
                                        Vat Amt
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtVatAMT_INV" styles="width:100%;" readonly="true" type="number"
                                            format="###,###.##" />
                                    </td>
                                    <td align="right" style="width: 10%;">
                                        Total Amt
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtTotalAMT_INV" styles="width:100%;" readonly="true" type="number"
                                            format="###,###.#R" />
                                    </td>
                                </tr>
                                <tr style="height: 5%">
                                    <td align="right" style="width: 10%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('SUBCUSTOMER')">Customer
                                            Name</b>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtSubCustomerPK" styles="width:100%;display:none" />
                                        <gw:textbox id="txtSubCustomerNM" styles="width:100%;" csstype="mandatory" />
                                    </td>
                                    <td align="right" style="width: 5%;">
                                        Remark
                                    </td>
                                    <td style="width: 40%" colspan="4">
                                        <gw:textbox id="txtRemark_INV" styles="width:100%;" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 28%">
                        <td colspan="30">
                            <gw:grid id='grdDetail' header='_MASTER_PK|_DETAIL_PK|Charge|Net Amt|Exc Amt|VAT|Vat Amt|Sub Total Amt'
                                format='0|0|2|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0' check='|||||||' editcol='1|1|1|1|1|1|1|1'
                                widths='0|0|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%'
                                onafteredit='TotalAmount()' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtTacAbdepomtPK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtNull" text="" style="display: none" />
<gw:textbox id="txtNetVatAmt_BC" text="" style="display: none" />
<gw:textbox id="txtNetVatAmt_LC_CB" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />
</html>
