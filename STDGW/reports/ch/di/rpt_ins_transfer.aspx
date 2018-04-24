<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_org = Request["p_org"].ToString();
    string p_group = Request["p_group"].ToString();
    string p_search = Request["p_search"].ToString();
    string p_text = Request["p_text"].ToString();
    string p_kind = Request["p_kind"].ToString();
    string p_status = Request["p_status"].ToString();
    string p_month = Request["p_month"].ToString();
    string p_book = Request["p_book"].ToString();

       string SQL
	= " select 0   " + 
        ",a.EMP_ID " +
        ",a.FULL_NAME " +
        ",decode(nvl(a.sex,'0'),'M',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as Male  " +
        ",decode(nvl(a.sex,'0'),'F',(case when length(a.BIRTH_DT)>4 then to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else substr(a.BIRTH_DT,1,4) end),'') as FeMale " +
        ",a.PERSON_ID " +
        ",a.SOCIAL_NO " +
        ",to_char(to_date(e.INS_MONTH,'yyyymm'),'mm/yyyy') ins_mon " +
        "from thr_insurance_reserve e, thr_employee a " +
        "where a.del_if=0 and e.del_if=0 " +
        "and e.THR_EMP_PK = a.pk " +
        "and   ( a.TCO_ORG_PK in( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('"+ p_org +"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+ p_org +"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '"+ p_org +"' = 'ALL') " +
        "        AND (DECODE('"+ p_search +"','1',UPPER(a.EMP_ID),'2',a.ID_NUM,'3',UPPER(a.FULL_NAME)) LIKE '%'||UPPER('"+ p_text +"') " +
        "                OR '"+ p_text +"' IS NULL)               " +
        "       and decode('"+ p_group +"','ALL','"+ p_group +"',a.thr_wg_pk)='"+ p_group +"' " +
        "       and decode('"+ p_kind +"','ALL','"+ p_kind +"',e.RESERVE_KIND )='"+ p_kind +"' " +
        "       and decode('"+ p_status +"','ALL','"+ p_status +"',a.status)='"+ p_status +"' " +
        "       and e.MOVE_MONTH = '"+ p_month +"' " +
        "       and decode('"+ p_book +"','ALL','"+ p_book +"',a.Social_book )='"+ p_book +"' " +
        "       order by  e.RESERVE_DT ";
        
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
    //getting employeer
    SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_ins_transfer_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_ins_transfer_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_ins_transfer_files/oledata.mso">
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
  <o:LastPrinted>2011-11-14T02:53:56Z</o:LastPrinted>
  <o:Created>2011-11-14T02:46:13Z</o:Created>
  <o:LastSaved>2011-11-14T09:08:38Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\,";
	mso-displayed-thousand-separator:"\.";}
@page
	{margin:.19in 0in .2in .59in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;}
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
	mso-font-charset:163;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style56
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
	mso-style-name:"Normal 2";}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl66
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style56;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl71
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl72
	{mso-style-parent:style56;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl73
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style56;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl79
	{mso-style-parent:style56;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	}
.xl80
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style56;
	color:windowtext;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style56;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style56;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl93
	{mso-style-parent:style56;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>CHUYEN DEN</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7995</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
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

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=833 style='border-collapse:
 collapse;table-layout:fixed;width:624pt'>
 <col class=xl66 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl66 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl66 width=177 style='mso-width-source:userset;mso-width-alt:6473;
 width:133pt'>
 <col class=xl66 width=71 span=3 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <col class=xl67 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 <col class=xl66 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl66 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <tr class=xl68 height=25 style='height:18.75pt'>
  <td colspan=6 height=25 class=xl84 width=502 style='height:18.75pt;
  width:376pt'>C&#7845;p ngành qu&#7843;n lý: BHXH Huy&#7879;n Nh&#417;n
  Tr&#7841;ch</td>
  <td class=xl85 width=123 style='width:92pt'>&nbsp;</td>
  <td class=xl83 width=108 style='width:81pt'>&nbsp;</td>
  <td class=xl83 width=100 style='width:75pt'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=25 style='height:18.75pt'>
  <td height=25 class=xl90 colspan=4 style='height:18.75pt;mso-ignore:colspan'>Tên
  &#273;&#417;n v&#7883;: <%=dt_name.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl87><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl83>&nbsp;</td>
 </tr>
 <tr class=xl68 height=25 style='height:18.75pt'>
  <td height=25 class=xl84 colspan=4 style='height:18.75pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7881;: <%=dt_name.Rows[2][0].ToString()%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl84 style='height:15.75pt'>S&#7889; &#272;T:
  (0613)569291~298</td>
  <td colspan=3 class=xl81>Fax: (0613)569299</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl84 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl84 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl83 height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl93 style='height:20.25pt'>DANH SÁCH LAO
  &#272;&#7896;NG CHUY&#7874;N S&#7892; THÁNG 07-2011</td>
  <td class=xl83>&nbsp;</td>
 </tr>
 <tr class=xl68 height=27 style='height:20.25pt'>
  <td height=27 colspan=3 class=xl81 style='height:20.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl82 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl80>29.07.2011</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl81 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl79 style='height:31.5pt'>STT</td>
  <td rowspan=2 class=xl79>MSNV</td>
  <td rowspan=2 class=xl79>H&#7884; VÀ TÊN</td>
  <td colspan=2 class=xl79 style='border-left:none'>N&#258;M SINH</td>
  <td class=xl79 style='border-left:none'>CMND</td>
  <td rowspan=2 class=xl92 width=123 style='width:92pt'>S&#7888; S&#7892;<br>
    <span style='mso-spacerun:yes'> </span>BHXH</td>
  <td rowspan=2 class=xl92 width=108 style='width:81pt'>GHI CHÚ<br>
    (Tgian tgia BH)</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl79 style='height:15.75pt' x:str>NAM<span style='mso-spacerun:yes'> </span></td>
  <td class=xl79 style='border-top:none;border-left:none'>N&#7918;</td>
  <td class=xl79 style='border-top:none;border-left:none' x:str="S&#7888; ">S&#7888;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr class=xl68 height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl74 style='height:.75pt'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-left:none'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
 </tr>
  <% 
     int count=0;
     for (int i = 0; i < irow; i++)
     {
         count++;
    %>
 <tr class=xl68 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt;border-top:none' x:num><%= count %></td>
  <td class=xl78 style='border-top:none;border-left:none'><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl77 style='border-top:none;border-left:none'><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl76 style='border-top:none;border-left:none' x:str><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl75 style='border-top:none;border-left:none'><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl76 style='border-top:none;border-left:none' x:str><%=dt_total.Rows[i][6].ToString()%></td>
  <td class=xl91 style='border-top:none;border-left:none'><%=dt_total.Rows[i][7].ToString()%></td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <%} %>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td height=17 class=xl67 width=123 style='height:12.75pt;width:92pt'>&nbsp;</td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'>&nbsp;</td>
  <td class=xl68>Ng&#432;&#7901;i l&#7853;p</td>
  <td colspan=7 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=177 style='width:133pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=100 style='width:75pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
