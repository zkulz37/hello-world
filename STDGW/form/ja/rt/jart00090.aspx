<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Booking Checking</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    dso_grdCashSummaryDaily.Call("SELECT");
}
function OnSearch()
{
    dso_grdCashSummaryDaily.Call("SELECT");
}
function ShowData()
{
    if(grdCashSummaryDaily.rows -1 >0)
    {
        txt1.text=grdCashSummaryDaily.GetGridData(1,0);
        txt2.text=grdCashSummaryDaily.GetGridData(1,1);
        txt3.text=grdCashSummaryDaily.GetGridData(1,2);
        txt4.text=grdCashSummaryDaily.GetGridData(1,3);
        txt5.text=grdCashSummaryDaily.GetGridData(1,4);
        txt6.text=grdCashSummaryDaily.GetGridData(1,5);
        txt7.text=grdCashSummaryDaily.GetGridData(1,6);
        txt8.text=grdCashSummaryDaily.GetGridData(1,7);
        txt9.text=grdCashSummaryDaily.GetGridData(1,8);
        txt10.text=grdCashSummaryDaily.GetGridData(1,9);
        txt11.text=grdCashSummaryDaily.GetGridData(1,10);
        txt12.text=grdCashSummaryDaily.GetGridData(1,11);
        txt13.text=grdCashSummaryDaily.GetGridData(1,12);
        txt14.text=grdCashSummaryDaily.GetGridData(1,13);
        txt15.text=grdCashSummaryDaily.GetGridData(1,14);
        txt16.text=grdCashSummaryDaily.GetGridData(1,15);
        txt17.text=grdCashSummaryDaily.GetGridData(1,16);
        txt18.text=grdCashSummaryDaily.GetGridData(1,17);
        txt19.text=grdCashSummaryDaily.GetGridData(1,18);
        
        txtGreen.text=grdCashSummaryDaily.GetGridData(1,4);
        txtCaddie.text=grdCashSummaryDaily.GetGridData(1,9);
        txtCart.text=grdCashSummaryDaily.GetGridData(1,12);
        txtF_B.text=grdCashSummaryDaily.GetGridData(1,15);
        txtProshop.text=grdCashSummaryDaily.GetGridData(1,18);
             
        var sum_all=0;
        sum_all= (Number(grdCashSummaryDaily.GetGridData(1,4)) + Number(grdCashSummaryDaily.GetGridData(1,9))+ Number(grdCashSummaryDaily.GetGridData(1,12))+Number(grdCashSummaryDaily.GetGridData(1,15))+Number(grdCashSummaryDaily.GetGridData(1,18)));
        txtGrandTotal.SetDataText("" + sum_all);
    }
    else
    {
        alert("No date.")
    }
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00090.rpt&procedure=CRM.sp_sel_jart00090&parameter="+dtInvoice.GetData();   
         	System.OpenTargetPage(url); // background-color: #33CCFF"
}
</script>

<body>
    <!----------------------------------------------------->
    <gw:data id="dso_grdCashSummaryDaily" onreceive="ShowData()"> 
        <xml> 
            <dso  type="grid" function="CRM.sp_sel_jart00090" >  
                <input bind="grdCashSummaryDaily" >  
                    <input bind="dtInvoice" /> 
                </input> 
                <output bind="grdCashSummaryDaily" /> 
            </dso> 
        </xml> 
    </gw:data> 
    <!----------------------------------------------------->
    <table style="height: 100%; width: 100%; border: 0px;" cellspacing="0" cellpadding="0">
        <tr style="height: 2%;">
            <td valign="top">
                <table style="height: 100%; width: 100%;">
                    <tr style="height: 100%;">
                        <td style="width: 10%;">
                            Date</td>
                        <td style="width: 10%; background-color:White" align="left">
                            <gw:datebox id="dtInvoice" maxlen="10" text="" styles='width:100%' lang="1" onchange="OnSearch()" />
                        </td>
                        <td style="width: 2%;">
                        </td>
                        <td style="width: 3%;">
                            <gw:imgbtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch()" />
                        </td>
                         <td style="width: 2%;">
                        </td>
                        <td style="width: 3%;">
                             <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
                        <td style="width: 70%;">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 20%;">
            <td style="width: 100%; background-color:Black">
                <table style="height: 100%; width: 100%;border: 0px;" cellspacing="1" cellpadding="1">
                    <tr style="height: 8%;" valign="top">
                        <td align="center" style="background-color: #87CEFA; width: 20%" colspan="2" valign="middle">
                            Green Fee
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 8%" valign="middle">
                            Facility
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 9%" rowspan="2" valign="middle">
                            VAT(1+2+3)*10%
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 13%" valign="middle">
                            Sub Total
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 37%" colspan="4" valign="middle">
                            Caddie Fee
                        </td>
                        <td align="center" style="background-color: #87CEFA;width: 13%" valign="middle">
                            Sub Total</td>
                    </tr>
                    <tr style="height: 8%;" valign="top">
                        <td align="center" style="background-color: #87CEFA; width: 10%" valign="middle">
                            Supply(A)
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 8%" valign="middle">
                            SCT(1*20%)
                        </td>
                        <td align="center" style="background-color: #87CEFA;" valign="middle">
                            Supply
                        </td>
                        <td align="center" style="background-color: #87CEFA;">
                            (1+2+3+4)
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 20%" valign="middle" colspan="2">
                            Supply
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 12%" rowspan="2" valign="middle">
                            Sub Total
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 9%" rowspan="2" valign="middle">
                            VAT
                        </td>
                        <td style="background-color: #87CEFA; width: 12%" rowspan="2" valign="middle" align="center">
                            (8+9)
                        </td>
                    </tr>
                    <tr style="height: 8%;" valign="top">
                        <td style="background-color: #87CEFA; width: 10%" colspan="5">
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 10%" valign="middle">
                            Company
                        </td>
                        <td align="center" style="background-color: #87CEFA; width: 10%" valign="middle">
                            Caddies
                        </td>
                    </tr>
                    <tr style="height: 8%;" valign="top">
                        <td align="center" style="background-color:#20B2AA;">
                            1
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            2
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            3
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            4
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            5
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            6
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            7
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            8
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            9
                        </td>
                        <td align="center" style="background-color: #20B2AA;" valign="middle">
                            10
                        </td>
                    </tr>
                    <tr style="height: 8%;" valign="top">
                        <td style="background-color: White;">
                            <gw:textbox id="txt1" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt2" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt3" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt4" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td style="background-color: White;">
                            <gw:textbox id="txt5" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt6" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt7" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt8" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td style="background-color: White;">
                            <gw:textbox id="txt9" styles="width:100%;border:0px;" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                        <td align="center" style="background-color: White;">
                            <gw:textbox id="txt10" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                format="###,###,###,###,###" readonly="true" />
                        </td>
                    </tr>
                    <tr style="height: 8%;" valign="top">
                        <td align="center" style="background-color: White;" colspan="10">
                            <div style="padding:10"></div>
                            <gw:textbox id="txtNotUse0" styles="width:100%;border:0px;font-weight:bold;display:none" readonly="T" />
                        </td>
                    </tr>
                    <!------------------------------------------------------------>
                    <tr>
                        <td colspan="10">
                            <table  style="height: 100%; width: 100%;border: 0px;" cellspacing="1" cellpadding="1">
                              <tr style="height: 8%;" valign="top">
                                <td align="center" style="background-color: #87CEFA;" colspan="3">
                                    Cart Fee
                                </td>
                                <td align="center" style="background-color: #87CEFA;" valign="middle" colspan="3">
                                    F_B
                                </td>
                                <td align="center" style="background-color: #87CEFA;" valign="middle" colspan="4">
                                    Proshop
                                </td>
                                </tr>
                                <tr style="height: 8%;" valign="top">
                                    <td style="background-color: #87CEFA;width: 11%;" align="center">
                                        Supply
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;" >
                                        VAT(11*10%)
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;width: 12%;">
                                        Sub Total
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;width: 11%;" >
                                        Supply
                                    </td>
                                    <td style="background-color: #87CEFA;" align="center">
                                        VAT(14*10%)
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;width: 12%;" >
                                        Sub Total
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;width: 11%;" >
                                        Supply
                                    </td>
                                    <td align="center" style="background-color: #87CEFA;" >
                                        VAT(17*10%)
                                    </td>
                                    <td style="background-color: #87CEFA;width: 13%;" colspan="2" align="center">
                                        Sub Total 
                                    </td>
                                </tr>
                                <tr style="height: 8%;" valign="top">
                                    <td align="center" style="background-color: #20B2AA;">
                                        11
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        12
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        13
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        14
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        15
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        16
                                    </td>
                                    <td align="center" style="background-color: #20B2AA;" valign="middle">
                                        17
                                    </td>
                                    <td align="center" style="background-color: 20B2AA;" valign="middle">
                                        18
                                    </td>
                                    <td align="center" style="background-color: 20B2AA;" valign="middle" colspan="2">
                                        19
                                    </td>
                                </tr>
                                <tr style="height: 8%;" valign="top">
                                    <td style="background-color: White;">
                                        <gw:textbox id="txt11" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt12" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt13" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt14" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td style="background-color: White;">
                                        <gw:textbox id="txt15" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt16" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt17" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td align="center" style="background-color: White;">
                                        <gw:textbox id="txt18" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                    <td style="background-color: White;" colspan="2">
                                        <gw:textbox id="txt19" styles="width:100%;border:0px;;font-weight:bold" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        <tr style="height: 8%;" valign="top">
            <td><div style="padding:10"></div></td>
        </tr>
        <tr style="height: 2%;" valign="top">
            <td style="width: 100%;" colspan="10">
                <table style="height: 100%; width: 100%;">
                    <tr>
                        <td align="center" style="background-color: White; width: 70%">
                        </td>
                        <td align="center" style="background-color: White; width: 30%">
                            <table style="height: 100%; width: 100%;" border="1">
                                <tr>
                                    <td style="background-color:White; width: 35%">
                                        Green</td>
                                    <td style="background-color: White; width: 65%">
                                        <gw:textbox id="txtGreen" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color:White;">
                                        Caddie</td>
                                    <td>
                                        <gw:textbox id="txtCaddie" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: White;">
                                        Cart</td>
                                    <td>
                                        <gw:textbox id="txtCart" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: White;">
                                        F&B</td>
                                    <td>
                                        <gw:textbox id="txtF_B" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color:White;">
                                        Proshop</td> 
                                    <td>
                                        <gw:textbox id="txtProshop" styles="width:100%;border:0px;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color:White;padding-left:5px;">
                                        Grand Total</td>
                                    <td>
                                        <gw:textbox id="txtGrandTotal" styles="width:100%;border:0px;font-weight:bold;" type="number"
                                            format="###,###,###,###,###" readonly="true" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 78%;" valign="top"></tr>
    </table>
    <gw:grid id='grdCashSummaryDaily' header='supply_a|sct|facility|green_vat|green_fee|company_caddie_amt|caddie_amt|caddy_sub_total|caddy_vat|caddy_fee
            |cart_supply|cart_vat|cart_subtotal|fnb_supply|fnb_vat|fnb_subtotal|proshop_supply|proshop_vat|proshop_subtotal'
        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        autosize="T" editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        sorting='T' styles='width:100%; height:100%;display:none' />
</body>
</html>
