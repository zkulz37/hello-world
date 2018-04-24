<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Correct Bill</title>
</head>
<%  ESysLib.SetUser("esys")%>
<script>
function BodyInit()
{
    var data="";
   
}
function OnSearch()
{
	data_search.Call("SELECT")
}
</script>
<body>
<!------------------------------------------------------->
<gw:data id="data_search" onreceive=""> 
        <xml> 
            <dso id="2" type="grid" function="esys.sp_sel_sdeab0010" >
                <input>
					<input bind="txtMenuIDName" />
                    <input bind="txtKeyWord_ENG" />
                    <input bind="txtKeyWord_VIE" />
                    <input bind="txtKeyWord_KOR" />
                </input>
                <output bind="grdInvoice" />
            </dso>
        </xml>
    </gw:data>
 <!------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 100%;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                        <td >
                        <fieldset>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
									<td style="width: 5%;">
                                        Menu[ID/Name]:
                                    </td>
                                    <td style="width: 10%;">
                                        <gw:textbox id="txtMenuIDName" onenterkey="OnSearch()" />
                                    </td>
                                    <td style="width: 15%;">
                                        Keyword[ENG]
                                    </td>
                                    <td style="width: 15%;">
                                        <gw:textbox id="txtKeyWord_ENG" onenterkey="OnSearch()" />
                                    </td>
                                    <td style="width: 10%;">
                                        [VIE]
                                    </td>
                                    <td style="width: 15%;">
                                        <gw:textbox id="txtKeyWord_VIE" onenterkey="OnSearch()" />
                                    </td>
                                    <td style="width: 10%;" align="right">
                                        [KOR]
                                    </td>
                                    <td style="width: 15%;">
                                        <gw:textbox id="txtKeyWord_KOR" onenterkey="OnSearch()" />
                                    </td>
                                    <td style="width: 2%;">
                                    </td>
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="idSearch" alt="search" img="search" onclick="OnSearch()" />
                                    </td>
                                  
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="grdInvoice" header="_PK|_TGM_VISITORFEE_GOLFER_PK|Date|Invoice#|Locker#|Bagtag#|Golfer Name#|Group#|Amount|Discount(%)|Amount|Location|Remark"
                                            format="0|0|4|0|-0|-0|0|-0|-0|0|-0|0|0" aligns="0|0|0|0|3|3|0|3|3|3|3|0|0" editcol="0|0|0|0|0|0|0|0|0|1|0|0|1"
                                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' 
                                            styles="width:100%; height:100%" onafteredit="OnDiscount(this)" oncellclick="OnShowInvoiceD()" oncelldblclick="OnpopupName()"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr> 
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txtInvoiceM_PK" styles="width:100%; display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
