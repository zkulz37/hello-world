<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_tco_org_pk        = Request["p_tco_org_pk"].ToString();
   string p_wg                 = Request["p_wg"].ToString();   
   string p_lsttemp            = Request["p_lsttemp"].ToString();
   string p_txttemp            = Request["p_txttemp"].ToString();
   string p_category           = Request["p_category"].ToString();
   string p_course             = Request["p_course"].ToString();
   string p_application        = Request["p_application"].ToString();
   string p_course_status      = Request["p_course_status"].ToString();
   string p_from_app           = Request["p_from_app"].ToString();
   string p_to_app             = Request["p_to_app"].ToString();
   string p_from_exp           = Request["p_from_exp"].ToString();
   string p_to_exp             = Request["p_to_exp"].ToString();
   string p_from_start         = Request["p_from_start"].ToString();
   string p_to_start           = Request["p_to_start"].ToString();
   string p_from_end           = Request["p_from_end"].ToString();
   string p_to_end             = Request["p_to_end"].ToString();
   string p_pass               = Request["p_pass"].ToString();
   string p_participate        = Request["p_participate"].ToString();
   string p_status_app         = Request["p_status_app"].ToString();
   string p_certificate_type   = Request["p_certificate_type"].ToString();
   string p_status             = Request["p_status"].ToString();

        string SQL
    = "select       c.org_nm " + 
        "              ,w.WORKGROUP_NM " +
        "              ,e.EMP_ID " +
        "              ,e.FULL_NAME " +
        "              ,nvl(h.times,0) " +
        "              ,(select v.code_nm from vhr_hr_code v where v.id='HR0078' and v.code= k.CATEGORY) " +
        "              ,k.COURSE_ID ||'-'||k.COURSE_NAME " +
        "              ,b.REQ_NO ||'-'||k.COURSE_NAME " +
        "              ,to_char(to_date(k.START_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "              ,to_char(to_date(k.END_DT ,'yyyymmdd'),'dd/mm/yyyy') " +
        "              ,to_char(to_date(k.END_REGISTER_DT ,'yyyymmdd'),'dd/mm/yyyy') " +
        "              ,decode(b.MANDATORY_YN,'Y', 'Yes', 'N', 'No')  " +
        "              ,decode(a.PARTICIPATE_YN, 'Y', 'Yes', 'N', 'No','') " +
        "              ,a.REASON_NO_PART " +
        "              ,a.PARTICIPATE_TIME " +
        "              ,a.THEORY_MARK " +
        "              ,a.PRACTICE_MARK " +
        "              ,decode(a.PASS_YN, 'Y', 'Yes', 'N', 'No','') " +
        "              ,(select v.code_nm from vhr_hr_code v where v.id='HR0166' and v.code =  a.CERTIFICATE_TYPE) " +
        "            from thr_train_reqd a, thr_train_req b, thr_train_course k, thr_employee e, comm.tco_org c, thr_work_group w " +
        "                ,(select max(a.pk) pk, a.trainee_pk,count(*) times  " +
        "                    from thr_train_reqd a, thr_train_req b, thr_train_course c " +
        "                    where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "                    and a.THR_TRAIN_REQ_PK = b.pk " +
        "                    and b.THR_TRAIN_COURSE_PK = c.pk " +
        "                    and c.APPROVED_STATUS ='40'  " +
        "                    and b.STATUS = '30' " +
        "                    and a.STATUS = '30' " +
        "                    group by a.TRAINEE_PK) h " +
        "            where a.del_if=0 and b.del_if=0 and k.del_if=0 and e.del_if=0 and c.del_if=0 and w.del_if=0 " +
        "                and a.THR_TRAIN_REQ_PK = b.pk and b.THR_TRAIN_COURSE_PK = k.pk  " +
        "                and a.TRAINEE_PK = e.PK and e.TCO_ORG_PK = c.pk and e.THR_WG_PK = w.pk " +
        "                and decode('"+ p_course_status +"','ALL', 'ALL', k.APPROVED_STATUS )='"+ p_course_status +"' " +
        "                and decode('"+ p_application +"','ALL', 'ALL', b.pk )='"+ p_application +"' " +
        "                and decode('"+ p_course +"','ALL', 'ALL', k.pk )='"+ p_course +"' " +
        "                and decode('"+ p_category +"','ALL', 'ALL', k.category )='"+ p_category +"' " +
        "                and decode('"+ p_wg +"','ALL', 'ALL', e.thr_wg_pk )='"+ p_wg +"' " +
        "                and (   e.tco_org_pk in ( " +
        "                                      select     g.pk " +
        "                                            from comm.tco_org g " +
        "                                           where g.del_if = 0 " +
        "                                      start with g.pk = " +
        "                                                    decode ('" + p_tco_org_pk + "', " +
        "                                                            'ALL', 0, " +
        "                                                            '" + p_tco_org_pk + "' " +
        "                                                           ) " +
        "                                      connect by prior g.pk = g.p_pk) " +
        "                                or '" + p_tco_org_pk + "' = 'ALL') " +
        "                and (('" + p_lsttemp + "' = '2' and upper(e.EMP_ID) like '%'|| upper('" + p_txttemp + "') ||'%') " +
        "                        or ('" + p_lsttemp + "' = '1' and upper(e.FULL_NAME) like '%'|| upper('" + p_txttemp + "') ||'%')) " +
        "                and (('" + p_from_app + "' is null and '" + p_to_app + "' is null) or " +
        "                      k.GA_APPROVED_DT between '" + p_from_app + "' and '" + p_to_app + "')  " +
        "                and (('" + p_from_exp + "' is null and '" + p_to_exp + "' is null) or " +
        "                      k.END_REGISTER_DT between '" + p_from_exp + "' and '" + p_to_exp + "') " +
        "                and (('" + p_from_start + "' is null and '" + p_to_start + "' is null) or " +
        "                      k.START_DT between '" + p_from_start + "' and '" + p_to_start + "') " +
        "                and (('" + p_from_end + "' is null and '" + p_to_end + "' is null) or " +
        "                      k.END_DT between '" + p_from_end + "' and '" + p_to_end + "') " +
        "                and decode('" + p_pass + "','ALL', 'ALL', a.pass_yn ) = '" + p_pass + "' " +
        "                and decode('" + p_participate + "','ALL', 'ALL', a.participate_yn ) = '" + p_participate + "' " +
        "                and decode('" + p_status_app + "','ALL', 'ALL', b.status ) = '" + p_status_app + "' " +
        "                and decode('"+ p_certificate_type +"','ALL', 'ALL', a.certificate_type ) = '"+ p_certificate_type +"' " +
        "                and decode('"+ p_status +"','ALL', 'ALL', e.status ) = '"+ p_status +"' " +
        "                and a.pk = h.pk " +
        "                and  a.TRAINEE_PK = h.trainee_pk " +
        "                order by 2,6 desc " ;

	//Response.Write(SQL);
      //  Response.End();

    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }


    //-----------------information of company-----------------
    string SQL_Com
    = "select  a.TCO_BPPHOTO_PK,a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,A.FAX_no, to_char(sysdate, 'dd/mm/yyyy') " +
        "from comm.tco_company a " +
        "where a.DEL_IF=0 and rownum=1 ";
       


    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_traning_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_traning_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_traning_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-05T08:54:36Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-05T08:55:15Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2303 style='border-collapse:
 collapse;table-layout:fixed;width:1729pt'>
 <col class=xl65 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl65 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl65 width=136 style='mso-width-source:userset;mso-width-alt:4973;
 width:102pt'>
 <col class=xl65 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl65 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl65 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl65 width=131 span=2 style='mso-width-source:userset;mso-width-alt:
 4790;width:98pt'>
 <col class=xl65 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl65 width=104 span=3 style='mso-width-source:userset;mso-width-alt:
 3803;width:78pt'>
 <col class=xl65 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl65 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl65 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl65 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl65 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl65 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl65 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl65 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td colspan=20 height=57 class=xl87 width=2303 style='height:42.75pt;
  width:1729pt'>TRAINING<span style='mso-spacerun:yes'>  </span>SUMMARY</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl83>Date : <%= dt_Com.Rows[0][5].ToString() %></td>
  <td colspan=18 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td class=xl82></td>
  <td colspan=18 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl67 style='height:19.5pt'>No</td>
  <td class=xl68>Department</td>
  <td class=xl68>Work Group</td>
  <td class=xl68>Emp ID</td>
  <td class=xl68>Full Name</td>
  <td class=xl68>Times</td>
  <td class=xl68>Category Train</td>
  <td class=xl68>Course Name</td>
  <td class=xl68>Application Name</td>
  <td class=xl68>Start Date</td>
  <td class=xl68>End Date</td>
  <td class=xl68>Expired Date</td>
  <td class=xl68>Mandatory</td>
  <td class=xl68>Participate</td>
  <td class=xl68>Reason Note</td>
  <td class=xl68>Participate Times</td>
  <td class=xl68>Theory Mark</td>
  <td class=xl68>Practice Mark</td>
  <td class=xl68>Pass Y/N</td>
  <td class=xl68>Certificate</td>
 </tr>
 <tr class=xl66 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl69 style='height:19.5pt'>STT</td>
  <td class=xl70>B&#7897; ph&#7853;n</td>
  <td class=xl70>Nhóm</td>
  <td class=xl70>Mã NV</td>
  <td class=xl70>H&#7885; và tên</td>
  <td class=xl70 x:str="S&#7889; l&#7847;n ">S&#7889; l&#7847;n<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl70>Lo&#7841;i &#273;ào t&#7841;o</td>
  <td class=xl70>Khóa &#273;ào t&#7841;o</td>
  <td class=xl70>Yêu c&#7847;u</td>
  <td class=xl70>Ngày b&#7855;t &#273;&#7847;u</td>
  <td class=xl70>Ngày k&#7871;t thúc</td>
  <td class=xl70>Ngày h&#7871;t h&#7841;n</td>
  <td class=xl70>B&#7855;t bu&#7897;c</td>
  <td class=xl70>Tham gia</td>
  <td class=xl70>Lí do</td>
  <td class=xl70>Th&#7901;i gian tham gia</td>
  <td class=xl70>&#272;i&#7875;m lý thuy&#7871;t</td>
  <td class=xl70>&#272;i&#7875;m th&#7921;c hành</td>
  <td class=xl70>&#272;&#7841;t</td>
  <td class=xl70>Ch&#7913;ng nh&#7853;n</td>
 </tr>
 <% 
      int count = 0;
      for (int i = 0; i < irow; i++)
      {
          count++;
    %> 
 <tr class=xl71 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl72 style='height:21.75pt' x:num><%= count %></td>
  <td class=xl73><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl73><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl73><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl81 style='border-top:none;border-left:none'><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl81 style='border-top:none;border-left:none'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl74><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl85><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl85><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl85><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl85><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl84 x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl84 x:num><% = dt_total.Rows[i][16].ToString()%></td>
  <td class=xl85><% = dt_total.Rows[i][17].ToString()%></td>
  <td class=xl75><% = dt_total.Rows[i][18].ToString()%></td>
 </tr>
 <%} %>
 <tr class=xl71 height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl76 style='height:2.25pt'>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=156 style='width:117pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
