<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("prod");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string fromdt = "", todt = "",group = "", roll = "", item = "", l_to_date = "";

    fromdt = Request.QueryString["fromdt"];
    todt = Request.QueryString["todt"];
    group = Request.QueryString["group"];
    roll = Request.QueryString["roll"];
    item = Request.QueryString["item"];
    string sqltemp = "select TO_CHAR (TO_DATE ('" + todt + "', 'yyyymmdd') + 1, 'yyyymmdd') || '0700' from dual";
    DataTable dt = ESysLib.TableReadOpen(sqltemp);
    if (dt.Rows.Count>0)
    {
       l_to_date = dt.Rows[0][0].ToString();
    }
    string SQL
    = "SELECT   lot_no, item_code, item_name, " +
        "         comm.f_get_logistic_codename ('LGPC0010', group_lg) group_lg, " +
        "         comm.f_get_logistic_codename ('LGPC0020', work_shift) work_shift, " +
        "         mc_speed, prod_qty, round(weight,2), loss_m, round(loss_kg,2), start_date, start_time, " +
        "        end_date, end_time, " +
        "         ROUND (  (  TO_DATE (end_date || end_time, 'yyyymmddhh24:mi') " +
        "                   - TO_DATE (start_date || start_time, 'yyyymmddhh24:mi') " +
        "                  ) " +
        "                * 24 " +
        "                * 60 " +
        "               ), " +
        "         bobin_no, " +
        "         comm.f_get_logistic_codename ('LGPC0010', lg_group) change_group, " +
        "         comm.f_get_logistic_codename ('LGPC0020', thr_work_shift_pk), " +
        "         change_time, hang_over, defect_name, st_from, st_to, defect_duration, " +
        "         defect_qty " +
        "    FROM (SELECT tb1.lot_no, tb1.item_code, tb1.item_name, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.lg_group " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.group_lg " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN sh.lg_group " +
        "                    ELSE tb1.group_lg " +
        "                 END " +
        "                 END " +
        "                 END group_lg, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.thr_work_shift_pk " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.work_shift " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN sh.thr_work_shift_pk " +
        "                    ELSE tb1.work_shift " +
        "                 END " +
        "                 END " +
        "                 END work_shift, " +
        "                 tb1.mc_speed, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN tb1.prod_qty - NVL (sh.hang_over, 0) " +
        "                    ELSE CASE " +
        "                    WHEN tb1.en_time > '"+l_to_date+"' AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.hang_over " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.prod_qty " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN tb1.prod_qty - NVL (sh.hang_over, 0) " +
        "                    ELSE sh.hang_over " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END prod_qty, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN DECODE (tb1.prod_qty, " +
        "                                    0, 0, " +
        "                                      tb1.weight " +
        "                                    / tb1.prod_qty " +
        "                                    * (tb1.prod_qty - NVL (sh.hang_over, 0)) " +
        "                                   ) " +
        "                    ELSE CASE " +
        "                    WHEN tb1.en_time > '"+l_to_date+"' AND sh.lg_group IS NOT NULL " +
        "                       THEN DECODE (tb1.prod_qty, " +
        "                                    0, 0, " +
        "                                      tb1.weight " +
        "                                    / tb1.prod_qty " +
        "                                    * NVL (sh.hang_over, 0) " +
        "                                   ) " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.weight " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN DECODE (tb1.prod_qty, " +
        "                                    0, 0, " +
        "                                      tb1.weight " +
        "                                    / tb1.prod_qty " +
        "                                    * (tb1.prod_qty - NVL (sh.hang_over, 0)) " +
        "                                   ) " +
        "                    ELSE DECODE (tb1.prod_qty, " +
        "                                 0, 0, " +
        "                                   tb1.weight " +
        "                                 / tb1.prod_qty " +
        "                                 * NVL (sh.hang_over, 0) " +
        "                                ) " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END weight, " +
        "                 tb1.loss_m, tb1.loss_kg, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.change_dt " +
        "                    ELSE CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NULL " +
        "                       THEN tb1.start_date " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.start_date " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN sh.change_dt " +
        "                    ELSE tb1.start_date " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END start_date, " +
        "                 CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.change_time " +
        "                    ELSE CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NULL " +
        "                       THEN tb1.start_time " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.start_time " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN sh.change_time " +
        "                    ELSE tb1.start_time " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END start_time, " +
        "                 CASE " +
        "                    WHEN tb1.en_time > '"+l_to_date+"' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN NVL (sh.change_dt, tb1.end_date) " +
        "                    ELSE CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NULL " +
        "                       THEN tb1.start_date " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.end_date " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN tb1.end_date " +
        "                    ELSE NVL (sh.change_dt, tb1.end_date) " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END end_date, " +
        "                 CASE " +
        "                    WHEN tb1.en_time > '"+l_to_date+"' " +
        "                    AND sh.lg_group IS NOT NULL " +
        "                       THEN sh.change_time " +
        "                    ELSE CASE " +
        "                    WHEN tb1.st_time < '"+fromdt+"' || '0700' " +
        "                    AND sh.lg_group IS NULL " +
        "                       THEN tb1.start_time " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = 'ALL' " +
        "                       THEN tb1.end_time " +
        "                    ELSE CASE " +
        "                    WHEN '"+group+"' = sh.lg_group " +
        "                       THEN tb1.end_time " +
        "                    ELSE NVL (sh.change_time, tb1.end_time) " +
        "                 END " +
        "                 END " +
        "                 END " +
        "                 END end_time, " +
        "                 tb1.DURATION, tb1.bobin_no, " +
        "                 DECODE ('"+group+"', 'ALL', sh.lg_group, NULL) lg_group, " +
        "                 DECODE ('"+group+"', " +
        "                         'ALL', sh.thr_work_shift_pk, " +
        "                         NULL " +
        "                        ) thr_work_shift_pk, " +
        "                 DECODE ('"+group+"', 'ALL', sh.change_time, NULL) change_time, " +
        "                 DECODE ('"+group+"', 'ALL', sh.hang_over, NULL) hang_over, " +
        "                 e.defect_name, e.st_from, e.st_to, e.defect_duration, " +
        "                 e.defect_qty " +
        "            FROM (SELECT   a.pk, a.tco_item_pk, b.item_code, b.item_name, " +
        "                           a.att14 group_lg, a.work_shift, a.att04 mc_speed, " +
        "                           c.lot_no, a.prod_qty, a.weight, " +
        "                           DECODE (a.loss_yn, " +
        "                                   'Y', a.att05 * a.att04, " +
        "                                   0 " +
        "                                  ) loss_m, " +
        "                           DECODE " +
        "                              (a.loss_yn, " +
        "                               'Y', a.att05 " +
        "                                * a.att04 " +
        "                                * sale.sf_get_dsbs00010_2 (4, a.tco_item_pk) " +
        "                                * sale.sf_get_dsbs00010_2 (5, a.tco_item_pk) " +
        "                                * prod.sf_get_gravity (a.tco_item_pk, NULL), " +
        "                               0 " +
        "                              ) loss_kg, " +
        "                           SUBSTR (a.st_time, 1, 8) start_date, " +
        "                           (   SUBSTR (a.st_time, 9, 2) " +
        "                            || ':' " +
        "                            || SUBSTR (a.st_time, 11, 2) " +
        "                           ) start_time, " +
        "                           SUBSTR (a.en_time, 1, 8) end_date, " +
        "                           (   SUBSTR (a.en_time, 9, 2) " +
        "                            || ':' " +
        "                            || SUBSTR (a.en_time, 11, 2) " +
        "                           ) end_time, " +
        "                           a.att05 DURATION, a.att02 bobin_no, " +
        "                           a.att16 hand_over_qty, a.st_time, a.en_time, " +
        "                           a.tpr_workins_pk " +
        "                      FROM prod.tpr_prodresult a, " +
        "                           comm.tco_item b, " +
        "                           prod.tpr_lotno c, " +
        "                           prod.tpr_workins d " +
        "                     WHERE a.del_if = 0 " +
        "                       AND b.del_if(+) = 0 " +
        "                       AND c.del_if(+) = 0 " +
        "                       AND d.del_if(+) = 0 " +
        "                       AND a.tpr_workins_pk = d.pk(+) " +
        "                       AND d.wi_type = '1' " +
        "                       AND a.tpr_lotno_pk = c.pk(+) " +
        "                       AND a.tco_item_pk = b.pk(+) " +
        "                       AND a.st_time < '"+l_to_date+"' " +
        "                       AND a.en_time > '"+fromdt+"' || '0700' " +
        "                       AND (   b.item_code LIKE '%' || UPPER ('"+item+"') || '%' " +
        "                            OR b.item_name LIKE '%' || UPPER ('"+item+"') || '%' " +
        "                           ) " +
        "                  ORDER BY start_date, start_time, c.lot_no) tb1, " +
        "                 (SELECT   c.defect_name, a.att01 st_from, a.att02 st_to, " +
        "                           a.att03 defect_duration, a.defect_qty, " +
        "                           b.tpr_prodresult_pk " +
        "                      FROM prod.tpr_oqcdefect a, " +
        "                           prod.tpr_oqcresult b, " +
        "                           prod.tpr_defect c " +
        "                     WHERE a.del_if = 0 " +
        "                       AND b.del_if = 0 " +
        "                       AND a.tpr_oqcresult_pk = b.pk " +
        "                       AND c.del_if = 0 " +
        "                       AND a.tpr_defect_pk = c.pk " +
        "                  ORDER BY a.att01) e, " +
        "                 (SELECT shift.thr_work_shift_pk, " +
        "                         NVL (shift.lg_group, '-') lg_group, " +
        "                         shift.tpr_workins_pk, hang_over, change_dt, " +
        "                            change_dt " +
        "                         || NVL (REPLACE (change_time, ':'), '0000') c_time, " +
        "                         shift.change_time " +
        "                    FROM tpr_prod_shift shift " +
        "                   WHERE del_if = 0) sh " +
        "           WHERE tb1.pk = e.tpr_prodresult_pk(+) " +
        "             AND tb1.tpr_workins_pk = sh.tpr_workins_pk(+) " +
        "             AND tb1.en_time > sh.c_time(+) " +
        "             AND tb1.st_time < sh.c_time(+) " +
        "             AND tb1.start_time >= e.st_from(+) " +
        "             AND tb1.end_time <= e.st_to(+)) temp " +
        "   WHERE temp.group_lg LIKE DECODE ('"+group+"', 'ALL', '%', '"+group+"') " +
        "     AND temp.start_date || REPLACE (temp.start_time, ':') <> " +
        "                                 temp.end_date || REPLACE (temp.end_time, ':') " +
        "     AND (   '"+roll+"' IS NULL " +
        "          OR (temp.lot_no LIKE '%' || UPPER ('"+roll+"') || '%') " +
        "         ) " +
        "ORDER BY 12, 13 ";
    dt = ESysLib.TableReadOpen(SQL);
    //DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_sel_fpep00060_1", "'" + fromdt + "','" + todt + "','" + group + "','" + item + "','" + roll + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpep000601_files/filelist.xml">
<link rel=Edit-Time-Data href="fpep000601_files/editdata.mso">
<link rel=OLE-Object-Data href="fpep000601_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2009-07-02T02:43:40Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2009-07-02T02:48:02Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"hh\:mm";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"hh\:mm";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:Fixed;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:Fixed;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:Fixed;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>51</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6150</x:WindowHeight>
  <x:WindowWidth>11715</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1965 style='border-collapse:
 collapse;table-layout:fixed;width:1475pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=67 span=4 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:2000;width:35pt'>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=20 height=33 class=xl41 width=1619 style='height:24.75pt;
  width:1215pt'>LIST OF MILL ROLL</td>
  <td width=58 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=32 style='width:24pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=20 height=17 class=xl42 style='height:12.95pt'>From:<%=fromdt.ToString().Substring(6, 2) + "/" + fromdt.ToString().Substring(4, 2) + "/" + fromdt.ToString().Substring(0, 4)%>  to
  :<%=todt.ToString().Substring(6, 2) + "/" + todt.ToString().Substring(4, 2) + "/" + todt.ToString().Substring(0, 4)%> </td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td rowspan=2 height=34 class=xl43 style='border-bottom:.5pt solid black;
  height:25.9pt;border-top:none'>No</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Roll Id</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Item Code</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Item Name</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Group</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Shift</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Line Speed</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Prod Qty</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Weight</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Loss(M)</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Loss (KG)</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>St DT</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>St Time</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>End DT</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>End Time</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Duration</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Bobbin No</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Change Group</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Change Shift</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>Change Time</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black'>Hang Over</td>
  <td colspan=5 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Defect</td>
 </tr>
 <tr class=xl24 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 style='height:12.95pt'>Name</td>
  <td class=xl25>St Time</td>
  <td class=xl25>End Time</td>
  <td class=xl25>Duration</td>
  <td class=xl25>Qty</td>
 </tr>
 <%
    float prod_qty = 0, prod_weight = 0, prod_dur = 0, def_dur=0,def_qty=0 , loss_m=0, loss_kg =0,sum_dur_x_sped=0;
    string temp_lotno, temp_shift;
    for(int i = 0; i<dt.Rows.Count;i++)
    {
        temp_lotno = dt.Rows[i][0].ToString();
        temp_shift = dt.Rows[i][3].ToString();

        def_dur = float.Parse('0' + dt.Rows[i][23].ToString()) + def_dur;
        def_qty = float.Parse('0' + dt.Rows[i][24].ToString()) + def_qty;
        if (i == 0)
        {
            prod_qty = float.Parse('0' + dt.Rows[i][6].ToString()) + prod_qty;
            prod_weight = float.Parse('0' + dt.Rows[i][7].ToString()) + prod_weight;
            prod_dur = float.Parse('0' + dt.Rows[i][14].ToString()) + prod_dur;
            loss_m = float.Parse('0' + dt.Rows[i][8].ToString()) + loss_m;
            loss_kg = float.Parse('0' + dt.Rows[i][9].ToString()) + loss_kg;
            sum_dur_x_sped = float.Parse('0' + dt.Rows[i][14].ToString()) * float.Parse('0' + dt.Rows[i][5].ToString()) + sum_dur_x_sped;
        }
        else
        {
            if (temp_lotno != dt.Rows[i - 1][0] || temp_shift != dt.Rows[i - 1][3])
            {
                prod_qty = float.Parse('0' + dt.Rows[i][6].ToString()) + prod_qty;
                prod_weight = float.Parse('0' + dt.Rows[i][7].ToString()) + prod_weight;
                prod_dur = float.Parse('0' + dt.Rows[i][14].ToString()) + prod_dur;
                loss_m = float.Parse('0' + dt.Rows[i][8].ToString()) + loss_m;
                loss_kg = float.Parse('0' + dt.Rows[i][9].ToString()) + loss_kg;
                sum_dur_x_sped = float.Parse('0' + dt.Rows[i][14].ToString()) * float.Parse('0' + dt.Rows[i][5].ToString()) + sum_dur_x_sped;
            }

        }
   %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl26 style='height:12.95pt' x:num><%=i+1 %></td>
  <td class=xl27><%=dt.Rows[i][0]%></td>
  <td class=xl27><%=dt.Rows[i][1]%></td>
  <td class=xl27><%=dt.Rows[i][2]%></td>
  <td class=xl27><%=dt.Rows[i][3]%></td>
  <td class=xl27 align=right x:num><%=dt.Rows[i][4]%></td>
  <td class=xl28 align=right x:num><%=dt.Rows[i][5]%></td>
  <td class=xl29 align=right x:num><%=dt.Rows[i][6]%></td>
  <td class=xl29 align=right x:num><%=dt.Rows[i][7]%></td>
  <td class=xl28 align=right x:num><%=dt.Rows[i][8]%></td>
  <td class=xl29 align=right x:num><%=dt.Rows[i][9]%></td>
  <td class=xl30><%=dt.Rows[i][10].ToString().Substring(6, 2) + "/" + dt.Rows[i][10].ToString().Substring(4, 2) + "/" + dt.Rows[i][10].ToString().Substring(0, 4)%></td>
  <td class=xl31 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl30><%=dt.Rows[i][12].ToString().Substring(6, 2) + "/" + dt.Rows[i][12].ToString().Substring(4, 2) + "/" + dt.Rows[i][12].ToString().Substring(0, 4)%></td>
  <td class=xl31 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][14]%></td>
  <td class=xl29 align=center ><%=dt.Rows[i][15]%></td>
  <td class=xl33><%=dt.Rows[i][16]%></td>
  <td class=xl34><%=dt.Rows[i][17]%></td>
  <td class=xl31><%=dt.Rows[i][18]%></td>
  <td class=xl28><%=dt.Rows[i][19]%></td>
  <td class=xl27><%=dt.Rows[i][20]%></td>
  <td class=xl31><%=dt.Rows[i][21]%></td>
  <td class=xl31><%=dt.Rows[i][22]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][23]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][24]%></td>
 </tr>
 <%
    }
  %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=4 height=17 class=xl39 style='height:12.95pt'>TỔNG CỘNG</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl27 align=right x:num></td>
  <td class=xl36 align=right x:num><%=Math.Round(sum_dur_x_sped / prod_dur)%></td>
  <td class=xl36 align=right x:num><%=prod_qty%></td>
  <td class=xl36 align=right x:num><%=prod_weight %></td>
  <td class=xl36 align=right x:num><%=loss_m%></td>
  <td class=xl36 align=right x:num><%=loss_kg%></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl36 align=right x:num></td>
  <td class=xl37 align=right x:num><%=prod_dur %></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl36 align=right x:num></td>
  <td class=xl36 align=right x:num></td>
  <td class=xl38 style='border-top:none;border-left:none' ></td>
  <td class=xl38 style='border-top:none;border-left:none'></td>
  <td class=xl37 x:num><%=def_dur %></td>
  <td class=xl37 x:num><%=def_qty %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=50 style='width:24pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
