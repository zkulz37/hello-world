<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Payment Request PopUp</title>
</head>

<script>
   var G2_pk        =0,
   G2_req_m_pk      =1,
   G2_tco_item_pk   =2,
   G2_item_code     =3,
   G2_item_name     =4,
   G2_unit_price    =5,
   G2_item_amt      =6,
   G2_vat_rate      =7,
   G2_vat_amt       =8,
   G2_total_amt     =9;  
//======================================================================    

function BodyInit()
{
    System.Translate(document); 
    txtPayReqPK.text = "<%=Request.querystring("payreq_pk")%>" ;
    //--------------
    txtPayNo.SetEnable(false);
    
    txtCustID.SetEnable(false);
     
    txtChargerID.SetEnable(false);
    txtChargerName.SetEnable(false);
    
    txtReqEmpID.SetEnable(false);
    txtReqEmpName.SetEnable(false);
    //-------------- 
    OnSearch('Master')
    OnBindingData();    
}
//======================================================================    

function OnSearch(pos)
{
    switch(pos)
    {
        case 'Master':
            data_dsap00021.Call("SELECT");
        break;
        
        case 'grdDetail':
            data_dsap00021_1.Call("SELECT");
        break;     
    }
}
function OnBindingData()
{   var data =""
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0100') FROM DUAL" )%>"; 
    lstCurr.SetDataText(data)
    
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGCM0110') FROM DUAL")%>||";  //payment form
    lstPayType.SetDataText(data);
}
//======================================================================
function OnFormat()
{
   
    var ctrl = grdDetail.GetGridControl();

    ctrl.ColFormat(G2_vat_amt) = "###,###,###,###";
    ctrl.ColFormat(G2_total_amt)= "###,###,###,###";	
    ctrl.ColFormat(G2_item_amt)= "###,###,###,###";
}

//====================================================================== 

function OnDataReceive(obj)
{
    switch(obj.id)
    {
       
        case 'data_dsap00021':
          
                OnSearch('grdDetail');
           
        break;        
    }
} 
 //=======================================================================

</script>

<body>
  
    <!------------------------------------------------------------------>
    <gw:data id="data_dsap00021" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control"  function="<%=l_user%>lg_sel_dsap00021" > 
                <inout>
                    <inout bind="txtPayReqPK" />
                    <inout bind="txtPayNo" />  
                    <inout bind="dtReqDT" />
                    <inout bind="txtCustPK" />
                    <inout bind="txtCustID" />
                    <inout bind="txtCustName" />
                    <inout bind="txtPONo" />
                                        
                    <inout bind="lstPayType" />  
                    <inout bind="lstCurr" />          
                    <inout bind="txtExRate" /> 
                    
                    <inout bind="txtChargerPK" /> 
                    <inout bind="txtChargerID" /> 
                    <inout bind="txtChargerName" /> 
                    <inout bind="txtReqEmpPK" /> 
                    <inout bind="txtReqEmpID" /> 
                    <inout bind="txtReqEmpName" /> 
                    
                    <inout bind="txtArraySOPK" />                                        
                    <inout bind="txtDescription" />  
                    
                    <inout bind="txtItemAmt" />                                        
                    <inout bind="txtVatAmt" />  
                    <inout bind="txtTotalAmt" />    
                      
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    
    <!--------------------------------------------------------------------->
    <gw:data id="data_dsap00021_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_SEL_dsap00021_1" >
                <input bind="grdDetail" >
			        <input bind="txtPayReqPK" />
                </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Req No</td>
            <td style="width: 20%">
                <gw:textbox id="txtPayNo" maxlen="100" styles='width:100%' />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Request DT</td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtReqDT" lang="<%=Application("Lang")%>" mode="01" />                
            </td>
           <td style="width: 5%; white-space: nowrap" align="right">
               Bill to </td>
            <td style="width: 45%; white-space: nowrap" align="right" colspan=4>
                <gw:textbox id="txtCustPK" styles="display:none" />
                <gw:textbox id="txtCustID" styles="width:30%" csstype="mandatory" />
                <gw:textbox id="txtCustName" styles="width:70%" csstype="mandatory" />
            </td>
        </tr>
        <tr style="height: 1%">  
            <td style="width: 5%; white-space: nowrap" align="right">
                P/O No</td>
            <td style="width: 20%">
                <gw:textbox id="txtPONo" maxlen="100" styles='width:100%' />
            </td>         
            <td style="width: 5%; white-space: nowrap" align="right">
               Payment Type  </td>
            <td style="width: 20%">
                 <gw:list id="lstPayType" styles='width:100%'  />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                Currency
            </td>
            <td style="width: 20%">
               <gw:list id="lstCurr" styles='width:100%'  />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                Ex Rate</td>
            <td style="width: 20%" >
                <gw:textbox id="txtExRate" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>            
        </tr>
          <tr style="height: 1%">           
            <td style="width: 5%; white-space: nowrap" align="right">
               <a title="Supplier" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                                                        Charger</a> </td>
            <td style="width: 20%">
                <gw:textbox id="txtChargerPK" styles='width:100%; display:none' />
                <gw:textbox id="txtChargerID"    styles='width:30%' />
                <gw:textbox id="txtChargerName" maxlen="100" styles='width:70%' />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                <a title="Supplier" onclick="OnPopUp('ReqEmp')" href="#tips" style="color: #0000ff">
                                                        Requester</a>
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtReqEmpPK" styles='width:100%; display:none' />
                <gw:textbox id="txtReqEmpID"  styles='width:30%' />
                <gw:textbox id="txtReqEmpName" maxlen="100" styles='width:70%' />
            </td>
             <td style="width: 5%; white-space: nowrap" align="right">
                Description</td>
            <td style="width: 45%" colspan=4>
                <gw:textbox id="txtDescription" maxlen="100" styles='width:100%' />
            </td>            
        </tr>
        <tr>
            <td style="width: 5%; white-space: nowrap" align="right">
                Item Amount</td>
            <td style="width: 20%" >
                <gw:textbox id="txtItemAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>    
            <td style="width: 5%; white-space: nowrap" align="right">
                Vat Amount</td>
            <td style="width: 20%" >
                <gw:textbox id="txtVatAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>    
            <td style="width: 5%; white-space: nowrap" align="right">
                Total Amount</td>
            <td style="width: 20%" >
                <gw:textbox id="txtTotalAmt" maxlen="100" type='number' format="#,###,###,###,###.##R" styles='width:100%' />
            </td>    
        </tr>       
        <tr style="height: 98%">
            <td colspan="8">
                    <gw:grid id='grdDetail'
                    header='_PK|_PC_PAYMENT_REQ_M_PK|_TCO_ITEM_PK|Item CD|Item Name|Unit Price|Item Amt|Vat Rate|Vat Amt|Total Amt'
                    format='0|0|0|0|0|1|1|1|1|1'
                    aligns='0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||'
                    editcol='0|0|0|0|1|1|1|1|1|1'
                    widths='0|0|0|1500|2000|1500|1500|1500|1500|1500'
                    sorting='T'
                    styles='width:100%; height:100%' onafteredit="CheckInput()"  
                    />
             </td>
        </tr>
    </table>
    <!--------------------------------------------------------------->
    <gw:textbox id="txtPayReqPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtArraySOPK" maxlen="100" styles='width:100%;display:none' />
    
</body>
</html>
