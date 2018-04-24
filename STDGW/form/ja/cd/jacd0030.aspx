<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head id="Head1" runat="server">
    <title>Line Result Incoming</title>
</head>

<script>

    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>";
    var  user_name = "<%=Session("USER_NAME")%>"  ;
//-----------------------------------------------------
var flag = '' ;


function BodyInit()
{
	OnSearch();
}
function OnDataReceive(obj)
{
    if(obj.id == 'dso_process')
    {
        alert(txt_alert.text);
        OnSearch();
    }
    if(obj.id == 'dso_Close')
    {
         alert(txt_alert_Close.text);
    }
}
function OnSearch()
{
    
    data_grd1.Call("SELECT");
} 
function OnProcess()
{
    dso_process.Call();
}
function OnShowDetail()
{
    TmpdtMonth.text = grd1.GetGridData(grd1.row, 9);//Work Month column 9
    data_grd2.Call("SELECT");//show grid detail
}  
function OnClose()
{
    dso_Close.Call();
} 
</script>
<body>
    <!---------------------------------------------------------------------------->
    <gw:data id="data_grd1"  onreceive="" > 
    <xml> 
        <dso  type="grid" function="CRM.sp_sel_jacd00030"> 
            <input bind="grd1">                    
                <input bind="dtMonth" /> 
            </input> 
            <output bind="grd1" />
        </dso> 
    </xml> 
</gw:data>
<!---------------------------------------------------------------------------->
    <gw:data id="data_grd2"  onreceive="" > 
    <xml> 
        <dso  type="grid" function="CRM.sp_sel_jacd00030_detail"> 
            <input bind="grd2">                    
                <input bind="TmpdtMonth" /> 
            </input> 
            <output bind="grd2" />
        </dso> 
    </xml> 
</gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_process" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="CRM.sp_prc_jacd00030"> 
                <input> 
                     <input bind="dtMonth"/>
                </input>
                <output>
                     <output bind="txt_alert"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_Close" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="crm.sp_prc_jacd00030_close"> 
                <input> 
                     <input bind="dtMonth"/>
                </input>
                <output>
                     <output bind="txt_alert_Close"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="right" style="width: 100%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b>Invoice No</b>
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtMonth" type="month" lang="<%=session("lang")%>" onchange="OnSearch()"/>
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Process By
                        </td>
                        <td style="width: 7%">
                            <gw:textbox id="txtProcessBy" styles='width:100%' readonly="true" />
                        </td>
                        <td style="width: 17%; white-space: nowrap" align="right">Process Date
                        </td>
                        <td style="width: 26%">
                            <gw:textbox id="txtProcessDate" styles='width:100%' readonly="true" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="btnProcess" alt="Process" text="Process" onclick="OnProcess()" />
                        </td>
						<td style="width: 1%" align="right">
                            <gw:icon id="btnClose" alt="Close" text="Close" onclick="OnClose()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b>Close Date</b>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtCloseDate" styles='width:100%' readonly="true" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Close By
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtCloseBy" styles='width:100%' readonly="true" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 17%; white-space: nowrap" align="right">Ex.Rate
                        </td>
                        <td style="width: 8%" colspan="4"><gw:textbox id="txtEXRate" styles='width:100%' readonly="true" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            <b>Total Caddies</b>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtTotalCaddies" styles='width:100%' readonly="true" />
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="right">
                            Total Amount(USD)
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtTotalUSD" styles='width:100%' readonly="true" />
                        </td>
                        
                        
                        <td style="width: 1%" align="right" colspan="2">Total Amt(VND)
                        </td>
                        <td style="width: 1%" align="right" colspan="4">
                            <gw:textbox id="txtTotAmtVND" styles='width:100%' readonly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>Description</td>
                        <td colspan="9"><gw:textarea id="txtDesc" rows="2" text=""  styles='width:100%;'/></td>
                    </tr>
                    <tr style="height: 43%">
                        <td colspan="11">                                                
                            <gw:grid id='grd1' header='_PK|Caddy#|Caddies Name|Work Days|Work Holes|Incentive Rate|Ex.Rate|Amount(VND)|Amount(USD)|_Work_Month'
                                format='0|0|0|0|0|0|-0|-0|-2|0' aligns='0|0|0|3|3|3|0|0|0|0' defaults='|||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                autosize="T" sorting='T' acceptnulldate="T" styles="width:100%;height:100%" oncellclick="OnShowDetail()" />
                        </td>
                    </tr>
                    <tr style="height: 44%">
                        <td colspan="11">                   
                            <gw:grid id='grd2' header='Date|Tee Time|Player Name|Total Holes|Caddy Fee|Incentive AMT(USD)|Incentive AMT(VND)|Card No|Bag No'
                                format='4|0|0|0|0|-2|-0|0|0' aligns='0|0|0|3|3|0|0|0|0' defaults='||||||||'
                                editcol='0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                autosize="T" sorting='T' acceptnulldate="T" styles="width:100%;height:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------->
    <!--<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />-->
    <!-------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txt_alert" styles='width:100%;display:none' />
    <gw:textbox id="txt_alert_Close" styles='width:100%;display:none' />
    <gw:textbox id="TmpdtMonth" styles='width:100%;display:none' />
    <gw:textbox id="txtRoomSearchPK" styles='width:100%;display:none' />
    <gw:textbox id="txtRoomPK" styles='width:100%;display:none' />
    <gw:textbox id="CONFIRM_YN" styles='width:100%;display:none' />
    <!-------------------------------------------------------------->
</body>
</html>
