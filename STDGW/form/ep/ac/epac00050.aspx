<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("sale")%>
<head id="Head1" runat="server">
    <title>EXPORT CONTRACT HISTORY</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
  //  var  user_code = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
        
    var G1_ex_rate      = 9,     
        G1_amount       = 10,     
        G1_vat_amt      = 11,     
        G1_total_amt    = 12,     
        G1_retouch_amt  = 13,     
        G1_trans_amt    = 14,
        G1_discount     = 37,    
        G1_disc_amt     = 38,
        G1_pay_ex_rate  = 41;
        
    var G2_qty          = 9,     
        G2_qty_packing  = 10,
        G2_u_price      = 11,    
        G2_ex_price     = 12,     
        G2_vat_rate     = 13,     
        G2_tot_amt      = 14,     
        G2_retouch_amt  = 15,     
        G2_tr_amt       = 16;
        
    var G3_pay_ex_rate  = 6,
        G3_ex_rate      = 8;
      
 //---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

 //---------------------------------------------------------
 function BodyInit()
 {
    var ldate;
   BindingDataList();
   FormatGrid();
   ldate=dtFromOrderDate.value;         
   ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
   dtFromOrderDate.value=ldate ; 
 }
 
 //---------------------------------------------------------
 function FormatGrid()
 {
      var trl
      trl=grdContract.GetGridControl();	
      trl.ColFormat(G1_ex_rate )    = "###,###,###,###,###";
      trl.ColFormat(G1_amount)      = "###,###,###,###,###.##";
      trl.ColFormat(G1_vat_amt)     = "###,###,###,###,###.##";
      trl.ColFormat(G1_total_amt)   = "###,###,###,###,###.##";
      trl.ColFormat(G1_retouch_amt) = "###,###,###,###,###.##";
      trl.ColFormat(G1_trans_amt )  = "###,###,###,###,###.##";
      trl.ColFormat(G1_discount)    = "###,###,###,###,###.##";
      trl.ColFormat(G1_disc_amt)    = "###,###,###,###,###.##";
      trl.ColFormat(G1_pay_ex_rate) = "###,###,###,###,###";      
      
      trl=grdContractDetail.GetGridControl();	
      trl.ColFormat(G2_qty )        = "###,###,###,###,###.##";
      trl.ColFormat(G2_qty_packing) = "###,###,###,###,###.##";
      trl.ColFormat(G2_u_price)     = "###,###,###,###,###.##";
      trl.ColFormat(G2_ex_price)    = "###,###,###,###,###.##";
      trl.ColFormat(G2_vat_rate)    = "###,###,###,###,###.##";
      trl.ColFormat(G2_tot_amt)     = "###,###,###,###,###.##";
      trl.ColFormat(G2_retouch_amt) = "###,###,###,###,###.##";
      trl.ColFormat(G2_tr_amt)      = "###,###,###,###,###.##";   
       
      trl=grdOrder.GetGridControl();	
      trl.ColFormat(G3_pay_ex_rate )= "###,###,###,###,###";
      trl.ColFormat(G3_ex_rate)     = "###,###,###,###,###";
 }
 
  //---------------------------------------------------------
 function BindingDataList()
 {    
    var data="";    
    data = "DATA|1|Saved|2|Confirmed|3|Cancelled|ALL|Select ALL";    
    cboStatus.SetDataText(data);
    cboStatus.value = "ALL" ;
    
    grdContract.GetGridControl().FrozenCols = 6
    grdOrder.GetGridControl().FrozenCols = 4
    grdContractDetail.GetGridControl().FrozenCols = 6
  }        
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
        case 1 ://search saleorder
            epac00050.Call("SELECT");
        break;
        case 2: //search master history
        {
            txtContractPK.text = grdSearch.GetGridData(event.row,0)
            epac00050_1.Call("SELECT");
        }
      }  
 }

 //---------------------------------------------------------
 function OnDataReceive(obj)
 {
    if(obj.id=="epac00050_1")
    {       
        epac00050_3.Call("SELECT")
    }
    if(obj.id=="epac00050_3")
    {
        epac00050_2.Call("SELECT");
    }
 }
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="epac00050" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="imex" function="imex.sp_sel_epac00050"   > 
                <input> 
                    <input bind="txtContractNo" /> 
                    <input bind="dtFromOrderDate" /> 
                    <input bind="dtToOrderDate" /> 
                    <input bind="cboStatus" /> 
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="epac00050_1" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="imex" function="imex.sp_sel_epac00050_1"   > 
                <input> 
                    <input bind="txtContractPK" /> 
                </input> 
                <output bind="grdContract" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="epac00050_2" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="imex" function="imex.sp_sel_epac00050_2"   > 
                <input> 
                    <input bind="txtContractPK" /> 
                </input> 
                <output bind="grdContractDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="epac00050_3" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="imex" function="imex.sp_sel_epac00050_3"   > 
                <input> 
                    <input bind="txtContractPK" /> 
                </input> 
                <output bind="grdOrder" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <table width="100%" cellpadding="0" cellspacing="0" border="1" style="height: 100%">
            <tr style="height: 100%">
                <td id='left' style="width: 20%">
                    <table width="100%" border="0" style="height: 100%">
                        <tr>
                            <td width='100%' style="height: 5%">
                                <table width="100%">
                                    <tr>
                                        <td align="right" width="30%" nowrap>
                                            <b>Contract No</b></td>
                                        <td width="69%">
                                            <gw:textbox id="txtContractNo" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                                        </td>
                                        <td width="1%" align='right'>
                                            <gw:imgbtn id="btnOrderNoSearch" img="search" onclick='OnSearch(1)' />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 5%">
                            <td width="100%">
                                <table width="100%">
                                    <tr>
                                        <td align="right" width='20%'>
                                            <b>Date</b>
                                        </td>
                                        <td width='40%'>
                                            <gw:datebox id="dtFromOrderDate" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                                        </td>
                                        <td width='40%'>
                                            <gw:datebox id="dtToOrderDate" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="100%">
                                <table width="100%">
                                    <tr>
                                        <td align="right" width='20%'>
                                            <b>Status</b>
                                        </td>
                                        <td width='80%'>
                                            <gw:list id="cboStatus" styles='width:100%' onchange="OnSearch(1)" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 90%">
                            <td>
                                <gw:grid id="grdSearch" 
                                    header="_PK|Contr Date|Contr No" 
                                    format="0|0|0" 
                                    aligns="0|0|1"
                                    defaults="||" 
                                    editcol="0|0|0" 
                                    widths="0|1500|1200" 
                                    styles="width:100%; height:100%"
                                    sorting="T" 
                                    acceptnulldate="true" 
                                    param="0,1,2,3" 
                                    oncellclick="OnSearch(2)" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td id='right' width="80%">
                    <table width='100%' style="height: 100%">
                        <tr style="height: 30%">
                            <td width='100%'>
                                <table style="height: 100%;width:'100%'" cellpadding="0" cellspacing="0">
                                    <tr style="height: 1%">
                                        <td style="width: 100%;color: Gray">Export Contract Info</td>
                                    </tr>
                                    <tr style="height: 99%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdContract'
                                                header='_pk|Crt Dt|Crt By|History Description|Contr No|Contr Date|Exp Date|Customer Id|Customer Name|Tr. Ccy|Ex Rate|Amount|Vat Amt|Total Amt|Retouch Amt|Trans Amt|Tole|Origin CD|Origin Nm|Shipment Date|Pl Nm|Place Loading|Place Discharge|Trade Terms|Pay Meth|Pay Ccy|Pay Term|Order Y/N|Close Y/N|Close Date|Trans. By|_Ship_Opt|Ship ID|Ship Name|Ship Addr|Nominated Party ID|Nominated Party Name|Nominated Party Addr|_Pay_Opt|Discount|Disc Amt|Paid to ID|Paid to Name|Pay Ex Rate|Trade Loc|Description|Bank Account|Status|Quality|Packing|Ship Remark|Transshipment|Partial Shipment|Shipping Doc|Insurance|Complaint|Force Majeure|Arbitration|Other Clauses|Percent Of Paid|Bank'
                                                format='0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                aligns='0|0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                defaults='||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
                                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                widths='0|1500|1200|2000|1300|1200|1200|1500|1800|1000|1000|1300|1200|1400|1400|1400|1000|1335|1335|1400|1500|1500|1500|1300|1000|1300|1000|1000|1200|1300|1000|1300|1600|1600|1300|2000|2200|2200|1000|1000|1300|1600|1200|1300|2000|1200|1200|1200|1200|1200|1200|1300|1300|1300|1500|1500|1500|1500|1500|1500|1500'
                                                sorting='T'
                                                styles ='width:100%; height:100%'
                                            />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 35%">
                            <td width='100%'>
                                <table  style="height: 100%;width:'100%'" cellpadding="0" cellspacing="0">
                                    <tr style="height: 1%">
                                        <td style="width: 100%;color: Gray">Order Info</td>
                                    </tr>
                                    <tr style="height: 99%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdOrder'
                                                header='Crt Dt|Crt By|Order No|Order Date|Exp Date|Ship Date|Pay Ex Rate|Tr Ccy|Ex Rate|Trade Terms|Pay Meth|Description|Close Y/N|Close Date|_Status'
                                                format='0|0|0|4|4|4|0|0|0|0|0|0|3|4|0'
                                                aligns='0|0|0|0|0|0|0|0|3|0|0|0|0|0|0'
                                                defaults='||||||||||||||'
                                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                widths='1500|1200|1300|1200|1200|1200|1300|1200|1200|1200|1200|2000|1000|1200|0'
                                                sorting='T'
                                                styles='width:100%; height:100%'
                                            />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 35%">
                            <td width='100%'>
                                <table style="height: 100%;width:'100%'" cellpadding="0" cellspacing="0">
                                    <tr style="height: 1%">
                                        <td style="width: 100%;color: Gray">Export Contract Detail Info</td>
                                    </tr>
                                    <tr style="height: 99%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdContractDetail'
                                                header='_Pk|Crt Dt|Crt By|Item Code|Item Name|Hs Code|Unit|Unit Packing|Apportion Y/N|Qty|Qty Packing|U/Price|Ex Price|Vat Rate|Tot Amt|Retouch Amt|Trans. Amt'
                                                format='0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0'
                                                aligns='0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3'
                                                defaults='||||||||||||||||'
                                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                widths='0|1500|1200|1500|1700|1200|1200|1200|1300|1300|1300|1300|1400|1200|1400|1400|1400'
                                                sorting='T'
                                                styles='width:100%; height:100%'
                                            />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
    <!------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------->
    <gw:textbox id="txtContractPK" maxlen="100" styles='width:100%;display:none' />
    <!------------------------------------------->
</body>
</html>
