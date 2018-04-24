<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Tariffs Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdTariffsList------ 'PK,TARIFFS_CODE,TARIFFS_NAME,TAX_TYPE,DESCRIPTION'

    var G1_TARIFFS_PK = 0,
        G1_TARIFFS_CODE = 1,
        G1_TARIFFS_NAME = 2,
        G1_TAX_TYPE = 3,
        G1_DESCRIPTION = 4;
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
        OnSearch('grdTariffsList');
    }


    //========================================================================
    function OnFormatGrid() {
//        var trl;

//        trl = grdTariffsList.GetGridControl();
//        trl.ColFormat(G1_CUSTOMS_LEVEL) = "###";
    }
 
    //========================================================================

    function BindingDataList() {
    
        var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  a.CODE, a.CODE_NM FROM tlg_lg_code a ,tlg_lg_code_group b  WHERE a.del_if = 0 and b.DEL_IF =0 AND a.tlg_lg_code_group_pk = b.pk and  b.GROUP_ID ='IECU04' ORDER BY a.ord " ) %> ";       
         grdTariffsList.SetComboFormat( G1_TAX_TYPE, data); 
    }

    //========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdTariffsList':
                data_epbs00050.Call('SELECT');
                break;

        }
    }

    //========================================================================

    function OnAddNew(pos) {
        switch (pos) {
            case 'grdTariffsList':
                grdTariffsList.AddRow();
                //grdTariffsList.SetGridText(grdTariffsList.rows - 1, G1_CUSTOMS_SHOW, -1);
                //grdTariffsList.SetGridText(grdTariffsList.rows - 1, G1_CUSTOMS_LEVEL, 1);
                break;
        }
    }

    //========================================================================

    function OnDelete(ogrid) {
        if (ogrid.row > 0) {
            if (ogrid.GetGridData(ogrid.row, G1_TARIFFS_PK) == '') //pk
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
            case 'grdTariffsList':
            
                data_epbs00050.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'data_epbs00050':
                if (grdTariffsList.rows > 1) 
                {
                    lbl_Record.text = grdTariffsList.rows - 1 + ' row(s)';
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

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00050" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4" function="<%=l_user %>lg_sel_epbs00050" procedure="<%=l_user %>lg_upd_epbs00050"  > 
			    <input bind="grdTariffsList" > 
			        <input bind="txt_TariffsCode" />	
			        <input bind="txt_TariffsName" />	
			    </input> 
			    <output bind="grdTariffsList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table name="Component" class="table" style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Code
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_TariffsCode" text="" styles="width:100%" onenterkey="OnSearch('grdTariffsList')" />
            </td>
            <td style="width: 5%" align="right">
                Name
            </td>
            <td style="width: 30%">
                <gw:textbox id="txt_TariffsName" text="" styles="width:100%" onenterkey="OnSearch('grdTariffsList')" />
            </td>
            <td style="width: 33%; text-align:center;">
                <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdTariffsList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New" img="new" alt="New" onclick="OnAddNew('grdTariffsList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete" img="delete" alt="Delete" onclick="OnDelete(grdTariffsList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete" img="undelete" alt="UnDelete" onclick="OnUnDelete(grdTariffsList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save" img="save" alt="Save" onclick="OnSave('grdTariffsList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel" img="cancel" alt="Cancel" onclick="OnCancel(grdTariffsList)" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Select" img="select" alt="Select" onclick="OnSelect(grdTariffsList)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="12">        
                <gw:grid id='grdTariffsList'
                    header='_PK|Code|Name|Tax Type|Description'
                    format='0|0|0|2|0'
                    aligns='0|0|0|1|0'
                    check='||||'
                    editcol='1|1|1|1|1'
                    widths='1000|1000|5000|1000|1000'
                    sorting='T'
                    styles='width:100%; height:100%' 
                    oncelldblclick="OnSelect(grdTariffsList)" 
                    />
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_PopType" text="" styles='display:none' />
    
</body>
</html>
