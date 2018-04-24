<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>비용관리(CLAIM입송금연락전)</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_Remit_Claim_pk = 0;
var rtnLGCode = '' ;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";    
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";

    txtACCSlipNo.SetEnable(false)  
   //---------------------------- 
    BindingDataList(); 
    data_kblc00110_1.StatusInsert();
    data_kblc00110.Call('SELECT')
}
 //==================================================================================
 
 function BindingDataList()
 {                
	 var data1= ""; 
	 var data2= "";    
	    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0110' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstGLType.SetDataText(data1); 
    lstGLType.value = '' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstShipper.SetDataText( data2);
    lstShipper.value = '' ;
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0010' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstBank.SetDataText( data1);
    lstBank.value = '10' ;
      		 
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
	                    alert(object[0])	                   
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
	                    alert(object[0])	                   
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
                
                  case 'BANK':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0010";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        
	                    alert(object[0])	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'IEBS0010';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstBank.value = object[1];      
	                    }    	                
	                 }                              
                break;     
                 case 'LCNO':
                 var path = System.RootURL + "/form/kb/lc/kblc00041.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNoPK.text   = object[0];
                    txtLCNo.text   = object[2];
                    txtProductName.text = object[8];
                    txtLCQty.text = object[10];                                              
                 }          
	       break;    
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdRemitClaim':
            data_kblc00110.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdRemitClaim.GetGridData(grdRemitClaim.row,G_Remit_Claim_pk);
            data_kblc00110_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case 'data_kblc00110_1':
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
                data_kblc00110.Call('SELECT');
            }
      break;
      
      case 'data_kblc00110':
            lblRecord.text  = ( grdRemitClaim.rows -1 )+ " record(s)."
      break;
      
        case 'pro_kblc00110':
        alert(txtReturnValue.text);
        data_kblc00110_1.Call('SELECT')
      break;
      case 'pro_kblc00110_1':
        alert(txtReturnValue.text);
        data_kblc00110_1.Call('SELECT')
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
    if(data_kblc00110_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00110_1.Call();  
        }
           
    }else
    {    
        data_kblc00110_1.Call();                
    }

}
function OnAddNew()
{
    data_kblc00110_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00110_1.StatusDelete();
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
                pro_kblc00110.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
        break;
        case "CANCEL" :
            if(txtMasterPK.text !="")
                {
                    pro_kblc00110_1.Call();
                }else
                {
                    alert("Please, select a slip to Cancel!");
                }
        break;
        case "SLIP" :
                if(txtMasterPK.text !="")
            {
                pro_kblc00110_2.Call();
            }else
            {
                alert("Please, select a slip to Make Slip!");
            }
        break;
     }
  
    
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
    <gw:data id="data_kblc00110" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00110"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>				
					<input	bind="txtSlipNoSearch"	/>
						
				</input>	
				<output	bind="grdRemitClaim"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00110_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,8,9,10,11,12,13,14,15,16"	function="<%=l_user%>lg_sel_kblc00110_1"	procedure="<%=l_user%>lg_upd_kblc00110_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtDisDT"	/>
						<inout	bind="dtReqDT"	/>
						
						<inout	bind="txtLCNoPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtProductName"	/>
						<inout	bind="txtLCQty"	/>	
						
						<inout	bind="lstShipper"	/>
						<inout	bind="lstGLType"	/>
						<inout	bind="txtDeposit"	/>
						
						<inout	bind="txtRemit"	/>
						<inout	bind="txtGap"	/>
						<inout	bind="txtReason"	/>
						<inout	bind="lstBank"	/>	
						<inout	bind="txtCommis"	/>
						<inout	bind="txtRemitNum"	/>	
						
						<inout	bind="lblStatus"	/>			
						<inout	bind="txtACCSlipNo"	/>						
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	<!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00110" > 
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
    <gw:data id="pro_kblc00110_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00110_1" > 
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
    <gw:data id="pro_kblc000110_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00110_2" > 
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
                  <td style="width: 23%" >
                       <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory"/>
                 </td>
                  <td align="right" style="width: 15%;" >
                               Disposal date
                 </td>
                  <td style="width: 15%">
                     <gw:datebox id="dtDisDT" lang="1"  />
                 </td>
                  <td align="right" style="width: 12%;">
                       Requisition date
                 </td>
                 <td colspan="4" style="width: 23%">
                     <gw:datebox id="dtReqDT" lang="1"  />
                 </td>                 
            </tr>
            <tr>        
                 <td align="right" style="width: 12%;"><a onclick="OnPopup('LCNO')" href="#tips" style="color: #0000ff">
                                L/C No</a>
                 </td>
                  <td style="width: 23%">
                       <gw:textbox id="txtLCNo" styles="width:100%;" readonly="true" />
                 </td>
                  <td align="right" style="width: 15%;">
                               Item
                 </td>
                  <td style="width: 15%">
                       <gw:textbox id="txtProductName" styles="width:100%; " readonly="true" />
                 </td>
                 <td align="right" style="width: 12%; ">
                                Quantity
                 </td>
                  <td colspan="4" style="width:23%">
                        <gw:textbox id="txtLCQty" styles="width:100%;" readonly="true" type="number" format="###,###.#R" />
                 </td>
            
            </tr>
            <tr>
                 <td align="right" style="width: 12%;"><a onclick="OnPopup('SHIPPER')" href="#tips" style="color: #0000ff">
                            Shipper</a>
                 </td>
                  <td style="width: 23%">
                       <gw:list id="lstShipper" styles="width:100%;" />
                 </td>                
                  <td align="right" style="width: 15%; "><a onclick="OnPopup('G/LTYPE')" href="#tips" style="color: #0000ff">
                      G/L Type</a>
                 </td>
                  <td style="width: 15%">
                     <gw:list id="lstGLType" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;">
                     Received AMT(Loss)                      
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtDeposit" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                 
            </tr>
           <tr>
               <td align="right" style="width: 12%;">
                              <a onclick="OnPopup('BANK')" href="#tips" style="color: #0000ff">Bank</a>
                     </td>
                      <td style="width: 23%">
                            <gw:list id="lstBank" styles="width:100%;" />
                     </td>
                                   
                      <td align="right" style="width: 15%; ">
                          Commission
                     </td>
                      <td style="width: 15%">
                         <gw:textbox id="txtCommis" styles="width:100%;"/>                           
                     </td>
                      <td align="right" style="width: 12%;">
                         Pay Amt
                     </td>
                      <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtRemit" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                     </td>
                     
           </tr>          
            
            <tr>
                  <td align="right" style="width: 12%; ">
                        Ref No
                 </td>
                  <td style="width: 23%">
                       <gw:textbox id="txtRemitNum" styles="width:100%;" />                       
                 </td>                
                  <td align="right" style="width: 15%; ">
                         Gap reason   
                 </td>
                  <td style="width: 15%">
                         <gw:textbox id="txtReason" styles="width:100%;"/> 
                 </td>
                  <td align="right" style="width: 12%;">
                         Gap
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtGap" styles="width:100%;" type="number" format="###,###,###,###.#R"/>                       
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
                    
                      <td align="right" style="width: 5%;">
                                    Slip No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSlipNoSearch" styles="width:100%;"  />
                     </td>
                     
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdRemitClaim')" />
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
        <gw:grid id='grdRemitClaim'
            header='_PK|Requisition Date|Slip NO|L/C NO|Item Name|Qty|Received Amt(Loss)|Pay Amt|Gap|Gap Reason|Bank|Commission|Ref No|Status|ACC Slip No'
            format='1|4|0|0|0|1|1|1|0|0|0|0|1|0|0'
            aligns='0|1|0|0|1|0|0|0|1|1|1|1|0|0|0'
            check='||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1500|1500|1500|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
            sorting='T'
            styles='width:100%; height:100%'oncellclick="OnSearch('Master')"/>
        
        </td>               
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtLCNoPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />

<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />

</html>
