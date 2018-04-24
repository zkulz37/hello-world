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

    var G_PK = 0,
        G_MASTER_PK = 1,
        G_NULL = 2,
        G_ITEM_GROUP_PK = 3,
        G_TLG_IT_ITEM_PK = 4,
        G_ITEM_NAME = 5,
        G_COUNT = 6,
        G_CAPACITY = 7,
        G_LAST_MONTH = 8,
        G_THIS_MONTH = 9,
        G_DAILY_PLAN = 10,
        G_MONTHLY_PLAN = 11,
        G_DAILY_EXPECT = 12,
        G_MONTHLY_EXPECT = 13,
        G_AVG_YARN_COUNT = 14;

    var arr_FormatNumber = new Array();
    //===============================================================================================
    function BodyInit() {
        System.Translate(document);  // Translate to language session    
        OnAddNew();
    }
    //==================================================================================
    function BindingDataList() {

    }
    //=============================================================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'Search':
                data_kbpr00070.Call("SELECT");
            break;  
            case 'Master':
                txtMasterPK.text  = grdSearch.GetGridData(grdSearch.row, 0);
                data_kbpr00070_1.Call("SELECT");
            break; 
            case 'Detail':            
                data_kbpr00070_2.Call("SELECT");
            break; 
        }
    }

    function OnPopup()
    {
        var path = System.RootURL + "/form/kb/pr/kbpr00071.aspx";
        var object = System.OpenModal(path, 800, 600, 'resizable:yes;status:yes', this);

        if (object != null) {
            var arrTemp;
            for (var i = 0; i < object.length; i++) {
                arrTemp = object[i];

                grdMaster.AddRow();
                grdMaster.SetGridText(grdMaster.rows - 1, G_TLG_IT_ITEM_PK, arrTemp[1]);
                grdMaster.SetGridText(grdMaster.rows - 1, G_ITEM_NAME, arrTemp[3]);
                grdMaster.SetGridText(grdMaster.rows - 1, G_COUNT, arrTemp[4]);
                grdMaster.SetGridText(grdMaster.rows - 1, G_CAPACITY, arrTemp[5]);
            }
        }
    }
    //=============================================================================================
    function OnAddNew() {
        data_kbpr00070_1.StatusInsert();
        txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
        lblChargerNM.text = "<%=Session("USER_NAME")%>"; 
        //-------------------------------------------         
        grdMaster.ClearData();
        flag = "view";   
    }
    //=============================================================================================
    function OnDelete() {
        if(grdMaster.rows == 1)
        {
            flag='delete';
            data_kbpr00070_1.StatusDelete();
            data_kbpr00070_1.Call();
        }
        //--------------------------------------
        if (grdMaster.GetGridData(grdMaster.row, G_PK) == '') {
            grdMaster.RemoveRow();
        }
        else {
            grdMaster.DeleteRow();
        }
    }
    //=============================================================================================
    function OnUnDelete() {
        grdMaster.UnDeleteRow();
    }
    //=============================================================================================
    function OnSave(pos) {
        switch(pos)
        { 
            case 'Master':
                    data_kbpr00070_1.Call();
                    flag='save';
            break;
            case 'Detail':        
                data_kbpr00070_2.Call();
            break;
        }
    }
    //=============================================================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case "data_kbpr00070_1":
                    if ( flag == 'save')
                    {
                        for(var i=1; i < grdMaster.rows;i++)
                        {
                            if ( grdMaster.GetGridData( i, G_MASTER_PK) == '' )
                            {
                                grdMaster.SetGridText( i,G_MASTER_PK, txtMasterPK.text);
                            } 
                        }
                        OnSave('Detail');                
                    }
                    else
                    {
                        OnSearch('Detail');   
                    }
                break;
                case 'data_kbpr00070_2':
                    grdMaster.SetCellBgColor( 1, G_THIS_MONTH, grdMaster.rows - 1, G_THIS_MONTH, 0xD6FFE9);
                    grdMaster.SetCellBgColor(1, G_MONTHLY_EXPECT, grdMaster.rows - 1, G_MONTHLY_EXPECT, 0xBFECFF);
                    grdMaster.SetCellBold( 1, G_LAST_MONTH,     grdMaster.rows - 1, G_THIS_MONTH,     true);  
                    grdMaster.SetCellFontColor(1, G_THIS_MONTH, grdMaster.rows - 1, G_THIS_MONTH, 0x0000FF);

                	grdMaster.Subtotal( 0, 2, -1, '8!9!10!11!12!13!14');

                    var count = 0, daily_expert = 0, total = 0, sum = 0;
                    for (var i = 1; i < grdMaster.rows-1; i++) {
                        count = System.Round(grdMaster.GetGridData( i, G_COUNT), 2);
                        daily_expert = System.Round(grdMaster.GetGridData( i, G_DAILY_EXPECT), 2);
                        total = Number(count) * Number(daily_expert);
                        sum += total;
                    }
                    grdMaster.SetGridText(grdMaster.rows-1 ,G_AVG_YARN_COUNT, System.Round(Number(sum)/Number(grdMaster.GetGridData(grdMaster.rows-1, G_DAILY_EXPECT).replace(/,/g,"")),2));
                break;
        }
    }
    function CheckInput(para)
    {
        try
        {   
            var row, col ;
            if(Number(para) > 0)
            {
                row = para;  
                col = G_THIS_MONTH;
            }
            else
            {
                row = event.row;
                col = event.col;
            }

            if(col == G_THIS_MONTH)
            {
                var qty = grdMaster.GetGridData(row, col);
                if(Number(qty) || qty > 0)
                {
                    var w_day = 0, exp_yield = 0, count = 0, capacity = 0;
                    capacity = grdMaster.GetGridData(row, G_CAPACITY);
                    var this_month = Number(grdMaster.GetGridData(row, G_THIS_MONTH));

                    grdMaster.SetGridText(row, G_DAILY_PLAN, capacity * this_month);

                    w_day = Number(txtWorkingDay.text);
                    grdMaster.SetGridText(row, G_MONTHLY_PLAN, Number(grdMaster.GetGridData(row, G_DAILY_PLAN)) * w_day);

                    exp_yield = Number(txtExpectationYield.text)/100;
                    grdMaster.SetGridText(row, G_DAILY_EXPECT, Number(grdMaster.GetGridData(row, G_DAILY_PLAN)) * exp_yield);
                    grdMaster.SetGridText(row, G_MONTHLY_EXPECT, Number(grdMaster.GetGridData(row, G_MONTHLY_PLAN)) * exp_yield);
                }
                else
                {
                    grdMaster.SetGridText(row, col, "");
                }
            }
        }
        catch(err)
        {
            alert(err.Message);
        }
    }

    //------------------------------------------
    function OnCalc()
    {
        for (var i = 1; i < grdMaster.rows; i++) {
            CheckInput(i);
        }
    }
     //------------------------------------------
    function OnReport()
    {
        var url =System.RootURL + "/reports/kb/pr/rpt_kbpr00070.aspx?p_master_pk="+txtMasterPK.text; 
        System.OpenTargetPage(url); 
    }
</script>
<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kbpr00070" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kbpr00070"	>	
				<input>
					<input	bind="dtFromMonth"	/>	
					<input	bind="dtToMonth"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_kbpr00070_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5"	function="<%=l_user%>lg_sel_kbpr00070_1"	procedure="<%=l_user%>LG_UPD_KBPR00070">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtChargerPK"	/>
                        <inout	bind="lblChargerNM"	/>
						<inout	bind="dtMonth"	/>
						<inout	bind="txtWorkingDay"	/>
                        <inout	bind="txtExpectationYield"	/>
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00070_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_kbpr00070_2"   procedure="<%=l_user%>lg_upd_kbpr00070_1"> 
                <input bind="grdMaster">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="width: 100%; height: 100%">
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td>
                            Date
                        </td>
                        <td>
                            <gw:datebox id="dtFromMonth" lang="1" type='month' onchange="OnSearch('Search')" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                        </td>
                        <td>
                            <gw:datebox id="dtToMonth" lang="1" type='month' onchange="OnSearch('Search')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('Search')" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_pk|Month|Working Day|Expectation Yield' format='0|0|1|1'
                                aligns='0|1|0|0' check='|||' editcol='0|0|0|0' widths='1000|1000|1000|1000' sorting='T'
                                autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 1%">
                            Month
                        </td>
                        <td style="width: 15%">
                            <gw:datebox id="dtMonth" lang="1" type='month' />
                        </td>
                        <td style="width: 1%">
                            Charger
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtChargerPK" styles='display:none' />
                            <gw:label id="lblChargerNM" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnReport()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" id="btnUnDelete1" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 1%; white-space: nowrap">
                            Working Day
                        </td>
                        <td style="width: 15%" align="center">
                            <gw:textbox id="txtWorkingDay" styles='width:30%' type="number" format="0#" onchange="OnCalc()"
                                onenterkey="OnCalc()" />
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                            Expectation Yield
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtExpectationYield" styles='width:20%' type="number" format="###.00"
                                onchange="OnCalc()" onenterkey="OnCalc()" />
                        </td>
                        <td style="width: 1%" colspan="5">
                            <gw:icon id="idBtnProdBI" img="2" text="Production Basic Info" styles='width:100%'
                                onclick="OnPopup()" />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdMaster' header='_pk|_master_pk|-|Item Group|_tlg_it_item_pk|Item Name|Count|Capacity|Last Month|This Month|Daily Plan|Monthly Plan|Daily Expect|Monthly Expect|Avg Yarn Count'
                                format='0|0|0|0|0|0|1|1|1|1|1|1|1|1|1' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|1|0|0|0|0|0' widths='100|500|1000|1000|0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="CheckInput(0)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
