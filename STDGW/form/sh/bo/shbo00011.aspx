<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>COLORANT USED</title>
</head>
<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_code  = "<%=Session("EMP_ID")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ; 
var colorYN ='';
    
var G1_pk               = 0, 
    G1_tsh_stnk_m_pk    = 1, 
    G1_col_code         = 2, 
    G1_tco_item_pk      = 3,
    G1_item_code        = 4, 
    G1_item_name        = 5, 
    G1_act_qty          = 6, 
    G1_seqno            = 7, 
    G1_cap_gu           = 8,
    G1_req_qty          = 9;
 //---------------------------------------------------------
 
 function BodyInit()
 {
   FormatGrid();
   var callerWindowObj = dialogArguments;    
   txtCap_GU.text = "<%=Request.QueryString("Captype")%>";
   
   if(txtCap_GU.text =='C')
   {
        txtColor.text = callerWindowObj.txtColorCap.text ;
        txtCapType.text = 'CAP'
   }
   else if(txtCap_GU.text =='B')
   {
        txtColor.text = callerWindowObj.txtColorBody.text ;
        txtCapType.text = 'BODY'
   }
   txtLotNO.text = callerWindowObj.txtLotNO.text ;
   txttsh_tank_pk.text = "<%=Request.QueryString("tank_m_pk")%>";
   txtSeq.text = "<%=Request.QueryString("seqno")%>";
   txtTankNo.text = "<%=Request.QueryString("tankno")%>";
   txtGelQty.text = "<%=Request.QueryString("gelqty")%>";
   data_shbo00011_2.Call('SELECT');
   txtTankNo.SetEnable(false);
   txtLotNO.SetEnable(false);
   txtGelQty.SetEnable(false);
   txtColor.SetEnable(false);
   txtCapType.SetEnable(false);
   txtSeq.SetEnable(false);
   txtCap_GU.SetEnable(false);
 }
//---------------------------------------------------------
function FormatGrid()
 {
      var trl ;
     
      trl = grdColor.GetGridControl();
      trl.ColFormat(G1_act_qty )     = "###,###,###,###,##0.##0";
 }
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_shbo00011_1':
            data_shbo00011_2.Call('SELECT');
        break;
    }
}
//======================================================================
function OnInputData()
{
    if(grdColor.rows >1)
    {
        OnUpdateData();
        //data_shbo00011_1.Call();
    }
    else
    {
        data_shbo00011_1.Call();
    }    
}
//======================================================================
function OnUpdateData()
{
    
    for (i =1; i< grdColor.rows;i++)
    {
        inst_qty=0;
         if(txtTankNo.text == '000')
         {
            inst_qty = Math.ceil( Number(grdColor.GetGridData(i, G1_req_qty)) * Number(txtGelQty.text)*1000)/1000;
         }
         else
            inst_qty =0;
         
        grdColor.SetGridText(i, G1_act_qty, inst_qty);
    }
}
//======================================================================
function OnExit()
{
    if(grdColor.rows>1)
        colorYN ='Y';
    else
        colorYN = 'N';
        
    window.returnValue = colorYN; 
    this.close(); 	
}
//======================================================================
function BodyClose()
{
    OnExit();
}
//------------------------------------------------------------------------------
</script>

<body>
     <!---------------------------------------------------------------->
    <gw:data id="data_shbo00011_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shbo00011_1" > 
                <input>
                    <input bind="txttsh_tank_pk" /> 
                    <input bind="txtColor" /> 
                    <input bind="txtCap_GU" /> 
                    <input bind="txtSeq" /> 
                    <input bind="txtGelQty" /> 
                    <input bind="txtTankNo" /> 
                    <input bind="txtLotNO" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00011_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8" function="prod.sp_sel_shbo00011_2" procedure="prod.sp_upd_shbo00011_2">
                <input bind="grdColor" >
                    <input bind="txtSeq" /> 
                    <input bind="txtCap_GU" />
                    <input bind="txtLotNO" />
                </input>
                <output bind="grdColor" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%"   valign="baseline" >
            <td style="width: 28%;white-space:nowrap"  align="right">
                <gw:textbox id="txtLotNO" styles='width:100%' csstype="mandatory"/>
            </td>
            <td style="width: 9%;margin-bottom: 3px;" align="right" >
                <gw:textbox id="txtSeq" styles='width:100%'/>
            </td>
            <td style="width: 35%;white-space:nowrap" align="right"> 
                <fieldset style="padding: 0">
                    <table style="width: 100%; height: 100%" >
                        <tr style="height: 100%">
                            <td style="white-space:nowrap" >
                                Color
                            </td>
                            <td style="white-space:nowrap" colspan=2 align=center >
                                Cap type
                            </td>
                            <td style="white-space:nowrap" >
                                Tank No.
                            </td>                            
                        </tr>
                        <tr style="height: 1%">
                            <td style="width: 25%;white-space:nowrap; " >
                                <gw:textbox id="txtColor" styles='width:100%;background-color:#009999'/>
                            </td>
                            <td style="width: 20%;white-space:nowrap" >
                                <gw:textbox id="txtCap_GU" styles='width:100%;background-color:#009999'/>
                            </td>
                            <td style="width: 30%;white-space:nowrap" >
                                <gw:textbox id="txtCapType" styles='width:100%;background-color:#009999'/>
                            </td>
                            <td style="width: 25%;white-space:nowrap" >
                                <gw:textbox id="txtTankNo" styles='width:100%'/>
                            </td>                            
                        </tr>
                    </table>
                </fieldset>
            </td>
            <td  align="right" style="width: 28%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%" valign="bottom">
                        <td style="width: 97%">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnInputData" img="3" text="Input Data" onclick="OnInputData()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnSave" img="3" text="Save" onclick="data_shbo00011_2.Call()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnExit" img="3" text="Exit" onclick="OnExit()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan=5>                
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan=5>
                <gw:grid id='grdColor' 
                    header='_pk|_tsh_stank_m_pk|_col_code|_tco_item_pk|Material Code|Material Name|Used Qty|Seqno|_Cap_Gu|_req_qty'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|3|1|0|0' defaults='|||||||||'
                    editcol='0|0|0|0|0|0|1|0|0|0' widths='0|0|0|0|2000|3500|1400|600|0|0'
                    check='||||||n|||' sorting='T' acceptnulldate="T"
                    styles='width:100%; height:100%'/>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>  
<gw:textbox id="txttsh_tank_pk" styles="width: 100%;display:none" />
<gw:textbox id="txtGelQty" styles="width: 100%;display:none" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
</html>
