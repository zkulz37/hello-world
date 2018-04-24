<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>HS Code Entry</title>
</head>
<% 
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdHSCodeList------ 'PK|CUS_CODE|CUS_NAME|CUS_LEVEL|SHOW_YN|DESCRIPTION'

    var G0_PK           =   0,
        G0_CHAPTER_CODE =   1,
        G0_DESCRIPTION  =   2;
        
    var G1_PK           =   0,
        G1_ID           =   1,
        G1_ORD          =   2,
        G1_GROUP_CODE   =   3,
        G1_GROUP_CODE_1 =   4,
        G1_GROUP_CODE_2 =   5,
        G1_HS_CODE      =   6,
        G1_HS_NM        =   7,
        G1_DESCRIPTION  =   8,
        G1_MN_TK        =   9,
        G1_CHAPTER      =   10;
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
        OnSearch('grdChapterList');
    }


    //========================================================================
    function OnFormatGrid() {
//        var trl;

//        trl = grdHSCodeList.GetGridControl();
//        trl.ColFormat(G1_CUSTOMS_LEVEL) = "###";
    }
 
    //========================================================================

    function BindingDataList() {

    }

    //========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdHSCodeList':
                data_epbs00030.Call('SELECT');
                break;
            case 'grdChapterList':
                data_epbs00030_1.Call('SELECT');
            break;

        }
    }

    //========================================================================

    function OnAddNew(pos) {
        switch (pos) {
            case 'grdHSCodeList':
                grdHSCodeList.AddRow();
                //grdHSCodeList.SetGridText(grdHSCodeList.rows - 1, G1_CUSTOMS_SHOW, -1);
                //grdHSCodeList.SetGridText(grdHSCodeList.rows - 1, G1_CUSTOMS_LEVEL, 1);
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
            case 'grdHSCodeList':            
                data_epbs00030.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'data_epbs00030':
                if (grdHSCodeList.rows > 1) 
                {
                    lbl_Record.text = grdHSCodeList.rows - 1 + ' row(s)';
                }
                break;
             case 'data_epbs00030_1':
                if (grdChapterList.rows > 1) 
                {
                    lbl_Record0.text = grdChapterList.rows - 1 + ' row(s)';
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
            case 'grdChapterList':
                txt_ChapterCode.text = objGrid.GetGridData(row,G0_CHAPTER_CODE);
                data_epbs00030.Call('SELECT')
            break;
            default:
            break;
        }
    }

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00030_1" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00030_1" > 
			    <input bind="grdChapterList" > 
			    </input> 
			    <output bind="grdChapterList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00030" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5" function="<%=l_user %>lg_sel_epbs00030" > 
			    <input bind="grdHSCodeList" > 
			        <input bind="txt_HSCode" />	
			        <input bind="txt_HSName" />	
			        <input bind="txt_ChapterCode" />	
			    </input> 
			    <output bind="grdHSCodeList" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table name="Component" class="table" style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
            </td>
            <td style="width: 20%">
            </td>
            <td style="width: 5%" align="right">
            </td>
            <td style="width: 30%">
            </td>
            <td style="width: 33%; text-align: center;">
                <gw:label id="lbl_Record0" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search0" img="search" styles="display:none" alt="Search" onclick="OnSearch('grdHSCodeList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New0" img="new"  styles="display:none" alt="New" onclick="OnAddNew('grdHSCodeList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete0" img="delete" styles="display:none"  alt="Delete" onclick="OnDelete(grdHSCodeList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete0" img="undelete"  styles="display:none" alt="UnDelete" onclick="OnUnDelete(grdHSCodeList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save0" img="save"  styles="display:none" alt="Save" onclick="OnSave('grdHSCodeList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel0" img="cancel"  styles="display:none" alt="Cancel" onclick="OnCancel(grdHSCodeList)" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Select" img="select" alt="Select" onclick="OnSelect(grdHSCodeList)" />
            </td>
        </tr>
        <tr style="height: 30%">
            <td colspan="12">
                <gw:grid id='grdChapterList'
                    header='_PK|Code|Description'
                    format='0|0|0'
                    aligns='0|1|0'
                    check='||'
                    editcol='0|0|0'
                    widths='1000|1000|3000'
                    sorting='F'
                    styles='width:100%; height:100%'
                    oncellclick="OnGridCellClick(this)"
                    />
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Code
            </td>
            <td style="width: 20%">
                <gw:textbox id="txt_HSCode" text="" styles="width:100%" onenterkey="OnSearch('grdHSCodeList')" />
            </td>
            <td style="width: 5%" align="right">
                Description
            </td>
            <td style="width: 30%">
                <gw:textbox id="txt_HSName" text="" styles="width:100%" onenterkey="OnSearch('grdHSCodeList')" />
            </td>
            <td style="width: 33%; text-align: center;">
                <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdHSCodeList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New" img="new" alt="New" onclick="OnAddNew('grdHSCodeList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete" img="delete" alt="Delete" onclick="OnDelete(grdHSCodeList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete" img="undelete" alt="UnDelete" onclick="OnUnDelete(grdHSCodeList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save" img="save" alt="Save" onclick="OnSave('grdHSCodeList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel" img="cancel" alt="Cancel" onclick="OnCancel(grdHSCodeList)" />
            </td>
            <td style="width: 1%">
                
            </td>
        </tr>
        <tr style="height: 68%">
            <td colspan="12">
                <gw:grid id='grdHSCodeList' header='_PK|_ID|_Ord|Group Code|Group Code 1|Group Code 2|HS Code|_HS_NM|Description|_MN_TK|_CHAPTER'
                    format='0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|2|1|1|1|1|0|0|0|0' check='||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='F' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_PopType" text="" styles='display:none' />
    <gw:textbox id="txt_ChapterCode" text="" styles='display:none' />
</body>
</html>
