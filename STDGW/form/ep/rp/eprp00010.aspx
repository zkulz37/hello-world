<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Import Export Declaration</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdCusList------ 'PK|CUS_CODE|CUS_NAME|CUS_LEVEL|SHOW_YN|DESCRIPTION'

    var G1_DTOKHAIMDID      =    0,
        G1_SOTK      =    1,
        G1_NGAY_DK      =    2,
        G1_MA_HQ      =    3,
        G1_SOTN      =    4,
        G1_NGAYTN      =    5,
        G1_MA_LH      =    6,
        G1_MA_DVUT      =    7,
        G1_DV_DT      =    8,
        G1_VAN_DON      =    9,
        G1_NGAY_VANDON      =    10,
        G1_SO_GP      =    11,
        G1_NGAY_GP      =    12,
        G1_NGAY_HHGP      =    13,
        G1_SO_HDTM      =    14,
        G1_NGAY_HDTM      =    15,
        G1_MA_CK      =    16,
        G1_MA_CK      =    17,
        G1_MA_GH      =    18,
        G1_MA_NT      =    19,
        G1_MA_PTTT      =    20,
        G1_MA_PTVT      =    21,
        G1_C1      =    22,
        G1_TEN_PTVT      =    23,
        G1_NGAYDEN      =    24,
        G1_TR_LUONG_NET      =    25,
        G1_PHI_BH      =    26,
        G1_PHI_VC      =    27,
        G1_TYGIA_VND      =    28,
        G1_TRIGIA_KB      =    29,
        G1_TGKB_VND      =    30,
        G1_MA_HTS      =    31,
        G1_SO_CONTAINER      =    32,
        G1_TR_LUONG      =    33,
        G1_DEXUATKHAC      =    34,
        G1_TENCH      =    35,
        G1_CODE_NM      =    36,
        G1_PLUONG      =    37,
        G1_HUONGDANPL      =    38,
        G1_NGAY_THN_THX      =    39,
        G1_TEN_DV_L1      =    40,
        G1_MA_CK      =    41,
        G1_C2      =    42,
        G1_NUOC_NK      =    43,
        G1_NAME      =    44,
        G1_NUOC_XK      =    45,
        G1_NAME      =    46,
        G1_C3      =    47,
        G1_ACCOUNT_CODE      =    48,
        G1_TREASURY_NAME      =    49,
        G1_TONGTIENTHUE      =    50,
        G1_TS_TTDB      =    51,
        G1_THUE_VAT      =    52,
        G1_TONGTIENTHUEKH      =    53,
        G1_LUONG      =    54,
        G1_SOHSTK      =    55;
    //========================================================================

    function BodyInit() {
        // Translate to language session
        System.Translate(document);  
        txtCompanyPk.text = "<%=session("company_pk")%>";
        //------------------
        BindingDataList();
            
        //----format col grid
        OnFormatGrid();
        //------------------
        pro_eprp00010.Call();
    }


    //========================================================================
    function OnFormatGrid() {
        var trl;

        trl = grdCusList.GetGridControl();
        //trl.ColFormat(G1_CUSTOMS_LEVEL) = "###";
    }
 
    //========================================================================

    function BindingDataList() {

    //IEBS0000: declaration type
    var data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0000' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM" )%>||";    
    lstDeclType.SetDataText(data); 
    lstDeclType.value = 'N'
    
    data = "<%=ESysLib.SetListDataSQL("select code, name from tlg_ie_country where del_if = 0  and use_im_yn = 'Y' order by code" )%>||";    
    lstImCountry.SetDataText(data); 
    lstImCountry.value = ''
    
    data = "<%=ESysLib.SetListDataSQL("select code, name from tlg_ie_country where del_if = 0  and use_ex_yn = 'Y' order by code" )%>||";    
    lstExCountry.SetDataText(data); 
    lstExCountry.value = ''    
    }

    //========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdCusList':
                data_eprp00010.Call('SELECT');
                break;

        }
    }

    //========================================================================

    function OnAddNew(pos) {
        switch (pos) {
            case 'grdCusList':
                grdCusList.AddRow();
                grdCusList.SetGridText(grdCusList.rows - 1, G1_CUSTOMS_SHOW, -1);
                //grdCusList.SetGridText(grdCusList.rows - 1, G1_CUSTOMS_LEVEL, 1);
                break;
        }
    }

    //========================================================================

    function OnDelete(ogrid) {
        if (ogrid.row > 0) {
            if (ogrid.GetGridData(ogrid.row, G1_CUSTOMS_PK) == '') //pk
            {
                ogrid.RemoveRowAt(ogrid.row);
            }
            else 
            {
                ogrid.DeleteRow();
            }
        }
    }

    //========================================================================

    function OnUnDelete(ogrid) {

        ogrid.UnDeleteRow()
    }

    //========================================================================

    function OnSave(pos) {
        switch (pos) {
            case 'grdCusList':
            
                data_eprp00010.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'pro_eprp00010':
                data_eprp00010.Call();
            break
            case 'data_eprp00010':
                lbl_Record.text = grdCusList.rows - 1 + ' row(s)';
                txtTongSoToKhai.text = grdCusList.rows - 1;
                var l_Total1 = 0
                var l_Total2 = 0
                for(var i =1; i< grdCusList.rows; i++)
                {
                    l_Total2 = l_Total2  + Number(grdCusList.GetGridData(i, G1_TGKB_VND));                    
                    l_Total1 = l_Total1  + Number(grdCusList.GetGridData(i, G1_TONGTIENTHUE));
                }
                txtTongGiaTri.text = l_Total2;
                txt_TongThue.text = l_Total1;
                 var ctrl = grdCusList.GetGridControl(); 
                ctrl.Cell( 7, 0, G1_TRIGIA_KB, grdCusList.rows - 1, G1_TRIGIA_KB) = 0xFF0000;
                ctrl.Cell( 7, 0, G1_TGKB_VND, grdCusList.rows - 1, G1_TGKB_VND) = 0xFF0000;
                ctrl.Cell( 7, 0, G1_SOTK, grdCusList.rows - 1, G1_SOTK) = 0x0000FF;
                break;
        }
    }
    
    //======================================================================
    
    function OnSelect(oGrid) {
        var code_data = new Array();

        if (oGrid.row > 0) {
            for (j = 0; j < oGrid.cols; j++) {
                code_data[j] = oGrid.GetGridData(oGrid.row, j);
            }
        }
        else {
            for (j = 0; j < oGrid.cols; j++) {
                code_data[j] = '';
            }
        }
        //----------------------------
        window.returnValue = code_data;
        this.close();
    }
    
    //========================================================================
        
    function OnCancel(oGrid) {
        var code_data = new Array()

        for (j = 0; j < oGrid.cols; j++) {
            code_data[j] = '';
        }

        window.returnValue = code_data;
        this.close();
    }
    //======================================================================

</script>

<body>
    <!--------------------------------------Thuc hien lay thong tin mac dinh------------------------------->
    <gw:data id="pro_eprp00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user %>.sp_sel_eprp00010_0" > 
                <input>
                    <input bind="txtCompanyPk" />
                </input> 
                <output>
                    <output bind="txtCustomCode" />
                    <output bind="txtCompanyCode" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_eprp00010" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_eprp00010" > 
			    <input bind="grdCusList" > 
			        <input bind="txtCustomCode" />	
			        <input bind="txtCompanyCode" />	
			        
			        <input bind="lstDeclType" />	
			        <input bind="dtFrom" />	
			        <input bind="dtTo" />	
			        <input bind="txt_ContractNo" />	
			        <input bind="txt_BillOfNo" />	
			        <input bind="lstImCountry" />	
			        <input bind="lstExCountry" />	
			        <input bind="txt_Decl_profile_no" />	
			        <input bind="txt_ComInvNo" />	
			        <input bind="txt_HSCode" />	
			        <input bind="txt_MatProdCode" />	
			        <input bind="txtTenHang" />	
			        <input bind="txt_PartnerPK" />	
			        <input bind="txt_PartnerID" />	
			        <input bind="txt_PartnerName" />	
			    </input> 
			    <output bind="grdCusList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" >
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap;" align="right">
                Decl Type
            </td>
            <td style="width: 20%">
                <gw:list id="lstDeclType" style="width: 100%;" onchange="OnSearch()" />
            </td>
            <td style="width: 5%" align="right">
                Date
            </td>
            <td style="width: 20%; white-space: nowrap;">
                <gw:datebox id="dtFrom" lang="1" onchange="dateChange()" />
                ~
                <gw:datebox id="dtTo" lang="1" onchange="dateChange()" />
            </td>
            <td style="width: 5%; white-space: nowrap;" align="right">
                Contract No
            </td>
            <td style="width: 20%;">
                <gw:textbox id="txt_ContractNo" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%; white-space: nowrap;" align="right">
                Bill Of No.
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_BillOfNo" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap;" align="right">
                Im Country
            </td>
            <td style="width: 20%">
                <gw:list id="lstImCountry" style="width: 100%;" onchange="OnSearch()" />
            </td>
            <td style="width: 5%; white-space: nowrap;" align="right">
                Ex Country
            </td>
            <td style="width: 20%">
                <gw:list id="lstExCountry" style="width: 100%;" onchange="OnSearch()" />
            </td>
            <td style="width: 5%" align="right">
                Profile no
            </td>
            <td style="width: 20%; text-align: center;">
                <gw:textbox id="txt_Decl_profile_no" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%; white-space: nowrap;" align="right">
                Com Inv No
            </td>
            <td style="width: 20%" >
                <gw:textbox id="txt_ComInvNo" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                HS Code
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_HSCode" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%; white-space:nowrap;" align="right">
                Mat/Prod Code
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_MatProdCode" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%" align="right">
                Ten hang
            </td>
            <td style="width: 20%; text-align: center;">
                <gw:textbox id="txtTenHang" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%" align="right">
                Partner
            </td>
            <td style="width: 20%; white-space:nowrap;" >
                <gw:textbox id="txt_PartnerPK" text="" styles="width:100%;display:none" />
                <gw:textbox id="txt_PartnerID" text="" styles="width:30%" onenterkey="OnSearch()" />
                <gw:textbox id="txt_PartnerName" text="" styles="width:70%" onenterkey="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="8">
                <table style="width:100%; height:100%;">
                    <tr >
                        <td style="width: 5%" align="right">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 30%" align="center" colspan="2">
                            <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
                        </td>
                        <td style="width: 17%">
                        </td>
                        <td style="width: 5%" align="right">
                        </td>
                        <td style="width: 20%">
                        </td>
                        
                        <td style="width: 1%" align="right">
                            <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdCusList')" />
                        </td>
                        <td style="width: 1%">
                            <gw:button id="btn_Cancel" img="cancel" alt="Cancel" onclick="OnCancel(grdCusList)" />
                        </td>
                        <td style="width: 1%">
                            <gw:button id="btn_Select" img="excel" alt="Excel" onclick="OnSelect(grdCusList)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="8">
                <gw:grid id='grdCusList'
                    header='_DTOKHAIMDID|Decl No|Reg Date|_MA_HQ|Recep No|Recep Date|Decl Form|MA_DVUT|DV_DT|B/L|B/L Date|SO_GP|NGAY_GP|NGAY_HHGP|SO_HDTM|NGAY_HDTM|MA_CK|MA_CK|MA_GH|MA_NT|MA_PTTT|MA_PTVT|C1|TEN_PTVT|NGAYDEN|TR_LUONG_NET|PHI_BH|PHI_VC|TYGIA_VND|TRIGIA_KB|TGKB_VND|MA_HTS|SO_CONTAINER|TR_LUONG|DEXUATKHAC|TENCH|CODE_NM|PLUONG|HUONGDANPL|NGAY_THN_THX|TEN_DV_L1|MA_CK|C2|NUOC_NK|NAME|NUOC_XK|NAME|C3|ACCOUNT_CODE|TREASURY_NAME|TONGTIENTHUE|TS_TTDB|THUE_VAT|TONGTIENTHUEKH|LUONG|SOHSTK'
                    format='0|0|4|0|0|4|0|0|0|0|4|0|4|4|0|4|0|0|0|0|0|0|0|0|4|1|1|1|1|1|1|0|0|1|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||||||||||||||||||||||||||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T'
                    autosize='T' 
                    styles='width:100%; height:100%'
                    oncelldblclick="OnSelect(grdCusList)" 
                    />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap;" align="right">
                Decl.Number
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtTongSoToKhai" text="" styles="width:100%; color:blue"  type="number" format="###,###,###"  readonly="T" />
            </td>
            <td style="width: 5%; white-space: nowrap;" align="right">
                Total Val
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtTongGiaTri" text="" styles="width:100%; color:blue"  type="number" format="###,###,###" readonly="T"  />
            </td>
            <td style="width: 5%; white-space:nowrap;" align="right">
                Total Tax Val
            </td>
            <td style="width: 20%; white-space: nowrap; text-align: center;">
                <gw:textbox id="txt_TongThue" text="" styles="width:100%; color:blue"  type="number" format="###,###,###" readonly="T" />
            </td>
            <td style="width: 5%" align="right">
                &nbsp;
            </td>
            <td style="width: 20%">
                &nbsp;
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txtCustomCode" text="" styles='display:none' />
    <gw:textbox id="txtCompanyCode" text="" styles='display:none' />
    <gw:textbox id="txtCompanyPk" text="" styles='display:none' />
</body>
</html>
