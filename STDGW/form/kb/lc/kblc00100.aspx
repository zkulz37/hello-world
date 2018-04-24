<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>CLAIM 청구입금</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_Pay_Claim_pk = 0;
var rtnLGCode = '' ;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";   
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";
 
   //---------------------------- 
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;     
   
    txtACCSlipNo.SetEnable(false)    
    
    BindingDataList(); 
    data_kblc00100_1.StatusInsert();
    data_kblc00100.Call('SELECT')
}
 //==================================================================================
 
 function BindingDataList()
 {                
	 var data= ""; 
	    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0110' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstGLType.SetDataText(data); 
    lstGLType.value = 'L' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstShipper.SetDataText( data);
    lstShipper.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstShipComp.SetDataText( data);
    lstShipComp.value = '' ;
    	
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0090' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstAgent.SetDataText( data);
    lstAgent.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstInspecComp.SetDataText( data);
    lstInspecComp.value = '' ; 
    
    data = "Data|Y|Yes|N|No";
    lstPayment.SetDataText( data);
    lstPayment.value = 'Y' ; 
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy.SetDataText(data); 
    		 
 }
 //==================================================================================
 function OnPopup(obj)
 {
    switch(obj)
        {
            case 'G/LTYPE':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0110";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        
	                     if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGKB0110';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstGLType.value = object[1];      
	                    }    	                
	                 }                              
                break;    
             case 'SHIPPER':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0070";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'IEBS0070';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstShipper.value = object[1];      
	                    }    	                
	                 }                              
                break;    
                case 'SHIP_COMP':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0030";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
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
                case 'AGENT':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0090";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGKB0090';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstAgent.value = object[1];      
	                    }    	                
	                 }                              
                break;
                case 'INSPEC_COMP':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0100";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGKB0100';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstInspecComp.value = object[1];      
	                    }    	                
	                 }                
	           break; 
	             case 'PRODUCT':
                var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {
                     txtProdPK.text = object[0];
                    txtProdName.text = object[2]; 	
                 }                        
            break;   
             case 'INSPEC_NO':
                var path = System.RootURL + "/form/kb/lc/kblc00101.aspx";
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {
                     txtInspecNoPK.text = object[0];
                     txtInspecNo.text = object[1];
                     txtContractNo.text = object[2];
                     txtInvoiceNo.text = object[3];
                     txtProdName.text = object[4];
                     txtUnitPrice.text = object[5]; 
                     lstShipper.value = object[8];
                     lstInspecComp.value = object[10];
                     txtSign.text = object[15];
                     txtNumOfRod.text = object[16];
                     txtDocNetWT.text = object[19];
                     txtInsNetWT.text = object[17];
                     txtGapNetWT.text = object[21];
                     txtClaimAMT.text = Number(txtGapNetWT.text)* Number(txtUnitPrice.text)
                 }                        
            break;  
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdPayClaim':
            data_kblc00100.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdPayClaim.GetGridData(grdPayClaim.row,G_Pay_Claim_pk);
            data_kblc00100_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case 'data_kblc00100_1':
            if (lblStatus.text == 'SAVE'||lblStatus.text == 'CANCEL')
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
               }
            }
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00100.Call('SELECT');
            }
      break;
      
      case 'data_kblc00100':
            lblRecord.text  = ( grdPayClaim.rows -1 )+ " record(s)."
      break;
      
       case 'pro_kblc00100':
        alert(txtReturnValue.text);
        data_kblc00100_1.Call('SELECT')
      break;
      case 'pro_kblc00100_1':
        alert(txtReturnValue.text);
        data_kblc00100_1.Call('SELECT')
      break;
        
    }
}
//====================================================================================

function Validate()
{       
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00100_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00100_1.Call();  
        }
           
    }else
    {    
        data_kblc00100_1.Call();                
    }

}
function OnAddNew()
{
    data_kblc00100_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00100_1.StatusDelete();
       OnSave();
    }
 }
  //====================================================================================
//====================================================================================
function OnProcess(obj)
{
       switch(obj)
     {   
        case "APPROVE" :
            if(txtMasterPK.text !="")
            {
                pro_kblc00100.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
        break;
        case "CANCEL" :
            if(txtMasterPK.text !="")
                {
                    pro_kblc00100_1.Call();
                }else
                {
                    alert("Please, select a slip to Cancel!");
                }
        break;
        case "SLIP" :
                if(txtMasterPK.text !="")
            {
                pro_kblc00100_2.Call();
            }else
            {
                alert("Please, select a slip to Make Slip!");
            }
        break;
     }
 
}
//====================================================================================  
function CalNetWt()
{
    txtGapNetWT.text = Number(txtDocNetWT.text) - Number(txtInsNetWT.text)
}    
//====================================================================================
function CalClaimAmt()
{
    txtClaimAMT.text = Number(txtGapNetWT.text)* Number(txtUnitPrice.text)
}    
//====================================================================================
function CalGainLossRate()
{
    txtGLRate.text = Number(txtDeposit.text) / Number(txtClaimAMT.text)
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
    <gw:data id="data_kblc00100" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00100"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>				
					<input	bind="txtSearchNo"	/>	
				</input>	
				<output	bind="grdPayClaim"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00100_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24"	function="<%=l_user%>lg_sel_kblc00100_1"	procedure="<%=l_user%>lg_upd_kblc00100_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtInspecNoPK"	/>
						<inout	bind="txtInspecNo"	/>
						
						<inout	bind="lstGLType"	/>
						<inout	bind="dtClaimDT"	/>
						
						<inout	bind="lstShipper"	/>
						<inout	bind="txtContractNo"	/>					
						<inout	bind="lstShipComp"	/>
						
						<inout	bind="lstAgent"	/>
						<inout	bind="txtInvoiceNo"	/>
						<inout	bind="lstInspecComp"	/>
	
                        <inout	bind="txtProdName"	/>	
						<inout	bind="txtSign"	/>
						<inout	bind="txtNumOfRod"	/>	
						
						<inout	bind="txtDocNetWT"	/>
						<inout	bind="txtInsNetWT"	/>
						<inout	bind="txtGapNetWT"	/>
						
						<inout	bind="lstPayment"	/>
						<inout	bind="txtGLRate"	/>
						<inout	bind="dtDepositDT"	/>					
						<inout	bind="txtDeposit"	/>					
						<inout	bind="txtUnitPrice"	/>
						<inout	bind="txtClaimAMT"	/>	
						<inout	bind="lstCCy"	/>		
						<inout	bind="lblStatus"	/>			
						<inout	bind="txtACCSlipNo"	/>							
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	<!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00100" > 
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
    <gw:data id="pro_kblc00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00100_1" > 
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
    <gw:data id="pro_kblc00100_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00100_2" > 
                <input>
                    <input bind="txtMasterPK" />
                    <input bind="txtCompany_PK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
        <td>
        <table style="width: 100%; height: 100%">
            <tr style="height: 1%">
                <td style="width: 12%" colspan="11">
                    <table>
                        <tr>
                          <td style="width: 30%">                               
                                
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
                                <td align="right" style="width: 10%;">
                                    ACC SlipNo
                                </td>
                                <td style="width: 15%">
                                       <gw:textbox id="txtACCSlipNo" styles="width:100%;"  />
                                </td>  
                                <td style="width: 15%" align="center">
                                    <gw:label id="lblStatus"  text="" styles="color:red"/>
                                 </td>        
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
            <tr>
                <td align="right" style="width: 12%;">
                                Slip No
                 </td>
                  <td style="width: 18%" >
                       <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory"/>
                 </td>
                  <td align="right" style="width: 12%;" ><a onclick="OnPopup('INSPEC_NO')" href="#tips" style="color: #0000ff">
                               Inspection No</a>
                 </td>
                  <td style="width: 23%" colspan=2>
                      <gw:textbox id="txtInspecNoPK" text="" style="display: none" />  
                      <gw:textbox id="txtInspecNo" csstype="mandatory" styles="width:100%;" readonly="true" />    
                 </td>
                  <td align="right" style="width: 12%;">  
                 </td>
                 <td colspan="4" style="width: 23%">    
                 </td>                 
            </tr>
             <tr>
                <td align="right" style="width: 12%;"><a onclick="OnPopup('G/LTYPE')" href="#tips" style="color: #0000ff">
                               Gain/Loss Type</a>          
                 </td>
                  <td style="width: 18%" >
                        <gw:list id="lstGLType" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;" >
                  Claim date
                 </td>
                  <td style="width: 23%" colspan=2>
                      <gw:datebox id="dtClaimDT" lang="1"  />
                 </td>
                  <td align="right" style="width: 12%;">
                       
                 </td>
                 <td colspan="4" style="width: 23%">
                    
                 </td>                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;"><a onclick="OnPopup('SHIPPER')" href="#tips" style="color: #0000ff">
                            Shipper</a>
                 </td>
                  <td style="width: 18%">
                       <gw:list id="lstShipper" styles="width:100%;" />
                 </td>                
                  <td align="right" style="width: 12%; ">
                      P/O No
                 </td>
                  <td style="width: 23%" colspan=2>
                      <gw:textbox id="txtContractNo" styles="width:100%;" /> 
                 </td>
                  <td align="right" style="width: 12%;"><a onclick="OnPopup('SHIP_COMP')" href="#tips" style="color: #0000ff">
                     Shipping company </a>                      
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:list id="lstShipComp" styles="width:100%;" />
                 </td>
                 
            </tr>
           <tr>
                 <td align="right" style="width: 12%;"><a onclick="OnPopup('AGENT')" href="#tips" style="color: #0000ff">
                            Agent</a>
                 </td>
                  <td style="width: 18%">
                       <gw:list id="lstAgent" styles="width:100%;" />
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Invioce No
                 </td>
                  <td style="width: 23%" colspan="2">
                        <gw:textbox id="txtInvoiceNo" styles="width:100%;"/> 
                 </td>
                  <td align="right" style="width: 12%;"><a onclick="OnPopup('INSPEC_COMP')" href="#tips" style="color: #0000ff">
                        Inspection company </a>    
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:list id="lstInspecComp" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                    Product's name
                 </td>
                  <td style="width: 18%">         
                       <gw:textbox id="txtProdName" styles="width:100%;"/>
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Mark
                 </td>
                  <td style="width: 23%" colspan=2>
                       <gw:textbox id="txtSign" styles="width:100%;"/>
                 </td>
                  <td align="right" style="width: 12%;">
                            Number of rod
                 </td>
                  <td colspan="4" style="width: 23%">
                         <gw:textbox id="txtNumOfRod" styles="width:100%;"/>
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">Doc Net WT
                 </td>
                  <td style="width: 15%">
                       <gw:textbox id="txtDocNetWT" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="CalNetWt()" onchange="CalNetWt()" />
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Payment YN
                 </td>
                  <td style="width: 23%" colspan=2>
                       <gw:list id="lstPayment" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;">
                          Gain/Loss rate
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtGLRate" styles="width:100%;" type="number" format="###,###,###,###.##R"/> 
                 </td>
                 
            </tr>
             <tr>
                 <td align="right" style="width: 12%;">Ins Net WT</td>
                  <td style="width:15%">
                       <gw:textbox id="txtInsNetWT" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="CalNetWt()" onchange="CalNetWt()"/>
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Deposit date 
                 </td>
                  <td style="width: 23%" colspan=2>
                       <gw:datebox id="dtDepositDT" lang="1"  />
                 </td>
                  <td align="right" style="width: 12%;">
                         Receive Amt   
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtDeposit" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="CalGainLossRate()" onchange="CalGainLossRate()"/> 
                 </td>
                 
            </tr>
            <tr>        
                 <td align="right" style="width: 15%;">
                                Gap Net WT
                 </td>
                  <td style="width: 15%">
                       <gw:textbox id="txtGapNetWT" styles="width:100%;" type="number" format="###,###,###,###.#R" onblur="CalClaimAmt()" onchange="CalClaimAmt()" />
                 </td>
                  <td align="right" style="width: 12%;">
                                Unit price
                 </td>
                  <td style="width: 15%" >
                       <gw:textbox id="txtUnitPrice" styles="width:100%; " type="number" format="###,###,###,###.#R" onblur="CalClaimAmt()" onchange="CalClaimAmt()" />
                 </td>
                 <td>
                    <gw:list id="lstCCy" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 15%; ">
                                Claim amount
                 </td>
                  <td colspan="4" style="width: 18%">
                        <gw:textbox id="txtClaimAMT" styles="width:100%;" type="number" format="###,###.#R" />
                 </td>
            
            </tr>
           </table> 
        
            </td> 
        </tr>
        <tr style="height: 10%">
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
                                    Slip No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSearchNo" styles="width:100%;"  />
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdPayClaim')" />
                     </td>
                      <td style="width: 2%">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                      </td>
                </tr>
            </table>
        </td>
                
        </tr>
        <tr style="height: 70%">
        <td colspan="8">
        <gw:grid id='grdPayClaim'
            header='_PK|Slip NO|_TLG_KB_RAW_INSPECTION_PK|G/L Type|Claim Date|Shipper|Agent|PO No|Invoice No|Shipping Comp|Inspec Comp|Item Name|Sign|Nun of Rod|Doc NW(LB)|Ins WT(LB)|Gap WT(LB)|Unit Price|Claim AMT|Payment YN|Deposit Date|Deposit|G/L Rate|Status|ACC Slip No'
            format='1|0|1|0|4|0|0|0|0|0|0|0|0|0|1|1|1|1|1|0|4|1|1|1|1'
            aligns='0|1|0|0|1|1|1|1|1|1|1|1|0|1|0|0|0|0|0|1|1|0|0|1|1'
            check='||||||||||||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1200|0|1300|1300|1300|1300|1500|1500|2000|2000|3000|1300|1300|1500|1500|1500|1500|1500|1200|1300|1200|1200|1200|1200'
            sorting='T'
            styles='width:100%; height:100%'oncellclick="OnSearch('Master')"/>
        
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
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />

<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
</html>
