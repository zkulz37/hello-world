<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string dtForm=Request["dtform"];
    string dtTo= Request["dtto"];
    string dtToday = Request["dttoday"];
    string sql = "select to_char(to_date(" + dtForm + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtTo + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtToday + ",'yyyymmdd'),'yyyy.mm.dd') from dual";
    DataTable dt = ESysLib.TableReadOpen(sql);
    string a = dt.Rows[0][0].ToString();
    string b = dt.Rows[0][1].ToString();
    string c = dt.Rows[0][2].ToString();
    DataTable dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00120", "'" + dtForm + "','" + dtTo + "'");
    DataTable dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00120_1", "'" + dtForm + "','" + dtTo + "'");
    DataTable dt3 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00120_2", "'" + dtForm + "','" + dtTo + "'");
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Additive%20Solution%20Register_files/filelist.xml">
<link rel=Edit-Time-Data
href="Additive%20Solution%20Register_files/editdata.mso">
<link rel=OLE-Object-Data
href="Additive%20Solution%20Register_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Trung</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-03-30T02:46:58Z</o:LastPrinted>
  <o:Created>2010-03-30T02:19:16Z</o:Created>
  <o:LastSaved>2010-03-30T08:32:56Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.67in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font9
	{color:windowtext;
	font-size:12.0pt;
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>66</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
       <x:RangeSelection>$M$6:$N$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$N$55</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1018 style='border-collapse:
 collapse;table-layout:fixed;width:766pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=64 style='width:48pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=64 style='width:48pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=64 style='width:48pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=14 height=30 class=xl41 width=954 style='height:22.5pt;
  width:718pt'>Additive<span style='mso-spacerun:yes'>  </span>Solution Batch
  No. Register</td>
  <td class=xl27 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=9 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl39>Date<font class="font9"><span
  style='mso-spacerun:yes'>  </span>:<span style='mso-spacerun:yes'> 
  </span><%=c %></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=4 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl26>Period:</td>
  <td colspan=3 class=xl25><%=a %><span style='mso-spacerun:yes'>  
  </span>-<span style='mso-spacerun:yes'>   </span><%=b %></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=2 class=xl39>Page<font class="font9"> :<span
  style='mso-spacerun:yes'>  </span>1<span style='mso-spacerun:yes'>     
  </span>/<span style='mso-spacerun:yes'>  </span>1</font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl32 style='height:21.75pt'>Issued Date</td>
  <td colspan=2 class=xl32>Entered Date</td>
  <td colspan=2 class=xl32>Batch No.</td>
  <td colspan=2 class=xl32>Tr. /Op</td>
  <td colspan=2 class=xl32>Batch Q'ty</td>
  <td colspan=2 class=xl32>Total Inst Q'ty</td>
  <td colspan=2 class=xl32>Remarks</td>
  <td></td>
 </tr>
   <%
      string issuedate = "";
      string enterdate = "";
      Double inst_tot1 = 0;
      Double  inst_tot2 = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         inst_tot1 = inst_tot1 + CommondLib.ConvertToDbl(dt1.Rows[i][5].ToString());
         inst_tot2 = inst_tot1;
         if (issuedate != dt1.Rows[i][1].ToString() || enterdate != dt1.Rows[i][2].ToString())
         {
           %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl37 style='height:21.75pt'><%=dt1.Rows[i][1]%></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][2]%></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][3]%></td>
  <td colspan=2 class=xl38><%=dt1.Rows[i][4]%></td>
  <td colspan=2 class=xl33 x:num><%=dt1.Rows[i][5]%></td>
  <td colspan=2 class=xl33 x:num><%=inst_tot2%></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][7]%></td>
  <td></td>
 </tr>
           <%
      }
      else
      { 
             %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl37 style='height:21.75pt'></td>
  <td colspan=2 class=xl37></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][3]%></td>
  <td colspan=2 class=xl38><%=dt1.Rows[i][4]%></td>
  <td colspan=2 class=xl33 x:num><%=dt1.Rows[i][5]%></td>
  <td colspan=2 class=xl33 x:num><%=inst_tot2%></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][7]%></td>
  <td></td>
 </tr>
                       <%
         }
         issuedate = dt1.Rows[i][1].ToString();
         enterdate = dt1.Rows[i][2].ToString();
     }
  %>
  <%
      for (int j = 0; j < dt2.Rows.Count; j++)
      {
          if (j == 0)
          {
               
          
            %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl43 style='height:21.75pt'>&nbsp;</td>
  <td colspan=2 class=xl43>&nbsp;</td>
  <td colspan=2 class=xl43>&nbsp;</td>
  <td colspan=2 class=xl45><%=dt2.Rows[j][0] %></td>
  <td colspan=2 class=xl36 x:num><%=dt2.Rows[j][1] %></td>
  <td colspan=2 class=xl36 x:num><%=dt2.Rows[j][2] %></td>
  <td colspan=2 class=xl43>&nbsp;</td>
  <td></td>
 </tr>
            <% 
                }
              else
              {
                  %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=2 height=29 class=xl59 style='height:21.75pt'></td>
  <td colspan=2 class=xl59></td>
  <td colspan=2 class=xl59></td>
  <td colspan=2 class=xl60><%=dt2.Rows[j][0] %></td>
  <td colspan=2 class=xl58 x:num><%=dt2.Rows[j][1] %></td>
  <td colspan=2 class=xl58 x:num><%=dt2.Rows[j][2] %></td>
  <td colspan=2 class=xl59></td>
  <td></td>
 </tr>
                  <%
              }
        
      }
   %>
      <%
       for (int k = 0; k < dt3.Rows.Count; k++)
       {
            %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl28 style='height:20.25pt'>&nbsp;</td>
  <td colspan=2 class=xl28>&nbsp;</td>
  <td colspan=2 class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30>Total</td>
  <td colspan=2 class=xl34 x:num><%=dt3.Rows[k][0] %></td>
  <td colspan=2 class=xl34 x:num><%=dt3.Rows[k][1] %></td>
  <td colspan=2 class=xl28>&nbsp;</td>
  <td></td>
 </tr>
             <% 
       }
        %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
