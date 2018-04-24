<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Line W/I Entry</title>
</head>
<%  
    ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>

<script>
    //-----------------------------------------------------
    var flag;

    var GM_MASTER_PK        = 0,
        GM_DETAIL_PK        = 1,
        GM_SHIFT_PK         = 2,
        GM_SHIFT            = 3,
        GM_WORKING_HOUR     = 4,
        GM_OPERATION_HOURS  = 5,
        GM_EMPLOYEE         = 6;
        
    var G_MASTER_PK = 0,
        G_DETAIL_PK = 1,
        G_ITEM_PK = 2,
        G_ITEM = 3,
        G_COUNT = 4,
        G_NO_OF_OPERATING_LINE = 5,
        G_PRODUCT_QTY = 6,
        G_DAILY_SPINNING_CAPACITY = 7,
        G_DAILY_LINE_CAPACITY = 8,
        G_TOTAL = 9;
    var arr_FormatNumber = new Array();
    //===============================================================================================
    function BodyInit() {
        System.Translate(document);  // Translate to language session    
        data_kbpr00080_2.StatusInsert();
        //txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
        //lblChargerNM.text = "<%=Session("USER_NAME")%>"; 
        //-------------------------------------------         
        grdMaster_01.ClearData();
        flag = "view";
    }
    //==================================================================================
    function BindingDataList() {
    }
    //=============================================================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'Search':
                data_kbpr00080.Call("SELECT");
                break;
            case 'Master':
                flag = 'view';
                txtMasterPK.text = grdSearch.GetGridData(grdSearch.row, 0);
                data_kbpr00080_2.Call("SELECT");
                break;
            case 'Detail':
                txtMasterPK.text = grdSearch.GetGridData(grdSearch.row, 0);
                data_kbpr00080_3.Call("SELECT");
                break;
            case 'Detail_1':
                data_kbpr00080_4.Call("SELECT");
                break;
        }
    }
    function OnPopup() {
        var path = System.RootURL + "/form/kb/pr/kbpr00071.aspx";
        var object = System.OpenModal(path, 800, 600, 'resizable:yes;status:yes', this);
        if (object != null) {
            var arrTemp;
            for (var i = 0; i < object.length; i++) {
                arrTemp = object[i];
                grdDetail.AddRow();
                grdDetail.SetGridText(grdDetail.rows - 1, 2, arrTemp[1]);
                grdDetail.SetGridText(grdDetail.rows - 1, 3, arrTemp[3]);
                grdDetail.SetGridText(grdDetail.rows - 1, 4, arrTemp[4]);
            }
        }
    }
    //=============================================================================================
    function OnAddNew() {
        if (grdMaster_01.rows == 1) {
            data_kbpr00080_3.Call('SELECT');
            return;
        }
        else {
            data_kbpr00080_2.StatusInsert();
            //txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //lblChargerNM.text = "<%=Session("USER_NAME")%>"; 
            //-------------------------------------------         
            grdMaster_01.ClearData();
            grdDetail.ClearData();
            flag = "view";
            data_kbpr00080_1.Call('SELECT');
        }
    }
    //=============================================================================================
    function OnDelete(para) {
        if (para == 1) {
            if (confirm("Do you want to delete this data?")) {
                data_kbpr00080_2.StatusDelete();
                OnSave('Master');
            }
        }
        else if (para == 2) {
            if (grdMaster_01.GetGridData(grdMaster_01.row, 1) == '') {
                grdMaster_01.RemoveRow();
            }
            else {
                grdMaster_01.DeleteRow();
            }
            TotalAmt();
        }
        else if (para == 3) {
            if (grdDetail.GetGridData(grdDetail.row, G_DETAIL_PK) == '') {
                grdDetail.RemoveRow();
            }
            else {
                grdDetail.DeleteRow();
            }
            TotalAmt();
        }
    }
    //=============================================================================================
    function OnUnDelete(para) {
        if (para == 1) {
            grdMaster_01.UnDeleteRow();
        }
        else if (para == 2) {
            grdDetail.UnDeleteRow();
        }
        TotalAmt();
    }
    //=============================================================================================
    function OnSave(pos) {
        switch (pos) {
            case 'Master':
                data_kbpr00080_2.Call();
                flag = 'save';
                break;
            case 'Detail':
                data_kbpr00080_3.Call();
                flag = 'save';
                break;
            case 'Detail_1':
                data_kbpr00080_4.Call();
                break;
        }
    }
    //=============================================================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case 'data_kbpr00080_1':
                break;
            case "data_kbpr00080_2":
                if (flag == 'save') {
                    for (var i = 1; i < grdMaster_01.rows; i++) {
                        if (grdMaster_01.GetRowStatus(i) == 16 && grdMaster_01.GetGridData(i, 0) == '') {
                            grdMaster_01.SetGridText(i, 0, txtMasterPK.text);
                        }
                    }
                    OnSave('Detail');
                }
                else {
                    OnSearch('Detail');
                }
                break;
            case 'data_kbpr00080_3':
                if (flag == 'save') {
                    for (var i = 1; i < grdDetail.rows-1; i++) {
                        if (grdDetail.GetRowStatus(i) == 16 && grdDetail.GetGridData(i, 0) == '') {
                            grdDetail.SetGridText(i, 0, txtMasterPK.text);
                        }
                    }
                    OnSave('Detail_1');
                }
                else {
                    OnSearch('Detail_1');
                }
                break;
            case 'data_kbpr00080_4':
                if (grdDetail.rows > 1) {
                    grdDetail.Subtotal(0, 2, -1, '5!6!8!9');
                    var sum = 0, count = 0, daily_line_capacity = 0;
                    for (var i = 1; i < grdDetail.rows - 1; i++) {
                        if(Number(grdDetail.GetGridData(i, G_NO_OF_OPERATING_LINE)) == 0)
                        {
                            daily_line_capacity+=Number(grdDetail.GetGridData(i, G_DAILY_LINE_CAPACITY).replace(",",""));
                            grdDetail.SetCellBgColor( i, G_ITEM, i, G_TOTAL, 0xD4D4D4); 
                        }
                        if(Number(grdDetail.GetGridData(i, G_DAILY_SPINNING_CAPACITY)) != 0)
                        {
                            count++;
                        }
                        sum += System.Round(grdDetail.GetGridData(i, G_DAILY_SPINNING_CAPACITY), 2);
                    }
                    grdDetail.SetGridText(grdDetail.rows - 1, G_DAILY_SPINNING_CAPACITY, System.Round(sum / count, 2));
                    grdDetail.SetGridText(grdDetail.rows - 1, G_DAILY_LINE_CAPACITY, System.Round(Number(grdDetail.GetGridData(grdDetail.rows - 1, G_DAILY_LINE_CAPACITY).replace(",","")) - daily_line_capacity, 2));
                    txtAverage_Spinning.text = grdDetail.GetGridData(grdDetail.rows - 1, G_DAILY_SPINNING_CAPACITY);
                }
                data_kbpr00080_5.Call('SELECT');
                break;
            case 'data_kbpr00080_5':
                break;
            case 'pro_kbpr00080':
                alert(txtReturnValue.text);
            break;
        }
    }
    //===========================================================
    function OnCalc() {
        try {
            var row = event.row;
            var col = event.col;
            if (col == G_NO_OF_OPERATING_LINE) {
                var qty = grdDetail.GetGridData(row, col);
                if (Number(qty) || qty > 0) {
                    var result = 0, no_of_oper_line = 0, daily_line_capa = 0;
                    no_of_oper_line = System.Round(grdDetail.GetGridData(row, G_NO_OF_OPERATING_LINE), 2);
                    daily_line_capa = System.Round(grdDetail.GetGridData(row, G_DAILY_LINE_CAPACITY), 2);
                    result = (daily_line_capa * no_of_oper_line) / 3;
                    grdDetail.SetGridText(row, G_PRODUCT_QTY, System.Round(result, 2));
                    grdDetail.SetCellBgColor( row, G_ITEM, row, grdDetail.cols - 1, 0xCCFFCC);
                    grdDetail.GetGridControl().Cell( 7, row, G_ITEM, row, grdDetail.cols - 1 ) = 0x3300cc;
                }
                else {
                    grdDetail.SetGridText(row, col, "");
                }
                TotalAmt();
            }
        }
        catch (err) {
            alert(err.Message);
        }
    }
    //===========================================================
    function TotalAmt() {
        try {
            var total_whs = 0, total_oper_hs = 0, total_employee = 0;
            for (var a = 1; a < grdMaster_01.rows; a++) {
                if (grdMaster_01.GetRowStatus(a) != 80 && grdMaster_01.GetRowStatus(a) != 64) {
                    total_whs += Number(grdMaster_01.GetGridData(a, 4));
                    total_oper_hs += Number(grdMaster_01.GetGridData(a, 5));
                    total_employee += Number(grdMaster_01.GetGridData(a, 6));
                }
            }
            txtTotal_Working_Hour.text = total_whs;
            txtTotal_Operation_Hours.text = total_oper_hs;
            txtTotal_Employee.text = total_employee;
            //-------------------------------------------
            var sum_average_spinning = 0;
            for (var i = 1; i < grdDetail.rows; i++) {
                if (grdDetail.GetRowStatus(i) != 80 && grdDetail.GetRowStatus(i) != 64) {
                    sum_average_spinning += Number(grdDetail.GetGridData(i, G_DAILY_SPINNING_CAPACITY).replace("", 0));
                }
            }
            sum_average_spinning = sum_average_spinning / Number(grdDetail.rows - 1);
            txtAverage_Spinning.text = sum_average_spinning.replace("", "0");
        } catch (err) {}
    }
    //===========================================================
    function OnReport()
    {
        var url =System.RootURL + "/reports/kb/pr/rpt_kbpr00080.aspx?p_master_pk="+txtMasterPK.text+"&p_date="+dtPlan.GetData(); 
        System.OpenTargetPage(url);     
    }
    //===========================================================
    function OnCopy()
    {
        if(txtMasterPK.text != "")
        {   
            if(confirm('Do you want to copy this slip?'))
            {
                pro_kbpr00080.Call();
            }
        }
    }
</script>

<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kbpr00080" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kbpr00080"	>	
				<input>
					<input	bind="dtFrom"	/>	
					<input	bind="dtTo"	/>	
                    <input	bind="txtSlipNoSearch"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Get Shift =====================================-->
    <gw:data id="data_kbpr00080_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0"	function="<%=l_user%>lg_sel_kbpr00080_1"	>	
				<input>
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdMaster_01"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kbpr00080_2" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8"	function="<%=l_user%>lg_sel_kbpr00080_2"	procedure="<%=l_user%>LG_UPD_kbpr00080">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
                        <inout	bind="dtPlan"	/>
                        <inout	bind="txtTotal_Working_Hour"	/>
						<inout	bind="txtTotal_Operation_Hours"	/>
                        <inout	bind="txtTotal_Employee"	/>
						<inout	bind="txtAverage_Spinning"	/>
						<inout	bind="txtOperation_Machine"	/>
                        <inout	bind="txtEmployee"	/>
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------------- Detail --------------------------------->
    <gw:data id="data_kbpr00080_3" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6" function="<%=l_user%>lg_sel_kbpr00080_1"   procedure="<%=l_user%>lg_upd_kbpr00080_1"> 
                <input bind="grdMaster_01">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdMaster_01" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------- Detail --------------------------------->
    <gw:data id="data_kbpr00080_4" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="4" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00080_4"   procedure="<%=l_user%>lg_upd_kbpr00080_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Get Detail =====================================-->
    <gw:data id="data_kbpr00080_5" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0"	function="<%=l_user%>lg_sel_kbpr00080_3"	>	
				<input>
					<input	bind="dtPlan"	/>	
				</input>	
				<output	bind="grdMaster_02"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--------------------------Copy Slip-------------------------------------->
    <gw:data id="pro_kbpr00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbpr00080" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>	
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="width: 100%; height: 100%">
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 1%">
                            Date
                        </td>
                        <td style="width: 98%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtTo" lang="1" width="10%" />
                        </td>
                        <td style="height: 1%">
                        </td>
                    </tr>
                    <tr style="height: 1%; white-space: nowrap">
                        <td style="height: 1%; white-space: nowrap">
                            Slip No
                        </td>
                        <td>
                            <gw:textbox id="txtSlipNoSearch" styles='width:100%' onenterkey="OnSearch('Search')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('Search')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_pk|Date|Slip No|_Total Prod Qty|Avg Spinning' format='0|4|0|1|1'
                                aligns='0|0|0|0|0' check='||||' editcol='0|0|0|0|0' widths='0|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="width: 100%; height: 1%">
                        <td colspan="3" style="background-color: #D1FFF4">
                            <table>
                                <tr>
                                    <td style="width: 30%; white-space: nowrap" align="right">
                                        Slip No
                                    </td>
                                    <td style="width: 40%">
                                        <gw:textbox id="txtSlipNo" readonly="T" />
                                    </td>
                                    <td style="width: 1%">
                                        Date
                                    </td>
                                    <td style="width: 26%">
                                        <gw:datebox id="dtPlan" lang="1" width="10%" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="copy" alt="Copy" id="btnCopy" onclick="OnCopy()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete2" onclick="OnDelete('1')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 45%">
                        <td style="width: 50%">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr style="height: 1%">
                                    <td style="width: 1%; white-space: nowrap">
                                    </td>
                                    <td style="width: 25%">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td>
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete3" onclick="OnDelete('2')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete3" onclick="OnUnDelete('1')" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="8">
                                        <gw:grid id='grdMaster_01' header='_master_pk|_detail_pk|_shift_pk|Shift|Working Hour|Operation Hours|Employee'
                                            format='0|0|0|0|1|1|1' aligns='0|0|0|1|0|0|0' check='||||||' editcol='0|0|0|0|1|1|1'
                                            widths='0|0|0|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%'
                                            onafteredit="TotalAmt()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 50%">
                            <table style="width: 100%; height: 100%" border="1">
                                <tr>
                                    <td style="width: 1%" colspan="3">
                                        <gw:grid id='grdMaster_02' header='_pk|Title|Previous|Today|Lastest' format='0|0|1|1|1'
                                            aligns='0|1|0|0|0' check='||||' editcol='0|0|0|0|0' widths='0|1000|1000|1000|1000'
                                            sorting='T' autosize='T' styles='width:100%; height:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="4">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 1%; white-space: nowrap">
                                        Total Working Hour
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtTotal_Working_Hour" readonly="T" styles='width:100%' type="number"
                                            format="###,###,###,###" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        Total Operation Hours
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtTotal_Operation_Hours" readonly="T" styles='width:100%' type="number"
                                            format="###,###,###,###" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        Total Employee
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtTotal_Employee" readonly="T" styles='width:100%' type="number"
                                            format="###,###,###,###" />
                                    </td>
                                    <td>
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 1%; white-space: nowrap">
                                        Average Spinning
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtAverage_Spinning" readonly="T" styles='width:100%' type="number"
                                            format="###,###,###,###.0000R" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        Operation Machine
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtOperation_Machine" readonly="T" styles='width:100%' type="number"
                                            format="###,###,###,###" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        Employee
                                    </td>
                                    <td style="width: 32%">
                                        <gw:textbox id="txtEmployee" readonly="T" styles='width:100%' type="number" format="###,###,###,###" />
                                    </td>
                                    <td>
                                        <!--  <gw:imgbtn img="new" alt="New" id="btnNew2" onclick="data_kbpr00080_5.Call('SELECT')" /> -->
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('3')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete2" onclick="OnUnDelete('2')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 54%">
                        <td colspan="2">
                            <gw:grid id='grdDetail' header='_master_pk|_detail_pk|_item_pk|Item|Count|No of Operating Line|Product Qty|Daily Spinning Capacity|Daily Line Capacity|Total'
                                format='0|0|0|0|1|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||' editcol='0|0|0|0|0|1|0|0|0|0'
                                widths='0|0|0|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%'
                                onafteredit="OnCalc()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!-----------------------------------------------------------------OnPopup('INFO')------------->
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
