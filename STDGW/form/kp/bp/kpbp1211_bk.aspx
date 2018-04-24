﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>1.2.11 AR Confirm</title>
</head>
<%ESysLib.SetUser("EC111")%>

<script type="text/javascript">
function BodyInit()
{
	System.Translate(document);
    BindingDataList() ;
}
//-------------------------------------------------------------------------
function BindingDataList() 
{
    var data="<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
    lstCompany.SetDataText(data);
}
//--------------------------------------------------------------------------
function OnToggle() 
{
    var left = document.all("left");
    var right = document.all("right");
    var imgArrow = document.all("imgArrow");

    if (imgArrow.status == "expand") 
    {
        left.style.display = "none";
        imgArrow.status = "collapse";
        right.style.width = "100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else 
    {
        left.style.display = "";
        imgArrow.status = "expand";
        right.style.width = "75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}	
//----------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var obj = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( obj != null )
		    {
			    txtProject_Pk.text = obj[0];
                txtProject_Cd.text = obj[1];
                txtProject_Nm.text = obj[2];
                txtProject_M.text = obj[1];
//                txttac_abplcenter_pk.text 		= obj[8];
//                dso_get_customer_105.Call();
		    }
	    break;
        case 'Customer1':
            var path = System.RootURL + '/form/kp/bp/kpbp128_popup_Customer.aspx?Project_Pk=' + txtProject_Pk.text;
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
				txtCustomer1_Nm.SetDataText(obj[2]);//customer name
				txtCustomer1_Pk.SetDataText(obj[0]);//customer name
				txtCustomer1_Cd.SetDataText(obj[1]);
//                dso_get_AccountNo_auto.Call(); 
            }
        break;   
        case 'Customer3':
            var path = System.RootURL + '/form/kp/bp/kpbp128_popup_Customer.aspx?Project_Pk=' + txtProject_Pk.text;
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
				txtCustomer3_Nm.SetDataText(obj[2]);//customer name
				txtCustomer3_Pk.SetDataText(obj[0]);//customer name
				txtCustomer3_Cd.SetDataText(obj[1]);
//                dso_get_AccountNo_auto.Call(); 
            }
        break;   
        case 'Customer2':
            var path = System.RootURL + '/form/kp/bp/kpbp128_popup_Customer.aspx?Project_Pk=' + txtProject_Pk.text;
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
				txtCustomer2_Nm.SetDataText(obj[2]);//customer name
				txtCustomer2_Pk.SetDataText(obj[0]);//customer name
				txtCustomer2_Cd.SetDataText(obj[1]);
//                dso_get_AccountNo_auto.Call(); 
            }
        break;   
        case 'Contract':
				var path = System.RootURL + '/form/kp/bp/kpbp128_popup_AccCont.aspx?TAC_ABPL_pk=' + txtProject_Pk.text;
				var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					txtContract.SetDataText(obj[1]);
					txtContract_Pk.SetDataText(obj[0]);
				}
		break;
		case 'MCrequest':
			var path = System.RootURL + '/form/kp/bp/kpbp1210_1.aspx';
				var obj = System.OpenModal( path ,1000 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					txttecps_mctrequestPK.SetDataText(obj[0]);
					dso_upd_1211_1.Call();
				}
		break;
    }
}
//--------------------------------------------------------------------------------
</script>

<body>
<!------------1-------------------------------------------------------------------------->
<gw:data id="dso_upd_1211_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0" function="ec111.sp_sel_kpbp1211" >
                <input>
                     <inout bind="txttecps_mctrequestPK"  />
                     <inout bind="txtProject_Pk"  />
                     <inout bind="txtProject_Cd"  />
                     <inout bind="txtProject_Nm"  />
					 <inout bind="txtContract_Pk"  />
                     <inout bind="txtContract"  />  
                     <inout bind="txtCustomer_Pk_AR"  />
					 <inout bind="txtCustomer_Cd_AR"  />
                     <inout bind="txtCustomer_Nm_AR"  />  
					 <inout bind="txtCustomer_Pk_to"  />
					 <inout bind="txtCustomer_Cd_to"  />
                     <inout bind="txtCustomer_Nm_to"  />
					 <inout bind="txtCustomer_Pk_im"  />
					 <inout bind="txtCustomer_Cd_im"  />
                     <inout bind="txtCustomer_Nm_im"  />
                     <inout bind="txtTransType_Pk"  />
					 <inout bind="txtTransType_Cd"  />
                     <inout bind="txtTransType_Nm"  />
					 <inout bind="txtDescription"  />
                     <inout bind="txtLocal_Description"  />
					 <inout bind="txtEnclose"  />
                     <inout bind="lstOrder_Ccy"  />
					 <inout bind="txtOrder_ExRate"  />
					 <inout bind="lstInvoice_Ccy"  />
					 <inout bind="txtInvoice_ExRate"  />
					 <inout bind="lstBook_Ccy"  />
					 <inout bind="lblBook_Rate"  />
					 <inout bind="txtAmount_ord"  />
					 <inout bind="txtAmount_inv"  />
					 <inout bind="txtAmount_bk"  />
					 <inout bind="dtTrans_Date"  />
					 <inout bind="txtVoucher_No"  />
					 <inout bind="txtStatus"  />
					 <inout bind="txtSeq"  />
					 <inout bind="txtSerial_No"  />
					 <inout bind="txtInvoice_No"  />
					 <inout bind="dtInvoice_Date"  />
					 <inout bind="dtDue_Date"  />
                </input>
            </dso>
        </xml>
    </gw:data>
<!--------------------------------------------------------------------------------->
   <table style="width:100%;height:100%;background:#BDE9FF" >
   		<tr height="100%">
        	<td id="left" width="25%" style="background:white" valign="top">
            	<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
                	<tr height="6%">
                    	<td>
                        	<fieldset style="padding:0">
                                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                         <tr style="height:">
                                                <td style="width: 10%" align="right">Date&nbsp;</td>
                                                <td style="width: 90%"><gw:datebox id="dtFrom" lang="1" onchange="OnSearch('grid_master')" />~<gw:datebox id="dtTo" onchange="OnSearch('grid_master')" lang="1" /></td>
                                                <td width=""><gw:imgbtn id="ibtnUpdte1" img="search" alt="Search" onclick="OnSearch('grid_master')" /></td>
                                            </tr>
                                            <tr style="height: " >
                                                <td style="width: 10%" align="right">Project&nbsp;</td>
                                                <td colspan="2"><gw:textbox id="txtProject_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                            </tr>
                                            <tr style="height: " >
                                                <td style="width: 10%" align="right">Customer&nbsp;</td>
                                                <td colspan="2"><gw:textbox id="txtCustomer_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                            </tr>
                                            <tr style="height: " >
                                                <td align="right">Seq&nbsp;</td>
                                                <td colspan="2"><gw:textbox id="txtSeq_M" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                            </tr>
                                </table>
                          </fieldset>  
                        </td>
                    </tr>
                    <tr height="94%">
                        <td colspan="">
                            <gw:grid id='grdMaster' 
                            header='_PK|Seq|Amount|CCY' 
                            format='0|0|0|0'
                            aligns='0|1|3|1' 
                            check='|||' 
                            editcol='0|0|0|0' 
                            widths='0|1200|1500|1500' 
                            sorting='T'
                            styles='width:100%; height:100%' oncellclick="OnSearch('control')" />
                        </td>
                    </tr>
                </table>
            </td>
        	<td id="right" width="75%" valign="top" style="background:white">
            	<table cellpadding="0" cellspacing="0"  style="width:100%;height:" border="0">
                        <tr style="background:#C5EFF1;height:">
                            <td width="80%" colspan="">
                                <table cellpadding="0" cellspacing="0" width="100%" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:" border="1">
                                    <tr>
                                            <td align="right" width="30%">Company&nbsp;</td>
                                            <td width="70%"><gw:list id="lstCompany" onchange="" styles='width:100%'  /></td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="" width="20%">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
									     <td width="60%"></td>
									    <td width="10%"><gw:imgbtn id="btnpopup" img="popup" alt="Get main contract request" onclick="OnPopUp('MCrequest')" /></td>
                                        <td width="10%"><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave('Master')" /></td>
                                        <td width="10%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" onclick="OnConfirm()" /></td>
                                        <td width="10"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" /></td>
                                        <td width="1%"><gw:imgbtn id="btnb" img="excel" alt="Print Out Accounting Slip" onclick="OnPrint('Accounting')" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="" colspan="" valign="top">
                                <table cellpadding="1" cellspacing="0" width="100%" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:" border="1">
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right" width="30%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project&nbsp;</a></td>
                                            <td width="70%" colspan="">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="30%"><gw:textbox id="txtProject_Cd" csstype="mandatory" readonly="true" styles='width:100%' /></td>
                                                        <td width="70%"><gw:textbox id="txtProject_Nm" csstype="mandatory" readonly="true" styles='width:100%' /></td>
                                                        <td width=""><gw:textbox id="txtProject_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                                        <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right" ><a href="#" title="Click here to show Contract" style="text-decoration: none" onClick="OnPopUp('Contract')">Contract&nbsp;</a></td>
                                            <td colspan="">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="100%"><gw:textbox id="txtContract" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width=""><gw:textbox id="txtContract_Pk" styles='width:0%;display:none' /></td>
                                                        <td><gw:imgbtn id="btnonfim" img="reset" alt="Reset" onclick="txtContract.text='';txtContract_Pk.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right" ><a href="#" title="Click here to show Customer" style="text-decoration: none" onClick="OnPopUp('Customer1')">Customer(AR)&nbsp;</a></td>
                                            <td colspan="">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="30%"><gw:textbox id="txtCustomer_Cd_AR" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width="70%" ><gw:textbox id="txtCustomer_Nm_AR" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width=""><gw:textbox id="txtCustomer_Pk_AR" styles='width:0%;display:none' /></td>
                                                        <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtCustomer_Cd_AR.text='';txtCustomer_Nm_AR.text='';txtCustomer_Pk_AR.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td> 
                                        </tr>
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right" ><a href="#" title="Click here to show Customer" style="text-decoration: none" onClick="OnPopUp('Customer2')">Customer(T/O)&nbsp;</a></td>
                                            <td colspan="">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="30%"><gw:textbox id="txtCustomer_Cd_to" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width="70%" ><gw:textbox id="txtCustomer_Nm_to" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width=""><gw:textbox id="txtCustomer_Pk_to" styles='width:0%;display:none' /></td>
                                                        <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtCustomer_Cd_to.text='';txtCustomer_Nm_to.text='';txtCustomer_Pk_to.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td> 
                                        </tr>
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right" ><a href="#" title="Click here to show Customer" style="text-decoration: none" onClick="OnPopUp('Customer3')">Importer&nbsp;</a></td>
                                            <td colspan="">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="30%"><gw:textbox id="txtCustomer_Cd_im" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width="70%" ><gw:textbox id="txtCustomer_Nm_im" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                                        <td width=""><gw:textbox id="txtCustomer_Pk_im" styles='width:0%;display:none' /></td>
                                                        <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtCustomer_Cd_im.text='';txtCustomer_Nm_im.text='';txtCustomer_Pk_im.text='';" /></td>
                                                    </tr>
                                                </table>
                                            </td> 
                                        </tr>
                                        <tr style="background:#C5EFF1;height:">
                        <td align="right" ><a href="#" title="Click here to show Transaction Type" style="text-decoration: none" onClick="OnPopUp('TransType')">Trans.Type&nbsp;</a></td>
                        <td colspan="">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td width="30%"><gw:textbox id="txtTransType_Cd" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                    <td width="70%" ><gw:textbox id="txtTransType_Nm" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                    <td width=""><gw:textbox id="txtTransType_Pk" styles='width:0%;display:none' /></td>
                                    <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtTransType_Cd.text='';txtTransType.text='';txtTransType_Pk.text='';" /></td>
                                </tr>
                            </table>
                        </td> 
                        
                    </tr>
                                        <tr style="background:#C5EFF1;height:">
                        <td align="right"><a title="Description" style="color:#333">Description&nbsp;</a></td>
                        <td colspan=""><gw:textbox id="txtDescription" styles='width:100%' /></td>
                       
                    </tr>
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right"><a title="Local Description" style="color:#333">L. Description&nbsp;</a></td>
                                            <td colspan=""><gw:textbox id="txtLocal_Description" styles='width:100%' /></td>
                                        </tr>
                                        <tr style="background:#C5EFF1;height:">
                                            <td align="right">Enclose&nbsp;</td>
                                            <td colspan=""><gw:textbox id="txtEnclose" styles='width:100%' /></td>
                                        </tr>    
                                </table>
                            </td>
                            <td width="" valign="top">
                                <table cellpadding="0" cellspacing="0" width="100%" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:100%" border="1">
                                    <tr>
                                        <td valign="top" style="background:#C5EFF1">
                                            <fieldset style="padding:0"><legend><font style="color:Blue">Slip Info</font></legend>
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Trans.Date&nbsp;</td>
                                                        <td colspan=""><gw:datebox id="dtTrans_Date" lang="1"  /></td>
                                                    </tr>
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Voucher No&nbsp;</td>
                                                        <td colspan=""><gw:textbox id="txtVoucher_No" styles='width:100%' /></td>
                                                    </tr>  
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Status&nbsp;</td>
                                                        <td colspan=""><gw:textbox id="txtStatus" styles='width:100%' /></td>
                                                    </tr>  
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Seq&nbsp;</td>
                                                        <td colspan=""><gw:textbox id="txtSeq" styles='width:100%' /></td>
                                                    </tr>    
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="background:#C5EFF1">
                                            <fieldset style="padding:0"><legend><font style="color:Blue">Invoice Info</font></legend>
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Serial No&nbsp;</td>
                                                        <td colspan=""><gw:textbox id="txtSerial_No" styles='width:100%' /></td>
                                                    </tr>  
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Inv. No&nbsp;</td>
                                                        <td colspan=""><gw:textbox id="txtInvoice_No" styles='width:100%' /></td>
                                                    </tr>  
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Inv. Date&nbsp;</td>
                                                        <td colspan=""><gw:datebox id="dtInvoice_Date" lang="1"  /></td>
                                                    </tr>
                                                    <tr style="background:#C5EFF1;height:">
                                                        <td align="right">Due. Date&nbsp;</td>
                                                        <td colspan=""><gw:datebox id="dtDue_Date" lang="1"  /></td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                    </tr>
                        <tr style="height:">
                                <td colspan="2">
                                    <table cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse:collapse;width:100%;height:100%" border="1">
                                        <tr style="background:#C5EFF1;height:20">
                                            <td width="19%"></td>
                                            <td align="center" width="27%" style="">
                                                <table cellpadding="0" cellspacing="0" >
                            	                    <tr>
                                                        <td width="" style="white-space:nowrap"><a title="Click here to show Order Currency" href="#" style="text-decoration: none" onClick="OnPopUp('currency')">Order CCY&nbsp;</a></td>
                                                        <td width="38%"><gw:list id="lstOrder_Ccy" onchange="dso_get_rate_Order.Call();" styles='width:100%'  /></td>
                                                        <td width="2%"></td>
                                                        <td width="60%"><gw:textbox id="txtOrder_ExRate" styles='width:100%' type="number"  format="###,###.#" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" width="27%">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                            	                    <tr>
                                                        <td width="" style="white-space:nowrap"><a title="Click here to show Invoice Currency" href="#" style="text-decoration: none" onClick="OnPopUp('Invoice')">Inv. CCY&nbsp;</a></td>
                                                        <td width="38%"><gw:list id="lstInvoice_Ccy" onchange="dso_get_rate_Invoice.Call();" styles='width:100%'  /></td>
                                                        <td width="2%"></td>
                                                        <td width="60%"><gw:textbox id="txtInvoice_ExRate" type="number"  format="###,###.#" styles='width:100%;text-align:right'  /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td align="center" width="27%">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                            	                    <tr>
                                                        <td width="" style="white-space:nowrap"><a title="Click here to show Book Currency" href="#" style="text-decoration: none" onClick="OnPopUp('BCCY')">BCCY&nbsp;</a></td>
                                                        <td width="38%"><gw:list id="lstBook_Ccy" onchange="dso_get_rate_book.Call();" styles='width:100%'  /></td>
                                                        <td width="2%"></td>
                                                        <td width="60%"><gw:textbox id="lblBook_Rate" type="number"  format="###,###.#" styles='width:100%;text-align:right'  /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                    </tr>
                                        <tr style="background:#C5EFF1;height:2%">
                                        <td align="right">Amount&nbsp;</td>
                                        <td width=""><gw:textbox id="txtAmount_ord" type="number" onenterkey="" onblur="" format="###,###.#"  styles='width:100%' /></td>
                        			    <td width=""><gw:textbox id="txtAmount_inv" type="number" onenterkey="OnCalc_Control()" onblur="OnCalc_Control()" format="###,###.#R"  styles='width:100%' /></td>
                                        <td width=""><gw:textbox id="txtAmount_bk" type="number" onenterkey="OnCalc_Control()" onblur="OnCalc_Control()" format="###,###.##R"  styles='width:100%' /></td>
                                    </tr>
                                    </table>
                                </td>
                        </tr>
                        <tr id="_5" style="height:">
					<td colspan="4" width="100%" >
						<table border="1" width="100%" cellpadding=0 cellspacing=0 bordercolor="#00FFFF">
							<tr>
								<td width="60%" valign=top id="tdGrid">
								  <table border="0" width="100%" cellpadding=0 cellspacing=0>
									<tr>
										<td width="5%" align="center">
                                                    <a onclick="OnSumDR()" href="#tips">Debit</a></td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_dr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_dr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="10%" align="center">
                                                    Total</td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_dr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_dr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnNew_Dr" img="new" alt="New" styles="width:100%;display:none" onclick="OnNewDr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_dr" img="save" alt="Save" onclick="OnSave('Dr')" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Dr" img="delete" styles="width:100%;display:none" alt="Delete" onclick="OnDelDr()" />
                                                </td>
                                               
                                                <td width="3%">
                                                </td>
									</tr>
									<tr >
									   <!--0_Pk|1_Acc_pk|2check|3 type ref|4.Acc.Code|5.Acc.Name|6.Ccy|7.Rate|8.Amount Trans|9.mount Book|10.Description|11.Local Description|12_Expense Type|13_m_pk|14_ODR|15_DRCR|16_ChkTreat|17.Book Rate|18Tmp Rate|19_bookccy|20_tco_buspartner_pk|21_tac_abplcenter_pk|22_BUS_ID|23_BUS_NM-->
										<td colspan="10" width="width: 100%">
											<gw:grid id="grdDebit" 
											header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|_Tmp Rate|_bookccy|_tco_buspartner_pk|_tac_abplcenter_pk|_BUS_ID|_BUS_NM"
											format="0|0|3|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
											aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3|0|0|0|0|0"
											defaults="||||||VND||||||||||||||||0|0" 
											editcol="1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
											widths="0|0|250|300|1500|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000|0|0|0|0|0"
											styles="width:100%; height:200" 
											sorting="F"  
											oncelldblclick="OnPopUp('Edit_Dr')" 
											oncellclick="RowClick_DR()"
											/>
										</td>
									</tr>
									<tr>
										 <td width="5%" align="center">
                                                    <b><a onclick="OnSumCR()" href="#tips">Credit</a></td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_cr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_chk_cr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##.##R" />
                                                </td>
                                                <td width="10%" align="center">
                                                    Total</td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_cr_famt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="15%">
                                                    <gw:textbox id="txtsum_total_cr_amt" styles="width:100%" type="number" format="#,###,###,###,###.##R" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnNew_Cr" img="New" styles="width:100%;display:none" alt="New credit" onclick="OnNewCr()" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnSave_cr" img="save" alt="Save" onclick="OnSave('Cr')" />
                                                </td>
                                                <td width="3%" align="right">
                                                    <gw:imgbtn id="btnDel_Cr" img="delete" styles="width:100%;display:none"  alt="Delete" onclick="OnDelCr()" />
                                                </td>
                                               
                                            
                                                <td width="3%" align="right">
                                                    <img status="expand" id="img1" src="../../../system/images/next_orange.gif"
                                                        style="cursor: hand;" onclick="OnToggle_dtl()" /></img></td>
									</tr>
									<tr >
									<td colspan="10" width="width: 100%">
										<gw:grid id="grdCredit" 
										header="_Pk|_Acc_pk|||Acc.Code|Acc.Name|Ccy|Rate|Amount Trans|Amount Book|Description|Local Description|_Expense Type|_m_pk|_ODR|_DRCR|_ChkTreat|Book Rate|_Tmp Rate|_bookccy|_tco_buspartner_pk|_tac_abplcenter_pk|_BUS_ID|_BUS_NM"
										format="0|0|3|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										aligns="0|0|1|1|1|0|1|1|3|3|0|0|0|0|0|0|0|0|3|0|0|0|0|0"
										defaults="||||||VND|||||||||||||0|0|0|0|0" 
										editcol="1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
										widths="0|0|250|300|1500|2000|700|1000|1800|1800|3000|2500|1000|1000|1000|800|0|1000|1000|0|0|0|0|0"
										styles="width:100%; height:200" 
										sorting="F"
										oncelldblclick="OnPopUp('Edit_Cr')" 
										oncellclick="RowClick_CR()"
										/>
									</td>
								</tr>

								</table>
								
								</td>
								
								<td width="40%"  id="tdControlItem" style="height:100%" valign="top" >
									<table border="0" style="height:100%" width="100%" cellpadding=0 cellspacing=0>
										<tr height="2%">
										  <td width="100%" align="left"> Control Item</                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              