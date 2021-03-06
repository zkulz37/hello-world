<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Goods Delivery Entry Detail</title>
</head>

<script type="text/javascript">

    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>";
    var  user_name = "<%=Session("USER_NAME")%>"  ; 	 

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_SEQ              = 1,
    G1_REF_NO           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_REQ_ITEM_CODE    = 4,
    G1_REQ_ITEM_NAME    = 5,
    G1_OUT_ITEM_PK      = 6,
    G1_OUT_ITEM_CODE    = 7,
    G1_OUT_ITEM_NAME    = 8,
    G1_REQ_QTY          = 9,
    G1_REQ_UOM          = 10,
    G1_OUT_QTY          = 11,
    G1_OUT_UOM          = 12,
    G1_UNIT_PRICE       = 13,
    G1_ITEM_AMOUNT      = 14,
    G1_VAT_RATE         = 15,
    G1_VAT_AMOUNT       = 16,
    G1_TOTAL_AMOUNT     = 17,
    G1_LOT_NO           = 18,
    G1_WH_PK            = 19,
    G1_WH_NAME          = 20,
    G1_REMARK           = 21,
    G1_MASTER_PK        = 22,
    G1_SO_D_PK          = 23,
    G1_REQ_D_PK         = 24;
 
//==========================================================================

function BodyInit()
{
    System.Translate(document);  // Translate to language session    
	
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtCustomerName.SetEnable(false);      
 
    //---------------------------- 
    
    FormatGrid();    
    OnToggleGrid();
    //---------------------- 
    txtMasterPK.text = "<%=Request.querystring("return_pk")%>";
	
	p_type = "<%=Request.querystring("type")%>";  
	
	if ( p_type == 'APPROVE' )
	{ 
		btnCancel.style.display = "none";
	}
	else
	{
		btnApprove.style.display = "none";
	}
		
    OnSearch('Master');
    //----------------------     
}

//==========================================================================
 function FormatGrid()
 {
     var data = ""; 
     //----------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT TRANS_CODE ,TRANS_CODE || ' - ' || trans_name  FROM tlg_in_trans_code  WHERE del_if = 0 and type = 'O' and TRANS_CODE = 'O100' ORDER BY trans_code" )%>";    
     lstTransType.SetDataText(data);
     //----------------------------
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);    	 
	 //----------------------------  
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0301') FROM DUAL" )%>||";    
     lstOutType.SetDataText(data); 
	 lstOutType.value = "";
	 	 
	 var ctr = grdDetail.GetGridControl(); 
    
     ctr.ColFormat(G1_REQ_QTY) = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_OUT_QTY) = "#,###,###,###,###,###.##";
    
     ctr.ColFormat(G1_UNIT_PRICE)   = "#,###,###,###,###,###.###";
     ctr.ColFormat(G1_ITEM_AMOUNT)  = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_VAT_RATE)     = "#,###,###,###,###,###";
     ctr.ColFormat(G1_VAT_AMOUNT)   = "#,###,###,###,###,###.##";
     ctr.ColFormat(G1_TOTAL_AMOUNT) = "#,###,###,###,###,###.##";
  }
//==========================================================================

function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdDetail' :        
            data_dscd00061_2.Call("SELECT")            
        break;
                
        case 'Master' :             
            data_dscd00061_1.Call("SELECT");
        break;
    }
}
//==========================================================================

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_dscd00061_1" :
           
            //---------------------------- 
            OnSearch('grdDetail');   
                         
        break;
               
        case "data_dscd00061_2":
	        if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G1_OUT_ITEM_CODE, grdDetail.rows - 1, G1_OUT_ITEM_CODE,  true);
	            
                grdDetail.SetCellBold( 1, G1_REQ_QTY, grdDetail.rows - 1, G1_REQ_QTY, true);
                grdDetail.SetCellBold( 1, G1_OUT_QTY, grdDetail.rows - 1, G1_OUT_QTY, true);
                
                grdDetail.SetCellBold( 1, G1_TOTAL_AMOUNT, grdDetail.rows - 1, G1_TOTAL_AMOUNT, true);                
                
                grdDetail.SetCellBgColor( 1, G1_REQ_ITEM_CODE , grdDetail.rows - 1, G1_REQ_ITEM_NAME , 0xCCFFFF );
                
				var t_total_qty = 0;
				
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    if ( Number(grdDetail.GetGridData( i, G1_REQ_ITEM_PK)) > 0 && ( grdDetail.GetGridData( i, G1_REQ_ITEM_PK) != grdDetail.GetGridData( i, G1_OUT_ITEM_PK) ) )
                    {
                        grdDetail.GetGridControl().Cell( 7, i, G1_OUT_ITEM_CODE, i, G1_OUT_ITEM_NAME ) = 0x3300cc;
                    } 
					
					t_total_qty = t_total_qty + Number(grdDetail.GetGridData( i, G1_OUT_QTY      ));
                }  
				
				lblTotalOutQty.text = t_total_qty;  
                //--------------------------------                
            }         
        break;
        
        case 'pro_dscd00061':
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();            
        break;
		
 		case 'pro_dscd00061_1':
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();            
        break;		
    }
}
 
//==========================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_CODE) = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_NAME) = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_QTY)       = true ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_UOM)       = true ;
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)  = true ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT) = true ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_RATE)    = true ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_AMOUNT)  = true ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT)= true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_CODE) = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_ITEM_NAME) = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_QTY)       = false ;
		grdDetail.GetGridControl().ColHidden(G1_REQ_UOM)       = false ;				
		
		grdDetail.GetGridControl().ColHidden(G1_UNIT_PRICE)  = false ;
		grdDetail.GetGridControl().ColHidden(G1_ITEM_AMOUNT) = false ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_RATE)    = false ;
		grdDetail.GetGridControl().ColHidden(G1_VAT_AMOUNT)  = false ;
		grdDetail.GetGridControl().ColHidden(G1_TOTAL_AMOUNT)= false ;
				
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
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
                pro_dscd00061.Call();
            }    
        break;
		
		case 'Cancel' :
			if ( confirm('Do you want to cancel this Slip?'))
            {
                pro_dscd00061_1.Call();
            }  		
		break;
    }	
}

//==========================================================================
</script>

<body>
    <!---------------------------------------------------------------------------->
    <gw:data id="data_dscd00061_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="control" function="<%=l_user%>lg_sel_dscd00061_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"> 
                <inout > 
                      <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />
					 <inout  bind="lblStatus" />
					 <inout  bind="txtRefNo" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstTransType" />                      
                     <inout  bind="txtCustomerPK" />
                     <inout  bind="txtCustomerName" />
					 <inout  bind="txtAmount" /> 
                     <inout  bind="lstCurrency" />  
                     <inout  bind="txtExRate" />					 
                     <inout  bind="txtRemark" />   
					 <inout  bind="lstOutType" />  
                </inout> 
             </dso> 
        </xml> 
    </gw:data>  
    <!---------------------------------------------------------------------------->
    <gw:data id="data_dscd00061_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dscd00061_2" parameter ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"  > 
                <input bind="grdDetail" > 
                     <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="pro_dscd00061" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00060_3" > 
                <input>
                    <input bind="txtMasterPK" />
                     
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
	<!---------------------------------------------------------------------------->
    <gw:data id="pro_dscd00061_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dscd00060_4" > 
                <input>
                    <input bind="txtMasterPK" />
                
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
    <!---------------------------------------------------------------------------->
   <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                         
                        <td style="width: 40%" align="center" colspan=2 >
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>                         
                        <td style="width: 20%" align="right">
                            <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
							<gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Ref No
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRefNo" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">                            
                                Charger 
                        </td>
                        <td colspan=2 >
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Trans Type
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstTransType" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                              Deli To 
                        </td>
                        <td style="white-space: nowrap" colspan=2 >
                             <gw:textbox id="txtCustomerPK" styles="display:none" />
                             <gw:textbox id="txtCustomerName" styles="width:100%" />
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Total AMT
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:textbox id="txtAmount" styles="width:100%;" type="number" format="#,###.###"
                                csstype="mandatory" />
                        </td>
                       
                        <td style="width: 10%; white-space: nowrap" align="right">
						    Ex-Rate                             
                        </td>
                         <td style="width: 20%" >
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td style="width: 20%" >
                        	<gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###" />                            
                        </td>
                    </tr>    
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                             In-Type 
                        </td>
                        <td colspan="3" style="white-space: nowrap">
                            <gw:list id="lstOutType" styles="width:100%" onchange="" />
                        </td>												 
                        <td style="width: 10%" align="right">
                             Remark
                        </td>
                        <td colspan=2 >
                             <gw:textbox id="txtRemark" styles="width:100%;" /> 
                        </td>
                    </tr>					 
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="left">                            
                            <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                            style="cursor: hand" onclick="OnToggleGrid()" />
                        </td>
						<td style="width: 25%; white-space: nowrap" align="right">                                      
                        </td>
						<td style="width: 5%; white-space: nowrap" align="right">
                             Qty :
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
                             <gw:label id="lblTotalOutQty" styles='width:100%;color:cc0000;font:9pt' text='' type="number"
                                 format="###.###,###.##" />
                        </td>
						<td align="right" colspan=3 >                                      
                        </td>	
                    </tr>
                    <tr style="height: 95%">
						<td colspan="7">
                        	<gw:grid id='grdDetail' 
								header='_PK|Seq|Ref No|_REQ_ITEM_PK|Req Item Code|Req Item Name|_OUTGO_ITEM_PK|Rtn Item Code|Rtn Item Name|Req Qty|UOM|Rtn Qty|UOM|U/P|Item Amt|Tax (%)|Tax Amt|Total Amt|Lot No|_WH_PK|W/H|Remark|_MASTER_PK|_SO_D_PK|_REQ_D_PK'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|1|1|0|0|0|0|0|0|3|1|3|1|3|3|3|3|3|1|0|0|0|0|0|0'
                                check='||||||||||||||||||||||||' 
							    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|800|1500|0|1500|3000|0|1500|3000|1200|800|1200|800|1200|1500|1200|1500|1500|1500|0|1500|1000|0|0|0'
                                sorting='T' styles='width:100%; height:100%' acceptnulldate='T'/>  
						</td>		                          
                    </tr>
                </table>
            </td>
        </tr>
    </table> 
    <!-------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!-------------------------------------------------------------->
</body>
</html>
