<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html>
    <head>
        <title>System controls management</title>
        <script language="javascript">
            function BodyInit() {
                BindData();
                OnNew_Data();
				grdControlsManageGrid.GetGridControl().FrozenCols = 3;
            }

            function BindData() {
                var data = "grid|grid|process|process|list|list|control|control|array|array|tree|tree";
                lstType_Search.SetDataText("DATA|ALL|ALL|" + data);
                lstType.SetDataText("DATA|" + data);

                data = "#IN;Input|#OUT;Output|#INOUT;Inout"
                grdControlsManageArgument.SetComboFormat(5, data);

                data = "#0;TextBox|#2;ListBox|#3;CheckBox|#4;Date|#5;Month|#5;Month|#-0;Number 1|#-1;Number 1.0|#-2;Number 1.00|#-3;Number 1.000|#-4;Number 1.0000|#-5;Number 1.00000|#-6;Number 1.000000";
                grdControlsManageGrid.SetComboFormat(4, data);

                data = "#2;Left|#3;Right|#1;Center";
                grdControlsManageGrid.SetComboFormat(6, data);
				
				data = "#0;Not null|#n;Must be a number|#-;Must be number and >=0|#0n;Must be a number and must input|#0-;Must be number and >=0 and must input|#;No check";
                grdControlsManageGrid.SetComboFormat(10, data);
            }

            function OnSearch() {
                data_search.Call('SELECT');
            }

            function OnSelect_Data() {
                if (grdControlsManageSearch.GetGridData(grdControlsManageSearch.row, 0) != '') {
                    txtControlPk.text = grdControlsManageSearch.GetGridData(grdControlsManageSearch.row, 0);
                    grdControlsManageArgument.ClearData();
                    grdControlsManageGrid.ClearData();
                    data_controls.Call('SELECT');
                }
            }

            function OnNew_Data() {
                if (data_controls.GetStatus() != 20) {
                    data_controls.StatusInsert();

                    txtControlPk.text = "";
                    txtOnReceive.text = "OnDataReceive(this)";
                    txtOnError.text = "OnDataError(this)";
                    txtGridWidth.text = "100%";
                    txtGridHeight.text = "100%";
                    chkGridDisplay.value = "T";
                    chkGridSort.value = "T";
                    chkGridAutosize.value = "T";

                    OnInitControl(txtControlPk);
                    grdControlsManageArgument.ClearData();
                    grdControlsManageGrid.ClearData();
                }
                else {
                    alert("Now you can register DSO control.");
                }
            }

            function OnSave_Data() {
                var status = data_controls.GetStatus();

                if (status != 40) {
                    if (status != 20) {
                        data_controls.StatusUpdate();
                    }
                    
                    data_controls.Call();
                } else {
                    data_controls.Call();
                }
            }

            function OnDelete_Data() {
                if (txtControlPk.text == "") {
                    alert("Please select a DSO to delete.");
                    return;
                }
                if (confirm("Do you want to delete this DSO?")) {
                    data_controls.StatusDelete();
                    OnSave_Data();
                }
            }

            function OnNew_Argu() {
                var grid = grdControlsManageArgument.GetGridControl();
                grdControlsManageArgument.AddRow();
                grdControlsManageArgument.SetGridText(grid.Rows - 1, 1, grid.Rows - 1);
                grdControlsManageArgument.SetGridText(grid.Rows - 1, 5, 'IN');
                //grdControlsManageArgument.SetGridText(grid.Rows - 1, 4, 1);

                if (txtControlPk.text != "") {
                    grdControlsManageArgument.SetGridText(grid.Rows - 1, 7, txtControlPk.text);
                }
            }

            function OnSave_Argu() {
                data_argument.Call();
            }

            function OnDelete_Argu() {
                if(confirm('Are you sure to delete this Argument?')){
                    grdControlsManageArgument.DeleteRow();
                    data_argument.Call();
                }
            }

            function OnGet_Argu() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=data";
                oValue = System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
				//window.showModalDialog(fpath,this, "resizable:yes;status:yes;width:600px;height:600px;");
                //window.open(fpath);
            }

            function OnAfterEdit_Argu() {
                if(grdControlsManageArgument.col == 2)
                    if (grdControlsManageArgument.GetGridData(grdControlsManageArgument.row, 2) != '') {
                        var old_str = grdControlsManageArgument.GetGridData(grdControlsManageArgument.row, 2);
                        var new_str = 'p_' + old_str.replace(/\s+/g, '_').replace(/[&\/\\#,+()$~%.'":*?<>{}]/g,'').toString().toLowerCase();
                        grdControlsManageArgument.SetGridText(grdControlsManageArgument.row, 3, new_str);
                    }
            }

            function OnNew_Grid() {
                var grid = grdControlsManageGrid.GetGridControl();
                grdControlsManageGrid.AddRow();
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 1, grid.Rows - 1);//seq
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 4, 0);
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 6, 2);
				grdControlsManageGrid.SetGridText(grid.Rows - 1, 7, 1000);//width
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 8, 1);
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 9, 1);
                //grdControlsManageGrid.SetGridText(grid.Rows - 1, 11, 1);
                grdControlsManageGrid.SetGridText(grid.Rows - 1, 12, 0);

                if (txtControlPk.text != "") {
                    grdControlsManageGrid.SetGridText(grid.Rows - 1, 15, txtControlPk.text);
                }
            }

            function OnSave_Grid() {
			    for(var i=1;i<grdControlsManageGrid.rows;i++){
					grdControlsManageGrid.SetGridText(i,1,i);
					if(grdControlsManageGrid.GetGridData(i,2)==""){
						alert("Please input column id at row "+ i +".");
						return;
					}
					if(grdControlsManageGrid.GetGridData(i,3)==""){
						alert("Please input column parameter  at row "+ i +".");
						return;
					}
				}
				//Insert Grid
				for (var j = 1; j < grdControlsManageGrid.rows; j++) {
//					if (grdControlsManageGrid.GetGridData(j, 15) == "") {
						grdControlsManageGrid.SetGridText(j, 15, txtControlPk.text);
//					}
				}
                data_grid.Call();
            }

            function OnDelete_Grid() {
                if (confirm('Are you sure to delete this Column?')) {
                    grdControlsManageGrid.DeleteRow();
                    data_grid.Call();
                }
            }

            function OnGet_Grid() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=grid";
				//window.open(fpath);
				System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
            }

            function OnAfterEdit_Grid() {
                if (grdControlsManageGrid.col == 2)
                    if (grdControlsManageGrid.GetGridData(grdControlsManageGrid.row, 2) != '') {
                        var old_str = grdControlsManageGrid.GetGridData(grdControlsManageGrid.row, 2);
                        var new_str = 'p_' + old_str.replace(/\s+/g, '_').replace(/[&\/\\#,+()$~%.'":*?<>{}]/g, '').toString().toLowerCase();
                        grdControlsManageGrid.SetGridText(grdControlsManageGrid.row, 3, new_str);
                    }
            }

            function OnEventRegister(obj) {
                var str = obj.id, id = 'txtGrid' + str.substring(7, str.length).toString();
                str = 'ongrid_' + str.substring(7, str.length).toLowerCase() + '(this);';
                var ctrl = document.getElementById(id);
                ctrl.text = (obj.value == 'T')?str:'';
            }

            function OnGet_Func() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=function";
                //window.open(fpath);
				System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
            } 

            function OnGet_Proc() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=procedure";
                //window.open(fpath);
				System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
            } 

            function OnGet_Cold() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=col_index";
                //window.open(fpath);
				System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
            }

            function OnGet_List() {
                var fpath = System.RootURL + "/form/sys/ab/controlsman_popup.aspx?dso_id=" + txtDataID.text + "&output_control=grid_list_html";
                //window.open(fpath);
				System.OpenModal(fpath, 600, 600, 'resizable:yes;status:yes');
            }

            function OnInitControl(obj_master) {
                var isbool = (obj_master.text != "");
                btnDeleteData.SetEnable(isbool);
                btnProcessFunc.SetEnable(isbool);
                btnProcessProc.SetEnable(isbool);

                btnProcessArgu.SetEnable(isbool);
                btnDeleteArgu.SetEnable(isbool);

                btnProcessGrid.SetEnable(isbool);
                btnDeleteGrid.SetEnable(isbool);
                btnProcessCold.SetEnable(isbool);
                btnProcessList.SetEnable(isbool);
            }

            function OnDataReceive(obj_dso) {
                switch (obj_dso.id) {
                    case "data_controls":

                        //Insert Grid Argument
                        for (var i = 1; i < grdControlsManageArgument.rows; i++) {
                            if (grdControlsManageArgument.GetGridData(i, 7) == "") {
                                grdControlsManageArgument.SetGridText(i, 7, txtControlPk.text);
                            }
                        }
                        //Insert Grid
                        for (var j = 1; j < grdControlsManageGrid.rows; j++) {
                            if (grdControlsManageGrid.GetGridData(i, 15) == "") {
                                grdControlsManageGrid.SetGridText(i, 15, txtControlPk.text);
                            }
                        }
                        
                        OnInitControl(txtControlPk);
                        data_argument.Call();
                        break;
                    case "data_argument":
						//Insert Grid
                        for (var j = 1; j < grdControlsManageGrid.rows; j++) {
                            if (grdControlsManageGrid.GetGridData(i, 15) == "") {
                                grdControlsManageGrid.SetGridText(i, 15, txtControlPk.text);
                            }
                        }
                        data_grid.Call();
                        break;
                }
            }
			function OnColMoveUp(){
				if(grdControlsManageGrid.row > 1){
					grdControlsManageGrid.UpRow();
				}	
				else{
					alert("Already at the top.");
				    return;
				}
			}
			function OnColMoveDown(){
				if( grdControlsManageGrid.row < grdControlsManageGrid.rows-1){
					grdControlsManageGrid.DownRow();
				}	
				else{
					alert("Already at the bottom.");
				    return;
				}
			}
        </script>
    </head>
    <body>
        <!------------------------DSO---------------------------->
        <gw:data id="data_controls" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso    type        ="control" 
                        parameter   ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38" 
                        function    ="gasp.sp_sel_ctrs_management" 
                        procedure   ="gasp.sp_upd_ctrs_management">
                    <inout>
                        <inout bind="txtControlPk" /> 
                        <inout bind="txtDataID" /> 
                        <inout bind="lstType" /> 
                        <inout bind="txtFunction" /> 
                        <inout bind="txtProcedure" />
                        <inout bind="txtOnReceive" />
                        <inout bind="txtOnError" />
                        <inout bind="txtDescription" />

                        <inout bind="txtGridID" />
                        <inout bind="chkGridDisplay" />
                        <inout bind="chkGridSort" />
                        <inout bind="chkGridAutosize" />
                        <inout bind="chkGridDeBug" />
                        <inout bind="txtGridWidth" />
                        <inout bind="txtGridHeight" /> 

                        <inout bind="chkGridCellClick" />
                        <inout bind="txtGridCellClick" />
                        <inout bind="chkGridCellDblClick" />
                        <inout bind="txtGridCellDblClick" />
                        <inout bind="chkGridEnterCell" />
                        <inout bind="txtGridEnterCell" />
                        <inout bind="chkGridSelChange" />
                        <inout bind="txtGridSelChange" />
                        <inout bind="chkGridBeforeEdit" />
                        <inout bind="txtGridBeforeEdit" />
                        <inout bind="chkGridAfterEdit" />
                        <inout bind="txtGridAfterEdit" />
                        <inout bind="chkGridBeforeSort" />
                        <inout bind="txtGridBeforeSort" />
                        <inout bind="chkGridAfterSort" />
                        <inout bind="txtGridAfterSort" />
                        <inout bind="chkGridKeyUpEdit" />
                        <inout bind="txtGridKeyUpEdit" />
                        <inout bind="chkGridKeyDownEdit" />
                        <inout bind="txtGridKeyDownEdit" />
                        <inout bind="chkGridKeyPressEdit" />
                        <inout bind="txtGridKeyPressEdit" />
                        <inout bind="chkGridAfterGrouping" />
                        <inout bind="txtGridAfterGrouping" />

                        <inout bind="lblCreateTime" />
                        <inout bind="lblCreateBy" />
                        <inout bind="lblModTime" />
                        <inout bind="lblModBy" />
                    </inout>
                </dso>
            </xml>
        </gw:data>

        <gw:data id="data_argument" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso type="grid" parameter="0,1,2,3,4,5,6,7" function="gasp.sp_sel_ctrs_management_arg" procedure="gasp.sp_upd_ctrs_management_arg" > 
                    <input bind="grdControlsManageArgument"> 
                        <input bind="txtControlPk" /> 
                    </input> 
                    <output bind="grdControlsManageArgument" /> 
                </dso> 
            </xml> 
        </gw:data> 

        <gw:data id="data_grid" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="gasp.sp_sel_ctrs_management_grid" procedure="gasp.sp_upd_ctrs_management_grid" > 
                    <input bind="grdControlsManageGrid"> 
                        <input bind="txtControlPk" /> 
                    </input> 
                    <output bind="grdControlsManageGrid" /> 
                </dso> 
            </xml> 
        </gw:data> 

        <gw:data id="data_search" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso type="grid" function="gasp.sp_sel_ctrs_management_search"> 
                    <input bind="grdControlsManageSearch"> 
                        <input bind="txtDataID_Search" /> 
                        <input bind="txtStoreFunc_Search" /> 
                        <input bind="lstType_Search" /> 
                    </input> 
                    <output bind="grdControlsManageSearch" /> 
                </dso> 
            </xml> 
        </gw:data> 
        <!------------------------HIDDEN CONTROLS---------------------------->
        <gw:textbox id="txtControlPk" styles="display:none" />
        <!------------------------HTML CONTENT---------------------------->
        <table cellpadding="0" cellspacing"0" style="width:100%;height:100%">
            <tr>
                <td valign="top" style="background-color:Gray;">
                    <table cellpadding="3" cellspacing="1" border="0" style="width:100%;height:100%">
                        <tr style="height:100%">
                            <td style="width:300px;background-color:White;" valign="top">
                                <table cellpadding="0" cellspacing"0" style="width:100%;">
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Data ID</td>
                                        <td style="width:100%" colspan="2"><gw:textbox id="txtDataID_Search"  styles='width:100%'  /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Proc/Func</td>
                                        <td colspan="2"><gw:textbox id="txtStoreFunc_Search"  styles='width:100%'  /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Data Type</td>
                                        <td style="width:100%"><gw:list id="lstType_Search" styles="width:100%;" /></td>
                                        <td style="width:1%"><gw:button id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" /></td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing"0" style="width:100%;height:100%">
                                    <tr>
                                        <td valign="top">
                                            <gw:grid id ='grdControlsManageSearch'      
                                                header  ='_PK_CONTROLS|DATA ID|DATA TYPE|PROCEDURE|FUNCTION'
                                                format  ='0|0|0|0|0'
                                                aligns  ='0|0|0|0|0'
                                                defaults='||||'
                                                editcol ='0|0|0|0|0'
                                                widths  ='0|2000|1200|2000|2000'
                                                sorting ='T'
                                                styles  ='width:100%; height:100%;'
                                                oncellclick = 'OnSelect_Data()'
                                                />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="background-color:White" valign="top">
                                <table cellpadding="0" cellspacing"0" style="width:100%;">
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Data ID</td>
                                        <td style="width:30%"><gw:textbox id="txtDataID"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Data Type</td>
                                        <td style="width:10%"><gw:list id="lstType" styles="width:100%;" /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Description</td>
                                        <td style="width:35%"><gw:textbox id="txtDescription"  styles='width:100%'  /></td>
                                        <td width="1%"><gw:button id="btnNewData" img="new" alt="New" text="New" onclick="OnNew_Data();" /></td>
                                        <td width="1%"><gw:button id="btnDeleteData" img="delete" alt="Delete" text="Delete" onclick="OnDelete_Data();" /></td>
                                        <td width="1%"><gw:button id="btnSaveData" img="save" alt="Save" text="Save" onclick="OnSave_Data();" /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Function</td>
                                        <td colspan="2"><gw:textbox id="txtFunction" styles='width:100%'  /></td>
                                        <td width="1%"><gw:button id="btnProcessFunc" img="popup" alt="Get Source" text="Source" onclick="OnGet_Func();" /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Procedure</td>
                                        <td style="width:20%" colspan="3"><gw:textbox id="txtProcedure"  styles='width:100%'  /></td>
                                        <td width="1%"><gw:button id="btnProcessProc" img="popup" alt="Get Source" text="Source" onclick="OnGet_Proc();" /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">OnReceive</td>
                                        <td colspan="3"><gw:textbox id="txtOnReceive"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">OnError</td>
                                        <td colspan="4"><gw:textbox id="txtOnError"  styles='width:100%'  /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Create Time</td>
                                        <td><gw:label id="lblCreateTime" styles='width:100%' /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Create By</td>
                                        <td><gw:label id="lblCreateBy" styles='width:100%' /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Mod Time</td>
                                        <td><gw:label id="lblModTime" styles='width:100%' /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">Mod By</td>
                                        <td colspan="2"><gw:label id="lblModBy" styles='width:100%' /></td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing"0" style="width:100%;height:30%">
                                    <tr style="height:22px">
                                        <td width="97%">&nbsp;</td>
                                        <td width="1%"><gw:button id="btnProcessArgu" img="popup" alt="Get Source" text="Source" onclick="OnGet_Argu();" /></td>
                                        <td width="1%"><gw:button id="btnNewArgu" img="new" alt="New" text="New" onclick="OnNew_Argu();" /></td>
                                        <td width="1%"><gw:button id="btnDeleteArgu" img="delete" alt="Delete" text="Delete" onclick="OnDelete_Argu();" /></td>
                                        <td width="1%"><gw:button id="btnSaveArgu" img="save" alt="Save" text="Save" onclick="OnSave_Argu();" /></td>
                                    </tr>
                                    <tr>
                                        <td valign="top" colspan="5">
                                            <gw:grid id ='grdControlsManageArgument'      
                                                header  ='_PK_ARGUMENT|SEQ|CONTROL ID|CONTROL PARAM|UPLOAD|TYPE|DESCRIPTION|_TES_DATA_CONTROL_PK'
                                                format  ='0|0|0|0|3|0|0|0'
                                                aligns  ='0|1|0|0|0|0|0|0'
                                                defaults='|||||||'
                                                editcol ='1|1|1|1|1|1|1|0'
                                                widths  ='0|500|2000|2000|1000|1000|2000|0'
                                                styles  ='width:100%; height:100%;'
                                                onafteredit = "OnAfterEdit_Argu()";
                                                />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing"0">
                                    <tr style="height:22px">
                                        <td colspan="12">
                                            <table cellpadding="0" cellspacing"0">
                                                <tr style="height:22px">
                                                    <td style="white-space:nowrap;padding-right:5px;" align="right">Grid ID</td>
                                                    <td style="width:150px"><gw:textbox id="txtGridID"  styles='width:100%'  /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Display</td>
                                                    <td><gw:checkbox id="chkGridDisplay" value="T" /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Sort</td>
                                                    <td><gw:checkbox id="chkGridSort" value="T" /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Autosize</td>
                                                    <td><gw:checkbox id="chkGridAutosize" value="T" /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Debug</td>
                                                    <td><gw:checkbox id="chkGridDeBug" value="F" /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Width</td>
                                                    <td style="width:68px"><gw:textbox id="txtGridWidth"  styles='width:100%'  /></td>
                                                    <td style="white-space:nowrap;padding-right:5px;padding-left:5px;" align="right">Height</td>
                                                    <td style="width:68px"><gw:textbox id="txtGridHeight"  styles='width:100%'  /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Cell Click</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridCellClick" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridCellClick"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Cell Dbl Click</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridCellDblClick" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridCellDblClick"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Enter Cell</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridEnterCell" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridEnterCell"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Select Change</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridSelChange" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridSelChange"  styles='width:100%'  /></td>
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Before Edit</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridBeforeEdit" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridBeforeEdit"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On After Edit</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridAfterEdit" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridAfterEdit"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On Before Sort</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridBeforeSort" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridBeforeSort"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On After Sort</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridAfterSort" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridAfterSort"  styles='width:100%'  /></td
                                    </tr>
                                    <tr style="height:22px">
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On KeyUp Edit</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridKeyUpEdit" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridKeyUpEdit"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On KeyDown Edit</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridKeyDownEdit" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridKeyDownEdit"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On KeyPress Edit</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridKeyPressEdit" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridKeyPressEdit"  styles='width:100%'  /></td>
                                        <td style="white-space:nowrap;padding-right:5px;" align="right">On After Grouping</td>
                                        <td style="width:10px"><gw:checkbox id="chkGridAfterGrouping" value="F" onchange="OnEventRegister(this);" /></td>
                                        <td style="width:120px"><gw:textbox id="txtGridAfterGrouping"  styles='width:100%'  /></td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing"0" style="width:100%;height:30%">
                                    <tr style="height:22px">
									    <td width="1%"><gw:button id="btnUp" img="up"  text="Move Up" onclick="OnColMoveUp();" /></td>
                                        <td width="1%"><gw:button id="btnDown" img="down"  text="Move Down" onclick="OnColMoveDown();" /></td>
                                        <td width="90%">&nbsp;</td>
                                        <td width="1%"><gw:button id="btnProcessList" img="popup" alt="Get Source" text="Column List" onclick="OnGet_List();" /></td>
                                        <td width="1%"><gw:button id="btnProcessCold" img="popup" alt="Get Source" text="Column Index" onclick="OnGet_Cold();" /></td>
                                        <td width="1%"><gw:button id="btnProcessGrid" img="popup" alt="Get Source" text="Source" onclick="OnGet_Grid();" /></td>
                                        <td width="1%"><gw:button id="btnNewGrid" img="new" alt="New" text="New" onclick="OnNew_Grid()" /></td>
                                        <td width="1%"><gw:button id="btnDeleteGrid" img="delete" alt="Delete" text="Delete" onclick="OnDelete_Grid()" /></td>
                                        <td width="1%"><gw:button id="btnSaveGrid" img="save" alt="Save" text="Save" onclick="OnSave_Grid()" /></td>
                                    </tr>
                                    <tr>
                                        <td valign="top" colspan="9">
                                            <gw:grid id ='grdControlsManageGrid'      
                                                header  ='_PK_GRID|SEQ|COL ID|COL PARAM|FORMAT|DEFAULTS|ALIGN|WIDTH|EDIT|UPLOAD|CHECK|HIDDEN|SUM|SQL FOR LISTBOX|DESCRIPTION|TES_DATA_CONTROL_PK'
                                                format  ='0|0|0|0|0|0|0|-0|3|3|0|3|3|0|0|0'
                                                aligns  ='0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                defaults='|||||||||||||||'
                                                editcol ='1|0|1|1|1|1|1|1|1|1|0|1|1|1|1|0'
                                                widths  ='0|500|2000|2000|2000|1000|1000|1000|1000|1000|1000|1000|1000|2000|2000|0'
                                                sorting ='T' autosize="true"
                                                styles  ='width:100%; height:100%;'
                                                onafteredit = "OnAfterEdit_Grid()";
                                                />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>