
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<% ESysLib.SetUser("comm")%>
<script language="javascript" type="text/javascript" >
    function BodyInit()
     {       
        System.Translate(document);  // Translate to language session
        
        dat_epac00010_1.StatusInsert();
        BindingDataList();  
        txtOrderPK.text="<%=request.QueryString("order_pk") %>";
        txtOrderNo.text="<%=request.QueryString("order_no") %>";
        dtOrderDate.value="<%=request.QueryString("order_date") %>";
        dat_epac00010_1.Call('SELECT');
        txtCom_pk.text= "<%=request.QueryString("Com_pk") %>";
     }
//-----------------------------------------------------------------------------------
     function BindingDataList()
     {   
         
         var data2 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT INITCAP(comm.F_COMMONCODE('ACCR0020','','')) FROM DUAL")%>";  //trade term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0140','','') FROM DUAL")%>";  // payment method
                  
         cboPaymentTermS.SetDataText(data3);        
         cboPaymentTerm.SetDataText(data3);   
         cboCurrencyS.SetDataText(data2); 
         cboPaymentMethod.SetDataText(data4);      
     }
     //---------------------------------------------------------------------------------------
    function openPopup(index)
    {
         var fpath = '';
	    switch(index)
	    {          
	        case 1:// Ship to 
	            var desc;
	            if (radShipType.value=='b')
	            {
	                var fpath = System.RootURL + "/form/ep/hd/PopUpGetCustoms.aspx?"; //customs
                    aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	                if ( aValue != null )
	                {          
	                    desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                    txtShipName.SetDataText(aValue[2]); 
	                    txtShipCode.SetDataText(aValue[0]);  
	                    txtShipPK.SetDataText(aValue[0]);  
	                    txtShipAdd.SetDataText(desc);
	                }
	            }	
	        break;
	        case 2:// Paid to   
	            var desc;
	            var fpath = System.RootURL + "/form/ep/hd/PopUpGetCustoms.aspx?partner_type=90"; //customs
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                txtPaidName.SetDataText(aValue[2]); 
	                txtPaidCode.SetDataText(aValue[0]);  
	                txtPaidPK.SetDataText(aValue[0]);  
	                txtPaidAdd.SetDataText(desc);
	            }	
	        break;
	    }
	}
	//---------------------------------------------------------------------------------
	function onSave()
	{
	    dat_epac00010_1.Call('');
	}
	//----------------------------------------------------------------------------------
	function OnDataReceive(obj)
	{
	
	}
	//--------------------------------------------------------------
    function onChangeShipType()
    {
        if (radShipType.value=='a')
            dat_epac00010_8.Call('SELECT');
    }
</script>
<body>
    <!------------------------Update Order detail -------------------------------------->
<gw:data id="dat_epac00010_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,5,6,7,8,9,10,11,12,15,16,17,18,19,20,21,22,23" function="imex.sp_sel_tim_order_ship_paid"  procedure="imex.sp_upd_tim_order_ship_paid"> 
            <inout>     
                 <inout  bind="txtOrderPK" /> 
                 <inout  bind="radShipType" />
                 <inout  bind="txtShipPK" /> 
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipName" />    
                 <inout  bind="txtShipAdd" />
                 <inout  bind="txtTransport" /> 
                 <inout  bind="dtShipDate" />   
                 <inout  bind="txtPLCofLoading" /> 
                 <inout  bind="txtPLCofDischarge" />
                 <inout  bind="cboPaymentTermS" />    
                 <inout  bind="radPayType" />          
                 <inout  bind="txtPaidPK" />
                 <inout  bind="txtPaidCode" />
                 <inout  bind="txtPaidName" /> 
                 <inout  bind="txtPaidAdd" />               
                 <inout  bind="cboPaymentMethod" /> 	
                 <inout  bind="cboCurrencyS" /> 
                 <inout  bind="cboPaymentTerm" />
                 <inout  bind="txtDiscount" />
                 <inout  bind="txtLocation" />
                 <inout  bind="txtAccountBank" />
                 <inout  bind="txtExRateS" />
                 <inout  bind="txtDesc" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------Get Company Info -------------------------------------->
<gw:data id="dat_epac00010_8"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,43" function="imex.sp_sel_get_CompanyInfo"  > 
            <inout>     
                 <inout  bind="txtCom_pk" />
                 <inout  bind="txtShipName" />
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipPK" />
                 <inout  bind="txtShipAdd" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
    <form id="form1" runat="server">
        <table id="Shipment/Payment" name="Shipment/Payment" cellpadding=0 cellspacing=0 width="100%">
            <tr>
                <td colspan=3>
                    <table width='100%' cellpadding=0 cellspacing=0 >
                        <tr> 
                            <td width="10%" align="right">Order No</td>
                            <td width="20%"><gw:textbox id="txtOrderNo"   styles="width:100%;" /></td>
                            <td width="10%" align="right">Order Date</td>
                            <td width="20%"><gw:datebox id="dtOrderDate" lang="1" onchange=""  styles="width:100%;" /></td>
                            <td width="40%"></td>
                        </tr>
                    </table>
                </td>                
            </tr>
            <tr>
                <td colspan="3" >
                    <table cellpadding=0 cellspacing=0 width="100%">
                        <tr>
                            <td wisth="98%">&nbsp;</td>
                            <td width="2%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="45%">
                    <table width="100%" border=0 cellpadding=0 cellspacing=0>
                        <tr>
                            <td colspan="3">
                                <gw:radio id="radShipType" value="a" styles="width:100%" onchange="onChangeShipType();"> 
                                    <span value="a">Us/Customer </span> 
                                    <span value="b">Consignee</span> 
                                </gw:radio>
                            </td>
                            <td> </td>
                        </tr>
                        <tr> 
                            <td width="30%"><a title="Click here to select" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF">Ship To</a></td>
                            <td width="10%"><gw:textbox id="txtShipCode"   styles="width:100%;" /><gw:textbox id="txtShipPK"   styles="display:none" /></td>
                            <td colspan="2" width="10%"><gw:textbox id="txtShipName"   styles="width:100%;" /></td>
                        </tr>
                        <tr> 
                            <td>&nbsp;</td>
                            <td colspan="3"><gw:textarea id="txtShipAdd" styles="width:100%;" /></td>
                        </tr>
                        <tr>
                            <td>Transportation By</td>
                            <td colspan="2"><gw:textbox id="txtTransport"   styles="width:100%;" /></td>
                            <td width="20%"> </td>
                        </tr>
                        <tr>
                            <td>Shipment Date</td>
                            <td><gw:datebox id="dtShipDate" lang="1" onchange=""  styles="width:100%;" /></td>
                            <td> </td>
                            <td> </td>
                        </tr>
                        <tr>
                            <td>Place of Loading</td>
                            <td colspan="2"><gw:textbox id="txtPLCofLoading"   styles="width:100%;" /></td>
                            <td> </td>
                        </tr>
                        <tr>
                            <td>Place of Discharge</td>
                            <td colspan="2"><gw:textbox id="txtPLCofDischarge"   styles="width:100%;" /></td>
                            <td> </td>
                        </tr>
                        <tr>
                            <td>Trade Terms</td>
                            <td colspan="2"><gw:list id="cboPaymentTermS" styles="width:100%;"></gw:list></td>
                            <td> </td>
                        </tr>
                    </table>
                </td>
                <td width="5%"></td>
                <td width="50%">
                    <table width="100%" cellpadding=0 cellspacing=0 border=0>
                        <tr>
                            <td colspan="6">
                                <gw:radio id="radPayType" value="a" styles="width:100%" onchange=""> 
                                    <span value="a">Vendor </span> 
                                    <span value="b">Other</span> 
                                </gw:radio>
                            </td>
                        </tr>
                        <tr>
                            <td width="30%"><a title="Click here to select" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF">Paid To</a> </td>
                            <td width="20%"><gw:textbox id="txtPaidCode"   styles="width:100%;" /><gw:textbox id="txtPaidPK"   styles="display:none" /></td>
                            <td colspan="4" width="20%"><gw:textbox id="txtPaidName"   styles="width:100%;" /></td>                                            
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="5" ><gw:textarea id="txtPaidAdd" styles="width:100%;" /></td>
                        </tr>
                        <tr>
                            <td>Payment Method</td>
                            <td><gw:list id="cboPaymentMethod" styles="width:100%;"></gw:list></td>                                
                            <td></td>
                            <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bank Account</td>
                            <td colspan="2"><gw:textbox id="txtAccountBank"   styles="width:100%;" /></td>
                        </tr>
                        <tr>
                            <td>Payment Currency</td>
                            <td><gw:list id="cboCurrencyS" styles="width:100%;"></gw:list></td>
                            <td>/VND</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ex. Rate</td>
                            <td width="10%"><gw:textbox id="txtEachCurS"   styles="width:100%;" /></td>
                            <td width="15%"><gw:textbox id="txtExRateS"   styles="width:100%;" /></td> 
                        </tr>
                        <tr>
                             <td>Payment Term</td>
                             <td colspan="5"><gw:list id="cboPaymentTerm" styles="width:100%;"></gw:list></td>                                             
                        </tr>
                         <tr>
                            <td>Location</td>
                            <td colspan="5"><gw:textbox id="txtLocation"   styles="width:100%;" /></td>
                        </tr>
                        <tr>
                            <td>Discount on Payment</td>
                            <td><gw:textbox id="txtDiscount"  type="number" format="#,###,###,###,###.##R" styles="width:100%;" /></td>
                            <td>%</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>                                       
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <table width="100%" cellpadding=0 cellspacing=0>
                        <tr>
                            <td width="11%">Description</td>
                            <td width="89%"><gw:textbox id="txtDesc"   styles="width:100%;" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
    <gw:textbox id="txtCom_pk" styles="display:none" />
    <gw:textbox id="txtOrderPK"   styles="display:none" />
</body>
</html>
