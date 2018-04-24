<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Request for payment</title> 
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
var vStatus;
var company_pk = "<%=Session("COMPANY_PK")%>"; 
var l_tac_hgtrh_pk;
//--------------------------------------------------------------------
function BodyInit()
{
	BindingDataList();
	txtCompanyPK.text = '1';
	
	txt_requestpayment_pk.text = '<%=Request.QueryString("p_payment_pk")%>';
    vStatus = '<%=Request.QueryString("p_status")%>';
    
    l_tac_hgtrh_pk = '<%=Request.QueryString("p_TAC_HGTRH_PK")%>';    
    if (l_tac_hgtrh_pk != '')
        btnSave.SetEnable(false);        
    
	if (txt_requestpayment_pk.text == '')
	{
		dso_kpcs314_2.StatusInsert();

		txtMSTPK.text		= '<%=Request.QueryString("p_mst_pk")%>';		
		txtPrjPK.text		= '<%=Request.QueryString("p_prj_pk")%>';
		txtPrjCode.text		= '<%=Request.QueryString("p_prj_code")%>';
		txtPrjName.text		= '<%=Request.QueryString("p_prj_name")%>';
		txtSubNoPK.text		= '<%=Request.QueryString("p_subno_pk")%>';
		txtSubNoCode.text	= '<%=Request.QueryString("p_subno_code")%>';
		txtSubNoName.text	= '<%=Request.QueryString("p_subno_name")%>';
		txtSubPK.text		= '<%=Request.QueryString("p_sub_pk")%>';
		txtSubCodeT.text	= '<%=Request.QueryString("p_sub_code")%>';
		txtSubNameT.text	= '<%=Request.QueryString("p_sub_name")%>';
		lstCCY.value		= '<%=Request.QueryString("p_ccy")%>';
		txtSeq.text 		= '<%=Request.QueryString("p_seq")%>';
		
		dso_subct_info.Call();
		
	}
	else
	{
        dso_exrate.Call();
	}
	
	SetReqMonth();
}  
//==========================================================================
function BindingDataList()
{
	var data ;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>";
	lstCCY.SetDataText(data);

	data = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0030' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>";
	lstPP.SetDataText(data);
	
	data = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0043' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>";
	lstPayMethod.SetDataText(data);
} 

function SetReqMonth()
{
    if (lstPP.value == '01')
        dtReqMonth.acceptnull = true;
    else
        dtReqMonth.acceptnull = false;
}

function OnSearch()
{
   
}

function OnClick(obj)
{
	switch (obj.id)
	{
		case 'btnSave':
		    vStatus = 'update';
			dso_kpcs314_2.Call();
		break;
		case 'btnClose':
			window.returnValue = txt_requestpayment_pk.text;
	   		this.close(); 	
		break;
	}
}
	
function OnDataReceive(obj)
{
	switch (obj.id)
	{
		case 'dso_subct_info':
			if (txt_edit_yn.GetData()=='N')
			{
				dtReqMonth.SetEnable(false);
			}else{
				dtReqMonth.SetEnable(true);
			}
			OnChangeCCY();
		break;
		case 'dso_kpcs314_2':
		    if (txtWith.text == '0')
                idCustomer.style.display = 'none';
            else
                idCustomer.style.display = '';
                
		    if (vStatus != 'update')
			    ReqAMT();
		break;
		case 'dso_exrate':
		    if (txtWith.text == '0')
                idCustomer.style.display = 'none';
            else
                idCustomer.style.display = '';
                
            if (vStatus != 'update')
			    ReqAMT();
			else
		        dso_kpcs314_2.Call("SELECT");
		break;
		case 'dso_req_amt':
		    if (txtReqStatus.text != '')
		    {
		        alert(txtReqStatus.text);
                btnSave.SetEnable(false);
		    }
		    else
		    {
                btnSave.SetEnable(true);
		    }
		    
		    OnChangeText();
		break;
	}
}

function ReqAMT()
{
	dso_req_amt.Call();
}

function OnGetCCY()
{
	var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');

	if (object != null )
	{
		lstCCY.SetDataText(object[1]);
		dso_exrate.Call();
	}
}

function OnGetPartner()
{
    var path = System.RootURL + "/form/gf/co/ffbp00031.aspx";
	var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');

	if (object != null )
	{
        txt_buspartner_pk.text = object[0];
        txt_buspartner_cd.text = object[1];
        txt_buspartner_nm.text = object[2];
	}
}

function OnChangeCCY()
{
	dso_exrate.Call();
}

function format_number(dec, fix) 
{
	fixValue = parseFloat(Math.pow(10,fix));
	rtn_value = parseInt(Math.round(dec * fixValue)) / fixValue;	
	return rtn_value ;
}

function OnChangeText()
{
	if (lblBCCY.text == 'USD')
	{
		if (lstCCY.GetText() == 'VND')
		{
		    if (lstPP.value == '01')
		    {
		        txtReqAMT.text = Number(txtReqFAMT.text) / Number(txtBRate.text);
		        
			    txtVATFAMT.text	= 0;
			    txtVATAMT.text = 0;
			    
			    //txtFWTAX.text 	= format_number(Number(txtReqFAMT.text) * (Number(txtWith.text)/100),0);
			    txtWTAX.text 	= Number(txtFWTAX.text) / Number(txtBRate.text);

                txtRETENFAMT.text = 0;
			    txtRETENAMT.text = 0;
			    		        
			    txtAdvDeducFAMT.text = 0;
			    txtAdvDeducAMT.text = 0;
			    
			    //txtTotalFAMT.text  = format_number(Number(txtReqFAMT.text) - Number(txtFWTAX.text),0);
			    txtTotalAMT.text = Number(txtTotalFAMT.text) / Number(txtBRate.text);
		    }
		    else
		    {
		        txtReqFAMT.text = format_number(txtReqFAMT.text, 0);
			    txtReqAMT.text = Number(txtReqFAMT.text) / Number(txtBRate.text);

			    txtVATFAMT.text	= format_number(txtVATFAMT.text, 0);
			    txtVATAMT.text = Number(txtVATFAMT.text) / Number(txtBRate.text);

			    //txtFWTAX.text 	= format_number(Number(txtReqFAMT.text) * (Number(txtWith.text)/100),0);
			    txtWTAX.text 	= Number(txtFWTAX.text) / Number(txtBRate.text);

			    //txtRETENFAMT.text  = format_number(Number(txtReqFAMT.text) * (Number(txtReten.text)/100),0);
			    txtRETENAMT.text = Number(txtRETENFAMT.text) / Number(txtBRate.text);

			    //txtAdvDeducFAMT.text = format_number(Number(txtReqFAMT.text) * (Number(txtAdv.text)/100),0);
			    txtAdvDeducAMT.text = Number(txtAdvDeducFAMT.text) / Number(txtBRate.text);
    			
			    //txtTotalFAMT.text  = format_number(Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtFWTAX.text) - Number(txtRETENFAMT.text) - Number(txtAdvDeducFAMT.text),0);
			    txtTotalAMT.text = Number(txtTotalFAMT.text) / Number(txtBRate.text);
			}
		}
		else if (lstCCY.GetText() == 'USD')
		{
		    if (lstPP.value == '01')
		    {
		        txtReqAMT.text = Number(txtReqFAMT.text);
		        
			    txtVATFAMT.text	= 0;
			    txtVATAMT.text = 0;
			    
			    //txtFWTAX.text 	= Number(txtReqFAMT.text) * (Number(txtWith.text)/100);
			    txtWTAX.text 	= Number(txtFWTAX.text);

                txtRETENFAMT.text = 0;
			    txtRETENAMT.text = 0;
			    		        
			    txtAdvDeducFAMT.text = 0;
			    txtAdvDeducAMT.text = 0;
			    
			    //txtTotalFAMT.text  = Number(txtReqFAMT.text) - Number(txtFWTAX.text) ;
			    txtTotalAMT.text = Number(txtTotalFAMT.text);
		    }
		    else
		    {
			    txtReqAMT.text = Number(txtReqFAMT.text);

			    //txtVATFAMT.text	= Number(txtReqAMT.text) * (Number(txtWith.text)/100);
			    txtVATAMT.text = Number(txtVATFAMT.text);

			    //txtFWTAX.text 	= Number(txtReqFAMT.text) * (Number(txtWith.text)/100);
			    txtWTAX.text 	= Number(txtFWTAX.text);

			    //txtRETENFAMT.text  = Number(txtReqFAMT.text) * (Number(txtReten.text)/100);
			    txtRETENAMT.text = Number(txtRETENFAMT.text);

			    //txtAdvDeducFAMT.text    = Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			    txtAdvDeducAMT.text     = Number(txtAdvDeducFAMT.text);
    			
			    //txtTotalFAMT.text  = Number(txtReqAMT.text) + Number(txtVATAMT.text) - Number(txtWTAX.text) - Number(txtRETENAMT.text) - Number(txtAdvDeducAMT.text);
			    txtTotalAMT.text = Number(txtTotalFAMT.text);
			}
		}
	}
	else if (lblBCCY.text == 'VND')
	{
		alert('Please, contact to Admin...');
	}
}

function OnPopUp(pos)
{
	var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
	var aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

	switch(pos)
    {
        case 'DA':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtDebitAccPK.text = tmp[1];
				txtDebitAccC.text = tmp[2];
				txtDebitAccN.text = tmp[3];
			}
	    break;
        case 'CA':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtCreditAccPK.text = tmp[1];
				txtCreditAccC.text = tmp[2];
				txtCreditAccN.text = tmp[3];
			}
	    break;
		case 'DVAT':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtDebitVATCPK.text = tmp[1];
				txtDebitVATC.text = tmp[2];
				txtDebitVATN.text = tmp[3];
			}
	    break;
		case 'CVAT':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtCreditVATCPK.text = tmp[1];
				txtCreditVATC.text = tmp[2];
				txtCreditVATN.text = tmp[3];
			}
	    break;
		case 'DW':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtDebitWCPK.text = tmp[1];
				txtDebitWC.text = tmp[2];
				txtDebitWN.text = tmp[3];
			}
	    break;
		case 'CW':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtCreditWCPK.text = tmp[1];
				txtCreditWC.text = tmp[2];
				txtCreditWN.text = tmp[3];
			}
	    break;
		case 'DR':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtDebitRCPK.text = tmp[1];
				txtDebitRC.text = tmp[2];
				txtDebitRN.text = tmp[3];
			}
	    break;
		case 'CR':			
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtCreditRCPK.text = tmp[1];
				txtCreditRC.text = tmp[2];
				txtCreditRN.text = tmp[3];
			}
	    break;
	    case 'DD':
	        
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtDebitDPK.text = tmp[1];
				txtDebitDC.text = tmp[2];
				txtDebitDN.text = tmp[3];
			}
	    break;
	    case 'CD':	        
			if (aValue != null)
			{
				var tmp = aValue[0];
				txtCreditDPK.text = tmp[1];
				txtCreditDC.text = tmp[2];
				txtCreditDN.text = tmp[3];
			}
	    break;
	}
}

function ChangeCB()
{
    //SetReqMonth();
    dso_exrate.Call();
    //ReqAMT();
//    return;
//    
//	if (txtSeq.text == '')
//	{
//		lstPP.value = '01';
//	}
//	else
//	{
//		if (txtSeq.text == 1 && lstPP.value == '01')
//		{
//			lstPP.value = '02';	
//		}
//		
//		ReqAMT();
//	}
}
//-------------------------------------------------------------------------
</script>

<body>
<!----------------------------------------------------------------------------->
<gw:data id="dso_subct_info" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.sp_314_get_subcontractinfo"  > 
			<input> 
				<input bind="txtPrjPK" />
				<input bind="txtSubNoPK" />
			 </input>
			 <output>
				<output bind="dtReqMonth"/>
				<output bind="txt_edit_yn"/>
				<output bind="lstPP"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<!----------------------------------------------------------------------------->
<gw:data id="dso_exrate" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.SP_GET_EXRATE"  > 
			<input> 
				<input bind="txtPrjPK" />
				<input bind="txtCompanyPK" />
				<input bind="lstCCY" />
				<input bind="dtReqDate" />
				<input bind="txtSubNoPK" />
			 </input>
			 <output>
				<output bind="txtExRate"/>
				<output bind="txtBRate"/>
				<output bind="lblBCCY"/>
				<output bind="txtAdv"/>
				<output bind="txtReten"/>
				<output bind="txtWith"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_req_amt" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.sp_pro_kpcs314_req_amt_1"  > 
			<input> 
				<input bind="lstPP" />
				<input bind="txtMSTPK" />
				<input bind="txtPrjPK" />
				<input bind="dtReqMonth" />
				<input bind="dtReqMonth_to" />
			 </input>
			 <output>
				<output bind="txtReqFAMT"/>
				<output bind="txtVATFAMT"/>
				<output bind="txtActQty"/>
				<output bind="txtReqStatus"/>
				
				<output bind="txtFWTAX"/>
				<output bind="txtRETENFAMT"/>
				<output bind="txtAdvDeducFAMT"/>
				<output bind="txtTotalFAMT"/>
				<output bind="txtvendorbasic_pk"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_kpcs314_2" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="control" parameter="0,1,4,7,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,39,42,45,48,51,54,57,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,77,78,81,84,85,86,87,88,89" function="ec111.sp_sel_kpcs314_2" procedure="ec111.sp_upd_kpcs314_2"> 
			<inout> 
				 <inout  bind="txt_requestpayment_pk" />
				 <inout  bind="txtPrjPK" />
				 <inout  bind="txtPrjCode" />
				 <inout  bind="txtPrjName" />
				 <inout  bind="txtSubNoPK" />
				 <inout  bind="txtSubNoCode" />
				 <inout  bind="txtSubNoName" />
				 <inout  bind="txtSubPK" />
				 <inout  bind="txtSubCodeT" />
				 <inout  bind="txtSubNameT" />
				 <inout  bind="txtStatus" />
				 <inout  bind="lstCCY" />
				 <inout  bind="txtExRate" />
				 <inout  bind="txtReqNo" />
				 <inout  bind="dtReqDate" />
				 <inout  bind="lstPP" />
				 <inout  bind="lstPayMethod" />
				 <inout  bind="txtSerialNo" />
				 <inout  bind="txtInvoiceNo" />
				 <inout  bind="dtInvoice" />
				 <inout  bind="dtDue" />
				 <inout  bind="txtReqRate" />
				 <inout  bind="txtReqAMT" />
				 <inout  bind="txtReqFAMT" />
				 <inout  bind="txtVATRate" />
				 <inout  bind="txtVATAMT" />
				 <inout  bind="txtVATFAMT" />
				 <inout  bind="txtACCRate" />
				 <inout  bind="txtWTAX" />
				 <inout  bind="txtFWTAX" />
				 <inout  bind="txtRETENAMT" />
				 <inout  bind="txtRETENFAMT" />
				 <inout  bind="txtTotalAMT" />
				 <inout  bind="txtTotalFAMT" />
				 <inout  bind="txtDesc" />
				 <inout  bind="txtMSTPK" />
				 <inout  bind="txtDebitAccPK" />
				 <inout  bind="txtDebitAccC" />
				 <inout  bind="txtDebitAccN" />
				 <inout  bind="txtCreditAccPK" />
				 <inout  bind="txtCreditAccC" />
				 <inout  bind="txtCreditAccN" />
				 <inout  bind="txtDebitVATCPK" />
				 <inout  bind="txtDebitVATC" />
				 <inout  bind="txtDebitVATN" />
				 <inout  bind="txtCreditVATCPK" />
				 <inout  bind="txtCreditVATC" />
				 <inout  bind="txtCreditVATN" />
				 <inout  bind="txtDebitWCPK" />
				 <inout  bind="txtDebitWC" />
				 <inout  bind="txtDebitWN" />
				 <inout  bind="txtCreditWCPK" />
				 <inout  bind="txtCreditWC" />
				 <inout  bind="txtCreditWN" />				 
				 <inout  bind="txtDebitRCPK" />
				 <inout  bind="txtDebitRC" />
				 <inout  bind="txtDebitRN" />
				 <inout  bind="txtCreditRCPK" />
				 <inout  bind="txtCreditRC" />
				 <inout  bind="txtCreditRN" />
				 <inout  bind="txtDesVAT" />
				 <inout  bind="txtDesW" />
				 <inout  bind="txtDesR" />
				 <inout  bind="txtSeq" />
				 <inout  bind="txtDesVATE" />
				 <inout  bind="txtDesWE" />
				 <inout  bind="txtDesRE" />
				 <inout  bind="txtDescE" />
				 <inout  bind="lblBCCY" />		
				 <inout  bind="txtAdvDeducAMT" />		 
				 <inout  bind="txtAdvDeducFAMT" />
				 <inout  bind="txtAdv" />
				 <inout  bind="txtReten" />
				 <inout  bind="txtWith" />
				 <inout  bind="txt_buspartner_pk" />
				 <inout  bind="txt_buspartner_cd" />
				 <inout  bind="txt_buspartner_nm" />
				 <inout  bind="txtBRate" />
				 <inout  bind="txtDebitDPK" />
				 <inout  bind="txtDebitDC" />
				 <inout  bind="txtDebitDN" />
				 <inout  bind="txtCreditDPK" />
				 <inout  bind="txtCreditDC" />
				 <inout  bind="txtCreditDN" />
				 <inout  bind="txtDesD" />
				 <inout  bind="txtDesDE" />
				 <inout  bind="dtReqMonth" />
				 <inout  bind="dtReqMonth_to" />
				 <inout  bind="txtvendorbasic_pk" />
			</inout>
		</dso> 
	</xml> 
</gw:data>
<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%" border="0" >
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Project  
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtPrjCode" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td colspan="2" style="width: 20%">
			  <gw:textbox id="txtPrjName" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td style="width: 15%" align="right">
			<table style="width: 100%" >
				<tr>
					<td style="width: 40%" align="center">
						<gw:label id="lblBCCY" />
					</td>
					<td style="width: 60%" >
					    <gw:textbox id="txtBRate" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" />
					</td>
				</tr>
			</table>
		</td>
		<td style="width: 15%" align="right">
			<table >
				<tr>
					<td>
						<gw:icon id="btnSave" img="in" text="Save" onclick="OnClick(this)"  />
					</td>
					<td>
						<gw:icon id="btnClose" img="in" text="Close" onclick="OnClick(this)"  />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Subcontract No  
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtSubNoCode" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td colspan="2" style="width: 20%">
			  <gw:textbox id="txtSubNoName" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td style="width: 15%" align="right">
			  Status
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtStatus" lang="1" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Subcontractor 
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtSubCodeT" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td colspan="2" style="width: 20%">
			  <gw:textbox id="txtSubNameT" readonly="true" lang="1" styles='width:100%' />
		</td>
		<td style="width: 15%" align="right">
			<a href="#" style="text-decoration: none" onClick="OnGetCCY()">Currency</a>
		</td>
		<td style="width: 15%">
			  <gw:list id="lstCCY" styles='width:100%' onchange="" />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Request No  
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtReqNo" lang="1" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Request Date
		</td>
		<td style="width: 20%">
			  <gw:datebox id="dtReqDate" lang="1" styles='width:100%'/>
		</td>
		<td style="width: 15%" align="right">
			  PP Des
		</td>
		<td style="width: 15%">
			  <gw:list id="lstPP" styles='width:100%' onchange="ChangeCB()" />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Payment method  
		</td>
		<td colspan="3" style="width: 15%">
			  <gw:list id="lstPayMethod" styles='width:100%' />
		</td>
		<td style="width: 15%" align="right" >
			  Serial No
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtSerialNo" lang="1" styles='width:100%' />
		</td>
	</tr>
	<tr>
		<td colspan="7" width="100%">
			<table cellpadding="0" cellspacing="0" style="width: 100%;" border="0" >
			   <tr>
				<td style="width: 20%" align="right">Progress date</td>
				<td style="width: 15%"><gw:datebox id="dtReqMonth" lang="1" type="date" styles='width:100%'  onchange="ReqAMT()"/></td>
				<td style="width: 1%" align="center">~</td>
				<td style="width: 15%"><gw:datebox id="dtReqMonth_to" lang="1"   type="date" styles='width:100%'  onchange="ReqAMT()"/></td>
				<td style="width: 15%" align="right" >Invoice Date</td>
				<td style="width: 15%"><gw:datebox id="dtInvoice" lang="1" styles='width:100%' /></td>
				<td style="width: 15%" align="right">Due Date</td>
		        <td style="width: 15%"><gw:datebox id="dtDue" lang="1" styles='width:100%' /></td>
			   </tr>	
			</table>
		</td>
	</tr>
	
	
	<tr style="height: 1%" valign="top" align="right">
		<td style="width: 15%" align="right" >
			Invoice no
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtInvoiceNo" lang="1" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Request AMT.	
		</td>
		<td style="width: 20%" colspan="1">
			  <gw:textbox id="txtReqFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" onchange="OnChangeText()" />
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtReqAMT" type="number" format="#,###,###,###,###.##R" readonly="true" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Ex. Rate
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtExRate" lang="1" type="number" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			VAT AMT.	
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtVATFAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtVATAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			VAT Rate
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtVATRate" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" onchange="OnChangeText()"/>
		</td>
		<td style="width: 20%" align="right">
			Withholding Tax.	
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtFWTAX" type="number" readonly="true"  format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" onchange="OnChangeText()"/>
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtWTAX" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Request Rate				
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtReqRate" type="number" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Retention AMT	
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtRETENFAMT" type="number" readonly="true"  format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" onchange="OnChangeText()"/>
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtRETENAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		
		<td style="width: 15%" align="right">
			ACC Rate		
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtACCRate" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Deduction AMT
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtAdvDeducFAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtAdvDeducAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" >
		</td>
		<td style="width: 15%">
		<td style="width: 20%" align="right">
			This Payment	
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtTotalFAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtTotalAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('DA')">Debit (Acc Code)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtDebitAccPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			  <gw:textbox id="txtDebitAccC"  readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 15%;" >
		    <div style="float:left"><gw:textbox id="txtDebitAccN" readonly="true" styles='width:95%' /></div>
            <div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtDebitAccPK.text='';txtDebitAccC.text='';txtDebitAccN.text='';" /></div>
		</td>
	</tr>	
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('CA')">Credit (Acc Code)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtCreditAccPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			  <gw:textbox id="txtCreditAccC"  readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 15%" >
			  <div style="float:left"><gw:textbox id="txtCreditAccN" readonly="true" styles='width:95%' /></div>
			  <div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtCreditAccPK.text='';txtCreditAccC.text='';txtCreditAccN.text='';" /></div>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('DVAT')">Debit (VAT)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtDebitVATCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 15%">
			<gw:textbox id="txtDebitVATC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 20%" >
			<div style="float:left"><gw:textbox id="txtDebitVATN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtDebitVATCPK.text='';txtDebitVATC.text='';txtDebitVATN.text='';" /></div>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('CVAT')">Credit (VAT)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtCreditVATCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			<gw:textbox id="txtCreditVATC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6"  style="width: 15%" >
			<div style="float:left"><gw:textbox id="txtCreditVATN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtCreditVATCPK.text='';txtCreditVATC.text='';txtCreditVATN.text='';" /></div>
		</td>
	</tr>	
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Descr. VAT
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesVAT"  styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Local Descr. VAT
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesVATE"  styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('DW')">Debit (Withholding)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtDebitWCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 15%">
			<gw:textbox id="txtDebitWC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 20%" >
			<div style="float:left"><gw:textbox id="txtDebitWN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve4" img="reset" alt="Reset" onclick="txtDebitWCPK.text='';txtDebitWC.text='';txtDebitWN.text='';" /></div>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('CW')">Credit (Withholding)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtCreditWCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			<gw:textbox id="txtCreditWC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 20%">
			<div style="float:left"><gw:textbox id="txtCreditWN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve5" img="reset" alt="Reset" onclick="txtCreditWCPK.text='';txtCreditWC.text='';txtCreditWN.text='';" /></div>
		</td>
	</tr>
	<tr id="idCustomer" style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Customers" href="#" style="text-decoration: none" onclick="OnGetPartner()">Customer&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txt_buspartner_pk"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			<gw:textbox id="txt_buspartner_cd" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 15%">
			<gw:textbox id="txt_buspartner_nm" readonly="true" styles='width:100%' />
		</td>
	</tr>		
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Descr. Withholding
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesW"  styles='width:100%' />
		</td>
	</tr>		
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Local Descr. Withholding
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesWE"  styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('DR')">Debit (Retention)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtDebitRCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 15%">
			<gw:textbox id="txtDebitRC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6"  style="width: 20%">
			<div style="float:left"><gw:textbox id="txtDebitRN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtDebitRCPK.text='';txtDebitRC.text='';txtDebitRN.text='';" /></div>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('CR')">Credit (Retention)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtCreditRCPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			 <gw:textbox id="txtCreditRC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 15%">			
			<div style="float:left"><gw:textbox id="txtCreditRN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtCreditRCPK.text='';txtCreditRC.text='';txtCreditRN.text='';" /></div>
		</td>
	</tr>		
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Descr. Retention
		</td>
		<td colspan="8" style="width: 80%" >
    <gw:textbox id="txtDesR"  styles='width:100%' />
		</td>
	</tr>		
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Local Descr. Retention
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesRE"  styles='width:100%' />
		</td>
	</tr>
	
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			<a title="Click here to show Debit Deduct Code" href="#" style="text-decoration: none" onclick="OnPopUp('DD')">Debit (Deduct)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtDebitDPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 15%">
			<gw:textbox id="txtDebitDC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6"  style="width: 20%">
			<div style="float:left"><gw:textbox id="txtDebitDN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btnDebitD" img="reset" alt="Reset" onclick="txtDebitDPK.text='';txtDebitDC.text='';txtDebitDN.text='';" /></div>
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			<a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('CD')">Credit (Deduct)&nbsp;</a>
		</td>
		<td style="display:none">
			  <gw:textbox id="txtCreditDPK"  readonly="true" styles='width:100%' />
		</td>	
		<td style="width: 20%">
			 <gw:textbox id="txtCreditDC" readonly="true" styles='width:100%' />
		</td>
		<td colspan="6" style="width: 15%">			
			<div style="float:left"><gw:textbox id="txtCreditDN" readonly="true" styles='width:95%' /></div>
			<div style="float:left"><gw:imgbtn id="btnDebitC" img="reset" alt="Reset" onclick="txtCreditDPK.text='';txtCreditDC.text='';txtCreditDN.text='';" /></div>
		</td>
	</tr>	
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Descr. Deduct
		</td>
		<td colspan="8" style="width: 80%" >
    <gw:textbox id="txtDesD"  styles='width:100%' />
		</td>
	</tr>		
	<tr style="height: 1%" valign="top">
		<td style="width: 20%" align="right">
			Local Descr. Deduct
		</td>
		<td colspan="8" style="width: 80%" >
			  <gw:textbox id="txtDesDE"  styles='width:100%' />
		</td>
	</tr>
	
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			REQ. Descr.
		</td>
		<td colspan="5" style="width: 15%">
			<gw:textbox id="txtDesc" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right">
			Local REQ. Descr.
		</td>
		<td colspan="5" style="width: 15%">
			<gw:textbox id="txtDescE" styles='width:100%' />
		</td>
	</tr>
</table>
</body>
<gw:textbox id="txtPrjPK" lang="1" styles='display:none' />
<gw:textbox id="txtSubPK" lang="1" styles='display:none' />
<gw:textbox id="txtMSTPK" lang="1" styles='display:none' />
<gw:textbox id="txtSubNoPK" lang="1" styles='display:none' />
<gw:textbox id="txt_requestpayment_pk" lang="1" styles='display:none' />
<gw:textbox id="txtTEXT" lang="1" styles='display:none' />
<gw:textbox id="txtCompanyPK" lang="1" styles='display:none' />
<gw:textbox id="txtSeq" lang="1" styles='display:none' />
<gw:textbox id="txtActQty" lang="1" styles='display:none' />
 
<gw:textbox id="txtAdv" lang="1" styles='display:none' />
<gw:textbox id="txtReten" lang="1" styles='display:none' />
<gw:textbox id="txtWith" lang="1" styles='display:none' />
<gw:textbox id="txtReqStatus" lang="1" styles='display:none' />
<gw:textbox id="txtvendorbasic_pk" lang="1" styles='display:none' />
<gw:textbox id="txt_edit_yn" text="Y" styles='display:none' />
</html>