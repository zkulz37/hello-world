<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Starter</title>
</head>

<script>
function BodyInit()
{
	dso_IncentiveSetUp.Call("SELECT");
}
function OnNew()
{
    grdIncentiveSetUp.AddRow();
}
function OnDelete()
{
    grdIncentiveSetUp.DeleteRow();
}
function OnSave()
{
    dso_IncentiveSetUp.Call();
}
function OnSearch()
{
    dso_IncentiveSetUp.Call("SELECT");
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dso_IncentiveSetUp" onreceive=""> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5" function="crm.sp_sel_jacd0040" procedure="crm.sp_upd_jacd0040">  
                <input>  
                </input>
                <output bind="grdIncentiveSetUp" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <!--<td style="width: 5%">
                            Date</td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
                        <td style="width: 63%"></td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>-->
                        <td style="width: 85%"></td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnAddNewCop" img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnDeleteCop" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSaveCop" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdIncentiveSetUp' header='_PK|Valid From|Valid To|Incentive Rate|Incentive Amount|Use YN'
                                format='0|4|4|-0|-0|3' aligns='0|0|0|3|3|0' defaults='|||||'
                                editcol='1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' autosize='T' check="|||0-|0-|" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
