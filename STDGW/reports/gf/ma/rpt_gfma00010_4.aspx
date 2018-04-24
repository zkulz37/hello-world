<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
    ESysLib.SetUser("acnt"); 
	//Response.Buffer = false;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
  string l_pk=Request["pk_req"]; 
  string l_num="";
  string l_t_num="";

  string l_col1_1 = "";
  string l_col1_2 = "";
  string l_col1_3 = "";

  string l_col2_1 = "";
  string l_col2_2 = "";
  string l_col2_3 = "";

  string l_col3_1 = "";
  string l_col3_2 = "";
  string l_col3_3 = "";

  string l_colK_1 = "";
  string l_colK_2 = "";
  string l_colK_3 = "";
  string l_colK_4 = "";

  string l_colV_1 = "";
  string l_colV_2 = "";
  string l_colV_3 = "";
  string l_colV_4 = "";

  string l_colE_1 = "";
  string l_colE_2 = "";
  string l_colE_3 = "";
  string l_colE_4 = "";

  string l_colS_1 = "";
  string l_colS_2 = "";
  string l_colS_3 = "";
  string l_colS_4 = "";

  string l_colN_1 = "";
  string l_colN_2 = "";
  string l_colN_3 = "";
  string l_colN_4 = "";
    
  string SQL_EACAB044 = "SELECT   char_1, char_2, char_3,char_4, code " +
        "    FROM tac_commcode_master a, tac_commcode_detail b " +
        "    WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB045' " +
        "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
        "    ORDER BY code, b.code_nm ";
 
  DataTable dt_EACAB044 = ESysLib.TableReadOpen(SQL_EACAB044);
  if (dt_EACAB044.Rows.Count > 0)
  {
      for (int j = 0; j < dt_EACAB044.Rows.Count; j++)
      {
          switch (dt_EACAB044.Rows[j][4].ToString())
          { 
              case "KOR":
                  l_colK_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colK_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colK_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colK_4 = dt_EACAB044.Rows[j][3].ToString(); 
              break;
              case "ENG":
                  l_colE_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colE_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colE_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colE_4 = dt_EACAB044.Rows[j][3].ToString(); 
              break;
             case "VIE":
                  l_colV_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colV_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colV_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colV_4 = dt_EACAB044.Rows[j][3].ToString();
              break;
             case "SIG":
                  l_colS_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colS_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colS_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colS_4 = dt_EACAB044.Rows[j][3].ToString();
              break;
              case "NAM":
                  l_colN_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colN_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colN_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colN_4 = dt_EACAB044.Rows[j][3].ToString();
              break;               
          }
      }
  }  
        
 
  string name1 = "";
  string name2 = "";
  string name3 = "";
  string SQL_NAME = "SELECT   char_1, char_2, char_3, code " +
          "    FROM tac_commcode_master a, tac_commcode_detail b " +
          "   WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB031' " +
          "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
          "         AND code='NAM' " +
          "ORDER BY code, b.code_nm ";

  DataTable dt_NAME = ESysLib.TableReadOpen(SQL_NAME);

  if (dt_NAME.Rows.Count > 0)
  {
      name1 = dt_NAME.Rows[0][0].ToString();
      name2 = dt_NAME.Rows[0][1].ToString();
      name3 = dt_NAME.Rows[0][2].ToString();

  }
         
    
    
  string SQL
	= "SELECT TO_CHAR(TO_DATE(a.voucher_date, 'yyyymmdd'), 'dd') v_dd " + 
        "     , TO_CHAR(TO_DATE(a.voucher_date, 'yyyymmdd'), 'mm') v_mm " +
        "     , TO_CHAR(TO_DATE(a.voucher_date, 'yyyymmdd'), 'yyyy') v_yy " +
        "     , b1.full_name app_nm, b.full_name, '' permanent_addr " +
        "     , DECODE(req_ccy " +
        "            , 'VND', TO_CHAR(a.tr_amt, '999,999,999,999') " +
        "                           , TO_CHAR(a.tr_amt,'9,999,999,999,990.99') ) tr_amt1 " +
        "     , a.l_description " +
        "     , TO_CHAR(TO_DATE(a.req_date, 'yyyymmdd'), 'dd-Mon-yyyy') req_date, a.req_ccy " +
        "     , c.partner_lname, d.org_nm, c.addr1 " +
        "     , TO_CHAR(TO_DATE(a.voucher_date, 'yyyymmdd'), 'dd-Mon-yyyy') vc_dt,a.tr_amt, c.TCO_BPPHOTO_PK  " +
        "  FROM acnt.tac_empadvreq a " +
        "     , tac_employee_adv b " +
        "     , tac_employee_adv b1 " +
        "     , comm.tco_company c " +
        "     , comm.tco_org d " +
        " WHERE a.del_if = 0 AND b.del_if(+) = 0 AND b1.del_if(+) = 0 AND c.del_if(+) = " +
        "                                                                             0 " +
        "       AND d.del_if(+) = 0 AND a.charger_pk = b.pk(+) AND a.charger_appr = b1.pk(+) " +
        "       AND a.tco_company_pk = c.pk(+) AND a.tco_org_pk = d.pk(+) " +
        "        and a.PK='" + l_pk + "' " ;

        


  //Response.Write(SQL);
 // Response.End();
  DataTable dt = ESysLib.TableReadOpen(SQL);
 
   
  %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_gfma00010_3_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_gfma00010_3_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_gfma00010_3_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AiLinh</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2009-08-20T03:16:55Z</o:LastPrinted>
  <o:Created>2009-08-05T06:33:22Z</o:Created>
  <o:LastSaved>2009-08-20T03:19:00Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
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
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
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
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>tam ung</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>82</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>23</x:Row>
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" u1:ext="edit"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=775 style='border-collapse:
 collapse;table-layout:fixed;width:582pt'>
 <col class=xl24 width=136 style='mso-width-source:userset;mso-width-alt:4973;
 width:102pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl24 width=147 style='mso-width-source:userset;mso-width-alt:5376;
 width:110pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 width=136 style='height:17.1pt;width:102pt' align=left
  valign=top><u3:shapetype id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f"><u3:stroke joinstyle="miter"/><u3:formulas><u3:f eqn="if lineDrawn pixelLineWidth 0"/><u3:f eqn="sum @0 1 0"/><u3:f eqn="sum 0 0 @1"/><u3:f eqn="prod @2 1 2"/><u3:f eqn="prod @3 21600 pixelWidth"/><u3:f eqn="prod @3 21600 pixelHeight"/><u3:f eqn="sum @0 0 1"/><u3:f eqn="prod @6 1 2"/><u3:f eqn="prod @7 21600 pixelWidth"/><u3:f eqn="sum @8 21600 0"/><u3:f eqn="prod @7 21600 pixelHeight"/><u3:f eqn="sum @10 21600 0"/></u3:formulas><u3:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/><o:lock u3:ext="edit" aspectratio="t"/></u3:shapetype><u3:shape id="_x0000_s1025" type="#_x0000_t75" alt="" style="position:absolute;&#13;&#10;   margin-left:0;margin-top:0;width:45.75pt;height:32.25pt;z-index:1"><u3:imagedata src="http://192.168.52.253/esys/system/binary/ViewFile.aspx?img_pk=1&amp;table_name=tco_bpphoto"/><x:ClientData ObjectType="Pict"><x:SizeWithCells/></x:ClientData></u3:shape><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" alt="" style='position:absolute;
   margin-left:0;margin-top:0;width:45.75pt;height:32.25pt;z-index:1'>
   <v:imagedata src="../../../system/binary/ViewFile.aspx%3fimg_pk=%3c%25=dt.Rows%5b0%5d%5b"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:61px;
  height:43px'><img width=61 height=43
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["TCO_BPPHOTO_PK"].ToString()%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl25 width=136 style='height:17.1pt;width:102pt'
    x:str="                 "><span
    style='mso-spacerun:yes'>                 </span></td>
   </tr>
  </table>
  </span></td>
  <%=dt.Rows[0][10].ToString() %>
  <td class=xl24 width=142 style='width:107pt'></td>
  <td class=xl24 width=144 style='width:108pt'></td>
  <td class=xl24 width=147 style='width:110pt'></td>
  <td class=xl24 width=142 style='width:107pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt' x:str="               "><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[0]["ADDR1"].ToString() %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'>Ngày(Date):………………………………</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl35 style='height:12.75pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=4 height=22 class=xl36 style='height:17.1pt'>GIẤY ĐỀ NGHỊ THANH
  TOÁN</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=4 height=22 class=xl37 style='height:17.1pt'>(REQUEST FOR
  PAYMENT)</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=4 height=22 class=xl38 style='height:17.1pt'>Ngày <font
  class="font9">()</font><%=dt.Rows[0]["vc_dt"].ToString() %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'>Họ Tên <font class="font9">(Full
  Name)</font><font class="font6">:<span style='mso-spacerun:yes'> </span></font><%=dt.Rows[0]["FULL_NAME"].ToString() %></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>………………………………………………………………………<span
  style='display:none'>……………………..</span></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>……………………………..</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'>Bộ phận<font class="font9">
  (Section)</font><font class="font6">:<span style='mso-spacerun:yes'> </span></font><%=dt.Rows[0]["org_NM"].ToString() %></td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'>……………………………………………………………………………………………..</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 colspan=5 style='height:17.1pt;mso-ignore:colspan'>Đề
  nghị thanh toán cho số tiền <font class="font9">(Request for payment)</font><font
  class="font6"> :…………………………………………………………….<span
  style='mso-spacerun:yes'> </span></font><%=dt.Rows[0]["tr_amt1"].ToString() %></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'>Bằng chữ <font class="font9">(By
  words):</font><span style='display:none'><font class="font9">
  ……………………………………………………………………………………….</font></span><%
        l_num=CommondLib.Num2VNText(dt.Rows[0]["tr_amt"].ToString(),dt.Rows[0]["req_ccy"].ToString());
       %><%=l_num%></td>
  <td class=xl25 colspan=5 style='mso-ignore:colspan'>………………………………………………………………………………………………</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 colspan=4 style='height:17.1pt;mso-ignore:colspan'>Lý
  do (<font class="font9">Reasons): …………………………………………………………………………</font><span
  style='display:none'><font class="font9">………</font></span><%=dt.Rows[0]["l_description"].ToString() %></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>……………………………..</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'>……………………..</td>
  <td class=xl25 colspan=5 style='mso-ignore:colspan'>………………………………………………………………………………………………</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 colspan=2 style='height:17.1pt;mso-ignore:colspan'>Chứng
  từ đính kèm<font class="font9"> (attacted invoice):</font><%=dt.Rows[0]["req_date"].ToString() %></td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'>………………………………………………………………………</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=4 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl26 style='height:17.1pt'><%=l_colK_1%>Người đề nghị</td>
  <td class=xl27><%=l_colK_2%>&nbsp;</td>
  <td class=xl27><%=l_colK_3%>&nbsp;</td>
  <td class=xl27><%=l_colK_4%>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'><%=l_colV_1%>&nbsp;</td>
  <td class=xl30><%=l_colV_2%>&nbsp;</td>
  <td class=xl30><%=l_colV_3%>&nbsp;</td>
  <td class=xl30><%=l_colV_4%>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'><%=l_colE_1%>&nbsp;</td>
  <td class=xl30><%=l_colE_2%>&nbsp;</td>
  <td class=xl30><%=l_colE_3%>&nbsp;</td>
  <td class=xl30><%=l_colE_4%>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl32 style='height:17.1pt'><%=l_colS_1%>&nbsp;</td>
  <td class=xl33><%=l_colS_2%>&nbsp;</td>
  <td class=xl33><%=l_colS_3%>&nbsp;</td>
  <td class=xl33><%=l_colS_4%>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl32 style='height:17.1pt'><%=l_colN_1%>&nbsp;</td>
  <td class=xl33><%=l_colN_2%>&nbsp;</td>
  <td class=xl33><%=l_colN_3%>&nbsp;</td>
  <td class=xl33><%=l_colN_4%>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=136 style='width:102pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=147 style='width:110pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
