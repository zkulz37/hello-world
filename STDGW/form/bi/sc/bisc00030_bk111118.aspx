<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Monitoring Display</title>
</head>


<script type="text/javascript">
	//============================================================================
    function BodyInit() 
	{
	    System.Translate(document); 
        var ldate;

        ldate = dtFrom.value;
        ldate = ldate.substr(0, 4) + ldate.substr(4, 2) + '01';
        dtFrom.value = ldate;
        //-------------------
        var data;
        data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE b.GROUP_ID='LGIN0210' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " )%>" ; 
        lstWHType.SetDataText(data);
		
        var data;
        data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.wh_id || ' * ' || a.wh_name FROM tlg_in_warehouse a where a.del_if = 0 ORDER BY a.wh_id " )%>" ; 
        lstWareHouse.SetDataText(data);		
    }
    //============================================================================
    function OnPopUp(pos) 
	{
        switch (pos) 
		{
            case 'PLDAILYREPORT':
                var url = System.RootURL + '/reports/bi/sc/rpt_bisc00030.aspx?p_from_date=' + dtFrom.value + '&p_to_date=' + dtTo.value + '&p_wh_type=' + lstWHType.value;
                window.open(url);
            break;

            case 'DAILYCOMMODITY':
                var url = System.RootURL + '/reports/bi/sc/rpt_bisc00030_01.aspx?p_from_date=' + dtFrom.value + '&p_to_date=' + dtTo.value;
                window.open(url);
            break;
			
			case '10':
                var url = System.RootURL + '/reports/bi/sc/rpt_bisc00031.aspx?p_from_date=' + dtFrom.value + '&p_wh_pk=' + lstWareHouse.value + '&p_wh_name=' + lstWareHouse.GetText();
                window.open(url);
            break;
        }
    }
    //============================================================================
</script>

<body>
    <!------------------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 20%">
        </tr>
        <tr style="height: 60%">
            <td style="width: 40%">
            </td>
            <td style="width: 20%">
                <table style="width: 100%; height: 100%; border: 3px solid #034D72" border="1">
                    <tr style="height:1%">
                        <td style="width: 40%; white-space: nowrap" align="center" colspan="2">
                            <table>
                                <tr>
                                    <td align="right">
                                        Date
                                    </td>
                                    <td>
                                        <gw:datebox id="dtFrom" lang="1" />
                                        &nbsp;&nbsp;&nbsp;
                                        <gw:datebox id="dtTo" lang="1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        W/H Type
                                    </td>
                                    <td>
                                        <gw:list id="lstWHType" styles="width:100%;" />
                                    </td>
                                </tr>
								<tr>
                                    <td>
                                        W/H
                                    </td>
                                    <td>
                                        <gw:list id="lstWareHouse" styles="width:100%;" />
                                    </td>
                                </tr>
								
                            </table>
                        </td>
                    </tr>
					<tr>
                        <td style="border: 1px solid #034D72; width: 40%; white-space: nowrap; background-color: #B4E7FF"
                            colspan="2">
                            <b style="color: #1b2ff2; cursor: hand; font-size: large;" onclick="OnPopUp('10')">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* SUM
                                DAILY CLOSING &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                        </td>
                    </tr>					
                    <tr>
                        <td style="border: 1px solid #034D72; width: 40%; white-space: nowrap; background-color: #B4E7FF"
                            colspan="2">
                            <b style="color: #1b2ff2; cursor: hand; font-size: large;" onclick="OnPopUp('PLDAILYREPORT')">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* P/L DAILY
                                REPORT &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid #034D72; background-color: #B4E7FF" colspan="2">
                            <b style="color: #1b2ff2; cursor: hand; font-size: large; white-space: nowrap" onclick="OnPopUp('DAILYCOMMODITY')">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* INCOME
                                MONTHLY AMOUNT &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 40%">
            </td>
        </tr>
        <tr style="height: 20%">
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------------>
</html>
