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
    string l_group = Request.QueryString["l_group"].ToString();
    string l_m_type = Request.QueryString["l_m_type"].ToString();
    string l_bn_times = Request.QueryString["l_bn_times"].ToString();
    string l_emp_id = Request.QueryString["l_emp_id"].ToString();
    string l_dept = Request.QueryString["l_dept"].ToString();
    string l_year = Request.QueryString["l_year"].ToString();
    
    string SQL
	= "  select  " + 
        "  e.PARTNER_LNAME a0 " +
        "  ,a.emp_id a2 " +
        "  ,a.full_name a1 " +
        "  ,d.org_nm a4 " +
        "  ,(select h.code_nm from vhr_hr_code h where h.id='HR0008' and h.code=a.pos_type) a5 " +
        "  ,to_char(to_date(a.join_dt,'yyyymmdd'),'dd-MON-yyyy') a3 " +
        "  ,nvl(c.ALE_PAY_AMT,0) a28 " +
        "  ,nvl(b.BN_AMT,0) a10 " +
        "  ,nvl(b.ADV_AMT,0) a11 " +
        "  ,nvl(b.BONUS_ALE_ADV_AMT,0) a29 " +
        "  from thr_employee a, thr_bonus b,thr_annual_leave c,tco_org d,tco_company e " +
        "  where a.del_if=0 and b.del_if=0 and c.del_if(+)=0 and d.del_if=0 and e.del_if=0  " +
        "  and a.tco_org_pk=d.pk and a.tco_company_pk=e.pk " +
        "  and b.thr_emp_pk=a.pk " +
        "  and b.thr_emp_pk=c.thr_emp_pk(+) " +
        "  and b.BN_YEAR='" + l_year + "' " +
        "  and c.an_year(+)='" + l_year + "' " +
        "    and decode('" + l_m_type + "','ALL','" + l_m_type + "',b.MONEY_KIND)='" + l_m_type + "'  " +
        "    and decode('" + l_bn_times + "','ALL','" + l_bn_times + "',b.BN_TIMES)='" + l_bn_times + "'  " +
        "    and (a.EMP_ID like  '%'||'" + l_emp_id + "'||'%' or '" + l_emp_id + "' is null) " +
        "    and (a.tco_org_PK in   (  " +
        "                              SELECT     g.pk  " +
        "                                    FROM tco_org g  " +
        "                                   WHERE g.del_if = 0  " +
                "                              START WITH g.pk =  " +
        "                                            DECODE ('" + l_dept + "',  " +
        "                                                    'ALL', 0,  " +
        "                                                    '" + l_dept + "'  " +
        "                                                   )  " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "            OR '" + l_dept + "' = 'ALL')  " +
        "   order by  a.EMP_ID     ";
    //Response.Write(SQL);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    int emp_row=dt_emp.Rows.Count;
    int emp_col=dt_emp.Columns.Count;
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }


        
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bonus_sign_cash_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bonus_sign_cash_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bonus_sign_cash_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nobland</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2012-08-15T03:33:19Z</o:LastPrinted>
  <o:Created>2012-01-15T09:47:56Z</o:Created>
  <o:LastSaved>2012-08-15T03:33:29Z</o:LastSaved>
  <o:Company>nobland</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&L&\0022Arial\,Regular\0022      \000A     NGÆ¯á»œI PHT TIá»€N\000A  \(K\, ghi ríµ‚í¸œ1ECD tê®œ\, MSNV\)&\0022VNI-Times\,Normal\0022\000A";
	margin:.5in 0in 1.0in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
.font8
	{color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Bodoni MT Black", serif;
	mso-font-charset:0;}
.font9
	{color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Bodoni MT Black", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:9.0pt;
	font-weight:700;
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
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-family:VNI-Times;
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
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Helve-Condense;
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
	font-family:VNI-Times;
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
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl28
	{mso-style-parent:style22;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:top;}
.xl29
	{mso-style-parent:style22;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl30
	{mso-style-parent:style22;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl31
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl40
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	padding-left:9px;
	mso-char-indent-count:1;}
.xl42
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm\\-yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl49
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style22;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style22;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style22;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Bodoni MT Black", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
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
       <x:ActiveRow>5</x:ActiveRow>
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
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1010 style='border-collapse:
 collapse;table-layout:fixed;width:760pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=160 style='mso-width-source:userset;mso-width-alt:5851;width:120pt'>
 <col width=101 span=2 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <tr height=22 style='height:16.5pt'>
  <td colspan=3 height=22 class=xl51 align=left width=245 style='height:16.5pt;
  width:184pt'><%=dt_emp.Rows[0][0].ToString() %></td>
  <td class=xl26 width=101 style='width:76pt'></td>
  <td class=xl25 width=101 style='width:76pt'></td>
  <td class=xl25 width=74 style='width:56pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=97 style='width:73pt'></td>
  <td colspan=2 height=22 width=198 style='height:16.5pt;width:149pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
   direction:LTR;text-align:left;margin-left:1in;margin-top:3pt;width:60pt;
   height:11.25pt;z-index:1'>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:96px;margin-top:4px;width:80px;
  height:15px'><img width=80 height=15
  src="rpt_bonus_sign_cash_files/image001.gif" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=22 class=xl52 align=right width=198 style='height:
    16.5pt;width:149pt' x:num>1</td>
   </tr>
  </table>
  </span></td>
  <td width=108 style='width:81pt'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=10 height=40 class=xl53 style='height:30.0pt'>13<font
  class="font9"><sup>TH</sup></font><font class="font8"> SALARY + ANNUAL LEAVE
  <%=l_year %> - BY CASH</font></td>
  <td></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=10 height=32 class=xl53 style='height:24.0pt'>SALARY JANUARY <%=int.Parse(l_year)+1 %></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 colspan=2 align=left style='height:18.0pt;
  mso-ignore:colspan'>Payment date :</td>
  <td class=xl28>02-FEB-<%=int.Parse(l_year)+1 %></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl29></td>
  <td></td>
 </tr>
 <tr class=xl32 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl33 style='height:27.0pt'>NO.</td>
  <td class=xl34>CODE</td>
  <td class=xl34>FULLNAME</td>
  <td class=xl34>SECTION</td>
  <td class=xl34>POSITION</td>
  <td class=xl35 width=74 style='width:56pt'>STARTING DATE</td>
  <td class=xl35 width=86 style='width:65pt'>ANNUAL <br>
    LEAVE</td>
  <td class=xl35 width=97 style='width:73pt'>13<font class="font16"><sup>TH </sup></font><font
  class="font15">SALARY</font></td>
  <td class=xl35 width=100 style='width:75pt'>SALARY<br>
    JAN-11</td>
  <td class=xl36 width=98 style='width:74pt'>FINAL PAYMENT</td>
  <td class=xl37>SIGNATURE</td>
 </tr>
 <% 
    double[] Group_Total=new double[emp_col];
    for (int j = 0; j < emp_col; j++)
    {
        Group_Total[j] = 0;
      
    }
    
    for(int i=0;i<emp_row;i++)
    { 
        for (int j=6;j<emp_col;j++)
        {
            Group_Total[j]+=Double.Parse(dt_emp.Rows[i][j].ToString());
        }
    %>
 <tr class=xl38 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl39 style='height:21.0pt'><%=i+1 %></td>
  <td class=xl40 x:num ><%=dt_emp.Rows[i][1].ToString() %></td>
  <td class=xl41><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl41><%=dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl41><%=dt_emp.Rows[i][4].ToString() %></td>
  <td class=xl42 x:num><%=dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl43 x:num><%=dt_emp.Rows[i][6].ToString() %></td>
  <td class=xl43 x:num><%=dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl43 x:num><%=dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl44 x:num><%=dt_emp.Rows[i][9].ToString() %></td>
  <td class=xl45>&nbsp;</td>
 </tr>
<%
} %>
 <tr class=xl38 height=28 style='height:21.0pt'>
  <td colspan=6 height=28 class=xl48 style='border-right:.5pt solid black;
  height:21.0pt'>TOTAL</td>
  <td class=xl46 x:num><%=Group_Total[6] %></td>
  <td class=xl46 x:num><%=Group_Total[7] %></td>
  <td class=xl46 x:num><%=Group_Total[8] %></td>
  <td class=xl46 x:num style="white-space:normal;mso-text-control:shrinktofit;"><%=Group_Total[9] %></td>
  <td class=xl47>&nbsp;</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=11 style='height:22.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=11 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=11 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=108 style='width:81pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
