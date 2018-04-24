<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Customs Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdCusList------ 'PK|CUS_CODE|CUS_NAME|CUS_LEVEL|SHOW_YN|DESCRIPTION'

    var G1_CUSTOMS_PK = 0,
        G1_CUSTOMS_CODE = 1,
        G1_CUSTOMS_NAME = 2,
        G1_CUSTOMS_LEVEL = 3,
        G1_CUSTOMS_SHOW = 4,
        G1_DESCRIPTION = 5;
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
        OnSearch('grdCusList');
    }


    //========================================================================
    function OnFormatGrid() {
        var trl;

        trl = grdCusList.GetGridControl();
        trl.ColFormat(G1_CUSTOMS_LEVEL) = "###";
    }
 
    //========================================================================

    function BindingDataList() {

    }

    //========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdCusList':
                data_epbs00040.Call('SELECT');
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
            
                data_epbs00040.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'data_epbs00040':
                if (grdCusList.rows > 1) 
                {
                    lbl_Record.text = grdCusList.rows - 1 + ' row(s)';
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
    <gw:data id="data_epbs00040" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00040" procedure="<%=l_user %>lg_upd_epbs00040"  > 
			    <input bind="grdCusList" > 
			        <input bind="txt_CustomsCode" />	
			        <input bind="txt_Customs" />	
			    </input> 
			    <output bind="grdCusList" /> 
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
                <gw:textbox id="txt_CustomsCode" text="" styles="width:100%" onenterkey="OnSearch('grdCusList')" />
            </td>
            <td style="width: 5%" align="right">
                Name
            </td>
            <td style="width: 30%">
                <gw:textbox id="txt_Customs" text="" styles="width:100%" onenterkey="OnSearch('grdCusList')" />
            </td>
            <td style="width: 33%; text-align:center;">
                <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdCusList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New" img="new" alt="New" onclick="OnAddNew('grdCusList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete" img="delete" alt="Delete" onclick="OnDelete(grdCusList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete" img="undelete" alt="UnDelete" onclick="OnUnDelete(grdCusList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save" img="save" alt="Save" onclick="OnSave('grdCusList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel" img="cancel" alt="Cancel" onclick="OnCancel(grdCusList)" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Select" img="select" alt="Select" onclick="OnSelect(grdCusList)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="12">                    
                <gw:grid id='grdCusList'
                    header='_PK|Code|Name|Level|Show|Description'
                    format='0|0|0|1|3|0'
                    aligns='0|0|0|1|1|0'
                    check='|||||'
                    editcol='1|1|1|1|1|1'
                    widths='1000|1000|5000|1000|1000|1000'
                    sorting='T'
                    styles='width:100%; height:100%' 
                    oncelldblclick="OnSelect(grdCusList)" 
                    />
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_PopType" text="" styles='display:none' />
    
</body>
</html>
