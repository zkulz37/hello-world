<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Dinh Muc</title>
</head>
<% 
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdMATDMList------ 'PK|CUS_CODE|CUS_NAME|CUS_LEVEL|SHOW_YN|DESCRIPTION'

    var G0_MA_SP          = 0
        G0_TEN_SP         = 1
        G0_SO_DM          = 2
        G0_NGAY_DK        = 3
        G0_SO_HD_BAN      = 4
        G0_NGAY_HD_BAN    = 5
        G0_SOLUONG        = 6
        G0_CO             = 7
        G0_DINHMUC_TTID   = 8
        G0_HDGCID         = 9
        G0_SP_HDID        = 10;
        
    var G1_DINHMUCID       = 0
        G1_MA_NPL          = 1
        G1_TEN_NPL         = 2
        G1_MA_DVT          = 3
        G1_DM_SD           = 4
        G1_TL_HH           = 5
        G1_DM_CHUNG        = 6
        G1_GHI_CHU         = 7;
    //========================================================================

    function BodyInit() {
        // Translate to language session
        System.Translate(document);  
        txt_PopType.text = "<%=Request.querystring("pop_type")%>";
        //------------------
        BindingDataList();
        
        //visable select button for popup type
        if(txt_PopType.text == 'Y')
        {
            btn_Select.style.display = '';
            btn_Cancel.style.display = '';
        }
        else
        {
            btn_Select.style.display = 'none';
            btn_Cancel.style.display = 'none';
        }
            
        //----format col grid
        OnFormatGrid();
        //------------------
        OnSearch('grdProdDMList');
    }


    //========================================================================
    function OnFormatGrid() {
        var trl;

        trl = grdMATDMList.GetGridControl();
        trl.ColFormat(G1_DM_SD) = "###,###,###.########";
        trl.ColFormat(G1_TL_HH) = "###,###,###";
        trl.ColFormat(G1_DM_CHUNG) = "###,###,###.#####";
        
    }
 
    //========================================================================

    function BindingDataList() {

    }
//========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdMATDMList':    
                data_epbs00060_1.Call('SELECT');
                
                break;
            case 'grdProdDMList':
                data_epbs00060.Call('SELECT');
            break;

        }
    }

    //========================================================================

    function OnAddNew(pos) {
        switch (pos) {
            case 'grdMATDMList':
                grdMATDMList.AddRow();
                //grdMATDMList.SetGridText(grdMATDMList.rows - 1, G1_CUSTOMS_SHOW, -1);
                //grdMATDMList.SetGridText(grdMATDMList.rows - 1, G1_CUSTOMS_LEVEL, 1);
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
            case 'grdMATDMList':            
                data_epbs00060_1.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'data_epbs00060_1':
                if (grdMATDMList.rows > 1) 
                {
                    lbl_Record.text = grdMATDMList.rows - 1 + ' row(s)';
                }
                break;
             case 'data_epbs00060':
                if (grdProdDMList.rows > 1) 
                {
                    lbl_Record0.text = grdProdDMList.rows - 1 + ' row(s)';
                }
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
    function OnGridCellClick(objGrid)
    {         
      var col = event.col;
        var row = event.row;
        switch(objGrid.id)
        {
            case 'grdProdDMList':
                txt_Prod_Code.text = objGrid.GetGridData(row,G0_MA_SP);
                data_epbs00060_1.Call('SELECT')
            break;
            default:
            break;
        }
    }

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00060" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00060" > 
			    <input bind="grdProdDMList" > 
			        <input bind="txt_ProdCode" />	
			        <input bind="txt_ProdName" />	
			    </input> 
			    <output bind="grdProdDMList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00060_1" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00060_1" > 
			    <input bind="grdMATDMList" > 
			        <input bind="txt_Cus_Code" />
			        <input bind="txt_Com_Code" />	
			        <input bind="txt_Prod_Code" />
			        <input bind="txt_Mat_Code" />	
			        <input bind="txt_Mat_Name" />		
			    </input> 
			    <output bind="grdMATDMList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table name="Component" class="table" style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space:nowrap;" align="right">
                Prod Code/Name
            </td>
            <td style="width: 40%; white-space:nowrap;">
                <gw:textbox id="txt_ProdCode" text="" styles="width:30%" onenterkey="OnSearch('grdProdDMList')" />
                <gw:textbox id="txt_ProdName" text="" styles="width:70%" onenterkey="OnSearch('grdProdDMList')" />
            </td>
            <td style="width: 5%" align="right">
            </td>
            <td style="width: 10%">
            </td>
            <td style="width: 33%; text-align: center;">
                <gw:label id="lbl_Record0" styles="color: blue; white-space:nowrap;">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search0" img="search" styles="display:none" alt="Search" onclick="OnSearch('grdMATDMList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New0" img="new"  styles="display:none" alt="New" onclick="OnAddNew('grdMATDMList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete0" img="delete" styles="display:none"  alt="Delete" onclick="OnDelete(grdMATDMList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete0" img="undelete"  styles="display:none" alt="UnDelete" onclick="OnUnDelete(grdMATDMList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save0" img="save"  styles="display:none" alt="Save" onclick="OnSave('grdMATDMList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel0" img="cancel"  styles="display:none" alt="Cancel" onclick="OnCancel(grdMATDMList)" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Select" img="select" alt="Select" onclick="OnSelect(grdMATDMList)" />
            </td>
        </tr>
        <tr style="height: 53%">
            <td colspan="12">
                <gw:grid id='grdProdDMList'
                header='Prod Code|Prod Name|Seq|Reg Date|Contract No|Contract Date|Qty|Size|_DINHMUC_TTID|_HDGCID|_SP_HDID'
                format='0|0|0|4|0|4|1|0|1|0|0'
                aligns='0|0|1|1|0|1|2|0|2|0|0'
                check='||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0'
                widths='3000|4000|500|1200|1500|1500|1000|1000|1000|1000|1000'
                sorting='T'
                styles='width:100%; height:100%'
                oncellclick='OnGridCellClick(this)'
                />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Mat Code/Name
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_Mat_Code" text="" styles="width:100%" onenterkey="OnSearch('grdMATDMList')" />
            </td>
            <td style="width: 5%" align="right">
                Description
            </td>
            <td style="width: 30%">
                <gw:textbox id="txt_Mat_Name" text="" styles="width:100%" onenterkey="OnSearch('grdMATDMList')" />
            </td>
            <td style="width: 33%; text-align: center;">
                <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdMATDMList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New" img="new" styles="display:none" alt="New" onclick="OnAddNew('grdMATDMList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete" img="delete"  styles="display:none" alt="Delete" onclick="OnDelete(grdMATDMList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete" img="undelete"  styles="display:none" alt="UnDelete" onclick="OnUnDelete(grdMATDMList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save" img="save"  styles="display:none" alt="Save" onclick="OnSave('grdMATDMList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel" img="cancel"  styles="display:none" alt="Cancel" onclick="OnCancel(grdMATDMList)" />
            </td>
            <td style="width: 1%">
                
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="12">
                <gw:grid id='grdMATDMList'
                    header='_DINHMUCID|Mat Code|Mat Name|UOM|Yield(Use)|Rate|Yield|Remarks'
                    format='0|0|0|0|1|1|1|0'
                    aligns='0|0|0|0|0|0|0|0'
                    check='|||||||'
                    editcol='0|0|0|0|0|0|0|0'
                    widths='1000|2000|4000|1000|1200|500|1000|1000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    />
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_PopType" text="" styles='display:none' />
    <gw:textbox id="txt_ChapterCode" text="" styles='display:none' />
    
    <!----------------------------------------------------------->
    <gw:textbox id="txt_Cus_Code" text="P03L" styles='display:none' />
    <gw:textbox id="txt_Com_Code" text="0900283167" styles='display:none' />
    <gw:textbox id="txt_Prod_Code" text="" styles='display:none' />
    
    
</body>
</html>
