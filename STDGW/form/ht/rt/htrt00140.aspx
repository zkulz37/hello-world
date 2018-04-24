<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("crm")%>

<script type="text/javascript" language="javascript">
function BodyInit()
{
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GTD'" )%>||"; 
	lstGTDType.SetDataText(data);
	lstGTDType.value='';
	txtBookNo.SetReadOnly(true);
	HideShowControl();
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CREDITCARD'" )%>"; 
	lstCreditType.SetDataText(data);
	var dataVenue ="DATA|03|PDR #19|04|PDR #20|05|PDR #21|06|Besta|07|Festa|08|Vista|09|Grand ballroom|11|Business Center||";
		lstVenue.SetDataText(dataVenue);
		lstVenue.value="";
	dataVenue ="DATA|01|U shape|02|Class room|03|theatre|04|Round Table|05|Other||";	
	lstSetup.SetDataText(dataVenue);
	lstSetup.value="";
	txtHotelfSlipNo.SetReadOnly(true);
	txtGolfSlipNo.SetReadOnly(true);
	txtCompanyNameS.SetReadOnly(true);
	txtCustomer.SetReadOnly(true);
	HideShowControl();
	OnNew();
	OnSearch();
}
function OnToggle()
{
    var left  = document.all("left");    
			var right = document.all("right");   
			var imgArrow = document.all("imgArrow");

			if(imgArrow.status == "expand")
			{
				left.style.display="none";       
				imgArrow.status = "collapse";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/next_orange.gif";
			}
			else
			{
				left.style.display="";
				imgArrow.status = "expand";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/prev_orange.gif";
			}
}
var flag='select';
function OnSearch()
{
	dso_htfo00240_grd_search.Call("SELECT");
}
function OnSerachMaster()
{
	flag='Not Receive';
	txtMasterPK.text = grdData.GetGridData(grdData.row, 0);
	data_htfo00240.Call('SELECT');
}
function OnNew()
{
	HideShowControl();
	data_htfo00240.StatusInsert();
}
function OnSave()
{
	if(checkValidate())
	{
		flag='update';
		data_htfo00240.Call();
	}
}
function OnDelete()
{
	if (confirm('Are you sure delete data ?'))
	{
		flag='update';
		data_htfo00240.StatusDelete();
		data_htfo00240.Call();
	}
}
function checkValidate()
{
	if (lstSetup.value == '')
	{
		alert('Please, choose Setup of conference.');
		return;
	}
	if (lstVenue.value == '')
	{
		alert('Please, choose venue.');
		return;
	}
	if (dtBookDate.value == '')
	{
		alert('Please, input Book Date.');    
		return;
	}	
	if (txtCustomer.text == '')
	{
		alert('Please, input Customer Name.');
		return;
	}
	if (txtTotalPerson.text == '')
	{
		alert('Please, input Total Person.');
		return;
	}
	if (txtFromTime.text == '')    
	{
		alert('Please, input time from.');
		return;
	}
	if (txtToTime.text == '')   
	{
		alert('Please, input time to.');
		return;
	}				
	
	if (txtContactPhone.text == '')   
	{
		alert('Please, input Contact phone.');
		return;
	}
	if (txtContactPerson.text == '')
	{
		alert('Please, input Contact Person.');
		return;
	}
	return true;
}
function OnDataReceive(obj)
{
	if(obj.id == 'data_htfo00240')
	{
		HideShowControl();
		if(flag=='update')
		{
			dso_htfo00240_grd_search.Call("SELECT");
		}
		else
		{
			HideShowControl();
		}
	}
}
function checkTime(n) 
{ 
	// regular expression to match required time format  
	// (eg. 08:50 or 8:50am)
	re = /^\d{1,2}:\d{2}([ap]m)?$/;
	switch(n)      
	{
		case 1:
			if(txtFromTime.text != '' && !txtFromTime.text.match(re)) 
			{ 
				alert("Invalid time format(format is hh:mm): " + txtFromTime.text); 
				txtFromTime.focus(); 
				txtFromTime.text = '';
				return false; 
			}
		break;
		case 2:
			if(txtToTime.text != '' && !txtToTime.text.match(re)) 
			{
				alert("Invalid time format(format is hh:mm): " + txtToTime.text); 
				txtToTime.focus(); 
				txtToTime.text = '';
				return false; 
			}
		break;
	}
}
function OnHotel_GolfConfNo(obj)
{
	if(obj=='hotel')
	{
		var path = System.RootURL + "/form/ja/bk/jabk00030_hotel_confirm_no_popup.aspx?";
				var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					txtHotelfSlipNo.text	= object[7];   
				}
	}
	if(obj=='golf')
	{
		var path = System.RootURL + "/form/ja/bk/jabk00030_golf_confirm_no_popup.aspx?";
				var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					txtGolfSlipNo.text	= object[5];
				}
	}
}
function OnPopUp(obj)
{		
	if(obj=='1')
	{
		var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
		var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
		if ( object != null )
		{
			txtCustomerPK.text  = object[0];   
			txtCustomer.text	= object[2];
		}
	}
	if(obj=='customer_s')
	{
		var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				tco_buspartner_pk_s.text  = object[0]; 
				txtCompanyNameS.text			= object[3];
				OnSearch();
			}

	}
}
function OnPrint(obj)
{
	if(obj=='conference_golf_hotel')
	{	
		if(txtMasterPK !="")
		{
			 url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00240_conference.rpt&procedure=CRM.sp_rpt_main_not_use|CRM.sp_rpt_htfo00240_hotel|CRM.sp_rpt_htfo00240_conference|CRM.sp_rpt_htfo00240_golf&parameter="+txtMasterPK.text+"|"+txtMasterPK.text+"|"+txtMasterPK.text+"|"+txtMasterPK.text;   
			 System.OpenTargetPage(url);  

		}
	}
	if(obj=='only_conference')
	{
		if(txtMasterPK !="")
		{
			var url = System.RootURL + '/reports/ht/fo/rpt_htfo00240_conference_only.aspx?p_pk='+txtMasterPK.text;
			 System.OpenTargetPage(url);
		 }
	}
}
function HideShowControl()
{
    if(lstGTDType.value == '' || lstGTDType.value == '02')
    {
       dtExpDate.value=""; 
	   txtCCV.text=""; 
	   txtCreditNo.text=""; 
	   txtCreditOwner.text="";
	   document.all("tab_credit").style.display = "none";
			
    }
    if ( lstGTDType.value == '01' )
    {       
        document.all("tab_credit").style.display = "";
        
    } 
}

</script>

<body>
    <gw:data id="dso_htfo00240_grd_search"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.sp_sel_htfo00240_grd_search">
			<input bind="grdData">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtConferrenceNameS" />
				<input bind="txtBookNoS" />
				<input bind="tco_buspartner_pk_s" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>
<!------------------------------------------------------------------>
    <gw:data id="data_htfo00240" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30" function="crm.sp_sel_htfo00240" procedure="crm.sp_upd_htfo00240">
                <inout>
                    <inout bind="txtMasterPK" />  
                    <inout bind="txtBookNo" /> 
                    <inout bind="txtRoomNo" />     
                    <inout bind="txtContactPhone" />   
                    <inout bind="dtBookDate" /> 
                    <inout bind="txtCustomerPK" />
                    <inout bind="txtTotalPerson" /> 
                    <inout bind="txtFromTime" />                 
                    <inout bind="txtToTime" />                    
                    <inout bind="txtContactPerson" />  
                    <inout bind="txtConferrenceName" />
                    <inout bind="txtTotalAmt" />
                    <inout bind="txtEmail" />                    
                    <inout bind="txtSVECharge" />  
                    <inout bind="txtVAT" />
                    <inout bind="lstGTDType" />
                    <inout bind="lstCreditType" />
                    <inout bind="dtExpDate" />     
                    <inout bind="txtCCV" />      
                    <inout bind="txtCreditNo" />
					<inout bind="txtCreditOwner" />  					
                    <inout bind="txtCashDeposit" /> 
					<inout bind="txtTotalDue" />
					<inout bind="txtDescription" /> 
					<inout bind="txtCreateBy" /> 
					<inout bind="txtCreateDate" /> 
					<inout bind="lstVenue" /> 
					<inout bind="lstSetup" /> 
					<inout bind="txtHotelfSlipNo" /> 
					<inout bind="txtGolfSlipNo" />
					<inout bind="txtCustomer" /> 
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="height: 100%; width: 100%;" border="1">
        <tr style="height: 100%;" valign="top">
            <td style="width: 35%" id="left">
                <table style="height: 100%; width: 100%;">
                    <tr valign="top" style="height: 2%">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 33%">
                                        &nbsp;&nbsp;&nbsp;Date</td>
                                    <td style="width: 64%">
                                        <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()" />
                                        ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch()" alt="Search" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top" style="height: 2%">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 30%">
                                        Conferrence Name</td>
                                    <td style="width: 70%">
                                        <gw:textbox id="txtConferrenceNameS" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top" style="height: 2%">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 30%">
                                        Book No</td>
                                    <td style="width: 70%">
                                        <gw:textbox id="txtBookNoS" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
                        <td colspan=3>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 32%">
                                        <a href="#" onclick="OnPopUp('customer_s')">Company</a></td> 
                                    <td style="width: 65%; white-space: nowrap">
                                        <gw:textbox id="txtCompanyNameS" styles="width:100%" readonly="true" />
                                    </td>
									<td style="width: 3%"><gw:imgbtn id="btnClearCompanyS" img="reset" alt="Reset" onclick="txtCompanyNameS.text='';tco_buspartner_pk_s.text='';" /></td>
                                </tr>
								</table>
                        </td>
                    </tr>

                    <tr style="height: 94%" valign="top">
                        <td colspan="3">
                            <gw:grid id="grdData" header="_PK|Book Date|Customer|Contact Phone" format="0|4|0|0"
                                aligns="0|0|0|0" defaults="|||" editcol="0|0|0|0" widths="0|2000|2000|15000"
                                styles="width:100%;height:100%" autosize='T' oncellclick="OnSerachMaster()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 65%" id="right">
                <table style="height: 100%; width: 100%;">
					<tr valign="top" style="height: 2%">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 85%">
                                    </td>
									<td style="width: 3%">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnNew()" styles="display: none" />
                                    </td>		
                                    <td style="width: 3%">
										<gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" styles="display: none" />
									</td>
									<td style="width: 3%">
										<gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" styles="display: none" /> 
									</td>
									<td style="width: 3%" align="right">
									<gw:imgbtn img="excel" alt="Only Conference" text="Print" id="btnReport" onclick="OnPrint('only_conference')"/>
									</td>
									<td style="width: 3%">
										<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint('conference_golf_hotel')" />
									</td> 	
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 8%">
                                        Book No</td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtBookNo" styles="width: 100%" csstype="mandatory" />
                                    </td>
                                    <td style="width: 12%" align="center">
										<b style="color: Red">*</b>Setup
                                    </td>
                                    <td style="width: 25%">
                                       <gw:list id="lstSetup" styles="width:100%;" />
                                    </td>
                                    <td style="width: 15%">
                                        <b style="color: Red">*</b>Venue</td>
                                    <td style="width: 20%">
                                       <gw:list id="lstVenue" styles="width:100%;" />   
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr valign="top">
                                    <td style="width: 10%">
                                        <b style="color: Red">*</b>Book Date</td>
                                    <td style="width: 20%">
                                        <gw:datebox id="dtBookDate" lang="1" styles="width:100%" nullaccept="T" />
                                    </td>
                                    <td style="width: 10%">
                                        Confer.Name</td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtConferrenceName" />
                                    </td>
                                    <td style="width: 20%">
                                        <b style="color: Red">*</b>Total Person</td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtTotalPerson" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr>
                                    <td style="width: 10%">
                                        <b style="color: Red">*</b>From Time</td>
                                    <td style="width: 17%">
                                        <gw:textbox id="txtFromTime" styles="text-align:center;width:100%;" onchange='checkTime(1)' />
                                    </td>
                                    <td align="center" style="width: 14%">
                                        <b style="color: Red">*</b>To Time</td>
                                    <td style="width: 17%">
                                        <gw:textbox id="txtToTime" styles="text-align:center;width:100%;" onchange='checkTime(2)' /> 
                                    </td>
                                    <td style="width: 22%">
                                        <b style="color: Red">*</b>Contact Phone</td>
                                    <td style="width: 20%">
                                       <gw:textbox id="txtContactPhone" /> 
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr>
                                    <td style="width: 10%">
                                        <b style="color: Red">*</b><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('1')">Customer</b></td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtCustomer" />
                                    </td>
                                    <td style="width: 20%">
                                       <b style="color: Red">*</b>Contact Person </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtContactPerson" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr>
                                    <td style="width: 10%">
                                        Email</td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtEmail" />
                                    </td>
                                    <td style="width: 20%">
                                       Total Amt</td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTotalAmt" type="number" format="###,###,###" styles="text-align:right;" /> 
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr>
                                    <td style="width: 10%">
										Create By:
                                        </td>
                                    <td style="width: 15%">
                                        <gw:label id="txtCreateBy" />
                                    </td>
									<td style="width: 12%">
                                     Create Date:   
                                    </td>
									<td style="width: 23%">
                                      <gw:label id="txtCreateDate" /> 
                                    </td>
                                    <td style="width: 20%">
                                         SVE Charge(5%)</td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtSVECharge" type="number" format="###,###,###" styles="text-align:right;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr>
                                    <td style="width: 10%">
                                        GTD Type</td>
                                    <td style="width: 50%">
                                        <gw:list id="lstGTDType" text="" styles='width:100%' onchange="HideShowControl()" />
                                    </td>
                                    <td style="width: 20%">
                                        VAT(10%)</td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtVAT" type="number" format="###,###,###" styles="text-align:right;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					
                    
					<tr id="tab_credit">
					<td >
						<fieldset style="padding: 5">
							<table style="width: 100%; height: 100%" >
								<tr>
									<td style="width: 5%; white-space: nowrap" align="right">
										Credit Type
									</td>
									<td style="width: 20%">
										<gw:list id="lstCreditType" text="" styles='width:100%' />
									</td>
									<td style="width: 5%; white-space: nowrap"> 
										Exp.Date
									</td>
									<td style="width: 20%">
										<gw:datebox id="dtExpDate" lang="1" styles="width:100%" nullaccept="T" />
									</td>
									<td style="width: 5%; white-space: nowrap" align="right">
										Credit CCV
									</td>
									<td style="width: 20%">
										<gw:textbox id="txtCCV" styles="text-align:left;width:120;" />
									</td>
								</tr>
								<tr>
									<td style="width: 5%">
										Card No
									</td>
									<td style="width: 20%">
										<gw:textbox id="txtCreditNo" styles="text-align:left;width:100%;" onenterkey="OnEnterEvent(this)" />
									</td>
									<td style="width: 5%; white-space: nowrap" align="right">
										Credit Owner
									</td>
									<td style="width: 20%">
										<gw:textbox id="txtCreditOwner" styles="width: 100%" />
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr style="height: 2%;" valign="top">
					<td>
						<table style="height: 100%; width: 100%;">
							<tr>
								<td style="width: 10%">
									Cash Deposit</td>
								<td style="width: 40%">
									<gw:textbox id="txtCashDeposit" type="number" format="###,###,###" styles="text-align:right;" />
								</td>
								<td style="width: 10%">
									Total Due</td>
								<td style="width: 40%">
									<gw:textbox id="txtTotalDue" type="number" format="###,###,###" styles="text-align:right;" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
					<tr style="height: 2%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;"> 
                                <tr>
                                    <td style="width: 10%">
                                        <a href="#" onclick="OnHotel_GolfConfNo('hotel')">Hotel.Slip#</a></td>
                                    <td style="width: 17%">
                                        <gw:textbox id="txtHotelfSlipNo" csstype="mandatory" styles="width: 100%"/>
                                    </td>
									<td style="width: 2%"><gw:imgbtn id="btnClearHT" img="reset" alt="Reset" onclick="txtHotelfSlipNo.text='';" /></td>	
                                    <td align="center" style="width: 10%">
                                        <a href="#" onclick="OnHotel_GolfConfNo('golf')">Golf.Slip#</a></td>
                                    <td style="width: 17%">
                                        <gw:textbox id="txtGolfSlipNo" styles="width: 100%" csstype="mandatory" />
                                    </td>
									<td style="width: 2%"><gw:imgbtn id="btnClearGolf" img="reset" alt="Reset" onclick="txtGolfSlipNo.text='';" /></td>	
                                    <td style="width: 22%">
                                        </td>
                                    <td style="width: 20%">
                                      
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 5%;" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%;">
                                <tr style="height: 2%">
                                    <td style="width: 100%">
                                        Description
                                    </td>
                                </tr>
                                <tr style="height: 98%">
                                    <td style="width: 100%">
                                        <gw:textarea id="txtDescription" rows="4" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 66%;" valign="top">
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</body>
<gw:textbox id="txtCustomerPK" style="display: none" />
<gw:textbox id="txtMasterPK" style="display: none" />
<gw:textbox id="txtRoomNo" style="display: none" /> 
<gw:textbox id="tco_buspartner_pk_s" styles="display: none" />

</html>
