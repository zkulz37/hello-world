<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Payment Slip</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//-----------------------------------------------------

var flag;

var G_PK        = 0,     
    G_SLip_No   = 1,
    G_Date      = 2,
    G_PARTNER   = 3;

//=================================================================================

var G1_DETAIL_PK            = 0,
    G1_MASTER_PK            = 1,
    G1_SEQ                  = 2,
    G1_PAY_AMOUNT           = 3,
    G1_DEDUCT_AMOUNT        = 4,
    G1_BAL_AMOUNT           = 5,
    G1_PAYMENT_DESC         = 6,
    G1_PC_PAYMENT_REQ_M_PK  = 7;
        
var arr_FormatNumber = new Array();   
 //===============================================================================================
 
var rtnLGCode = '' ;

function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
     
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtCustomerName.SetEnable(false);      
    
    //-------------------------
    
    txtMasterPK.text="<%=Request.querystring("MasterPK")%>";
    
    var data ;
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0110') FROM DUAL")%>||";  //report type
    lstColMedName.SetDataText(data);
    lstColMedName.value="";
    
//    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGSA6020') FROM DUAL")%>||";  //report type
//    lstColTypeName.SetDataText(data);
//    lstColTypeName.value="";
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL" )%>";    
    lstCurrency.SetDataText(data);
    
    //----------------------------         
    SetGridFormat();  
    //OnToggleGrid();
    //----------------------------
    OnSearch('grdMaster');
 }
 //==================================================================================
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_DEDUCT_AMOUNT) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_BAL_AMOUNT) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G1_PAY_AMOUNT) = "#,###,###,###,###,###.###";
    
    arr_FormatNumber[G1_DEDUCT_AMOUNT] = 3;    
 }
 //==================================================================================
  

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdMaster':
            data_dsap00040_1.Call("SELECT");                             
        break;
        
        case 'grdDetail':            
            data_dsap00040_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'data_dsap00040_1':
            OnSearch('grdDetail');
        break;
        case'pro_dsap00032':
            this.close();
        break;
    }          
}
//=================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'cancel' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to Cancel this Slip?'))
                {
                    pro_dsap00032.Call();
                } 
            }                          
        break;        
    }
}
//=================================================================================

//=================================================================================

//=================================================================================


//=================================================================================


//=================================================================================

//=================================================================================

//=================================================================================


//=================================================================================

//=================================================================================
</script>

<body>
    <!-----------------------grdSearch---------------------------------------->
    <!------------------------------------------------------------------------->
    <gw:data id="data_dsap00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_dsap00040_1"  procedure="<%=l_user%>lg_upd_dsap00040_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtReqDate" />
                     <inout  bind="lblStatus" />                         
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />                                          
                     <inout  bind="txtCustomerPK" />
                     <inout  bind="txtCustomerName" />					 				 
                     <inout  bind="txtRemark" />             
                     <inout  bind="lstColMedName" />           
                     <inout  bind="txtTotalAmt" /> 
                     <inout  bind="txtPayAmt" /> 
                     <inout  bind="txtBalAmt" />    
                     <inout  bind="lstCurrency" /> 
                     <inout  bind="txtExRate" />                                                                       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00040_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_dsap00040_2"   procedure="<%=l_user%>lg_upd_dsap00040_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsap00032" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsap00032" > 
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
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtReqDate" lang="1" />
                        </td>
                        <td style="width: 20%" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:icon id="idBtnSubmit" img="2" text="Cancel" styles='width:100%' onclick="OnProcess('cancel')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Customer
                        </td>
                        <td>
                            <gw:textbox id="txtCustomerPK" styles="display:none" />
                            <gw:textbox id="txtCustomerName" styles="width:100%" readonly="true" />
                        </td>
                        <td align="right" style="width: 10%">
                            Charger
                        </td>
                        <td colspan="10">
                            <gw:textbox id="txtStaffName" styles="width:100%" readonly="true" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Collect Method
                        </td>
                        <td style="white-space: nowrap">
                            <gw:list id="lstColMedName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Ex-Rate
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstCurrency" styles="width:100%" onchange="" />
                        </td>
                        <td style="white-space: nowrap" colspan="7">
                            <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###.###"
                                readonly="true" />
                        </td>
                    </tr>
                    <%--<tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Ref No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtRefNo" styles="width:100%;" readonly="true" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Collect Type
                        </td>
                        <td style="white-space: nowrap" colspan="10">
                            <gw:list id="lstColTypeName" styles="width:100%" />
                        </td>
                    </tr>--%>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Collect Description
                        </td>
                        <td style="white-space: nowrap" colspan="12">
                            <gw:textbox id="txtRemark" styles="width:100%;" readonly="true" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="13">
                            <table style="width: 100%; height: 100%; background-color: #CCFFFF">
                                <tr style="height: 1%">
                                    <td style="width: 10%; white-space: nowrap">
                                        Total Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtTotalAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R"
                                            readonly="true" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap">
                                        Pay Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtPayAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R"
                                            readonly="true" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap">
                                        Bal Amount
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtBalAmt" styles="width:100%" type="number" format="#,###,###,###,###.###R"
                                            readonly="true" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="14">
                            <gw:grid id='grdDetail' header='_PK|_MASTER_PK|Seq|Slip No/Ref No|_ITEM_DESC|Req Amount|Pay Amount|Bal Amount|Collect Desc|_PC_COLLECT_REQ_M_PK'
                                format='0|0|0|0|0|1|1|1|0|0' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||' editcol='0|0|0|0|0|0|0|0|0|0'
                                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' acceptnulldate='T' />
                            />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:textbox id="txtLGGroupCodeID" styles="width: 100%;display: none" />
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtReturnValue" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
</html>
