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
var G_Clear_pk = 0;
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
    data_kblc00050_master.StatusInsert();
    data_kblc00050_search.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	 var data1= ""; 
	 var data2= "";    
	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0060' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstOffice.SetDataText(data); 
    lstOffice.value = '10' ;
    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0050' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstCustoms.SetDataText( data1);
    lstCustoms.value = '10' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0040' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstFactory.SetDataText( data2);
    lstFactory.value = 'F1' ;
    		 
 }
 //==================================================================================
 function OnPopup(obj)
 {
    switch(obj)
        {
            case 'OFFICE':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0060";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                alert(object[0])	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0060';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstOffice.value = object[1];      
	                }    	                
	             }                              
            break;    
            case 'CUSTOMS':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0050";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0050';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstCustoms.value = object[1];      
	                }    	                
	             }                              
            break;
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
	                    lstFactory.value = object[1];      
	                }    	                
	             }                              
            break;
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
       }
 }


//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdClearance':
            data_kblc00050_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdClearance.GetGridData(grdClearance.row,G_Clear_pk);
            data_kblc00050_master.Call("SELECT");
        break;
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0060')
             {
                lstOffice.SetDataText(txtLGCodeList.text);
                lstOffice.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0050')
             {
                lstCustoms.SetDataText(txtLGCodeList.text);  
                lstCustoms.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0040')
             {
                lstFactory.SetDataText(txtLGCodeList.text);  
                lstFactory.value = rtnLGCode;                      
             }
        break;
        case 'data_kblc00050_search':
            lblRecord.text  = ( grdClearance.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00050_master':
             if(flag=='save')
                {
                    flag = 'search';
                    data_kblc00050_search.Call('SELECT');
                }
        break;
    }
}
//====================================================================================

function Validate()
{   
  if(txtReportNo.text =="" || txtReportNo.text =="0")
    {
        alert("Please, input Clearance No!");
        return false;
    }
    else if(txtNumRod.text =="")
    {
        alert("Please, input Num Of Rod!");
        return false;
    }
     else if(txtTariffRate.text =="" || txtTariffRate.text =="0")
    {
        alert("Please, input Tariff Rate!");
        return false;
    }        
     else if(txtReportPrice.text =="" || txtReportPrice.text =="0")
    {
        alert("Please, input Clearance Price!");
        return false;
    }
     
     else if( txtTaxRate.text =="" ||  txtTaxRate.text =="0")
    {
        alert("Please, input Taxable exchange rate!");
        return false;
    }
     else if( txtAppValue.text =="" ||  txtAppValue.text =="0")
    {
        alert("Please, input Appraised amount!");
        return false;
    }
     else if( txtClearFees.text =="" ||  txtClearFees.text =="0")
    {
        alert("Please, input Clearance fees!");
        return false;
    }
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00050_master.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00050_master.Call();  
        }
           
    }else
    {    
        data_kblc00050_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00050_master.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00050_master.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function OnCalAuto()
{
    txtClearFees.text = parseInt(txtAppValue.text) * parseInt(txtTariffRate.text);
    txtTaxRate.text =  parseInt(txtClearFees.text) * 0.1;
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
    <gw:data id="data_kblc00050_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2"	function="<%=l_user%>lg_sel_kblc00050"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtControlSearch"	/>	
					
				</input>	
				<output	bind="grdClearance"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00050_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"	function="<%=l_user%>lg_sel_kblc00050_1"	procedure="<%=l_user%>lg_upd_kblc00050_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtControlNo"	/>
						<inout	bind="txtReportNo"	/>
						<inout	bind="dtClear"	/>
						<inout	bind="dtPayDeadline"	/>
						<inout	bind="lstOffice"	/>					
						<inout	bind="lstCustoms"	/>
						<inout	bind="lstFactory"	/>
						<inout	bind="txtNumRod"	/>
						<inout	bind="txtTariffRate"	/>
                        <inout	bind="txtReportPrice"	/>	
						<inout	bind="txtTaxRate"	/>	
						<inout	bind="txtAppValue"	/>
						<inout	bind="txtClearFees"	/>			
						<inout	bind="txtLCNoPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtProductName"	/>
						<inout	bind="txtLCQty"	/>		
																
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
                <td style="width: 15%"></td>
                <td style="width: 20%"></td>
                <td style="width: 15%"></td>
                <td style="width: 17%"></td>
                <td style="width: 15%"></td>
                <td style="width: 15%"></td>             
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                </td>
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                </td>
                <td style="width: 1%" align="right">
                    <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
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
                                Clearance No
                 </td>
                  <td style="width: 17%">
                       <gw:textbox id="txtReportNo" styles="width:100%;"/>
                 </td>
                 <td align="right" style="width: 15%; ">
                 </td>
                  <td colspan="4" style="width: 18%">
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">
                                Clearance date
                 </td>
                  <td style="width: 20%">
                       <gw:datebox id="dtClear" lang="1" />
                 </td>
                  <td align="right" style="width: 15%; ">
                                Payment deadline
                 </td>
                  <td style="width: 17%">
                      <gw:datebox id="dtPayDeadline" lang="1" />
                 </td>
                 <td align="right" style="width: 15%;">
                 </td>
                  <td colspan="4" style="width: 18%">
                       
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 15%;"><a onclick="OnPopup('OFFICE')" href="#tips" style="color: #0000ff">
                                Clearance office</a>
                 </td>
                  <td style="width: 20%">
                       <gw:list id="lstOffice" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 15%;"><a onclick="OnPopup('CUSTOMS')" href="#tips" style="color: #0000ff">
                                Customs</a>
                 </td>
                  <td style="width: 17%">
                      <gw:list id="lstCustoms" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 15%;"><a onclick="OnPopup('FACTORY')" href="#tips" style="color: #0000ff">
                                Stored factory</a> 
                 </td>
                  <td colspan="4" style="width: 18%">
                    <gw:list id="lstFactory" styles="width:100%;" />
                  </td>
            </tr>
            <tr>
                 <td align="right" style="width: 15%;">
                                Number of rod
                 </td>
                  <td style="width: 20%">
                        <gw:textbox id="txtNumRod" styles="width:100%;" />
                 </td>
                  <td align="right" style="width: 15%;"  >
                                Tariff rate
                 </td>
                  <td style="width: 17%">
                       <gw:textbox id="txtTariffRate" styles="width:100%;" type="number" format="###,###.#R" onchange="OnCalAuto()"/>
                 </td>
                 <td align="right" style="width: 15%;">
                                Clearance price 
                 </td>
                  <td colspan="4" style="width: 18%">
                        <gw:textbox id="txtReportPrice" styles="width:100%;" type="number" format="###,###.#R" />
                 </td>
                 
            </tr>
             <tr>
                 <td align="right" style="width: 15%;">
                       Clearance fees     
                 </td>
                  <td style="width: 20%">
                     <gw:textbox id="txtClearFees" styles="width:100%;" type="number" format="###,###.#R"/>
                 </td>
                  <td align="right" style="width: 15%;">
                                Tax
                 </td>
                  <td style="width: 17%">
                      <gw:textbox id="txtTaxRate" styles="width:100%;" type="number" format="###,###.#R"/>
                 </td>
                 <td align="right" style="width: 15%;">
                               Appraised amount(VND)
                 </td>
                  <td colspan="4" style="width: 18%">
                        <gw:textbox id="txtAppValue" styles="width:100%;" type="number" format="###,###.#R" onchange="OnCalAuto()"/>
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
                                Item
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
                    <td align="right" style="width: 10%; ">
                                   Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                                <gw:datebox id="dtFromSearch" lang="1" />
                                ~
                                <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    <td align="right" style="width: 15%;">
                                    Slip No Search
                     </td>
                      <td style="width: 20%">
                           <gw:textbox id="txtControlSearch" styles="width:100%;" />
                     </td>
                      <td align="right" style="width: 10%;">
                     </td>
                      <td style="width: 15%">                      
                     </td>
                     <td style="width: 10%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                       <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdClearance')" />
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
            <gw:grid id='grdClearance'
            header='_PK|Slip No|Product Name|Quantity|Clearance No|Clearance Dt|Clearance Off|Customs|Stored Fact|Num Of Rod|Quantity|Tariff Rate|Tax Ex Rate|Clearance Price|Appraise Value|Clearance Fees'
            format='1|0|0|1|0|4|0|0|0|0|1|1|1|1|1|1'
            aligns='0|0|1|0|0|1|1|1|1|0|0|0|0|0|0|0'
            check='|||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='1000|1200|2500|1500|1500|1200|1500|2000|1500|1300|1300|1300|1300|1500|1500|1500'
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
</html>
