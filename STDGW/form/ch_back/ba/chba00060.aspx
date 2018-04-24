<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
    var strcodereturn;
    var user;
    var flag_header = true;
    var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit() {
    if (v_language != "ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    user = "<%=session("USER_ID")%>";
    grdShortTermAbs.GetGridControl().FrozenCols = 7;
    grdShortTermAbs.GetGridControl().ScrollTrack = true;
    grdLongTermAbs.GetGridControl().ScrollTrack = true;
    grdAbs.GetGridControl().ScrollTrack = true;
    //grdDetailAbs.GetGridControl().ScrollTrack=true;
    txtDay.SetEnable(false);
    lstValue.SetEnable(false);
    //grdDetail.GetGridControl().FrozenCols =4;
    //grdDetail.GetGridControl().ScrollTrack=true;
    ChangeColorItem(lstOrg.GetControl());
    //ChangeColorItem(lstOrg2.GetControl());
    //SetGridHeader(grdDetail);
    if ((Trim(iduser_pk.text) != "") && (txtHr_level.text == "1")) //QUYEN BI GIOI HAN 
    {
        datUser_info.Call();
    }
    else
        onChange_org();
}

//-----------------------------------------------
function ChangeColorItem(lstctl) {
    var slevel1, slevel2, slevel3, slevel4;
    for (var i = 0; i < lstctl.options.length; i++) {
        slevel1 = lstctl.options.item(i).text.substr(0, 1);
        slevel2 = lstctl.options.item(i).text.substr(0, 3);
        slevel3 = lstctl.options.item(i).text.substr(0, 5);
        slevel4 = lstctl.options.item(i).text.substr(0, 7);
        if (slevel4 != ".......") {
            if (slevel3 == ".....") {
                lstctl.options.item(i).style.color = "0066CC";
            }
            else {
                if (slevel2 == "...") {
                    lstctl.options.item(i).style.color = "FF4500";
                }
                else {
                    if (slevel1 == ".")
                        lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                }
            }
        }
    }
}

//---------------------------------------------------------------------------
//Merge Header
/*
function SetGridHeader(obj)
{
var stt;
var fg = obj.GetGridControl();

if (flag_header==true)
{
    fg.rows=fg.rows+1;
    flag_header=false;
}

fg.FixedRows = 2;
fg.FixCols = 1;
fg.MergeCells = 5;
stt = 0;    //num column
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "Organization";  //fg.Cell(CellPropertySettings,row, from_col, row, to_col)	

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "Work Group";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "Emp ID";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "Full Name";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "Join Date";

fg.MergeRow(0) =true	;
stt+=1;

fg.Cell(0, 0, stt, 0, stt+6)  = "Absence Regulation";   
//obj.SetCellBgColor(0, stt,0, stt+5, 0x99FF99);
//obj.SetCellBgColor(1, stt,1, stt+5, 0x99FF99);

fg.Cell(0,1,stt,1,stt) = "Annual";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Wedding";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Funeral";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Labour Accident";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Compensation";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Other";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "_Total Regulation";

fg.MergeRow(0) =true	;
stt+=1;

fg.Cell(0, 0, stt, 0, stt+2)  = "Absence Non Permission";   
//obj.SetCellBgColor(0, stt,0, stt+2, 0x99FF99);
//obj.SetCellBgColor(1, stt,1, stt+2, 0x99FF99);

fg.Cell(0,1,stt,1,stt) = "Non Scan";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Non Permission";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "_Total Non Permission";

fg.MergeRow(0) =true	;
stt+=1;
fg.Cell(0, 0, stt, 0, stt+10)  = "Absence Permission";   
//obj.SetCellBgColor(0, stt,0, stt+10, 0x99FF99);
//obj.SetCellBgColor(1, stt,1, stt+10, 0x99FF99);

fg.Cell(0,1,stt,1,stt) = "Unpaid";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "In Schedule";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Maternity";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Sick";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Sick children";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Preg. Test";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Miscarriage";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Save Health";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Family planning";

stt+=1;
fg.Cell(0,1,stt,1,stt) = "Other";

stt+=1;
fg.MergeCol(stt) = true;
fg.Cell(0,0,stt,1,stt) = "_Total Permission";

obj.SetCellBold(1,0,1,stt,true);
obj.SetCellBold(0,0,1,stt,true);
fg.FontSize=9;
}
*/
//-------------------------------------------------
function OnShowPopup() {
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj != null) {
        lstOrg.value = obj
        //txtUpperDept.text=obj;
        onChange_org();
    }

}
//----------------------------------------------------
function ChoseList_box(obj_list, value) {
    obj_list.SetDataText(value);
    obj = obj_list.GetControl()
    if (obj.options.length == 2)
        obj.options.selectedIndex = 0;
    else
        obj.options.selectedIndex = obj.options.length - 1;
}
//----------------------------------------------
function OnDataReceive(obj) {
    if (obj.id == "datDeptData") {
        if (txtHr_level.text == "6")
            txtDeptData.text = txtDeptData.text + "|ALL|Select All";
        lstOrg.SetDataText(txtDeptData.text);

        obj = lstOrg.GetControl()
        if (obj.options.length == 2)
            obj.options.selectedIndex = 0;
        else
            obj.options.selectedIndex = 0;
        //datGroupData.Call();
    }
    else if (obj.id == "datGroupData") {
        ChoseList_box(lstWG, txtGroupData.text)

    }
    else if (obj.id == "datShortTermAbsSum") {
        lblRecord.text = grdShortTermAbs.rows - 1 + " record(s).";
        auto_resize_column(grdShortTermAbs, 0, grdShortTermAbs.cols - 1, 0)
        //SetColor(grdShortTermAbs,5);   
    }
    else if (obj.id == "datLongTermAbsSum") {
        lblRecord.text = grdLongTermAbs.rows - 1 + " record(s).";
        auto_resize_column(grdLongTermAbs, 0, grdLongTermAbs.cols - 1, 0)
        for (var i = 1; i < grdLongTermAbs.rows; i++) {
            if (grdLongTermAbs.GetGridData(i, 9) != "" && grdLongTermAbs.GetGridData(i, 9) != grdLongTermAbs.GetGridData(i, 6))
                grdLongTermAbs.SetCellBgColor(i, 6, i, 9, 0xccffff);
        }
        //SetColor(grdLongTermAbs,4); 
    }
    else if (obj.id == "datAbsSum") {
        lblRecord.text = grdAbs.rows - 1 + " record(s).";
        //SetColor(grdAbs,4); 
    }
    else if (obj.id == "datUser_info") {
        ChangeColorItem(lstOrg.GetControl());
        //ChangeColorItem(lstOrg2.GetControl());
        datWorkGroup_info.Call();
    }
    else if (obj.id == "datWorkGroup_info") {

        lstWG.SetDataText(txtwg_tmp.text + '|ALL|Select All');
        lstWG.value = 'ALL';

    }
    /*
else if (obj.id=="datSummaryDetail")
{
     lblRecord2.text=grdDetail.rows-2 + " record(s).";
     SetGridHeader(grdDetail);
     auto_resize_column(grdDetail,0,grdDetail.cols-1,0)
}    */
}

//------------------------------------------------
function OnChangeDept() {
    txtDept.text = lstOrg.value;
    //datGroupData.Call();
}
//----------------------------------------------------
function OnSearch() {
    if (txtOption.text == 1)
        datShortTermAbsSum.Call("SELECT");
    else if (txtOption.text == 2)
        datLongTermAbsSum.Call("SELECT");
    else
        datAbsSum.Call("SELECT");
}
//-----------------------------------------------
function OnReport() {
    if (txtOption.text == 1) {
        var url = System.RootURL + '/reports/ch/ba/rpt_short_term_absence.aspx?p_user=' + user + '&p_tco_org_pk=' + lstOrg.value + '&p_wg=' + lstWG.value + '&p_nation_type=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_absence_type=' + lstAbs_Type.value + '&p_absence_type_text=' + lstAbs_Type.GetText();
        url = url + '&p_print_type=' + lstPrint_Type.value + '&p_shift=' + lstShift.value + '&p_from_date=' + dtFrom_AbsDate.value + '&p_to_date=' + dtTo_AbsDate.value + '&p_from_date_text=' + dtFrom_AbsDate.text + '&p_to_date_text=' + dtTo_AbsDate.text + '&p_emp_type=' + lstEmp_Type.value;
    }
    else if (txtOption.text == 2) {
        var url = System.RootURL + '/reports/ch/ba/rpt_long_term_absence.aspx?p_user=' + user + '&p_tco_org_pk=' + lstOrg.value + '&p_wg=' + lstWG.value + '&p_nation_type=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_absence_type=' + lstAbs_Type.value + '&p_absence_type_text=' + lstAbs_Type.GetText();
        url = url + '&p_print_type=' + lstPrint_Type.value + '&p_from_date=' + dtFrom_AbsDate.value + '&p_to_date=' + dtTo_AbsDate.value + '&p_from_date_text=' + dtFrom_AbsDate.text + '&p_to_date_text=' + dtTo_AbsDate.text + '&p_emp_type=' + lstEmp_Type.value;
    }
    else {
        var url = System.RootURL + '/reports/ch/ba/rpt_absence_summary.aspx?p_user=' + user + '&p_tco_org_pk=' + lstOrg.value + '&p_wg=' + lstWG.value + '&p_nation_type=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_absence_type=' + lstAbs_Type.value + '&p_absence_type_text=' + lstAbs_Type.GetText();
        url = url + '&p_print_type=' + lstPrint_Type.value + '&p_from_date=' + dtFrom_AbsDate.value + '&p_to_date=' + dtTo_AbsDate.value + '&p_from_date_text=' + dtFrom_AbsDate.text + '&p_to_date_text=' + dtTo_AbsDate.text + '&p_days=' + txtDay.text + '&p_emp_type=' + lstEmp_Type.value + '&p_value=' + lstValue.value;
    }
    window.open(url);
}
//-----------------------------------------------------
function SelectOption(obj, grdObj) {
    txtOption.text = obj;
    grdLongTermAbs.ClearData();
    grdShortTermAbs.ClearData();
    grdAbs.ClearData();
    grdShortTermAbs.style.display = "none";
    grdLongTermAbs.style.display = "none";
    grdAbs.style.display = "none";
    grdObj.style.display = "";
    lblRecord.text = "0 record(s).";
    if (obj == 1) //short term
        lstShift.SetEnable(true);
    else
        lstShift.SetEnable(false);
    if (obj != 3) //short term
    {
        txtDay.SetEnable(false);
        lstValue.SetEnable(false);
        ibtnDetPrinter.SetEnable(true);

        if (imgMaster.status == "expand") {
            OnToggle(true);
        }
    }
    else {
        txtDay.SetEnable(true);
        txtDay.GetControl().focus;
        lstValue.SetEnable(true);
    }
}

//--------------------------------------------------------
function ShowAbs(grdObj, colObj, colabs) {
    var col = event.col;
    if (col == colObj) {
        var abs_code, flag;
        abs_code = grdObj.GetGridData(event.row, colabs);
        flag = 0;
        var fpath = System.RootURL + "/form/ch/ba/chba00020_03.aspx?abs_code=" + abs_code + "&flag=" + flag;
        var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');


    }
}
//----------------------------------------
function SetColor(grdObj, colObj) {
    if (grdObj.rows > 1)
        grdObj.SetCellBgColor(1, colObj, grdObj.rows - 1, colObj, 0xccffff);
}
//-----------------------------------------
function OnToggle(flag) {
    if (txtOption.text == 3 || flag == true) {
        if (imgMaster.status == "expand") {
            tdDetail.style.display = "none";
            imgMaster.status = "collapse";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
            imgMaster.alt = "Show detail"

        }
        else {
            tdDetail.style.display = "";
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
            imgMaster.alt = "Close detail"

        }
    }
}
//-----------------------------------------
function ShowDetail() {
    var row;
    row = event.row;
    txtEmp_PK.text = grdAbs.GetGridData(row, 10);
    txtAbsence_Code.text = grdAbs.GetGridData(row, 9);
    txtFromDate.text = grdAbs.GetGridData(row, 5);
    txtToDate.text = grdAbs.GetGridData(row, 6);
    datDetailAbs.Call("SELECT");
}
function auto_resize_column(obj, col1, col2, font_size) {
    if (font_size != 0)
        obj.GetGridControl().FontSize = font_size;
    obj.GetGridControl().AutoSize(col1, col2, false, 0);
}

function onChange_org() {
    datWorkGroup_info.Call();
}

/*
function Popup()
{
    var flag, col, abs_type;
    col = event.col
    var abs_other;
    switch(col)
    {
        case 5:     //annual leave
            flag = "Annual Leave";
            abs_type = "01";
            break;
        case 6:     //Wedding leave
            flag = "Wedding Leave";
            abs_type = "08";
            break;
        case 7:     //Funeral leave
            flag = "Funeral Leave";
            abs_type = "02";    
            break;
        case 8:     
            flag = "Labour Accident";
            abs_type = "09";
            break;
        case 9:     
            flag = "Compensation";
            abs_type = "14";
            break;
        case 10:     
            flag = "Other company pay";
            abs_type = "other_com_pay";
            break;
        case 12:     
            flag = "Non Scan Time Card";
            abs_type = "13";
            break;
        case 13:     
            flag = "Non Permission Leave";
            abs_type = "05";
            break;
        case 15:     
            flag = "Unpaid Leave";
            abs_type = "19";
            break;
        case 16:     
            flag = "Absence In Schedule";
            abs_type = "17";
            break;
        case 17:     
            flag = "Maternity";
            abs_type = "04";
            break;
        case 18:     
            flag = "Sick Leave";
            abs_type = "07";
            break;
        case 19:     
            flag = "Sick Children Leave";
            abs_type = "06";
            break;
        case 20:     
            flag = "Pregnancy Test Leave";
            abs_type = "03";
            break;
        case 21:     
            flag = "Miscarriage Leave";
            abs_type = "10";
            break;
        case 22:     
            flag = "Save Health";
            abs_type = "15";
            break;
        case 23:     
            flag = "Family Health";
            abs_type = "16";
            break;
        case 24:     
            flag = "Other Permission Leave";
            abs_type = "other_per";
            break;
    }
    
    var fpath = System.RootURL + "/form/ch/ba/chba00060_01.aspx?l_emp_pk=" + grdDetail.GetGridData(event.row,26) + "&l_from_dt=" + txtTemp1.text + "&l_to_dt=" + txtTemp2.text + "&l_flag=" + flag + "&l_abs_type=" + abs_type;
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:35;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
}
*/
</script>
<body >
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->

<!--------------------------------------------------------------->
<gw:data id="datShortTermAbsSum" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10020006_short_abs_sum" > 
                <input bind="grdShortTermAbs">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="lstNation" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstAbs_Type" /> 
                    <input bind="lstPrint_Type" /> 
                    <input bind="lstShift" /> 
                    <input bind="dtFrom_AbsDate" />
                    <input bind="dtTo_AbsDate" />
                    <input bind="lstEmp_Type" />
                </input> 
                <output bind="grdShortTermAbs"/>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------->
<gw:data id="datLongTermAbsSum" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10020006_long_abs_sum" > 
                <input bind="grdLongTermAbs">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="lstNation" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstAbs_Type" /> 
                    <input bind="lstPrint_Type" /> 
                    <input bind="dtFrom_AbsDate" />
                    <input bind="dtTo_AbsDate" />
                    <input bind="lstEmp_Type" />
                </input> 
                <output bind="grdLongTermAbs"/>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------->
<gw:data id="datAbsSum" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10020006_abs_sum" > 
                <input bind="grdAbs">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="lstNation" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstAbs_Type" /> 
                    <input bind="lstPrint_Type" /> 
                    <input bind="dtFrom_AbsDate" />
                    <input bind="dtTo_AbsDate" />
                    <input bind="txtDay" />
                    <input bind="lstValue" />
                    <input bind="lstEmp_Type" />
                </input> 
                <output bind="grdAbs"/>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------->
<gw:data id="datDetailAbs" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10020006_detail_abs" > 
                <input bind="grdDetailAbs">
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtAbsence_Code" /> 
                    <input bind="txtFromDate" /> 
                    <input bind="txtToDate" /> 
                    <input bind="lstEmp_Type" />
                </input> 
                <output bind="grdDetailAbs"/>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--
<gw:data id="datSummaryDetail" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="sp_sel_10020006_sum_detail_abs" > 
                <input bind="grdDetailAbs">
                    <input bind="txtTemp1" /> 
                    <input bind="txtTemp2" /> 
                    <input bind="lstOrg2" /> 
                    <input bind="lstWG2" /> 
                    <input bind="lstTemp2" /> 
                    <input bind="txtSeach2" />
                    <input bind="lstStatus2" />
                    <input bind="lstNation2" />
                    <input bind="lstKind2" />
                    <input bind="lstVal2" />
                    <input bind="txtVal2" />
                </input> 
                <output bind="grdDetail"/>
            </dso> 
        </xml> 
</gw:data>
    -->
<!-------------------data control----------------------->
<!-- <gw:tab id="tabMain" border=1 style="width:100%;height:100%;"  >       -->
   <table name="Summary" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="7%" style="border:0;" align="right" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td width="21%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="6%" style="border:0;" align="right" >WGroup</td>
                        <td width="10%" style="border:0;" align="left" >
                         <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0" )%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                         <td width="4%" style="border:0;" align="right" >Nation</td>
                        <td width="8%" style="border:0;" align="left" >
                         <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                       <td  width="9%" style="border:0" align="right" valign="middle">Search by</td>
					    <td  width="10%" style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="11%" colspan=2 style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
                        <td width="4%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnDetPrinter"    alt="Detail Report"  onclick="OnReport()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Abs Type</td>
					    <td  style="border:0">
					        <gw:list  id="lstAbs_Type" value="ALL" styles='width:100%' onchange=""> 
							        <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0003' order by code_nm")%>|ALL|Select All</data>
					        </gw:list>
				        </td>
                        <td  style="border:0" align="right">Print Type</td>
                        <td  style="border:0">
					        <gw:list  id="lstPrint_Type" value="ALL" styles='width:100%' onchange=""> 
							        <data>|1|Pay(Company)|2|UnPay(Company)|3|Pay(Insurance)|4|Unpay(Insurance)|5|Permission|6|Non Permission|ALL|Select All</data>
					        </gw:list>
				        </td>
                         <td style="border:0;" align="right" >Shift</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstShift" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>|1|Normal|0|Normal + Night|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0;" align="right">Absence Date</td>
				        <td  style="border:0;"><gw:datebox id="dtFrom_AbsDate"  styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center"><b>~</b></td>
				        <td  style="border:0;"><gw:datebox id="dtTo_AbsDate"  styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td   style="border:0" align="right" colspan=3><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0;" align="right">Emp Type</td>
                        <td  style="border:0">
					        <gw:list  id="lstEmp_Type" value="ALL" styles='width:100%' onchange=""> 
							        <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0017' order by code_nm")%>|ALL|Select All</data>
					        </gw:list>
				        </td>
                        <td   colspan=2 style="border:0" align="right" >
                        <input type="radio"  id="optAbs1" name="option" value="1" checked onclick="SelectOption(1, grdShortTermAbs)" /><font size="2" color="green" >Short Term</font>
                        </td>
                        <td  colspan=2 style="border:0" align="center"> 
					       <input type="radio"  id="optAbs2"  name="option" value="2" onclick="SelectOption(2, grdLongTermAbs)"/><font size="2" color="green" >Long Term</font>
				        </td>
				        <td  colspan=2 style="border:0" align="left"> 
					       <input type="radio"  id="optAbs3"  name="option" value="3" onclick="SelectOption(3, grdAbs)"/><font size="2" color="green" >Summary Absence</font>
				        </td>
				        <td  colspan=2  style="border:0" align="right" >Absence Days</td>
                        <td  style="border:0;" align="center" >
                         <gw:list  id="lstValue" value='>=' maxlen = "100" styles='width:90%' >
                            <data>|>|>|<|<|=|=|>=|>=|<=|<=</data></gw:list>
                        </td>
                         <td  style="border:0" > 
					        <gw:textbox id="txtDay"  onenterkey   ="OnSearch()" type="number" format="##.#R" styles='width:100%' csstype="filter"/>
				        </td>
				        <td style="border:0"  align="right" valign="bottom"><img status="collapse" id="imgMaster" alt="Show detail" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle(false)"  /> </td>
                    </tr>
                    <tr style="border:0;width:100%;height:80%" valign="top">
                        <td colspan=14 style="width:100%;height:100%;border:0"> 
                            <table style="width:100%;height:100%;" border=1 cellpadding="0" cellspacing="0">
                                <tr style="width:100%;height:100%;">
                                    <td id="tdMaster" style="width:70%;height:100%;">
                                        <gw:grid   
					                        id="grdShortTermAbs"  
					                        header="Organization|Work Group|Emp ID|Full Name|Work Shift|Absence Type|Absent Date|Description|Absence Time|Company Pay Flag|Company Pay Rate|Insurance Pay Flag|Insurance Pay Rate|_Absence_Code|Remark"   
				                            format="0|0|0|0|0|0|4|0|0|3|0|3|0|0|0"  
				                            aligns="0|0|1|0|0|0|0|0|1|1|1|0|1|0|0"  
				                            defaults="|||||||||||||||"  
				                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				                            widths="1300|1500|900|2300|1500|2000|1200|2000|1400|1800|1800|1800|1800|1500|0|0"  
				                            styles="width:100%; height:100%"   
				                            acceptnulldate
				                            sorting="T"    oncelldblclick="ShowAbs(grdShortTermAbs,5,13)"
				                             /> 
				                         <gw:grid   
					                        id="grdLongTermAbs"  
					                        header="Organization|Work Group|Emp ID|Full Name|Absence Type|From Date|To Date|Description|_Absence_Code|Date(2)"   
				                            format="0|0|0|0|2|4|4|0|0|4"  
				                            aligns="0|0|1|0|0|0|0|0|0|0"  
				                            defaults="|||||||||"  
				                            editcol="0|0|0|0|0|0|0|0|0|0"  
				                            widths="1500|1500|1400|2300|2000|1200|1200|2000|1400|1500"  
				                            styles="width:100%; height:100%" 
				                            acceptnulldate  
				                            sorting="T" style="display:none" oncelldblclick="ShowAbs(grdLongTermAbs,4,8)"
				                             /> 
				                          <gw:grid   
					                        id="grdAbs"  
					                        header="Organization|Work Group|Emp ID|Full Name|Absence Type|From Date|To Date|_Description|Days|_Absence_Code|_Emp_PK"   
				                            format="0|0|0|0|2|4|4|0|0|0|0"  
				                            aligns="0|0|1|0|0|0|0|0|0|0|0"  
				                            defaults="|||||||||||"  
				                            editcol="0|0|0|0|0|0|0|0|0|0|0|0"  
				                            widths="1500|1500|1400|2300|2000|1200|1200|2000|1400|1000|0|0"  
				                            styles="width:100%; height:100%"  
				                            acceptnulldate 
				                            sorting="T" style="display:none" oncelldblclick="ShowAbs(grdAbs,4,9)" oncellclick="ShowDetail()"
				                             /> 
                                    </td>
                                    <td id="tdDetail" style="width:30%;height:100%;display:none">
                                        <gw:grid   
					                        id="grdDetailAbs"  
					                        header="_Absence Type|Absent Date|Description|Absence Time|Company Pay Flag|Company Pay Rate|Insurance Pay Flag|Insurance Pay Rate"   
				                            format="0|4|0|0|3|0|3|0"  
				                            aligns="0|0|0|1|1|1|0|1"  
				                            defaults="||||||||"  
				                            editcol="0|0|0|0|0|0|0|0"  
				                            widths="2000|1200|2000|1400|1800|1800|1800|1800|1500"  
				                            styles="width:100%; height:100%"  
				                            acceptnulldate 
				                            sorting="T"  
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
<!--
    <table name="Detail" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                    <tr width="100%">
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
						<td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td><td colspan=1 width="1%"></td>
					</tr>
                    <tr style="width:100%;height:6%" valign="center" >
					    <td colspan="5" align="right"><input type="radio" id="Radio2" checked name="option_P" value="3" onclick="OnOption(option_P,1,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Month</font></strong></td>					
					    <td colspan="7" align="Left">
								    <gw:datebox styles="width:50%" lang="<%=Session("Lang")%>"  id="dtMonth" type="month">
						</gw:datebox>
					    </td>
					    
					    <td colspan="3" align=right><input type="radio"  id="Radio1" name="option_P" value="2" onclick="OnOption(option_P,2,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Quarter</font></strong></td>					
					    <td  colspan="4" align="center" valign="top">
								    <gw:list id="lstQuarter" styles="width:100%">
										    <data>DATA|I|Quý I|II|Quý II|III|Quý III|IV|Quý IV</data>
								    </gw:list>
					    </td>
					    <td colspan="2" align="right"><strong><font color="#000000">Year</font></strong></td>
					    <td colspan="4"  align="left">
							    <gw:datebox lang="<%=Session("Lang")%>"  id="dtYear" styles="width:50%" type="year">
							    </gw:datebox>
					    </td>
					    <td colspan="4" align="right"><input type="radio"  id="idOption" name="option_P" value="1" onclick="OnOption(option_P,3,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Date</font></strong></td>
					    <td colspan="5" align="right" >
								    <gw:datebox styles="width:60%" lang="<%=Session("Lang")%>"  id="dtFromDate" type="date">
								    </gw:datebox>
					    </td>
					    <td align="center"><strong><font color="#000000"> ~ </font></strong></td>
					    <td colspan="5"><gw:datebox styles="width:60%" lang="<%=Session("Lang")%>"  id="dtToDate" type="date">
								    </gw:datebox>
					    </td>
                        <td colspan=3 style="border:0;" align="right" >Status</td>
                        <td colspan=4 style="border:0;" align="left" >
                         <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td width="1%" style="border:0;" align="right" ></td>
					    <td width="2%" style="border:0;" align="center" >
                         <gw:imgBtn img="search" id="ibtnSearch2"   alt="Search"  onclick="OnSearch(2)"/>
                        </td>
                        <td width="1%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnDetPrinter2"    alt="Detail Report"  onclick="OnReport(2)"/>
                        </td>							
				    </tr>
                    <tr style="border:0;width:100%;height:6%" valign="center" >
                        <td colspan=5 style="border:0;" align="right" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td colspan=7 style="border:0;" align="left" >
                         <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=3 style="border:0;" align="right" >WGroup</td>
                        <td colspan=6 style="border:0;" align="left" >
                         <gw:list  id="lstWG2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0" )%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        <td colspan=3 style="border:0;" align="right" >Nation</td>
                        <td colspan=5 style="border:0;" align="left" >
                         <gw:list  id="lstNation2" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=4 style="border:0" align="right" valign="middle">Search by</td>
					    <td  colspan=4 style="border:0">
					        <gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td colspan=5 style="border:0"> 
					        <gw:textbox id="txtSeach2" onenterkey   ="OnSearch(2)" styles='width:100%'/>
				        </td>
                        <td colspan=8 style="border:0;" align="right" ><gw:label id="lblRecord2"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                    </tr>
                    <tr style="border:0;width:100%;height:6%" valign="center" >
                        <td colspan=5 style="border:0;" align="right" >Total Absence</td>
                        <td colspan=7 style="border:0;" align="left" >
                         <gw:list  id="lstKind2" value='1' maxlen = "100" styles='width:100%'onchange="" >
                            <data>LIST|1|Absence Regulation|2|Absence Non Permission|3|Absence Permission</data>
                        </gw:list>
                        </td>
                        <td colspan=3 style="border:0;" align="right" >
                            <gw:list  id="lstVal2" value='' maxlen = "100" styles='width:100%'onchange="" >
                                <data>LIST|=|=|>=|>=|<=|<=</data>
                            </gw:list></td>
                        <td colspan=2 style="border:0;" align="left" >
                            <gw:textbox id="txtVal2" styles='width:100%'/>
                        </td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:82%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;">
                            <gw:grid   
					            id="grdDetail"  
					            header="Organization|Work Group|Emp ID|Full Name|Join DT|Abs1|Abs2|Abs3|Abs4|Abs5|Abs6|_Abs7|Abs8|Abs9|_Abs10|Abs11|Abs12|Abs13|Abs14|Abs15|Abs16|Abs17|Abs18|abs19|abs20|_abs21|_emp_pk"   
				                format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				                aligns="0|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
				                defaults="|||||||||||||||||||||||||||"  
				                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				                widths="1300|1500|900|2300|1500|1000|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|1300|0"  
				                styles="width:100%; height:100%"   
				                acceptnulldate
				                sorting="T"    oncelldblclick="Popup()"
				                    /> 
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>
    </table>
</gw:tab>

    -->
</body>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtOption" text="1" styles="display:none"/> 
<gw:textbox id="txtEmp_PK"  styles="display:none"/> 
<gw:textbox id="txtAbsence_Code"  styles="display:none"/> 
<gw:textbox id="txtFromDate"  styles="display:none"/> 
<gw:textbox id="txtToDate"  styles="display:none"/> 
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="txtTemp1" styles="display:none"/>
<gw:textbox id="txtTemp2" styles="display:none"/>      
</html>
