<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>SHIPMENT</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_Shipment_pk = 0;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
   //---------------------------- 
    BindingDataList(); 
    data_kblc00030_1.StatusInsert();
    data_kblc00030.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	      	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstShipComp.SetDataText(data); 
    lstShipComp.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0040' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstStoredFact.SetDataText(data); 
    lstStoredFact.value = '' ; 
    
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0020' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstShipPort.SetDataText(data); 
    lstShipPort.value = '' ; 
    
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0021' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstArrivalPort.SetDataText(data); 
    lstArrivalPort.value = '' ; 
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy.SetDataText(data); 
    lstCCy.value = 'USD' ;
    
    lstCCY2.SetDataText(data); 
    lstCCY2.value = 'USD' ;   
 } 
 //==================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'SHIPCOM':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0030";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                alert(object[0])	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0030';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShipComp.value = object[1];      
	                }    	                
	             }                              
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
           
              case 'SHIP-PORT':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0020";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0020';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShipPort.value = object[1];      
	                }    	                
	             }                              
            break;   
             case 'ARR-PORT':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0021";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0021';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstArrivalPort.value = object[1];      
	                }    	                
	             }                              
            break;   
             case 'PRODUCT':
                var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {                                 
                        txtProductPK.text = object[0];
                        txtProductName.text = object[1]+ ' - ' +object[2]; 	 							                                     
                 }                        
            break;     
            case 'PARTNER' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	         
	            txtCustomerPK.text   = object[0];
                txtCustomerNM.text = object[2];   
                txtTaxCode.text =  object[6];
                txtCustomerID.text = object[1];
                
                txtBillToNM.text = object[2];
	         }
	      break;
	      case 'LC':
                 var path = System.RootURL + "/form/kb/lc/kblc00031.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCPK.text   = object[0];
                    txtLCNo.text   = object[2];                                                                     
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
            data_kblc00030.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdInsurance.GetGridData(grdInsurance.row,G_Shipment_pk);
            data_kblc00030_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0030')
             {
                lstShipComp.SetDataText(txtLGCodeList.text);
                lstShipComp.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0040')
             {
                lstStoredFact.SetDataText(txtLGCodeList.text);  
                lstStoredFact.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'IEBS0020')
             {
                lstShipPort.SetDataText(txtLGCodeList.text);  
                lstShipPort.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'IEBS0021')
             {
                lstArrivalPort.SetDataText(txtLGCodeList.text);  
                lstArrivalPort.value = rtnLGCode;                      
             }
      break;    
      case 'data_kblc00030_1':
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00030.Call('SELECT');
            }
      break;  
      case 'data_kblc00030':
            lblRecord.text  = ( grdInsurance.rows -1 )+ " record(s)."
      break;
        
    }
}
//====================================================================================

function Validate()
{   
    if(txtBLNo.text =="")
    {
        alert("Please, input BL NO No!")
        return false;
    }
    else if(txtInvoice.text =="" )
    {
        alert("Please, input Invoice No!");
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
    if(data_kblc00030_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00030_1.Call();  
        }
           
    }else
    {    
        data_kblc00030_1.Call();                
    }

}
//====================================================================================
function OnAddNew()
{
    data_kblc00030_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00030_1.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function CalExAmount()
{ 
    txtExAmount.text = Number(txtInvoiceAMT.text) * Number(txtExRate.text);
    OnCalVat();        
}
//====================================================================================
function OnCalVat()
{
    if(txtVatRate.text == "")
         txtVatAMT.text = ""; 
    else
    {     
        if( txtExAmount.text != '0')
             txtVatAMT.text = parseFloat(txtVatRate.text) * parseFloat(txtExAmount.text)/100;  
        else
             txtVatAMT.text = parseFloat(txtVatRate.text) * parseFloat(txtInvoiceAMT.text)/100;    
    }    
    OnTotalAmt();
}
//==================================================================================== 
function OnTotalAmt()
{
     if( txtExAmount.text != '0')
    {  
        if(txtVatAMT.text != "")  
            txtTotalAMT.text = parseFloat(txtExAmount.text)+ parseFloat(txtVatAMT.text);
         else
            txtTotalAMT.text = parseFloat(txtExAmount.text);
    }
    else
    {   
        if(txtVatAMT.text != "")  
            txtTotalAMT.text = parseFloat(txtInvoiceAMT.text)+ parseFloat(txtVatAMT.text);
        else
            txtTotalAMT.text = parseFloat(txtInvoiceAMT.text);
    }
}   
//==================================================================================== 
function OnCalNetWt()
{
     txtNetWT.text = parseFloat(txtGrossWT.text)- parseFloat(txtTareWT.text);     
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
    <gw:data id="data_kblc00030" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00030"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>
					<input	bind="txtSearchNo"	/>					
				</input>	
				<output	bind="grdInsurance"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00030_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29"	function="<%=l_user%>lg_sel_kblc00030_1"	procedure="<%=l_user%>lg_upd_kblc00030_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtBLNo"	/>
						<inout	bind="txtInvoice"	/>
						
						<inout	bind="dtShipmentDT"	/>						
						<inout	bind="lstShipComp"	/>
						<inout	bind="lstStoredFact"	/>
						
						<inout	bind="dtArrvalDt"	/>
						<inout	bind="lstShipPort"	/>
						<inout	bind="lstArrivalPort"	/>					
                       	
                       	<inout	bind="dtIncomeDT"	/>
                       	<inout	bind="txtVesselNm"	/>	
						<inout	bind="txtInvoiceAMT"	/>						
						<inout	bind="lstCCy"	/>
								
						<inout	bind="txtLCPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtItemSpec"	/>
						<inout	bind="txtExRate"	/>
						<inout	bind="lstCCY2"	/>              
						
						<inout	bind="txtGrossWT"	/>	
						<inout	bind="txtTareWT"	/>	
						<inout	bind="txtNetWT"	/>	
						
						<inout	bind="txtNumOfRod"	/>		
						<inout	bind="txtSign"	/>
						<inout	bind="txtRemark"	/>	
						
						<inout	bind="txtExAmount"	/> 
						<inout	bind="txtVatRate"	/> 
						<inout	bind="txtVatAMT"	/> 
						<inout	bind="txtTotalAMT"	/>																										
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 5%;width:100%">
        <td>
            <table style="width: 100%; height: 100%">
                <tr style="height: 1%">
                    <td style="width: 12%"></td>
                    <td style="width: 18%"></td>
                    <td style="width: 12%"></td>
                    <td style="width: 18%"></td>
                    <td style="width: 12%"></td>
                    <td style="width: 20%"></td>             
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
           
         <tr style="height: 30%" id="Shipment">
          <td>            
             <table style="width: 100%; height: 100%"> 
                <tr>
                    <td align="right" style="width: 12%;">
                                    Slip No
                     </td>
                      <td style="width: 18%">
                           <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory" readonly ="true"/>
                     </td>
                      <td align="right" style="width: 12%;" >
                                    B/L No
                     </td>
                      <td style="width: 18%">
                           <gw:textbox id="txtBLNo" styles="width:100%;"/>
                     </td>
                      <td align="right" style="width: 12%;">
                                  Invoice No
                     </td>
                      <td colspan="4" style="width: 28%">
                            <gw:textbox id="txtInvoice" styles="width:100%;"  />
                     </td>
                </tr>
                <tr>
                     <td align="right" style="width: 12%;">
                           Shipment Date
                     </td>
                      <td style="width: 18%">
                            <gw:datebox id="dtShipmentDT" lang="1" />
                     </td>
                      <td align="right" style="width: 12%; ">
                           <a onclick="OnShowPopup('SHIPCOM')" href="#tips" style="color: #0000ff">Shipping Company</a>
                     </td>
                      <td style="width: 18%">
                          <gw:list id="lstShipComp" styles="width:100%;" />
                     </td>
                     <td align="right" style="width: 12%; ">
                             <a onclick="OnShowPopup('FACT')" href="#tips" style="color: #0000ff">Stored Factory</a>
                     </td>
                      <td colspan="4" style="width: 28%">
                          <gw:list id="lstStoredFact" styles="width:100%;" />
                     </td>
                </tr>
                <tr>
                     <td align="right" style="width: 12%;">
                              Arrival Date
                     </td>
                      <td style="width: 18%">
                           <gw:datebox id="dtArrvalDt" lang="1" nullaccept />
                     </td>
                      <td align="right" style="width: 12%;">
                        <a onclick="OnShowPopup('SHIP-PORT')" href="#tips" style="color: #0000ff">Shipment Port</a>
                                 
                     </td>
                      <td style="width: 18%">
                          
                           <gw:list id="lstShipPort" styles="width:100%;" />
                     </td>
                     <td align="right" style="width: 12%">
                             <a onclick="OnShowPopup('ARR-PORT')" href="#tips" style="color: #0000ff">Arrival Port</a>     
                     </td>
                      <td colspan="4" style="width: 28%">
                            <gw:list id="lstArrivalPort" styles="width:100%;" />
                     </td>
                </tr>
                <tr>
                     <td align="right" style="width: 12%;">
                             Income Date
                     </td>
                      <td style="width: 18%">
                             <gw:datebox id="dtIncomeDT" lang="1" nullaccept />
                     </td>
                      <td align="right" style="width: 12%;">
                              Vessel's Name
                     </td>
                      <td style="width: 18%">
                           <gw:textbox id="txtVesselNm" styles="width:100%;"  />
                     </td>
                     <td align="right" style="width: 12%;">
                                Invoice AMT
                     </td>
                     <td colspan="2" style="width: 20%">
                            <gw:textbox id="txtInvoiceAMT" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="CalAmount()" onchange="CalAmount()" />
                     </td> 
                      <td  style="width: 8%" colspan="3">
                        <gw:list id="lstCCy" styles="width:100%;" />
                     </td>                
                </tr>      
                <tr>
                     <td align="right" style="width: 12%;">
                            <a onclick="OnShowPopup('LC')" href="#tips" style="color: #0000ff">L/C </a>
                     </td>
                      <td style="width: 18%">
                           <gw:textbox id="txtLCPK" styles="width:100%;display:none"  />
                           <gw:textbox id="txtLCNo" styles="width:100%;" csstype="mandatory" readonly ="true"  />
                     </td>
                      <td align="right" style="width: 12%;">
                             Detail Spec
                     </td>
                      <td style="width: 18%">
                             <gw:textbox id="txtItemSpec" styles="width:100%;"  />
                     </td>
                     <td align="right" style="width: 12%;">
                              Exchange rate
                     </td>
                     <td colspan="2" style="width: 20%">
                            <gw:textbox id="txtExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" onblur="CalExAmount()" onchange="CalExAmount()" />   
                     </td> 
                      <td  style="width: 8%" colspan="3">
                       <gw:list id="lstCCY2" styles="width:100%;" />
                     </td>                  
                </tr>      
                
                <tr>
                     <td align="right" style="width: 12%;">
                             Gross WT
                     </td>
                     <td style="width: 18%">
                           
                           <gw:textbox id="txtGrossWT"  styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="OnCalNetWt()" onchange="OnCalNetWt()" onenterkey="OnCalNetWt()"/>
                     </td>
                      <td align="right" style="width: 12%;">
                            BALE
                     </td>
                      <td style="width: 18%">
                            <gw:textbox id="txtNumOfRod" styles="width:100%;"  /> 
                                              
                     </td>
                     <td align="right" style="width: 12%;">
                            Exchange AMT 
                     </td>
                     <td colspan="4" style="width: 28%">
                            <gw:textbox id="txtExAmount"  styles="width:100%;" type="number" format="###,###,###,###.#R" /> 
                     </td>                 
                </tr>    
                 
                <tr>
                    <td align="right" style="width: 12%;">
                            Tare WT 
                     </td>
                     <td style="width: 18%">                 
                          <gw:textbox id="txtTareWT"  styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="OnCalNetWt()" onchange="OnCalNetWt()" onenterkey="OnCalNetWt()"/> 
                     </td>
                      <td align="right" style="width: 12%;">
                           Vat rate 
                     </td>
                     <td style="width: 18%">
                            <gw:textbox id="txtVatRate" styles="width:100%;" onenterkey="OnCalVat()" onblur="OnCalVat()"/>
                     </td>
                     <td align="right" style="width: 12%;">
                            Vat AMT  
                     </td>
                     <td colspan="4" style="width: 28%">
                            <gw:textbox id="txtVatAMT" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="OnTotalAmt()"/>
                     </td>                   
                </tr>       
                <tr>
                    <td align="right" style="width: 12%;">
                            Net WT
                     </td>
                     <td style="width: 18%">                 
                          <gw:textbox id="txtNetWT"  styles="width:100%;" type="number" format="###,###,###,###.#R" /> 
                     </td>
                      <td align="right" style="width: 12%;">              
                           Mark
                     </td>
                     <td style="width: 18%">                        
                          <gw:textbox id="txtSign" styles="width:100%;"  />     
                     </td>
                     <td align="right" style="width: 12%;">                          
                         Total AMT</td>
                     <td colspan="4" style="width: 28%">
                          <gw:textbox id="txtTotalAMT" styles="width:100%;" type="number" format="###,###.#R"/>   
                     </td> 
                                    
                </tr>
                  <tr>
                     <td align="right" style="width: 12%;">
                             Remark
                     </td>
                     
                     <td colspan="8" style="width: 28%">
                        <gw:textbox id="txtRemark" styles="width:100%;"  />    
                     </td> 
                                    
                </tr>
            </table>
           </td>
           </tr>
              
        <tr style="height: 5%">
        <td>
            <table style="width: 100%; height: 100%">
                <tr>
                    <td align="right" style="width: 5%; ">
                                   Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    <td align="right" style="width: 10%;">
                                    Slip No/ L/C No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSearchNo" styles="width:100%;"  />
                           
                     </td>
                      <td align="right" style="width: 5%;">
                                   
                     </td>
                      <td style="width: 15%">
                          
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
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
        <tr style="height: 55%">
        <td style="width: 100%">
        <gw:grid id='grdInsurance'
        header='_PK|Slip No|BL No|Invoice No|L/C No|Shipment DT|Ship Company|Stored Fact.|Arrival DT|Vessel Name|Income DT|Shipment Port|Arrival Port|Invoice AMT|_EXCHANGE_RATE|Exchange AMT|Spec|Sign|Gross WT|Tare WT|Net WT|Num of Rod|Remark'
        format='0|0|0|0|0|4|0|0|4|0|4|0|0|1|1|1|0|0|1|1|1|0|0'
        aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        check='||||||||||||||||||||||'
        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        widths='0|1500|1500|1500|1300|1200|1500|1500|1200|1500|1200|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
        sorting='T'    
        acceptnulldate ="true"
        oncellclick="OnSearch('Master')" 
        styles='width:100%; height:100%'
        />
        
        </td>               
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
