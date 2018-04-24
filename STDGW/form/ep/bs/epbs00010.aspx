<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>IE Setting</title>
</head>

<script type="text/javascript">

   var user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
   var user_name  = "<%=Session("USER_NAME")%>" ;
   
//=========================================================================        
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        //--------------------------------------
        txtCustID.SetEnable(false);
        txtCustName.SetEnable(false);
        //--------------------------------------
       // OnChangeTab();
        //--------------------------------------
        BindingDataList();
        ListSelectChanged();
        //--------------------------------------          
    }
   
//=========================================================================        
 function BindingDataList()
 {   
      var data = "" ;
      
      data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
      lstCompany.SetDataText(data);
                                                                  
 }     
//=========================================================================        
function OnSave(pos)
{
    switch (pos)
    {
        case 'Master':              
                if (txtMasterPK.text == '' && data_epbs00010.GetStatus() != 20 )
                {
                        data_epbs00010.StatusInsert();
                }
                data_epbs00010.Call();
        break;                
       
    }
}

//=========================================================================        
    function OnDataReceive(obj)
    {
        switch (obj.id)
        {
            case "data_epbs00010" :  
            
            break;                                                                
        }   
    }    
//===================================================================================   
 function OnChangeTab()
 { 
    var strRad = radTab.GetData();
             
	switch (strRad)
	{
		case '1':
		    document.all("Tab_Invoice_Info").style.display     = "";
		    document.all("Tab_Description").style.display      = "none";
		    
		    document.all("Invoice_Info").style.color     = "red"; 
		    document.all("Description").style.color      = ""; 
        break;
        
        case '2':
		    document.all("Tab_Invoice_Info").style.display     = "none";
		    document.all("Tab_Description").style.display      = ""; 
		    
		    document.all("Invoice_Info").style.color     = ""; 
		    document.all("Description").style.color      = "red";       
        break;	        
    } 
 }
//===================================================================================
function OnSearch(pos)
{
    switch(pos)
    {        
        case 'Master':
            data_epbs00010.Call("SELECT");
        break;

    }
}    

//===================================================================================
function ListSelectChanged()
{
    OnSearch('Master')
}


//===================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Customs' :
             var path = System.RootURL + "/form/ep/bs/epbs00040.aspx?pop_type=Y";
	         var object = System.OpenModal( path ,850 , 600 ,  'resizable:yes;status:yes;scroll:no;');
	         
	         if ( object != null )
	         {
	            txtCustPK.text   = object[0];
	            txtCustID.text   = object[1];
                txtCustName.text = object[2];              
	         }
        break;
        
        case 'ShipTo' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtShipToPK.text   = object[0];
	            txtShipToID.text   = object[1];
                txtShipToName.text = object[2];

                txtShipAdd.SetDataText(object[37]);          
	         }
        break;     
        
        case 'PaidTo' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPaidToPK.text   = object[0];
	            txtPaidToID.text   = object[1];
                txtPaidToName.text = object[2]; 
                
                txtPaidAdd.SetDataText(object[37]);             
	         }
        break;                  
        
        case 'Carrier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtCarrierPK.text   = object[0];
	            txtCarrierID.text   = object[1];
                txtCarrierName.text = object[2];
                
                txtCarrierDesc.SetDataText(object[37]);          
	         }
        break;  
        
        case 'Notify' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtNotifyPK.text   = object[0];
	            txtNotifyID.text   = object[1];
                txtNotifyName.text = object[2]; 
                
                txtNotifyDesc.SetDataText(object[37]);            
	         }
        break;                                        
        
        case 'DeliMethod':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0250";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0250';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDeliMethod.value = object[1];      
	            }    	                
	         }                
        break;   

        case 'DomesticPort':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0230";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0230';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDomesticPort.value = object[1];      
	            }    	                
	         }                
        break; 

        case 'OverSeaPort':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0240";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0240';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstOverSeaPort.value = object[1];      
	            }    	                
	         }                
        break; 

        case 'PriceType':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0130';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPriceType.value = object[1];      
	            }    	                
	         }                
        break;   
                                                                                 
        case 'PaymentMethod':        
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0110';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentMethod.value = object[1];      
	            }    	                
	         }                
        break;   
        
        case 'PaymentTerms':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0120";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0120';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPaymentTerm.value = object[1];      
	            }    	                
	         }                              
        break;    

        case 'DiscountRate':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0150";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0150';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstDiscountRate.value = object[1];      
	            }    	                
	         }                              
        break;    
        
        case 'TrCCY':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0100';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstTrCCY.value = object[1];      
	            }    	                
	         }                
        break;   
       case 'BookCCY':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0100';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstTrCCY.value = object[1];      
	            }    	                
	         }                
        break;  
        case 'PayCCY':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0100";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGCM0100';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstPayCCY.value = object[1];      
	            }    	                
	         }                
        break;  
        
        case 'ReportType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEEX0020";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEEX0020';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstReportType.value = object[1];      
	            }    	                
	         }                
        break;          
        
        case 'LCBank':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0010";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'IEBS0010';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstLCBank.value = object[1];      
	            }    	                
	         }                
        break;                                                                                                                   
    }	       
}
  //===================================================================================
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbs00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00010"  procedure="<%=l_user %>lg_upd_epbs00010"> 
                <inout>
                     <inout  bind="lstCompany" />
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtCustPK" />
                     <inout  bind="txtCustID" />               
                     <inout  bind="txtCustName" />                     
                     <inout  bind="txtCompanyCode" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Company
            </td>
            <td style="width: 25%">
                <gw:list id="lstCompany" styles="width:100%;" onchange="ListSelectChanged()"></gw:list>
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
            </td>
            <td style="width: 60%; white-space: nowrap">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="15">
                <table style="width: 100%; height: 100%">
                    <tr valign="top" >
                        <td style="width: 5%; white-space: nowrap">
                            <a title="Customer" onclick="OnPopUp('Customs')" href="#tips" style="text-decoration: none;
                                color=#0000ff">Cust</a>
                        </td>
                        <td style="width: 35%; white-space: nowrap" colspan="5">
                            <gw:textbox id="txtCustPK" text="" styles='width:10%;display:none' />
                            <gw:textbox id="txtCustID" text="" styles='width:30%;' csstype="mandatory" />
                            <gw:textbox id="txtCustName" text="" styles='width:70%;' csstype="mandatory" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Company Code
                            <td style="width: 10%">
                                <gw:textbox id="txtCompanyCode" styles='width:100%' />
                            </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" text="" styles='display:none' />
<!------------------------------------------------------------------------------->
</html>
