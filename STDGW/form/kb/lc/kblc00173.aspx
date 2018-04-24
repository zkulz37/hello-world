<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>POP UP GET ITEM FROM SALE ORDER</title>
</head>
<script>
    var arr_data = new Array();
    //grdLC
    var G1_LC_OPEN_PK = 0,
	    G1_NEGO_PK = 1,
	    G1_SLIP_NO = 2,
	    G1_LC_OPEN_DT = 3,
	    G1_LC_NO = 4,
        G1_PARTNER_PK = 5,
	    G1_PARTNER_NAME = 6,
	    G1_LC_QTY = 7,
	    G1_LC_AMT = 8,
	    G1_NEGO_AMT = 9,
	    G1_LC_BAL = 10,
	    G1_NEGO_BANK = 11,
        G1_CCY = 12,
        G1_COMPANY_NM = 13,
        G1_DESCRIPTION = 14;
    //grdINVC
    var G2_CHK = 0,
        G2_PK = 1,
	    G2_INVOICE_DATE = 2,
	    G2_INVOICE_NO = 3,
	    G2_INVOICE_AMT = 4,
	    G2_LC_MAPPING_AMT = 5,
	    G2_LC_AMT_BL = 6;
    //grdDELI
    var G3_DELI_NO = 0,
	    G3_REF_NO = 1,
	    G3_OUT_DATE = 2,
        G3_AMOUNT = 3;
    //grdDetail
    var G4_SLIP_NO = 0,
	    G4_LC_DATE = 1,
	    G4_LC_NO = 2,
        G4_PARTNER_PK = 3,
	    G4_PARTNER_NAME = 4,
	    G4_LC_QTY = 5,
	    G4_LC_AMT = 6,
	    G4_NEGO_AMT = 7,
	    G4_LC_BAL = 8,
	    G4_AR_INVC_DT = 9,
	    G4_AR_INVC_NO = 10,
	    G4_AR_INVC_AMT = 11,
	    G4_AR_LC_MAPPING_AMT = 12,
	    G4_AR_LC_AMT_BAL = 13,
	    G4_DELI_NO = 14,
	    G4_REF_NO = 15,
	    G4_DELI_DATE = 16,
	    G4_DELI_AMT = 17;

    var arr_FormatNumber = new Array();
    //==============================================================================================

    function BodyInit() {
        System.Translate(document);
        var callerWindowObj = dialogArguments;

        txtCustPK.text = callerWindowObj.txtBuyerPK.text;
        lblCustomer.text = callerWindowObj.txtBuyerNM.text;

        dtFrom.SetDataText(System.AddDate(dtTo.GetData(), -30));

        OnFormatGrid();
    }

    //==============================================================================================

    function OnFormatGrid() {
        var data = "";
        /*var trl;
        trl = grdDetail.GetGridControl();	
        trl.ColFormat(G1_ORD_QTY)    = "###,###,###,###,###.##"; 
        trl.ColFormat(G1_DELI_QTY)   = "###,###,###,###,###.##";   
        trl.ColFormat(G1_DELI_BAL)   = "###,###,###,###,###.##";    		 

        trl = grdStock.GetGridControl();	
        trl.ColFormat(G2_STOCK_QTY)    = "###,###,###,###,###.##"; 
	 	
        trl = grdItem.GetGridControl();	
        trl.ColFormat(G3_DELI_BAL)    = "###,###,###,###,###.##"; 
        trl.ColFormat(G3_STOCK_QTY)   = "###,###,###,###,###.##";   
  		
        arr_FormatNumber[G3_STOCK_QTY] = 2;  
		
        grdDetail.GetGridControl().MergeCells  = 2 ;	
        grdDetail.GetGridControl().MergeCol(0) = true;  
		
        grdDetail.GetGridControl().Cell( 7, 0, G1_DELI_BAL, 0, G1_DELI_BAL ) = 0x3300cc;		
        grdItem.GetGridControl().Cell( 7, 0, G3_STOCK_QTY, 0, G3_STOCK_QTY ) = 0x3300cc;	*/

    }

    //==============================================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'LC':
                data_kblc00173.Call("SELECT");
                break;
            case 'INVC':
                data_kblc00173_1.Call("SELECT");
                break;
            case 'DELI':
                data_kblc00173_2.Call("SELECT");
                break;
        }

    }
    //==============================================================================================
    function OnDataReceive(po_oData) {
        switch (po_oData.id) {
            case "data_kblc00173":

                break;
            case 'data_kblc00173_2':
                if (grdINVC.GetGridData(grdINVC.row, G2_CHK) == -1) {
                    var s_deli = "";
                    for (var i = 1; i < grdDELI.rows; i++) {
                        var arrTemp = new Array();

                        arrTemp[0] = grdINVC.GetGridData(grdINVC.row, G2_INVOICE_NO);
                        arrTemp[1] = s_deli + grdDELI.GetGridData(i, G3_DELI_NO);
                        arr_data[arr_data.length] = arrTemp;
                        s_deli = ",";
                    }
                }
                break;
        }
    }
    //================================================================================================
    function OnAdd() {
        try {
            if (grdLC.row > 0) {
                var count = 0;
                for (var i = 1; i < grdINVC.rows; i++) {
                    if (grdINVC.GetGridData(i, G2_CHK) == -1) {
                        for (var a = 0; a < grdDetail.rows; a++) {
                            if (grdINVC.GetGridData(i, G2_INVOICE_NO) == grdDetail.GetGridData(a, G4_AR_INVC_NO)) {
                                count = 1; break;
                            }
                            else {
                                count = 0;
                            }
                        }
                        if (count == 0) {
                            grdDetail.AddRow();

                            grdDetail.SetGridText(grdDetail.rows - 1, G4_SLIP_NO, grdLC.GetGridData(grdLC.row, G1_SLIP_NO));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_LC_DATE, grdLC.GetGridData(grdLC.row, G1_LC_OPEN_DT));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_LC_NO, grdLC.GetGridData(grdLC.row, G1_LC_NO));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_PARTNER_PK, grdLC.GetGridData(grdLC.row, G1_PARTNER_PK));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_PARTNER_NAME, grdLC.GetGridData(grdLC.row, G1_PARTNER_NAME));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_LC_QTY, grdLC.GetGridData(grdLC.row, G1_LC_QTY));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_LC_AMT, grdLC.GetGridData(grdLC.row, G1_LC_AMT));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_NEGO_AMT, grdLC.GetGridData(grdLC.row, G1_NEGO_AMT));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_LC_BAL, grdLC.GetGridData(grdLC.row, G1_LC_BAL));

                            grdDetail.SetGridText(grdDetail.rows - 1, G4_AR_INVC_DT, grdINVC.GetGridData(i, G2_INVOICE_DATE));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_AR_INVC_NO, grdINVC.GetGridData(i, G2_INVOICE_NO));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_AR_INVC_AMT, grdINVC.GetGridData(i, G2_INVOICE_AMT));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_AR_LC_MAPPING_AMT, grdINVC.GetGridData(i, G2_LC_MAPPING_AMT));
                            grdDetail.SetGridText(grdDetail.rows - 1, G4_AR_LC_AMT_BAL, grdINVC.GetGridData(i, G2_LC_AMT_BL));

                            for (var j = 0; j < arr_data.length; j++) {
                                var arrTemp = arr_data[j];
                                if (arrTemp[0] == grdINVC.GetGridData(i, G2_INVOICE_NO)) {
                                    grdDetail.SetGridText(grdDetail.rows - 1, G4_DELI_NO, arrTemp[1]);
                                }
                            }
                        }
                    }
                }
            }
            else {
                alert("PLS SELECT ONE P/O");
            }
            countItem();
        }
        catch (err) {
            alert(err.Message);
        }
    }

    //==============================================================================================
    function OnRemove() {
        if (grdDetail.row > 0) {
            grdDetail.RemoveRowAt(grdDetail.row);
            countItem();
        }
    }
    //==============================================================================================

    function countItem() {
        lblCount.text = grdDetail.rows - 1 + " item(s)."
    }


    //==============================================================================================
    function OnCheckInput() {
        var col, row

        col = event.col
        row = event.row

        if (col == G3_STOCK_QTY) {
            var dQuantiy;

            dQuantiy = grdItem.GetGridData(row, col);

            if (Number(dQuantiy)) {
                if (dQuantiy > 0) {
                    grdItem.SetGridText(row, col, System.Round(dQuantiy, arr_FormatNumber[col]));
                }
                else {
                    alert(" Value must greater than zero !!");
                    grdItem.SetGridText(row, col, "");
                }
            }
            else {
                grdItem.SetGridText(row, col, "");
            }
        }
    }

    //==============================================================================================
    function OnSelect(oGrid) {
        var arr_data = new Array();

        if (oGrid.rows > 1) {
            for (var i = 1; i < grdDetail.rows; i++) {
                var arrTemp = new Array();

                for (var j = 0; j < grdDetail.cols; j++) {
                    arrTemp[arrTemp.length] = grdDetail.GetGridData(i, j);
                }

                arr_data[arr_data.length] = arrTemp;
            }

            if (arr_data != null) {
                window.returnValue = arr_data;
                window.close();
            }
            else {
                alert("You have not selected data yet.");
            }
        }

    }
    //====================================================================
    function OnGridCellClick(obj) {
        switch (obj.id) {
            case 'grdINVC':
                txtPK.text = grdINVC.GetGridData(grdINVC.row, G2_PK);
                data_kblc00173_2.Call('SELECT');
                break;
        }
    }

    //====================================================================
    function CheckInput() {
        try {
            var row = event.row;
            var col = event.col;
            if (col == G2_LC_MAPPING_AMT) {
                var qty = grdINVC.GetGridData(row, col);
                if (Number(qty)) {
                    if (qty < Number(grdINVC.GetGridData(row, G2_INVOICE_AMT)) && qty > 0) {
                        grdINVC.SetGridText(row, col, qty);
                        grdINVC.SetGridText(row, G2_LC_AMT_BL, Number(grdINVC.GetGridData(row, G2_INVOICE_AMT)) - qty);
                    }
                    else {
                        alert(" Value must greater than zero and less than invoice amount !!!");
                        grdINVC.SetGridText(row, col, "");
                        grdINVC.SetGridText(row, G2_LC_AMT_BL, "");
                    }
                }
                else {
                    grdINVC.SetGridText(row, col, "");
                    grdINVC.SetGridText(row, G2_LC_AMT_BL, "");
                }
            }
        }
        catch (err) {
            alert(err.Message);
        }
    }
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_kblc00173" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4" function="<%=l_user%>LG_SEL_KBLC00173" > 
                <input>
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" />  
                    <input bind="txtSearch" />  
                    <input bind="chkBal" />  
                    <input bind="txtCustPK" />                
                </input> 
                <output bind="grdLC" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kblc00173_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2" function="<%=l_user%>LG_SEL_KBLC00173_1" > 
                <input>
                    <input bind="dtFromInv" /> 
                    <input bind="dtToInv" />  
                    <input bind="txtSearchInv" />               
                </input> 
                <output bind="grdINVC" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kblc00173_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0" function="<%=l_user%>LG_SEL_KBLC00173_2" > 
                <input>
                    <input bind="txtPK" />               
                </input> 
                <output bind="grdDELI" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 60%">
            <td align="right" style="width: 50%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 1%">
                            Date
                        </td>
                        <td style="width: 20%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                        </td>
                        <td style="width: 25%" colspan="3">
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center" colspan="3">
                        </td>
                        <td align="right" style="width: 1%">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 1%">
                            Search
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSearch" styles='width:100%' onenterkey="OnSearch('LC')" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                        </td>
                        <td style="width: 25%" colspan="3">
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center" colspan="3">
                            <gw:checkbox id="chkBal" styles="color:red" defaultvalue="Y|N" value="Y" onchange="OnSearch('LC')">Balance</gw:checkbox>
                        </td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch_1" onclick="OnSearch('LC')" />
                        </td>
                    </tr>
                    <tr style="height: 48%">
                        <td colspan="10">
                            <gw:grid id='grdLC' header='_lc_open_pk|_nego_pk|Slip No|LC Open|LC No|_partner_pk|Partner Name|LC Qty|LC Amt|Nego Amt|LC Bal|Nego Bank|CCY|Company|Description'
                                format='0|0|0|4|0|0|0|1|1|1|1|0|0|0|0' aligns='0|0|0|1|0|0|0|0|0|0|0|0|1|1|0'
                                check='||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right" style="width: 50%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Customer
                        </td>
                        <td style="width: 40%" colspan="4">
                            <gw:label id="lblCustomer" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('INVC')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
                        <td style="width: 40%">
                            <gw:datebox id="dtFromInv" lang="1" />
                            ~<gw:datebox id="dtToInv" lang="1" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Search
                        </td>
                        <td style="width: 40%" colspan="3">
                            <gw:textbox id="txtSearchInv" styles="width:100%" onenterkey="OnSearch('INVC')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="9">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td>
                                        <gw:grid id='grdINVC' header='Chk|_pk|Invoice Date|Invoice No|Invoice Amt|LC Mapping Amt|LC Amt Balance'
                                            format='3|0|4|0|1|1|1' aligns='0|0|1|0|0|0|0' check='|||||||' editcol='1|0|0|0|0|1|1'
                                            widths='1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%'
                                            oncellclick='OnGridCellClick(this)' onafteredit="CheckInput()" />
                                    </td>
                                    <td>
                                        <gw:grid id='grdDELI' header='Deli No|Ref No|Out Date|Amount' format='0|0|4|1' aligns='0|0|1|0'
                                            check='|||' editcol='0|0|0|0' widths='1000|1000|1000|1000' sorting='T' autosize='T'
                                            styles='width:100%; height:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 40%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 50%" align="center">
                            <gw:label id="lblRecord2" styles="color: blue; white-space:nowrap"></gw:label>
                        </td>
                        <td style="width: 46%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(grdDetail)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdDetail)" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdDetail' header='Slip No|LC Date|LC No|Partner_PK|Partner Name|LC Qty|LC Amt|Nego Amt|LC Bal|AR Invc Date|AR Invc No|AR Invc Amt|AR_LC Mapping Amt|AR_LC Amt Bal|Deli No|Ref No|Deli Date|Deli Amt'
                                format='0|4|0|0|0|1|1|1|1|4|0|1|1|1|0|0|4|1' aligns='0|1|0|0|0|0|0|0|0|1|0|0|0|0|0|0|1|0'
                                check='|||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------------->
    <gw:textbox id="txtArrayPONo" styles="width: 100%;display: none" />
    <gw:textbox id="txtPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtCustPK" styles="width: 100%;display: none" />
    <!----------------------------------------------------------------->
</body>
</html>
