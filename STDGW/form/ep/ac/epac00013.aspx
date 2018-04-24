
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>View Order detail</title>
</head>
<%ESysLib.SetUser("comm")%>
<script language="javascript" type="text/javascript" >
    function BodyInit()
     {       
        System.Translate(document);  // Translate to language session
        
        dat_epac00010_1.StatusInsert();
        BindingDataList();  
        txtOrderPK.text="<%=request.QueryString("order_pk") %>";
        txtOrderNo.text="<%=request.QueryString("order_no") %>";
        dtOrderDate.value="<%=request.QueryString("order_date") %>";
        txtCom_pk.text= "<%=request.QueryString("Com_pk") %>";
        SetStatus();
        dat_epac00010_1.Call('SELECT');
     }
//-----------------------------------------------------------------------------------
     function BindingDataList()
     {            
         var data2 = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.del_if=0 and b.del_if=0 order by a.CODE")%>";  //currency 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0010','','') FROM DUAL")%>";  //trade term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0140','','') FROM DUAL")%>";  // payment method
         var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0020','','') FROM DUAL")%>";  //
         var data6 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEBD0050','','') FROM DUAL")%>";  // payment method
                  
         cboPaymentTermS.SetDataText(data3);        
         cboPaymentTerm.SetDataText(data3);   
         cboCurrencyS.SetDataText(data2); 
         cboPaymentMethod.SetDataText(data4);      
         cboTransport.SetDataText(data5); 
         cboDiscount.SetDataText(data6); 
     }
     //---------------------------------------------------------------------------------------
     function SetStatus()
     {
        txtOrderNo.SetEnable(false);
        dtOrderDate.SetEnable(false);
        
        txtPLCofLoading.SetEnable(false);  
        txtPLCofDischarge.SetEnable(false);
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
	                var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AP"; //customs
                    aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	                if ( aValue != null )
	                {          
	                    desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                    txtShipName.SetDataText(aValue[2]); 
	                    txtShipCode.SetDataText(aValue[1]);  
	                    txtShipPK.SetDataText(aValue[0]);  
	                    txtShipAdd.SetDataText(desc);
	                }
	            }	
	        break;
	        case 2:// Paid to   
	            var desc;
	            var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AP"; //customs
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                txtPaidName.SetDataText(aValue[2]); 
	                txtPaidCode.SetDataText(aValue[1]);  
	                txtPaidPK.SetDataText(aValue[0]);  
	                txtPaidAdd.SetDataText(desc);
	            }	
	        break;
	        case 9:       
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPLCofLoading.SetDataText(aValue[3]); 
	                txtPLCofLoadingCD.SetDataText(aValue[2]);  
	            }	
	        break;  
	        case 10: 
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPLCofDischarge.SetDataText(aValue[3]); 
	                txtPLCofDischargeCD.SetDataText(aValue[2]);  
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
	    getExRate();
	}
	//--------------------------------------------------------------
    function onChangeShipType()
    {
        if (radShipType.value=='a')
            dat_epac00010_8.Call('SELECT');
    }
    //-----------------------------------------------
    function GetXmlHttpRequest(handler)
    { 
	    var objXmlHttp=null;
    	
	    if (navigator.userAgent.indexOf("Opera")>=0)
	    {
		    alert("Sorry! Ajax doesn't work in Opera"); 
		    return; 
	    }
    	
	    if (navigator.userAgent.indexOf("MSIE")>=0)
	    { 
		    var strName="Msxml2.XMLHTTP";
		    if (navigator.appVersion.indexOf("MSIE 5.5")>=0)
		    {
			    strName="Microsoft.XMLHTTP";    			
		    } 
		    try
		    { 
			    objXmlHttp=new ActiveXObject(strName);
			    objXmlHttp.onreadystatechange=handler; 
    			
			    return objXmlHttp;
		    } 
		    catch(e)
		    { 
			    alert("Error. Scripting for ActiveX might be disabled");
			    return; 
		    } 
	    } 
    	
	    if (navigator.userAgent.indexOf("Mozilla")>=0)
	    {
		    objXmlHttp=new XMLHttpRequest();
		    objXmlHttp.onload=handler;
		    objXmlHttp.onerror=handler;
    		
		    return objXmlHttp;
	    }
    }     
    //-----------------------------------------------
    //ajax function
    function GetRequestState(obj)
    {
     
      if(obj.readyState == 4 && obj.status == 200)
      {
          return true;
      }
      return false;
    }
    //--------------------------------------------------------------
    function getExRate()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtOrderDate.value +"&curr=" + cboCurrencyS.value;
	    ajax_test = null;
	   
	    ajax_test = GetXmlHttpRequest(returnExRate);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null); 
    }
    //---------------------------------------------------------
    function returnExRate()
    {
        if(GetRequestState(ajax_test))
	    {	
	        strdata = ajax_test.responseText;	 	  
	        txtExRateS.SetDataText(''+strdata);
	    }
    }
    //-----------------------------------------------------------------------------------------
    function AddCommonCode(index)
    {     
        var scode;
        switch(index)
        {           
            case 1:
                scode='IEAB0010'; //cboPaymentTermS
            break;
            case 2:
                scode='IEAB0010'; //cboPaymentTerm
            break;
            case 3:
                scode='ACAB0110'; // cboCurrency
            break;  
            case 4:
                scode='ACAB0110'; // cboCurrencyS
            break;  
            case 5:
                scode='ACCR0140'; // cboPaymentMethod
            break;
            case 6:
                scode='IEAB0020'; // cboTransport
            break;
            case 7:
                scode='IEBD0050'; // cboTolerance
            break;  
            case 8:
                scode='IEBD0050'; // cboDiscount
            break;                 
        }
        var fpath = System.RootURL + "/form/ep/bp/epbp00020_com_code.aspx?code=" + scode ;
       
        var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
        if (obj!=null)
        {
            strcodereturn=obj[1];
            indexCode=index;
            
            if (obj[0]==1 ) //modify common code
                OnLoadNew(scode);
            else
            {               
                switch(index)
                {                        
                    case 1:
                        cboPaymentTermS.value=strcodereturn; //cboPaymentTermS
                    break;
                    case 2:
                        cboPaymentTerm.value=strcodereturn; //cboPaymentTerm
                    break;
                    case 3:
                        cboCurrency.value=strcodereturn; // cboCurrency
                    break;  
                    case 4:
                        cboCurrencyS.value=strcodereturn; // cboCurrencyS
                    break;  
                    case 5:
                        cboPaymentMethod.value=strcodereturn; // cboPaymentMethod
                    break;
                    case 6:
                        cboTransport.value=strcodereturn; // cboTransport
                    break;
                    case 7:
                        cboTolerance.value=strcodereturn; // cboTolerance
                    break;  
                    case 8:
                        cboDiscount.value=strcodereturn; // cboDiscount
                    break;               
                }            
            }
        }	     
    }
    //-----------------------------------------------------------------------------------    
    function OnLoadNew(scode)
    {	
	    var t=new Date()
	    var url =  System.RootURL + "/form/ep/gd/epgd00010_searchidcode.aspx?id=" + scode;
	    ajax_test = null;
	    ajax_test = GetXmlHttpRequest(return_result);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null);
    }
    //--------------------------------------------------------------------------------------------
    function return_result()
    {	        
	    if(GetRequestState(ajax_test))
	    {
	        strdata = ajax_test.responseText;	
            switch(indexCode)
            {    
                case 1:
                    cboPaymentTermS.SetDataText(strdata);
                    cboPaymentTermS.value=strcodereturn; //cboPaymentTermS                    
                break;
                case 2:
                    cboPaymentTerm.SetDataText(strdata);
                    cboPaymentTerm.value=strcodereturn; //cboPaymentTerm
                break;
                case 3:
                    cboCurrency.SetDataText(strdata);
                    cboCurrency.value=strcodereturn; // cboCurrency
                break;  
                case 4:
                    cboCurrencyS.SetDataText(strdata);
                    cboCurrencyS.value=strcodereturn; // cboCurrencyS
                break;  
                case 5:
                    cboPaymentMethod.SetDataText(strdata);
                    cboPaymentMethod.value=strcodereturn; // cboPaymentMethod
                break;
                case 6:
                    cboTransport.SetDataText(strdata);
                    cboTransport.value=strcodereturn; // cboTransport
                break;
                case 7:
                    cboTolerance.SetDataText(strdata);
                    cboTolerance.value=strcodereturn; // cboTolerance
                break;  
                case 8:
                    cboDiscount.SetDataText(strdata);
                    cboDiscount.value=strcodereturn; // cboDiscount
                break;                            
            }
	    }
    }
    //--------------------------------------------------------------
    function onClose()
    {
        window.close();
    }
</script>
<body>
    <!------------------------Update Order detail -------------------------------------->
<gw:data id="dat_epac00010_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,5,6,7,8,9,10,11,12,15,16,17,18,19,20,21,22,23" function="imex.sp_sel_epac00013_1"  procedure="imex.sp_upd_epac00013_1"> 
            <inout>     
                 <inout  bind="txtOrderPK" /> 
                 <inout  bind="radShipType" />
                 <inout  bind="txtShipPK" /> 
                 <inout  bind="txtShipCode" />
                 <inout  bind="txtShipName" />    
                 <inout  bind="txtShipAdd" />
                 <inout  bind="cboTransport" /> 
                 <inout  bind="dtShipDate" />   
                 <inout  bind="txtPLCofLoadingCD" /> 
                 <inout  bind="txtPLCofDischargeCD" />
                 <inout  bind="cboPaymentTermS" />    
                 <inout  bind="radPayType" />          
                 <inout  bind="txtPaidPK" />
                 <inout  bind="txtPaidCode" />
                 <inout  bind="txtPaidName" /> 
                 <inout  bind="txtPaidAdd" />               
                 <inout  bind="cboPaymentMethod" /> 	
                 <inout  bind="cboCurrencyS" /> 
                 <inout  bind="cboPaymentTerm" />
                 <inout  bind="cboDiscount" />
                 <inout  bind="txtLocation" />
                 <inout  bind="txtAccountBank" />
                 <inout  bind="txtExRateS" />
                 <inout  bind="txtDesc" />                 
                 <inout  bind="txtPLCofLoading" />
                 <inout  bind="txtPLCofDischarge" />
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
    <!begin------------>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table1">
	<tr>
	    <td width="10%" align="right">Order No</td>
        <td width="20%"><gw:textbox id="txtOrderNo"   styles="width:100%;" /></td>
        <td width="10%" align="right">Order Date</td>
        <td width="20%"><gw:datebox id="dtOrderDate" lang="1" onchange=""  styles="width:100%;" /></td>
		<td width="55%" ></td>
		<td><gw:imgBtn img="save" 		alt="Save" id="btnUpdate" onclick="onSave()" /></td>								
		<td><gw:icon img="in"  text="Close"		alt="Update" id="btnClose" onclick="onClose()" /></td>								
	</tr>
	<tr>
	    <td width=100% colspan=7>
	         <fieldset style="padding: 2">
             <legend>Shipment Information</legend>
               <table width="100%" cellpadding=0 cellspacing=0 border="0">
                <tr>
                    <td width=24%></td>
                     <td width=66% colspan=3 >
				        <gw:radio id="radShipType" value="a" styles="width:100%" onchange="onChangeShipType();"> 
                                    <span value="a">Company </span> 
                                    <span value="b">Consignee</span> 
                        </gw:radio>	
					 </td>
                </tr>
                 <tr> 
                    <td width="24%"><a title="Click here to select" onclick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Ship To</b></a></td>
                    <td width="20%"><gw:textbox id="txtShipCode" csstype="mandatory"   styles="width:100%;" /><gw:textbox id="txtShipPK"   styles="display:none" /></td>
                    <td width="55%"><gw:textbox id="txtShipName"  csstype="mandatory"  styles="width:100%;" /></td>
                    <td><gw:imgBtn id="ibtnDReset11" img="reset" alt="Reset Ship To" onclick="txtShipPK.text='';txtShipCode.text='';txtShipName.text='';"/></td>
                 </tr>
                 <tr>
					<td width="24%">Address</td>
					<td colspan="3" width="76%">
						<gw:textarea rows=3  id="txtShipAdd"  styles="width:100%" csstype=""/>		
					</td>
				</tr>
				<tr>
					<td width="24%"><a title="Click here to select Transportation By" onclick="AddCommonCode(6)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Transportation By</b></a></td>
					<td colspan="3" width="76%">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table10">
							<tr>
								<td width="30%">
									<gw:list id="cboTransport" onChange="" styles="width:100%"></gw:list >					
								</td>
								<td width="28%">&nbsp;&nbsp;&nbsp;&nbsp;  Shipment Date.</td>
								<td width="25%" align="right"><gw:datebox id="dtShipDate"  onchange="" lang="<%=Session("Lang")%>" nullaccept styles="width:200%"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				    <td width="24%"><a title="Click here to select Place of Loading" onclick="openPopup(9)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Loading</b></a></td>
					<td colspan="3" width="76%">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table8">
							<tr>
								<td width="36%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table11">
											<tr>
												<td width="90%">
													<gw:textbox id="txtPLCofLoadingCD" text="" style="display:none" />
													<gw:textbox id="txtPLCofLoading"  styles="width:100%" csstype=""/>					
												</td>
											   <td><gw:imgBtn id="ibtnDReset11" img="reset" alt="Reset Place of Loading<" onclick="txtPLCofLoadingCD.text='';txtPLCofLoading.text='';"/></td>
											</tr>			
										</table>					
									</td>
									<td width="64%">
										<table width="100%" border="0" cellpadding="0" cellspacing="0" >
											<tr>
												<td width="56%"><a title="Click here to select Place of Discharge" onclick="openPopup(10)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Place of Discharge</b></a></td>
												<td colspan="2" width="44%">
													<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table13">
														<tr>
															<td width="99%">
																<gw:textbox id="txtPLCofDischargeCD" text="" style="display:none;" />
																<gw:textbox id="txtPLCofDischarge"  styles="width:99%" csstype=""/>					
															</td>
														    <td align="right"><gw:imgBtn id="ibtnDReset11" img="reset" alt="Reset Customer" onclick="txtPLCofDischarge.text='';"/></td>
														</tr>			
														
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="24%"><font color="#000000"><b><a title="Click here to select Trade Terms" onClick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Trade Terms</b></a></b></font></td>
						<td colspan="3" width="76%">
							<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table15">
								<tr>
									<td width="36%">
										<gw:list id="cboPaymentTermS" styles="width:100%" ></gw:list>
									</td>
									<td width="36%"><font color="#000000"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Location</b></font></td>
									<td width="28%" align="right"><gw:textbox id="txtLocation" onkeypress="checkKey()" text="" csstype='mandatory' styles="width:100%;" /></td>
								</tr>
							</table>
						</td>
					</tr>
               </table>
            </fieldset>

	    </td>
	</tr>
	<tr>
	    <td height=10></td>
	</tr>
	<tr>
	    <td width=100% colspan=7>
	         <fieldset style="padding: 2">
             <legend>Payment Information</legend>
                <table width=100% cellpadding=0 cellspacing=0 border=0>
                    <tr>
                        <td width=25%></td>
                        <td width=76% colspan=3>
                                      <gw:radio id="radPayType" value="a" styles="width:100%" onchange=""> 
                                        <span value="a">Vendor </span> 
                                        <span value="b">Other</span> 
                                    </gw:radio>
                         </td>   
                    </tr>             
                    <tr>
						<td width="24%"><a title="Click here to select" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Paid To</b></a> </td>
						<td width="75%">
							<gw:textbox id="txtPaidPK" text="" style="display:none;" />
							<gw:textbox id="txtPaidCode" styles="width:30%" csstype="mandatory"/>
							<gw:textbox id="txtPaidName"  styles="width:69%" csstype="mandatory"/>					
						</td>
						<td><gw:imgBtn id="ibtnDReset11" img="reset" alt="Reset Payer" onclick="txtPaidPK.text='';txtPaidCode.text='';txtPaidName.text='';"/></td>
				 	</tr>
				   <tr>                                         
                      <td width="24%">Address</td>
                      <td width="76%" colspan="3"><gw:textarea rows=3 id="txtPaidAdd" styles="width:100%" /></td>
				   </tr>	
				   <tr>                                         
  		              <td width="24%"><a title="Click here to select Payment Method" onclick="AddCommonCode(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Method</b></a></td>
                      <td width="76%" colspan="3">
							<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table22">
								<tr>
									<td  width="38%" ><gw:list id="cboPaymentMethod" styles="width:66%" ></gw:list></td>
									<td width="32%" align="left">Bank Account</td>
									<td width="30%"><gw:textbox id="txtAccountBank"   styles="width:100%;" /></td>
								</tr>			
							</table>
						</td>
					</tr>
                    <tr>
						<td width="24%"><a title="Click here to select Payment Term" onclick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Term</b></a></td>
						<td width="76%" colspan="3">
							<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table27">
								<tr>
									<td  width="38%"><gw:list id="cboPaymentTerm" onChange="" styles="width:66%"></gw:list ></td>
									<td width="32%" align="left"><a title="Click here to select Payment Currency" onclick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Payment Currency</b></a></td>
									<td width="30%"><gw:list id="cboCurrencyS" onchange="getExRate();" styles="width:100%"></gw:list></td>
								</tr>
							</table>
						</td>
					</tr>
                   <tr>
						<td width="24%"><font color="#000000"><b><a title="Click here to select Discount on Payment" onclick="AddCommonCode(8)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Discount on Payment</b></a></b></font></td>
						<td width="76%" colspan="3">
							<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table17">
								<tr>
									<td  width="38%">
										<gw:list id="cboDiscount" onChange="" styles="width:66%"></gw:list >	
									</td>
									<td width="23%" align="left">Ex. Rate</td>
									<td width="60%">
										<table border="0" cellpadding="0" cellspacing="0" width="100%" ID="Table30">
											<tr>
											    <td width="22%"></td>
												<td width="39%"><gw:textbox id="txtExrate1" text="1"  styles="width:100%;text-align:right"/></td>
												<td width="39%"><gw:textbox id="txtExRateS" type="number" format="#,###,###,###,###R"   styles="width:100%;text-align:right"/></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr> 
                </table>
             </fieldset>

	    </td>
	</tr>
	<tr>
        <td colspan="7" width="100%">
            <table width="100%" cellpadding=0 cellspacing=0 border=0>
                <tr>
                    <td width="23%">Description</td>
                    <td width="77%">&nbsp; <gw:textbox id="txtDesc"   styles="width:99%;" /></td>
                </tr>
            </table>
        </td>
    </tr>
	
</table>
    </form>
    <gw:textbox id="txtOrderPK"   styles="display:none" />
    <gw:textbox id="txtCom_pk" styles="display:none" />
</body>
</html>
