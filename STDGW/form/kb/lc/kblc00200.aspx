<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>INSURANCE</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_Insurance_pk = 0;
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
    data_kblc00200_1.StatusInsert();
    data_kblc00200.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	 var data1= "";    
	      	
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0080' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstPayBy.SetDataText(data1); 
    lstPayBy.value = '' ;
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0170' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstPayPro.SetDataText(data1); 
    lstPayPro.value = '' ; 
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCy1.SetDataText(data1); 
    lstCCy1.value = 'USD' ;  
    lstCCy2.SetDataText(data1); 
    lstCCy2.value = 'USD' ;  
    
    data = "DATA|Y|Y|K|K";
    lstLGYN.SetDataText(data);       
 } 
 //==================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'PAY_BY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0080";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                alert(object[0])	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0080';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPayBy.value = object[1];      
	                }    	                
	             }                              
            break;    
            case 'PAY_PROV':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0170";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0170';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPayPro.value = object[1];      
	                }    	                
	             }                              
            break;    
            case 'LC':
                   
	             var path = System.RootURL + "/form/kb/lc/kblc00201.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNoPK.text   = object[0];
                    txtLCNo.text   = object[2];
                    txtRefNo.text =  object[4];                                        
                 }                                
            break;   
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdCharge':
            data_kblc00200.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdCharge.GetGridData(grdCharge.row,G_Insurance_pk);
            data_kblc00200_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0080')
             {
                lstPayBy.SetDataText(txtLGCodeList.text);
                lstPayBy.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0170')
             {
                lstPayPro.SetDataText(txtLGCodeList.text);  
                lstPayPro.value = rtnLGCode;                      
             }
      break;
      
      case 'data_kblc00200_1':
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00200.Call('SELECT');
            }
      break;
      
      case 'data_kblc00200':
            lblRecord.text  = ( grdCharge.rows -1 )+ " record(s)."
      break;
   
        
    }
}
//====================================================================================

function Validate()
{   
    if(txtBLNo.text =="")
    {
        alert("Please, input B/L No !")
        return false;
    }
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00200_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00200_1.Call();  
        }
           
    }else
    {    
        data_kblc00200_1.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00200_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00200_1.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function OnProcess(obj)
{
    if(obj=="APPROVE")
    {
        if(txtMasterPK.text !="")
        {
            pro_kblc00200.Call();
        }else
        {
            alert("Please, select an insurance slip to approve!");
        }
    }else
    {
         if(txtMasterPK.text !="")
        {
            pro_kblc00200_1.Call();
        }else
        {
            alert("Please, select an insurance slip to Cancel!");
        }
    }
    
} 
//====================================================================================
function OnCalDay()
{
    txtNumOfDay.text = Number(dtDeadLine.getDate()  - dtDocArr.getDate());
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
    <gw:data id="data_kblc00200" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00200"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtSlipNoSearch"	/>	
					<input	bind="txtPolicySearch"	/>	
				</input>	
				<output	bind="grdCharge"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00200_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"	function="<%=l_user%>lg_sel_kblc00200_1"	procedure="<%=l_user%>lg_upd_kblc00200_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtBLNo"	/>	
						<inout	bind="lstPayPro"	/>
						
						<inout	bind="txtLCNoPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtRefNo"	/>						
						<inout	bind="lstPayBy"	/>
                        <inout	bind="dtPayDate"/>                        
						<inout	bind="lstLGYN"	/>
						
						<inout	bind="dtDocArr"	/>
						<inout	bind="txtZipDay"	/>	
						<inout	bind="txtTTSell"	/>	
						<inout	bind="txtPayAmt1"	/>							
						<inout	bind="lstCCy1"	/>	
						
						<inout	bind="txtPayAmt2"	/>	
						<inout	bind="lstCCy2"	/>	
						<inout	bind="txtExRate"	/>	
						<inout	bind="dtDeadLine"	/>	
						<inout	bind="txtNumOfDay"	/>	
														
				</inout>
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
                          <td style="width: 45%">                               
                                
                                </td> 
                                <td style="width: 2%" align="right">
                                    
                                </td> 
                                <td style="width: 2%" align="right">
                                    
                                </td>  
                                <td align="right" style="width: 10%;">
                                    
                                </td>
                                <td style="width: 15%">
                                    
                                </td>  
                                <td style="width: 15%" align="center">
                                    
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
                  <td style="width: 18%" colspan="2">
                       <gw:textbox id="txtSlipNo" styles="width:100%;"/>
                 </td>
                  <td align="right" style="width: 12%;" >
                                B/L SEQ
                 </td>
                  <td style="width: 18%" colspan="2" >
                       <gw:textbox id="txtBLNo" styles="width:100%;"/>
                 </td>
                 <td align="right" style="width: 12%; ">
                              
                 </td>
                  <td colspan="4" style="width: 28%">
                       
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                       <a onclick="OnShowPopup('PAY_PROV')" href="#tips" style="color: #0000ff">Payment Provision</a>
                 </td>
                  <td style="width: 18%" colspan="2">
                       <gw:list id="lstPayPro" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;" >
                       <a onclick="OnShowPopup('LC')" href="#tips" style="color: #0000ff">L/C No </a>
                 </td>
                  <td style="width: 18%" colspan="2">
                       <gw:textbox id="txtLCNoPK" styles="width:100%;display:none"    /> 
                       <gw:textbox id="txtLCNo" styles="width:100%;" csstype="mandatory" readonly="true"  />
                 </td>
                 <td align="right" style="width: 12%;">
                                Ref No
                 </td>
                  <td colspan="4" style="width: 28%">
                       <gw:textbox id="txtRefNo" styles="width:100%;" csstype="mandatory" readonly="true"/>
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                               <a onclick="OnShowPopup('PAY_BY')" href="#tips" style="color: #0000ff">Paid by</a>
                 </td>
                  <td style="width: 18%" colspan="2">
                       <gw:list id="lstPayBy" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 12%;">
                              Paid Date
                 </td>
                  <td style="width: 18%" colspan="2">
                      <gw:datebox id="dtPayDate" lang="1" />
                 </td>
                 <td align="right" style="width: 12%;">
                             L/G
                 </td>
                  <td colspan="4" style="width: 28%">
                         <gw:list id="lstLGYN" styles="width:100%;" />
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                                Document Arrival
                 </td>
                  <td style="width: 18%" colspan="2">
                       <gw:datebox id="dtDocArr" lang="1"/>
                 </td>
                  <td align="right" style="width: 12%;">
                           Zip day
                 </td>
                 <td  style="width: 18%" colspan=2>
                     <gw:textbox id="txtZipDay" styles="width:100%;"  />
                 </td>                 
                 <td align="right" style="width: 12%;">
                               T/T SELLING
                 </td>
                  <td colspan="4" style="width: 28%">
                        <gw:textbox id="txtTTSell" styles="width:100%;"  />
                 </td>
                 
            </tr>    
            
             <tr>
                 <td align="right" style="width: 12%;">
                         Payment Amt
                 </td>
                  <td style="width: 12%">
                       <gw:textbox id="txtPayAmt1" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>
                  <td style="width: 6%">
                      <gw:list id="lstCCy1" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 12%;">
                         Payment Amt
                 </td>
                  <td style="width: 12%">
                       <gw:textbox id="txtPayAmt2" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>
                  <td style="width: 6%">
                      <gw:list id="lstCCy2" styles="width:100%;" />
                 </td>           
                 <td align="right" style="width: 12%;">
                              Ex-Rate
                 </td>
                  <td colspan="4" style="width: 28%">
                       <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>
                 
            </tr>  
              <tr>
                 <td align="right" style="width: 12%;">
                         Term Change DeadLine
                 </td>
                  <td style="width: 18%" colspan="2">
                        <gw:datebox id="dtDeadLine" lang="1"/>
                 </td>
                 
                 <td align="right" style="width: 12%;">
                         Num Of Days
                 </td>
                  <td style="width: 18%" colspan="2">
                       <gw:textbox id="txtNumOfDay" styles="width:100%;" type="number" format="###,###,###,###" readonly="true"/>
                 </td>
                     
                 <td align="right" style="width: 12%;">
                       
                 </td>
                  <td colspan="4" style="width: 28%">
                       
                 </td>
                 
            </tr>          
           </table> 
        
            </td> 
        </tr>
        <tr style="height: 10%">
        <td colspan=9>
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
                           <gw:textbox id="txtSlipNoSearch" styles="width:100%;" />
                     </td>
                      <td align="right" style="width: 5%;">
                                    B/L Seq
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtPolicySearch" styles="width:100%;"  />
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdCharge')" />
                     </td>
                      <td style="width: 2%">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                      </td>
                </tr>
            </table>
        </td>
                
        </tr>
        <tr style="height: 70%">
        <td colspan="9">
        <gw:grid id='grdCharge'
            header='_PK|SLip No|BL Seq|Payment Provision|_TLG_KB_SUB_LC_M_PK|LC No|Ref No|Paid By|Paid DT|L/G YN|Doc. Arrival|Zip Day|TT Selling|Payment AMT 1|Ccy 1|Payment AMT 2|Ccy 2|Ex Rate|Term Charge DeadLine|Num Of Day'
            format='0|0|0|0|0|0|0|0|4|0|4|0|0|0|0|0|0|0|4|0'
            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            check='|||||||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1500|1500|1500|0|1500|1500|1500|1500|800|1500|1500|1500|1500|800|1500|800|1500|1200|1500'
            sorting='T'
            autosize='T' 
            oncellclick="OnSearch('Master')" 
            styles='width:100%; height:100%'/>
        
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
</html>
