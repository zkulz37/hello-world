<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>CLEARANCE MANAGEMENT</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_ChargeB_pk = 0;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";

   //---------------------------- 
     txtACCSlipNo.SetEnable(false)
     
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
    //-------------------------
    BindingDataList();
    data_kblc00060_master.StatusInsert();
    data_kblc00060_search.Call('SELECT')
}

//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	 var data1 = "";      	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstTranCom.SetDataText(data); 
    lstTranCom.value = '' ;
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0180' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstIssueBy.SetDataText(data1); 
    lstIssueBy.value = '' ; 
    
    
 } 
 //==================================================================================
 function OnPopup(obj)
 {
    switch(obj)
        {
            
            case 'LCNO':
                 var path = System.RootURL + "/form/kb/lc/kblc00051.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNoPK.text   = object[0];
                    txtLCNo.text   = object[2];
                    txtProductName.text = object[8];
                    txtLCQty.text = object[10];                                              
                 }          
	       break; 
	       case 'TRANS_COMP':
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
	                    lstTranCom.value = object[1];      
	                }    	                
	             }                              
            break;
           
            case 'ISSUE_BY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0180";
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
	                    lstIssueBy.value = object[1];      
	                }    	                
	             }                              
            break;               
       }
 }


//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdChargeB':
            data_kblc00060_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdChargeB.GetGridData(grdChargeB.row,G_ChargeB_pk);
            data_kblc00060_master.Call("SELECT");
        break;
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_kblc00060_search':
            lblRecord.text  = ( grdChargeB.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00060_master':
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
                    data_kblc00060_search.Call('SELECT');
                }
        break;
       case 'pro_kblc00060':
        alert(txtReturnValue.text);
        data_kblc00060_master.Call('SELECT')
      break;
      case 'pro_kblc00060_1':
        alert(txtReturnValue.text);
        data_kblc00060_master.Call('SELECT')
      break;
    }
}
//====================================================================================

function Validate()
{   
   if(txtPayPro.text =="" )
    {
        alert("Please, input Payment Provision!");
        return false;
    }
    
     else if(txtCost.text =="" || txtCost.text =="0")
    {
        alert("Please, input Cost!");
        return false;
    }
    
     else if( txtContainer.text =="" )
    {
        alert("Please, input Container!");
        return false;
    }
    
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00060_master.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00060_master.Call();  
        }
           
    }else
    {    
        data_kblc00060_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00060_master.StatusInsert();
    
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00060_master.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function OnProcess(obj)
{
    
     switch(obj)
     {   
        case "APPROVE" :
             if(txtMasterPK.text !="")
        {
            pro_kblc00060.Call();
        }else
        {
            alert("Please, select an insurance slip to approve!");
        }
        break;
        case "CANCEL" :
              if(txtMasterPK.text !="")
            {
                pro_kblc00060_1.Call();
            }else
            {
                alert("Please, select an insurance slip to Cancel!");
            }
        break;
        case "SLIP" :
              if(txtMasterPK.text !="")
            {
                pro_kblc00060_2.Call();
            }else
            {
                alert("Please, select an insurance slip to make slip!");
            }
        break;
      }  
}       
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
    <gw:data id="data_kblc00060_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00060"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtControlSearch"	/>	
					<input	bind="txtPaymentBy"	/>
					
				</input>	
				<output	bind="grdChargeB"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00060_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9"	function="<%=l_user%>lg_sel_kblc00060_1"	procedure="<%=l_user%>lg_upd_kblc00060_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtControlNo"	/>
						<inout	bind="txtPayPro"	/>
						<inout	bind="dtPayment"	/>
						<inout	bind="lstTranCom"	/>
						<inout	bind="lstIssueBy"	/>					
						<inout	bind="txtCost"	/>				
						<inout	bind="txtVat"	/>
						<inout	bind="txtContainer"	/>					
						<inout	bind="txtLCNoPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtProductName"	/>
						<inout	bind="txtLCQty"	/>	
						<inout	bind="lblStatus"	/>			
						<inout	bind="txtACCSlipNo"	/>											
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	 <!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00060" > 
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
    <gw:data id="pro_kblc00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00060_1" > 
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
    <gw:data id="pro_kblc00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00060_2" > 
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
                <td align="right" style="width: 15%;">
                                Slip No
                 </td>
                  <td style="width: 20%">
                       <gw:textbox id="txtControlNo" styles="width:100%;" csstype="mandatory"/>
                 </td>
                  <td align="right" style="width: 15%;">
                                Payment provision
                 </td>
                  <td style="width: 17%">
                       <gw:textbox id="txtPayPro" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 15%; ">
                 </td>
                  <td colspan="4" style="width: 18%">
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">
                                Payment date
                 </td>
                  <td style="width: 20%">
                       <gw:datebox id="dtPayment" lang="1" />
                 </td>
                  <td align="right" style="width: 15%; "><a onclick="OnPopup('TRANS_COMP')" href="#tips" style="color: #0000ff">
                                Transport company</a>
                 </td>
                  <td style="width: 17%">
                      <gw:list id="lstTranCom" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 15%;"><a onclick="OnPopup('ISSUE_BY')" href="#tips" style="color: #0000ff">
                                Issue by</a>
                 </td>
                  <td colspan="4" style="width: 18%">
                       <gw:list id="lstIssueBy" styles="width:100%;" />
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">
                                Charge
                 </td>
                  <td style="width: 20%">
                       <gw:textbox id="txtCost" styles="width:100%;" type="number" format="###,###.#R"/>
                 </td>
                  <td align="right" style="width: 15%;">
                                VAT
                 </td>
                  <td style="width: 17%">
                      <gw:textbox id="txtVat" styles="width:100%;" type="number" format="###,###.#R"/>
                 </td>
                 <td align="right" style="width: 15%;">
                                Container 
                 </td>
                  <td colspan="4" style="width: 18%">
                    <gw:textbox id="txtContainer" styles="width:100%;" />
                  </td>
            </tr>
            
             
            <tr>        
                 <td align="right" style="width: 15%;"><a onclick="OnPopup('LCNO')" href="#tips" style="color: #0000ff">
                                L/C No</a>
                 </td>
                  <td style="width: 20%">
                       <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />
                 </td>
                  <td align="right" style="width: 15%;">
                                Product name
                 </td>
                  <td style="width: 17%">
                       <gw:textbox id="txtProductName" csstype="mandatory" styles="width:100%; " readonly="true" />
                 </td>
                 <td align="right" style="width: 15%; ">
                                Quantity
                 </td>
                  <td colspan="4" style="width: 18%">
                        <gw:textbox id="txtLCQty" csstype="mandatory" styles="width:100%;" readonly="true" type="number" format="###,###.#R" />
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
                    <td align="right" style="width: 15%;">
                                    Slip No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtControlSearch" styles="width:100%;" />
                     </td>
                     <td align="right" style="width: 10%;">
                                    Payment by
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtPaymentBy" styles="width:100%;" />
                     </td>
                           
                    
                      <td align="right" style="width: 10%;">
                     </td>
                      
                     <td style="width: 10%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                       <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdChargeB')" />
                     </td>
                      <td style="width: 2%">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                        </td>
                </tr>
            </table>
        </td>
                
        </tr>
        
        <tr style="height: 72%">
        <td colspan="8">
            <gw:grid id='grdChargeB'
                header='_PK|Slip NO|L/C NO|Product Name|Quantity|Issue By|Payment Provision|Cost|VAT|Container|STATUS|ACC Slip'
                format='1|0|0|0|1|0|0|1|1|0|1|0'
                aligns='0|1|1|1|0|1|1|0|0|1|1|0'
                check='|||||||||||'
                editcol='0|0|0|0|0|0|0|1|0|0|1|0'
                widths='1000|1200|1200|2500|1500|1500|2000|1500|1000|1500|1000|1500'
                sorting='T' styles='width:100%; height:100%'oncellclick="OnSearch('Master')"/>
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
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />

<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
</html>
