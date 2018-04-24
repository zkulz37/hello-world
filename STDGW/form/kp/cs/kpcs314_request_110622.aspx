<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Request for payment</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
var vStatus;
var company_pk = "<%=Session("COMPANY_PK")%>"; 

function BodyInit()
{
	BindingDataList();
	txtCompanyPK.text = '1';
	
	txt_requestpayment_pk.text = '<%=Request.QueryString("p_payment_pk")%>';
    vStatus = '<%=Request.QueryString("p_status")%>';
    
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
        
		OnChangeCCY();
	}
	else
	{
		dso_kpcs314_2.Call("SELECT");
	}
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
		case 'dso_kpcs314_2':
		    dso_exrate.Call()
		break;
		case 'dso_exrate':
            if (vStatus != 'update')
			    ReqAMT();
		break;
		case 'dso_req_amt':
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

function OnChangeCCY()
{
	dso_exrate.Call();
}

function OnChangeText()
{
	if (lblBCCY.text == 'USD')
	{
		if (lstCCY.GetText() == 'VND')
		{
		    if (lstPP.value == '01')
		    {
		        txtReqAMT.text = Number(txtReqFAMT.text) / Number(lblBRate.text);
		        
			    txtVATFAMT.text	= 0;
			    txtVATAMT.text = 0;
			    
			    txtFWTAX.text 	= 0;
			    txtWTAX.text 	= 0;

                txtRETENFAMT.text = 0;
			    txtRETENAMT.text = 0;
			    		        
			    txtAdvDeducFAMT.text = 0;
			    txtAdvDeducAMT.text = 0;
			    
			    txtTotalFAMT.text  = txtReqFAMT.text ;
			    txtTotalAMT.text = Number(txtTotalFAMT.text) / Number(lblBRate.text);
		    }
		    else
		    {
			    txtReqAMT.text = Number(txtReqFAMT.text) / Number(lblBRate.text);

			    txtVATFAMT.text	= Number(txtReqFAMT.text) * (Number(txtVATRate.text)/100);
			    txtVATAMT.text = Number(txtReqAMT.text) * (Number(txtVATRate.text)/100);

			    txtFWTAX.text 	= Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			    txtWTAX.text 	= Number(txtFWTAX.text) / Number(lblBRate.text);

			    txtRETENFAMT.text  = Number(txtReqFAMT.text) * (Number(txtReten.text)/100);
			    txtRETENAMT.text = Number(txtRETENFAMT.text) / Number(lblBRate.text);

			    txtAdvDeducFAMT.text = Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			    txtAdvDeducAMT.text = Number(txtFWTAX.text) / Number(lblBRate.text);
    			
			    txtTotalFAMT.text  = Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtFWTAX.text) - Number(txtRETENFAMT.text) - Number(txtAdvDeducFAMT.text);
			    txtTotalAMT.text = Number(txtTotalFAMT.text) / Number(lblBRate.text);
			}
		}
		else if (lstCCY.GetText() == 'USD')
		{
			txtReqAMT.text = Number(txtReqFAMT.text);

			txtVATFAMT.text	= Number(txtReqAMT.text) * (Number(txtVATRate.text)/100);
			txtVATAMT.text = Number(txtReqFAMT.text) * (Number(txtVATRate.text)/100);

			txtFWTAX.text 	= Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			txtWTAX.text 	= Number(txtFWTAX.text);

			txtRETENFAMT.text  = Number(txtReqFAMT.text) * (Number(txtReten.text)/100);
			txtRETENAMT.text = Number(txtRETENFAMT.text);

			txtAdvDeducFAMT.text    = Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			txtAdvDeducAMT.text     = Number(txtAdvDeducFAMT.text);
			
			txtTotalFAMT.text  = Number(txtReqAMT.text) + Number(txtVATAMT.text) - Number(txtWTAX.text) - Number(txtRETENAMT.text) - Number(txtAdvDeducAMT.text);
			txtTotalAMT.text = Number(txtTotalFAMT.text);
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
	}
}

function ChangeCB()
{
    ReqAMT();
    return;
    
	if (txtSeq.text == '')
	{
		lstPP.value = '01';
	}
	else
	{
		if (txtSeq.text == 1 && lstPP.value == '01')
		{
			lstPP.value = '02';	
		}
		
		ReqAMT();
	}
}
//-------------------------------------------------------------------------
</script>

<body>
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
				<output bind="lblBRate"/>
				<output bind="lblBCCY"/>
				<output bind="txtAdv"/>
				<output bind="txtReten"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_req_amt" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.sp_pro_kpcs314_req_amt"  > 
			<input> 
				<input bind="lstPP" />
				<input bind="txtMSTPK" />
				<input bind="txtPrjPK" />
			 </input>
			 <output>
				<output bind="txtReqFAMT"/>
				<output bind="txtActQty"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_kpcs314_2" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="control" parameter="0,1,4,7,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,39,42,45,48,51,54,57,60,61,62,63,64,65,66,67,68,69,70" function="ec111.sp_sel_kpcs314_2" procedure="ec111.sp_upd_kpcs314_2"> 
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
			<table >
				<tr>
					<td align="center">
						<gw:label id="lblBCCY" />
					</td>
					<td>
						<gw:label id="lblBRate"/>
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
			  <gw:list id="lstCCY" styles='width:100%' onchange="OnChangeCCY()" />
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
			  <gw:datebox id="dtReqDate" lang="1" styles='width:100%' />
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
	<tr style="height: 1%" valign="top">
		<td style="width: 15%" align="right" >
			Invoice no
		</td>
		<td style="width: 15%">
			  <gw:textbox id="txtInvoiceNo" lang="1" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Invoice Date
		</td>
		<td style="width: 20%">
			  <gw:datebox id="dtInvoice" lang="1" styles='width:100%' />
		</td>
		<td style="width: 15%" align="right">
			Due Date
		</td>
		<td style="width: 15%">
			  <gw:datebox id="dtDue" lang="1" styles='width:100%' />
		</td>
	</tr>
	<tr style="height: 1%" valign="top" align="right">
		<td style="width: 15%" >
			Ex. Rate
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtExRate" lang="1" type="number" format="#,###,###,###,###.##R" styles='width:100%' />
		</td>
		<td style="width: 20%" align="right">
			Request AMT.	
		</td>
		<td style="width: 20%">
			  <gw:textbox id="txtReqFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" onchange="OnChangeText()" />
		</td>
		<td colspan="2" style="width: 15%">
			  <gw:textbox id="txtReqAMT" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
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
			Request Rate				
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtReqRate" type="number" format="#,###,###,###,###.##R" styles='width:100%' />
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
			ACC Rate		
		</td>
		<td style="width: 15%">
			<gw:textbox id="txtACCRate" type="number" readonly="true" format="#,###,###,###,###.##R" styles='width:100%' />
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
		<td style="width: 15%" >
		</td>
		<td style="width: 15%">
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
			Total AMT	
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
			<gw:textbox id="txtDebitWN" readonly="true" styles='width:100%' />
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
		<td colspan="6" style="width: 15%">
			<gw:textbox id="txtCreditWN" readonly="true" styles='width:100%' />
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

</html>