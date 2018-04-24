<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
    var startTime, interval_time;
    var dt_tmp;
    var opt_value = 1;
    var user;
    var v_language = "<%=Session("SESSION_LANG")%>";
var check_init = 0;

var c_emp_pk = 0;
c_org = 1
c_wg = 2
c_emp_id = 3,
c_fullname = 4,
c_ws = 5,
c_date_in = 6,
c_in_time = 7,
c_date_out = 8,
c_out_time = 9,
c_wt = 10,
c_ot = 11,
c_nt = 12,
c_nt2 = 13,
c_ht = 14,
c_tick_approve = 15,
c_approve_status = 16,
c_wt_approve = 17,
c_ot_approve = 18,
c_nt_approve = 19,
c_nt2_approve = 20,
c_ht_approve = 21,
c_work_dt = 22,
c_wg2 =23,
c_hol_type = 24,
c_ot_plus = 25,
c_close =26,
c_thr_ot_approval_pk = 27;
c_date_now = 28;
c_date_next = 29;
c_approve_status_old = 30;
c_approve_status_new = 31;

function BodyInit() {
    if (v_language != "ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text = "<%=Session("COMPANY_PK")%>";
    user = "<%=session("USER_NAME")%>";
    menu_id.text = System.Menu.GetMenuID();
    var tmp;
    
     tmp = "<%=ESysLib.SetGridColumnDataSQL("select A.PK,A.SHIFT from THR_WORK_SHIFT A where a.del_if=0 AND A.USE_YN='Y' ORDER BY A.SHIFT ") %>";
    grd_att.SetComboFormat(c_ws, tmp);

    

     lstOrg.value = "ALL";
     lstWG.value = "ALL";
     FromDT.SetEnable(0);
     ToDT.SetEnable(0);
     Month.SetEnable(0);
     grd_att.GetGridControl().ColEditMask(c_in_time) = "99:99";
     grd_att.GetGridControl().ColEditMask(c_out_time) = "99:99";
     grd_att.GetGridControl().FrozenCols = 5;
     grd_att.GetGridControl().ScrollTrack = true;
     onSetEnable(0);
     onSetEnable2(0);

     grd_att.GetGridControl().ColHidden(c_date_in) = 1;
     grd_att.GetGridControl().ColHidden(c_date_out) = 1;
     
     ChangeColorItem(lstOrg.GetControl());

     datCheck_View.Call();
     //check_init = 1;


 }
 

    function onSetEnable(n) {

        ibtnSave.SetEnable(n);
        
    }
    function onSetEnable2(n) {
        idHH.SetEnable(n);
        
        idBtnSet.SetEnable(n);
        idBtnClear.SetEnable(n);
    }

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

    function OnSearch() {

        //alert(1);
        //return;
        if (check_init == 1) {
            clear_Interval(idInterval);
            var arr = txt_WS_temp.text.replace("DATA|", '').split("|");
            //alert(txt_WS_temp.text);
            var s = "";
            var t = 0;
            for (var i = 0; i < (arr.length + 1) / 2 - 1; i++) {
                s = s + "#" + arr[t] + ";" + arr[t + 1].split('-')[0] + "|";
                t = t + 2;
            }
            grd_att.SetComboFormat(c_ws, s);


            switch (opt_value) {
                case 1:
                    txtFrom.text = DailyDT.value
                    txtTo.text = DailyDT.value
                    break;
                case 2:
                    txtFrom.text = FromDT.value
                    txtTo.text = ToDT.value
                    break;
                case 3:
                    txtFrom.text = Month.value + "01"
                    txtTo.text = Month.value + "31"
                    break;
            }
            if ((opt_value != 1) && (lstOrg.value == "ALL") && (lstWG.value == "ALL") && (idtxtTmp.text == "")) {
                if (confirm("It will take long time because you get overload data, do you want to continous?\nHệ thống dự báo dữ liệu quá nhiều bạn sẽ phải đợi trong 1 thời gian dài, bạn có muốn tiếp tục?")) {
                    set_Interval(100);
                    dsoApproveWTOT.Call("SELECT");
                }
            }
            else {
                set_Interval(100);
                dsoApproveWTOT.Call("SELECT");
            }
        }

    }

    function set_Interval(x) {
        startTime = new Date().valueOf();
        interval_time = setInterval("clock(" + startTime + "," + x + ")", x);
    }
    function clock(start, x) {
        var d = new Date()
        idInterval.text = Math.round((d.valueOf() - start) / x);

    }
    //------------------------------------------------------------------------------------

    function clear_Interval(obj) {
        clearInterval(interval_time);
        obj.text = "";
    }

    function OnDataReceive(obj) {
        if (obj.id == "datCheck_View") {
            if (txtFlag_View.text == 'Y') {
                ibtnSave.style.display = "none";
                
            }

            if ((Trim(iduser_pk.text) != "") && (txtHr_level.text == "1")) //QUYEN BI GIOI HAN 
            {
                datUser_info.Call();
            }
            else {
                onChange_org();
            }
        }
        else if (obj.id=="dsoCheckApproveOT")
        {
            if (txtWTApprovalYN.text == "Y")
            {
                
                grd_att.GetGridControl().ColHidden(c_wt_approve) = 0;
            }
            else
            {
                
                grd_att.GetGridControl().ColHidden(c_wt_approve) = 1;
            }
            check_init = 1;
        }
        else if (obj.id == "dsoApproveWTOT")
        {
            clear_Interval(idInterval);
            idRecord.text = grd_att.rows - 1 + " Rec(s)."
            if (grd_att.rows > 1)
            {
                var wt, ot, nt, ht, abs;
                wt = ot = nt = ht = abs = 0;
                onSetEnable(1);
                if (idLstInOut.value != "0")
                    onSetEnable2(1);
                for (var i = 1; i < grd_att.rows; i++)
                {
                    if (grd_att.GetGridData(i, c_approve_status) == "APPROVE" || grd_att.GetGridData(i, c_approve_status) == "CANCEL")
                    {
                        grd_att.SetRowEditable(i, 0);

                        //alert(1);
                    }
                    else {
                        grd_att.SetRowEditable(i, 1);
                    }
                    //alert(grd_att.GetGridData(i, c_approve_status));  

                    if (grd_att.GetGridData(i, c_close) == "M")
                        grd_att.SetCellBgColor(i, c_emp_pk, i, c_close, 0x99FFFF);
                    if (grd_att.GetGridData(i, c_close) == "Y")
                        grd_att.SetCellBgColor(i, c_emp_pk, i, c_close, 0xFFEEFF);


                    if (Trim(grd_att.GetGridData(i, c_hol_type)) != "")
                    {
                        if (Trim(grd_att.GetGridData(i, c_hol_type)) == "HOL") {
                            grd_att.SetCellBgColor(i, c_ht, i, c_ht, 0x3366FF);
                            grd_att.SetCellBold(i, c_ht, i, c_ht, true);
                            grd_att.SetCellBgColor(i, c_ht_approve, i, c_ht_approve, 0x3366FF);
                            grd_att.SetCellBold(i, c_ht_approve, i, c_ht_approve, true);
                        }
                        else {
                            grd_att.SetCellBgColor(i, c_ht, i, c_ht, 0xCC9900);
                            grd_att.SetCellBold(i, c_ht, i, c_ht, true);
                            grd_att.SetCellBgColor(i, c_ht_approve, i, c_ht_approve, 0xCC9900);
                            grd_att.SetCellBold(i, c_ht_approve, i, c_ht_approve, true);
                        }
                    }
                    grd_att.SetCellBgColor(i, c_tick_approve, i, c_approve_status, 0x90EAF4);
                    grd_att.SetCellBold(i, c_approve_status, i, c_approve_status, true);
                    if (Trim(grd_att.GetGridData(i, c_wt_approve)) == "" ? wt += 0 : wt += Number(grd_att.GetGridData(i, c_wt_approve)));
                    if (Trim(grd_att.GetGridData(i, c_ot_approve)) == "" ? ot += 0 : ot += Number(grd_att.GetGridData(i, c_ot_approve)));
                    if (Trim(grd_att.GetGridData(i, c_nt_approve)) == "" ? nt += 0 : nt += Number(grd_att.GetGridData(i, c_nt_approve)));
                    if (Trim(grd_att.GetGridData(i, c_nt2_approve)) == "" ? nt += 0 : nt += Number(grd_att.GetGridData(i, c_nt2_approve)));
                    if (Trim(grd_att.GetGridData(i, c_ht_approve)) == "" ? ht += 0 : ht += Number(grd_att.GetGridData(i, c_ht_approve)));


                }
                idlbWtOtNtHt.text = "WT: " + wt + "(H)." + "OT:" + ot + "(H). " + " NT: " + nt + "(H). " + " Absence: " + abs + "(H).";
            }
            else
            {
                onSetEnable(0);
                onSetEnable2(0);
                idlbWtOtNtHt.text = "";
            }
            auto_resize_column(grd_att, 0, grd_att.cols - 1, 0);

        }
        else if (obj.id == "datFind_Report") {
            var url = System.RootURL + '/reports/ch/ba/' + txtReport_tmp.text + '?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value + '&p_from_date=' + txtFrom.text + '&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value + '&p_com=' + txtCompany_pk.text + '&p_data_type=' + idPrint_type.value + '&p_confirm=' + idConfirm.value;
            window.open(url);
        }
        else if (obj.id == "datWorkGroup_info") {
            lstWG.SetDataText(txtwg_tmp.text + '|ALL|Select All');
            lstWG.value = 'ALL';

            datWorkShift_info.Call();
        }
        else if (obj.id == "datWorkShift_info") {

            lstWS.SetDataText(txt_WS_temp.text + '|ALL|All Shift');
            lstWS.value = 'ALL';
            dsoCheckApproveOT.Call();
            

        }
        else if (obj.id == "datUser_info") {
            ChangeColorItem(lstOrg.GetControl());
            onChange_org();
        }
        else if (obj.id=="dsoRollBackWTOT")
        {
            for (var i = 1; i < grd_att.rows; i++)
            {
                grd_att.SetCellBgColor(i, c_tick_approve, i, c_approve_status, 0x90EAF4);
                grd_att.SetCellBold(i, c_approve_status, i, c_approve_status, true);
                if (grd_att.GetGridData(i, c_approve_status) == "APPROVE" || grd_att.GetGridData(i, c_approve_status) == "CANCEL")
                {
                    grd_att.SetRowEditable(i, 0);;
                }
                else
                {
                    grd_att.SetRowEditable(i, 1);
                }
            }
            
        }

    }

    function auto_resize_column(obj, col1, col2, font_size) {
        if (font_size != 0)
            obj.GetGridControl().FontSize = font_size;
        obj.GetGridControl().AutoSize(col1, col2, false, 0);
    }

    function On_click() {
        var ws;
        dt_tmp = grd_att.GetGridData(event.row, event.col)//luu tru gia tri vua click
        ws = grd_att.GetGridData(event.row, c_ws)
        lstWS_temp.value = ws;
        idlbWS.text = lstWS_temp.GetText();
        //alert(event.col);

    }

    function Popup() {
        var col = event.col;
        var flag = 0;
        if ((col == c_emp_id) || (col == c_fullname)) {
            var fpath = System.RootURL + "/form/ch/ba/chba003aa.aspx?emp_pk=" + grd_att.GetGridData(event.row, c_emp_pk) + "&dt1=" + grd_att.GetGridData(event.row, c_date_now)
            + "&dt2=" + grd_att.GetGridData(event.row, c_date_next) + "&emp_id=" + grd_att.GetGridData(event.row, c_emp_id);
            var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:yes;status:no;dialogWidth:35;dialogHeight:20;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
            if (obj != null) {
                if (obj[0] != "") {
                    if (obj[0] != grd_att.GetGridData(event.row, c_date_in)) {
                        grd_att.SetGridText(event.row, c_date_in, obj[0]);
                        grd_att.SetCellBgColor(event.row, c_date_in, event.row, c_date_in, 0x3366FF);
                        grd_att.SetCellBold(event.row, c_date_in, event.row, c_date_in, true);
                        flag = 1;
                    }
                    if (obj[1] != grd_att.GetGridData(event.row, c_in_time)) {
                        grd_att.SetGridText(event.row, c_in_time, obj[1]);
                        grd_att.SetCellBgColor(event.row, c_in_time, event.row, c_in_time, 0x3366FF);
                        grd_att.SetCellBold(event.row, c_in_time, event.row, c_in_time, true);
                        flag = 1;
                    }

                }
                if (obj[2] != "") {
                    if (obj[2] != grd_att.GetGridData(event.row, c_date_out)) {
                        grd_att.SetGridText(event.row, c_date_out, obj[2]);
                        grd_att.SetCellBgColor(event.row, c_date_out, event.row, c_date_out, 0x3366FF);
                        grd_att.SetCellBold(event.row, c_date_out, event.row, c_date_out, true);
                        flag = 1;
                    }
                    if (obj[3] != grd_att.GetGridData(event.row, c_out_time)) {
                        grd_att.SetGridText(event.row, c_out_time, obj[3]);
                        grd_att.SetCellBgColor(event.row, c_out_time, event.row, c_out_time, 0x3366FF);
                        grd_att.SetCellBold(event.row, c_out_time, event.row, c_out_time, true);
                        flag = 1;

                    }

                }
                if (flag == 1) {
                    grd_att.SetGridText(event.row, c_wt, "");
                }
            }
        }
        else if (col == c_ws) {
            var fpath = System.RootURL + "/form/ch/ba/chba003ab.aspx?shift=" + grd_att.GetGridData(event.row, c_ws);
            var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:yes;status:no;dialogWidth:40;dialogHeight:15;dialogLeft:100;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
            if (obj != null) {
                if (obj[0] != grd_att.GetGridData(event.row, c_ws)) {
                    grd_att.SetGridText(event.row, col, obj[0]);
                    grd_att.SetCellBgColor(event.row, c_ws, event.row, c_ws, 0x3366FF);
                    grd_att.SetCellBold(event.row, c_ws, event.row, c_ws, true);
                    lstWS_temp.value = obj[0];
                    idlbWS.text = lstWS_temp.GetText();


                }
            }
            //alert(obj[0]);
        }

        if ((grd_att.GetGridData(event.row, c_close) == "M" || grd_att.GetGridData(event.row, c_close) == "Y")) {
            alert("You can't modify and save this record because salary period was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ");

            return;
        }

    }

    function onChange_org()
    {
        //if(lstOrg.value!='ALL')
        datWorkGroup_info.Call();
    }

    function On_AfterEdit()
    {
        var tmpIN, tmpOUT, tmpDT, ws, temp;
        cIdx = event.col;
        ws = grd_att.GetGridData(event.row, c_ws)
        lstWS_temp.value = ws;
        idlbWS.text = lstWS_temp.GetText();        
        if (cIdx == c_wt_approve) //WT      
        {
            if (Number(grd_att.GetGridData(event.row, cIdx)) > 0 && grd_att.GetGridData(event.row, c_hol_type) != "") {
                alert("This day is holiday, haven't WT.\nNgày này là ngày nghỉ không thể có giờ làm việc chính thức.")
                grd_att.SetGridText(event.row, cIdx, '0');
            }
        }


        if (grd_att.GetGridData(event.row, c_close) == "M" || grd_att.GetGridData(event.row, c_close) == "Y" ) {
            alert("You can't modify this data! \nBạn không thể điều chỉnh thông tin này! ");
            return;
        }

        //alert(grd_att.GetGridData(event.row, event.col));
        if (event.col == c_tick_approve)
        {
            //alert(grd_att.GetGridData(event.row, event.col));
            if (grd_att.GetGridData(event.row, event.col) == "-1")
            {
                if (grd_att.GetGridData(event.row, c_approve_status) == "SUBMIT")
                {
                    grd_att.SetGridText(event.row, c_tick_approve, '-1');
                    grd_att.SetGridText(event.row, c_approve_status, "APPROVE");
                    grd_att.SetGridText(event.row, c_approve_status_new, '3');
                }
                else if (grd_att.GetGridData(event.row, c_approve_status) == "CANCEL")
                {
                    if (grd_att.GetGridData(event.row, c_approve_status_old) == grd_att.GetGridData(event.row, c_approve_status_new))
                    {
                        alert("Data CANCELED, action denied!\nEmpID:" + grd_att.GetGridData(event.row, c_emp_id));
                        grd_att.SetGridText(event.row, c_tick_approve, '0');
                        return;
                    }
                    else
                    {
                        grd_att.SetGridText(event.row, c_tick_approve, '-1');
                        grd_att.SetGridText(event.row, c_approve_status, "APPROVE");
                        grd_att.SetGridText(event.row, c_approve_status_new, '3');
                    }
                }
                else if (grd_att.GetGridData(event.row, c_approve_status) == "APPROVE")
                {
                    if (grd_att.GetGridData(event.row, c_approve_status_old) == grd_att.GetGridData(event.row, c_approve_status_new))
                    {
                        alert("Data APPROVED, action denied!\nEmpID:" + grd_att.GetGridData(event.row, c_emp_id));
                        grd_att.SetGridText(event.row, c_tick_approve, '0');
                        return;
                    }
                }
                
            }
            else
            {
                if(grd_att.GetGridData(event.row, c_approve_status) == "APPROVE")
                {
                    if (grd_att.GetGridData(event.row, c_approve_status_new) != grd_att.GetGridData(event.row, c_approve_status_old))
                    {
                        grd_att.SetGridText(event.row, c_approve_status, "SUBMIT");
                        grd_att.SetGridText(event.row, c_approve_status_new, "2");
                        return;
                    }
                    else
                    {
                        alert("Data APPROVED, action denied!");
                        return;
                    }
                }
                else if (grd_att.GetGridData(event.row, c_approve_status) == "CANCEL")
                {
                    if (grd_att.GetGridData(event.row, c_approve_status_new) != grd_att.GetGridData(event.row, c_approve_status_old))
                    {
                        grd_att.SetGridText(event.row, c_approve_status, "SUBMIT");
                        grd_att.SetGridText(event.row, c_approve_status_new, "2");
                        return;
                    }
                    else
                    {
                        alert("Data CANCELED, action denied!");
                        return;
                    }
                }
                else if (grd_att.GetGridData(event.row, c_approve_status) == "ROLLBACK")
                {
                    var _last_status;
                    if (grd_att.GetGridData(event.row, c_approve_status_new) == "2")
                        _last_status = "SUBMIT";
                    else if (grd_att.GetGridData(event.row, c_approve_status_new) == "3")
                        _last_status = "APPROVE";
                    else if (grd_att.GetGridData(event.row, c_approve_status_new) == "4")
                        _last_status = "CANCEL";
                    grd_att.SetGridText(event.row, c_approve_status, _last_status);
                }
            }
        }
        else if (event.col == c_wt_approve)
        {
            if(grd_att.GetGridData(event.row,c_wt )=='0' && grd_att.GetGridData(event.row,c_wt_approve )!='0' )
            {
                alert('Only approve if any WT > 0, Action denied!\n Không thể approve WT > 0 vì giờ gốc không có WT');
                grd_att.SetGridText(event.row, event.col, '0');
                return;
            }
        }
        else if (event.col == c_ot_approve)
        {
            if (grd_att.GetGridData(event.row, c_ot) == '0' && grd_att.GetGridData(event.row, c_ot_approve) != '0')
            {
                alert('Only approve if any OT > 0, Action denied!\n Không thể approve OT > 0 vì giờ gốc không có OT');
                grd_att.SetGridText(event.row, event.col, '0');
                return;
            }
        }
        else if (event.col == c_nt_approve)
        {
            if (grd_att.GetGridData(event.row, c_nt) == '0' && grd_att.GetGridData(event.row, c_nt_approve) != '0')
            {
                alert('Only approve if any NT > 0, Action denied!\n Không thể approve NT > 0 vì giờ gốc không có NT');
                grd_att.SetGridText(event.row, event.col, '0');
                return;
            }
        }
        else if (event.col == c_nt2_approve)
        {
            if (grd_att.GetGridData(event.row, c_nt2) == '0' && grd_att.GetGridData(event.row, c_nt2_approve) != '0')
            {
                alert('Only approve if any NT2 > 0, Action denied!\n Không thể approve NT2 > 0 vì giờ gốc không có NT2');
                grd_att.SetGridText(event.row, event.col, '0');
                return;
            }
        }
        else if (event.col == c_ht_approve)
        {
            if (grd_att.GetGridData(event.row, c_ht) == '0' && grd_att.GetGridData(event.row, c_ht_approve) != '0')
            {
                alert('Only approve if any HT > 0, Action denied!\n Không thể approve HT > 0 vì giờ gốc không có HT');
                grd_att.SetGridText(event.row, event.col, '0');
                return;
            }
        }
    }

    function OnTickApprove() {
        var ctrl = grd_att.GetGridControl();
        for (var i = 0 ; i < ctrl.SelectedRows ; i++)
        {
            var row = ctrl.SelectedRow(i);
            if (row > 0)
            {
                if (chkApprove.value == 'T')
                {
                    if (grd_att.GetGridData(row, c_approve_status) == "SUBMIT")
                    {
                        grd_att.SetGridText(row, c_tick_approve, '-1');
                        grd_att.SetGridText(row, c_approve_status, "APPROVE");
                        grd_att.SetGridText(row, c_approve_status_new, '3');
                    }
                    else if (grd_att.GetGridData(row, c_approve_status) == "CANCEL")
                    {
                        if(grd_att.GetGridData(row, c_approve_status_old) == grd_att.GetGridData(row, c_approve_status_new))
                        {
                            alert("Data CANCELED, action denied!\nEmpID:" + grd_att.GetGridData(row, c_emp_id));
                            return;
                        }
                        else
                        {
                            grd_att.SetGridText(row, c_tick_approve, '-1');
                            grd_att.SetGridText(row, c_approve_status, "APPROVE");
                            grd_att.SetGridText(row, c_approve_status_new, '3');
                        }
                    }
                    else if (grd_att.GetGridData(row, c_approve_status) == "APPROVE")
                    {
                        if (grd_att.GetGridData(row, c_approve_status_old) == grd_att.GetGridData(row, c_approve_status_new))
                        {
                            alert("Data APPROVED, action denied!\nEmpID:" + grd_att.GetGridData(row, c_emp_id));
                            return;
                        }
                    }
                }
                else
                {
                    if (grd_att.GetGridData(row, c_approve_status) == "APPROVE")
                    {
                        if (grd_att.GetGridData(row, c_approve_status_old) != grd_att.GetGridData(row, c_approve_status_new))
                        {
                            grd_att.SetGridText(row, c_tick_approve, '0');
                            grd_att.SetGridText(row, c_approve_status, "SUBMIT");
                            grd_att.SetGridText(row, c_approve_status_new, '2');
                        }
                    }
                }                
            }
        }
    }

    function OnTickCancel()
    {
        var ctrl = grd_att.GetGridControl();
        for (var i = 0 ; i < ctrl.SelectedRows ; i++)
        {
            var row = ctrl.SelectedRow(i);
            if (row > 0)
            {
                if(chkCancel.value == 'T')
                {
                    if (grd_att.GetGridData(row, c_approve_status) == "SUBMIT")
                    {
                        grd_att.SetGridText(row, c_tick_approve, '-1');
                        grd_att.SetGridText(row, c_approve_status, "CANCEL");
                        grd_att.SetGridText(row, c_approve_status_new, '4');
                    }
                    else if (grd_att.GetGridData(row, c_approve_status) == "APPROVE")
                    {
                        if(grd_att.GetGridData(row, c_approve_status_old) == grd_att.GetGridData(row, c_approve_status_new))
                        {
                            alert("Data APPROVED, action denied!\nEmpID:" + grd_att.GetGridData(row, c_emp_id));
                            return;
                        }
                        else
                        {
                            grd_att.SetGridText(row, c_tick_approve, '-1');
                            grd_att.SetGridText(row, c_approve_status, "CANCEL");
                            grd_att.SetGridText(row, c_approve_status_new, '4');
                        }
                    }
                    else if (grd_att.GetGridData(row, c_approve_status) == "CANCEL")
                    {
                        if (grd_att.GetGridData(row, c_approve_status_old) == grd_att.GetGridData(row, c_approve_status_new))
                        {
                            alert("Data CANCELED, action denied!\nEmpID:" + grd_att.GetGridData(row, c_emp_id));
                            return;
                        }                        
                    }
                }
                else
                {
                    if (grd_att.GetGridData(row, c_approve_status) == "CANCEL")
                    {
                        if (grd_att.GetGridData(row, c_approve_status_old) != grd_att.GetGridData(row, c_approve_status_new))
                        {
                            grd_att.SetGridText(row, c_tick_approve, '0');
                            grd_att.SetGridText(row, c_approve_status, "SUBMIT");
                            grd_att.SetGridText(row, c_approve_status_new, '2');
                        }
                    }
                }                
            }
        }
    }
    function OnToggle() {
        if (imgMaster.status == "expand") {
            imgMaster.status = "collapse";
            grd_att.GetGridControl().ColHidden(c_date_in) = 1;
            grd_att.GetGridControl().ColHidden(c_date_out) = 1;


            imgMaster.src = "../../../system/images/iconmaximize.gif";
            imgMaster.alt = "Show Column";
        }
        else {
            grd_att.GetGridControl().ColHidden(c_date_in) = 0;
            grd_att.GetGridControl().ColHidden(c_date_out) = 0;
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
            imgMaster.alt = "Hide Column";
        }

    }

    function change_list() {
        if (idLstInOut.value == "0") {
            onSetEnable2(0);
            return;
        }
        if ((idLstInOut.value == "1") || (idLstInOut.value == "2")) {
            
            idlbHH.text = "HH"
            


        }
        else {
            
            idlbHH.text = "H"
            

        }
        if (grd_att.rows > 1) {
            onSetEnable2(1);
            idHH.GetControl().focus();
        }
    }

    function OnSetToGrid()
    {
        var gCtrl, i;
        var input_time, hh, mm1, mm2
        var mm_tmp, ran_var, result
        gCtrl = grd_att.GetGridControl();
        
        hh = Trim(idHH.text);
        //alert(idLstInOut.value);
        if (gCtrl.rows > 1)
        {
            if (gCtrl.SelectedRows <= 1)
            {
                if (confirm("Set to all blank records (not include holiday)?\nĐiền vào tất cả những dòng còn trống (không kể ngày nghỉ)?"))
                {
                    for (i = 1; i < gCtrl.rows; i++)
                    {
                        if (idLstInOut.value == "3")
                        {
                            if (grd_att.GetGridData(i, c_wt) != '0')
                                grd_att.SetGridText(i, c_wt_approve, Trim(idHH.text));
                        }
                        else if (idLstInOut.value == "4")
                        {
                            if (grd_att.GetGridData(i, c_ot) != '0')
                                grd_att.SetGridText(i, c_ot_approve, Trim(idHH.text));
                        }
                        else if (idLstInOut.value == "5")
                        {
                            if (grd_att.GetGridData(i, c_nt) != '0')
                                grd_att.SetGridText(i, c_nt_approve, Trim(idHH.text));
                        }
                        else if (idLstInOut.value == "7") //NT2
                        {
                            if (grd_att.GetGridData(i, c_nt2) != '0')
                                grd_att.SetGridText(i, c_nt2_approve, Trim(idHH.text));
                        }
                        else if (idLstInOut.value == "6")//HT 
                        {
                            if (grd_att.GetGridData(i, c_ht) != '0')
                                grd_att.SetGridText(i, c_ht_approve, Trim(idHH.text));
                        }
                    }
                }
            }
            else
            {
                for (i = 0; i < gCtrl.SelectedRows; i++)
                {
                    var tmp = gCtrl.SelectedRow(i);
                    if (idLstInOut.value == "3")
                    {
                        if (grd_att.GetGridData(tmp, c_wt) != '0')
                            grd_att.SetGridText(tmp, c_wt_approve, Trim(idHH.text));
                    }
                    else if (idLstInOut.value == "4")
                    {
                        if (grd_att.GetGridData(tmp, c_ot) != '0')
                            grd_att.SetGridText(tmp, c_ot_approve, Trim(idHH.text));
                    }
                    else if (idLstInOut.value == "5")
                    {
                        //alert(grd_att.GetGridData(tmp, c_nt));
                        if (grd_att.GetGridData(i, c_nt) != '0')
                            grd_att.SetGridText(tmp, c_nt_approve, Trim(idHH.text));
                    }
                    else if (idLstInOut.value == "7")
                    {
                        if (grd_att.GetGridData(tmp, c_nt2) != '0')
                            grd_att.SetGridText(tmp, c_nt2_approve, Trim(idHH.text));
                    }
                    else if (idLstInOut.value == "6")
                    {
                        if (grd_att.GetGridData(tmp, c_ht) != '0')
                            grd_att.SetGridText(tmp, c_ht_approve, Trim(idHH.text));
                    }                    
                }
            }
        }
    }

    function onClearGrid()
    {
        var ctrl, i
        ctrl = grd_att.GetGridControl();
        if (ctrl.SelectedRows <= 1)
        {
            if (confirm("Set to all blank records"))
            {
                switch (idLstInOut.value)
                {
                    
                    case "3": //wt
                        for (i = 1; i < ctrl.rows; i++)
                        {
                            grd_att.SetGridText(i, c_wt_approve, "0")
                        }
                        break;
                    case "4": //ot
                        for (i = 1; i < ctrl.rows; i++)
                        {
                            grd_att.SetGridText(i, c_ot_approve, "0")
                        }
                        break;
                    case "5": //nt
                        for (i = 1; i < ctrl.rows; i++)
                        {
                            grd_att.SetGridText(i, c_nt_approve, "0")
                        }
                        break;
                    case "7": //nt
                        for (i = 1; i < ctrl.rows; i++)
                        {
                            grd_att.SetGridText(i, c_nt2_approve, "0")
                        }
                        break;
                    case "6": //ht
                        for (i = 1; i < ctrl.rows; i++)
                        {
                            grd_att.SetGridText(i, c_ht_approve, "0")
                        }
                        break;
                }
            }
        }
        else
        {
            for (i = 0; i < ctrl.SelectedRows; i++)
            {
                var tmp = ctrl.SelectedRow(i);
                switch (idLstInOut.value)
                {

                    case "3":
                        grd_att.SetGridText(tmp, c_wt_approve, "0")
                        break;
                    case "4":
                        grd_att.SetGridText(tmp, c_ot_approve, "0")
                        break;
                    case "5":
                        grd_att.SetGridText(tmp, c_nt_approve, "0")
                        break;
                    case "7":
                        grd_att.SetGridText(tmp, c_nt2_approve, "0")
                        break;
                    case "6":
                        grd_att.SetGridText(tmp, c_ht_approve, "0")
                        break;
                }
            }
        }
    }

    function OnUpdate()
    {

        if (confirm("Do you want to save?\nBạn muốn save?"))
            dsoApproveWTOT.Call();
    }

    function OnRollback()
    {        
        var ctrl = grd_att.GetGridControl();
        for (var i = 0 ; i < ctrl.SelectedRows ; i++)
        {
            var row = ctrl.SelectedRow(i);
            if (row > 0)
            {
                var _last_status;
                if (grd_att.GetGridData(row, c_approve_status_new) == "2")
                    _last_status = "SUBMIT";
                else if (grd_att.GetGridData(row, c_approve_status_new) == "3")
                    _last_status = "APPROVE";
                else if (grd_att.GetGridData(row, c_approve_status_new) == "4")
                    _last_status = "CANCEL";
                    //alert(_last_status);
                if (chkRollback.value == 'T')
                {
                    grd_att.SetGridText(row, c_tick_approve, "-1");
                    grd_att.SetGridText(row, c_approve_status, "ROLLBACK");
                    //ibtnSave.style.display = "none";
                    //chkSetData.style.display = "none";
                    //chkApprove.style.display = "none";
                    //chkCancel.style.display = "none";
                }
                else
                {
                    grd_att.SetGridText(row, c_tick_approve, "0");
                    grd_att.SetGridText(row, c_approve_status, _last_status);
                    //ibtnSave.style.display = "";
                    //chkSetData.style.display = "";
                    //chkApprove.style.display = "";
                    //chkCancel.style.display = "";
                }
                
                
            }
        }
    }

    function OnConfirmRollback()
    {
        if(confirm('Rollback will erase your saved task before, All data will return SUBMIT, you cannot revert your action, Are you sure?'))
            dsoRollBackWTOT.Call("UPDATE");
    }

    function onClickOption(n)
    {
        opt_value = n;
        switch (n)
        {
            case 1:
                DailyDT.SetEnable(1);
                FromDT.SetEnable(0);
                ToDT.SetEnable(0);
                Month.SetEnable(0);
                break;
            case 2:
                DailyDT.SetEnable(0);
                FromDT.SetEnable(1);
                ToDT.SetEnable(1);
                Month.SetEnable(0);
                break;
            case 3:
                DailyDT.SetEnable(0);
                FromDT.SetEnable(0);
                ToDT.SetEnable(0);
                Month.SetEnable(1);
                break;
        }
    }
</script>

<body>
<!------------------------------------------>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HRPROCH0000000_00_CHECK_VIEW"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datWorkShift_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HRSELCH0000000_00_WS_ROLE"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txt_WS_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HRSELCH0000000_00_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


    <gw:data id="dsoApproveWTOT" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="hrselchba003fr_00_att_approval" procedure="hrupdchba003fr_00_att_approval"> 
                <input bind="grd_att" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="lstWS" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstReg" />
                    <input bind="idPrint_type" />
                    <input bind="idConfirm" />
                </input>
                <output  bind="grd_att" />
            </dso> 
        </xml> 
</gw:data>

    <gw:data id="dsoRollBackWTOT" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="hrselchba003fr_00_att_approval" procedure="hrupdchba003fr_00_att_rollback"> 
                <input bind="grd_att" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="lstWS" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstReg" />
                    <input bind="idPrint_type" />
                    <input bind="idConfirm" />
                </input>
                <output  bind="grd_att" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hrproch0000000_00_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
					<input bind="txtCompany_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <gw:data id="datCheck_OT_Approval" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HRSELCH0000000_00_OT_APPROVAL"  > 
                <input>
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="txtOTApprovalYN" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HRSELCH0000000_00_WG_ROLE"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <gw:data id="dsoCheckApproveOT" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HRSELCH0000000_00_OT_APPROVAL"  > 
                <input>
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="txtWTApprovalYN" />
                    <output bind="txtOTApprovalYN" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:23%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
  	
	<tr style="height:7%;border:1">	
		<td colspan=3 align=right style="width:6%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font>Daily</font></td>
		<td colspan=5 align=left style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=2 align=right style="width:4%;border:1"></td>
		<td colspan=5 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=3>From</font></td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=3 align=right style="width:6%;border:0"><font>To</font> </td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
        <td align=right colspan=5 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font>Month</font> </td>
		<td align=left colspan=5 style="width:10%;border:0"><gw:datebox id="Month"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month /></td>
		<td colspan=3 align=right valign="bottom" style="width:6%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"></td>
    </tr>	
    <tr style="height:7%;border:1">	
		<td colspan=3 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=9 align=right style="width:18%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td colspan=10 align=right style="width:20%;border:0"><gw:list  id="lstWG"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|W.Group-Select All</data></gw:list>
        </td>
        <td colspan=10 align=right style="width:20%;border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|All W-Shift</data></gw:list>
        </td>
        
        <td colspan=8 align=right style="width:16%;border:0"><gw:list  id="lstReg"  maxlen = "100" styles='width:100%' >
                            <data>|ALL|Reg - Select All|1|Reg Allowance</data></gw:list>
        </td>
         <td align=right colspan=7 style="width:14%;border:0"><gw:list  id="idPrint_type" value="4" styles='width:100%' onChange="">
                <data>|1|Absence|2|Working time|3|Incorrect time|4|Type - Select All</data></gw:list>
         </td>
         <td colspan=3 align=right style="width:6%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" style="display:none" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:7%">	
        <td colspan=3 align=right style="width:6%;border:0">Nation</td>	
        <td colspan=4 align=right style="width:8%;border:0">
            <gw:list id='lstNation' value='01'>
                <data>
                    <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
    	<td colspan=3 align=right style="width:6%;border:0"><font color="FF3399">Set Time</font></td>	
		<td colspan=6 align=right style="width:12%;border:0"><gw:list id="idLstInOut"  styles="width:100%" value="0" onchange="change_list()"><data>|3|WT|4|OT|5|NT|7|NT2|6|HT</data></gw:list ></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:label id="idlbHH" styles="width:100%">HH</gw:label></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:textbox id="idHH" maxlen = "5" styles="width:100%" onkeypress="" /></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="OnSetToGrid()"/></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:icon id="idBtnClear"  styles='width:90%' img="in"  text="Clear"  onclick="onClearGrid()"/></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=3 align=right style="width:6%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>
		<td colspan=6 align=center style="width:12%;border:0"><gw:list  id="idConfirm" value="2" styles="width:95%" onChange="">
                <data>|2|SUBMIT|3|APPROVE|4|CANCEL|ALL|Approve Status All</data></gw:list></td>
		<td colspan=4 align=center style="width:8%;border:0"><gw:label id="idRecord" text="0 rec(s)" styles="width:100%" ></gw:label></td>
		
    </tr>	

    <tr style="height:2%;border:inherit">	
        <td colspan=3 align=right style="width:6%;border:1" ></td>
        <td colspan=5 align=left style="width:10%;border:1" ></td>
        <td colspan=11 align=center style="width:22%;border:1" style="color=#FF00CC"><gw:label id="idlbWtOtNtHt" styles="width:100%;"></gw:label></td>
        
        <td colspan=2 align=center valign=middle style="width:4%;border:inherit" ><img status="collapse" id="imgMaster" alt="Show Column" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle()"  /></td>
		
		<td colspan=13 align=center style="width:38%;border:0" ><gw:label id="idlbWS" styles="width:100%;color:red"></gw:label></b></td>
        <td colspan=2 align=center style="width:4%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
        <td colspan=2 align=right style="width:4%;border:0" ><gw:checkbox id="chkRollback" value="F" onclick="OnRollback()" ></gw:checkbox ></td>
        <td colspan=2 align=left style="width:4%;border:0" >Rollback</td>
        <td colspan=2 align=left style="width:4%;border:0" ><gw:icon id="idBtnConfirm"  styles='width:90%' img="in"  text="Confirm"  onclick="OnConfirmRollback()"/></td>
        <td colspan=2 align=right style="width:4%;border:0" ></td>
		<td colspan=2 align=left style="width:4%;border:0" ></td>
        <td colspan=1 align=right style="width:4%;border:0"><gw:checkbox id="chkApprove" value="F" onclick="OnTickApprove()" ></gw:checkbox ></td>
        <td colspan=1 align=left style="width:4%;border:0">Approve</td>
        <td colspan=1 align=right style="width:4%;border:0"><gw:checkbox id="chkCancel" value="F" onclick="OnTickCancel()" ></gw:checkbox ></td>
        <td colspan=1 align=lect style="width:4%;border:0">Cancel</td>
        
    </tr>	
        
	</table>
	<table id="tbl" style="width:100%;height:77%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="_EMP_PK|ORGANIZATION|WGROUP|EMP_ID|FULL_NM|W_S|DATE_IN|IN TIME|DATE_OUT|OUT TIME|WT|OT|NT|NT2|HT||STATUS|WT|OT|NT|NT2|HT|WorkDT|WGROUP|Hol_type|_OT Plus|_close|_thr_ot_approval_pk|_date now|_date next|_status old|_status new"
					format="0|0|0|0|0|0|4|0|4|0|0|0|0|0|0|3|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="||||||||||||||||||||||||||||||||"
				   editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0"                    
					widths="0|1500|1500|1000|2500|500|1000|1000|1000|1000|500|500|500|500|500|500|1500|500|500|500|500|500|1500|1500|600|1000|600|500|500|500|1000|1000"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit()"
					acceptNullDate="T"
                    debug="T"
                    
					oncelldblclick = "Popup()"
					onentercell = "On_click()"/>
			</td>
		</tr>	
	</table>
</table>

	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtFrom" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
	<gw:textbox id="txtCompany_pk" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>
    <gw:list  id="lstWS_temp" value="ALL"  maxlen = "100" styles='display:none' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>             
    <gw:textbox id="txt_WS_temp" styles="display:none"/>             
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />              
    <gw:textbox id="txtOTApprovalYN" text="" styles="display:none"  />             
    <gw:textbox id="txtWTApprovalYN" text="" styles="display:none"  /> 
	
</body>
</html>

