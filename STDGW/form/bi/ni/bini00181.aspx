<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Ougoing</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_Seq              = 1,
    G1_Ref_No           = 2,
    G1_REQ_ITEM_PK      = 3,
    G1_Req_Item_Code    = 4,
    G1_Req_Item_Name    = 5,
    G1_OUTGO_ITEM_PK    = 6,
    G1_Out_Item_Code    = 7,
    G1_Out_Item_Name    = 8,
    G1_Req_Qty          = 9,
    G1_Req_UOM          = 10,
    G1_Out_Qty          = 11,
    G1_Out_UOM          = 12,
    G1_UP               = 13,
    G1_Amount           = 14,
    G1_VAT_Rate         = 15,
    G1_VAT_Amount       = 16,
    G1_Total_Amount     = 17,
    G1_Lot_No           = 18,
    G1_Item_BC          = 19,
    G1_Description      = 20,
    G1_MASTER_PK        = 21,
    G1_PO_D_PK          = 22,
    G1_QC_IREQ_D_PK     = 23;
 //===============================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    

    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtPLName.SetEnable(false);
    //----------------------------    
    BindingDataList();    
    //----------------------------         
    SetGridFormat();  
    OnToggleGrid();
    //----------------------------
    txtMasterPK.text = "<%=Request.querystring("outgo_pk")%>";
	
	p_type = "<%=Request.querystring("type")%>";  
	
	if ( p_type == 'APPROVE' )
	{ 
		btnCancel.style.display = "none";
	}
	else
	{
		btnApprove.style.display = "none";
	}
	
    OnSearch('grdMaster');
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------- 
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0 and use_yn = 'Y' ORDER BY line_id" )%>";    
     lstLine.SetDataText(data);     
     
     data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM tlg_in_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>";    
     lstWH.SetDataText(data);          
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_Req_Qty) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_Out_Qty) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_UP)        = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_Amount)    = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_VAT_Rate)     = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_VAT_Amount)   = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_Total_Amount) = "#,###,###,###,###,###.###";
 }

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdMaster':        
            data_bini00181_1.Call("SELECT");                             
        break;
        
        case 'grdDetail':          
            data_bini00181_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {    
        case "pro_bini00181":
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();
        break;
		
		case "pro_bini00181_1":
            alert(txtReturnValue.text);
            window.returnValue = 1; 
            this.close();
        break;		
            
        case "data_bini00181_1":         
            //---------------------------- 
            OnSearch('grdDetail');                               
        break;

        case "data_bini00181_2":
            if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G1_Out_Item_Code, grdDetail.rows - 1, G1_Out_Item_Code,  true);
	            
                grdDetail.SetCellBold( 1, G1_Req_Qty, grdDetail.rows - 1, G1_Req_Qty, true);
                grdDetail.SetCellBold( 1, G1_Out_Qty, grdDetail.rows - 1, G1_Out_Qty, true);
                grdDetail.SetCellBold( 1, G1_UP,           grdDetail.rows - 1, G1_Amount,       true);
                grdDetail.SetCellBold( 1, G1_VAT_Rate,     grdDetail.rows - 1, G1_VAT_Rate,     true);
                grdDetail.SetCellBold( 1, G1_VAT_Amount,   grdDetail.rows - 1, G1_VAT_Amount,   true);
                grdDetail.SetCellBold( 1, G1_Total_Amount, grdDetail.rows - 1, G1_Total_Amount, true);
                
                grdDetail.SetCellBold( 1, G1_Ref_No, grdDetail.rows - 1, G1_Ref_No, true);
                
                grdDetail.SetCellBgColor( 1, G1_Req_Item_Code , grdDetail.rows - 1, G1_Req_Item_Name , 0xCCFFFF );
                
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    if ( Number(grdDetail.GetGridData( i, G1_REQ_ITEM_PK)) > 0 && ( grdDetail.GetGridData( i, G1_REQ_ITEM_PK) != grdDetail.GetGridData( i, G1_OUTGO_ITEM_PK) ) )
                    {
                        grdDetail.GetGridControl().Cell( 7, i, G1_Out_Item_Code, i, G1_Out_Item_Name ) = 0x3300cc;
                    }                    
                }        
                //--------------------------------
            }                  
        break;         
   }            
}

//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Approve' :
            if ( confirm('Do you want to Approve this Slip?'))
            {
                pro_bini00181.Call();
            }    
        break;
		
		case 'Cancel' :
            if ( confirm('Do you want to cancel this Slip?'))
            {
                pro_bini00181_1.Call();
            }    
        break;		
    }
}

//======================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Code) = true ;
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Name) = true ;
		grdDetail.GetGridControl().ColHidden(G1_Req_Qty)       = true ;
		grdDetail.GetGridControl().ColHidden(G1_Req_UOM)       = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Code) = false ;
		grdDetail.GetGridControl().ColHidden(G1_Req_Item_Name) = false ;
		grdDetail.GetGridControl().ColHidden(G1_Req_Qty)       = false ;
		grdDetail.GetGridControl().ColHidden(G1_Req_UOM)       = false ;				
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}

//=================================================================================
</script>

<body>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bini00181_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_bini00181_1"  procedure="<%=l_user%>lg_upd_bini00181_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtVoucherDate" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="lstLine" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtRemark" /> 
                     <inout  bind="lblStatus" />     
                     <inout  bind="txtRefNo" /> 
                     <inout  bind="txtAmount" /> 
                     <inout  bind="txtCCY" />                                                     
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_bini00181_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="<%=l_user%>lg_sel_bini00181_2"   procedure="<%=l_user%>lg_upd_bini00181_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00181" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00180_3" > 
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
    <gw:data id="pro_bini00181_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00180_4" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>	
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <tr style="height: 1%">
                <td align="right" style="width: 10%; white-space: nowrap">
                    Date
                </td>
                <td style="width: 25%">
                    <gw:datebox id="dtVoucherDate" lang="1" />
                </td>
                <td align="right" style="width: 5%; white-space: nowrap">
                    
                </td>
                <td style="width: 10%" align="left">
                    
                </td>
                <td align="right" style="width: 10%">
                </td>
                <td style="width: 40%" align="center">
                    <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                </td>
                <td style="width: 10%">
                    <gw:icon id="btnApprove" img="2" text="Approve" onclick="OnProcess('Approve')" />
					<gw:icon id="btnCancel" img="2" text="Cancel" onclick="OnProcess('Cancel')" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td align="right" style="width: 10%; white-space: nowrap">
                    Slip No
                </td>
                <td style="white-space: nowrap" colspan="3">
                    <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                </td>
                <td align="right" style="width: 10%; white-space: nowrap">
                    Charger
                </td>
                <td colspan="7">
                    <gw:textbox id="txtStaffName" styles="width:100%" />
                    <gw:textbox id="txtStaffPK" styles="display:none" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td align="right" style="width: 10%; white-space: nowrap">
                    Ref No
                </td>
                <td style="white-space: nowrap" colspan="3">
                    <gw:textbox id="txtRefNo" styles="width:100%;" />
                </td>
                <td align="right" style="width: 10%; white-space: nowrap">
                    P/L
                </td>
                <td colspan="7">
                    <gw:textbox id="txtPLPK" styles="display:none" />
                    <gw:textbox id="txtPLName" styles="width:100%" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td align="right" style="width: 10%; white-space: nowrap">
                    Line
                </td>
                <td style="white-space: nowrap" colspan="3">
                    <gw:list id="lstLine" styles='width:100%' csstype="mandatory" />
                </td>
                <td align="right" style="width: 10%; white-space: nowrap">
                    W/H
                </td>
                <td style="white-space: nowrap" colspan="7">
                    <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td style="width: 10%; white-space: nowrap" align="right">
                    Total AMT
                </td>
                <td colspan="3" style="white-space: nowrap">
                    <gw:textbox id="txtAmount" styles="width:70%;" type="number" format="#,###.###" csstype="mandatory" />
                    <gw:textbox id="txtCCY" styles="width:30%;" />
                </td>
                <td align="right" style="width: 10%">
                    Remark
                </td>
                <td colspan="7">
                    <gw:textbox id="txtRemark" styles="width:100%;" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td colspan="12">
                    <table style="width: 100%; height: 100%">
                        <tr>
                            <td style="width: 10%" align="left">
                                <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                    style="cursor: hand" onclick="OnToggleGrid()" />
                            </td>
                            <td style="width: 65%" align="right">
                            </td>
                            <td style="width: 20%" align="center">
                            </td>
                            <td align="right" style="width: 1%">
                            </td>
                            <td align="right" style="width: 1%">
                            </td>
                            <td align="right" style="width: 1%">
                            </td>
                            <td style="width: 1%">
                            </td>
                            <td style="width: 1%">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 97%">
                <td colspan="12">
                    <gw:grid id='grdDetail' header='_PK|Seq|Ref No|_REQ_ITEM_PK|Req Item Code|Req Item Name|_INCOME_ITEM_PK|Out Item Code|Out Item Name|Req Qty|UOM|Out Qty|UOM|U/P|Amount|VAT(%)|VAT Amount|Total Amount|Lot No|Item BC|Description|_ST_INCOME_M_PK|_PO_PO_D_PK|_QC_IREQ_D_PK'
                        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|1|1|0|0|0|0|0|0|3|1|3|1|3|3|3|3|3|1|1|0|0|0|0'
                        check='|||||||||||||||||||||||' editcol='0|1|1|0|0|0|0|0|0|1|0|1|0|1|1|1|1|1|1|1|1|0|0|0'
                        widths='0|800|1000|0|1500|2000|0|1500|2000|1200|1000|1200|1000|1200|1200|1200|1200|1200|1500|1500|1000|0|0|0'
                        sorting='T' styles='width:100%; height:100%' />
                </td>
            </tr>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
