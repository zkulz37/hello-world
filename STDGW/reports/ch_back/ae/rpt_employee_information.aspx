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
    long emp_pk;
    emp_pk = long.Parse(Request["emp_pk"].ToString());
    string SQL;

    SQL    = "Select em.EMP_ID,em.ID_NUM, em.FULL_NAME, em.PRESENT_ADDR, em.PERMANENT_ADDR,de.ORG_NM, g.WORKGROUP_NM    " +
        ", emp.code_nm EMPLOYEE_TYPE, em.TEL, s.code_fnm sex, sta.code_nm STATUS,to_char(to_date( em.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt, to_char(to_date( em.LEFT_DT,'yyyymmdd'),'dd/mm/yyyy') LEFT_DT   " +
        ", na.code_nm NATION, pl.code_nm PLACE_BIRTH   " +
        ", CASE WHEN  LENGTH(em.BIRTH_DT)>4 THEN to_char(to_date(  em.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')  ELSE  em.BIRTH_DT END BIRTH_DT, em.PERSON_ID, Per_ID.code_nm PLACE_PER_ID,to_char(to_date(em.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') ISSUE_DT   " +
        ", pos.code_nm POS_TYPE, job.code_nm JOB_TYPE, edu.code_nm EDU_TYPE, eth.code_nm ETHNIC_TYPE, re.code_nm RELIG_TYPE, em.MARRIED_YN, pro.code_knm PROB_TYPE,to_char(to_date(em.BEGIN_PROBATION,'yyyymmdd'),'dd/mm/yyyy') BEGIN_PROBATION   " +
        ", to_char(to_date(em.END_PROBATION,'yyyymmdd'),'dd/mm/yyyy') END_PROBATION, co.code_fnm CONTRACT_TYPE   " +
        ", to_char(to_date(em.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') BEGIN_CONTRACT, to_char(to_date(em.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') END_CONTRACT, em.PRO_SAL, em.BASIC_SAL, em.REMARK,photo_pk   " +
        "from thr_employee em, tco_org de, thr_work_group g   " +
        ", (select code, code_fnm from vhr_hr_code where id='HR0007' order by code_fnm) s   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0017' order by code_nm) emp   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm) sta   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0009' order by code_nm) na   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0021' order by code_nm) pl   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0014' order by code_nm) Per_ID   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0008' order by code_nm) pos   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0010' order by code_nm) job   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0011' order by code_nm) edu   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0015' order by code_nm) eth   " +
        ", (select code,code_nm from vhr_hr_code where id='HR0016' order by code_nm) re   " +
        ", (select code,code_knm from vhr_hr_code where id='HR0002' order by code_nm) pro   " +
        ", (select code,code_fnm from vhr_hr_code where id='HR0001' order by code_nm) co   " +
        "where em.del_if = 0   " +
        "and em.TCO_ORG_PK = de.PK(+)   " +
        "and em.THR_WG_PK = g.pk(+)   " +
        "and em.sex = s.code(+)   " +
        "and em.EMPLOYEE_TYPE = emp.code(+)   " +
        "and em.STATUS = sta.code(+)   " +
        "and em.NATION = na.code(+)   " +
        "and em.PLACE_BIRTH = pl.code(+)   " +
        "and em.PLACE_PER_ID = Per_ID.code(+)   " +
        "and em.POS_TYPE = pos.code(+)   " +
        "and em.JOB_TYPE = job.code(+)   " +
        "and em.EDU_TYPE = edu.code(+)   " +
        "and em.ETHNIC_TYPE = eth.code(+)   " +
        "and em.RELIG_TYPE = re.code(+)   " +
        "and em.PROB_TYPE = pro.code(+)   " +
        "and em.CONTRACT_TYPE = co.code(+)   " +
        "and em.pk = " + emp_pk.ToString()+
        " ORDER BY em.EMP_ID,em.ID_NUM, em.FULL_NAME   ";


    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //Experience
    string SQL_E;
    SQL_E = " select COM_NM, to_char(to_date(a.START_DT,'yyyymmdd'),'dd/mm/yyyy'), to_char(to_date(a.END_DT,'yyyymmdd'),'dd/mm/yyyy'), POSITION, SALARY, REMARK ";
    SQL_E = SQL_E + "from thr_experience a ";
    SQL_E = SQL_E + "where del_if=0 and a.THR_EMPLOYEE_PK= " + emp_pk.ToString(); 
    SQL_E = SQL_E + "order by start_dt ";
    DataTable dt_total_e = ESysLib.TableReadOpen(SQL_E);
    int irow_e;
    irow_e = dt_total_e.Rows.Count;
    
    //Family 
    string SQL_F;
    SQL_F = " select  a.FULL_NAME , b.code_nm, to_char(to_date( a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy'), a.job,a.salary,a.REMARK ";
    SQL_F = SQL_F + "from THR_FAMILY a,vhr_hr_code b ";
    SQL_F = SQL_F + " where del_if=0   ";
    SQL_F = SQL_F + " and a.relation = b.code ";
    SQL_F = SQL_F + " and b.id='HR0024' and thr_employee_pk=" + emp_pk.ToString(); 
    SQL_F = SQL_F + " order by b.code ";
    DataTable dt_total_f = ESysLib.TableReadOpen(SQL_F);
    int irow_f;
    irow_f = dt_total_f.Rows.Count;
    //Note 
    string SQL_N;
    SQL_N = " select a.NOTE_1,a.note_2,a.note_3,a.note_4,a.note_5 ";
    SQL_N = SQL_N + "from thr_expand a ";
    SQL_N = SQL_N + "where del_if=0 and thr_employee_pk=" + emp_pk.ToString(); 
    SQL_N = SQL_N + "order by note_1 ";
    DataTable dt_total_n = ESysLib.TableReadOpen(SQL_N);
    int irow_n;
    irow_n = dt_total_n.Rows.Count;
    int i = 0;    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_information_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_information_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_information_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-05-26T07:39:20Z</o:LastPrinted>
  <o:Created>2008-05-26T06:08:27Z</o:Created>
  <o:LastSaved>2008-07-04T03:09:05Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .41in .43in .32in;
	mso-header-margin:.28in;
	mso-footer-margin:.28in;}
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
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
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
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
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
  <x:WindowHeight>7680</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>330</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=728 style='border-collapse:
 collapse;table-layout:fixed;width:548pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=9 style='mso-width-source:userset;mso-width-alt:329;width:7pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=9 style='mso-width-source:userset;mso-width-alt:329;width:7pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=9 style='mso-width-source:userset;mso-width-alt:329;width:7pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=10 height=45 class=xl52 width=728 style='height:33.75pt;
  width:548pt'>EMPLOYEE'S INFORMATION</td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl43 width=145 style='height:22.5pt;width:109pt'>Emp
  ID</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Card ID</td>
  <td class=xl26>:</td>
  <td class=xl30 x:num="2323232"><%= dt_total.Rows[0][1].ToString() %></td>
 <td width=100 style='width:75pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:25.5pt;margin-top:0;width:117pt;height:112.5pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][34].ToString()%>&table_name=<%=Session["APP_DBUSER"].ToString()%>.TC_FSBINARY" o:title="Www_PhiSon_Info_SieuBaby_29"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:34px;margin-top:0px;width:156px;
  height:150px'><img width=156 height=150
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][34].ToString()%>&table_name=<%=Session["APP_DBUSER"].ToString()%>.TC_FSBINARY" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=30 class=xl27 width=100 style='height:22.5pt;width:75pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl43 width=145 style='height:22.5pt;width:109pt'>Full
  Name</td>
  <td class=xl26>:</td>
  <td colspan=4 class=xl42 ><%= dt_total.Rows[0][2].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl43 width=145 style='height:22.5pt;width:109pt'>Current
  Address</td>
  <td class=xl26>:</td>
  <td colspan=4 class=xl28><%= dt_total.Rows[0][3].ToString() %></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl44 style='height:22.5pt'>Permanent Address</td>
  <td class=xl26>:</td>
  <td colspan=4 class=xl28><%= dt_total.Rows[0][4].ToString() %></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl43 width=145 style='height:22.5pt;width:109pt'>Deparment</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][5].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Group</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][6].ToString() %></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Emp
  Type</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][7].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Tel</td>
  <td class=xl26>:</td>
  <td class=xl28 x:num><%= dt_total.Rows[0][8].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt' x:str="Sex ">Sex<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][9].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Status</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][10].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Join Date</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][11].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>Left Date</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][12].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Nation</td>
  <td class=xl26>:</td>
  <td class=xl24><%= dt_total.Rows[0][13].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Birth Place</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][14].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>Birth Date</td>
  <td class=xl26>:</td>
  <td class=xl29><%= dt_total.Rows[0][15].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Person
  ID</td>
  <td class=xl26>:</td>
  <td class=xl28 x:num><%= dt_total.Rows[0][16].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Person ID Place</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][17].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>Issued Date</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][18].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Position</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][19].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Job</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][20].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>Education</td>
  <td class=xl26>:</td>
  <td class=xl30><%= dt_total.Rows[0][21].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Ethnic</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][22].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Religion</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][23].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>Marital Status</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][24].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Probation
  Type</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][25].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Begin Probation</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][26].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>End Probation</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][27].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Contract
  Type</td>
  <td class=xl26>:</td>
  <td class=xl28><%= dt_total.Rows[0][28].ToString() %></td>
  <td class=xl25 width=113 style='width:85pt'>Begin Contract</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][29].ToString() %></td>
  <td class=xl25 width=100 style='width:75pt'>End Contract</td>
  <td class=xl26>:</td>
  <td class=xl29 x:num><%= dt_total.Rows[0][30].ToString() %></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Probation
  Salary</td>
  <td class=xl26>:</td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'>               
  </span><%= dt_total.Rows[0][31] %> </td>
  <td class=xl25 width=113 style='width:85pt'>Basic Salary</td>
  <td class=xl26>:</td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'>             
  </span><%= dt_total.Rows[0][32]%>  </td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl25 width=145 style='height:22.5pt;width:109pt'>Remark</td>
  <td class=xl26>:</td>
  <td colspan=7 class=xl28><%= dt_total.Rows[0][33].ToString() %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
     if (irow_e > 0)
     {        %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl51 width=728 style='height:24.0pt;
  width:548pt'>EMPLOYEE'S EXPERIENCE</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 width=33 style='height:21.0pt;border-top:none;
  width:25pt'>No</td>
  <td colspan=2 class=xl33 style='border-left:none'>Company Name</td>
  <td class=xl34 style='border-top:none;border-left:none'>Start Date</td>
  <td class=xl33 style='border-top:none;border-left:none'>End Date</td>
  <td colspan=2 class=xl33 style='border-left:none'>Position</td>
  <td class=xl33 style='border-top:none;border-left:none'>Salary</td>
  <td colspan=2 class=xl33 style='border-left:none'>Remark</td>
 </tr>
 <%
        for (i = 0; i < irow_e; i++)
        {
          %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl35 style='height:21.0pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_e.Rows[i][0].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><%= dt_total_e.Rows[i][1].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><%= dt_total_e.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_e.Rows[i][3].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_total_e.Rows[i][4].ToString() %> </td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_e.Rows[i][5].ToString() %></td>
 </tr>
 <%
        }
                
     }
      %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
     if (irow_f > 0)
     {        %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl51 width=728 style='height:24.0pt;
  width:548pt'>EMPLOYEE'S FAMILY</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 width=33 style='height:21.0pt;border-top:none;
  width:25pt'>No</td>
  <td colspan=2 class=xl33 style='border-left:none'>Name</td>
  <td class=xl34 style='border-top:none;border-left:none'>Relation</td>
  <td class=xl33 style='border-top:none;border-left:none'>Birth Date</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Job</td>
  <td  class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Salary</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
 </tr>
  <%
        for (i = 0; i < irow_f; i++)
        {
          %>

 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl35 style='height:21.0pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_f.Rows[i][0].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt_total_f.Rows[i][1].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num><%= dt_total_f.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_f.Rows[i][3].ToString() %></td>
  <td class=xl46 style='border-right:.5pt solid black;border-left:
  none;mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0"' x:num><%= dt_total_f.Rows[i][4].ToString() %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_f.Rows[i][5].ToString() %></td>
 </tr>
 <%
        }
                
     }
      %>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=10 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <%
     if (irow_n > 0)
     {        %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl51 width=728 style='height:24.0pt;
  width:548pt'>EMPLOYEE'S NOTE</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 width=33 style='height:21.0pt;width:25pt'>No</td>
  <td colspan=2 class=xl33 style='border-left:none'>Note 1</td>
  <td class=xl38 style='border-left:none'>Note 2</td>
  <td class=xl38>Note 3</td>
  <td colspan=2 class=xl33>Note 4</td>
  <td colspan=3 class=xl33 style='border-left:none'>Note 5</td>
 </tr>
 <%
        for (i = 0; i < irow_n; i++)
        {
          %>

 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl35 style='height:21.0pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_n.Rows[i][0].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt_total_n.Rows[i][1].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt_total_n.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%= dt_total_n.Rows[i][3].ToString() %></td>
  <td colspan=3 class=xl36 style='border-left:none'><%= dt_total_n.Rows[i][4].ToString() %></td>
 </tr>
  <%
        }
                
     }
      %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 style='height:16.5pt'></td>
  <td colspan=9 class=xl45 width=695 style='width:523pt'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
