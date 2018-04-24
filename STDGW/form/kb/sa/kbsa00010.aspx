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

var G_PK            = 0,
    G_SO_DATE       = 1,
    G_SO_NO         = 2,
    G_PO_NO         = 3,
    G_PARTNER_NAME  = 4,
    G_ITEM          = 5,
    G_PO_QTY        = 6,
    G_NET_PRICE     = 7,
    G_SALES_AMT_CCY = 8,
    G_SALES_AMT_VND = 9,
    G_TAX           = 10,
    G_TOTAL_AMOUNT  = 11,
    G_COM           = 12,
    G_ETA           = 13,
    G_ETD           = 14,
    G_REMARK        = 15;
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtSONo.SetEnable(false);
     //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;  
   //---------------------------- 
    
    BindingDataList(); 
     data_kblc00010_master.StatusInsert();
    //data_kblc00010_search.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";          
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCCY.SetDataText(data); 
    lstCCY.value = 'USD' ;

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>";    
    lstPriceType.SetDataText(data); 

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0220') FROM DUAL" )%>"; 
    lstDestNation.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0110') FROM DUAL" )%>";    
    lstPaymentType.SetDataText(data);
    	 
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0210') FROM DUAL" )%>"; 
    lstExpNation.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('IEBS0021') FROM DUAL" )%>";    
    lstDestPort.SetDataText(data); 

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('IEBS0020') FROM DUAL" )%>";    
    lstExpPort.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGSA1020') FROM DUAL" )%>";    
    lstOrderType.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGKB0220') FROM DUAL" )%>";    
    lstGroup.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGKB0250') FROM DUAL" )%>";    
    lstVariety.SetDataText(data);

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGKB0240') FROM DUAL" )%>";    
    lstMarket.SetDataText(data);

    data = "<%=ESysLib.SetListDataSQL("select  UOM_CODE, UOM_CODE || '-' || UOM_NM from TLG_IT_UOM where del_if=0  order by 1")%>";   
    lstUnit.SetDataText(data);
 }
 //==================================================================================
 function OnPopUp(obj)
 {
    switch(obj)
        {        
            case 'DeliTo' :
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	             if ( object != null )
	             {
	                txtDeliTo_PK.text   = object[0];
                    txtDeliTo_NM.text = object[2];  
                    txtCustomer_PK.text   = object[0];
                    txtCustomer_NM.text = object[2];     
	             }
	        break;
            case 'Customer' :
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	             if ( object != null )
	             {
	                txtCustomer_PK.text   = object[0];
                    txtCustomer_NM.text = object[2];     
	             }
	        break;                   
            case 'LCNo':
	             var path = System.RootURL + "/form/kb/lc/kblc00041.aspx";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtLCNo_PK.text   = object[0];
                    txtLCNo_NM.text   = object[2];                                           
                 }                                
            break;         
            case 'Item':
	             var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=|Y|||Y|Y';
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
          	                   
                 if ( object != null )
                 {	         
                    txtItemPK.text   = object[0];
                    txtItemNM.text   = object[2];                                           
                 }                                
            break;   
            case "Order_Type":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA1020";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGSA1020';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstOrderType.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;
            case "Price_Type":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

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
	                    lstPriceType.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;
            case "Payment_Method":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0110";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGCM0110';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstPaymentType.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;
            case "Dest_Nation":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0220";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGCM0220';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstDestNation.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;   
            case "Group":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0220";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0220';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstGroup.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;
            case "Market":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0240";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0240';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstMarket.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;   
            case "Variety":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0250";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0250';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstVariety.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;  
            case "Export_Nation":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0210";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGCM0210';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstExpNation.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break; 
            case "Dest_Port":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0021";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0021';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstDestPort.value = object[1];      
	                }    	                
	            }                 	 	                                 
            break;
            case "Export_Port":
                var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0020";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');		

                if ( object != null )
	            {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'IEBS0020';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstExpPort.value = object[1];      
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
            data_kblc00010_search.Call("SELECT");
        break;
        case 'Master':
            txtMasterPK.text  = grdLCSearch.GetGridData(grdLCSearch.row,G_LC_pk);
            data_kblc00010_master.Call("SELECT");
        break;  
          
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGSA1020')
             {
                lstOrderType.SetDataText(txtLGCodeList.text);
                lstOrderType.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0130')
             {
                lstPriceType.SetDataText(txtLGCodeList.text);
                lstPriceType.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0110')
             {
                lstPaymentType.SetDataText(txtLGCodeList.text);
                lstPaymentType.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGCM0220')
             {
                lstDestNation.SetDataText(txtLGCodeList.text);
                lstDestNation.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0220')
             {
                lstGroup.SetDataText(txtLGCodeList.text);
                lstGroup.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0240')
             {
                lstMarket.SetDataText(txtLGCodeList.text);
                lstMarket.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0250')
             {
                lstVariety.SetDataText(txtLGCodeList.text);
                lstVariety.value = rtnLGCode;                      
             }             
             else if ( txtLGGroupCodeID.text == 'LGCM0210')
             {
                lstExpNation.SetDataText(txtLGCodeList.text);
                lstExpNation.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'IEBS0021')
             {
                lstDestPort.SetDataText(txtLGCodeList.text);
                lstDestPort.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'IEBS0020')
             {
                lstExpPort.SetDataText(txtLGCodeList.text);
                lstExpPort.value = rtnLGCode;                      
             }
        break;
        case 'data_kblc00010_search':
            lblRecord.text  = ( grdLCSearch.rows -1 )+ " record(s)."
        break;
        case 'data_kblc00010_master':
            grdLCSearch.SetGridText(0, G_SALES_AMT_CCY, 'Sale Amt(' + lstCCY.value + ')');
             if(flag=='save')
                {
                    flag = 'search';
                    data_kblc00010_search.Call('SELECT');
                }
        break;
    }
}
//====================================================================================

function Validate()
{   
    /*if(txtLCNo_NM.text =="")
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
     else if(txtProdName.text =="")
    {
        alert("Please, input Item!");
        return false;
    }    
    */
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00010_master.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00010_master.Call();  
        }
           
    }else
    {    
        data_kblc00010_master.Call();                
    }

}
//====================================================================================

function OnAddNew()
{
    data_kblc00010_master.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00010_master.StatusDelete();
       OnSave();
    }
 }

//====================================================================================
function OnCalc()
{
        txtSalesAmount.text = Number(txtCredit.text) + Number(txtDeposit.text) + Number(txtPayment.text)
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
    <gw:data id="data_kblc00010_search" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kbsa00010_1"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtPOItemSearch"	/>	
					<input	bind="txtCustSearch"	/>	
				</input>	
				<output	bind="grdLCSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kblc00010_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37"	function="<%=l_user%>lg_sel_kbsa00010"	procedure="<%=l_user%>lg_upd_kbsa00010">	
				<inout>	
						<inout    bind="txtMasterPK"    />
                        <inout    bind="txtCustomer_PK"    />
                        <inout    bind="txtCustomer_NM"    />
                        <inout    bind="txtDeliTo_PK"    />
                        <inout    bind="txtDeliTo_NM"    />
                        <inout    bind="lstCCY"    />
                        <inout    bind="lstDestNation"    />
                        <inout    bind="lstDestPort"    />
                        <inout    bind="txtExcRate"    />
                        <inout    bind="lstExpNation"    />

                        <inout    bind="lstExpPort"    />    
                        <inout    bind="lstGroup"    />
                        <inout    bind="txtLCNo_PK"    />
                        <inout    bind="txtLCNo_NM"    />
                        <inout    bind="lstMarket"    /> 
                        <inout    bind="lstOrderType"    />  
                        <inout    bind="lstPaymentType"    />
                        <inout    bind="txtPONo"    />    
                        <inout    bind="lstPriceType"    /> 
                        <inout    bind="txtRemark"    />

                        <inout    bind="dtExpSO"    />
                        <inout    bind="txtSONo"    />
                        <inout    bind="lstVariety"    />

                        <inout    bind="txtDetailPK"    />
                        <inout    bind="txtCom"    />
                        <inout    bind="txtCredit"    />
                        <inout    bind="txtDeposit"    />
                        <inout    bind="dtETA"    />
                        <inout    bind="dtETD"    />
                        <inout    bind="txtItemPK"    />    
                        <inout    bind="txtItemNM"    />
                        <inout    bind="txtNetPrice"    />
                        <inout    bind="txtPayment"    />

                        <inout    bind="txtPOQty"    />
                        <inout    bind="txtSalesAmount"    />
                        <inout    bind="txtReceivable"    />
                        <inout    bind="txtTax"    />
                        <inout    bind="lstUnit"    />

				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 30%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 12%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td style="width: 17%">
                        </td>
                        <td style="width: 12%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 1%" align="right">
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
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Order_Type')" href="#tips" style="color: #0000ff">Order Type</a>
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstOrderType" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            S/O No
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtSONo" styles="width:100%;" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 12%;">
                            P/O No
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtPONo" styles="width:100%;" csstype="mandatory" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtExpSO" lang="1" width="10%" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('DeliTo')">Deli To </b>
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtDeliTo_PK" styles="width:100%;display:none" csstype="mandatory" />
                            <gw:textbox id="txtDeliTo_NM" styles="width:100%;" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Customer')" href="#tips" style="color: #0000ff">Customer</a>
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtCustomer_PK" styles="width:100%;display:none" csstype="mandatory" />
                            <gw:textbox id="txtCustomer_NM" styles="width:100%;" csstype="mandatory" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Group')" href="#tips" style="color: #0000ff">Group</a>
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstGroup" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('Price_Type')" href="#tips" style="color: #0000ff">Price Type</a>
                        </td>
                        <td style="width: 17%">
                            <gw:list id="lstPriceType" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Market')" href="#tips" style="color: #0000ff">Market</a>
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:list id="lstMarket" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Variety')" href="#tips" style="color: #0000ff">Variety</a>
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstVariety" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Payment_Method')">Payment
                                Type</b>
                        </td>
                        <td style="width: 17%">
                            <gw:list id="lstPaymentType" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dest_Nation')">Dest Nation
                            </b>
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:list id="lstDestNation" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Unit
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstUnit" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Export_Nation')">Export Nation</b>
                        </td>
                        <td style="width: 17%">
                            <gw:list id="lstExpNation" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Dest_Port')">Dest Port</b>
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:list id="lstDestPort" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            CCY
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstCCY" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Export_Port')">Export Port</b>
                        </td>
                        <td style="width: 17%">
                            <gw:list id="lstExpPort" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                        </td>
                        <td colspan="5" style="width: 23%">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10">
                            <hr noshade size="1" style="color: Silver" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            Exchange Rate
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtExcRate" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                        <td align="right" style="width: 15%;">
                            <a onclick="OnPopUp('LCNo')" href="#tips" style="color: #0000ff">L/C NO</a>
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtLCNo_PK" styles="width:100%;display:none" />
                            <gw:textbox id="txtLCNo_NM" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Payment
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtPayment" styles="width:100%;" type="number" format="###,###.##"
                                onchange="OnCalc()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            <a onclick="OnPopUp('Item')" href="#tips" style="color: #0000ff">Item</a>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtItemPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtItemNM" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 15%;">
                            Com.
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtCom" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Credit Limit
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtCredit" styles="width:100%;" type="number" format="###,###.##"
                                onchange="OnCalc()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            PO Qty
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPOQty" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                        <td align="right" style="width: 15%;">
                            TAX
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtTax" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Receivable
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtReceivable" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            NET Price
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtNetPrice" styles="width:100%;" type="number" format="###,###.##" />
                        </td>
                        <td align="right" style="width: 15%;">
                            Remark
                        </td>
                        <td style="width: 17%">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Sales Amount
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtSalesAmount" styles="width:100%;" type="number" format="###,###.##"
                                onchange="OnCalc()" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 12%;">
                            ETA
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtETA" lang="1" width="10%" />
                        </td>
                        <td align="right" style="width: 15%;">
                            ETD
                        </td>
                        <td style="width: 17%">
                            <gw:datebox id="dtETD" lang="1" width="10%" />
                        </td>
                        <td align="right" style="width: 12%;">
                            Deposit
                        </td>
                        <td colspan="5" style="width: 23%">
                            <gw:textbox id="txtDeposit" styles="width:100%;" type="number" format="###,###.##"
                                onchange="OnCalc()" />
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
                            PO/Item
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtPOItemSearch" styles="width:100%;" onenterkey="OnSearch('grdLCSearch')" />
                        </td>
                        <td align="right" style="width: 10%;">
                            Customer
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtCustSearch" styles="width:100%;" onenterkey="OnSearch('grdLCSearch')" />
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
                <gw:grid id='grdLCSearch' header='_pk|SO Date|SO No|PO No|Partner Name|Item|PO Qty|Net Price|Sales Amount|Sales Amount(VND)|Tax|Total Amount|Com|ETA|ETD|Remark'
                    format='0|4|0|0|0|0|1|1|1|1|1|1|1|4|4|0' aligns='0|1|0|0|0|0|0|0|0|0|0|0|0|1|1|0'
                    check='|||||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='0|1200|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1200|1200|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<gw:textbox id="txtDetailPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
