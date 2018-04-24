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
    string p_tco_dept_pk,p_thr_group_pk,p_status,p_emp_id,p_work_mon;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["l_thr_group_pk"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();

    string SQL
    = "select a.EMP_ID as c0  " +
        ",a.FULL_NAME as c1  " +
        ",substr(a.BIRTH_DT,1,4) c2 " +
        ",decode(a.sex,'M','Nam','Nữ') c3 " +
        ",(select code_nm from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH) as c4 " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code=a.pos_TYPE ) as c5   " +
        ",to_char(to_date(a.left_dt,'yyyymmdd'),'dd/mm/yyyy') as c6 " +
        ",(select decode(code,'01','X','') from vhr_hr_code where id='HR0004' and code=a.resign_TYPE ) as c7 " +
        ",(select decode(code,'02','X','') from vhr_hr_code where id='HR0004' and code=a.resign_TYPE ) as c8 " +
        ",(select decode(code,'01','','02','','X') from vhr_hr_code where id='HR0004' and code=a.resign_TYPE ) as c9 " +
        ",a.contract_no as c10 " +
        ",to_char(to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy') as c11 " +
        "from thr_employee a " +
        "where a.del_if=0  " +
        "and a.left_dt like '" + p_work_mon + "%'" +
        "and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_group_pk)='" + p_thr_group_pk + "' " +
        "and a.emp_id like '%" + p_emp_id + "%' " + 
        "order by a.emp_id " ;



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
    //-----------------information of company-----------------
    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_dept  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and rownum=1 ";

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
<link rel=File-List href="rpt_resigned_workers_hansoll_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_resigned_workers_hansoll_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_resigned_workers_hansoll_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr. Khoi</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-05-19T03:25:14Z</o:LastPrinted>
  <o:Created>2006-02-06T09:09:53Z</o:Created>
  <o:LastSaved>2009-05-19T03:26:09Z</o:LastSaved>
  <o:Company>FM9FY-TMF7Q-KCKCT-V9T29-TBBBG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .12in .25in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.31in;
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
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
.style23
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1_1;}
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
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;}
.xl32
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	mso-protection:locked hidden;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	mso-protection:locked hidden;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-protection:locked hidden;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	mso-protection:locked hidden;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	mso-protection:locked hidden;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	mso-protection:locked hidden;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	mso-protection:locked hidden;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:locked hidden;}
.xl41
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-protection:unlocked visible;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	mso-protection:locked hidden;}
.xl43
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;}
.xl44
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-protection:unlocked visible;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:locked hidden;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-protection:locked hidden;}
.xl59
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-protection:unlocked visible;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:locked hidden;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
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
	border-left:.5pt solid windowtext;}
.xl66
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
	border-left:none;}
.xl67
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
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>13995</x:WindowWidth>
  <x:WindowTopX>720</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$13:$14</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl30>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1029 style='border-collapse:
 collapse;table-layout:fixed;width:774pt'>
 <col class=xl30 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl30 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl30 width=205 style='mso-width-source:userset;mso-width-alt:7497;
 width:154pt'>
 <col class=xl30 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl29 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl30 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl30 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl31 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl30 width=64 style='width:48pt'>
 <col class=xl30 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl30 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl29 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl29 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=3 width=307 style='height:15.0pt;mso-ignore:
  colspan;width:231pt'><%=dt_Com.Rows[0][0].ToString()%></td>
  <td class=xl26 width=51 style='width:38pt'></td>
  <td class=xl27 width=52 style='width:39pt'></td>
  <td class=xl26 colspan=4 width=362 style='mso-ignore:colspan;width:272pt'>C&#7896;NG
  HÒA XÃ H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T NAM</td>
  <td class=xl26 width=50 style='width:38pt'></td>
  <td width=46 style='width:35pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1104" type="#_x0000_t75" style='position:absolute;
   margin-left:5.25pt;margin-top:0;width:149.25pt;height:33pt;z-index:1'>
   <v:imagedata src="rpt_resigned_workers_hansoll_files/image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:7px;margin-top:0px;width:199px;
  height:44px'><img width=199 height=44
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1104"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl26 width=46 style='height:15.0pt;width:35pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29 width=75 style='width:56pt'></td>
  <td class=xl29 width=86 style='width:65pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=4 style='height:15.0pt;mso-ignore:colspan'><%=dt_Com.Rows[0][1].ToString()%></td>
  <td class=xl27></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                   </span>&#272;&#7897;c L&#7853;p-
  T&#7921; Do- H&#7841;nh Phúc</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=3 style='height:15.0pt;mso-ignore:colspan'>&#272;I&#7878;N
  THO&#7840;I: <%=dt_Com.Rows[0][2].ToString()%></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl30 colspan=5 style='mso-ignore:colspan'>Bình D&#432;&#417;ng,
  Ngày 10 Tháng 12 N&#259;m 2008</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl27 style='height:15.0pt'>BÁO CÁO TÌNH HÌNH
  GI&#7842;M LAO &#272;&#7896;NG</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=13 height=24 class=xl27 style='height:18.0pt'><span
  style='mso-spacerun:yes'>               </span>THÁNG <%=p_work_mon.Substring(4,2) + "/" +  p_work_mon.Substring(0,4)%></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl30></td>
  <td class=xl26></td>
  <td class=xl28></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl30 style='height:5.25pt'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td class=xl30></td>
  <td class=xl28></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=4 class=xl26 style='height:6.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=13 height=21 class=xl27 style='height:15.75pt'>KÍNH G&#7916;I:
  BAN QU&#7842;N LÝ CÁC KCN </td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl47 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl46 style='height:30.0pt'>STT</td>
  <td rowspan=2 class=xl46>MS</td>
  <td rowspan=2 class=xl46>H&#7884; VÀ TÊN</td>
  <td rowspan=2 class=xl46>NS</td>
  <td rowspan=2 class=xl46>GT</td>
  <td rowspan=2 class=xl46>N&#416;I SINH</td>
  <td rowspan=2 class=xl46>V&#7882; TRÍ CV</td>
  <td rowspan=2 class=xl46>NG. NGH&#7880;</td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>LÝ DO GI&#7842;M</td>
  <td rowspan=2 class=xl46>S&#7888; H&#272;</td>
  <td rowspan=2 class=xl46>NGÀY LV</td>
 </tr>
 <tr class=xl47 height=20 style='height:15.0pt'>
  <td height=20 class=xl46 style='height:15.0pt;border-top:none;border-left:
  none'>T. vi&#7879;c</td>
  <td class=xl46 style='border-top:none;border-left:none'>Sa th&#7843;i</td>
  <td class=xl46 style='border-top:none;border-left:none'>Khác</td>
 </tr>
 <% 
    string s_format;
     for (int i = 0; i < irow; i++) 
    {
       if (i == irow - 1)
            s_format = ";border-bottom:.5pt solid windowtext;";
        else
            s_format = ";";
    %> 
 <tr class=xl47 height=20 style='height:15.0pt'>
  <td height=20 class=xl52 style='height:15.0pt<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' x:num><%=i+1 %></td>
  <td class=xl60 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;'><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl62 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl53 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' x:num><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl54 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl54 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl54 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl55 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl52 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl52 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl52 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl53 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl54 style='border-left:none<%=s_format%>white-space:nowrap;mso-text-control:shrinktofit;' ><% = dt_total.Rows[i][11].ToString()%></td>
 </tr>
 <%} %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl27></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl27></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td class=xl58>Ng&#432;&#7901;i l&#7853;p bi&#7875;u</td>
  <td class=xl40></td>
  <td class=xl41></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl27>Tr&#432;&#7903;ng phòng nhân s&#7921;</td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl37></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl31></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl43></td>
  <td class=xl59></td>
  <td class=xl44></td>
  <td class=xl35></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl30></td>
  <td class=xl57></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl33></td>
  <td class=xl45></td>
  <td class=xl40></td>
  <td class=xl35></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td class=xl27></td>
  <td class=xl56></td>
  <td class=xl30></td>
  <td class=xl38></td>
  <td class=xl39></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=205 style='width:154pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=86 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
