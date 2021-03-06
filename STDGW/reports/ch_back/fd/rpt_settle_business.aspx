﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string bz_pk;
       
    bz_pk = Request["p_biz_trip_pk"].ToString(); 
    
    
    string SQL
	= "select a.APPLICATION_NO " + 
        ",to_char(d.SUBMIT_TIME,'dd/mm/yyyy') " +
        ",b.emp_id " +
        ",b.full_name " +
        ",c.org_nm " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code=b.pos_type)  " +
        ",to_char(d.DEPT_SIGN_DT,'dd/mm/yyyy') " +
        ",to_char(d.GA_STAFF_SIGN_DT,'dd/mm/yyyy') " +
        ",to_char(d.GA_dept_SIGN_DT,'dd/mm/yyyy') " +
        ",(select code_nm from vhr_hr_code where id='HR0059' and code=a.B_OBJECT ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and d.manager_pk=g.thr_emp_pk ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and d.ga_staff_pk=g.thr_emp_pk ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and d.ga_manager_pk=g.thr_emp_pk ) " +
        "from thr_biz_trip a,thr_employee b,comm.tco_org c,thr_biz_settle_expenses d " +
        "where a.del_if=0  and c.del_if=0 and d.del_if=0 " +
        "and b.del_if=0 and a.THR_EMP_PK=b.pk and d.thr_biz_pk=a.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.pk=" + bz_pk ;


        //Response.Write(SQL);
        //Response.End();
     
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow;
        irow = dt_total.Rows.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
        //-------------------companion 
        string SQL_Com
	    = " select " + 
        "        a.COMPANER_ID, " +
        "        a.COMPANER_NM, " +
        "        c.org_nm, " +
        "        (select code_nm from vhr_hr_code where id='HR0008' and code=a.POS_TYPE) " +
        "        from thr_biz_companion a,comm.tco_org c " +
        "        where a.del_if=0 and c.del_if(+)=0 " +
        "        and a.tco_dept_pk=c.pk(+) " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "        order by a.companer_id " ;
        
        DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
        int irow_com;
        irow_com = dt_Com.Rows.Count;
        //----------------Schedule 
        string SQL_Sch
	    = "select " + 
        "        to_char(to_date(a.S_FROM,'yyyymmdd'),'dd/mm/yyyy'), " +
        "        to_char(to_date(a.S_to,'yyyymmdd'),'dd/mm/yyyy'), " +
        "        a.DEPARTURE_COUNTRY, " +
        "        a.DEPARTTURE_CITY, " +
        "        a.ARRIVAL_COUNTRY, " +
        "        a.ARRIVAL_CITY, " +
        "        a.PLAN " +
        "        from THR_BIZ_SCHEDULE a " +
        "        where a.del_if=0 " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "        order by a.s_from " ;
        DataTable dt_Sch = ESysLib.TableReadOpen(SQL_Sch);
        int irow_sch;
        irow_sch = dt_Sch.Rows.Count;

        
        //----------------Transportation 
        string SQL_Tra
	    = "SELECT B.S_DEPARTURE,B.S_ARRIVAL " + 
        "        ,(SELECT C.CODE_NM FROM VHR_HR_CODE C WHERE C.ID='HR0063' AND C.CODE=B.GO_BY) AS GO_BY " +
        "        ,(SELECT char_1 FROM VHR_HR_CODE B,THR_BIZ_TRIP C WHERE  C.DEL_IF=0 AND B.CODE=C.CURRENCY AND ID='HR0040' and c.pk=" + bz_pk + ")  " +
        "        ,nvl(B.APPLIED_AMT,0) " +
        "        ,nvl(B.ACTUAL_AMT ,0)" +
        "        ,B.REASON,B.REMARK " +
        "        FROM THR_SETTLE_TRANS B " +
        "        WHERE B.DEL_IF=0 " +
        "        AND B.THR_BIZ_SETTLE_PK=" +
        " (select t.pk from THR_BIZ_SETTLE_EXPENSES t where t.del_if=0 and THR_BIZ_PK=" + bz_pk + ")" + 
        "        ORDER BY B.PK " ;

        DataTable dt_Tra = ESysLib.TableReadOpen(SQL_Tra);
        int irow_tra;
        irow_tra= dt_Tra.Rows.Count;
         //----------------Other Expense
        string SQL_Oth
	    = "SELECT (SELECT C.CODE_NM FROM VHR_HR_CODE C WHERE C.ID='HR0062' AND C.CODE=B.SO_TYPE) AS OTHER_TYPE " + 
        "        ,B.DESCRIPTION " +
        "        ,(SELECT char_1 FROM VHR_HR_CODE B,THR_BIZ_TRIP C WHERE  C.DEL_IF=0 AND B.CODE=C.CURRENCY AND ID='HR0040' and c.pk=" + bz_pk + ")  " +
        "        ,nvl(APPLIED_AMT,0) " +
        "        ,nvl(ACTUAL_AMT,0) " +
        "        ,B.REASON " +
        "        ,b.REMARK " +
        "        FROM THR_SETTLE_OTHER B " +
        "        WHERE B.DEL_IF=0 " +
        "        AND B.THR_BIZ_SETTLE_PK=" +
        " (select t.pk from THR_BIZ_SETTLE_EXPENSES t where t.del_if=0 and THR_BIZ_PK=" + bz_pk + ")" + 
        "        ORDER BY B.PK " ;

        DataTable dt_Oth = ESysLib.TableReadOpen(SQL_Oth);
        int irow_oth;
        irow_oth= dt_Oth.Rows.Count;
        //----------------Lodging
        string SQL_Lod
	    = "SELECT to_char(to_date(B.L_FROM,'yyyymmdd'),'dd/mm/yyyy') " + 
        "        ,to_char(to_date(B.L_TO,'yyyymmdd'),'dd/mm/yyyy') " +
        "        ,B.L_COUNTRY " +
        "        ,B.L_CITY " +
        "        ,L_NAME " +
        "        ,nvl(B.AMOUNT,0) " +
        "        ,B.REMARK " +
        "        FROM THR_SETTLE_LODGING B " +
        "        WHERE B.DEL_IF=0 " +
        "        AND B.THR_BIZ_SETTLE_PK=" +
        " (select t.pk from THR_BIZ_SETTLE_EXPENSES t where t.del_if=0 and THR_BIZ_PK=" + bz_pk + ")" + 
        "        order by B.L_FROM " ;


        DataTable dt_Lod = ESysLib.TableReadOpen(SQL_Lod);
        int irow_lod;
        irow_lod= dt_Lod.Rows.Count;
        //----------------Meal
        string SQL_Mea
	    = " SELECT  " + 
        "        to_char(to_date(B.M_FROM,'yyyymmdd'),'dd/mm/yyyy') " +
        "        ,to_char(to_date(B.M_TO,'yyyymmdd'),'dd/mm/yyyy') " +
        "        ,B.AMOUNT " +
        "        ,B.REMARK " +
        "        FROM THR_SETTLE_MEAL B " +
        "        WHERE B.DEL_IF=0 " +
        "        AND B.THR_BIZ_SETTLE_PK=" +
        " (select t.pk from THR_BIZ_SETTLE_EXPENSES t where t.del_if=0 and THR_BIZ_PK=" + bz_pk + ")" + 
        "        order by B.m_FROM " ;



        DataTable dt_Mea = ESysLib.TableReadOpen(SQL_Mea);
        int irow_mea;
        irow_mea= dt_Mea.Rows.Count;
        double sum_app_tra=0;
        double sum_act_tra=0;
        double sum_app_oth=0;
        double sum_act_oth=0;
        double sum_lod=0;
        double sum_mea=0;
        
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_settle_business_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_settle_business_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_settle_business_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tyml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:Created>2009-05-25T06:36:28Z</o:Created>
  <o:LastSaved>2009-05-25T08:31:46Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.98in .75in .98in .75in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=984 style='border-collapse:
 collapse;table-layout:fixed;width:740pt'>
 <col class=xl25 width=133 style='mso-width-source:userset;mso-width-alt:3783;
 width:100pt'>
 <col class=xl25 width=104 style='mso-width-source:userset;mso-width-alt:2958;
 width:78pt'>
 <col class=xl25 width=129 style='mso-width-source:userset;mso-width-alt:3669;
 width:97pt'>
 <col class=xl25 width=117 span=2 style='mso-width-source:userset;mso-width-alt:
 3328;width:88pt'>
 <col class=xl25 width=125 span=2 style='mso-width-source:userset;mso-width-alt:
 3555;width:94pt'>
 <col class=xl25 width=134 style='mso-width-source:userset;mso-width-alt:3811;
 width:101pt'>
 <col class=xl25 width=104 span=248 style='mso-width-source:userset;mso-width-alt:
 2958;width:78pt'>
 <tr height=24 style='height:18.0pt'>
  <td colspan=7 height=24 class=xl24 width=850 style='height:18.0pt;width:639pt'
  x:str="Business Trip Application ">Business Trip Application<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 width=134 style='width:101pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Application No.</td>
  <td class=xl25><% = dt_total.Rows[0][0].ToString()%></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl29>Dept. Manager</td>
  <td class=xl29 style='border-left:none'>GA Staff Review</td>
  <td class=xl29 style='border-left:none'>GA Dept. Manager</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Application Date</td>
  <td class=xl25><% = dt_total.Rows[0][1].ToString()%></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td rowspan=4 height=68 width=125 style='border-bottom:.5pt solid black;
  height:51.0pt;width:94pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:2.25pt;width:83.25pt;height:48pt;z-index:1'>
   <v:imagedata src="" o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:3px;width:111px;
  height:64px'><img width=111 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][10].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=4 height=68 class=xl30 width=125 style='border-bottom:.5pt solid black;
    height:51.0pt;border-top:none;width:94pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026"
   type="#_x0000_t75" style='position:absolute;margin-left:2.25pt;margin-top:2.25pt;
   width:90pt;height:48pt;z-index:2'>
   <v:imagedata src="" o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:3px;margin-top:3px;width:120px;
  height:64px'><img width=120 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][11].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl30 width=125 style='height:12.75pt;border-top:none;
    border-left:none;width:94pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1027"
   type="#_x0000_t75" style='position:absolute;margin-left:2.25pt;margin-top:2.25pt;
   width:90pt;height:48pt;z-index:3'>
   <v:imagedata src="" o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:3;margin-left:3px;margin-top:3px;width:120px;
  height:64px'><img width=120 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][12].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl30 width=134 style='height:12.75pt;border-top:none;
    border-left:none;width:101pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Applicant</td>
  <td class=xl31>Emp ID</td>
  <td class=xl25><% = dt_total.Rows[0][2].ToString()%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl32 style='border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl31>Name</td>
  <td colspan=3 class=xl33 style='border-right:.5pt solid black'><% = dt_total.Rows[0][3].ToString()%></td>
  <td class=xl32 style='border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl31>Department</td>
  <td colspan=3 class=xl33 style='border-right:.5pt solid black'><% = dt_total.Rows[0][4].ToString()%></td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl31>Position</td>
  <td colspan=3 class=xl33 style='border-right:.5pt solid black'><% = dt_total.Rows[0][5].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none'><% = dt_total.Rows[0][6].ToString()%></td>
  <td class=xl36 style='border-top:none'><% = dt_total.Rows[0][7].ToString()%></td>
  <td class=xl37 style='border-top:none'><% = dt_total.Rows[0][8].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Companion</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>No</td>
  <td class=xl29 style='border-left:none'>EMP ID</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Name</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Department</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none' x:str="Position ">Position<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
    if (irow_com==0)
    {
    
  %>
  <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl45 style='height:13.5pt;border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <%
    }
    else
    { %>
 <%
        for (int i = 0; i < irow_com; i++) 
        {
  %> 
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl42 style='height:13.5pt;border-top:none'><% = i+1%></td>
  <td class=xl42 style='border-top:none;border-left:none'><% = dt_Com.Rows[i][0].ToString()%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Com.Rows[i][1].ToString()%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Com.Rows[i][2].ToString()%></td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Com.Rows[i][3].ToString()%></td>
 </tr>
 <%
        }
  } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Object</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=8 height=28 class=xl48 style='height:21.0pt'><% = dt_total.Rows[0][9].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Schedule</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl50 style='border-bottom:.5pt solid black;
  height:25.5pt' x:str="From ">From<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl50 style='border-bottom:.5pt solid black'>To</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Deaprture</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Arrival</td>
  <td colspan=2 rowspan=2 class=xl29>Plan</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none;border-left:
  none'>Country</td>
  <td class=xl29 style='border-top:none;border-left:none'>City</td>
  <td class=xl29 style='border-top:none;border-left:none'>Country</td>
  <td class=xl29 style='border-top:none;border-left:none'>City</td>
 </tr>
 <%
    if (irow_sch==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl42 style='height:12.75pt;border-top:none'> </td>
  <td class=xl42 style='border-top:none;border-left:none'> </td>
  <td class=xl45 style='border-top:none;border-left:none'> </td>
  <td class=xl45 style='border-top:none;border-left:none'> </td>
  <td class=xl45 style='border-top:none;border-left:none'> </td>
  <td class=xl45 style='border-top:none;border-left:none'> </td>
  <td colspan=2 class=xl52 width=259 style='border-right:.5pt solid black;
  border-left:none;width:195pt'> </td>
 </tr>
 <%
    }
    else
    { %>
 <%
        for (int i = 0; i < irow_sch; i++) 
        {
  %> 
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl42 style='height:12.75pt;border-top:none'><% = dt_Sch.Rows[i][0].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][1].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][2].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][3].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][4].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl52 width=259 style='border-right:.5pt solid black;
  border-left:none;width:195pt'><% = dt_Sch.Rows[i][6].ToString()%></td>
 </tr>
  <%
        }
  } %>
  
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Transporation</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>Deaprture</td>
  <td class=xl29 style='border-left:none'>Arrival</td>
  <td class=xl54 style='border-left:none'>Transportation By</td>
  <td class=xl29>Currency</td>
  <td class=xl55 style='border-left:none'>Applied Amount</td>
  <td class=xl29 style='border-left:none'>Actual Amount</td>
  <td class=xl29 style='border-left:none'>Reason</td>
  <td class=xl29 style='border-left:none'>Remark</td>
 </tr>
 <%
    
    if (irow_tra==0)
    {
    
  %>
 <tr class=xl38 height=17 style='height:12.75pt'>
  <td height=17 class=xl57 style='height:12.75pt;border-top:none'></td>
  <td class=xl58 style='border-top:none'></td>
  <td class=xl59 style='border-top:none'></td>
  <td class=xl60 style='border-top:none'></td>
  <td class=xl61 style='border-top:none;border-left:none'></td>
  <td class=xl61 style='border-top:none;border-left:none'></td>
  <td class=xl62 width=125 style='border-top:none;width:94pt'></td>
  <td class=xl62 width=134 style='border-top:none;width:101pt'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_tra; i++) 
        {
            sum_app_tra +=double.Parse(dt_Tra.Rows[i][4].ToString());
            sum_act_tra +=double.Parse(dt_Tra.Rows[i][5].ToString());
  %> 
  <tr class=xl38 height=17 style='height:12.75pt'>
  <td height=17 class=xl57 style='height:12.75pt;border-top:none'><%=dt_Tra.Rows[i][0].ToString() %></td>
  <td class=xl58 style='border-top:none'><%=dt_Tra.Rows[i][1].ToString() %></td>
  <td class=xl59 style='border-top:none'><%=dt_Tra.Rows[i][2].ToString() %></td>
  <td class=xl60 style='border-top:none'><%=dt_Tra.Rows[i][3].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dt_Tra.Rows[i][4].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dt_Tra.Rows[i][5].ToString() %></td>
  <td class=xl62 width=125 style='border-top:none;width:94pt'><%=dt_Tra.Rows[i][6].ToString() %></td>
  <td class=xl62 width=134 style='border-top:none;width:101pt'><%=dt_Tra.Rows[i][7].ToString() %></td>
 </tr>
 <%
        }
  } %>
 <tr class=xl38 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=3 class=xl38 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl56>Sum</td>
  <td class=xl61 style='border-top:none' x:num><%=sum_app_tra %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_act_tra %></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Other Expense</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>Type</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Descirption</td>
  <td class=xl29 style='border-left:none'>Currency</td>
  <td class=xl29 style='border-left:none'>Applied Amount</td>
  <td class=xl41>Actual Amount</td>
  <td class=xl29 style='border-left:none'>Reason</td>
  <td class=xl29 style='border-left:none'>Remark</td>
 </tr>
 <%
    if (irow_oth==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'></td>
  <td colspan=2 class=xl64 width=233 style='border-right:.5pt solid black;
  width:175pt'></td>
  <td class=xl60 style='border-top:none;border-left:none'></td>
  <td class=xl61 style='border-top:none;border-left:none'></td>
  <td class=xl61 style='border-top:none;border-left:none'></td>
  <td class=xl62 width=125 style='border-top:none;width:94pt'></td>
  <td class=xl66 width=134 style='border-top:none;width:101pt'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_oth; i++) 
        {
            sum_app_oth+=double.Parse(dt_Oth.Rows[i][3].ToString());
            sum_act_oth+=double.Parse(dt_Oth.Rows[i][4].ToString());
  %> 
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><%=dt_Oth.Rows[i][0].ToString() %></td>
  <td colspan=2 class=xl64 width=233 style='border-right:.5pt solid black;
  width:175pt'><%=dt_Oth.Rows[i][1].ToString() %></td>
  <td class=xl60 style='border-top:none;border-left:none'><%=dt_Oth.Rows[i][2].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dt_Oth.Rows[i][3].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none'  x:num><%=dt_Oth.Rows[i][4].ToString() %></td>
  <td class=xl62 width=125 style='border-top:none;width:94pt'><%=dt_Oth.Rows[i][5].ToString() %></td>
  <td class=xl66 width=134 style='border-top:none;width:101pt'><%=dt_Oth.Rows[i][6].ToString() %></td>
 </tr>
  <%
        }
  } %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=3 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl56>Sum</td>
  <td class=xl61 style='border-top:none'  x:num><%=sum_app_oth %></td>
  <td class=xl61 style='border-top:none;border-left:none'  x:num><%=sum_act_oth %></td>
  <td class=xl38></td>
  <td class=xl25></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Lodging</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl56 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt' x:str="From ">From<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-left:none'>To</td>
  <td class=xl29 style='border-left:none'>Country</td>
  <td class=xl29 style='border-left:none'>City</td>
  <td class=xl29 style='border-left:none'>Name</td>
  <td class=xl29 style='border-left:none'>Amount</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
 </tr>
 <%
    if (irow_lod==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'></td>
  <td class=xl60 style='border-top:none;border-left:none'></td>
  <td class=xl67 style='border-top:none;border-left:none'></td>
  <td class=xl67 style='border-top:none;border-left:none'></td>
  <td class=xl67 style='border-top:none;border-left:none'></td>
  <td class=xl61 style='border-top:none;border-left:none'></td>
  <td colspan=2 class=xl63 style='border-right:.5pt solid black;border-left:
  none'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_lod; i++) 
        {
            sum_lod+=double.Parse(dt_Lod.Rows[i][5].ToString());
  %> 
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'><%=dt_Lod.Rows[i][0].ToString() %></td>
  <td class=xl60 style='border-top:none;border-left:none'><%=dt_Lod.Rows[i][1].ToString() %></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=dt_Lod.Rows[i][2].ToString() %></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=dt_Lod.Rows[i][3].ToString() %></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=dt_Lod.Rows[i][4].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dt_Lod.Rows[i][5].ToString() %></td>
  <td colspan=2 class=xl63 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Lod.Rows[i][6].ToString() %></td>
 </tr>
 <%
        }
  } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl56>Sum</td>
  <td class=xl61 style='border-top:none'  x:num><%=sum_lod %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Meal</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt' x:str="From ">From<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-left:none'>To</td>
  <td class=xl29 style='border-left:none'>Amount</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <%
    if (irow_mea==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'> </td>
  <td class=xl60 style='border-top:none;border-left:none'> </td>
  <td class=xl61 style='border-top:none;border-left:none'> </td>
  <td colspan=2 class=xl69 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt'> </td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_mea; i++) 
        {
            sum_mea+=double.Parse(dt_Mea.Rows[i][2].ToString());
  %> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'><%=dt_Mea.Rows[i][0].ToString() %></td>
  <td class=xl60 style='border-top:none;border-left:none'><%=dt_Mea.Rows[i][1].ToString() %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=dt_Mea.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl69 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt'><%=dt_Mea.Rows[i][3].ToString() %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
        }
  } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl56>Sum</td>
  <td class=xl61 style='border-top:none'  x:num><%=sum_mea %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Total Expense</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt'>Item</td>
  <td class=xl29 style='border-left:none'>Applied Amount</td>
  <td class=xl29 style='border-left:none'>Actual Amount</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt;border-top:none'>Transportation</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_app_tra %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_act_tra %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt'>Other Expense</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_app_oth %></td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_act_oth %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl57 style='height:12.75pt'>Lodging</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num>0.00</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num ><%=sum_lod %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt'>Meal</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num>0.00</td>
  <td class=xl61 style='border-top:none;border-left:none' x:num><%=sum_mea %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl74 style='height:12.75pt'>Sum</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'  x:num><%=sum_app_tra+ sum_app_oth%></td>
  <td class=xl61 style='border-top:none;border-left:none'  x:num><%=sum_act_tra+ sum_act_oth + sum_lod + sum_mea%></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=133 style='width:100pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=134 style='width:101pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
