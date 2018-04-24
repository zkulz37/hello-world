<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<script type="text/Javascript" language ="javascript" >

function alert_meth()

{

alert("Client Side MessageBox");

}

</script>
<%
    string p_factory_pk = Request.QueryString["p_factory_pk"];
	string p_from_date	= Request.QueryString["p_from_date"];

    string para = "'" + p_factory_pk + "','" + p_from_date + "'";

    DateTime date = Convert.ToDateTime(System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("MM/dd/yyyy"));

	DataTable dt1;
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpip00030", para);  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpip00040_files/filelist.xml">
<link rel=Edit-Time-Data href="fpip00040_files/editdata.mso">
<link rel=OLE-Object-Data href="fpip00040_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-03-15T09:11:53Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-03-15T09:27:22Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	color:navy;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:navy;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=10018 style='border-collapse:
 collapse;table-layout:fixed;width:760pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:2026;width:29pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:4304;width:47pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:6013;width:50pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:4504;width:41pt'>
 <col width=47 span=15 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=20 height=35 class=xl29 width=1018 style='height:26.25pt;
  width:760pt'>LINE PLAN ENTRY</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=20 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl25 style='height:16.5pt'>R/G</td>
  <td class=xl26>PO</td>
  <td class=xl26>Image</td>
  <td class=xl26>Style</td>
  <td class=xl26>Spec</td>
  <td class=xl30 x:str><%= date.AddDays(0).ToString("dd-MMM") %></td>
  <td class=xl27 x:str><%= date.AddDays(1).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27 x:str><span style='mso-spacerun:yes'></span><%= date.AddDays(2).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27><%= date.AddDays(3).ToString("dd-MMM") %></td>
  <td class=xl27 x:str><%= date.AddDays(4).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27 x:str><%= date.AddDays(5).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27 x:str><span style='mso-spacerun:yes'></span><%= date.AddDays(6).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27 x:str><%= date.AddDays(7).ToString("dd-MMM") %><span style='mso-spacerun:yes'></span></td>
  <td class=xl27><%= date.AddDays(8).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(9).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(10).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(11).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(12).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(13).ToString("dd-MMM") %></td>
  <td class=xl27><%= date.AddDays(14).ToString("dd-MMM") %></td>
 </tr>
 <%
	//======================
        string strRG = string.Empty;
        int[] arrRG_count = new int[dt1.Rows.Count];
        int strRG_count = 1;
        int a = 0;
        for (int y = 0; y < dt1.Rows.Count; y++)
        {
            if (strRG == "" || strRG == null)
            {
                strRG = dt1.Rows[y]["line_id"].ToString().Trim();
                strRG_count = 1;
            }
            else
            {
                if (dt1.Rows[y]["line_id"].ToString().Trim() != strRG.Trim())
                {
                    arrRG_count[a] = strRG_count;
                    strRG_count = 1;
                    a++;
                    strRG = dt1.Rows[y]["line_id"].ToString().Trim();
                }
                else
                {
                    strRG_count++;
                }
            }
        }
        //------------------------ 
        arrRG_count[a] = strRG_count;
        a = 0;
        strRG = string.Empty;

		//---------------------------
	for( int i = 0; i < dt1.Rows.Count; i++)
	{
	
 %>
 <tr class=xl28 height=65 style='mso-height-source:userset;height:48.75pt'>
             <%  if (strRG != dt1.Rows[i]["line_id"].ToString())
                {
            %> 
  <td rowspan="<%= arrRG_count[a] %>" height=65 class=<% if(i % 2 == 0)
				{ %>
				xl31
			 <%	}
				else
				{ %>
					xl37
				<% } %> style='height:48.75pt' x:num><%=dt1.Rows[i]["line_id"]%></td>
                <%                         
                    strRG = dt1.Rows[i]["line_id"].ToString();
                    a++;
                }
            %> 
  <td class=<% if(i % 2 == 0)
				{ %>
				xl32
			 <%	}
				else
				{ %>
					xl35
				<% } %> width=63 style='width:47pt'><%=dt1.Rows[i]["ref_po_no"]%></td>
  <td height=65 class=xl33 width=91 style='height:48.75pt;width:68pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:.75pt;margin-top:.75pt;width:67.5pt;height:47.25pt;z-index:1'>
   <v:imagedata src="fpip00040_files/image001.jpg" o:title="Graphic1"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=1 height=1 class=xl32></td>
   </tr>
   <tr>
    <td></td>
    <td>
	<img width=84 height=60 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[i]["tco_stitemphoto_pk"]%>&table_name=tco_stitem"  v:shapes="_x0000_s1025">
	</td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:68.25pt;height:48.75pt'></span><![endif]--></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl32
			 <%	}
				else
				{ %>
					xl35
				<% } %> width=66 style='width:50pt'><%=dt1.Rows[i]["style"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl32
			 <%	}
				else
				{ %>
					xl35
				<% } %> width=54 style='width:41pt'><%=dt1.Rows[i]["spec"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day01_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day02_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day03_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day04_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day05_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day06_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day07_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day08_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day09_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day10_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day11_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day12_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day13_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day14_qty"]%></td>
  <td class=<% if(i % 2 == 0)
				{ %>
				xl34
			 <%	}
				else
				{ %>
					xl36
				<% } %> align=right x:num><%=dt1.Rows[i]["day15_qty"]%></td>
 </tr>
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
