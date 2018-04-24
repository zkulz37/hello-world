<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
    //_pk|_pk_master|Select|Organization|EMP ID|EMP Name|Position|Evaluation Group| 1st Reviewer|Eva. 1|2nd Reviewer|Eva. 2|_THR_EVA_GROUP_PK|_THR_EMP_PK|_TCO_DEPT_PK|_manager_pk1|_manager_pk2|_position_id|Eva Emp Status|_gradetype
    //_pk|_pk_master|Select|Organization|Employee ID|Employee Name|Position|Eva Group| 1st Reviewer|Eva. Grade 1|2nd Reviewer|Eva. Grade 2|_THR_EVA_GROUP_PK|_THR_EMP_PK|_TCO_DEPT_PK|_manager_pk1|_manager_pk2|_position_id|Eva Emp Status|_gradetype
    var flag = '';
    var stt = 0;
    var c_pk = stt++;
    var c_pk_master = stt++;
    var c_select = stt++;
    var c_org = stt++;
    var c_emp_id = stt++;
    var c_emp_name = stt++;
    var c_pos = stt++;
    var c_eva_group = stt++;
    var c_manager_l1 = stt++;
    var c_grade_l1_yn = stt++;
    var c_manager_l2 = stt++;
    var c_grade_l2_yn = stt++;
    var c_manager_l3 = stt++;
    var c_grade_l3_yn = stt++;
    var c_eva_group_pk = stt++;
    var c_emp_pk = stt++;
    var c_org_pk = stt++;
    var c_manager_l1_pk = stt++;
    var c_manager_l2_pk = stt++;
    var c_manager_l3_pk = stt++;
    var c_pos_id = stt++;
    var c_eva_emp_status = stt++;
    var c_confirm_yn = stt++;
    var c_grade_type = stt++;

    var check_init = 0;

function BodyInit()
{
     
    var ls_data;
	System.Translate(document);
	txtEMP_NM.SetEnable(false);
	 //btnCancel.SetEnable(false);
    txtchk.SetDataText("0");
    txtCompany_pk.text = "<%=session("COMPANY_PK")%>";

    grdDetail.GetGridControl().FrozenCols = 6;
    grdDetail.GetGridControl().ScrollTrack = true;
    
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 order by  EVA_YYYY ||' - ' || EVA_SEQ desc")%>";
    lstYear.SetDataText(ls_data);
    
    <%=ESysLib.SetGridColumnComboFormat("grdDetail", 9, "SELECT 'Y', 'Y' FROM dual union SELECT 'N', 'N' FROM dual")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdDetail" , 11, "SELECT 'Y', 'Y' FROM dual union SELECT 'N', 'N' FROM dual")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdDetail" , 13, "SELECT 'Y', 'Y' FROM dual union SELECT 'N', 'N' FROM dual")%>;
    ls_data ="<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0103' order by code_nm" ) %>  ";
    lstStatus.SetDataText(ls_data);
    lstStatus.SetDataText(ls_data+ "|%|Select ALL");
    lstStatus.SetDataText("%");

    ls_data = "DATA|1|Reviewer 1st|2|Reviewer 2nd|3|Reviewer 3rd";
    lstReviewer.SetDataText(ls_data);
    ls_data = "DATA|1|Grade 1st|2|Grade 2nd|3|Grade 3rd";
    lstGrade.SetDataText(ls_data);
    txtReviewer.SetEnable(0);

    datchem00050_1.Call();
}
//--------------------------------------------------------------------------------------------
    function button_click(index) {
        if (check_init == 1) {
            switch (index) {
                case 0://NEW EMPLOYEE for Evaluation Group
                    var fpath = System.RootURL + "/form/ch/em/chem00050_1_v2.aspx?eva_no=" + lstYear.GetData();
                    oValue = System.OpenModal(fpath, 1000, 700, 'resizable:yes;status:yes');
                    if (oValue != null) {
                        //alert(oValue.length);
                        grdDetail.SetData("");
                        for (var i = 0; i < oValue.length; i++) {
                            var aValue = oValue[i];
                            aValue = oValue[i];
                            grdDetail.AddRow();
                            grdDetail.SetGridText(grdDetail.rows - 1, c_emp_id, aValue[2]); // 4.EMP ID
                            grdDetail.SetGridText(grdDetail.rows - 1, c_emp_name, aValue[3]); //5.EMP Name
                            grdDetail.SetGridText(grdDetail.rows - 1, c_pos, aValue[4]); //6.Position
                            grdDetail.SetGridText(grdDetail.rows - 1, c_emp_pk, aValue[1]); //13.THR_EMP_PK
                            grdDetail.SetGridText(grdDetail.rows - 1, c_emp_pk, aValue[1]); //13.THR_EMP_PK 
                            grdDetail.SetGridText(grdDetail.rows - 1, c_org_pk, aValue[5]); // 5.TCO_DEPT_PK
                            grdDetail.SetGridText(grdDetail.rows - 1, c_org, aValue[6]); //3.6dept_nm
                            grdDetail.SetGridText(grdDetail.rows - 1, c_pk_master, lstYear.GetData()); //3.6dept_nm
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l1_pk, aValue[7]); //7.manager_pk1
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l1, aValue[8]); //manager_nm1
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l2_pk, aValue[9]);//manager_pk2
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l2, aValue[10]);//manager_nm2
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l3_pk, aValue[14]);//manager_pk3
                            grdDetail.SetGridText(grdDetail.rows - 1, c_manager_l3, aValue[15]);//manager_nm3
                            if (grdDetail.GetGridData(grdDetail.rows - 1, c_manager_l1_pk) == "") {

                                grdDetail.SetGridText(grdDetail.rows - 1, c_grade_l1_yn, 'N');//11 grade1
                            }

                            if (grdDetail.GetGridData(grdDetail.rows - 1, c_manager_l2_pk) == "") {

                                grdDetail.SetGridText(grdDetail.rows - 1, c_grade_l2_yn, 'N');//11 12grade2
                            }

                            if (grdDetail.GetGridData(grdDetail.rows - 1, c_manager_l3_pk) == "") {

                                grdDetail.SetGridText(grdDetail.rows - 1, c_grade_l3_yn, 'N');//11 12grade2
                            }

                            grdDetail.SetGridText(grdDetail.rows - 1, c_pos_id, aValue[13]);//position id
                            grdDetail.SetGridText(grdDetail.rows - 1, c_grade_type, lblGradeEvatype.GetData());//position id

                        }
                        btnConfirm.SetEnable(false);
                        //btnSelect.SetEnable(false);
                        //btnUnselect.SetEnable(false);
                        btnDelete.SetEnable(false);
                        btnSetall.SetEnable(true);
                        btnSave.SetEnable(true);
                    }
                    break;
                case 1://Change Evaluator
                    var fpath = System.RootURL + "/form/ch/em/chem00050_2.aspx?eva_no=" + lstYear.GetData();
                    aValue = System.OpenModal(fpath, 1000, 700, 'resizable:yes;status:yes');
                    break;

                case 4://Set ALL
                    var ctrl = grdDetail.GetGridControl();

                    //for (i = 1; i< grdDetail.rows; i++)
                    //{
                    if (ctrl.SelectedRows > 0) {
                        for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
                            var row = ctrl.SelectedRow(i);
                            if (row > 0) {
                                grdDetail.SetGridText(row, c_eva_group, lstEvaluationGrp1.GetData());
                            }

                        }
                    }
                    else {
                        for (i = 1; i < grdDetail.rows; i++) {
                            if (grdDetail.GetGridData(i, c_confirm_yn) == 'NO' || grdDetail.GetGridData(i, c_confirm_yn) == '') {
                                //grdDetail.SetGridText(i, c_eva_group_pk, lstEvaluationGrp1.GetData());
                                grdDetail.SetGridText(i, c_eva_group, lstEvaluationGrp1.GetData());
                                //lstEvaluationGrp.SetDataText(lstEvaluationGrp1.GetData());
                            }
                        }
                    }

                    break;
                case 5://Save

                    for (i = 1; i < grdDetail.rows; i++) {
                        if (grdDetail.GetGridData(i, 0) == '' && grdDetail.GetGridData(i, c_eva_group) == '') {
                            alert('You must set group first.\n Bạn phải nhập nhóm đánh giá.');
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l1) == '' && grdDetail.GetGridData(i, c_grade_l1_yn) == 'Y') {
                            alert("You must set the first manager.\n Bạn phải nhập người đánh giá thứ 1.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l2) == '' && grdDetail.GetGridData(i, c_grade_l2_yn) == 'Y') {
                            alert("You must set the second manager.\n Bạn phải nhập người đánh giá thứ 2.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l3) == '' && grdDetail.GetGridData(i, c_grade_l3_yn) == 'Y') {
                            alert("You must set the third manager.\n Bạn phải nhập người đánh giá thứ 3.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l1_pk) == grdDetail.GetGridData(i, c_emp_pk)) {
                            alert("Employee and the first manager have different.\n Nhân viên và người đánh giá thứ 1 phải khác nhau.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l2_pk) == grdDetail.GetGridData(i, c_emp_pk)) {
                            alert("Employee and the second manager have different.\n Nhân viên và người đánh giá thứ 2 phải khác nhau.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l3_pk) == grdDetail.GetGridData(i, c_emp_pk)) {
                            alert("Employee and the third manager have different.\n Nhân viên và người đánh giá thứ 3 phải khác nhau.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, c_manager_l1_pk) == grdDetail.GetGridData(i, c_manager_l2_pk) || grdDetail.GetGridData(i, c_manager_l1_pk) == grdDetail.GetGridData(i, c_manager_l3_pk)
                                || (grdDetail.GetGridData(i, c_manager_l2_pk) == grdDetail.GetGridData(i, c_manager_l3_pk) && grdDetail.GetGridData(i, c_manager_l2_pk) != '' && grdDetail.GetGridData(i, c_manager_l3_pk) != '')) {
                            alert("Managers have different.\n Người đánh giá phải khác nhau.")
                            return;
                        }
                        else if (grdDetail.GetGridData(i, 0) == '' && grdDetail.GetGridData(i, c_eva_group) != '' && grdDetail.GetGridData(i, c_confirm_yn) == "NO") {
                            grdDetail.SetRowStatus(i, 0x20);
                        }
                    }
                    flag = 'save';
                    datchem00050_3.Call("");
                    break;
                case 6://Confirm
                    var l_cnt = 0;
                    var l_save = '';
                    for (i = 1; i < grdDetail.rows; i++) {
                        if (grdDetail.GetGridData(i, 2) == '-1') {
                            l_cnt = Number(l_cnt) + 1;
                        }

                    }

                    if (Number(l_cnt) == 0) {
                        alert('You should select item to confirm');
                        return false;
                    } else {
                        if (confirm('Do you want to confirm selected item?')) {
                            for (i = 1; i < grdDetail.rows; i++) {
                                //alert(grdDetail.GetGridData(i,0));
                                if (grdDetail.GetGridData(i, 2) == '-1' && grdDetail.GetGridData(i, 0) != '') {
                                    grdDetail.SetGridText(i, c_eva_emp_status, 'CONFIRM');
                                }

                            }
                            flag = 'CONFIRM';
                            datchem00050_3.Call();
                        }
                    }
                    break;
                case 7://Search

                    datchem00050_3.Call('SELECT');
                    break;
                case 8://Delete
                    var ctrl = grdDetail.GetGridControl();
                    var l_cnt = 0;
                    for (i = 1; i < grdDetail.rows; i++) {
                        if (grdDetail.GetGridData(i, 2) == '-1') {
                            l_cnt = Number(l_cnt) + 1;
                        }

                    }

                    if (Number(l_cnt) == 0) {
                        alert('You should select item to delete');
                        return false;
                    }
                    else {
                        if (confirm('Do you want to delete selected item?')) {
                            for (i = 1; i < grdDetail.rows; i++) {
                                if (grdDetail.GetGridData(i, 2) == '-1' && grdDetail.GetGridData(i, c_confirm_yn) == 'NO') {
                                    grdDetail.SetRowStatus(i, 0x40);
                                    //grdDetail.DeleteRow();

                                }
                            }
                            flag = 'DELETE';
                            datchem00050_3.Call();
                        }
                    }
                    break;
                case 9: // print report
                    var url = '/reports/ch/em/rptchem00050_1.aspx?eva_no=' + lstYear.GetText() + '&GradeType=' + lblGradeEvatype.GetData();
                    url = url + '&Position=' + lstPosition.text + '&period=' + lblPeriod.GetData() + '&schedule=' + lblSchedule.GetData();
                    url = url + '&group=' + escape(lstEvaluationGrp.GetText()) + '&Org1=' + escape(txtOrganization_NM.GetData());
                    url = url + '&grdtimes=' + escape(lblGradeEvatimes.GetData()) + '&p_year=' + lstYear.GetData();
                    url = url + '&p_organization_pk=' + lstOrg.value + '&p_emp_pk=' + txtEMP_pk.GetData();
                    url = url + '&p_position_id=' + lstPosition.value + '&p_thr_eva_group_pk=' + lstEvaluationGrp.GetData()
                    url = url + '&p_company_pk=' + txtCompany_pk.GetData() + '&status=' + lstStatus.GetData();
                    //alert(url);
                    System.OpenTargetPage(System.RootURL + url, "newform");
                    break;
                case 10:// cancel
                    var l_cnt = 0;
                    var l_save = '';
                    for (i = 1; i < grdDetail.rows; i++) {
                        if (grdDetail.GetGridData(i, 2) == '-1') {
                            l_cnt = Number(l_cnt) + 1;
                        }

                    }

                    if (Number(l_cnt) == 0) {
                        alert('You should select item to cancel');
                        return false;
                    } else {
                        if (confirm('Do you want to cancel selected item?')) {
                            for (i = 1; i < grdDetail.rows; i++) {
                                //alert(grdDetail.GetGridData(i,0));
                                if (grdDetail.GetGridData(i, 2) == '-1' && grdDetail.GetGridData(i, 0) != '') {
                                    grdDetail.SetGridText(i, c_eva_emp_status, 'CANCEL');
                                }

                            }
                            flag = 'CANCEL';
                            datchem00050_3.Call();
                        }
                    }
                    break;

            }
        }
}

//--------------------------------------------------------------------------------
function HideColManager(obj)
{
    if (obj == '1')
    {
        grdDetail.GetGridControl().ColHidden(c_manager_l1) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l1_yn) = 0;
        grdDetail.GetGridControl().ColHidden(c_manager_l2) = 1;
        grdDetail.GetGridControl().ColHidden(c_grade_l2_yn) = 1;
        grdDetail.GetGridControl().ColHidden(c_manager_l3) = 1;
        grdDetail.GetGridControl().ColHidden(c_grade_l3_yn) = 1;

        ls_data = "DATA|1|Reviewer 1st";
        lstReviewer.SetDataText(ls_data);
        ls_data = "DATA|1|Grade 1st";
        lstGrade.SetDataText(ls_data);
    }
    else if (obj == '2') {
        grdDetail.GetGridControl().ColHidden(c_manager_l1) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l1_yn) = 0;
        grdDetail.GetGridControl().ColHidden(c_manager_l2) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l2_yn) = 0;
        grdDetail.GetGridControl().ColHidden(c_manager_l3) = 1;
        grdDetail.GetGridControl().ColHidden(c_grade_l3_yn) = 1;

        ls_data = "DATA|1|Reviewer 1st|2|Reviewer 2nd";
        lstReviewer.SetDataText(ls_data);
        ls_data = "DATA|1|Grade 1st|2|Grade 2nd";
        lstGrade.SetDataText(ls_data);
    }
    else {
        grdDetail.GetGridControl().ColHidden(c_manager_l1) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l1_yn) = 0;
        grdDetail.GetGridControl().ColHidden(c_manager_l2) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l2_yn) = 0;
        grdDetail.GetGridControl().ColHidden(c_manager_l3) = 0;
        grdDetail.GetGridControl().ColHidden(c_grade_l3_yn) = 0;

        ls_data = "DATA|1|Reviewer 1st|2|Reviewer 2nd|3|Reviewer 3rd";
        lstReviewer.SetDataText(ls_data);
        ls_data = "DATA|1|Grade 1st|2|Grade 2nd|3|Grade 3rd";
        lstGrade.SetDataText(ls_data);
    }
}

function ShowHideButton(obj)
{
    var tmp;
    if (obj == "Y")     //close
        tmp = false;
    else
        tmp = true;

    btnSave.SetEnable(tmp);
    btnConfirm.SetEnable(tmp);
    btnCancel.SetEnable(tmp);
    btnDelete.SetEnable(tmp);
    btnSet.SetEnable(tmp);
    btnSetall.SetEnable(tmp);
    btnNewEMP.SetEnable(tmp);
    btnSetGrade.SetEnable(tmp);
}

//--------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "datchem00050_1":
            //alert(lblGradeEvatimes.text);
            HideColManager(lblGradeEvatimes.text);
            ShowHideButton(txtEvaCloseYN.text);
            datchem00050_2.Call('SELECT');
            break;
        case "datchem00050_2":
            lstEvaluationGrp.SetDataText(lstEvaGroup_tmp.text + "|ALL|Select ALL");
            lstEvaluationGrp1.SetDataText(lstEvaGroup_tmp.text);

            var t = lstEvaGroup_tmp.text;
            var s = "";
            t = t.substring(5, t.length);
            var arr = t.split("|");
            var i = 0;
            while (i < arr.length) {
                s += "#" + arr[i] + ";" + arr[i + 1] + "|";
                i += 2;
            }
            s = s.substring(0, s.length - 1);
            
            grdDetail.SetComboFormat(c_eva_group, s);
 
            lstEvaluationGrp.SetDataText("ALL");

            flag = '';
            datchem00050_3.Call('SELECT');
            break;
        case "datchem00050_3":
            ChangeColor();
                             
            lblTotalRecords.text = grdDetail.rows - 1 + ' staff(s)';
            ShowHideButton(txtEvaCloseYN.text);
            if (flag == 'CONFIRM')
                datchem00050_1.Call();

            check_init = 1;
        break;
    }
}
//--------------------------------------------------------------------------------
function OnShowPopup(index)
{
    if (check_init == 1) {
        switch (index) {
            case 0:

                var fpath = System.RootURL + "/form/ch/em/chem00050_4.aspx?";
                //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
                var obj = System.OpenModal(fpath, 400, 400, 'resizable:yes;status:yes'); //window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
                if (obj != null) {
                    lstOrg.value = obj;
                    //txtOrganization_pk.text=obj;
                    datchem00050_2.Call();
                }
                break;
            case 1:// Emp
                var fpath = System.RootURL + "/form/ch/em/chem00050_5.aspx";
                var aValue = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
                if ((aValue != null) && (aValue[0] != "")) {
                    txtEMP_pk.text = aValue[0];
                    txtEMP_ID.text = aValue[1];
                    txtEMP_NM.text = aValue[2];
                }
                break;
            case 2:// position
                var fpath = System.RootURL + "/form/ch/em/chem00050_com_code.aspx?code=HR0008";
                var obj = System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
                if (obj != null) {
                    lstPosition.value = obj[1];
                    //txtPosition.text=obj[1] + ' - ' + obj[2];
                    //txtPosition_id.text=obj[1];
                }
                break;
            case 3:// manager
                var emp_confirm;
                emp_confirm = grdDetail.GetGridData(grdDetail.row, c_confirm_yn);
                if (emp_confirm != "NO")
                    return;

                if (event.col == c_manager_l1) {

                    var fpath = System.RootURL + "/form/ch/em/chem00050_3_v2.aspx";
                    var obj = System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
                    if (obj != null) {
                        var manager1_pk;
                        manager1_pk = grdDetail.GetGridData(grdDetail.row, c_manager_l1_pk);

                        grdDetail.SetGridText(grdDetail.row, c_manager_l1, obj[2]); // 8.1st Reviewer name
                        grdDetail.SetGridText(grdDetail.row, c_manager_l1_pk, obj[0]); // 15.manager_pk1
                    }
                }
                if (event.col == c_manager_l2) {

                    var fpath = System.RootURL + "/form/ch/em/chem00050_3_v2.aspx";
                    var obj = System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
                    if (obj != null) {
                        var manager2_pk;
                        manager2_pk = grdDetail.GetGridData(grdDetail.row, c_manager_l2_pk);

                        grdDetail.SetGridText(grdDetail.row, c_manager_l2, obj[2]); // 10.2nd Reviewer
                        grdDetail.SetGridText(grdDetail.row, c_manager_l2_pk, obj[0]); // 16.manager_pk2

                    }
                }
                if (event.col == c_manager_l3) {

                    var fpath = System.RootURL + "/form/ch/em/chem00050_3_v2.aspx";
                    var obj = System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
                    if (obj != null) {
                        var manager3_pk;
                        manager3_pk = grdDetail.GetGridData(grdDetail.row, c_manager_l3_pk);

                        grdDetail.SetGridText(grdDetail.row, c_manager_l3, obj[2]); // 10.2nd Reviewer
                        grdDetail.SetGridText(grdDetail.row, c_manager_l3_pk, obj[0]); // 16.manager_pk2

                    }
                }
                break;
        }
    }
}
function ChangeColor()
{
    var ctrl = grdDetail.GetGridControl();
    for (i = 1; i < ctrl.Rows; i++)
	{
        if (grdDetail.GetGridData(i, c_confirm_yn) != "NO")
        {
	        //ctrl.Cell(0, i, 1, i, 18) = false;
	       // grdDetail.SetCellBold(i, 1, i, 18, true);
            grdDetail.SetCellBgColor(i, 0, i, c_confirm_yn, 0X7AA0FF);
        }
        else
	    {
	        //ctrl.Cell(0, i, 1, i, 18) = false;
	      // grdDetail.SetCellBold(i, 1, i, 18, false);
            grdDetail.SetCellBgColor(i, 0, i, c_confirm_yn, 0XFFFFFF);
	    }
	 
	}
}
//---------------------------------------------------------------------------------
function CellClick()
{
    var ctrl = grdDetail.GetGridControl();
    if(Number(lstStatus.GetData()) <= 10 )
    {
        for (i = 1; i < ctrl.Rows; i++)
	    {
            if (grdDetail.GetGridData(grdDetail.row, c_confirm_yn) != "NO")
            {
                grdDetail.row=-1;
                return false;
            }
        }   
    }    
}
function OnRemoveReviewer() {
    if (grdDetail.row > 0) {
        if (grdDetail.GetGridData(grdDetail.row, c_confirm_yn) == "YES") {
            alert("This data was confirmed. So you can not change.");
            return;
        }
        if (grdDetail.col == c_manager_l2) {
            if (confirm("Do you want to remove reviewer " + grdDetail.GetGridData(grdDetail.row, c_manager_l2) + " ?")) {
                grdDetail.SetGridText(grdDetail.row, c_manager_l2, "");
                grdDetail.SetGridText(grdDetail.row, c_grade_l1_yn, "");
                grdDetail.SetGridText(grdDetail.row, c_manager_l2_pk, "");
                button_click(5);
            }
        }
        else {
            alert("Please click on the reviewer who you want to remove.");
        }
    }
    else {
        alert("Please click on the reviewer who you want to remove.");
    }
}

function OnSel_Reviewer()
{
    var fpath = System.RootURL + "/form/ch/em/chem00050_3_v2.aspx" ;
              var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	            if (obj!=null)
                {
                    
                    txtReviewer_pk.text=obj[0];
                    txtReviewer.text=obj[2];
               }    
}

function onSet_Reviewer(obj) {
    if (obj == 1) {
        var i;
        if (txtReviewer_pk.text == "") {
            alert("Please select reviewer before set.")
            return;
        }

        var ctrl = grdDetail.GetGridControl();

        //for (i = 1; i< grdDetail.rows; i++)
        //{
        if (ctrl.SelectedRows > 0) {
            for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
                var row = ctrl.SelectedRow(i);
                if (row > 0) {
                    if (lstReviewer.value == '1')//first reviewer
                    {
                        grdDetail.SetGridText(row, c_manager_l1, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(row, c_manager_l1_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                    else if (lstReviewer.value == '2') {
                        grdDetail.SetGridText(row, c_manager_l2, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(row, c_manager_l2_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                    else {
                        grdDetail.SetGridText(row, c_manager_l3, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(row, c_manager_l3_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                }

            }
        }
        else {

            for (i = 1; i < grdDetail.rows; i++) {
                if (grdDetail.GetGridData(i, c_confirm_yn) == 'NO' || grdDetail.GetGridData(i, c_confirm_yn) == '') {
                    if (lstReviewer.value == '1')//first reviewer
                    {
                        grdDetail.SetGridText(i, c_manager_l1, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(i, c_manager_l1_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                    else if (lstReviewer.value == '2') {
                        grdDetail.SetGridText(i, c_manager_l2, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(i, c_manager_l2_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                    else {
                        grdDetail.SetGridText(i, c_manager_l3, txtReviewer.text); // 8.1st Reviewer name
                        grdDetail.SetGridText(i, c_manager_l3_pk, txtReviewer_pk.text); // 15.manager_pk1
                    }
                }
            }
        }
    }
    else  //set grade
    {
        var ctrl = grdDetail.GetGridControl();

        //for (i = 1; i< grdDetail.rows; i++)
        //{
        if (ctrl.SelectedRows > 0) {
            for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
                var row = ctrl.SelectedRow(i);
                if (row > 0) {
                    if (lstGrade.value == '1')
                    {
                        grdDetail.SetGridText(row, c_grade_l1_yn, lstGradeYN.value);
                    }
                    else if (lstGrade.value == '2') {
                        grdDetail.SetGridText(row, c_grade_l2_yn, lstGradeYN.value);
                    }
                    else {
                        grdDetail.SetGridText(row, c_grade_l3_yn, lstGradeYN.value);
                    }
                }

            }
        }
        else {

            for (i = 1; i < grdDetail.rows; i++) {
                if (grdDetail.GetGridData(i, c_confirm_yn) == 'NO' || grdDetail.GetGridData(i, c_confirm_yn) == '') {
                    if (lstGrade.value == '1') {
                        grdDetail.SetGridText(row, c_grade_l1_yn, lstGradeYN.value);
                    }
                    else if (lstGrade.value == '2') {
                        grdDetail.SetGridText(row, c_grade_l2_yn, lstGradeYN.value);
                    }
                    else {
                        grdDetail.SetGridText(row, c_grade_l3_yn, lstGradeYN.value);
                    }
                }
            }
        }
    }
}
//---------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox, obj_grd, obj_col) {
    var tmp;
    if (obj_checkbox.GetData() == 'T')
        tmp = -1;
    else
        tmp = 0;
    var ctrl = obj_grd.GetGridControl();

    if (ctrl.SelectedRows > 0) {
        for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
            var row = ctrl.SelectedRow(i);
            if (row > 0) {
                obj_grd.SetGridText(row, obj_col, tmp);
            }

        }
    }
    else {
        for (var i = 1 ; i < ctrl.rows ; i++) {
            obj_grd.SetGridText(i, obj_col, tmp);
        }
    }

}

</script>

<body bgcolor='#F5F8FF'>
   <!--------------------------------------->
<gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_chem00050_1_v2" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="lblPeriod" />
                    <output bind="lblSchedule" />
                    <output bind="lblGradeEvatype" />
                    <output bind="lblGradeEvatimes" />
                    <output bind="lblTotal" />
                    <output bind="txtEvaCloseYN" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datchem00050_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sel_chem00050_2_v2" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="lstEvaGroup_tmp" />
          </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datchem00050_3" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,7,9,11,13,15,16,17,18,19,20,21,23" function="hr_sel_chem00050_3_v2" procedure="hr_upd_chem00050_3_v2"> 
                <input bind="grdDetail" >
                    <input bind="lstYear" />
                    <input bind="lstOrg" />
                    <input bind="lstTemp" /> 
                    <input bind="txtEMP_ID" /> 
                    <input bind="lstPosition" />
                    <input bind="lstEvaluationGrp" />
                    <input bind="txtCompany_pk" />
                    <input bind="lstStatus" />
                    
                   </input>
                <output  bind="grdDetail" />
          
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
  <table border="1" cellspacing="1" cellpadding=1 width="100%" height="100%">
      <tr height="20%">
          <td>
                <table border="0" cellspacing="1" cellpadding=1 width="100%" height="100%">
                    <tr style="background-color:#fff3ae">
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Eva Year #</td>
                        <td colspan="15" width="15%" align="left"> <gw:list id="lstYear" styles="width:100%"   onchange="datchem00050_1.Call()"/></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Eva Period</td>
                        <td colspan="15" width="15%" align="left"><gw:label id="lblPeriod" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Eva times</td>
                        <td colspan="15" width="15%" align="left"><gw:label id="lblGradeEvatype" text="" styles="width:100%; text-align:left; border:1px solid #6B9EB8" /></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Schedule</td>
                        <td colspan="15" width="15%" align="left"><gw:label id="lblSchedule" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
                    </tr>
                    <tr >
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left"><a title="Click here to show Organization" onclick="OnShowPopup(0)" href="#tips" >Organization</a></td>
                        <td colspan="15" width="15%" align="left"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%'>
                                            <data>
                                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                                            </data>
                                            </gw:list></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Eva Group</td>
                        <td colspan="15" width="15%" align="left"><gw:list id="lstEvaluationGrp"  onchange="button_click(7)"/></td>
                        

                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Search by</td>
                        <td colspan="7" width="7%" align="left"><gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
				                        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
		                        </gw:list></td>
                        <td colspan="8" width="8%" align="right"><gw:textbox id="txtEMP_ID" onenterkey   ="button_click(7)" styles="width:95%"/></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left"></td>
                        <td colspan="5" width="5%" align="left"><gw:icon id="btnSearch" img="in" text="Search" onclick="button_click(7)" styles="width:100%" /></td>
                        <td colspan="5" width="5%" align="left"><gw:icon id="btnNewEMP" img="in" text="Add New" onclick="button_click(0)" styles="width:100%" /></td>
                        <td colspan="5" width="5%" align="left"><gw:icon id="btnPrint" img="in" text="Print" onclick="button_click(9)" styles="width:100%" /></td>
                    </tr>
                    <tr >
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left">Eva Emp Status</td>
                        <td colspan="15" width="15%" align="left"><gw:list id="lstStatus"  onchange="button_click(7)"/></td>
                        <td colspan="2" width="2%" align="left"></td>
                        <td colspan="8" width="8%" align="left"><a title="Click here to show Position" onclick="OnShowPopup(2)" href="#tips" >Position</a></td>
                        <td colspan="15" width="15%" align="left"><gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan="30" width="30%" align="center"> <gw:label id="lblTotalRecords"  styles="color:red;width:90%;font-weight: bold;font-size:13;" /></td>
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnSave" img="in" text="Save" onclick="button_click(5)" styles="width:100%" /></td>
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnConfirm" img="in" text="Confirm" onclick="button_click(6)" styles="width:100%" /></td>  
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnCancel" img="in" text="Cancel" onclick="button_click(10)" styles="width:100%" /></td>     
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnDelete" img="in" text="Delete" onclick="button_click(8)" styles="width:100%" /></td>
                    </tr>
                    <tr >
                        <td colspan="8" width="8%" align="left"><gw:checkbox id="chkSelect" value="F" onclick="OnSetGrid(chkSelect, grdDetail, c_select)" ></gw:checkbox > Select</td>
                        <td colspan="2" width="2%" align="left"> </td>
                        <td colspan="5" width="5%" align="left"><a title="Click here to select reviewer" onclick="OnSel_Reviewer()" href="#tips" >Reviewer</a></td>
                        <td colspan="10" width="10%" align="left"><gw:textbox id="txtReviewer" onchange=""/></td>
                        <td colspan="10" width="10%" align="left"><gw:list id="lstReviewer"  onchange=""/></td>
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnSet" img="in" text="Set" onclick="onSet_Reviewer(1)" styles="width:100%" /></td>
                        <td colspan="10" width="10%" align="left"></td>
                        <td colspan="2" width="2%" align="left"> </td>
                        <td colspan="8" width="8%" align="left">Eva Grade</td>
                        <td colspan="7" width="7%" align="left"><gw:list id="lstGrade"  onchange=""/></td>
                        <td colspan="5" width="5%" align="left"><gw:list id="lstGradeYN"  onchange="" value ="Y"><data>LIST|Y|YES|N|NO</data> </gw:list></td>
                        <td colspan="3" width="3%" align="left"> <gw:icon id="btnSetGrade" img="in" text="Set" onclick="onSet_Reviewer(2)" styles="width:100%" /></td>
                        <td colspan="2" width="2%" align="left"> </td>
                        <td colspan="8" width="8%" align="left">Eva Group</td>
                        <td colspan="10" width="10%" align="left"><gw:list id="lstEvaluationGrp1"  onchange=""/></td>
                        <td colspan="5" width="5%" align="left"> <gw:icon id="btnSetall" img="in" text="Set" onclick="button_click(4)" styles="width:100%" /></td>
                    </tr>
            </table>
          </td>
      </tr>
     
        <tr height="80%" border="0" >
            <td width="100%" height="100%" colspan=100>
                <table border="0" cellspacing="1" cellpadding=1 width="100%" height="100%" valign="top">
                    <tr><td>
                        <gw:grid id="grdDetail" 
                        header="_pk|_pk_master|Select|Organization|Employee ID|Employee Name|Position|Eva Group| 1st Reviewer|Eva. Grade 1|2nd Reviewer|Eva. Grade 2|3rd Reviewer|Eva. Grade 3|_THR_EVA_GROUP_PK|_THR_EMP_PK|_TCO_DEPT_PK|_manager_pk1|_manager_pk2|_manager_pk3|_position_id|Eva Emp Status|Confirm YN|_gradetype"
                        format="0|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||Y||Y||||||||||||" 
                        editcol="1|1|1|1|1|1|0|0|0|1|0|1|0|1|0|0|0|0|0|1|0|0|0|0" 
                        widths="0|0|700|2700|1500|3000|1500|2000|3000|1500|3000|1500|3000|1500|0|0|0|0|0|0|0|2000|1500|0"
                        styles="width:100%; height:100%" sorting="T" 
                        oncelldblclick="OnShowPopup(3)" 
                        oncellclick="CellClick()"
                        onafteredit=""
                        onselchange="" />
                    </td></tr>

                </table>
            </td>
        </tr>
   
</table>
    <gw:textbox id="txtchk"        text="0"         style="display:none" />
    <gw:textbox id="txtCompany_pk" styles="display:none"/>
    <gw:label id="lblGradeEvatimes" text="" styles="width:100%; text-align:left;border:1px solid #6B9EB8;display:none" />

    <gw:textbox id="txtEMP_pk" styles="display:none"/>
    <gw:textbox id="txtEMP_NM" styles="display:none"/>
    <gw:textbox id="txtPosition_id"  styles="display:none"/>
    <gw:textbox id="txtOrganization_pk" styles="display:none"/>
    <gw:textbox id="txtReviewer_pk" styles="display:none"/>
    <gw:textbox id="lstEvaGroup_tmp" styles="display:none"/>
    <gw:textbox id="txtEvaCloseYN" styles="display:none"/>
    <gw:textbox id="lblTotal" styles="display:none"/>
</body>
