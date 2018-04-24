<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Country List</title>
</head>
<% 
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script type="text/javascript">
    //---------grdCusList------ 

    var G1_PK 			= 0
		G1_CODE 		= 1
		G1_NAME 		= 2
		G1_LNAME 		= 3
		G1_FNAME 		= 4
		G1_USE_IM_YN 	= 5
		G1_USE_EX_YN 	= 6
		G1_CCY_CODE 	= 7
		G1_REMARKS 		= 8;
    //========================================================================

    function BodyInit() {
        // Translate to language session
        System.Translate(document);  
        txt_PopType.text = "<%=Request.querystring("pop_type")%>";
        //------------------
        //-----------------
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
        OnSearch('grdCountryList');
    }


    //========================================================================
    function OnFormatGrid() {
       
    }
 
    //========================================================================

    function BindingDataList() {

    }

    //========================================================================

    function OnSearch(pos) {
        switch (pos) {
            case 'grdCountryList':
                data_epbs00020.Call('SELECT');
                break;

        }
    }

    //========================================================================

    function OnAddNew(pos) {
        switch (pos) {
            case 'grdCountryList':
                grdCountryList.AddRow();
                //grdCountryList.SetGridText(grdCountryList.rows - 1, G1_CUSTOMS_SHOW, -1);
                //grdCountryList.SetGridText(grdCountryList.rows - 1, G1_CUSTOMS_LEVEL, 1);
                break;
        }
    }

    //========================================================================

    function OnDelete(ogrid) {
        if (ogrid.row > 0) {
            if (ogrid.GetGridData(ogrid.row, G1_PK) == '') //pk
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
            case 'grdCountryList':
            
                data_epbs00020.Call();
                break;
        }
    }

    //========================================================================

    function OnDataReceive(obj) {
        switch (obj.id) 
        {
            case 'data_epbs00020':
                if (grdCountryList.rows > 1) 
                {
                    lbl_Record.text = grdCountryList.rows - 1 + ' row(s)';
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
	
	function OnGridCellAfterEdit(obj)
	{
		var col = event.col;
		var row = event.row;
		switch(obj.id)
		{
			case 'grdCountryList':
			    if(obj.Validate(row, col)==false)
			    {
			    alert(_BeforeValBuff);
			        obj.SetGridText(row, col,_BeforeValBuff);
			    }
			break;
		}
		_BeforeValBuff = '';
	}
	
	//======================================================================
    var _BeforeValBuff = '';
	function OnGridCellBeforeEdit(obj)
	{
		var col = event.col;
		var row = event.row;
		switch(obj.id)
		{
			case 'grdCountryList':
			    _BeforeValBuff = obj.GetGridData(row,col);
			break;
		}
	}
	//======================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epbs00020" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid" parameter="0,1,2,3,4,5,6,7,8" function="<%=l_user %>lg_sel_epbs00020" procedure="<%=l_user %>lg_upd_epbs00020"  > 
			    <input bind="grdCountryList" > 
			        <input bind="txt_Code" />	
			        <input bind="txt_Name" />	
			    </input> 
			    <output bind="grdCountryList" /> 
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
                <gw:textbox id="txt_Code" text="" styles="width:100%" onenterkey="OnSearch('grdCountryList')" />
            </td>
            <td style="width: 5%" align="right">
                Name
            </td>
            <td style="width: 30%">
                <gw:textbox id="txt_Name" text="" styles="width:100%" onenterkey="OnSearch('grdCountryList')" />
            </td>
            <td style="width: 33%; text-align:center;">
                <gw:label id="lbl_Record" styles="color: blue">row(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch('grdCountryList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_New" img="new" alt="New" onclick="OnAddNew('grdCountryList')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Dlete" img="delete" alt="Delete" onclick="OnDelete(grdCountryList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_UnDelete" img="undelete" alt="UnDelete" onclick="OnUnDelete(grdCountryList)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:button id="btn_Save" img="save" alt="Save" onclick="OnSave('grdCountryList')" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Cancel" img="cancel" alt="Cancel" onclick="OnCancel(grdCountryList)" />
            </td>
            <td style="width: 1%">
                <gw:button id="btn_Select" img="select" alt="Select" onclick="OnSelect(grdCountryList)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="12">
				<gw:grid id='grdCountryList'
					header='_PK|Code|Name|_LNAME|_FNAME|Use IM|Use EX|CCY Code|Remarks'
					format='0|0|0|0|0|3|3|0|0'
					aligns='0|0|0|0|0|0|0|0|0'
					check='|2||||||3|'
					editcol='1|1|1|1|1|1|1|1|1'
					widths='1000|1000|3000|1000|1000|1000|1000|1000|1000'
					sorting='T'
					styles='width:100%; height:100%'
					onbeforeedit='OnGridCellBeforeEdit(this)'
					onafteredit='OnGridCellAfterEdit(this)'
				/>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------->
    <gw:textbox id="txt_PopType" text="" styles='display:none' />
    
</body>
</html>

