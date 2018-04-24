<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Charge C</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_Charge_C_pk = 0;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>"; 
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";

     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
    txtACCSlipNo.SetEnable(false)    
   //---------------------------- 
    BindingDataList(); 
    data_kblc00080_1.StatusInsert();
    data_kblc00080.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
    var data = "";   
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0040' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstStoredFact.SetDataText(data); 
    lstStoredFact.value = '' ; 
    var data1 = "";   
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0080' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstIssueBy.SetDataText(data1); 
    lstIssueBy.value = '' ; 
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy.SetDataText(data); 
    lstCCy.value = 'USD' ;     
	
 } 
 //==================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'FACTORY':
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
            case 'ISSUEBY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0080";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0070';
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
        case 'grdChargeC':
            data_kblc00080.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdChargeC.GetGridData(grdChargeC.row,G_Charge_C_pk);
            data_kblc00080_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0040')
             {
                lstStoredFact.SetDataText(txtLGCodeList.text);  
                lstStoredFact.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0080')
             {
                lstIssueBy.SetDataText(txtLGCodeList.text);  
                lstIssueBy.value = rtnLGCode;                      
             }
        break;
      case 'data_kblc00080_1':
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
                data_kblc00080.Call('SELECT');
            }
      break;
      
      case 'data_kblc00080':
            lblRecord.text  = ( grdChargeC.rows -1 )+ " record(s)."
      break;
      
     case 'pro_kblc00080':
        alert(txtReturnValue.text);
        data_kblc00080_1.Call('SELECT')
      break;
      case 'pro_kblc00080_1':
        alert(txtReturnValue.text);
        data_kblc00080_1.Call('SELECT')
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
    if(data_kblc00080_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00080_1.Call();  
        }
           
    }else
    {    
        data_kblc00080_1.Call();                
    }

}
function OnAddNew()
{
    data_kblc00080_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00080_1.StatusDelete();
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
                pro_kblc00080.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
        break;
        case "CANCEL" :
            if(txtMasterPK.text !="")
                {
                    pro_kblc00080_1.Call();
                }else
                {
                    alert("Please, select a slip to Cancel!");
                }
        break;
        case "SLIP" :
                if(txtMasterPK.text !="")
            {
                pro_kblc00080_2.Call();
            }else
            {
                alert("Please, select a slip to Make Slip!");
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
    <gw:data id="data_kblc00080" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00080"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>				
					<input	bind="txtSearchNo"	/>	
				</input>	
				<output	bind="grdChargeC"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00080_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6"	function="<%=l_user%>lg_sel_kblc00080_1"	procedure="<%=l_user%>lg_upd_kblc00080_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="lstIssueBy"	/>						
						<inout	bind="lstStoredFact"	/>
						<inout	bind="dtPaymentDT"	/>															
						<inout	bind="txtInpecFees"	/>	
						<inout	bind="lstCCy"	/>	
						<inout	bind="lblStatus"	/>			
						<inout	bind="txtACCSlipNo"	/>				
																	
				</inout>
			</dso>	
		</xml>	
	</gw:data>
       <!--------------------------------------Thuc hien approve ------------------------------->
    <gw:data id="pro_kblc00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00080" > 
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
    <gw:data id="pro_kblc00080_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00080_1" > 
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
    <gw:data id="pro_kblc00080_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00080_2" > 
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
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 10%">
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
                  <td align="right" style="width: 12%;" ><a onclick="OnShowPopup('ISSUEBY')" href="#tips" style="color: #0000ff">
                               Payment by </a>
                 </td>
                  <td style="width: 18%">
                      <gw:list id="lstIssueBy" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;"><a onclick="OnShowPopup('FACTORY')" href="#tips" style="color: #0000ff">
                       Stored Fact</a>
                 </td>
                 <td colspan="4" style="width: 23%">
                      <gw:list id="lstStoredFact" styles="width:100%;" />
                 </td>                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">Payment Date
                 </td>
                  <td style="width: 23%">
                       <gw:datebox id="dtPaymentDT" lang="1"  />
                 </td>                
                  <td align="right" style="width: 12%; ">
                       Inspection fees
                 </td>
                  <td style="width: 18%">
                        <gw:textbox id="txtInpecFees" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>
                  <td align="right" style="width: 12%;">
                      CCY       
                 </td>
                  <td colspan="4" style="width: 23%">
                      <gw:list id="lstCCy" styles="width:100%;" /> 
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
                                    Search No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSearchNo" styles="width:100%;"  />
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdChargeC')" />
                     </td>
                      <td style="width: 2%">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                      </td>
                </tr>
            </table>
        </td>
                
        </tr>
        <tr style="height: 80%">
        <td colspan="8">
        <gw:grid id='grdChargeC'
            header='_PK|Slip NO|Payment By|Stored Fact|Payment Date|Inspection Fees|CCY|Status|ACC Slip No'
            format='0|0|0|0|4|1|0|0|0'
            aligns='0|0|1|1|1|0|0|0|0'
            check='||||||||'
            editcol='0|0|0|0|0|0|0|0|0'
            widths='0|1500|3000|2500|2500|1500|1500|1500|1500'
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

<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />

</html>
