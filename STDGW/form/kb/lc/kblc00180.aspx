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
     data_kblc00180_master.StatusInsert();
    //data_kblc00180_search.Call('SELECT')
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
	
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %>|| ";                 
    lstCcy.SetDataText(data); 
    lstCcy.value = '' ;
    
    		 
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {
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
            
            case 'imp':
                 var path = System.RootURL + "/form/kb/lc/kblc00181.aspx?import_pk="+txtImportPK.text;
	             var object = System.OpenModal( path ,400 ,300 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	
	                txtImportPK.text = object[0];
	                txtInportGue.text =  object[1];               
	             }  
	             OnSum();                            
            break;    
            case 'bill':
                 var path = System.RootURL + "/form/kb/lc/kblc00182.aspx?import_pk="+txtBillPK.text;
	             var object = System.OpenModal( path ,400 ,300 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	
	                txtBillPK.text = object[0];
	                txtBillReceiable.text =  object[1];               
	             } 
	             OnSum();                             
            break; 
            case 'acc':
                 var path = System.RootURL + "/form/kb/lc/kblc00183.aspx?import_pk="+txtAccountPK.text;
	             var object = System.OpenModal( path ,400 ,300 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	
	                txtAccountPK.text = object[0];
	                txtAccReceivable.text =  object[1];               
	             }  
	             OnSum();                            
            break;      
                                 
       }
 }


//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdLCSearch':
            data_kblc00180_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdLCSearch.GetGridData(grdLCSearch.row,G_LC_pk);
            data_kblc00180_master.Call("SELECT");
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
        case 'data_kblc00180_search':
            lblRecord.text  = ( grdLCSearch.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00180_master':
             if(flag=='save')
                {
                    flag = 'search';
                    data_kblc00180_search.Call('SELECT');
                }
        break;
    }
}
//====================================================================================

function Validate()
{   
   if(txtLCNo.text =="")
    {
        alert("Please, input L/C No!")
        return false;
    }
    else if(txtQty.text =="" || txtQty.text =="0")
    {
        alert("Please, input L/C Qty!");
        return false;
    }
    else if(txtUnitPrice.text =="" || txtUnitPrice.text =="0")
    {
        alert("Please, input L/C Unit Price!");
        return false;
    }
     else if(txtAmount.text =="" || txtAmount.text =="0")
    {
        alert("Please, input L/C Open Amount!");
        return false;
    }    
    
   return true;
}

//====================================================================================

function OnSave()
{ 
    OnSum();
    flag='save';
    if(data_kblc00180_master.GetStatus() == 20)  
    { 
//        if(Validate())
//        {
             data_kblc00180_master.Call();  
        //}
           
    }else
    {    
        data_kblc00180_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00180_master.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00180_master.StatusDelete();
       OnSave();
    }
 }
//====================================================================================

function OnSum()
{
    txtTotalDebit.text = Number(txtCashInHand.text)+Number(txtCashInBank.text)+Number(txtRedeposit.text)+Number(txtInportGue.text)+Number(txtBillReceiable.text)+Number(txtAdvReceivedDebit.text);
    txtTotalCredit.text = Number(txtAccReceivable.text)+Number(txtAdvReceived.text)+Number(txtGuaDepo.text)+Number(txtMiscellReven.text);
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
    <gw:data id="data_kblc00180_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	function="<%=l_user%>lg_sel_kblc00180"	>	
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
    <gw:data id="data_kblc00180_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"	function="<%=l_user%>lg_sel_kblc00180_1"	procedure="<%=l_user%>lg_upd_kblc00180_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="dtDepositDate"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="txtCashInHand"	/>
						<inout	bind="txtCashInBank"	/>
						<inout	bind="txtRedeposit"	/>
						<inout	bind="txtInportGue"	/>
						<inout	bind="txtBillReceiable"	/>
						<inout	bind="txtAdvReceivedDebit"	/>
						<inout	bind="txtTotalDebit"	/>
                        <inout	bind="txtAccReceivable"	/>	
						<inout	bind="txtAdvReceived"	/>
						<inout	bind="txtGuaDepo"	/>	
						<inout	bind="txtMiscellReven"	/>
						<inout	bind="txtTotalCredit"	/>	
						<inout	bind="lstCcy"	/>	
						<inout	bind="txtExcRate"	/>	
						<inout	bind="txtImportPK"	/>	
						<inout	bind="txtBillPK"	/>	
						<inout	bind="txtAccountPK"	/>	
										
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
                        <td align="right" style="width: 15%;">
                            Deposit Date
                        </td>
                        <td style="width: 15%">
                            <gw:datebox id="dtDepositDate" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtSlipNo" styles="width:100%;" readonly="T" />
                        </td>
                        <td colspan="3">
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
                        <td align="right" style="width: 15%;">
                            Cash In Hand
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtCashInHand" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('ccy')" href="#tips" style="color: #0000ff">Exchange Rate</a>
                        </td>
                        <td style="width: 35%">
                            <table style="width:100%">
                                <tr>
                                    <td style="width:40%">
                                        <gw:list id="lstCcy" styles="width:100%;" readonly="T" />
                                    </td>
                                    <td style="width:60%">
                                        <gw:textbox id="txtExcRate" styles="width:100%;" type="number" format="###,###,###.##R"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            Cash In Bank
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtCashInBank" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('acc')" href="#tips" style="color: #0000ff">Account Receivable</a>
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtAccReceivable" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            Redeposit
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtRedeposit" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 15%;">
                            Advance Received
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtAdvReceived" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('imp')" href="#tips" style="color: #0000ff">Import Guarantee</a>
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtInportGue" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 15%;">
                            Guarantee deposits
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtGuaDepo" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('bill')" href="#tips" style="color: #0000ff">Bill Receivable</a>
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtBillReceiable" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 15%;">
                            Miscellaneous Revenue
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtMiscellReven" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            Advance Received
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtAdvReceivedDebit" styles="width:100%;" type="number" format="###,###,###.##R" onblur="OnSum()"/>
                        </td>
                        <td align="right" style="width: 15%;">
                            Total Credit
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtTotalCredit" styles="width:100%;" type="number" format="###,###,###.##R" 
                                readonly="T" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 15%;">
                            Total Debit
                        </td>
                        <td style="width: 35%" colspan="3">
                            <gw:textbox id="txtTotalDebit" styles="width:100%;" type="number" format="###,###,###.##R"
                                readonly="T" />
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
                <gw:grid id='grdLCSearch' header='_PK|Deposit Date|Slip No|Cash In Hand|Cash In Bank|Redeposit|Import Guarantee|Bill Receivable|Advance Receiveable|Total Debit|Account Receivable|Advance Received|Guarantee Deposit|Miscellaneous Revenue |Total Credit'
                    format='0|4|0|1|1|1|1|1|1|1|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
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

<gw:textbox id="txtImportPK" text="" style="display: none" />
<gw:textbox id="txtBillPK" text="" style="display: none" />
<gw:textbox id="txtAccountPK" text="" style="display: none" />
</html>
