<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>GOOD DELIVERY</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
  
var G_PK                        = 0,
    G_TLG_KB_SALE_DELI_M_PK     = 1,
    G_TLG_IT_ITEM_PK            = 2,
    G_ITEM_GROUP                = 3,
    G_PO_NO                     = 4, 
    G_ITEM_CODE                 = 5,
    G_ITEM_NAME                 = 6,
    G_QUANTITY                  = 7,
    G_UNIT_PRICE                = 8,
    G_AMOUNT                    = 9,
    G_UNIT                      = 10,
    G_LOT_NO                    = 11,
    G_TLG_KB_EXP_SALE_ODER_PK   = 12;     
   
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtCustomerCode.SetEnable(false);
    txtCustomerName.SetEnable(false);
     lstGroup.SetEnable(false);
     lstVariety.SetEnable(false);
     lstDeliType.SetEnable(false);
   //---------------------------- 
    txtMasterPK.text = "<%=Request.querystring("master_pk")%>";
	
	p_type = "<%=Request.querystring("type")%>";  
	
    if ( p_type == 'APPROVE' )
	{ 
		btnCancel.style.display = "none";
	}
	else
	{
		btnApprove.style.display = "none";
	}
	 BindingDataList(); 	
   OnSearch('grdMaster')
}
 //==================================================================================
 
 function BindingDataList()
 {                
	 var data1= ""; 
	 var data2= "";    
	 var data3= ""; 
	 
	    
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0220' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstGroup.SetDataText(data1);
    lstGroup.value = '' ;
    
    data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0250' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstVariety.SetDataText(data2);
    lstVariety.value = '' ;
    
    data3 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0280' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstDeliType.SetDataText(data3);
    lstDeliType.value = '' ;

    		 
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
      
        case 'grdMaster':          
                data_kbsa00040_master.Call("SELECT");
        break;
        
        case 'grdDetail':            
            data_kbsa00040_detail.Call("SELECT");
        break;
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      
      case "data_kbsa00040_master": 
            
             OnSearch('grdDetail');   
           
        break;

        case "data_kbsa00040_detail":
            if ( grdDetail.rows > 1 )
            {
                 grdDetail.SetCellBold( 1, G_ITEM_NAME, grdDetail.rows - 1, G_ITEM_NAME,  true);
	            //grdDetail.SetCellBold( 1, G_QUANTITY, grdDetail.rows - 1, G_QUANTITY,  true);
	             grdDetail.SetCellBold( 1, G_AMOUNT,grdDetail.rows - 1, G_AMOUNT,   true);   
                //grdDetail.SetCellBgColor( 1, G_AMOUNT, grdDetail.rows - 1, G_AMOUNT, 0x99FFFF ); 
                                  
            }
                  
        break;
        
         case 'pro_kbsa00040_1' :
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();      
        break;
        
        case'pro_kbsa00040_2':
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();      
        break;
        
    }
}
//==========================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Approve' :
            if ( confirm('Do you want to Approve this Slip?'))
            {
                pro_kbsa00040_1.Call();
            }    
        break;
		
		case 'Cancel' :
			if ( confirm('Do you want to cancel this Slip?'))
            {
                pro_kbsa00040_2.Call();
            }  		
		break;
    }	
}
//====================================================================================
    
</script>

<body>
  
	<!--============================================= Master =====================================-->
    <gw:data id="data_kbsa00040_master" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"	function="<%=l_user%>lg_sel_kbsa00041"	>	
				<inout>	
					<inout	bind="txtMasterPK"	/>
					<inout	bind="txtSlipNo"	/>
					<inout	bind="dtDeli"	/>
					<inout	bind="txtPONo"	/>
					
					<inout	bind="txtCustomerPK"	/>
					<inout	bind="txtCustomerCode"	/>
					<inout	bind="txtCustomerName"	/>
					
					<inout	bind="txtDeliToPK"	/>
					<inout	bind="txtDeliToCode"	/>
					<inout	bind="txtDeliToName"	/>
								
					<inout	bind="lstGroup"	/>
					<inout	bind="lstVariety"	/>		
					<inout	bind="lstDeliType"	/>
					
					<inout	bind="txtProdItem"	/>
					<inout	bind="txtRefNo"	/>
					<inout	bind="txtQty"	/>
					<inout	bind="txtCharge"	/>
					<inout	bind="txtSumAmt"	/>
					<inout	bind="txtRemark"	/>
												
				</inout>
			</dso>	
		</xml>	
	</gw:data>
	  <!--============================================= Detail =====================================-->
    <gw:data id="data_kbsa00040_detail" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_kbsa00041_1" >
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
	
    <!--------------------------------------make plan------------------------------->
    <gw:data id="pro_kbsa00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbsa00040" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_kbsa00040_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbsa00040_1" > 
                <input>
                    <input bind="txtMasterPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="right" style="width: 100%">
                <table style="width: 100%; height: 100%">   
                    <tr>
                    </tr>              
                    <tr style="height: 1%">
						<td align="right" style="width: 10%;">
                           Slip No
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" readonly="true"/>
                        </td>
                        <td align="right" style="width: 10%; ">
                            Date
                        </td>
						 <td style="width: 35%">
                            <gw:datebox id="dtDeli" lang="1" width="100%" />
                        </td>             
                       <td style="width: 5%" align="right" colspan="5">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
							<gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                       <td align="right" style="width: 10%; ">
                            PO No
                        </td>
                        <td style="width: 40%;">
                                      
                            <gw:textbox id="txtPONo" styles="width:100%;"  readonly="yes"/>
                        </td>
                       
                        <td align="right" style="width: 10%">
                            Group
                        </td>
                         <td colspan="6" style="width:40%">
                            <gw:list id="lstGroup" styles="width:100%;"  readonly="yes"/>
                        </td>
                                                    
                    </tr>
                    
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; ">
                         Customer
                        </td>
                       <td style="width: 40%;">
                            <gw:textbox id="txtCustomerPK" styles="display:none" />
                            <gw:textbox id="txtCustomerCode" csstype="mandatory" styles="width:30%" />
                            <gw:textbox id="txtCustomerName" csstype="mandatory" styles="width:69%" />
                        </td>
                        <td> Variety
                        </td>
                        <td colspan="6" style="width:40%">
                            <gw:list id="lstVariety" styles="width:100%;" />
                        </td>
                    </tr>
                      <tr style="height: 1%">
                        <td align="right" style="width: 10%;"> Deli to
                        </td>
                       <td style="width:40%;">
                            <gw:textbox id="txtDeliToPK" styles="display:none"  readonly="yes"/>
                            <gw:textbox id="txtDeliToCode" csstype="mandatory" styles="width:30%"  readonly="yes" />
                            <gw:textbox id="txtDeliToName" csstype="mandatory" styles="width:69%"  readonly="yes" />
                            
                        </td>
                        <td align="right" style="width: 10%;">
                            Deli Type
                        </td>
                        <td colspan="6" style="width: 40%">
                            <gw:list id="lstDeliType" styles="width:100%;"   readonly="yes"/>
                        </td>
                    </tr>
                    
                      <tr style="height: 1%">
                        <td align="right" style="width: 10%;">                  
                            Prod Item
                        </td>
                       <td style="width: 40%;">
                            <gw:textbox id="txtProdItem" styles="width: 100%;"   readonly="yes"/>
                            
                        </td>
                        <td align="right" style="width: 10%; ">      
                                Ref No
                        </td>
                        <td colspan="6" style="width: 40%">
                            <gw:textbox id="txtRefNo" styles="width: 100%;"  readonly="yes" />
                        </td>
                    </tr>
                     <tr style="height: 1%">
                        <td align="right" style="width: 10%; " >                  
                            Deli Req Qty
                        </td>
                       <td style="width: 40%;">
                            <gw:textbox id="txtQty" styles="width: 100%;" type="number" format="###,###,###,###.#R"  readonly="yes"/>
                            
                        </td>
                        <td align="right" style="width: 10%; ">      
                                Charger
                        </td>
                        <td colspan="6" style="width: 40%">
                            <gw:textbox id="txtCharge" styles="width: 100%;"  readonly="yes"/>
                        </td>
                    </tr>
                      <tr style="height: 1%">
                        <td align="right" style="width: 10%;">                  
                            Sum Amount
                        </td>
                       <td style="width: 40%;">
                            <gw:textbox id="txtSumAmt" styles="width: 100%;color: red" type="number" format="###,###,###,###.#R" readonly="true" />
                            
                        </td>
                        <td align="right" style="width: 10%">      
                                Remark
                        </td>
                        <td colspan="6" style="width: 40%">
                            <gw:textbox id="txtRemark" styles="width: 100%;"   readonly="yes"/>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="16">                           
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="16">
                            <gw:grid id='grdDetail'
                                header='_PK|_TLG_KB_SALE_DELIVERY_M_PK|_TLG_IT_ITEM_PK|Item Group|Po No|Item Code|Item Name|Qty|Unit Price|Amout|Unit|Lot No|_TLG_KB_EXP_SALE_ORDER_PK'
                                format='1|1|1|0|0|0|0|1|1|1|0|0|1'
                                aligns='0|0|0|1|1|1|0|0|0|0|1|1|0'
                                check='||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|0|0|1200|1200|1500|2500|1500|1500|1500|1000|1500|0'
                                sorting='T' styles='width:100%; height:100%'onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)"/>
                           

                        </td>
                    </tr>
                </table>
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
