<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Room Income Report</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
  OnSearch();
}
function OnSearch()
{
    datIncomDailyReport.Call("SELECT");
}
</script>

<body>
    <!----------------------------------------------------------------------------------------------->
    <gw:data id="datIncomDailyReport" onreceive=""> 
    <xml> 
        <dso  type="grid" function="CRM.sp_sel_htfo00100"> 
            <input bind="grdMinibarReport">                    
                <input bind="dtFromDate" /> 
                <input bind="txtRoomNo" /> 
            </input> 
            <output bind="grdMinibarReport" />
        </dso> 
    </xml> 
</gw:data>
    <!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td style="width: 5%">
                                                        Date
                                                    </td>
                                                    <td style="width: 10%; white-space: nowrap">
                                                        <gw:datebox id="dtFromDate" lang="1" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="12%" align="right">
                                                        Room No</td>
                                                    <td width="10%">
                                                        <gw:textbox id="txtRoomNo" styles="width:100%" onenterkey="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                         <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnClick()"
                                                            styles='width:100%' />
                                                    </td>
                                                    <td width="57%"></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            <gw:grid id="grdMinibarReport" header="Guest|Room#|Room Charge|F&B Amt|Laundry Amt|Telephone|SPA Amt"
                                format="0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0"
                                defaults="||||||" editcol="0|0|0|0|0|0|0"
                                widths="1000|1000|1000|1000|1000|1000|1000"
                                styles="width:100%; height:100%" sorting="T" autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display: none" />
</body>
</html>
