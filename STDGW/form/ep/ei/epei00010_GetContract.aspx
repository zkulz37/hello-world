<%@ Page Language="C#" AutoEventWireup="true"%>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Select Contract</title>
</head>

<%  ESysLib.SetUser("comm");%>
<script language="javascript" type="text/javascript">
    function BodyInit()
    {
        System.Translate(document);  // Translate to language session
        
        var ldate;
        
        txtVendor.text= "<%=Request.QueryString["vendor"] %>";
        ldate=dtFrom.value;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' 
        dtFrom.value= ldate;
    }
    //-------------------------------------------------------------------------
    function OnGridCellClick()
    {
        txtContrPK.text='';
        txtOrderPK.text='';
        txtContrNo.text='';
        txtOrderNo.text='';
        grdItem.ClearData();
        
        var flag;
        flag=0;
          
        for (var i=1; i<grdContractOrder.rows;i++)
            if (grdContractOrder.GetGridData(i,0)=='-1')    
                { 
                    flag=1;
                    txtContrPK.text = txtContrPK.text + grdContractOrder.GetGridData(i,10) + ','
                    if(grdContractOrder.GetGridData(i,11)!='')
                        txtOrderPK.text = txtOrderPK.text  + grdContractOrder.GetGridData(i,11) + ','
                }
         txtContrPK.text =txtContrPK.text.substr(0, txtContrPK.text.length-1)
         txtOrderPK.text =txtOrderPK.text.substr(0, txtOrderPK.text.length-1)
         txtTmp.text= '%' + txtItem.text + '%';
        if (flag==1) 
            dat_epei00010_2.Call('SELECT');
    }
    //-------------------------------------------------------------------------
    function OnDataReceive(obj)
    {
    
    }
    //-------------------------------------------------------------------------  
    function OnSelect()
    {
        var arr_data = new Array();
       
        txtContrNo.text='';
        txtContrPK.text='';
        
       if(grdItem.rows > 1)
       {            
          for(var i=1;i<grdItem.rows;i++)
          {
            if (grdItem.GetGridData(i,0)=="-1")
            {
                var arrTemp=new Array();
                 for(var j=0;j<grdItem.cols;j++)
                 {
                    arrTemp[arrTemp.length]= grdItem.GetGridData(i,j);
                 }
                
                 arr_data[arr_data.length]= arrTemp;
                 if((txtContrNo.text.indexOf(grdItem.GetGridData(i,2))<0)||(txtContrNo.text==''))
                 {
                    txtContrNo.text = txtContrNo.text + grdItem.GetGridData(i,2) + ','
                    txtContrPK.text = txtContrPK.text  + grdItem.GetGridData(i,12) + ','
                 }
                 if((txtOrderNo.text.indexOf(grdItem.GetGridData(i,3))<0)||(txtOrderNo.text==''))
                 {
                    txtOrderNo.text = txtOrderNo.text + grdItem.GetGridData(i,3) + ','
                 }
             }
          }
      }             
         txtContrNo.text =txtContrNo.text.substr(0, txtContrNo.text.length-1);
         txtOrderNo.text =txtOrderNo.text.substr(0, txtOrderNo.text.length-1);
         txtContrPK.text = txtContrPK.text.substr(0, txtContrPK.text.length-1);
        
         var arrTemp=new Array(); 
         arrTemp[0]=txtContrNo.text;
         arrTemp[1]=txtOrderNo.text;
         arrTemp[2]=txtContrPK.text;
         arr_data[arr_data.length]= arrTemp;
         
         arrTemp=new Array(); 
         for(i=1; i<grdContractOrder.rows; i++)
         {
            if( grdContractOrder.GetGridData(i,0)=='-1')
            {
                for(j=0; j<grdContractOrder.cols;j++)
                    arrTemp[arrTemp.length] = grdContractOrder.GetGridData(i,j); 
                break;               
            }
         }
         arr_data[arr_data.length]= arrTemp;
         
	      if ( arr_data !=null )
	      {
		    window.returnValue =  arr_data;
		    window.close();
	      }
	      else
	      {
	        alert("You have not selected data yet.");
	      }
        
    }
    //------------------------------------------------------------------------
    function onReset()
    {
        txtItem.text='';
    }
    //-------------------------------------------------------------------------
    function SelectAll()
    {
        for(var i=1; i< grdItem.rows; i++)
        {
            grdItem.SetGridText(i,0,"-1");
        }        
    }
    //-------------------------------------------------------------------------
</script>

<body>
<!-----------------------grdContractOrder---------------------------------------->
<gw:data id="dat_epei00010_1"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="IMEX.sp_sel_contract_order" > 
                <input> 
                    <input bind="txtContractNo" />
                    <input bind="txtOrdNo" /> 
                    <input bind="txtVendor" /> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" /> 
                </input> 
                <output bind="grdContractOrder" /> 
            </dso> 
        </xml> 
</gw:data>   
<!-----------------------grdItem---------------------------------------->
<gw:data id="dat_epei00010_2"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="IMEX.sp_sel_contract_order_item" > 
                <input> 
                    <input bind="txtContrPK" /> 
                    <input bind="txtOrderPK" /> 
                    <input bind="txtTmp" /> 
                </input> 
                <output bind="grdItem" /> 
            </dso> 
        </xml> 
</gw:data> 
<!--------------------------------------------------------------->
    <form id="form1" runat="server">
        <table width="100%" cellpadding=0 cellspacing=0 border=0>
            <tr>
                <td width="9%" nowrap >Contract No</td>
                <td width="12%" colspan="2"><gw:textbox id="txtContractNo"  onkeypress="" csstype="mandatory" styles="width:100%;" /></td>
                <td width="8%" align="right" >Order No</td>
                <td width="2%"></td>
                <td width="15%"><gw:textbox id="txtOrdNo"  onkeypress="" csstype="mandatory" styles="width:100%;" /></td>
                <td width="3%"></td>
                <td>
                    <table width="100%" cellpadding=0 cellspacing=0>
                        <tr>
                            <td width="15%" nowrap >Contract Date</td>
                            <td width="15%"><gw:datebox id="dtFrom" lang="1" onchange=""/></td>
                            <td width="2%" align="center" >~</td>
                            <td width="68%"><gw:datebox id="dtTo" lang="1" onchange=""/></td>
                        </tr>
                    </table>
                </td>
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="dat_epei00010_1.Call('SELECT');" /></td>
                <td width=2%><gw:imgbtn id="btnSel" img="select" alt="Select" text="Select" onclick="OnSelect()" /></td>                                
            </tr>
            <tr>
                <td colspan="10" height=10></td>
            </tr>
            <tr>
            <%--0.Select|1.No|2.Contract No|3.Contract Date|4.Order No|5.Order Date|6.Trans. Curr|7.Trans. Amt
            |8.Iplement|9.Remain|10._Contr_Pk|11._Order_Pk|12._ex_rate|13._plc_discharge|14._plc_loading
            |15._shipment_date|16._trade_terms|17._pay_meth|18._pay_ccy|19._pay_term|20._ship_opt|21._discount
            |22._transport_by|23._trade_loc|24._tco_buspartner_pk1|25.pay_ex_rate|26.loading|27.discharge'--%>
                <td colspan="10">
                    <gw:grid id='grdContractOrder'
                        header='Select|No|Contract No|Contract Date|Order No|Order Date|Trans. Curr|Trans. Amt|Iplement|Remain|_Contr_Pk|_Order_Pk|_ex_rate|_plc_discharge|_plc_loading|_shipment_date|_trade_terms|_pay_meth|_pay_ccy|_pay_term|_ship_opt|_discount|_transport_by|_trade_loc|_tco_buspartner_pk1|_pay_ex_rate|_loading|_discharge'
                        format='3|0|0|4|0|4|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|0|0|0|0|0|0|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        defaults='|||||||||||||||||||||||||||'
                        editcol='1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='800|1000|1500|1500|1500|1500|1200|1200|1200|1000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        sorting='T'
                        styles='width:100%; height:260'
                        oncellclick='OnGridCellClick()'
                    />
                </td>
            </tr>
            <tr>
                <td width="10%"><a title="Click here to select all items" onclick="SelectAll()" href="#tips" style="text-decoration : none; color=#0000FF">Select All</td>
                <td width="10%" align="right">Item</td>
                <td width="2%"></td>
                <td width="25%" colspan=3><gw:textbox id="txtItem"  onenterkey="OnGridCellClick()" csstype="mandatory" styles="width:100%;" /></td>
                <td width="2%"><gw:imgbtn id="btnReset0" img="reset" alt="Reset" text="Reset" onclick="onReset()" /></td>
                <td width="40%"></td>
                <td width=2%><%--<gw:imgbtn id="btnUp" img="back" alt="Up" text="Up" onclick="onChangePos(-1)" />--%></td>                
                <td width=2%><%--<gw:imgbtn id="btnDown" img="next" alt="Down" text="Down" onclick="onChangePos(1)" />--%></td>                
            </tr>
            <tr>
                <td colspan="10">
                <%--'0.Select|1.No|2.Contr No|3.Order No|4.Item Code|5.Item Name|6.Unit|7.Hs Code|8.U/price|9.Qty|10.Input Qty|11.Remain Qty|12._Contr_Pk|13._Order_Pk|14._Contr_Dlt_Pk|15._Tco_Item_Pk|16._Order_Yn|17._apportion|18._cnv_ratio'--%>
                    <gw:grid id='grdItem'
                        header='Select|No|Contr No|Order No|Item Code|Item Name|Unit|Hs Code|U/price|Qty|Input Qty|Remain Qty|_Contr_Pk|_Order_Pk|_Contr_Dlt_Pk|_Tco_Item_Pk|_Order_Yn|_apportion|_cnv_ratio|_unit_pack|_qty_pack|_tran_rate|_weight_rate'
                        format='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        aligns='0|0|0|0|0|0|0|0|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0'
                        defaults='||||||||||||||||||||||'
                        editcol='1|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0||0|0|0|0'
                        widths='800|600|1300|1300|1400|2000|700|1000|1000|900|1000|1000|0|0|0|0|0|0|0|0|0|0|0'
                        sorting='T'
                        styles='width:100%; height:300'
                    />
                </td>
            </tr>
        </table>
    </form>
</body> 
<gw:textbox id="txtContrPK" styles="display:none" />
<gw:textbox id="txtOrderPK" styles="display:none" />
<gw:textbox id="txtContrNo" styles="display:none" />
<gw:textbox id="txtOrderNo" styles="display:none" />
<gw:textbox id="txtVendor" styles="display:none" />
<gw:textbox id="txtTmp" styles="display:none" />
</html>
