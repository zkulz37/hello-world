﻿<%@ Page Language="C#"%>
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
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();  
    
    string SQL
	= "select a.EMP_ID as c0 " + 
        ",a.FULL_NAME as c1 " +
        ",decode(a.sex,'F',substr(a.BIRTH_DT,1,4),'') as c2 " +
        ",decode(a.sex,'M',substr(a.BIRTH_DT,1,4),'')  as c3 " +
        ",(select code_nm from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH) as c4 " +
        ",(select char_1 from vhr_hr_code where id='HR0009' and code=a.NATION ) as c5 " +
        ",(select decode(nvl(num_1,0),7,'X','') from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) as c6  " +
        ",(select decode(nvl(num_1,0),6,'X',5,'X','') from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) as c7 " +
        ",(select decode(nvl(num_1,0),4,'X','') from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) as c8 " +
        ",(select decode(nvl(num_1,0),3,code_nm,'') from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) as c9 " +
        ",(select decode(nvl(num_1,0),2,code_nm,'') from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) as c10 " +
        ",'' as c11 " +
        ",'X' as c12 " +
        ",to_char(to_date(a.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') as c13 " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code=a.pos_type) as c14 " +
        ",b.basic_sal as c15 " +
        "from thr_employee a,thr_labour_contract b " +
        "where a.del_if=0 and b.CONTRACT_TYPE='02' and b.del_if=0 " +
        "and b.thr_employee_pk=a.pk " +
        "and substr(b.BEGIN_CONTRACt,1,6) = '" + p_work_mon + "' " +
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
        "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
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
        "and rownum=1 " ;

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
<link rel=File-List href="rpt_new_workers_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_new_workers_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_new_workers_files/oledata.mso">
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
  <o:LastAuthor>TYML</o:LastAuthor>
  <o:LastPrinted>2009-05-14T07:12:25Z</o:LastPrinted>
  <o:Created>2006-02-04T06:35:07Z</o:Created>
  <o:LastSaved>2009-05-14T07:13:24Z</o:LastSaved>
  <o:Company>FM9FY-TMF7Q-KCKCT-V9T29-TBBBG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.36in .16in .38in .28in;
	mso-header-margin:.28in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
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
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:locked hidden;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl49
	{mso-style-parent:style0;
	font-size:8.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>115</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Watches>
     <x:Watch>
      <x:Source>$C$7</x:Source>
     </x:Watch>
    </x:Watches>
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
  <x:WindowHeight>8790</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$13:$14</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1018 style='border-collapse:
 collapse;table-layout:fixed;width:765pt'>
 <col class=xl25 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl25 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl25 width=165 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 <col class=xl25 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl25 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl26 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl25 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl26 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl26 width=40 span=2 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl25 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl25 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl25 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl27 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl28 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl25 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl25 width=38 style='height:12.0pt;width:29pt'></td>
  <td class=xl25 width=48 style='width:36pt'></td>
  <td class=xl25 width=165 style='width:124pt'></td>
  <td class=xl29 colspan=8 width=348 style='mso-ignore:colspan;width:261pt'><span
  style='mso-spacerun:yes'>                                  </span>CÔNG HOÀ XÃ
  H&#7896;I CH&#7910; NGH&#296;A VI&#7878;T<span style='mso-spacerun:yes'> 
  </span>NAM</td>
  <td class=xl25 width=33 style='width:25pt'></td>
  <td class=xl25 width=31 style='width:23pt'></td>
  <td class=xl25 width=38 style='width:29pt'></td>
  <td class=xl27 width=72 style='width:54pt'></td>
  <td width=126 style='width:95pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1050" type="#_x0000_t75" style='position:absolute;
   margin-left:5.25pt;margin-top:1.5pt;width:171.75pt;height:31.5pt;z-index:1'>
   <v:imagedata src="rpt_new_workers_files/image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:7px;margin-top:2px;width:229px;
  height:42px'><img width=229 height=42 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1050"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl25 width=126 style='height:12.0pt;width:95pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl28 width=68 style='width:51pt'></td>
  <td class=xl25 width=51 style='width:38pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl30 colspan=3 style='height:12.0pt;mso-ignore:colspan'><%=dt_Com.Rows[0][0].ToString()%><span style='mso-spacerun:yes'>  </span><font class="font5"><span
  style='mso-spacerun:yes'>     </span></font></td>
  <td class=xl25></td>
  <td class=xl25 colspan=7 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                                         
  </span>&#272;&#7897;c l&#7853;p - T&#7921; do - H&#7841;nh phúc</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl25 style='height:12.0pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>             </span>-----o0o-----</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>             </span>-----o0o-----</td>
  <td class=xl26></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=5 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>Ngày
  <%=DateTime.Today.Day.ToString() %> tháng <%=DateTime.Today.Month.ToString() %> n&#259;m <%=DateTime.Today.Year.ToString() %></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl25>S&#7889;:………………………</td>
  <td class=xl25></td>
  <td class=xl29 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                  </span>KHAI TRÌNH &#272;&#258;NG
  KÝ VI&#7878;C S&#7916; D&#7908;NG LAO &#272;&#7896;NG</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=4 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl29 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                         </span>KHI DOANH<span
  style='mso-spacerun:yes'>  </span>NGHI&#7878;P B&#7854;T &#272;&#7846;U
  HO&#7840;T &#272;&#7896;NG</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=5 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl29 colspan=7 style='mso-ignore:colspan'>(DSCNV
  &#272;&#431;&#7906;C KÝ H&#272; THÁNG  <%=p_work_mon.Substring(4,2) + "/" +  p_work_mon.Substring(0,4)%>)</td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=3 class=xl25 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl29 colspan=7 style='mso-ignore:colspan'>KÍNH G&#7916;I: BAN
  QU&#7842;N LÝ CÁC KCN</td>
  <td class=xl26></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=5 class=xl25 style='height:9.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=5 class=xl25 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td rowspan=2 height=77 class=xl51 style='border-bottom:.5pt solid black;
  height:57.75pt'>Stt</td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black'>Mã s&#7889;</td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black'>H&#7885; và
  Tên</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>N&#259;m sinh</td>
  <td rowspan=2 class=xl56 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>H&#7897; kh&#7849;u th&#432;&#7901;ng trú</td>
  <td rowspan=2 class=xl56 width=39 style='border-bottom:.5pt solid black;
  width:29pt'>Qu&#7889;c t&#7883;ch</td>
  <td colspan=5 class=xl58 width=178 style='border-right:.5pt solid black;
  border-left:none;width:134pt'>Trình &#273;&#7897; chuyên môn, c&#7845;p
  b&#7853;c CN</td>
  <td colspan=2 class=xl61 width=69 style='border-right:.5pt solid black;
  border-left:none;width:52pt'>H&#7907;p &#273;&#7891;ng lao &#273;&#7897;ng</td>
  <td rowspan=2 class=xl63 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Ngày ký H&#272;L&#272;</td>
  <td rowspan=2 class=xl56 width=126 style='border-bottom:.5pt solid black;
  width:95pt'>Ch&#7913;c danh công vi&#7879;c</td>
  <td rowspan=2 class=xl56 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>M&#7913;c l&#432;&#417;ng H&#272;L&#272;</td>
  <td rowspan=2 class=xl56 width=51 style='border-bottom:.5pt solid black;
  width:38pt'>Ghi chú</td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl32 style='height:29.25pt'>N&#7919;</td>
  <td class=xl32>Nam</td>
  <td class=xl33 width=34 style='width:26pt'>Trên &#272;H</td>
  <td class=xl33 width=31 style='width:23pt'>&#272;H, C&#272;</td>
  <td class=xl33 width=40 style='width:30pt'>Trung c&#7845;p</td>
  <td class=xl33 width=40 style='width:30pt'>Ph&#7893; thông</td>
  <td class=xl33 width=33 style='width:25pt'>B&#7853;c CN</td>
  <td class=xl33 width=31 style='width:23pt'>Dài h&#7841;n</td>
  <td class=xl33 width=38 style='width:29pt'>1-3 n&#259;m</td>
 </tr>
 <% 
     for (int i = 0; i < irow; i++) 
    {
       
    %> 
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl31 style='height:12.0pt' x:num><%=i+1 %></td>
  <td class=xl34><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl35><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl36><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl36 x:num><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl37><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl38 ><% = dt_total.Rows[i][5].ToString()%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl39><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl40><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl39><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl41 ><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl42><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl39><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl39><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl43><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl37><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl44 x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <%} %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl46 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td class=xl49></td>
  <td class=xl28></td>
  <td class=xl46></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl46 style='height:15.0pt'></td>
  <td class=xl50 colspan=5 style='mso-ignore:colspan'>Xét duy&#7879;t c&#7911;a
  Ban Q&#7911;an Lý KCN </td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl50 colspan=3 style='mso-ignore:colspan'>Th&#7911;
  tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl28></td>
  <td class=xl46></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl46 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl46></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl50 colspan=3 style='mso-ignore:colspan'>(Ký tên, &#273;óng
  d&#7845;u)</td>
  <td class=xl28></td>
  <td class=xl46></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=51 style='width:38pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
