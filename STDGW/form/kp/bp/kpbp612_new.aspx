<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Request for payment</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
var flag_update = false;

var G1_PK				    = 0,
	G1_REQ_NO		        = 1,
	G1_THIS_PAYMENT         = 2,
	G1_CCY      		    = 3;
	
function BodyInit()
{
	System.Translate(document);
	BindingDataList();
	//dso_kpcs319_mst.StatusInsert();
	
	/*
	grdDetail.GetGridControl().WordWrap = true;
	grdDetail.GetGridControl().RowHeight(0) = 450;
	var ctl = grdMST.GetGridControl();
	ctl.ColAlignment(G1_SUPPLY_PRICE)	= 7;
	ctl.ColAlignment(G1_VAT)			= 7;
	ctl.ColAlignment(G1_BALANCE)		= 7;
	ctl.ColAlignment(G1_AMT)			= 7;
	
	ctl.ColFormat(G1_SUPPLY_PRICE)	= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_VAT)			= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_BALANCE)		= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_AMT)			= "#,###,###,###,###,###,###,###,###.##R";

	var conn = grdDetail.GetGridControl();
	conn.FrozenCols = G2_PAY_REQ_AMT;
	for (col = G2_PAY_REQ_AMT; col <= G2_PRO_PAY_RATE; col++)
	{
		conn.ColAlignment(col)	= 7;
		conn.ColFormat(col)		= "#,###,###,###,###,###,###,###,###.##R";
	}
	/**/
}	

function BindingDataList()
{
	var data ;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>";
	lstCCY.SetDataText(data);
	lstCCY.value = 'USD';

	data = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0030' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>";
	lstPPDes.SetDataText(data);
	lstPPDes.value = '';
	
	data = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0043' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>";
	lstPayMethod.SetDataText(data);
	
	txtCompanyPK.text = "<%=Session("COMPANY_PK")%>";
}

function OnPrint(obj)
{
    switch(obj)
    {
        case 'proposal':
            return;
        break;
        case 'slipentry':
            return;
        break;
    }
}

function OnPopUp(pos)
{
	switch(pos)
	{
		case 'project':				
			var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
			var obj = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
					
			if ( obj != null )
			{
				txtProjectPK.text 		= obj[0];
				txtProjectCdSearch.text = obj[1];
				txtProjectCd.text 		= obj[1];
				txtProjectNm.text 		= obj[2];
			}
		break;
		case 'subcontracno':
			if (txtProjectPK.text == '')
			{
				alert('Please, select Project !!!');
			}
			else
			{
				var path = System.RootURL + '/form/kp/ar/kpar30_Subcontract.aspx?Project_pk=' + txtProjectPK.text;
				var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
				
				if ( obj != null )
				{
					tecps_substrp12000_pk.SetDataText(obj[0]);
					txtSubNoCd.SetDataText(obj[1]);
					txtSubNoNm.SetDataText(obj[2]); 
				   // txtSubcontractSearch.text = obj[1];
					dso_get_subcontractor.Call();
				}
			}
		break;
	    case 'subcontractor':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
			
            if ( obj != null )
            {
				txtCustomerPK.SetDataText(obj[0]);
				txtCustomerCd.SetDataText(obj[2]);
				txtCustomerCd.SetDataText(obj[1]); 
            }
        break;
        case 'Bank':
			var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company=1"+ '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txt_BankAcc1_Cd.text = object[3];//BANK ID
                    txt_BankAcc1_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txt_BankAcc1_Pk.text = object[6];
                }
            }
       
		break;
		case 'Bank1':
			var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company=1"+ '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txt_BankAcc_Cd.text = object[3];//BANK ID
                    txt_BankAcc_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txt_BankAcc_Pk.text = object[6];
                }
            }
		break;

	}
}
	
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if (imgArrow.status == "expand")
    {
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";

    	imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

function OnNew()
{
	btnSave.SetEnable(true);
	btnDelete.SetEnable(true);
	btconfirm.SetEnable(true);
	lstPPDes.value = '';
	dso_kpcs319_mst.StatusInsert();
}
function OnCheckInput()
{
    if (txtReqNo.text == '')
	{
		alert('Please, input Request No !!!');
        txtReqNo.GetControl().focus();
        return true;
    }
    else if(txtProjectPK.text == '')
    {
        alert('Please, input Project !!!');
        return true;
    }
    else if(txtSubNoCd.text == '')
    {
        alert('Please, input Subcontract No !!!');
        return true;
    }
    else if(txtSubCd.text == '')
    {
        alert('Please, input Subcontractor !!!');
        return true;
    }
    return false;
}
function OnSave()
{
    if(!OnCheckInput())
    {
		flag_update = true;
		dso_kpcs319_mst.Call();
    }
}

function OnDelete()
{
    if (txt_tecps_requestpayment_pk.text != '')
    {
        if (confirm('Are you sure you want to delete?'))
        {
			flag_update = true;
			dso_kpcs319_mst.StatusDelete();
            dso_kpcs319_mst.Call();
        }
    }
}

function OnConfirm()
{
    if (tac_hgtrh_pk.text != '')
	{
		alert('Already Confirm Slip ' + txtReqNo.text);
	}
	else
	{			
		if (confirm('Are you sure Make Slip for [' + txtReqNo.text + '] ?'))
		{
			if (txt_tecps_requestpayment_pk.text != '')
			{
				flag_update = true;
				txtAction.text = "INSERT";
				dso_MakeSlip.Call();
			}
		}
	}
}

function OnCancel()
{
    if (tac_hgtrh_pk.text == '')
	{
		alert('You can not Cancel Slip ' + txtReqNo.text);
	}
	else
	{
		if (txt_tecps_requestpayment_pk.text != '')
		{
			flag_update = true;
			txtAction.text = "DELETE";
			dso_MakeSlip.Call();
		}
	}
}

function OnSearch(obj)
{
    switch(obj.id)
    {
        case 'btnSearch':
        case 'txtProjectCdSearch':
      
            if(txtProjectCdSearch.text != '')
            {
                dso_kpcs319_search.Call("SELECT");
            }
            else
            {
                alert('Please select Project !!');
            }
        break;
        case 'grdSearch':
            if (grdSearch.row < 1) return;
            
            if (flag_update == false)
            {
                txt_tecps_requestpayment_pk.text = grdSearch.GetGridData(grdSearch.row, G1_PK);
                dso_kpcs319_mst.Call("SELECT");
            }
        break;
    }
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
		case 'dso_get_subcontractor':
			dso_exrate.Call();
		break;
		case 'dso_exrate':
			
		break;
        case 'dso_kpcs319_search':
			flag_update = false;
        break;
        case 'dso_kpcs319_mst':
			SetReqMonth();
            if (lblStatus.text == 'Confirm')
            {
                btnSave.SetEnable(false);
                btnDelete.SetEnable(false);
                btconfirm.SetEnable(false);
            }
            else
            {
                btnSave.SetEnable(true);
                btnDelete.SetEnable(true);
                btconfirm.SetEnable(true);
            }			
			
			if (flag_update == false)
				dso_kpcs319_dtl_debit.Call("SELECT");
			else
				dso_kpcs319_search.Call("SELECT");
        break;
        case 'dso_kpcs319_dtl_debit':
            dso_kpcs319_dtl_credit.Call("SELECT");
        break;
        case 'dso_kpcs319_dtl_credit':
        break;
		case 'dso_MakeSlip':
			dso_kpcs319_search.Call("SELECT");
		    alert(txtStatus.text);
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
		    if (lstPPDes.value == '01')
		    {
		        txtReqAMT.text = Number(txtReqFAMT.text) / Number(txtBRate.text);
		        
			    txtVATFAMT.text	= 0;
			    txtVATAMT.text = 0;
			    
			    txtWithFAMT.text 	= format_number(Number(txtReqFAMT.text) * (Number(txtWith.text)/100),0);
			    txtWithAMT.text 	= Number(txtWithFAMT.text) / Number(txtBRate.text);

                txtReFAMT.text = 0;
			    txtReAMT.text = 0;
			    		        
			    txtAdvFAMT.text = 0;
			    txtAdvAMT.text = 0;			    
				
				txtTotalDeFAMT.text = Number(txtWithFAMT.text) + Number(txtReFAMT.text) + Number(txtAdvFAMT.text);
				txtTotalDeAMT.text  = Number(txtWithAMT.text) + Number(txtReAMT.text) + Number(txtAdvAMT.text);
				
			    txtThisPayFAMT.text  = format_number(Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtTotalDeFAMT.text), 0);
			    txtThisPayAMT.text = Number(txtThisPayFAMT.text) / Number(txtBRate.text);
		    }
		    else
		    {
		        txtReqFAMT.text = format_number(txtReqFAMT.text, 0);
			    txtReqAMT.text = Number(txtReqFAMT.text) / Number(txtBRate.text);

			    txtVATFAMT.text	= format_number(txtVATFAMT.text, 0);
			    txtVATAMT.text = Number(txtVATFAMT.text) / Number(txtBRate.text);

			    txtWithFAMT.text 	= format_number(Number(txtReqFAMT.text) * (Number(txtWith.text)/100),0);
			    txtWithAMT.texft 	= Number(txtWithFAMT.text) / Number(txtBRate.text);

			    txtReFAMT.text  = format_number(Number(txtReqFAMT.text) * (Number(txtReten.text)/100),0);
			    txtReAMT.text = Number(txtReFAMT.text) / Number(txtBRate.text);

			    txtAdvFAMT.text = format_number(Number(txtReqFAMT.text) * (Number(txtAdvance.text)/100),0);
			    txtAdvAMT.text = Number(txtAdvFAMT.text) / Number(txtBRate.text);
    				
				txtTotalDeFAMT.text = Number(txtWithFAMT.text) + Number(txtReFAMT.text) + Number(txtAdvFAMT.text);
				txtTotalDeAMT.text  = Number(txtWithAMT.text) + Number(txtReAMT.text) + Number(txtAdvAMT.text);
				
				txtThisPayFAMT.text  = format_number(Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtTotalDeFAMT.text), 0);
			    txtThisPayAMT.text = Number(txtThisPayFAMT.text) / Number(txtBRate.text);
			}
		}
		else if (lstCCY.GetText() == 'USD')
		{
		    if (lstPPDes.value == '01')
		    {
		        txtReqAMT.text = Number(txtReqFAMT.text);
		        
			    txtVATFAMT.text	= 0;
			    txtVATAMT.text = 0;
			    
			    txtWithFAMT.text 	= Number(txtReqFAMT.text) * (Number(txtWith.text)/100);
			    txtWithAMT.text 	= Number(txtWithFAMT.text);

                txtReFAMT.text = 0;
			    txtReAMT.text = 0;
			    		        
			    txtAdvFAMT.text = 0;
			    txtAdvAMT.text = 0;
			    
				txtTotalDeFAMT = Number(txtWithFAMT.text) + Number(txtReFAMT.text) + Number(txtAdvFAMT.text);
				txtTotalDeAMT  = Number(txtWithAMT.text) + Number(txtReAMT.text) + Number(txtAdvAMT.text);
				
			    txtThisPayFAMT.text  = format_number(Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtTotalDeFAMT.text), 0);
			    txtThisPayAMT.text = Number(txtThisPayFAMT.text);
		    }
		    else
		    {
			    txtReqAMT.text = Number(txtReqFAMT.text);

			    //txtVATFAMT.text	= Number(txtReqAMT.text) * (Number(txtWith.text)/100);
			    txtVATAMT.text = Number(txtVATFAMT.text);

			    txtWithFAMT.text 	= Number(txtReqFAMT.text) * (Number(txtWith.text)/100);
			    txtWithAMT.text 	= Number(txtWithFAMT.text);

			    txtReFAMT.text  = Number(txtReqFAMT.text) * (Number(txtReten.text)/100);
			    txtReAMT.text = Number(txtReFAMT.text);

			    txtAdvFAMT.text    = Number(txtReqFAMT.text) * (Number(txtAdv.text)/100);
			    txtAdvAMT.text     = Number(txtAdvFAMT.text);
    							
				txtTotalDeFAMT.text = Number(txtWithFAMT.text) + Number(txtReFAMT.text) + Number(txtAdvFAMT.text);
				txtTotalDeAMT.text  = Number(txtWithAMT.text) + Number(txtReAMT.text) + Number(txtAdvAMT.text);
				
			    txtThisPayFAMT.text  = format_number(Number(txtReqFAMT.text) + Number(txtVATFAMT.text) - Number(txtTotalDeFAMT.text), 0);
			    txtThisPayAMT.text = Number(txtThisPayFAMT.text);
			}
		}
	}
	else if (lblBCCY.text == 'VND')
	{
		alert('Please, contact to Admin...');
	}
}

function ChangeCB()
{
	if (txtProjectPK.text != '')
	{
		if (lstPPDes.value == '01')
		{
			txtSeq.SetReadOnly(true);
			txtSeq.text = '0';
		}
		else
			txtSeq.SetReadOnly(false);

		dso_req_amt.Call();
	}
	else
	{
		alert('Please, select Project !!!');
	}
}

function SetReqMonth()
{
    if (lstPPDes.value == '01')
	{
		// fixed - no change
		dtProFrom.acceptnull = "true";
		dtProTo.acceptnull = "true";
        dtProFrom.SetData('');
		dtProTo.SetData('');
		dtProFrom.acceptnull="false";
		dtProTo.acceptnull="false";
	}
}

function OnShow() 
    {
       // var vendor1 = document.all("_1");
      //  var vendor2 = document.all("_2");
        var vendor3 = document.all("_3");
        var vendor4 = document.all("_4");
        var vendor5 = document.all("_5");
        if (vendor1.style.display == "none" && vendor2.style.display == "none" && vendor3.style.display == "none" && vendor4.style.display == "none" && vendor5.style.display == "none") 
        {
     //       vendor1.style.display = "";
      //      vendor2.style.display = "";
            vendor3.style.display = "";
            vendor4.style.display = "";
            vendor5.style.display = "";
            imgup.src = "../../../system/images/up.gif";
        }
        else 
        {
    //        vendor1.style.display = "none";
     //       vendor2.style.display = "none";
            vendor3.style.display = "none";
            vendor4.style.display = "none";
            vendor5.style.display = "none";
            imgup.src = "../../../system/images/down.gif";
        }
    }

//-----------------------------------------------------------------------------	
</script>
<body>
<gw:data id="dso_req_amt" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.sp_pro_kpcs319_req_amt"  > 
			<input> 
				<input bind="lstPPDes" />
				<input bind="tecps_substrp12000_pk" />
				<input bind="txtProjectPK" />
				<input bind="dtProFrom" />
				<input bind="dtProTo" />
			 </input>
			 <output>
				<output bind="txtReqFAMT"/>
				<output bind="txtVATFAMT"/>
				<output bind="txtActQty"/>
				<output bind="txtReqStatus"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_exrate" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.SP_GET_EXRATE"> 
			<input> 
				<input bind="txtProjectPK" />
				<input bind="txtCompanyPK"/>
				<input bind="lstCCY" />
				<input bind="dtReqDate" />
				<input bind="tecps_substrp12000_pk" />
			 </input>
			 <output>
				<output bind="txtERate"/>
				<output bind="txtBRate"/>
				<output bind="lblBCCY"/>
				<output bind="txtAdvance"/>
				<output bind="txtReten"/>
				<output bind="txtWith"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_get_subcontractor" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="EC111.SP_GET_SUBCONTRACTOR"> 
			<input> 
				<input bind="txtProjectPK" />
				<input bind="tecps_substrp12000_pk" />
			 </input>
			 <output>
				<output bind="txtSubPK"/>
				<output bind="txtSubCd"/>
				<output bind="txtSubNm"/>
				<output bind="lstCCY"/>
			 </output>
		</dso> 
	</xml>
</gw:data>

<gw:data id="dso_kpcs319_search" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid"    function="ec111.sp_sel_kpbp126_search"> 
			<input bind="grdSearch">                    
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 
				<input bind="txtProjectCdSearch" />
				
			</input> 
			<output bind="grdSearch" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_kpcs319_mst" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="control" parameter="0,1,4,7,10,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47" function="ec111.sp_sel_kpcs319_mst" procedure="ec111.sp_upd_kpcs319_mst"> 
			<inout> 
				 <inout  bind="txt_tecps_undertakeschdbasc_pk" />
				 <inout  bind="txtProjectPK" />                 
				 <inout  bind="txtProjectCd" />                 
				 <inout  bind="txtProjectNm" />                 
				 <inout  bind="txtCustomerPK" />                     
				 <inout  bind="txtCustomerCd" />                     
				 <inout  bind="txtCustomerNm" />
				 <inout  bind="txtReqNo" />  
				 <inout  bind="dtReqDate" />   	
				 <inout  bind="dtProFrom" />                    
				 <inout  bind="dtProTo" />                    
				 <inout  bind="txtreqtime" />
				 <inout  bind="lstPayMethod" />
         	     <inout  bind="lstBookccy" />
			     <inout  bind="txt_BankAcc1_Pk" />  
        		 <inout  bind="txt_BankAcc1_Cd" />   	
				 <inout  bind="txt_BankAcc1_Nm" />   
				 <inout  bind="txt_BankAcc_Pk" />  
        		 <inout  bind="txt_BankAcc_Cd" />   	
				 <inout  bind="txt_BankAcc_Nm" />  
				 <inout  bind="txtDes" />
    			 <inout  bind="txtLDes" />
				 <inout  bind="lstPPDes" />  
				 <inout  bind="lstCCY" />                       
				 <inout  bind="txtERate" />                     
				 <inout  bind="txtBRate" />
				 <inout  bind="txtReqFAMT" />
				 <inout  bind="txtReqAMT" />
				 <inout  bind="txtVATFAMT" />
				 <inout  bind="txtVATAMT" />
				 <inout  bind="txtReFAMT" />
				 <inout  bind="txtReAMT" />
				 <inout  bind="txtWithFAMT" />
				 <inout  bind="txtWithAMT" />
				 <inout  bind="txtAdvFAMT" />
				 <inout  bind="txtAdvAMT" />
				 <inout  bind="txtTotalDeFAMT" />
				 <inout  bind="txtTotalDeAMT" />
				 <inout  bind="txtThisPayFAMT" />
				 <inout  bind="txtThisPayAMT" />
				 <inout  bind="txtAdvance" />
				 <inout  bind="txtWith" />
				 <inout  bind="txtReten" />
				 <inout  bind="lblBCCY" />

			</inout>
		</dso> 
	</xml> 
</gw:data>

 <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;border-collapse: collapse" bordercolor="#00CCFF"  border="1">
	<tr style="width: 100%; height: 100%">
		<td style="width: 25%" id="left" >
			<table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
				<tr style="height:4%">
					<td>
						<fieldset style="padding:0">
							<table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
							    <tr>
									<td style="width: 10%" align="right">Date&nbsp;</td>
									<td style="width: 89%; white-space: nowrap"><gw:datebox id="dtFrom" lang="1" />~<gw:datebox id="dtTo" lang="1" /></td>
									<td style="width: 1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch(this)" /></td>
								</tr>
								<tr>
									<td style="width: 10%" align="right"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project</a>&nbsp;</td>
									<td colspan="2"><gw:textbox id="txtProjectCdSearch" styles="width: 100%" onenterkey="OnSearch(this)" /></td>
								</tr>
								
							</table>
						  </fieldset>
					</td>
				</tr>
				<tr style="height: 96%" valign="top">
					<td colspan="">
						<gw:grid id='grdSearch' 
							header='_PK|Request No.|Req. times|This Payment|CCY|_Confirm Date' 
							format='0|0|0|-1|0'
							aligns='0|0|3|3|0|0' 
							check='||||0|' 
							editcol='0|0|0|0|0|0' 
							widths='0|0|0|0|0|0' 
							sorting='T'
							autosize='T' 
							styles='width:100%; height:100%' 
							oncellclick="OnSearch(this)" />
					</td>
				</tr>
			</table>
		</td>
		<td style="width: 75%;" id="right" valign="top">
			<table cellpadding="0" cellspacing="0" style="width: 100%;border-collapse: collapse" bordercolor="#00CCFF"  border="1">
				<tr style="background:#C5EFF1;" >
                    <td align="right" width="20%">Seq&nbsp;</td>
					<td width="80%" colspan="">
						<table  style="width: 100%" cellpadding="0" cellspacing="0">
							<tr width="100%">
                                <td align="" width="30%"><gw:textbox id="txtSeq" type="number" format="#,###,###,###,###" styles="width: 100%"/></td>
                                <td width="28%" align="right">Status&nbsp;</td>
                                <td width="30%" align="left" ><gw:label id="lblStatus" styles="width: 100%; color:blue" text="Save"/></td>
								<td width="2%"><gw:imgbtn id="btnNew" 		img="new" 		alt="New" 			 	onclick="OnNew()" /></td>
								<td width="2%"><gw:imgbtn id="btnSave" 	img="save" 		alt="Save" 			 	onclick="OnSave()" /></td>
								<td width="2%"><gw:imgbtn id="btnDelete" 	img="delete" 	alt="Delete" 		 	onclick="OnDelete()" /></td>
								<td width="2%"><gw:imgbtn id="btconfirm" 	img="confirm" 	alt="Confirm" 		 	onclick="OnConfirm()"/></td>
								<td width="2%"><gw:imgbtn id="btnCancel" 	img="cancel" 	alt="Cancel" 		 	onclick="OnCancel()" /></td>
								<td width="2%"><gw:imgbtn id="btnPrint1" 	img="excel" 	alt="Proposal Sheet" 	onclick="OnPrint('proposal')" /></td>
								<td width=""><gw:imgbtn id="btnPrint2" 	img="excel" 	alt="Accounting slip" 	onclick="OnPrint('slipentry')" /></td>
							</tr>
						</table>
                    </td>
				</tr>
                <tr style="background:#C5EFF1;">
                    <td width="20%" align="right"><a href="#" title="Click here to show Project" style="text-decoration: none" onClick="OnPopUp('project')">Project&nbsp;</a></td>
                    <td style="width:80%">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="40%"><gw:textbox id="txtProjectCd" styles="width: 100%" csstype="mandatory" readonly="T"/></td>
                                <td width="60%"><gw:textbox id="txtProjectNm" styles="width: 100%" csstype="mandatory" readonly="T"/></td>
                                <td><gw:imgbtn id="btnonfirm" img="reset" alt="Reset" onclick="txtProjectCd.text='';txtProjectNm.text='';txtProjectPK.text='';" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
               
                <tr style="background:#C5EFF1">
					<td align="right"><a href="#" title="Click here to show Customer" style="text-decoration: none" onClick="OnPopUp('subcontractor')">Customer&nbsp;</a></td>
					<td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="40%"><gw:textbox id="txtCustomerCd" styles="width: 100%" csstype="mandatory" readonly="T"/></td>
                                <td width="60%"><gw:textbox id="txtCustomerNm" styles="width: 100%" csstype="mandatory" readonly="T"/></td>
                                <td><gw:imgbtn id="btnonfirm" img="reset" alt="Reset" onclick="txtCustomerCd.text='';txtCustomerNm.text='';" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background:#C5EFF1">
                    <td align="right">Request No&nbsp;</td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="70%"><gw:textbox id="txtReqNo" csstype="mandatory" styles="width: 100%" /></td>
                                <td width="30%" align="right">Req Date&nbsp;</td>
                                <td  width=""><gw:datebox id="dtReqDate" lang="1" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                
                <tr style="background:#C5EFF1">
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width=""align="left"><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow()" /></td>
                                <td width="100%" align="right">Progress date&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="20%" ><gw:datebox id="dtProFrom"  type="date" lang="1" onchange="ChangeCB()"/></td>
                                <td  align="center">~</td>
                                <td width="20%" align="left"><gw:datebox id="dtProTo" type="date" lang="1" onchange="ChangeCB()"/></td>
								<td  align="right">Req times</td>
                                <td width="20%" align="left"><gw:textbox id="txtreqtime" styles="width: 100%" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
              
                <tr id="_3">
                    <td  align="right"><a title="Payment method" style="color:#333">Pay. Method&nbsp;</a></td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="65%"><gw:list id="lstPayMethod" styles='width:100%'/></td>
                                <td width="15%" align="right">BCCY&nbsp;</td>
								<td width="20%" align="center"><gw:list id="lstBookccy" styles='width:100%'/></td>
                            </tr>
                        </table>
                    </td>
                </tr>
				
			   <tr id="_1">
                    <td  align="right"><a title="Click here to show Bank Account No" href="#" style="text-decoration: none" onClick="OnPopUp('Bank')">Bank Account No</a></td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="30%"><gw:textbox id="txt_BankAcc1_Cd"  text=""  styles="width:100%" /></td>
                                <td width="70%" ><gw:textbox id="txt_BankAcc1_Nm"  text=""  styles="width:100%" /></td>
							    <td ><gw:imgBtn id="btn_Reset"   img="reset"     alt="Reset" onclick="txt_BankAcc1_Cd.text='';txt_BankAcc1_Nm.text='';txt_BankAcc1_Pk.text='';" /></td>
							    <td width=""><gw:textbox id="txt_BankAcc1_Pk"  text=""  styles="width:100%;display:none" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
				<tr id="_2">
                    <td  align="right"><a title="Click here to show Bank Account No" href="#" style="text-decoration: none" onClick="OnPopUp('Bank1')">Bank Account No</a></td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="30%"><gw:textbox id="txt_BankAcc_Cd"  text=""  styles="width:100%" /></td>
                                <td width="70%" ><gw:textbox id="txt_BankAcc_Nm"  text=""  styles="width:100%" /></td>
							    <td ><gw:imgBtn id="btn_Reset"   img="reset"     alt="Reset" onclick="txt_BankAcc_Cd.text='';txt_BankAcc_Nm.text='';txt_BankAcc_Pk.text='';" /></td>
							    <td width=""><gw:textbox id="txt_BankAcc_Pk"  text=""  styles="width:100%;display:none" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="_4" >
					<td  align="right">Description&nbsp;</td>
					<td ><gw:textbox id="txtDes" styles='width:100%' onenterkey="" /></td>								
				</tr>				
				<tr id="_5" >
					<td  align="right">L.Description&nbsp;</td>
					<td ><gw:textbox id="txtLDes" styles='width:100%' onenterkey="" /></td>
				</tr>
                <tr style="background:#C5EFF1">
					<td  align="right">Request type&nbsp;</td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td width="20%"><gw:list id="lstPPDes" styles='width:100%' onchange="ChangeCB()" /></td>	
                                <td width="10%" align="right">CCY&nbsp;</td>
							    <td width="10%"><gw:list id="lstCCY" styles='width:100%' onchange="OnChangeCCY()" /></td>
							    <td width="15%" align="right">Ex. Rate&nbsp;</td>
                                <td width="15%"><gw:textbox id="txtERate" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()" /></td>
								<td width="15%" align="right">Book Rate&nbsp;</td>
								<td width="15%" align="right"><gw:textbox id="txtBRate" type="number" format="#,###,###,###,###.##R" styles='width:90%' onenterkey="OnChangeText()" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background:#C5EFF1">
					<td  align="right">Progress Amt(1)&nbsp;</td>	
                    <td colspan="">
						<table style="width: 100%; " border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtReqFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%' onenterkey="OnChangeText()"/></td>
								<td width="50%" ><gw:textbox id="txtReqAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
							</tr>
						</table>
					</td>
                </tr>
                <tr style="background:#C5EFF1">
					<td  align="right">VAT Amt(2)&nbsp;</td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtVATFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%" ><gw:textbox id="txtVATAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
							               
							</tr>
						</table>
					</td>
				</tr>						
				<tr style="background:#C5EFF1">
					<td  align="right">Retention Amt(3)&nbsp;</td>
					<td colspan="">
						<table style="width: 100% " border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtReFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%"><gw:textbox id="txtReAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
							                
							</tr>
						</table>
					</td>
				</tr>						
				<tr style="background:#C5EFF1">
					<td  align="right">Withholding Tax Amt(4)&nbsp;</td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtWithFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%" ><gw:textbox id="txtWithAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
										    
							</tr>
						</table>
					</td>
				</tr>				
				<tr style="background:#C5EFF1">
					<td  align="right">Adv Deduct Amt(5)&nbsp;</td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtAdvFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%"><gw:textbox id="txtAdvAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
										   
							</tr>
						</table>
					</td>
				</tr>		
                <tr style="background:#C5EFF1">
					<td  align="right">VAT Deduct Amt(6)&nbsp;</td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtVATDeduct_FAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%"><gw:textbox id="txtVATDeduct_AMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
										   
							</tr>
						</table>
					</td>
				</tr>						
				<tr style="background:#C5EFF1">
					<td  align="right"><a title="Total Deduct Amt.(7) = (3)+(4)+(5)+(6)" style="color:#333">Total Deduct Amt.(7)&nbsp;</a></td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtTotalDeFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%" ><gw:textbox id="txtTotalDeAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
										   
							</tr>
						</table>
					</td>
				</tr>				
				<tr style="background:#C5EFF1">
					<td  align="right"><a title="This Payment (8) = (1)+(2)-(7)" style="color:#333">This Payment(8)&nbsp;</a></td>
					<td colspan="">
						<table style="width: 100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
                                <td width="50%"><gw:textbox id="txtThisPayFAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
								<td width="50%" ><gw:textbox id="txtThisPayAMT" type="number" format="#,###,###,###,###.##R" styles='width:100%'/></td>
										    
							</tr>
						</table>
					</td>
				</tr>
                <!--tr >
					<td colspan="2" width="100%" >
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left" width="6%" colspan="" width="100%"><font size="2" color="red">Debit</font></td>
                                <td width="21%"><gw:textbox id="txtDSumTotal_T" type="number" format="###,###,###,###.#"  styles='width:100%' /></td>
                                <td width="21%"><gw:textbox id="txtDSumTotal_B" type="number" format="###,###,###,###.##R"  styles='width:100%' /></td>
                                <td width="10%" align="center">Different&nbsp;</td>
                                <td width="21%"><gw:textbox id="txtDifferent_T" type="number" format="###,###,###,###.#"  styles='width:100%' /></td>
                                <td width="21%"><gw:textbox id="txtDifferent_B" type="number" format="###,###,###,###.##R"  styles='width:100%' /></td>
                            </tr>
                        </table>
                    </td>
				</tr>
				<tr >
					<td colspan="2" width="width: 100%">
						<gw:grid id="grdDebit" 
						header="_Pk|_Acc_pk|_||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|Tmp Rate"
						format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0" 
						aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3"
						defaults="||||||VND||||||||||||" 
						editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
						widths="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000"
						styles="width:100%; height:200" 
						sorting="F"  />
					</td>
				</tr>
                <tr >
					<td colspan="2" width="100%" >
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="left" colspan="" width="6%"><font size="2" color="red">Credit</font></td>
                                <td width="21%"><gw:textbox id="txtCSumTotal_T" type="number" format="###,###,###,###.#"  styles='width:100%' /></td>
                                <td width="21%"><gw:textbox id="txtCSumTotal_B" type="number" format="###,###,###,###.##R"  styles='width:100%' /></td>
                                <td width="52%"></td>
                            </tr>
                        </table>
                    </td>
				</tr>		
				<tr >
					<td colspan="2" width="width: 100%">
						<gw:grid id="grdCredit" 
						header="_Pk|_Acc_pk|_||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|Tmp Rate"
						format="0|0|3|0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|0" 
						aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3"
						defaults="||||||VND||||||||||||" 
						editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
						widths="0|0|250|300|1000|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000"
						styles="width:100%; height:200" 
						sorting="F" />
					</td>
				</tr-->
			</table>
		</td>
	</tr>
</table>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onClick="OnToggle()" />
</body>
<gw:textbox id="txtProjectPK" 					styles="display:none"/>
<gw:textbox id="txt_tecps_undertakeschdbasc_pk" 	styles="display:none"/>
<gw:textbox id="tecps_substrp12000_pk" 			styles="display:none"/>
<gw:textbox id="txtCustomerPK" 						styles="display:none"/>
<gw:textbox id="txtAdvance" 					styles="display:none""/>
<gw:textbox id="txtWith" 				styles="display:none""/>
<gw:textbox id="txtReten" 						styles="display:none""/>
<gw:textbox id="tecps_orderingconttype_pk"" 	styles="display:none"/>
<gw:textbox id="tac_hgtrh_pk" 					styles="display:none"/>
<gw:textbox id="txtStatus" 						styles="display:none"/>
<gw:textbox id="txtAction" 						styles="display:none"/>
<gw:textbox id="txtCompanyPK" 					styles="display:none"/>
<gw:textbox id="txtActQty"						styles='display:none' />
<gw:textbox id="txtReqStatus"					styles='display:none' />

</html>
