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
c_n1 = 7,
c_in_time = 8,
c_date_out = 9,
c_n2 = 10,
c_out_time = 11,
c_wt = 12,
c_ot = 13,
c_nt = 14,
c_nt2 = 15,
c_ht = 16,
c_tick_submit = 17,
c_approve_status = 18,
c_wt_approve = 19,
c_ot_approve = 20,
c_nt_approve = 21,
c_nt2_approve = 22,
c_ht_approve = 23,
c_abs_code = 24,
c_abs_hour = 25,
c_ale = 26,
c_wkd_pk = 27,
c_ot_pk = 28,
c_abs_pk = 29,
c_work_dt = 30,
c_work_group2 = 31,
c_nt_pk = 32,
c_ht_pk = 33,
c_date_now = 34,
c_date_next = 35,
c_hol_type = 36,
c_mod_by_hand = 37,
c_no_scan = 38,
c_status = 39,
nt2_pk = 40,
c_ot_plus = 41,
c_close = 42,
c_note_att = 43,
c_confirm = 44;
c_thr_att_approval_pk = 45;
c_approve_status_old = 46;
c_approve_status_new = 47;

function BodyInit() {
    if (v_language != "ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text = "<%=Session("COMPANY_PK")%>";
    user = "<%=session("USER_NAME")%>";
    menu_id.text = System.Menu.GetMenuID();
    var tmp;
    tmp = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0003' and a.code<>'04' union SELECT NULL,'' FROM DUAL ") %>";
     grd_att.SetComboFormat(c_abs_code, tmp);
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
     grd_att.GetGridControl().ColHidden(c_n1) = 1;
     grd_att.GetGridControl().ColHidden(c_date_out) = 1;
     grd_att.GetGridControl().ColHidden(c_n2) = 1;
     idlbN1.style.display = 'none';
     D_IN.style.display = 'none';
     idlbN2.style.display = 'none';
     D_OUT.style.display = 'none';
     ChangeColorItem(lstOrg.GetControl());

     datCheck_View.Call();


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
 //------------------------------------------------------------------------------------
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
 //------------------------------------------------------------------------------------

 /*function OnShowPopup()
 {
         var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
         var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
         if (obj!=null)
         {
              txtUpperDept.text=obj;
              datDeptData.Call();
         }
 }
 */
 function OnShowPopup() {
     var strcom;
     var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
     var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
     if (obj != null) {
         lstOrg.value = obj
         txtUpperDept.text = obj;
         onChange_org();
     }

 }
 //------------------------------------------------------------------------------------

 //------------------------------------------------------------------------------------
 function onSetEnable(n) {
     chkSelectAll.SetEnable(n);
     D_OUT.SetEnable(n);
     D_IN.SetEnable(n);
     ibtnSave.SetEnable(n);
     ibtnDelete.SetEnable(n);
     ibtnUnDelete.SetEnable(n);
 }
 function onSetEnable2(n) {
     idHH.SetEnable(n);
     idMM1.SetEnable(n);
     idMM2.SetEnable(n);
     idBtnSet.SetEnable(n);
     idBtnClear.SetEnable(n);
 }
 //------------------------------------------------------------------------------------
 function OnDataReceive(obj) {
     if (obj.id == "datCheck_View") {
         if (txtFlag_View.text == 'Y') {
             ibtnSave.style.display = "none";
             ibtnDelete.style.display = "none";
             ibtnUnDelete.style.display = "none";
         }

         if ((Trim(iduser_pk.text) != "") && (txtHr_level.text == "1")) //QUYEN BI GIOI HAN 
         {
             datUser_info.Call();
         }
         else {
             onChange_org();
         }
     }
     else if (obj.id == "datAttendence_absence")
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
                 if (grd_att.GetGridData(i, c_approve_status) == "SUBMIT" || grd_att.GetGridData(i, c_approve_status) == "APPROVE")
                 {
                     grd_att.SetRowEditable(i, 0);
                     //alert(1);
                     //return;
                 }
                 else
                 {
                     grd_att.SetRowEditable(i, 1);
                     //alert(2);
                     //return;
                 }
                 //alert(grd_att.GetGridData(i, c_approve_status));
                 
                     
                 if (grd_att.GetGridData(i, c_close) == "M")
                     grd_att.SetCellBgColor(i, c_emp_pk, i, c_close, 0x99FFFF);
                 if (grd_att.GetGridData(i, c_close) == "Y")
                     grd_att.SetCellBgColor(i, c_emp_pk, i, c_close, 0xFFEEFF);


                 if (Trim(grd_att.GetGridData(i, c_hol_type)) != "") {
                     if (Trim(grd_att.GetGridData(i, c_hol_type)) == "HOL") {
                         grd_att.SetCellBgColor(i, c_ht, i, c_ht, 0x3366FF);
                         grd_att.SetCellBold(i, c_ht, i, c_ht, true);
                     }
                     else {
                         grd_att.SetCellBgColor(i, c_ht, i, c_ht, 0xCC9900);
                         grd_att.SetCellBold(i, c_ht, i, c_ht, true);
                     }
                 }
                 grd_att.SetCellBgColor(i, c_tick_submit, i, c_approve_status, 0x90EAF4);
                 grd_att.SetCellBold(i, c_approve_status, i, c_approve_status, true);

                 if (grd_att.GetGridData(i, c_date_in) != grd_att.GetGridData(i, c_date_now))
                     grd_att.SetGridText(i, c_n1, '-1');
                 if (grd_att.GetGridData(i, c_date_out) != grd_att.GetGridData(i, c_date_now))
                     grd_att.SetGridText(i, c_n2, '-1');
                 if (Trim(grd_att.GetGridData(i, c_wt)) == "" ? wt += 0 : wt += Number(grd_att.GetGridData(i, c_wt)));
                 if (Trim(grd_att.GetGridData(i, c_ot)) == "" ? ot += 0 : ot += Number(grd_att.GetGridData(i, c_ot)));
                 if (Trim(grd_att.GetGridData(i, c_nt)) == "" ? nt += 0 : nt += Number(grd_att.GetGridData(i, c_nt)));

                 if (Trim(grd_att.GetGridData(i, c_ht)) == "" ? ht += 0 : ht += Number(grd_att.GetGridData(i, c_ht)));
                 if (Trim(grd_att.GetGridData(i, c_abs_hour)) == "" ? abs += 0 : abs += Number(grd_att.GetGridData(i, c_abs_hour)));

             }
             idlbWtOtNtHt.text = "WT: " + wt + "(H)." + "OT:" + ot + "(H). " + " NT: " + nt + "(H). " + " Absence: " + abs + "(H).";
         }
         else {
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
         datCheck_OT_Approval.Call();
         

     }
     else if (obj.id == "datUser_info") {
         ChangeColorItem(lstOrg.GetControl());
         onChange_org();
     }
     else if (obj.id=="dsoSubmitWTOT")
     {
         for (var i = 1; i < grd_att.rows; i++)
         {
             grd_att.SetCellBgColor(i, c_tick_submit, i, c_approve_status, 0x90EAF4);
             grd_att.SetCellBold(i, c_approve_status, i, c_approve_status, true);
             if (grd_att.GetGridData(i, c_approve_status) == "SUBMIT" || grd_att.GetGridData(i, c_approve_status) == "APPROVE")
             {
                 grd_att.SetRowEditable(i, 0);
             }
             else
             {
                 grd_att.SetRowEditable(i, 1);
             }
         }
     }
     else if (obj.id == "datCheck_OT_Approval" )
     {
         check_init = 1;
         //alert(txtOTApprovalYN.text);
         if(txtOTApprovalYN.text =="Y")
         {
             //idOTApproval.style.display = "";
             grd_att.GetGridControl().ColHidden(c_approve_status) = 0;
             grd_att.GetGridControl().ColHidden(c_ot_approve) = 0;
             grd_att.GetGridControl().ColHidden(c_nt_approve) = 0;
             grd_att.GetGridControl().ColHidden(c_nt2_approve) = 0;
             grd_att.GetGridControl().ColHidden(c_ht_approve) = 0;
             idBtnSubmit.style.display = "";
         }
         else
         {
             //idOTApproval.style.display = "none";
             grd_att.GetGridControl().ColHidden(c_approve_status) = 1;
             grd_att.GetGridControl().ColHidden(c_ot_approve) = 1;
             grd_att.GetGridControl().ColHidden(c_nt_approve) = 1;
             grd_att.GetGridControl().ColHidden(c_nt2_approve) = 1;
             grd_att.GetGridControl().ColHidden(c_ht_approve) = 1;
             idBtnSubmit.style.display = "none";
         }

         if(txtWTApprovalYN.text=="Y")
         {
             grd_att.GetGridControl().ColHidden(c_wt_approve) = 0;
         }
         else
         {
             grd_att.GetGridControl().ColHidden(c_wt_approve) = 1;
         }
     }
 }
 //---------------------------------------------------
 function auto_resize_column(obj, col1, col2, font_size) {
     if (font_size != 0)
         obj.GetGridControl().FontSize = font_size;
     obj.GetGridControl().AutoSize(col1, col2, false, 0);
 }
 //------------------------------------------------------------------------------------

 function onClickOption(n) {
     opt_value = n;
     switch (n) {
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
 //------------------------------------------------------------------------------------

 function change_list() {
     if (idLstInOut.value == "0") {
         onSetEnable2(0);
         return;
     }
     if ((idLstInOut.value == "1") || (idLstInOut.value == "2")) {
         idMM1.style.display = '';
         idMM2.style.display = '';
         idlbHH.text = "HH"
         idlbMM1.text = "MM1"
         idlbMM2.text = "MM2"


     }
     else {
         idMM1.style.display = 'none';
         idMM2.style.display = 'none';
         idlbHH.text = "H"
         idlbMM1.text = ""
         idlbMM2.text = ""

     }
     if (grd_att.rows > 1)
     {
         onSetEnable2(1);
         idHH.GetControl().focus();
     }


 }
 //------------------------------------------------------------------------------------

 function On_AfterEdit() {
     var tmpIN, tmpOUT, tmpDT, ws, temp;
     cIdx = event.col;
     ws = grd_att.GetGridData(event.row, c_ws)
     lstWS_temp.value = ws;
     idlbWS.text = lstWS_temp.GetText();
     
     if (cIdx == c_tick_submit)
     {
         if (grd_att.GetGridData(event.row, c_tick_submit) == "-1")
         {
             if (grd_att.GetGridData(event.row, c_wkd_pk) != "")
             {                 
                 if (grd_att.GetGridData(event.row, c_approve_status) == "SUBMIT" || grd_att.GetGridData(event.row, c_approve_status) == "APPROVE")
                 {
                     alert("Data cannot be submit again, action canceled!\n EmpID:" + grd_att.GetGridData(event.row, c_emp_id));
                    grd_att.SetGridText(event.row, c_tick_submit, '0');
                    return;
                 }
                 
                 if ((txtWTApprovalYN.text == 'Y' &&
                              ((grd_att.GetGridData(event.row, c_hol_type) == '' && grd_att.GetGridData(event.row, c_wt) != '0')
                             || (grd_att.GetGridData(event.row, c_hol_type) != '' && grd_att.GetGridData(event.row, c_wt) != '0')
                             ))
                             || (txtOTApprovalYN.text == 'Y' && (grd_att.GetGridData(event.row, c_ot) != '0'
                                    || grd_att.GetGridData(event.row, c_nt) != '0' || grd_att.GetGridData(event.row, c_ht) != '0'
                                    || grd_att.GetGridData(event.row, c_nt2) != '0')
                             ))
                 {

                 }
                 else
                 {
                     grd_att.SetGridText(event.row, c_tick_submit, '0');
                     alert('Cannot submit blank data!');
                 }

            }
             else
             {
                 alert("Cannot submit now, save data first!\n EmpID:" + grd_att.GetGridData(event.row, c_emp_id));
                 grd_att.SetGridText(event.row, c_tick_submit, '0');
                 return;
            }
         }                  
     }
     if (cIdx == c_in_time) {
         tmpIN = grd_att.GetGridData(event.row, cIdx)
         if (tmpIN.length == 0) {
             grd_att.SetGridText(event.row, cIdx, "")
             //return;
         }
         if ((tmpIN.length != 4) && (tmpIN.length != "")) {
             alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if ((Number(tmpIN.substr(0, 2)) >= 24) || (Number(tmpIN.substr(0, 2)) < 0)) {
             alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if ((Number(tmpIN.substr(2, 2)) >= 60) || (Number(tmpIN.substr(2, 2)) < 0)) {
             alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if (tmpIN.length > 0) {
             tmpIN = tmpIN.substr(0, 2) + ":" + tmpIN.substr(2, 2)
             grd_att.SetGridText(event.row, cIdx, tmpIN)
         }
         // Set Columm WT khi edit
         if (tmpIN != dt_tmp) {
             grd_att.SetGridText(event.row, c_wt, "")
             grd_att.SetGridText(event.row, cIdx, tmpIN)
         }

     }
     if (cIdx == c_out_time) {
         tmpOUT = grd_att.GetGridData(event.row, cIdx)

         if (tmpOUT.length == 0) {
             grd_att.SetGridText(event.row, cIdx, "")
             //return;
         }
         if ((tmpOUT.length != 4) && (tmpOUT.length > 0)) {
             alert("Input Out time is not correct type.(type: hh:mm)\nKiểu giờ out không đúng(hh:mm)")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if ((Number(tmpOUT.substr(0, 2)) >= 24) || (Number(tmpOUT.substr(0, 2)) < 0)) {
             alert("Input Out time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ out phải >=00 và <=23")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if ((Number(tmpOUT.substr(2, 2)) >= 60) || (Number(tmpOUT.substr(2, 2)) < 0)) {
             alert("Input Out time(Minute) is not correct type.(00<= hh < 60)\nKiểu phút phải >=00 và <=59")
             grd_att.SetGridText(event.row, cIdx, '')
             return;
         }
         if (tmpOUT.length > 0) {
             tmpOUT = tmpOUT.substr(0, 2) + ":" + tmpOUT.substr(2, 2)
             grd_att.SetGridText(event.row, cIdx, tmpOUT);
         }
         // Set Columm WT khi edit
         if (tmpOUT != dt_tmp) {
             grd_att.SetGridText(event.row, c_wt, "")
             grd_att.SetGridText(event.row, cIdx, tmpOUT)
         }


     }
     if ((cIdx == c_date_in) || (cIdx == c_date_out)) //date in out
     {
         tmpDT = grd_att.GetGridData(event.row, cIdx)
         if (Number(tmpDT) < Number(grd_att.GetGridData(event.row, c_date_now)) - 1 || Number(tmpDT) > Number(grd_att.GetGridData(event.row, c_date_now)) + 1) {
             if (!confirm("You choose date maybe not correct, Do you want to keep?\nBạn đã chọn ngày không hợp lệ, Bạn chắc chắn?"))
                 grd_att.SetGridText(event.row, cIdx, dt_tmp);
         }
     }
     if (cIdx == c_abs_code || cIdx == c_ws) //ABS
     {
         if (grd_att.GetGridData(event.row, cIdx) == "") {
             grd_att.SetCellBgColor(event.row, cIdx, event.row, cIdx, 0x000000);
             grd_att.SetCellBold(event.row, cIdx, event.row, cIdx, false);
         }
         else if (dt_tmp != grd_att.GetGridData(event.row, cIdx)) {
             grd_att.SetCellBgColor(event.row, cIdx, event.row, cIdx, 0x3366FF);
             grd_att.SetCellBold(event.row, cIdx, event.row, cIdx, true);
         }
     }
     if (cIdx == c_wt) //WT      
     {
         if (Number(grd_att.GetGridData(event.row, cIdx)) > 0 && grd_att.GetGridData(event.row, c_hol_type) != "") {
             alert("This day is holiday, haven't WT.\nNgày này là ngày nghỉ không thể có giờ làm việc chính thức.")
             grd_att.SetGridText(event.row, cIdx, '0');
         }
     }
     //chkSelectAll.value='F';
     if (cIdx == c_n1) {
         if (grd_att.GetGridData(event.row, c_n1) == 0) {
             temp = grd_att.GetGridData(event.row, c_date_now)
             grd_att.SetGridText(event.row, c_date_in, temp)
         }
         else {
             temp = grd_att.GetGridData(event.row, c_date_next)
             grd_att.SetGridText(event.row, c_date_in, temp)
         }
     }
     else if (cIdx == c_n2) {
         if (grd_att.GetGridData(event.row, c_n2) == 0) {
             temp = grd_att.GetGridData(event.row, c_date_now)
             grd_att.SetGridText(event.row, c_date_out, temp)
         }
         else {
             temp = grd_att.GetGridData(event.row, c_date_next)
             grd_att.SetGridText(event.row, c_date_out, temp)
         }
     }
     if (dt_tmp != grd_att.GetGridData(event.row, cIdx)) {
         if (cIdx == c_abs_code || cIdx == c_abs_hour || cIdx == c_no_scan || cIdx == c_ot_plus || cIdx == c_note_att) {
             if (grd_att.GetGridData(event.row, c_status) != "1")
                 grd_att.SetGridText(event.row, c_status, "2");
         }
         else
             grd_att.SetGridText(event.row, c_status, "1");
     }

     if ((grd_att.GetGridData(event.row, c_status) == "1" || grd_att.GetGridData(event.row, c_status) == "2") && (grd_att.GetGridData(event.row, c_close) == "M" || grd_att.GetGridData(event.row, c_close) == "Y" || grd_att.GetGridData(event.row, c_confirm) == "Y")) {
         alert("You can't modify and save this record because this data was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ");
         grd_att.SetGridText(event.row, c_status, "");
         return;
     }



 }
 //------------------------------------------------------------------------------------

 function OnSearch() {
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
                 datAttendence_absence.Call("SELECT");
             }
         }
         else {
             set_Interval(100);
             datAttendence_absence.Call("SELECT");
         }
     }

 }
 //------------------------------------------------------------------------------------
 function OnUpdate() {
     grd_att.GetGridData(1, c_status);
     if (confirm("Do you want to save?\nBạn muốn save?"))
         datAttendence_absence.Call();
 }
 //------------------------------------------------
 function OnToggle() {
     if (imgMaster.status == "expand") {
         imgMaster.status = "collapse";
         grd_att.GetGridControl().ColHidden(c_date_in) = 1;
         grd_att.GetGridControl().ColHidden(c_n1) = 1;
         grd_att.GetGridControl().ColHidden(c_date_out) = 1;
         grd_att.GetGridControl().ColHidden(c_n2) = 1;
         idlbN1.style.display = 'none';
         D_IN.style.display = 'none';
         idlbN2.style.display = 'none';
         D_OUT.style.display = 'none';


         imgMaster.src = "../../../system/images/iconmaximize.gif";
         imgMaster.alt = "Show Column";
     }
     else {
         grd_att.GetGridControl().ColHidden(c_date_in) = 0;
         grd_att.GetGridControl().ColHidden(c_n1) = 0;
         grd_att.GetGridControl().ColHidden(c_date_out) = 0;
         grd_att.GetGridControl().ColHidden(c_n2) = 0;
         idlbN1.style.display = '';
         D_IN.style.display = '';
         idlbN2.style.display = '';
         D_OUT.style.display = '';
         imgMaster.status = "expand";
         imgMaster.src = "../../../system/images/close_popup.gif";
         imgMaster.alt = "Hide Column";
     }

 }
 //-----------------------------------------------------------------------------------
 function OnDelete() {
     var ctrl = grd_att.GetGridControl();
     
     for (var i = 0; i < ctrl.SelectedRows; i++)
     {
         var row = ctrl.SelectedRow(i);
         if (grd_att.GetGridData(row, c_approve_status) == "SUBMIT" || grd_att.GetGridData(row, c_approve_status) == "APPROVE")
         {
             alert("Cannot delete SUBMIT or APPROVE data!\nEmpID: " + grd_att.GetGridData(row, c_emp_id ));
             return;
         }
     }

     for (var i = 1; i <= ctrl.SelectedRows; i++)
     {
         grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_status, "1");
     }
     grd_att.DeleteRow(); 


 }
 //------------------------------------------------------------------------------------

 function OnUndelete() {
     var ctrl = grd_att.GetGridControl();
     grd_att.UnDeleteRow();
     for (var i = 1; i <= ctrl.SelectedRows; i++)
         grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_status, "0");
 }
 //------------------------------------------------------------------------------------
 function OnSelectAll(obj_checkbox, obj_grd) {
     var ctrl = obj_grd.GetGridControl();
     if (obj_checkbox.GetData() == 'T') {
         for (var i = 1; i < ctrl.rows; i++)
             ctrl.IsSelected(i) = "True";
     }
     else {
         for (var i = 1; i < ctrl.rows; i++)
             ctrl.IsSelected(i) = "False";
     }

 }
 function On_click() {
     var ws;
     dt_tmp = grd_att.GetGridData(event.row, event.col)//luu tru gia tri vua click
     ws = grd_att.GetGridData(event.row, c_ws)
     lstWS_temp.value = ws;
     idlbWS.text = lstWS_temp.GetText();

 }
 function On_check_next(n) {
     var flag, temp, ctrl = grd_att.GetGridControl();
     flag = 0;
     if (n == 1)//date in 
     {
         if (ctrl.SelectedRows > 1) {
             if (D_IN.GetData() == 'T') {
                 for (var i = 1; i <= ctrl.SelectedRows; i++) {
                     temp = grd_att.GetGridData(i, c_date_next);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_date_in, temp);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_n1, '-1');
                 }
             }
             else {
                 for (var i = 1; i <= ctrl.SelectedRows; i++) {
                     temp = grd_att.GetGridData(i, c_date_now);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_date_in, temp);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_n1, '0');
                 }
             }
         }
         else {
             alert("Select more than 1 row please, 1 row, you can do in grid.\nViệc này chỉ cho phép khi bạn chọn nhiều hơn 1 dòng, 1 dòng thì chỉnh dưới lưới.")
             D_IN.value = 'F';

         }
     }
     else if (n == 2) {
         if (ctrl.SelectedRows > 1) {
             if (D_OUT.GetData() == 'T') {
                 for (var i = 1; i <= ctrl.SelectedRows; i++) {
                     temp = grd_att.GetGridData(i, c_date_next);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_date_out, temp);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_n2, '-1');
                 }
             }
             else {
                 for (var i = 1; i <= ctrl.SelectedRows; i++) {
                     temp = grd_att.GetGridData(ctrl.SelectedRow(i - 1), c_date_now);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_date_out, temp);
                     grd_att.SetGridText(ctrl.SelectedRow(i - 1), c_n2, '0');
                 }
             }
         }
         else {
             alert("Select more than 1 row please, 1 row, you can do in grid.\nViệc này chỉ cho phép khi bạn chọn nhiều hơn 1 dòng, 1 dòng thì chỉnh dưới lưới.")
             D_OUT.value = 'F';
         }
     }
 }
 //---------------------------------------------------------------------------
 function Popup() {
     var col = event.col;
     var flag = 0;
     if ((col == c_emp_id) || (col == c_fullname)) {
         var fpath = System.RootURL + "/form/ch/ba/chba00020_01.aspx?emp_pk=" + grd_att.GetGridData(event.row, c_emp_pk) + "&dt1=" + grd_att.GetGridData(event.row, c_date_now)
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
                 grd_att.SetGridText(event.row, c_status, "1");
             }
         }
     }
     else if (col == c_ws) {
         var fpath = System.RootURL + "/form/ch/ba/chba00020_02.aspx?shift=" + grd_att.GetGridData(event.row, c_ws);
         var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:yes;status:no;dialogWidth:40;dialogHeight:15;dialogLeft:100;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
         if (obj != null) {
             if (obj[0] != grd_att.GetGridData(event.row, c_ws)) {
                 grd_att.SetGridText(event.row, col, obj[0]);
                 grd_att.SetCellBgColor(event.row, c_ws, event.row, c_ws, 0x3366FF);
                 grd_att.SetCellBold(event.row, c_ws, event.row, c_ws, true);
                 lstWS_temp.value = obj[0];
                 idlbWS.text = lstWS_temp.GetText();
                 grd_att.SetGridText(event.row, c_status, "1");

             }
         }
         //alert(obj[0]);
     }
     else if (col == c_abs_code) {
         var fpath = System.RootURL + "/form/ch/ba/chba00020_03.aspx?abs_code=" + grd_att.GetGridData(event.row, c_abs_code);
         var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:25;dialogLeft:200;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
         if (obj != null) {
             if (obj[0] != grd_att.GetGridData(event.row, c_abs_code)) {
                 grd_att.SetGridText(event.row, col, obj[0]);
                 grd_att.SetCellBgColor(event.row, c_abs_code, event.row, c_abs_code, 0x3366FF);
                 grd_att.SetCellBold(event.row, c_abs_code, event.row, c_abs_code, true);
                 if (grd_att.GetGridData(event.row, c_status) != "1")
                     grd_att.SetGridText(event.row, c_status, "2");
             }
         }

     }
     if ((grd_att.GetGridData(event.row, c_status) == "1" || grd_att.GetGridData(event.row, c_status) == "2") && (grd_att.GetGridData(event.row, c_close) == "M" || grd_att.GetGridData(event.row, c_close) == "Y")) {
         alert("You can't modify and save this record because salary period was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ");
         grd_att.SetGridText(event.row, c_status, "");
         return;
     }

 }
 //---------------------------------------------------------------------------
 function get_random(num) {
     var ranNum = Math.floor(Math.random() * num);//tra ra so nguyen
     return ranNum;
 }
 //---------------------------------------------------------------
 function OnSetToGrid() {
     var gCtrl, i;
     var input_time, hh, mm1, mm2
     var mm_tmp, ran_var, result
     gCtrl = grd_att.GetGridControl();
     mm1 = Trim(idMM1.text);
     mm2 = Trim(idMM2.text);
     hh = Trim(idHH.text);

     if (gCtrl.rows > 1) {
         if (gCtrl.SelectedRows <= 1) {
             if (confirm("Set to all blank records (not include holiday)?\nĐiền vào tất cả những dòng còn trống (không kể ngày nghỉ)?")) {
                 for (i = 1; i < gCtrl.rows; i++) {
                     if ((Number(mm1) >= 0) && (Number(mm1) < 60) && (Number(mm2) >= 0) && (Number(mm2) < 60) && (Number(hh) >= 0) && (Number(hh) <= 23) && (Number(mm1) < Number(mm2))
                         && (mm1.length == 2) && (mm2.length == 2) && (hh.length == 2)) {
                         mm_tmp = Number(mm2) - Number(mm1);
                         ran_var = get_random(mm_tmp) + Number(mm1);
                         if (Number(ran_var) < 10)
                             ran_var = "0" + ran_var;
                         result = hh + ":" + ran_var;
                         if (idLstInOut.value == "1") //in
                         {
                             if (grd_att.GetGridData(i, c_in_time) == "") {
                                 var day_type;
                                 day_type = grd_att.GetGridData(i, c_hol_type); //day type
                                 if (day_type == 0) {
                                     grd_att.SetGridText(i, c_in_time, result);
                                     grd_att.SetGridText(i, c_status, "1");
                                 }
                             }
                         }
                         if (idLstInOut.value == "2") //out
                         {

                             if (grd_att.GetGridData(i, c_out_time) == "") {
                                 var day_type;
                                 day_type = grd_att.GetGridData(i, c_hol_type); //day type
                                 if (day_type == 0) {
                                     grd_att.SetGridText(i, c_out_time, result);
                                     grd_att.SetGridText(i, c_status, "1");
                                 }

                             }
                         }
                     }
                     else if (idLstInOut.value == "3") {
                         grd_att.SetGridText(i, c_wt, Trim(idHH.text));
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     else if (idLstInOut.value == "4") {
                         grd_att.SetGridText(i, c_ot, Trim(idHH.text));
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     else if (idLstInOut.value == "5") {
                         grd_att.SetGridText(i, c_nt, Trim(idHH.text));
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     else if (idLstInOut.value == "7") //NT2
                     {
                         grd_att.SetGridText(i, c_nt2, Trim(idHH.text));
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     else if (idLstInOut.value == "6")//HT 
                     {
                         grd_att.SetGridText(i, c_ht, Trim(idHH.text));
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     else {
                         alert("Incorrect type of time.(HH:00->24),(mm1,mm2: 00->60), pld try again\nKiểu giờ bạn nhập không đúng, hãy nhập lại?")
                         return;
                     }
                 }
             }
         }
         else {
             for (i = 0; i < gCtrl.SelectedRows; i++) {
                 var tmp = gCtrl.SelectedRow(i);

                 if ((Number(mm1) >= 0) && (Number(mm1) < 60) && (Number(mm2) >= 0) && (Number(mm2) < 60) && (Number(hh) >= 0) && (Number(hh) <= 23) && (Number(mm1) < Number(mm2))
                     && (mm1.length == 2) && (mm2.length == 2) && (hh.length == 2)) {
                     mm_tmp = Number(mm2) - Number(mm1)
                     ran_var = get_random(mm_tmp) + Number(mm1)
                     if (Number(ran_var) < 10)
                         ran_var = "0" + ran_var
                     result = hh + ":" + ran_var

                     if (idLstInOut.value == "1") {
                         grd_att.SetGridText(tmp, c_in_time, result);
                         grd_att.SetGridText(tmp, c_status, "1");
                     }
                     if (idLstInOut.value == "2") {
                         grd_att.SetGridText(tmp, c_out_time, result);
                         grd_att.SetGridText(tmp, c_status, "1");
                     }

                 }
                 else if (idLstInOut.value == "3") {
                     grd_att.SetGridText(tmp, c_wt, Trim(idHH.text));
                     grd_att.SetGridText(tmp, c_status, "1");
                 }
                 else if (idLstInOut.value == "4") {
                     grd_att.SetGridText(tmp, c_ot, Trim(idHH.text));
                     grd_att.SetGridText(tmp, c_status, "1");
                 }
                 else if (idLstInOut.value == "5") {
                     grd_att.SetGridText(tmp, c_nt, Trim(idHH.text));
                     grd_att.SetGridText(tmp, c_status, "1");
                 }
                 else if (idLstInOut.value == "7") {
                     grd_att.SetGridText(tmp, c_nt2, Trim(idHH.text));
                     grd_att.SetGridText(tmp, c_status, "1");
                 }
                 else if (idLstInOut.value == "6") {
                     grd_att.SetGridText(tmp, c_ht, Trim(idHH.text));
                     grd_att.SetGridText(tmp, c_status, "1");
                 }
                 else {
                     alert("Incorrect type of time.(HH:00->24),(mm1,mm2: 00->60), pld try again\nKiểu giờ bạn nhập không đúng, hãy nhập lại?");
                     return;
                 }

             }
         }
     }
 }
 //-------------------------------------------------------------
 function onClearGrid() {
     var ctrl, i
     ctrl = grd_att.GetGridControl();
     if (ctrl.SelectedRows <= 1) {
         if (confirm("Set to all blank records")) {
             switch (idLstInOut.value) {
                 case "1": //in
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_in_time, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "2": //out
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_out_time, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "3": //wt
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_wt, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "4": //ot
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_ot, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "5": //nt
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_nt, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "7": //nt
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_nt2, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
                 case "6": //ht
                     for (i = 1; i < ctrl.rows; i++) {
                         grd_att.SetGridText(i, c_ht, "")
                         grd_att.SetGridText(i, c_status, "1");
                     }
                     break;
             }
         }
     }
     else {
         for (i = 0; i < ctrl.SelectedRows; i++) {
             var tmp = ctrl.SelectedRow(i);
             switch (idLstInOut.value) {
                 case "1":
                     grd_att.SetGridText(tmp, c_in_time, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "2":
                     grd_att.SetGridText(tmp, c_out_time, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "3":
                     grd_att.SetGridText(tmp, c_wt, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "4":
                     grd_att.SetGridText(tmp, c_ot, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "5":
                     grd_att.SetGridText(tmp, c_nt, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "7":
                     grd_att.SetGridText(tmp, c_nt2, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
                 case "6":
                     grd_att.SetGridText(tmp, c_ht, "")
                     grd_att.SetGridText(tmp, c_status, "1");
                     break;
             }
         }
     }
 }
 //---------------------------------------------------
 function Numbers(e) {
     //  var ctrl=idTEL.GetControl(); 
     var keynum;
     var keychar;
     var numcheck;
     keynum = event.keyCode;

     if (window.event) // IE 
     {
         keynum = e.keyCode;
     }
     else if (e.which) // Netscape/Firefox/Opera 
     {
         keynum = e.which;
     }
     keychar = String.fromCharCode(keynum);
     numcheck = /\d/;
     return numcheck.test(keychar);
 }
 function OnChangeShift() {
     var ctrl, i
     ctrl = grd_att.GetGridControl();
     if (ctrl.SelectedRows > 1 && lstWS.value != "ALL")
         for (i = 0; i < ctrl.SelectedRows; i++)
             grd_att.SetGridText(ctrl.SelectedRow(i), c_ws, lstWS.value)
 }
 //---------------------------------
 function OnReport() {
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
     txtReport_tmp.text = "attendance_absence_v2.aspx";
     datFind_Report.Call();
 }
 function onChange_org() {
     //if(lstOrg.value!='ALL')
     datWorkGroup_info.Call();
 }
 function OnSubmitWTOT()
 {
     if(confirm('Anytime you submit, data cannot be modified anymore, Y/N ?'))
     {
         for (var i = 1; i < grd_att.rows; i++)
         {
             if (grd_att.GetGridData(i, c_tick_submit) == "-1")
                 if(grd_att.GetGridData(i, c_wkd_pk) == "" )
                 {
                     alert("Cannot submit now, save data first!\n EmpID:" + grd_att.GetGridData(i, c_emp_id));
                     return;
                 }
         }
         dsoSubmitWTOT.Call();
     }
 }
 function OnTickSubmit()
 {
     var ctrl = grd_att.GetGridControl();
     for (var i = 0 ; i < ctrl.SelectedRows ; i++)
     {
         var row = ctrl.SelectedRow(i);
         if (row > 0)
         {
             if (grd_att.GetGridData(row, c_wkd_pk) != "")
             {
                 if (grd_att.GetGridData(row, c_approve_status) == "WAITING" || grd_att.GetGridData(row, c_approve_status) == "CANCEL")
                 {
                     if (chkSubmit.value == 'T')
                     {
                         //alert('ot=' + grd_att.GetGridData(row, c_ot) + ' nt=' + grd_att.GetGridData(row, c_nt) + ' ht=' + grd_att.GetGridData(row, c_ht) + ' nt2=' + grd_att.GetGridData(row, c_nt2));
                         if ((txtWTApprovalYN.text == 'Y' &&
                              ((grd_att.GetGridData(row, c_hol_type) == '' && grd_att.GetGridData(row, c_wt) != '0')
                             || (grd_att.GetGridData(row, c_hol_type) != '' && grd_att.GetGridData(row, c_wt) != '0')
                             ))
                             || (txtOTApprovalYN.text == 'Y' && (grd_att.GetGridData(row, c_ot) != '0'
                                    || grd_att.GetGridData(row, c_nt) != '0' || grd_att.GetGridData(row, c_ht) != '0'
                                    || grd_att.GetGridData(row, c_nt2) != '0')
                             ))
                         {
                             
                             grd_att.SetGridText(row, c_tick_submit, '-1');
                             grd_att.SetGridText(row, c_status, '1');
                         }
                         
                     }                         
                     else
                     {
                         grd_att.SetGridText(row, c_tick_submit, '0');
                         grd_att.SetGridText(row, c_status, '');
                     }                         
                 }
                 if (grd_att.GetGridData(row, c_approve_status) == "SUBMIT" || grd_att.GetGridData(row, c_approve_status) == "APPROVE")
                 {
                     alert("Data cannot be submit again, action canceled!\n EmpID:" + grd_att.GetGridData(row, c_emp_id));
                     return;
                 }
             }
             else
             {
                 alert("Cannot submit now, save data first!\n EmpID:" + grd_att.GetGridData(row, c_emp_id));
                 return;
             }                 
         }
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
<gw:data id="datAttendence_absence" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,5,6,8,9,11,12,13,14,15,16,17,18,24,25,27,28,29,32,33,34,36,38,39,40,41,43,44" function="hrselchba002fr_00_att_abs" procedure="hrupdchba002fr_00_att_abs"> 
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

    <gw:data id="dsoSubmitWTOT" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,5,6,8,9,11,12,13,14,15,16,17,18,24,25,27,28,29,32,33,34,36,38,39,40,41,43,44" function="hrselchba002fr_00_att_abs" procedure="hrupdchba002fr_00_submit"> 
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
                    <output bind="txtWTApprovalYN" />
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
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
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
         <td colspan=3 align=right style="width:6%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
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
		<td colspan=6 align=right style="width:12%;border:0"><gw:list id="idLstInOut"  styles="width:100%" value="0" onchange="change_list()"><data>|0|Choose...|1|Random In time|2|Random Out time|3|WT|4|OT|5|NT|7|NT2|6|HT</data></gw:list ></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:label id="idlbHH" styles="width:100%">HH</gw:label></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:textbox id="idHH" maxlen = "5" styles="width:100%" onkeypress="" /></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:label id="idlbMM1" styles="width:100%">MM1</gw:label></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:textbox id="idMM1" maxlen = "2" styles="width:100%"  onkeypress="return Numbers(event)"/></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:label id="idlbMM2" styles="width:100%">MM2</gw:label></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:textbox id="idMM2"	maxlen = "2" styles="width:100%" onkeypress="return Numbers(event)" /></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="OnSetToGrid()"/></td>
		<td colspan=2 align=right style="width:4%;border:0"><gw:icon id="idBtnClear"  styles='width:90%' img="in"  text="Clear"  onclick="onClearGrid()"/></td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=3 align=right style="width:6%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>
		<td colspan=6 align=center style="width:12%;border:0"><gw:list  id="idConfirm" value="ALL" styles="width:95%" onChange="">
                <data>|1|WAITING|2|SUBMIT|3|APPROVE|4|CANCEL|ALL|Approve Status-All</data></gw:list></td>
		<td colspan=4 align=center style="width:8%;border:0"><gw:label id="idRecord" text="0 rec(s)" styles="width:100%" ></gw:label></td>
		
    </tr>	
        <!--
    <tr id="idOTApproval" style="height:2%;border:inherit">	
        <td colspan=3 align=right style="width:6%;border:1" ></td>
        <td colspan=5 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=11 align=center style="width:22%;border:1" style="color=#FF00CC"></td>
        <td colspan=2 align=right style="width:4%;border:0" ></td>
        <td colspan=2 align=left style="width:4%;border:0" ></td>
        <td colspan=2 align=center valign=middle style="width:4%;border:inherit" ></td>
		<td colspan=2 align=right style="width:4%;border:0" ></td>
		<td colspan=2 align=left style="width:4%;border:0" ></td>
		<td colspan=19 align=center style="width:38%;border:0" ></td>
        <td colspan=2 align=center style="width:4%;border:0"></td>
    </tr> -->
    <tr style="height:2%;border:inherit">	
        <td colspan=3 align=right style="width:6%;border:1" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,grd_att)" ></gw:checkbox ></td>
        <td colspan=5 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=11 align=center style="width:22%;border:1" style="color=#FF00CC"><gw:label id="idlbWtOtNtHt" styles="width:100%;"></gw:label></td>
        <td colspan=2 align=right style="width:4%;border:0" ><gw:label id="idlbN1" styles="width:100%">N</gw:label></td>
        <td colspan=2 align=left style="width:4%;border:0" ><gw:checkbox id="D_IN" value="F" onclick="On_check_next(1)" ></gw:checkbox ></td>
        <td colspan=2 align=center valign=middle style="width:4%;border:inherit" ><img status="collapse" id="imgMaster" alt="Show Column" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle()"  /></td>
		<td colspan=2 align=right style="width:4%;border:0" ><gw:label id="idlbN2" styles="width:100%">N</gw:label></td>
		<td colspan=2 align=left style="width:4%;border:0" ><gw:checkbox id="D_OUT" value="F" onclick="On_check_next(2)" ></gw:checkbox ></td>
		<td colspan=16 align=center style="width:38%;border:0" ><gw:label id="idlbWS" styles="width:100%;color:red"></gw:label></b></td>
        <td colspan=2 align=center style="width:4%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
        <td colspan=1 align=center style="width:4%;border:0"><gw:checkbox id="chkSubmit" value="F" onclick="OnTickSubmit()" ></gw:checkbox ></td>
        <td colspan=2 align=center style="width:4%;border:0"><gw:icon id="idBtnSubmit" img="in" text="Submit WTOT" onclick="OnSubmitWTOT();" /></td>
        
    </tr>	
        
	</table>
	<table id="tbl" style="width:100%;height:77%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="_EMP_PK|ORGANIZATION|WGROUP|EMP_ID|FULL_NM|W_S|DATE_IN|N|IN TIME|DATE_OUT|N|OUT TIME|WT|OT|NT|NT2|HT||STATUS|WT|OT|NT|NT2|HT|ABSENCE CODE|H|ALE|_WKD_PK|_OT_PK|_ABS_PK|WorkDT|_WGROUP|_NT_PK|_HT_PK|_Date_Now|_date_next|_Hol_type|Mod by hand|No Scan|_S|_NT2_PK|OT Plus|_close|Note|Confirm|_thr_att_approval_pk"
					format="0|0|0|0|0|0|4|3|0|4|3|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0"
					defaults="||||||||||||||||||||||||||||||||||||||||||||||"
					editcol="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|1|0|1|0|0"
					widths="0|1500|1500|1000|2500|500|1200|300|1000|1200|300|1000|500|500|500|500|500|500|500|500|500|500|500|500|1500|300|600|0|0|0|1500|1500|0|0|0|0|0|1500|500|0|0|500|0|1000|500|0"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit()"
					acceptNullDate="T"
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

