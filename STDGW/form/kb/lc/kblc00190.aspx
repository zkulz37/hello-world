<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>L/C OPEN</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var G_LC_pk = 0;
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
     data_kblc00190_master.StatusInsert();
    //data_kblc00190_search.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";            
	 var data1= ""; 
	 var data2= "";  
	 var data3= "";  
	 var data4= "";
	 var data5= "";      
	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ||";                 
    lstCcy.SetDataText(data); 
    lstCcy.value = '' ;
    
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
            case 'lcno':
                 var path = System.RootURL + "/form/kb/lc/kblc00171.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                
	                txtLCNOPK.text =  object[0];	
	                txtLCNO.text = object[1]; 
	                txtSaleOrderPK.text   =  object[2];	
	                txtPONO.text   =  object[3];	
	             }                              
            break;  
            
            case 'pono':
                 var path = System.RootURL + "/form/kb/lc/kblc00161.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                txtPONO.text = object[1];
	                txtSaleOrderPK.text =  object[0];	                
	             }                              
            break;   
            
            case 'ccy':
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
	                    lstCcy.value = object[1];      
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
        case 'grdLCSearch':
            data_kblc00190_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdLCSearch.GetGridData(grdLCSearch.row,G_LC_pk);
            data_kblc00190_master.Call("SELECT");
        break;  
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'IEBS0070')
             {
                lstShipper.SetDataText(txtLGCodeList.text);
                lstShipper.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'IEBS0010')
             {
                lstBank.SetDataText(txtLGCodeList.text);  
                lstBank.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0120')
             {
                lstPayment.SetDataText(txtLGCodeList.text);  
                lstPayment.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0130')
             {
                lstPrice.SetDataText(txtLGCodeList.text);  
                lstPrice.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0100')
             {
                lstClass.SetDataText(txtLGCodeList.text);  
                lstClass.value = rtnLGCode;                      
             }
              else if ( txtLGGroupCodeID.text == 'LGCM0220')
             {
                lstCountry.SetDataText(txtLGCodeList.text);  
                lstCountry.value = rtnLGCode;                      
             }
        break;
        case 'data_kblc00190_search':
            lblRecord.text  = ( grdLCSearch.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00190_master':
             if(flag=='save')
                {
                    flag = 'search';
                    data_kblc00190_search.Call('SELECT');
                }
        break;
    }
}
//====================================================================================

function Validate()
{   
   if(txtLCNO.text =="")
    {
        alert("Please, input L/C No!")
        return false;
    }
   
    
   return true;
}

//====================================================================================

function OnSave()
{ 
    OnSum();
    flag='save';
    if(data_kblc00190_master.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00190_master.Call();  
        }
           
    }else
    {    
        data_kblc00190_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00190_master.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00190_master.StatusDelete();
       OnSave();
    }
 }
//====================================================================================
function OnSum()
{
    txtDeductAmt.text = Number(txtPostage.text)+Number(txtOther.text)+Number(txtDelay.text)+Number(txtLess.text)+Number(txtAltFee.text);
}
//====================================================================================
    
</script>

<body>
    <!-----------------------------LOGISTIC CODE------------------------------------->
    <%-- <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
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
    </gw:data>--%>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00190_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00190"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtFileNoSearch"	/>	
					<input	bind="txtSearchBy"	/>	
				</input>	
				<output	bind="grdLCSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00190_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"	function="<%=l_user%>lg_sel_kblc00190_1"	procedure="<%=l_user%>lg_upd_kblc00190_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="dtINegodt"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtPostage"	/>
						<inout	bind="txtOther"	/>
						<inout	bind="txtLCNOPK"	/>
						<inout	bind="txtLCNO"	/>
						<inout	bind="txtExcCom"	/>
						<inout	bind="txtDelay"	/>
                        <inout	bind="txtSaleOrderPK"	/>	
						<inout	bind="txtPONO"	/>
						<inout	bind="txtAltFee"	/>	
						<inout	bind="txtLess"	/>
						<inout	bind="txtDeductAmt"	/>		
						
						<inout	bind="lstCcy"	/>
						<inout	bind="txtExcRate"	/>			
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
                        <td colspan="100">
                            <table>
                                <tr>
                                    <td style="width: 99%">
                                    </td>
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
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Nego Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtINegodt" lang="1" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;" readonly="T" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('ccy')" href="#tips" style="color: #0000ff">Exchange Rate</a>
                        </td>
                        <td colspan="4" style="width: 23%">
                            <table style="width:100%">
                                <tr>
                                    <td style="width: 40%">
                                        <gw:list id="lstCcy" styles="width:100%;" />
                                    </td>
                                    <td style="width: 60%">
                                        <gw:textbox id="txtExcRate" styles="width:100%;" type="number" format="###,###,###.##R"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right" style="width: 12%;">
                            Other
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtOther" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('lcno')" href="#tips" style="color: #0000ff">L/C No</a>
                        </td>
                        <td style="width: 25%" colspan="3">
                            <gw:textbox id="txtLCNO" styles="width:100%;" readonly="T" />
                            <gw:textbox id="txtLCNOPK" styles="width:100%;display:none" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Postage
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtPostage" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 12%;">
                            Delay
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtDelay" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('pono')" href="#tips" style="color: #0000ff">P/O No</a>
                        </td>
                        <td style="width: 25%" colspan="3">
                            <gw:textbox id="txtPONO" styles="width:100%;" readonly="T" />
                            <gw:textbox id="txtSaleOrderPK" styles="width:100%;display:none" />
                        </td>
                        <td align="right" style="width: 12%; white-space: nowrap">
                            Exchange Commission
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtExcCom" styles="width:100%;" type="number" format="###,###,###.##R" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Less
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtLess" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                        </td>
                        <td style="width: 25%" colspan="3">
                        </td>
                        <td align="right" style="width: 12%;">
                            Alternative Fee
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtAltFee" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 12%;">
                            Deduct Amount
                        </td>
                        <td colspan="4" style="width: 23%">
                            <gw:textbox id="txtDeductAmt" styles="width:100%;" type="number" format="###,###,###.##R" readonly="T"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 8%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%;">
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
                            <gw:label id="lblRecord" text="" styles="color:red" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdLCSearch')" />
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
                <gw:grid id='grdLCSearch' header='_PK|Slip No|Nego Date|L/C No|P/O No|Postage|Other|Exchange Rate|Delay|Alternative Fee|Less|Deduct Amount'
                    format='0|0|4|0|0|1|1|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
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
