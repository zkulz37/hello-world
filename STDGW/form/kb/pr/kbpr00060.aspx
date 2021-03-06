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
        G_ITEM_PK = 1,
        G_ITEM_CODE = 2,
        G_ITEM_NAME = 3,
        G_COUNT = 4,
        G_CAPACITY = 5,
        G_CONVERT_INDEX = 6,
        G_VALUE_2 = 7,
        G_VALUE_3 = 8,
        G_REMARK = 9;

    var arr_FormatNumber = new Array();
    //===============================================================================================
    function BodyInit() {
        System.Translate(document);  // Translate to language session    
        BindingDataList();
    }
    //==================================================================================
    function BindingDataList() {
        var ctrl = grdMaster.GetGridControl();
        ctrl.ColFormat(G_CONVERT_INDEX)= "###,###,###.####" ;
        ctrl.ColFormat(G_VALUE_2)= "###,###,###.####" ;
    }
    //=============================================================================================
    function OnSearch(pos) {
        switch (pos) {
            case 'grdSearch':
                data_kbpr00060.Call("SELECT");
                break;
        }
    }
    //=============================================================================================
    function OnAddNew() {
        var path = System.RootURL + "/form/fp/ab/fpab00071.aspx?group_type=Y||Y||||";
        var object = System.OpenModal(path, 800, 600, 'resizable:yes;status:yes', this);

        if (object != null) {
            var arrTemp;
            for (var i = 0; i < object.length; i++) {
                arrTemp = object[i];

                grdMaster.AddRow();
                grdMaster.SetGridText(grdMaster.rows - 1, G_ITEM_PK, arrTemp[0]);
                grdMaster.SetGridText(grdMaster.rows - 1, G_ITEM_CODE, arrTemp[1]);
                grdMaster.SetGridText(grdMaster.rows - 1, G_ITEM_NAME, arrTemp[2]);
            }
        }
    }
    //=============================================================================================
    function OnDelete() {
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
    function OnSave() {
        data_kbpr00060.Call();
    }
    //=============================================================================================
    function OnSearch() {
        data_kbpr00060.Call('SELECT');
    }
    //=============================================================================================
    function OnDataReceive(obj) {
        switch (obj.id) {
            case "data_kbpr00060":
                break;
        }
    }
    //------------------------------------------
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00060" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_kbpr00060"   procedure="<%=l_user%>lg_upd_kbpr00060"> 
                <input bind="grdMaster">                    
                    <input bind="txtSearch" /> 
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="width: 100%; height: 1%">
            <td style="width: 1%">
                Item
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtSearch" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch()" />
            </td>
            <td style="width: 64%">
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
                <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="width: 100%; height: 99%">
            <td colspan="8">
                <gw:grid id='grdMaster' header='_pk|_item_pk|Item Code|Item Name|Count|Capacity|Convert Index|Value 2|Value 3|Remark'
                    format='0|0|0|0|1|1|1|1|1|0' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='0|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
