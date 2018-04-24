<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_org = Request["p_org"].ToString();
    string p_position = Request["p_position"].ToString();
    string p_serach = Request["p_serach"].ToString();
    string p_temp = Request["p_temp"].ToString();
    string p_resultby = Request["p_resultby"].ToString();
    string p_status = Request["p_status"].ToString();
    string p_request = Request["p_request"].ToString();
    string p_detail = Request["p_detail"].ToString();
    string p_PeriodFrom = Request["p_PeriodFrom"].ToString();
    string p_PeriodTo = Request["p_PeriodTo"].ToString();
    string p_receive_from = Request["p_receive_from"].ToString();
    string p_receive_to = Request["p_receive_to"].ToString();
    string p_Expiry_from = Request["p_Expiry_from"].ToString();
    string p_Expiry_to = Request["p_Expiry_to"].ToString();
    string p_Interview1_from = Request["p_Interview1_from"].ToString();
    string p_Interview1_to = Request["p_Interview1_to"].ToString();
    string p_Interview2_from = Request["p_Interview2_from"].ToString();
    string p_Interview2_to = Request["p_Interview2_to"].ToString();
    string p_Interview3_from = Request["p_Interview3_from"].ToString();
    string p_Interview3_to = Request["p_Interview3_to"].ToString();
    string p_working_from = Request["p_working_from"].ToString();
    string p_working_to = Request["p_working_to"].ToString();

    string SQL
     = "select 1  " +
         "    ,e.REC_NM fullname_01 " +
         "    ,decode(length(e.BIRTH_DT),4,e.BIRTH_DT, to_char(to_date(e.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) birth_02 " +
         "    ,e.SEX sex_03 " +
         "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0011' and v.code = e.EDU_TYPE) as edu_04  " +
         "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code = e.REC_POS_TYPE ) as pos_05 " +
         "    ,(select k.org_nm from comm.tco_org k where k.del_if=0 and k.pk = (select o.p_pk from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk)) as factory_06 " +
         "    ,(select o.org_nm from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk) as Dept_07 " +
         "    ,c.org_nm as group_nm_07 " +
         "    ,to_char(to_date(e.WORKING_DT,'yyyymmdd'),'dd/mm/yyyy') working_08 " +
         "    ,nvl(e.HAND_PHONE,e.HOME_PHONE) tel_09 " +
         "    ,(select a.app_no||' - '|| (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE=B.POS_TYPE ) from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) request_nm_10  " +
         "    ,(select to_char(to_date(a.FROM_DT,'yyyymmdd'),'dd/mm/yyyy') from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) as from_dt_11 " +
         "    ,(select to_char(to_date(a.TO_DT,'yyyymmdd'),'dd/mm/yyyy') from THR_REC_REQUEST a,THR_REC_REQUEST_detail b where a.del_if=0 and b.del_if=0 and a.PK=b.THR_REC_REQUEST_PK  and b.pk=e.THR_REC_REQUEST_DT_PK) as to_dt_12  " +
         "    ,(select g.full_name from thr_employee g where g.del_if=0 and g.pk = e.interviewer2_pk) int_13  " +
         "    ,(select g.full_name from thr_employee g where g.del_if=0 and g.pk = e.interviewer3_pk) int_14 " +
         "   from thr_rec_emp e, comm.tco_org c " +
         "   where e.del_if=0 and c.del_if(+)=0 " +
         "    and e.REC_ORG_PK = c.pk(+) " +
         "     and decode ('" + p_position + "','ALL','" + p_position + "',e.REC_POS_TYPE)='" + p_position + "' " +
        "      and ( ('" + p_resultby + "'='1' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t1 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='2' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t2 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='3' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t3 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='4' and  decode ('" + p_status + "','ALL','" + p_status + "',e.pass_yn )='" + p_status + "' ) " +
        "          or ('" + p_resultby + "' ='ALL' and (  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t1 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.result_t2 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.result_t3 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.pass_yn )='" + p_status + "'  " +
        "                                      )) " +
        "          ) " +
        "      and decode ('" + p_detail + "','ALL','" + p_detail + "',THR_REC_REQUEST_DT_PK)='" + p_detail + "' " +
        "      and (case when '" + p_request + "'='NON' and e.THR_REC_REQUEST_DT_PK is null  then 'NON' else  '1' end) = decode('" + p_request + "','NON','NON','1' ) " +
        "      and (e.THR_REC_REQUEST_DT_PK  " +
        "                in (select b.PK " +
        "                            from  THR_REC_REQUEST a,THR_REC_REQUEST_DETAIL b where b.del_if=0 and a.del_if=0 and a.pk=b.THR_REC_REQUEST_PK  " +
        "                            and e.THR_REC_REQUEST_DT_PK=b.pk " +
        "                            and(  " +
        "                                 (('" + p_PeriodFrom + "'  between  a.FROM_DT and a.TO_DT " +
        "                              or  '" + p_PeriodTo + "'  between  a.FROM_DT and a.TO_DT " +
        "                              or  a.FROM_DT  between  '" + p_PeriodFrom + "'  and '" + p_PeriodTo + "' " +
        "                              or  a.TO_DT  between  '" + p_PeriodFrom + "'  and '" + p_PeriodTo + "') " +
        "                              and '" + p_PeriodTo + "' is not null and '" + p_PeriodFrom + "'  is not null  " +
        "                              ) " +
        "                              or  " +
        "                              ( '" + p_PeriodTo + "' is null and '" + p_PeriodFrom + "'  is  null) " +
        "                               " +
        "                              ) " +
        "                              and decode ('" + p_request + "','ALL','" + p_request + "',a.pk)='" + p_request + "' " +
        "                              " +
        "                   ) " +
        "                   or '" + p_request + "'='ALL'  " +
        "                   and '" + p_request + "'<>'NON' " +
        "                   ) " +
        "       " +
        "       AND (e.REC_ORG_PK IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM COMM.TCO_ORG g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_org + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_org + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_org + "' = 'ALL') " +
        "      AND (   (    '" + p_serach + "' = 1 " +
        "                  AND UPPER (e.rec_nm) LIKE '%' || UPPER ('" + p_temp + "') || '%' " +
        "                 ) " +
        "              OR ('" + p_serach + "' = 2 AND e.rec_id LIKE '%' || '" + p_temp + "' || '%') " +
        "                          OR (    '" + p_serach + "' = 4 " +
        "                  AND UPPER (e.per_id) LIKE '%' || UPPER ('" + p_temp + "') || '%' " +
        "                 ) " +
        "              OR '" + p_temp + "' IS NULL " +
        "             ) " +
        "              " +
        "      and ( ('" + p_receive_from + "' is null and '" + p_receive_to + "' is null ) or (CV_RECIEVE_DT between  '" + p_receive_from + "' and '" + p_receive_to + "')  ) " +
        "      and ( ('" + p_Expiry_from + "' is null and '" + p_Expiry_to + "' is null ) or (EXPIRY_DT between  '" + p_Expiry_from + "'  and '" + p_Expiry_to + "')  )  " +
        "      and ( ('" + p_Interview1_from + "' is null and '" + p_Interview1_to + "' is null ) or (INTERVIEW_DT1 between  '" + p_Interview1_from + "'  and '" + p_Interview1_to + "')  ) " +
        "      and ( ('" + p_Interview2_from + "' is null and '" + p_Interview2_to + "' is null ) or (INTERVIEW_DT2 between  '" + p_Interview2_from + "'  and '" + p_Interview2_to + "')  )  " +
        "      and ( ('" + p_Interview3_from + "' is null and '" + p_Interview3_to + "' is null ) or (INTERVIEW_DT3 between  '" + p_Interview3_from + "'  and '" + p_Interview3_to + "')  )   " +
        "      and ( ('" + p_working_from + "' is null and '" + p_working_to + "' is null ) or (e.working_dt between  '" + p_working_from + "'  and '" + p_working_to + "')  )   " +
        "    order by 14,2 ";





   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
   
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_rec_employee_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_rec_employee_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_rec_employee_list_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:Created>2011-08-02T07:22:43Z</o:Created>
  <o:LastSaved>2011-08-02T07:23:23Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font5
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.style21
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl25
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style21;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\@";}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
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
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1720 style='border-collapse:
 collapse;table-layout:fixed;width:1295pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=186 style='mso-width-source:userset;mso-width-alt:6802;width:140pt'>
 <col class=xl42 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col class=xl42 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl42 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl42 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl42 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl42 width=86 span=2 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col width=133 span=2 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=34 style='height:12.75pt;width:26pt'></td>
  <td width=186 style='width:140pt'></td>
  <td class=xl42 width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=121 style='width:91pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=99 style='width:74pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=117 style='width:88pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=133 style='width:100pt'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 style='height:27.0pt' align=left valign=top></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>CÔNG TY TNHH HYOSUNG
  VI&#7878;T NAM</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=67 style='mso-height-source:userset;height:50.25pt'>
  <td colspan=16 height=67 class=xl28 width=1587 style='height:50.25pt;
  width:1195pt'>DANH SÁCH DỰ KIẾN NH&#7852;N VI&#7878;C
  <font class="font5"><br>
    </font><font class="font8">Expect working list </font>
  </td>
  <td class=xl28></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=10 height=28 class=xl29 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl36 height=67 style='mso-height-source:userset;height:50.25pt'>
  <td height=67 class=xl32 width=34 style='height:50.25pt;border-top:none;
  width:26pt'>TT<br>
    <font class="font10">No</font></td>
  <td class=xl32 width=186 style='border-top:none;border-left:none;width:140pt'>H&#7885;
  và Tên <br>
    <font class="font10">Full - name</font></td>
  <td class=xl33 width=83 style='border-top:none;border-left:none;width:62pt'>Ngày
  sinh<br>
    <font class="font10">DOB</font></td>
  <td class=xl34 width=53 style='border-top:none;border-left:none;width:40pt'>Gi&#7899;i
  tính<br>
    <font class="font10">Sex</font></td>
  <td class=xl32 width=125 style='border-top:none;border-left:none;width:94pt'>Trình
  &#273;&#7897; <br>
    <font class="font10">Education</font></td>
  <td class=xl32 width=101 style='border-top:none;border-left:none;width:76pt'>Ch&#7913;c
  v&#7909;<br>
    Position</td>
  <td class=xl35 width=89 style='border-top:none;border-left:none;width:67pt'>Job
  Group</td>
  <td class=xl35 width=102 style='border-top:none;border-left:none;width:77pt'>Department</td>
  <td class=xl35 width=121 style='border-top:none;border-left:none;width:91pt'>Part</td>
  <td class=xl33 width=86 style='border-top:none;border-left:none;width:65pt'><br>
    <font class="font10">Expect Working Date</font></td>
  <td class=xl32 width=99 style='border-left:none;width:74pt'>S&#7889;
  &#273;i&#7879;n tho&#7841;i <br>
    Tel. No</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ký tên<br>
    <font class="font10">Signature</font></td>
  <td class=xl33 width=117 style='border-left:none;width:88pt'>&#272;&#7907;t
  tuy&#7875;n d&#7909;ng<br>
    Recruitment</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ngày b&#7855;t
  &#273;&#7847;u<br>
    Start date</td>
  <td class=xl33 width=86 style='border-left:none;width:65pt'>Ngày k&#7871;t
  thúc<br>
    End date</td>
  <td class=xl32 width=133 style='border-left:none;width:100pt'>Ng&#432;&#7901;i
  ph&#7887;ng v&#7845;n 2<br>
    Interviewer 2</td>
  <td class=xl32 width=133 style='border-left:none;width:100pt'>Ng&#432;&#7901;i
  ph&#7887;ng v&#7845;n 3<br>
    Interviewer 3</td>
 </tr>
 <%
    int count = 0;
    for (int i = 0; i < irow_emp; i++)
     {
        count++;
  %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl37 style='height:23.25pt;border-top:none' x:num><%= count %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][15].ToString() %></td>
 </tr>
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=133 style='width:100pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
