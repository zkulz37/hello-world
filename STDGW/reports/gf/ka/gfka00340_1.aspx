<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_kind = Request["kind"];
    string p_status = Request["status"];
    string p_tco_company_pk = Request["tco_company_pk"];
    string p_date_fr = Request["date_fr"];
	string p_date_to = Request["date_to"];
	
    string p_user = Request["user"];
    string p_Acc_pk = Request["Acc_pk"];
    

    string l_parameter = "'" + p_kind + "', ";
    l_parameter += "'" + p_status + "', ";
    l_parameter += "'" + p_tco_company_pk + "', ";
    l_parameter += "'" + p_date_fr + "', ";
	l_parameter += "'" + p_date_to + "', ";
    l_parameter += "'" + p_user + "', ";
    l_parameter += "'" + p_Acc_pk + "' ";

    string p_company_name = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_tco_company_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    p_company_name = dt2.Rows[0][0].ToString();
    p_tax_code = dt2.Rows[0][1].ToString();
    p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00340_1", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }
    p_date_fr = p_date_fr.Substring(4, 2) + "/" + p_date_fr.Substring(0, 4);
	p_date_to = p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);
     
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
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
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-10-20T01:42:11Z</o:LastPrinted>
  <o:Created>2010-10-19T09:50:51Z</o:Created>
  <o:LastSaved>2010-10-22T06:43:42Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:&L&T;
	mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Operating cost 1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Operating cost 1'!$A$5:$J$5</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Operating cost 1'!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1112 style='border-collapse:
 collapse;table-layout:fixed;width:836pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl24 width=267 style='mso-width-source:userset;mso-width-alt:9764;
 width:200pt'>
 <col class=xl25 width=89 span=8 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl35 width=400 style='height:15.75pt;
  width:300pt'><%=p_company_name%></td>
  <td colspan=8 rowspan=2 class=xl41 width=712 style='width:536pt'
  x:str="OPERATING COST REPORT"><span
  style='mso-spacerun:yes'> </span>OPERATING COST REPORT<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl35 style='height:15.75pt'><%=p_cmp_add%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl35 style='height:15.75pt'>Mã số thuế: <%=p_tax_code%></td>
  <td colspan=8 class=xl42 ><span
  style='mso-spacerun:yes'> </span>From : <%=p_date_fr%> ~   <%=p_date_to%> <span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl26 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$5:$J$5" style='height:15.75pt'>Account Code</td>
  <td class=xl27 id="_x0000_s1026" x:autofilter="all" style='border-left:none'>Account
  Name</td>
  <td class=xl28 id="_x0000_s1027" x:autofilter="all" style='border-left:none'
  x:str="AP"><span style='mso-spacerun:yes'> </span>AP<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1028" x:autofilter="all" style='border-left:none'
  x:str="OF"><span style='mso-spacerun:yes'> </span>OF<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1029" x:autofilter="all" style='border-left:none'
  x:str="GY"><span style='mso-spacerun:yes'> </span>GY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1030" x:autofilter="all" style='border-left:none'
  x:str="RC"><span style='mso-spacerun:yes'> </span>RC<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1031" x:autofilter="all" style='border-left:none'
  x:str="OT"><span style='mso-spacerun:yes'> </span>OT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1032" x:autofilter="all" style='border-left:none'
  x:str="C1"><span style='mso-spacerun:yes'> </span>C1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1033" x:autofilter="all" style='border-left:none'
  x:str="C2"><span style='mso-spacerun:yes'> </span>C2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 id="_x0000_s1034" x:autofilter="all" style='border-left:none'
  x:str="Total"><span style='mso-spacerun:yes'> </span>Total<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
<%
    string tag_bold = "";
    string tag_endbold = "";
    string _class = "";
    int i;
    for (i = 0; i < dt.Rows.Count; i++) 
    { 
            tag_bold = "";
            tag_endbold = "";
            _class = "";
            if (dt.Rows[i][17].ToString() == "B")
            {

                _class = "background:#" + dt.Rows[i][18].ToString().Substring(6, 2) + dt.Rows[i][18].ToString().Substring(4, 2) + dt.Rows[i][18].ToString().Substring(2, 2)+ ";mso-pattern:auto none;";
               
                //Response.Write(_class);
                //Response.End();
                tag_bold = "<b>";
                tag_endbold = "</b>";
            }
  
 %> 
 <tr class=xl35 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt;<%=_class %>' ><%=tag_bold%><%=dt.Rows[i][0]%><%=tag_endbold%></td>
  <td class=xl32 style='border-left:none;<%=_class %>'><%=tag_bold%><%=dt.Rows[i][1]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num ><%=tag_bold%><%=dt.Rows[i][2]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num ><%=tag_bold%><%=dt.Rows[i][3]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num ><%=tag_bold%><%=dt.Rows[i][4]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num><%=tag_bold%><%=dt.Rows[i][5]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num><%=tag_bold%><%=dt.Rows[i][6]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num><%=tag_bold%><%=dt.Rows[i][7]%><%=tag_endbold%></td>
  <td class=xl33 style='border-left:none;<%=_class %>' x:num><%=tag_bold%><%=dt.Rows[i][8]%><%=tag_endbold%></td>
  <td class=xl34 style='border-left:none;<%=_class %>' x:num><%=tag_bold%><%=dt.Rows[i][9]%><%=tag_endbold%></td>
 </tr>
<%
} %> 

 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt' x:num></td>
  <td class=xl37 style='border-left:none'></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl38 style='border-left:none' x:num></td>
  <td class=xl39 style='border-left:none' x:num></td>
 </tr>

 
 <![if supportMisalignedColumns]>
 
 <![endif]>
</table>

</body>

</html>
