<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Processing Fee PopUp</title>
</head>

<script>

    //======================================================
    function BodyInit() {
        System.Translate(document);
        txtPage.text = 1;
        data_dspc00031_header.Call('SELECT');
    }
    //====================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'Search':
                if (OnCheck()) { data_dspc00031_header.Call('SELECT'); }
                break;
        }
    }
    //====================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case 'data_dspc00031_header':
                if (grdHeader.rows > 1) {
                    var col1 = grdHeader.GetGridData(1, 1);
                    var col2 = grdHeader.GetGridData(1, 2);
                    var col3 = grdHeader.GetGridData(1, 3);
                    var col4 = grdHeader.GetGridData(1, 4);
                    var col5 = grdHeader.GetGridData(1, 5);
                    var col6 = grdHeader.GetGridData(1, 6);
                    var col7 = grdHeader.GetGridData(1, 7);
                    var col8 = grdHeader.GetGridData(1, 8);
                    var col9 = grdHeader.GetGridData(1, 9);
                    var col10 = grdHeader.GetGridData(1, 10);
                    var col11 = grdHeader.GetGridData(1, 11);
                    var col12 = grdHeader.GetGridData(1, 12);
                    var col13 = grdHeader.GetGridData(1, 13);
                    var col14 = grdHeader.GetGridData(1, 14);
                    var col15 = grdHeader.GetGridData(1, 15);
                    //-------------------------------------
                    grdDetail.SetGridText(0, 3, col1);
                    grdDetail.SetGridText(0, 4, col2);
                    grdDetail.SetGridText(0, 5, col3);
                    grdDetail.SetGridText(0, 6, col4);
                    grdDetail.SetGridText(0, 7, col5);
                    grdDetail.SetGridText(0, 8, col6);
                    grdDetail.SetGridText(0, 9, col7);
                    grdDetail.SetGridText(0, 10, col8);
                    grdDetail.SetGridText(0, 11, col9);
                    grdDetail.SetGridText(0, 12, col10);
                    grdDetail.SetGridText(0, 13, col11);
                    grdDetail.SetGridText(0, 14, col12);
                    grdDetail.SetGridText(0, 15, col13);
                    grdDetail.SetGridText(0, 16, col14);
                    grdDetail.SetGridText(0, 17, col15);
                    //----
                    data_dspc00031.Call('SELECT');
                }
                break;
        }
    }
    //=====================================================
    function OnCheck() {
        if (txtPage.text <= 0) {
            txtPage.text = 1
            return false;
        }
        else
            return true;
    }
    //=====================================================
    function OnCal(pos) {
        switch (pos) {
            case '1':
                txtPage.text = Number(txtPage.text) - 1;
                OnSearch('Search');
                break;
            case '2':
                txtPage.text = Number(txtPage.text) + 1;
                OnSearch('Search');
                break;
        }
    }

    function OnReport() {
        var url = System.RootURL + "/reports/ds/pc/rpt_dspc00031.aspx?p_page=" + txtPage.text + "&p_style=" + txtStyle.text;
        System.OpenTargetPage(url);
    }
    
    
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_dspc00031_header" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dspc00031_1"> 
                <input> 
                    <input bind="txtPage" />
                </input> 
                <output bind="grdHeader" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_dspc00031" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dspc00031"> 
                <input> 
                    <input bind="txtPage" />
                    <input bind="txtStyle" />
                </input> 
                <output bind="grdDetail" /> 
            </dso>            
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 1%">
            <td style="width: 1%">
                Style
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtStyle" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('Search')" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('Search')" />
            </td>
            <td style="width: 100%" align="left">
                <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
            </td>
            <td style="width: 1%" align="right">
                <img status="expand" id="imgArrow1" src="../../../system/images/button/previous.gif"
                    style="cursor: hand; position: center" onclick="OnCal('1')" />
            </td>
            <td style="width: 10%">
                <gw:textbox id="txtPage" csstype="mandatory" type="number" format="###,###,###" styles="width:100%"
                    onenterkey="OnSearch('Search')" />
            </td>
            <td style="width: 1%">
                <img status="expand" id="imgArrow2" src="../../../system/images/button/next.gif"
                    style="cursor: hand; position: center" onclick="OnCal('2')" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="7">
                <gw:grid id='grdDetail' header='_style_pk|Item Code|Item Name|SPEC_01|SPEC_02|SPEC_03|SPEC_04|SPEC_05|SPEC_06|SPEC_07|SPEC_08|SPEC_09|SPEC_10|SPEC_11|SPEC_12|SPEC_13|SPEC_14|SPEC_15'
                    format='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|1500|2000|800|800|800|800|800|800|800|800|800|800|800|800|800|800|800'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <gw:grid id='grdHeader' header='COL0|COL1|COL2|COL3|COL4|COL5|COL6|COL7|COL8|COL9|COL10|COL11|COL12|COL13|COL14|COL15'
        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        check='|||||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
        sorting='T' styles='width:100%; height:50%;display:none' />
    <!------------------------------------------->
</body>
</html>
