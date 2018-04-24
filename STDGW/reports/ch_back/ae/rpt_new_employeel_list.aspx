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
    string p_thr_group_pk, p_nation, p_search_by, p_search_temp, p_from_joindate, p_to_joindate;
    string p_salary_yn, p_position, p_pay_type, p_contract_kind, p_from_contract, p_to_contract;
    string p_sex, p_insurance_yn, p_status, p_from_leftdate, p_to_leftdate, p_from_birthdate;
    string p_ot_yn, p_to_birthdate, p_tco_org_pk, p_sal_security;
    string p_job, p_education, p_union, p_lstProject, p_wg, p_birth_month, p_section_type;

    p_thr_group_pk = Request["p1"].ToString();
    p_nation = Request["p2"].ToString();
    p_search_by = Request["p3"].ToString();
    p_search_temp = Request["p4"].ToString();
    p_from_joindate = Request["p5"].ToString();
    p_to_joindate = Request["p6"].ToString();
    p_salary_yn = Request["p7"].ToString();
    p_position = Request["p8"].ToString();
    p_pay_type = Request["p9"].ToString();
    p_contract_kind = Request["p10"].ToString();
    p_from_contract = Request["p11"].ToString();
    p_to_contract = Request["p12"].ToString();
    p_sex = Request["p13"].ToString();
    p_insurance_yn = Request["p14"].ToString();
    p_status = Request["p15"].ToString();
    p_from_leftdate = Request["p16"].ToString();
    p_to_leftdate = Request["p17"].ToString();
    p_from_birthdate = Request["p18"].ToString();
    p_ot_yn = Request["p19"].ToString();
    p_to_birthdate = Request["p20"].ToString();
    p_tco_org_pk = Request["p21"].ToString();
    p_sal_security = Request["p22"].ToString();
    p_job = Request["p23"].ToString();
    p_education = Request["p24"].ToString();
    p_union = Request["p25"].ToString();
    p_birth_month = Request["p26"].ToString();
    p_section_type = Request["p27"].ToString();
    string p_emp_type = Request["p28"].ToString();
  
    string p_dt = DateTime.Today.Day.ToString() + "/" + DateTime.Today.Month.ToString() + "/" + DateTime.Today.Year.ToString();


    string SQL
      = "select  " +
          " (select max(g.ORG_NM ) from comm.tco_org g where     " +
          "        g.del_if=0  and g.ORG_TYPE='03'  " +
          "    start with g.pk=c.pk  " +
          "    connect by prior g.p_pk=g.pk   " +
          " )as t2  " +
          " ,c.ORG_NM  " +
          " ,(select v.CODE_NM from vhr_hr_code v where v.id='HR0008' and v.code=nvl(a.pos_type,' '))  " +
          " ,a.FULL_NAME  " +
          " ,decode(a.SEX,'M','Male','Female' )  " +
          " ,a.emp_id  " +
         " ,to_char(to_date(a.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
           " ,(select v.code_nm from vhr_hr_code v where v.code= a.edu_type and v.id='HR0011' )  " +
           " ,a.REMARK   ";
      SQL = SQL + "from thr_employee a,thr_work_group b,comm.tco_org c ";
  SQL = SQL + "where a.del_if=0 and b.del_if=0 and c.del_if=0 ";
  SQL = SQL + "and a.thr_wg_pk=b.pk  ";
  SQL = SQL + "and a.tco_org_pk=c.pk ";
  SQL = SQL + "and decode('" + p_thr_group_pk + "','ALL','ALL',b.pk)='" + p_thr_group_pk + "'";
  SQL = SQL + "and decode('" + p_emp_type + "','ALL','ALL',a.Employee_type)='" + p_emp_type + "'";
  SQL = SQL + "and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation + "'";
  SQL = SQL + "and decode('" + p_section_type + "','ALL','ALL',a.Section_type )='" + p_section_type + "'";
  SQL = SQL + "and (('" + p_search_by + "'='1' and upper(a.FULL_NAME) like  '%' || upper('" + p_search_temp + "') || '%') ";
  SQL = SQL + "         or ('" + p_search_by + "'='2' and upper(a.emp_id) like  '%' || upper('" + p_search_temp + "') || '%') ";
  SQL = SQL + "         or ('" + p_search_by + "'='3' and upper(a.id_num) like  '%' || upper('" + p_search_temp + "') || '%') ";
  SQL = SQL + "         or ('" + p_search_by + "'='4' and upper(a.PERSON_ID ) like  '%' || upper('" + p_search_temp + "') || '%') ";
  SQL = SQL + "         or ('" + p_search_by + "'='5' and upper(a.OLD_ID ) like  '%' || upper('" + p_search_temp + "') || '%')) ";
  SQL = SQL + "and (('" + p_from_joindate + "' is null and '" + p_to_joindate + "' is null)  ";
  SQL = SQL + "         or (a.JOIN_DT between '" + p_from_joindate + "' and '" + p_to_joindate + "') ) ";
  SQL = SQL + "and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn + "'";
  SQL = SQL + "and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position + "'";
  SQL = SQL + "and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type + "'";
  SQL = SQL + "and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind + "'";
  SQL = SQL + "and (('" + p_from_contract + "' is null and '" + p_to_contract + "' is null)  ";
  SQL = SQL + "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) ";
  SQL = SQL + "and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' ";
  SQL = SQL + "and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn + "'";
  SQL = SQL + "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'";
  SQL = SQL + "and (('" + p_from_leftdate + "' is null and '" + p_to_leftdate + "' is null)  ";
  SQL = SQL + "    or (a.LEFT_DT between '" + p_from_leftdate + "' and '" + p_to_leftdate + "') ) ";
  SQL = SQL + " and (('" + p_from_birthdate + "' is null and '" + p_to_birthdate + "' is null)  ";
  SQL = SQL + "    or (decode(length(a.BIRTH_DT),4,a.birth_dt || '0101',a.birth_dt) between '" + p_from_birthdate + "' and '" + p_to_birthdate + "') ) ";
  SQL = SQL + "and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn + "'";
  SQL = SQL + " and decode('" + p_union + "','ALL','ALL',a.union_yn)='" + p_union + "'";
  SQL = SQL + "AND (   a.tco_org_pk IN ( ";
  SQL = SQL + "                         SELECT     g.pk ";
  SQL = SQL + "                               FROM comm.tco_org g ";
  SQL = SQL + "                              WHERE g.del_if = 0 ";
  SQL = SQL + "                         START WITH g.pk = ";
  SQL = SQL + "                                       DECODE ('" + p_tco_org_pk + "', ";
  SQL = SQL + "                                               'ALL', 0, ";
  SQL = SQL + "                                               '" + p_tco_org_pk + "'";
  SQL = SQL + "                                              ) ";
  SQL = SQL + "                         CONNECT BY PRIOR g.pk = g.p_pk) ";
  SQL = SQL + "                   OR '" + p_tco_org_pk + "' = 'ALL') ";
  SQL = SQL + "AND ('" + p_birth_month + "'= 'ALL' or (LENGTH(A.BIRTH_DT)=8 and substr(A.BIRTH_DT,5,2)= '" + p_birth_month + "')) ";
  SQL = SQL + "order by nvl(c.seq,99999),emp_id ";
   
        
        
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2011-06-27T07:53:25Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-27T08:39:31Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .2in .1in .2in;
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
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1474 style='border-collapse:
 collapse;table-layout:fixed;width:1108pt'>
 <col class=xl25 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl26 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl26 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl26 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl26 width=176 style='mso-width-source:userset;mso-width-alt:6436;
 width:132pt'>
 <col class=xl25 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl25 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl25 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl25 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <col class=xl26 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl26 width=230 style='mso-width-source:userset;mso-width-alt:8411;
 width:173pt'>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td colspan=9 height=51 class=xl38 width=1474 style='height:38.25pt;
  width:1108pt'>REPORT NEW EMPLOYEES </td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=4 height=32 class=xl42 style='height:24.0pt'>REPORT DATE: <%=p_dt %></td>
  <td class=xl40 colspan=2 x:str>REPORT BY : <%=Session["USER_NAME"]%></td>
  <td class=xl40></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=4 height=27 class=xl41 style='height:20.25pt'>FROM DATE: <%=p_from_joindate.Substring(6, 2) + "/" + p_from_joindate.Substring(4, 2) + "/" + p_from_joindate.Substring(0, 4)%> ~ <%=p_to_joindate.Substring(6, 2) + "/" + p_to_joindate.Substring(4, 2) + "/" + p_to_joindate.Substring(0, 4)%> </td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl33 width=58 style='height:33.0pt;border-top:none;
  width:44pt'>No</td>
  <td class=xl34 width=158 style='border-top:none;border-left:none;width:119pt'>Factory</td>
  <td class=xl34 width=110 style='border-top:none;border-left:none;width:83pt'>Section</td>
  <td class=xl34 width=137 style='border-top:none;border-left:none;width:103pt'>Position</td>
  <td class=xl34 width=176 style='border-left:none;width:132pt'>Full name</td>
  <td class=xl34 width=129 style='border-left:none;width:97pt'>Sex</td>
  <td class=xl34 width=108 style='border-left:none;width:81pt'>ID</td>
  <td class=xl34 width=101 style='border-left:none;width:76pt'>Join date</td>
   <td class=xl34 width=140 style='border-left:none;width:105pt'>Education</td>
  <td class=xl35 width=230 style='border-left:none;width:173pt'>Remark</td>
 </tr>
 <%for(int i=0;i<dt_emp.Rows.Count;i++) {%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'><%=i+1 %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][7].ToString() %></td>
   <td class=xl36 style='border-top:none;border-left:none'><%=dt_emp.Rows[i][8].ToString() %></td>
 </tr>
 <%} %>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=58 style='width:44pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=176 style='width:132pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=230 style='width:173pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
