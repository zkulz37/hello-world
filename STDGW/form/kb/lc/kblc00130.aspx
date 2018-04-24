<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>보험 부보 입력</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_Insur_pk = 0;
var rtnLGCode = '' ;
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
    OnAddNew()

    data_kblc00130_search.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data1= ""; 
	 var data2= "";    
     var data3= ""; 
      var data4= "";
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0010' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstInsurComp.SetDataText(data1);
    lstInsurComp.value = '10' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0130' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstInsurTerm.SetDataText(data2);
    lstInsurTerm.value = '' ;
    	
    data3 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstCCY.SetDataText(data3);
    lstCCY.value = 'USD' ;
    
    data4 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";               
    lstCCY2.SetDataText(data4);
    lstCCY2.value = 'USD';
    	
    
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'COMPANY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0010";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0010';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstInsurComp.value = object[1];      
	                }    	                
	             }                              
            break;
            
            case 'INSUR_TERM':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0130";
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
	                    lstInsurTerm.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'CURRENCY':
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
	                    lstCCY.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'LCNO':
                 var path = System.RootURL + "/form/kb/lc/kblc00131.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNoPK.text   = object[0];
                    txtLCNo.text   = object[2];
                    txtRefNo.text = object[1];                                   
                 }          
	       break;  
       }
 }


//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kblc00130_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdSearch.GetGridData(grdSearch.row,G_Insur_pk);
            data_kblc00130_master.Call("SELECT");
        break;
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
         case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0010')
             {
                lstInsurComp.SetDataText(txtLGCodeList.text);  
                lstInsurComp.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0130')
             {
                lstInsurTerm.SetDataText(txtLGCodeList.text);  
                lstInsurTerm.value = rtnLGCode;                      
             }
        break;
        case 'data_kblc00130_search':
            lblRecord.text  = ( grdSearch.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00130_master':
             if(flag=='save')
                {
                    flag = 'search';
                    data_kblc00130_search.Call('SELECT');
                }
        break;
    }
}
//====================================================================================

function Validate()
{   
  if(txtLCNo.text =="")
    {
        alert("Please, input L/C No!");
        return false;
    }
    else if(txtRefNo.text =="")
    {
        alert("Please, input Ref No!");
        return false;
    }
     else if(txtPolicyNum.text =="" || txtPolicyNum.text =="0")
    {
        alert("Please, input Policy Num!");
        return false;
    }        
     else if(txtGuarAmt.text =="" || txtGuarAmt.text =="0")
    {
        alert("Please, input Guarantee Amount!");
        return false;
    }
     else if( txtPreRate.text =="" ||  txtPreRate.text =="0")
    {
        alert("Please, input Premium Rate!");
        return false;
    } 
     
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00130_master.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00130_master.Call();  
        }
           
    }else
    {    
        data_kblc00130_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00130_master.StatusInsert();
    txtSlipNo.text   = '***New Voucher***';
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00130_master.StatusDelete();
       OnSave();
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
    <gw:data id="data_kblc00130_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00130"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtFileNoSearch"	/>
					<input	bind="txtSearchBy"	/>
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00130_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"	function="<%=l_user%>lg_sel_kblc00130_1"	procedure="<%=l_user%>lg_upd_kblc00130_1">	
				<inout>	
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtSlipNo"	/>
					<inout	bind="txtLCNoPK"	/>
					<inout	bind="txtLCNo"	/>
					<inout	bind="dtInsured"	/>
					
					<inout	bind="lstInsurComp"	/>
					<inout	bind="txtRefNo"	/>
					<inout	bind="txtPolicyNum"	/>
					
					<inout	bind="txtGuarAmt"	/>
					<inout	bind="lstCCY"	/>
					<inout	bind="lstInsurTerm"	/>
								
					<inout	bind="txtPreRate"	/>
					<inout	bind="txtInsurRate"	/>
					<inout	bind="txtInsurAmt"	/>				
					<inout	bind="txtExRate"	/>
					
																
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
        <td>
         <table style="width: 100%; height: 100%">
                 <tr style="height: 2%">
						<td align="right" style="width: 5%; white-space: nowrap"></td>
                        <td style="width: 30%"></td>
                        <td align="right" style="width: 5%; white-space: nowrap"></td>
						<td style="width: 30%"> </td>
						<td align="right" style="width: 5%; white-space: nowrap"></td>
                        <td style="width: 19%" align="right"></td>
                                         
                        <td style="width: 2%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
						<td align="right" style="width: 5%; white-space: nowrap">
                           Slip No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap"><a onclick="OnPopUp('LCNO')" href="#tips" style="color: #0000ff">
                            L/C No</a>
                        </td>
						 <td style="width: 30%">
                            <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Insured Date
                        </td>                         
                        <td colspan="4" style="width: 25%" align="left">
                            <gw:datebox id="dtInsured" lang="1" width="15%" />
                        </td>
                       
                    </tr>
                    <tr style="height: 1%">
                       <td align="right" style="width: 5%; white-space: nowrap"><a onclick="OnPopUp('COMPANY')" href="#tips" style="color: #0000ff">
                            Insur Comp</a>
                        </td>
                        <td style="width: 30%;">
                            <gw:list id="lstInsurComp" styles="width:100%;" />
                        </td>
                       
                        <td align="right" style="width: 5%">
                            Ref No
                        </td>
                         <td style="width: 30%">
                            <gw:textbox id="txtRefNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                           Policy Number
                        </td>                         
                        <td colspan="4" style="width:25%" align="left">
                            <gw:textbox id="txtPolicyNum" styles="width:80%;" />                  
                        </td>
                         
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">                      
                            Guarantee AMT
                        </td>
                       <td style="width: 30%;">                      
                            <gw:textbox id="txtGuarAmt" styles="width:100%" type="number" format="###,###,###,###.#R"/>
                            
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                           Currency                      
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstCCY" styles="width:100%;" />                        
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap"><a onclick="OnPopUp('INSUR_TERM')" href="#tips" style="color: #0000ff">
                            Insur term</a>
                        </td>                         
                        <td colspan="4" style="width: 25%" align="left">
                              <gw:list id="lstInsurTerm" styles="width:80%;"/>    
                        </td>
                        
                    </tr>
                     <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">               
                           Premium rate(%)
                        </td>
                       <td style="width: 30%;">
                          <gw:textbox id="txtPreRate" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">                     
                            Insured AMT                            
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtInsurAmt" styles="width:100%;" type="number" format="###,###,###,###.#R"/>    
                                                    
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Exchange rate
                        </td>
                         <td style="width: 19%">
                            <gw:list id="lstCCY2" styles="width:100%;" />
                                                    
                        </td>                        
                        <td colspan="3" style="width: 6%" align="left">                       
                              <gw:textbox id="txtExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />               
                        </td>
                         
                    </tr>  
                     <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">               
                           Insure Rate(%)
                        </td>
                       <td style="width: 30%;">
                          <gw:textbox id="txtInsurRate" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">                                                                     
                        </td>
                        <td style="width: 30%">                                                     
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">  
                        </td>
                         <td style="width: 19%">                            
                        </td>                        
                        <td colspan="3" style="width: 6%" align="left">                                         
                        </td>
                         
                    </tr>        
                </table>
        
            </td> 
        </tr>
        <tr style="height: 10%">
        <td>
           <table style="width: 100%; height: 100%">
                <tr>
                    <td align="right" style="width: 10%; ">
                                   Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                                <gw:datebox id="dtFromSearch" lang="1" />
                                ~
                                <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    <td align="right" style="width: 10%;">
                                    Slip No/LC No
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtFileNoSearch" styles="width:100%;" />
                     </td>
                      <td align="right" style="width: 10%;">
                                    Search by
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtSearchBy" styles="width:100%;" />
                     </td>
                     <td style="width: 10%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                       <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
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
           <gw:grid id='grdSearch'
                header='_PK|Slip No|_TLG_KB_SUB_LC_M_PK|L/C No|_Insured Date|Insur Comp|_Ref NO|_POLICY_NO|Guarantee AMT|CCY|_INSUR_TERM|Premium Rate|Insur Rate|Insured AMT|_EX_RATE'
                format='1|0|1|0|4|0|0|0|1|0|0|1|1|1|1'
                aligns='0|0|0|1|1|1|1|1|0|1|1|0|0|0|0'
                check='||||||||||||||'
                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                widths='0|1200|0|1200|1200|1500|1500|1500|1500|1000|1300|1500|1500|1500|1300'
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
</html>
