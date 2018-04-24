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
    = "select 1 " + 
        "    ,e.rec_nm fullname_01 " +
        "    ,decode(length(e.birth_dt),4, e.birth_dt, to_char(to_date(e.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) birth_02 " +
        "    ,e.SEX " +
        "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0011' and v.code = e.EDU_TYPE) as edu_04 " +
        "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code = e.REC_POS_TYPE ) as pos_05 " +
        "    ,e.PERMANENT_ADDR add_06 " +
        "    ,nvl(e.HAND_PHONE,e.HOME_PHONE) " +
        "    ,e.HEIGHT " +
        "    ,e.WEIGHT " +
        "    ,c.org_nm " +
        "    , e.MAJOR as Major " +
        " from thr_rec_emp e, comm.tco_org c " +
        " where e.del_if=0 and c.del_if(+)=0 " +
        "    and e.rec_org_pk = c.pk(+) " +
        "     and decode ('"+p_position+"','ALL','"+p_position+"',e.REC_POS_TYPE)='"+p_position+"' " +
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
        "      and decode ('"+p_detail+"','ALL','"+p_detail+"',THR_REC_REQUEST_DT_PK)='"+p_detail+"' " +
        "      and (case when '"+p_request+"'='NON' and e.THR_REC_REQUEST_DT_PK is null  then 'NON' else  '1' end) = decode('"+p_request+"','NON','NON','1' ) " +
        "      and (e.THR_REC_REQUEST_DT_PK  " +
        "                in (select b.PK " +
        "                            from  THR_REC_REQUEST a,THR_REC_REQUEST_DETAIL b where b.del_if=0 and a.del_if=0 and a.pk=b.THR_REC_REQUEST_PK  " +
        "                            and e.THR_REC_REQUEST_DT_PK=b.pk " +
        "                            and(  " +
        "                                 (('"+p_PeriodFrom+"'  between  a.FROM_DT and a.TO_DT " +
        "                              or  '"+p_PeriodTo+"'  between  a.FROM_DT and a.TO_DT " +
        "                              or  a.FROM_DT  between  '"+p_PeriodFrom+"'  and '"+p_PeriodTo+"' " +
        "                              or  a.TO_DT  between  '"+p_PeriodFrom+"'  and '"+p_PeriodTo+"') " +
        "                              and '"+p_PeriodTo+"' is not null and '"+p_PeriodFrom+"'  is not null  " +
        "                              ) " +
        "                              or  " +
        "                              ( '"+p_PeriodTo+"' is null and '"+p_PeriodFrom+"'  is  null) " +
        "                               " +
        "                              ) " +
        "                              and decode ('"+p_request+"','ALL','"+p_request+"',a.pk)='"+p_request+"' " +
        "                              " +
        "                   ) " +
        "                   or '"+p_request+"'='ALL'  " +
        "                   and '"+p_request+"'<>'NON' " +
        "                   ) " +
        "       " +
        "       AND (e.REC_ORG_PK IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM COMM.TCO_ORG g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('"+p_org+"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+p_org+"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '"+p_org+"' = 'ALL') " +
        "      AND (   (    '"+p_serach+"' = 1 " +
        "                  AND UPPER (e.rec_nm) LIKE '%' || UPPER ('"+p_temp+"') || '%' " +
        "                 ) " +
        "              OR ('"+p_serach+"' = 2 AND e.rec_id LIKE '%' || '"+p_temp+"' || '%') " +
        "                          OR (    '"+p_serach+"' = 4 " +
        "                  AND UPPER (e.per_id) LIKE '%' || UPPER ('"+p_temp+"') || '%' " +
        "                 ) " +
        "              OR '"+p_temp+"' IS NULL " +
        "             ) " +
        "              " +
        "      and ( ('"+p_receive_from+"' is null and '"+p_receive_to+"' is null ) or (CV_RECIEVE_DT between  '"+p_receive_from+"' and '"+p_receive_to+"')  ) " +
        "      and ( ('"+p_Expiry_from+"' is null and '"+p_Expiry_to+"' is null ) or (EXPIRY_DT between  '"+p_Expiry_from+"'  and '"+p_Expiry_to+"')  )  " +
        "      and ( ('"+p_Interview1_from+"' is null and '"+p_Interview1_to+"' is null ) or (INTERVIEW_DT1 between  '"+p_Interview1_from+"'  and '"+p_Interview1_to+"')  ) " +
        "      and ( ('"+p_Interview2_from+"' is null and '"+p_Interview2_to+"' is null ) or (INTERVIEW_DT2 between  '"+p_Interview2_from+"'  and '"+p_Interview2_to+"')  )  " +
        "      and ( ('" + p_Interview3_from + "' is null and '" + p_Interview3_to + "' is null ) or (INTERVIEW_DT3 between  '" + p_Interview3_from + "'  and '" + p_Interview3_to + "')  )   " +
        "      and ( ('" + p_working_from + "' is null and '" + p_working_to + "' is null ) or (e.working_dt between  '" + p_working_from + "'  and '" + p_working_to + "')  )   " +
        "         order by 11    ";


 // Response.Write(SQL);
 // Response.End();
  DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
  int irow_emp;
  irow_emp = dt_Emp.Rows.Count;
   if (dt_Emp.Rows.Count == 0)
  {
      Response.Write("There is no data of salary");
      Response.End();
  }

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_rec_interview_status_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_rec_interview_status_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_rec_interview_status_list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nga</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-08-02T08:57:04Z</o:LastPrinted>
  <o:Created>2010-09-20T13:19:17Z</o:Created>
  <o:LastSaved>2011-08-02T09:10:20Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style62
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl70
	{mso-style-parent:style0;
	text-align:center;}
.xl71
	{mso-style-parent:style62;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style62;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style62;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:none;}
.xl74
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style62;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style62;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>DANH SACH PHONG VAN</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1316 style='border-collapse:
 collapse;table-layout:fixed;width:987pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=167 style='mso-width-source:userset;mso-width-alt:6107;width:125pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4754;width:98pt'>
 <col width=244 style='mso-width-source:userset;mso-width-alt:8923;width:183pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col class=xl70 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=31 style='height:15.0pt;width:23pt'></td>
  <td width=167 style='width:125pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=244 style='width:183pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=91 style='width:68pt'></td>
  <td class=xl70 width=171 style='width:128pt'></td>
 </tr>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td colspan=12 height=50 class=xl73 style='height:37.5pt'
  x:str>INTERVIEW STATUS REPORT <span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl71 style='height:12.0pt'>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl74 style='height:30.0pt;border-top:none'>STT</td>
  <td rowspan=2 class=xl74 style='border-top:none'>CANDIDATE'S NAME</td>
  <td rowspan=2 class=xl75 style='border-bottom:.5pt solid black;border-top:
  none'>DOB</td>
  <td rowspan=2 class=xl74 style='border-top:none'>SEX</td>
  <td rowspan=2 class=xl74 style='border-top:none'>EDUCATION</td>
  <td rowspan=2 class=xl74 style='border-top:none'>MAJOR</td>
  <td rowspan=2 class=xl74 style='border-top:none'>POSITION</td>
  <td rowspan=2 class=xl76 width=244 style='border-bottom:.5pt solid black;
  border-top:none;width:183pt'>PERMANENT ADDRESS</td>
  <td rowspan=2 class=xl74 style='border-top:none'>TELEPHONE</td>
  <td rowspan=2 class=xl77 style='border-bottom:.5pt solid black;border-top:
  none'>HEIGHT</td>
  <td rowspan=2 class=xl74 style='border-top:none'>WEIGHT</td>
  <td rowspan=2 class=xl74 style='border-top:none'>DEPT</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
 </tr>
  <%
    int count = 0;
    for (int i = 0; i < irow_emp; i++)
     {
        count++;
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl81 style='height:24.0pt;border-top:none' x:str><%= count %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl82 style='border-left:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl82 style='border-left:none'><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl83 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl81 style='border-top:none'><%= dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl81 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][10].ToString() %></td>
 </tr>
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=167 style='width:125pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=244 style='width:183pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=171 style='width:128pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
