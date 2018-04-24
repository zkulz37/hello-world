<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Usuance</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_Usance_C_pk = 0;
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
    data_kblc00090_1.StatusInsert();
    data_kblc00090.Call('SELECT')
}
  function BindingDataList()
 {  
     var data = "";   
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy1.SetDataText(data); 
    lstCCy1.value = '' ;       
    lstCCy2.SetDataText(data); 
    lstCCy2.value = '' ;
    lstCCy3.SetDataText(data); 
    lstCCy3.value = '' ;
    lstCCy4.SetDataText(data); 
    lstCCy4.value = '' ;
    lstCCy5.SetDataText(data); 
    lstCCy5.value = '' ; 
 }
 //==================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
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
        case 'grdUsance':
            data_kblc00090.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdUsance.GetGridData(grdUsance.row,G_Usance_C_pk);
            data_kblc00090_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case 'data_kblc00090_1':
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
                data_kblc00090.Call('SELECT');
            }
      break;
      
      case 'data_kblc00090':
            lblRecord.text  = ( grdUsance.rows -1 )+ " record(s)."
      break;
     
      case 'pro_kblc00090':
        alert(txtReturnValue.text);
        data_kblc00090_1.Call('SELECT')
      break;
      case 'pro_kblc00090_1':
        alert(txtReturnValue.text);
        data_kblc00090_1.Call('SELECT')
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
    if(data_kblc00090_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00090_1.Call();  
        }
           
    }else
    {    
        data_kblc00090_1.Call();                
    }

}
function OnAddNew()
{
    data_kblc00090_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00090_1.StatusDelete();
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
                pro_kblc00090.Call();
            }else
            {
                alert("Please, select a slip to approve!");
            }
        break;
        case "CANCEL" :
            if(txtMasterPK.text !="")
                {
                    pro_kblc00090_1.Call();
                }else
                {
                    alert("Please, select a slip to Cancel!");
                }
        break;
        case "SLIP" :
                if(txtMasterPK.text !="")
            {
                pro_kblc00090_2.Call();
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
    
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00090" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00090"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>				
					<input	bind="txtSearchNo"	/>	
				</input>	
				<output	bind="grdUsance"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00090_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24"	function="<%=l_user%>lg_sel_kblc00090_1"	procedure="<%=l_user%>lg_upd_kblc00090_1">	
				<inout>	
									
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtNegoDT"	/>
						<inout	bind="dtDeadDT"	/>
						<inout	bind="txtArgAmout"	/>
						<inout	bind="txtRate"	/>					
						<inout	bind="txtADCHG"	/>
						<inout	bind="txtCalAmount"	/>
						<inout	bind="txtNumOfDay"	/>
						<inout	bind="dtRepayDT1"	/>
                        <inout	bind="txtRepayAMT1"	/>	
                        <inout	bind="lstCCy1"	/>
						<inout	bind="dtRepayDT2"	/>
                        <inout	bind="txtRepayAMT2"	/>	
                        <inout	bind="lstCCy4"	/>
						<inout	bind="dtRepayDT3"	/>
                        <inout	bind="txtRepayAMT3"	/>
                        <inout	bind="lstCCy3"	/>
                        <inout	bind="dtRepayDT4"	/>
                        <inout	bind="txtRepayAMT4"	/>	
                        <inout	bind="lstCCy4"	/>
                        <inout	bind="dtRepayDT5"	/>
                        <inout	bind="txtRepayAMT5"	/>		
                        <inout	bind="lstCCy5"	/>
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
    <gw:data id="pro_kblc00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00090" > 
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
    <gw:data id="pro_kblc00090_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00090_1" > 
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
    <gw:data id="pro_kblc00090_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kblc00090_2" > 
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
                  <td align="right" style="width: 15%;" >
                               NEGO date
                 </td>
                  <td style="width: 15%">
                      <gw:datebox id="dtNegoDT" lang="1"  />
                 </td>
                  <td align="right" style="width: 12%;">
                       Deadline date
                 </td>
                 <td colspan="4" style="width: 23%">
                     <gw:datebox id="dtDeadDT" lang="1"  />
                 </td>                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">Argument AMT
                 </td>
                  <td style="width: 18%">
                       <gw:textbox id="txtArgAmout" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>                
                  <td align="right" style="width: 15%; ">
                      Repayment DT (1)
                 </td>
                  <td style="width: 15%">
                       <gw:datebox id="dtRepayDT1" lang="1" nullaccept />
                 </td>
                  <td align="right" style="width: 12%;">
                      Repayment AMT (1)      
                 </td>
                  <td  colspan="2" style="width: 13%">
                        <gw:textbox id="txtRepayAMT1" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                  <td  style="width:10%" colspan="2">
                    <gw:list id="lstCCy1" styles="width:100%;" />
                 </td>
                 
            </tr>
           <tr>
                 <td align="right" style="width: 12%;">RATE
                 </td>
                  <td style="width: 18%">
                       <gw:textbox id="txtRate" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>                
                  <td align="right" style="width: 15%; ">
                      (2)
                 </td>
                  <td style="width: 15%">
                       <gw:datebox id="dtRepayDT2" lang="1" nullaccept />
                 </td>
                  <td align="right" style="width: 12%;">
                        (2)     
                 </td>
                  <td colspan="2" style="width: 13%">
                        <gw:textbox id="txtRepayAMT2" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                  <td  style="width: 10%" colspan="2">
                    <gw:list id="lstCCy2" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">A/D CHG
                 </td>
                  <td style="width: 18%">
                       <gw:textbox id="txtADCHG" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>                
                  <td align="right" style="width: 15%; ">
                      (3)
                 </td>
                  <td style="width: 15%">
                       <gw:datebox id="dtRepayDT3" lang="1" nullaccept  />
                 </td>
                  <td align="right" style="width: 12%;">
                            (3) 
                 </td>
                  <td colspan="2" style="width:13%">
                        <gw:textbox id="txtRepayAMT3" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                  <td  style="width:10%" colspan="2">
                    <gw:list id="lstCCy3" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">Interest cal AMT
                 </td>
                  <td style="width: 18%">
                       <gw:textbox id="txtCalAmount" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>                
                  <td align="right" style="width: 15%; ">
                      (4)
                 </td>
                  <td style="width: 15%">
                       <gw:datebox id="dtRepayDT4" lang="1" nullaccept />
                 </td>
                  <td align="right" style="width: 12%;">
                            (4) 
                 </td>
                  <td colspan="2" style="width: 13%">
                        <gw:textbox id="txtRepayAMT4" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                  <td  style="width: 10%" colspan="2">
                    <gw:list id="lstCCy4" styles="width:100%;" />
                 </td>
                 
            </tr>
             <tr>
                 <td align="right" style="width: 12%;">Number of days
                 </td>
                  <td style="width: 18%">
                       <gw:textbox id="txtNumOfDay" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>                
                  <td align="right" style="width: 15%; ">
                      (5)
                 </td>
                  <td style="width: 15%">
                       <gw:datebox id="dtRepayDT5" lang="1"  nullaccept />
                 </td>
                  <td align="right" style="width: 12%;">
                          (5)   
                 </td>
                  <td colspan="2" style="width: 13%">
                        <gw:textbox id="txtRepayAMT5" styles="width:100%;" type="number" format="###,###,###,###.#R"/> 
                 </td>
                   <td  style="width: 10%" colspan="2">
                    <gw:list id="lstCCy5" styles="width:100%;" />
                 </td>
                 
            </tr>
            <tr>        
                 <td align="right" style="width: 15%;"><a onclick="OnShowPopup('LCNO')" href="#tips" style="color: #0000ff">
                                L/C No</a>
                 </td>
                  <td style="width: 18%">
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
                                   Dealine Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    
                      <td align="right" style="width: 10%;">
                                    Control No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSearchNo" styles="width:100%;"  />
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdUsance')" />
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
        <gw:grid id='grdUsance'
            header='_PK|Control No|L/C NO|Product NM|Qty|Interest Cal AMT|Argument AMT|RATE|A/D CHG|Num Of Day|NEGO Date|Repay Date 1|Repay AMT 1|CCY |Repay Date 2|Repay AMT 2|CCY |Repay Date 3|Repay AMT 3|CCY |Repay Date 4|Repay AMT 4|CCY |Repay Date 5|Repay AMT 5|CCY |Status|ACC Slip No'
            format='0|0|0|0|1|1|1|1|0|1|4|4|1|0|4|1|0|4|1|0|4|1|0|4|1|0|0|0'
            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            check='|||||||||||||||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1200|1300|2000|1300|1300|1300|1200|1200|1200|1200|1300|1500|800|1300|1500|800|1300|1500|800|1300|1500|800|1300|1500|800|1500|1500'
            sorting='T'
            autosize='T' 
            styles='width:100%; height:460'oncellclick="OnSearch('Master')"/>
        
        </td>               
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtLCNoPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />


</html>
