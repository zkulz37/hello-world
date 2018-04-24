﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_nation, p_org_pk, p_status;
    string p_from = Request.QueryString["p_1"].ToString();
    string p_to = Request.QueryString["p_2"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_org_pk = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();

    int month = int.Parse(p_from.Substring(4, 2));
    
    string SQL
    = "select sub.c00, c01, c02, c03, c04, c05, c06, c07, c08, c09, c10 " +
        "        , case when  c11 in ('02','03') and ( to_number(substr(c21,-2))=" + month + " )  then c21 else '' end c12  " +
        "        , case when c11 in ('01') and ( to_number(substr(c21,-2))=" + month + " ) then c21 else '' end c13 " +
        "        , case when c11 in ('04','06') and ( to_number(substr(c21,-2))=" + month + " ) then c21 else '' end c14 " +
        "        , to_number(substr(c19,1,2)) c18, c19, c20 , c21 " +
        "from  " +
        "(select E.EMP_ID c00 " +
        "    , E.FULL_NAME c01 " +
        "    , G.ORG_ID c02 " +
        "    , (select code_nm from vhr_hr_code v where id='HR0008' and code=E.POS_TYPE) c03 " +
        "    , to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c04 " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c05 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c06 " +
        "    , decode(E.SEX,'M','Male','Female') c07 " +
        "    , decode(nvl(E.MARRIED_YN,'N'),'N','Single','Married') c08 " +
        "    , to_char(to_date(decode(nvl(E.BEGIN_CONTRACT,' '),' ', E.BEGIN_PROBATION, E.BEGIN_CONTRACT),'yyyymmdd'),'dd/mm/yyyy') " +
        "        ||'~'|| " +
        "        to_char(to_date(decode(nvl(E.BEGIN_CONTRACT,' '),' ', E.END_PROBATION, E.END_CONTRACT),'yyyymmdd'),'dd/mm/yyyy') c09 " +
        "    , case when E.CONTRACT_TYPE='01' then  (select code_nm from vhr_hr_code v where code=E.PROB_TYPE and id='HR0002') " +
        "            else (select code_nm from vhr_hr_code v where code=E.CONTRACT_TYPE and id='HR0001') " +
        "      end c10 " +
        "    , E.CONTRACT_TYPE c11 " +
        "    , case when E.CONTRACT_TYPE='04' then substr(E.BEGIN_CONTRACT,-4)  " +
        "            else substr(decode(nvl(E.BEGIN_CONTRACT,' '),' ', E.END_PROBATION, E.END_CONTRACT),-4) " +
        "      end c19 " +
        "    , case when E.CONTRACT_TYPE='04' then to_char(to_date(E.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm')  " +
        "            else to_char(to_date(decode(nvl(E.BEGIN_CONTRACT,' '),' ', E.END_PROBATION, E.END_CONTRACT),'yyyymmdd'),'dd/mm')  " +
        "      end c20 " +
        "    , case when E.CONTRACT_TYPE='04' then to_char(to_date(E.BEGIN_CONTRACT,'yyyymmdd')+1,'dd/mm')  " +
        "            else to_char(to_date(decode(nvl(E.BEGIN_CONTRACT,' '),' ', E.END_PROBATION, E.END_CONTRACT),'yyyymmdd')+1,'dd/mm')  " +
        "      end c21   " +
        "from thr_employee e, tco_org g " +
        "where E.DEL_IF=0 " +
        "and G.DEL_IF=0 " +
        "and E.TCO_ORG_PK=g.pk " +
        "and decode('" + p_nation + "','ALL','ALL',e.nation)='" + p_nation + "' " +
        "and decode('" + p_status + "','ALL','ALL',E.STATUS)='" + p_status + "' " +
        "and E.MONEY_KIND in ('01','02') " +
        " AND (   e.tco_org_pk IN ( " +
             "                         SELECT     g.pk " +
             "                               FROM tco_org g " +
             "                              WHERE g.del_if = 0 " +
             "                         START WITH g.pk = " +
             "                                       DECODE ('" + p_org_pk + "', " +
             "                                               'ALL', 0, " +
             "                                               '" + p_org_pk + "'" +
             "                                              ) " +
             "                         CONNECT BY PRIOR g.pk = g.p_pk) " +
             "                   OR '" + p_org_pk + "' = 'ALL') " +
        ") sub " +
        "order by c19, c00 ";

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        
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
<link rel=File-List href="rpt_contract_information2_pcss_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_contract_information2_pcss_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_contract_information2_pcss_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:LastPrinted>2013-04-16T07:53:14Z</o:LastPrinted>
  <o:Created>2013-02-21T01:57:56Z</o:Created>
  <o:LastSaved>2013-04-18T08:29:13Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;}
.xl70
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl75
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl90
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;}
.xl91
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>21-01-2013 </x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>600</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7110</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='21-01-2013 '!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1786 style='border-collapse:
 collapse;table-layout:fixed;width:1339pt'>
 <col class=xl65 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl65 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl67 width=212 style='mso-width-source:userset;mso-width-alt:7753;
 width:159pt'>
 <col class=xl67 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl68 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl69 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl69 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl69 width=43 span=2 style='mso-width-source:userset;mso-width-alt:
 1572;width:32pt'>
 <col class=xl69 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl69 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl67 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl70 width=67 span=3 style='mso-width-source:userset;mso-width-alt:
 2450;width:50pt'>
 <col class=xl65 width=96 span=6 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=34 style='height:25.5pt'>
  <td height=34 width=39 style='height:25.5pt;width:29pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_7" o:spid="_x0000_s1034" type="#_x0000_t75"
   alt="posco ss-vina logo" style='position:absolute;margin-left:4.5pt;
   margin-top:0;width:88.5pt;height:48.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_contract_information2_pcss_files/image001.jpg"
    o:title="posco ss-vina logo"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:6px;margin-top:0px;width:118px;
  height:65px'><img width=118 height=65
  src="rpt_contract_information2_pcss_files/image002.jpg"
  alt="posco ss-vina logo" v:shapes="Picture_x0020_7"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=34 class=xl65 width=39 style='height:25.5pt;width:29pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl76 width=0></td>
  <td colspan=13 class=xl89 width=1171 style='width:878pt'>LIST OF CONTRACT
  INFORMATION OF EMPLOYEES</td>
  <td class=xl65 width=96 style='width:72pt'></td>
  <td class=xl65 width=96 style='width:72pt'></td>
  <td class=xl65 width=96 style='width:72pt'></td>
  <td class=xl65 width=96 style='width:72pt'></td>
  <td class=xl65 width=96 style='width:72pt'></td>
  <td class=xl65 width=96 style='width:72pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl66 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl90 x:str><%=p_from.Substring(4,2) %>/<%=p_from.Substring(0,4) %></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=2 class=xl72 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=6 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=55 style='mso-height-source:userset;height:41.25pt'>
  <td height=55 class=xl84 style='height:41.25pt'>No.</td>
  <td class=xl85 width=0 style='border-left:none'>Code<br>
    <span style='mso-spacerun:yes'> </span>Emp.</td>
  <td class=xl86 style='border-left:none' x:str="Name"><span
  style='mso-spacerun:yes'> </span>Name<span style='mso-spacerun:yes'> </span></td>
  <td class=xl87 width=54 style='border-left:none;width:41pt' x:str="Dept"><span
  style='mso-spacerun:yes'> </span>Dept<span style='mso-spacerun:yes'> </span></td>
  <td class=xl86 style='border-left:none' x:str="Position"><span
  style='mso-spacerun:yes'> </span>Position<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl86 style='border-left:none' x:str="Date of join"><span
  style='mso-spacerun:yes'> </span>Date of join<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl87 width=77 style='border-left:none;width:58pt'
  x:str="Date&#10; of birth"><span style='mso-spacerun:yes'> </span>Date<br>
    <span style='mso-spacerun:yes'> </span>of birth<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl86 style='border-left:none' x:str="Age"><span
  style='mso-spacerun:yes'> </span>Age<span style='mso-spacerun:yes'> </span></td>
  <td class=xl86 style='border-left:none' x:str="Sex"><span
  style='mso-spacerun:yes'> </span>Sex<span style='mso-spacerun:yes'> </span></td>
  <td class=xl87 width=72 style='border-left:none;width:54pt'
  x:str="Marital Status"><span style='mso-spacerun:yes'> </span>Marital
  Status<span style='mso-spacerun:yes'> </span></td>
  <td class=xl87 width=145 style='border-left:none;width:109pt'
  x:str="Labour contract/Probation contract (From-to)"><span
  style='mso-spacerun:yes'> </span>Labour contract/Probation contract
  (From-to)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl75 width=113 style='border-left:none;width:85pt'
  x:str="Period of Labour contract"><span
  style='mso-spacerun:yes'> </span>Period of Labour contract<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl75 width=67 style='border-left:none;width:50pt'
  x:str="Renewal the LC"><span style='mso-spacerun:yes'> </span>Renewal the
  LC<span style='mso-spacerun:yes'> </span></td>
  <td class=xl75 width=67 style='border-left:none;width:50pt' x:str="Finish PC"><span
  style='mso-spacerun:yes'> </span>Finish PC<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl75 width=67 style='border-left:none;width:50pt'
  x:str="Salary review"><span style='mso-spacerun:yes'> </span>Salary
  review<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string str_format = "";
     
     int i = 0;
     for (i = 0; i < dt_emp.Rows.Count; i++)
     {
         if(i>0)
         {
             if(dt_emp.Rows[i]["c18"].ToString()!=dt_emp.Rows[i-1]["c18"].ToString())
                 str_format = "border-top:1.0pt solid windowtext;";
             else
                 str_format = "border-top:.5pt solid windowtext;";
         }
      %>
 <tr class=xl74 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl79 style='height:21.0pt;<%=str_format%>' x:num><%=i+1 %></td>
  <td class=xl79 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c00"].ToString() %></td>
  <td class=xl88 style='border-left:none;<%=str_format%>' x:str><%=dt_emp.Rows[i]["c01"].ToString() %></td>
  <td class=xl79 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c02"].ToString() %></td>
  <td class=xl80 style='border-left:none;<%=str_format%>'x:str><%=dt_emp.Rows[i]["c03"].ToString() %></td>
  <td class=xl77 style='border-left:none;<%=str_format%>' x:str><%=dt_emp.Rows[i]["c04"].ToString() %></td>
  <td class=xl77 style='border-left:none;<%=str_format%>' x:str><%=dt_emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl81 style='border-left:none;<%=str_format%>' x:num><%=dt_emp.Rows[i]["c06"].ToString() %></td>
  <td class=xl81 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c07"].ToString() %></td>
  <td class=xl81 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c08"].ToString() %></td>
  <td class=xl77 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c09"].ToString() %></td>
  <td class=xl82 style='border-left:none;<%=str_format%>' x:str><%=dt_emp.Rows[i]["c10"].ToString() %></td>
  <td class=xl83 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c12"].ToString() %></td>
  <td class=xl83 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c13"].ToString() %></td>
  <td class=xl83 style='border-left:none;<%=str_format%>'><%=dt_emp.Rows[i]["c14"].ToString() %></td>
  <td colspan=6 class=xl74 style='mso-ignore:colspan'></td>
 </tr>

 <%} %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl65 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=6 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <!--<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl78 style='height:17.25pt'>&nbsp;</td>
  <td class=xl65></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=6 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>-->
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>