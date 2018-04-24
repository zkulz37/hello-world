<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns="http://www.w3.org/TR/REC-html40" xmlns:o = 
"urn:schemas-microsoft-com:office:office" xmlns:x = 
"urn:schemas-microsoft-com:office:excel">
<%
  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
  string p_Company=Request["p_Company"]; 
  string p_from=Request["p_from"];
  string p_to=Request["p_to"];
  string p_Status=Request["p_Status"];
  string p_VCNo=Request["p_VCNo"];
  string p_Seq=Request["p_Seq"];
  string p_VCType=Request["p_VCType"];
  string p_TransPK=Request["p_TransPK"];
  string p_Desc=Request["p_Desc"];
  string p_amount=Request["p_amount"];
  string p_fromtext=Request["p_fromtext"];
  string p_tottext=Request["p_tottext"];
  string p_statustext=Request["p_statustext"];
  string p_datetype =Request["p_datetype"];
  
  string l_num="";
  string l_t_num="";
  
  string l_cmp_name = "";
  string l_cmp_add = "";
  string l_cmp_taxcode = "";
  
  ///---Get company information-------------------------------------------------------------------------------
        
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE,TCO_BPPHOTO_PK FROM TCO_COMPANY WHERE PK = '" + p_Company + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }
  
  string l_parameter = "'" + p_Company + "','" + p_from + "','" + p_to + "','" +  p_Status  + "','" + p_VCNo + "','" + p_Seq + "'";
         l_parameter = l_parameter + ",'" + p_VCType + "','" + p_TransPK + "','" + p_Desc + "','" +  p_amount  + "','" + p_datetype  + "'";
    
    //Response.Write(l_parameter);
    //Response.End();
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor("sp_sel_gfhg00080_2",l_parameter);
    
  
   /* if (dt_detail.Rows.Count==0)
    {
        Response.Write("There is no data");
        Response.End();
    }*/

  %>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00080_SLip%20Inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="gfhg00080_SLip%20Inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="gfhg00080_SLip%20Inquiry_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2009-08-08T02:26:23Z</o:LastPrinted>
  <o:Created>2008-12-03T03:21:02Z</o:Created>
  <o:LastSaved>2009-08-08T02:52:12Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl44
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl45
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Slip Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
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
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8820</x:WindowHeight>
  <x:WindowWidth>19080</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1680</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Slip Inquiry'!$A$5:$L$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:
 collapse;table-layout:fixed;width:881pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=183 span=2 style='mso-width-source:userset;mso-width-alt:
 6692;width:137pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 width=476 style='height:15.0pt;width:357pt'
  align=left valign=top>
  
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=20 class=xl39 width=476 style='height:15.0pt;
    width:357pt'><%=l_cmp_name %></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 rowspan=2 class=xl42 width=699 style='width:524pt'>SLIP INQUIRY</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl40 width=476 style='height:15.0pt;width:357pt'><%=l_cmp_add %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl39 style='height:15.0pt'>Mã số thuế:<%=l_cmp_taxcode %></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Trans Date : <font
  class="font6"><%=p_fromtext %> ~ <%=p_tottext %></font></td>
  <td class=xl24></td>
  <td colspan=3 class=xl41>Status : <font class="font6"><%=p_statustext %></font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl43 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$5:$T$5" style='height:27.75pt'>No</td>
  <td class=xl44 id="_x0000_s1026" x:autofilter="all">Seq</td>
  <td class=xl44 id="_x0000_s1027" x:autofilter="all">Voucher No</td>
  <td class=xl45 id="_x0000_s1028" x:autofilter="all" width=75
  style='width:56pt'>Trans<br>
    Date</td>
  <td class=xl45 id="_x0000_s1029" x:autofilter="all" width=75
  style='width:56pt'>Approval<br>
    Date</td>
  <td class=xl45 id="_x0000_s1030" x:autofilter="all" width=133
  style='width:100pt'>Trans Type</td>
  <td class=xl44 id="_x0000_s1031" x:autofilter="all">Amount</td>
  <td class=xl44 id="_x0000_s1032" x:autofilter="all">Description</td>
  <td class=xl44 id="_x0000_s1033" x:autofilter="all">Local Description</td>
  <td class=xl46 id="_x0000_s1035" x:autofilter="all">Enclose</td>
  <td class=xl46 id="_x0000_s1036" x:autofilter="all">Status</td>
  <td class=xl46 id="_x0000_s1037" x:autofilter="all">Prps By</td>
  <td class=xl46 id="_x0000_s1038" x:autofilter="all">Created date</td>
  <td class=xl46 id="_x0000_s1039" x:autofilter="all">Modified date</td>
  <td class=xl46 id="_x0000_s1040" x:autofilter="all">Modified by</td>
  <td class=xl46 id="_x0000_s1041" x:autofilter="all">Sign date</td>
  <td class=xl46 id="_x0000_s1042" x:autofilter="all">Sign by</td>
  <td class=xl46 id="_x0000_s1043" x:autofilter="all">Cancel date</td>
  <td class=xl46 id="_x0000_s1044" x:autofilter="all">Cancel by</td>
  <td class=xl46 id="_x0000_s1045" x:autofilter="all">Cancel cause</td>

 </tr>
 <%
    if (dt_detail.Rows.Count>0)
    {
        for(int j=0;j<dt_detail.Rows.Count;j++)
        {
  %>
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt' x:num><%=j+1 %></td>
  <td class=xl26 x:num><%=dt_detail.Rows[j]["pk"].ToString()%></td>
  <td class=xl27><%=dt_detail.Rows[j]["voucherno"].ToString()%></td>
  <td class=xl38 ><%=dt_detail.Rows[j]["trdate"].ToString()%></td>
  <td class=xl38 style='border-left:none' ><%=dt_detail.Rows[j]["app_date"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["TR_TPNM"].ToString()%></td>
  <td class=xl30 x:num><%=dt_detail.Rows[j]["amt"].ToString()%></td>
  <td class=xl31><%=dt_detail.Rows[j]["remark"].ToString()%></td>
  <td class=xl32 width=183 style='width:137pt'><%=dt_detail.Rows[j]["remark2"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["tr_enclose"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["status"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["crt_by"].ToString()%></td>
 <td class=xl29><%=dt_detail.Rows[j]["crt_dt"].ToString()%></td>

  <td class=xl29><%=dt_detail.Rows[j]["mod_dt"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["mod_by"].ToString()%></td>
   <td class=xl29><%=dt_detail.Rows[j]["sign_date"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["sign_memb"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["cancel_date"].ToString()%></td>
   <td class=xl29><%=dt_detail.Rows[j]["cancel_memb"].ToString()%></td>
  <td class=xl29><%=dt_detail.Rows[j]["cancel_cause"].ToString()%></td>
 
 </tr>
 <%
        }
      }  
  %>
 
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl35 style='height:15.0pt'>Ng&#432;&#7901;i ghi
  s&#7893;</td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl35>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl24></td>
  <td colspan=3 class=xl35>T&#7893;ng Giám &#273;&#7889;c</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl37 style='height:15.0pt'><span
  style='mso-spacerun:yes'> </span>( Ký, h&#7885; tên)</td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl37>( Ký, h&#7885; tên)</td>
  <td class=xl24></td>
  <td colspan=3 class=xl37>(Ký, h&#7885; tên, &#273;óng d&#7845;u)</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=183 style='width:137pt'></td>
  <td width=183 style='width:137pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
