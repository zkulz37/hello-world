<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";	
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string l_wi_pk = "";
        
    DataTable dt ;
    
    l_wi_pk = Request["wi_pk"];
    
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00122", l_wi_pk);
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpcw00122_files/filelist.xml">
<link rel=Edit-Time-Data href="fpcw00122_files/editdata.mso">
<link rel=OLE-Object-Data href="fpcw00122_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2009-09-05T09:43:59Z</o:LastPrinted>
  <o:Created>2009-09-05T09:17:57Z</o:Created>
  <o:LastSaved>2009-09-05T09:44:46Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .26in .24in .25in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;
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
.xl24
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=936 style='border-collapse:
 collapse;table-layout:fixed;width:699pt'>
 <col class=xl24 width=75 span=6 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl24 width=75 span=6 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <%
    int i ;
    DataTable dt2;
     
    String p1_cutdate = "", p1_ref_po_no = "", p1_style_name = "", p1_school = "", p1_part_name = "", p1_lot_no = "", p1_color = "", p1_size = "", p1_cut_card_qty = "", p1_cut_card_id = "";
    String p2_cutdate = "", p2_ref_po_no = "", p2_style_name = "", p2_school = "", p2_part_name = "", p2_lot_no = "", p2_color = "", p2_size = "", p2_cut_card_qty = "", p2_cut_card_id = "";
    String p3_cutdate = "", p3_ref_po_no = "", p3_style_name = "", p3_school = "", p3_part_name = "", p3_lot_no = "", p3_color = "", p3_size = "", p3_cut_card_qty = "", p3_cut_card_id = "";
    String p4_cutdate = "", p4_ref_po_no = "", p4_style_name = "", p4_school = "", p4_part_name = "", p4_lot_no = "", p4_color = "", p4_size = "", p4_cut_card_qty = "", p4_cut_card_id = "";

    string p1_process01 = "", p1_process02 = "", p1_process03 = "";
    string p2_process01 = "", p2_process02 = "", p2_process03 = "";
    string p3_process01 = "", p3_process02 = "", p3_process03 = "";
    string p4_process01 = "", p4_process02 = "", p4_process03 = ""; 
     
    for (i = 0; i < dt.Rows.Count; i=i+4)
    {
        if (i < dt.Rows.Count)
        {
            p1_cutdate = dt.Rows[i]["cut_date"].ToString();
            p1_ref_po_no = dt.Rows[i]["ref_po_no"].ToString();
            p1_style_name = dt.Rows[i]["style_name"].ToString();
            p1_school = dt.Rows[i]["school_name"].ToString();
            p1_part_name = dt.Rows[i]["part_name"].ToString();
            p1_lot_no = dt.Rows[i]["lot_id"].ToString();
            p1_color = dt.Rows[i]["prod_color"].ToString();
            p1_size = dt.Rows[i]["size_spec"].ToString();
            p1_cut_card_qty = dt.Rows[i]["cut_card_qty"].ToString();
            p1_cut_card_id = dt.Rows[i]["CUT_CARD_ID"].ToString();

            dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00122_1", dt.Rows[i]["card_pk"].ToString());
            int j=0;
            if (j < dt2.Rows.Count)
            {
                p1_process01 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p1_process02 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p1_process03 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
        }
        if (i+1 < dt.Rows.Count)
        {
            p2_cutdate = dt.Rows[i+1]["cut_date"].ToString();
            p2_ref_po_no = dt.Rows[i + 1]["ref_po_no"].ToString();
            p2_style_name = dt.Rows[i + 1]["style_name"].ToString();
            p2_school = dt.Rows[i + 1]["school_name"].ToString();
            p2_part_name = dt.Rows[i + 1]["part_name"].ToString();
            p2_lot_no = dt.Rows[i + 1]["lot_id"].ToString();
            p2_color = dt.Rows[i + 1]["prod_color"].ToString();
            p2_size = dt.Rows[i + 1]["size_spec"].ToString();
            p2_cut_card_qty = dt.Rows[i + 1]["cut_card_qty"].ToString();
            p2_cut_card_id = dt.Rows[i + 1]["CUT_CARD_ID"].ToString();
            
            dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00122_1", dt.Rows[i]["card_pk"].ToString());
            int j = 0;
            if (j < dt2.Rows.Count)
            {
                p2_process01 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p2_process02 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p2_process03 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
        }
        if (i + 2 < dt.Rows.Count)
        {
            p3_cutdate = dt.Rows[i + 2]["cut_date"].ToString();
            p3_ref_po_no = dt.Rows[i + 2]["ref_po_no"].ToString();
            p3_style_name = dt.Rows[i + 2]["style_name"].ToString();
            p3_school = dt.Rows[i + 2]["school_name"].ToString();
            p3_part_name = dt.Rows[i + 2]["part_name"].ToString();
            p3_lot_no = dt.Rows[i + 2]["lot_id"].ToString();
            p3_color = dt.Rows[i + 2]["prod_color"].ToString();
            p3_size = dt.Rows[i + 2]["size_spec"].ToString();
            p3_cut_card_qty = dt.Rows[i + 2]["cut_card_qty"].ToString();
            p3_cut_card_id = dt.Rows[i + 2]["CUT_CARD_ID"].ToString();
            
            dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00122_1", dt.Rows[i]["card_pk"].ToString());
            int j = 0;
            if (j < dt2.Rows.Count)
            {
                p3_process01 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p3_process02 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p3_process03 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
        }
        if (i + 3 < dt.Rows.Count)
        {
            p4_cutdate = dt.Rows[i + 3]["cut_date"].ToString();
            p4_ref_po_no = dt.Rows[i + 3]["ref_po_no"].ToString();
            p4_style_name = dt.Rows[i + 3]["style_name"].ToString();
            p4_school = dt.Rows[i + 3]["school_name"].ToString();
            p4_part_name = dt.Rows[i + 3]["part_name"].ToString();
            p4_lot_no = dt.Rows[i + 3]["lot_id"].ToString();
            p4_color = dt.Rows[i + 3]["prod_color"].ToString();
            p4_size = dt.Rows[i + 3]["size_spec"].ToString();
            p4_cut_card_qty = dt.Rows[i + 3]["cut_card_qty"].ToString();
            p4_cut_card_id = dt.Rows[i + 3]["CUT_CARD_ID"].ToString();
            
            dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpcw00122_1", dt.Rows[i]["card_pk"].ToString());
            int j = 0;
            if (j < dt2.Rows.Count)
            {
                p4_process01 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p4_process02 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
            if (j < dt2.Rows.Count)
            {
                p4_process03 = dt2.Rows[j]["process_name"].ToString();
                j++;
            }
        }               
 %>     
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl32 width=450 style='border-right:1.0pt solid black;
  height:15.0pt;width:336pt'>CUTTING CARD</td>
  <td rowspan=12 class=xl36 width=36 style='width:27pt'>&nbsp;</td>
  <td colspan=6 class=xl32 width=450 style='border-right:1.0pt solid black;
  width:336pt'>CUTTING CARD</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>CUT DATE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p1_cutdate %></td>
  <td class=xl25 style='border-top:none;border-left:none'>PO #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p1_ref_po_no %></td>
  <td class=xl35 style='border-top:none'>CUT DATE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p2_cutdate%></td>
  <td class=xl25 style='border-top:none;border-left:none'>PO #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p2_ref_po_no%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>STYLE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p1_style_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>DESIGN</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p1_school %></td>
  <td class=xl35 style='border-top:none'>STYLE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p2_style_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>DESIGN</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p2_school%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>PART</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p1_part_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>LOT #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p1_lot_no %></td>
  <td class=xl35 style='border-top:none'>PART</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p2_part_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>LOT #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p2_lot_no%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>COLOR</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p1_color%></td>
  <td class=xl25 style='border-top:none;border-left:none'>SIZE</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p1_size%></td>
  <td class=xl35 style='border-top:none'>COLOR</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p2_color%></td>
  <td class=xl25 style='border-top:none;border-left:none'>SIZE</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p2_size%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>CARD QTY</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p1_cut_card_qty%></td>
  <td class=xl25 style='border-top:none;border-left:none'>CUT DEFECT</td>
  <td colspan=2 class=xl27 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>CARD QTY</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p2_cut_card_qty%></td>
  <td class=xl25 style='border-top:none;border-left:none'>CUT DEFECT</td>
  <td colspan=2 class=xl27 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 height=40 class=xl29 style='border-right:1.0pt solid black;
  height:30.0pt'>*<%= p1_cut_card_id%>*</td>
  <td colspan=6 class=xl29 style='border-right:1.0pt solid black'>*<%= p2_cut_card_id%>*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl40 style='border-right:1.0pt solid black;
  height:15.0pt'><%= p1_cut_card_id%></td>
  <td colspan=6 class=xl40 style='border-right:1.0pt solid black'><%= p2_cut_card_id%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl42 style='height:15.0pt'>PROCESS</td>
  <td class=xl27 style='border-left:none'>INPUT</td>
  <td class=xl27 style='border-left:none'>DEFECT</td>
  <td class=xl39 style='border-left:none'>RESULT</td>
  <td colspan=3 class=xl42>PROCESS</td>
  <td class=xl27 style='border-left:none'>INPUT</td>
  <td class=xl27 style='border-left:none'>DEFECT</td>
  <td class=xl39 style='border-left:none'>RESULT</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'><%=p1_process01 %></td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black'><%=p2_process01 %></td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'><%=p1_process02 %></td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black'><%=p2_process02 %></td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl48 style='border-right:.5pt solid black;
  height:15.0pt'><%=p1_process03 %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl48 style='border-right:.5pt solid black'><%=p2_process03 %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td colspan=13 height=5 class=xl53 style='height:3.75pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>&nbsp;</td>
  <td class=xl27 style='border-left:none'>Cutting</td>
  <td class=xl27 style='border-left:none'>Print</td>
  <td class=xl27 style='border-left:none'>Emb</td>
  <td class=xl27 style='border-left:none'>Sew</td>
  <td class=xl27 style='border-left:none'>Manager</td>
  <td rowspan=5 class=xl54>&nbsp;</td>
  <td class=xl27 style='border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-left:none'>Cutting</td>
  <td class=xl27 style='border-left:none'>Print</td>
  <td class=xl27 style='border-left:none'>Emb</td>
  <td class=xl27 style='border-left:none'>Sew</td>
  <td class=xl27 style='border-left:none'>Manager</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Line</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Line</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt;border-top:none'>Charger</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Charger</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Sign</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Sign</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Date</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Date</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=13 height=20 class=xl53 style='height:15.0pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl32 style='border-right:1.0pt solid black;
  height:15.0pt'>CUTTING CARD</td>
  <td rowspan=12 class=xl38></td>
  <td colspan=6 class=xl32 style='border-right:1.0pt solid black'>CUTTING CARD</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>CUT DATE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p3_cutdate%></td>
  <td class=xl25 style='border-top:none;border-left:none'>PO #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p3_ref_po_no%></td>
  <td class=xl35 style='border-top:none'>CUT DATE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p4_cutdate%></td>
  <td class=xl25 style='border-top:none;border-left:none'>PO #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p4_ref_po_no%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>STYLE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p3_style_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>DESIGN</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p3_school%></td>
  <td class=xl35 style='border-top:none'>STYLE</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p4_style_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>DESIGN</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p4_school%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>PART</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p3_part_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>LOT #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p3_lot_no%></td>
  <td class=xl35 style='border-top:none'>PART</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p4_part_name%></td>
  <td class=xl25 style='border-top:none;border-left:none'>LOT #</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p4_lot_no%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>COLOR</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p3_color%></td>
  <td class=xl25 style='border-top:none;border-left:none'>SIZE</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p3_size%></td>
  <td class=xl35 style='border-top:none'>COLOR</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p4_color%></td>
  <td class=xl25 style='border-top:none;border-left:none'>SIZE</td>
  <td colspan=2 class=xl26 style='border-right:1.0pt solid black;border-left:
  none'><%= p4_size%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt;border-top:none'>CARD QTY</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p3_cut_card_qty%></td>
  <td class=xl25 style='border-top:none;border-left:none'>CUT DEFECT</td>
  <td colspan=2 class=xl27 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>CARD QTY</td>
  <td colspan=2 class=xl26 style='border-left:none'><%= p4_cut_card_qty%></td>
  <td class=xl25 style='border-top:none;border-left:none'>CUT DEFECT</td>
  <td colspan=2 class=xl27 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 height=40 class=xl29 style='border-right:1.0pt solid black;
  height:30.0pt'>*<%= p3_cut_card_id %>*</td>
  <td colspan=6 class=xl29 style='border-right:1.0pt solid black'>*<%= p4_cut_card_id%>*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl40 style='border-right:1.0pt solid black;
  height:15.0pt'><%= p3_cut_card_id %></td>
  <td colspan=6 class=xl40 style='border-right:1.0pt solid black'><%= p4_cut_card_id %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl42 style='height:15.0pt'>PROCESS</td>
  <td class=xl27 style='border-left:none'>INPUT</td>
  <td class=xl27 style='border-left:none'>DEFECT</td>
  <td class=xl39 style='border-left:none'>RESULT</td>
  <td colspan=3 class=xl42>PROCESS</td>
  <td class=xl27 style='border-left:none'>INPUT</td>
  <td class=xl27 style='border-left:none'>DEFECT</td>
  <td class=xl39 style='border-left:none'>RESULT</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'><%=p3_process01 %></td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black'><%=p4_process01 %></td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'><%=p3_process02 %></td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black'><%=p4_process02 %></td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl48 style='border-right:.5pt solid black;
  height:15.0pt'><%=p3_process03 %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl48 style='border-right:.5pt solid black'><%=p4_process03 %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td colspan=13 height=5 class=xl53 style='height:3.75pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>&nbsp;</td>
  <td class=xl27 style='border-left:none'>Cutting</td>
  <td class=xl27 style='border-left:none'>Print</td>
  <td class=xl27 style='border-left:none'>Emb</td>
  <td class=xl27 style='border-left:none'>Sew</td>
  <td class=xl27 style='border-left:none'>Manager</td>
  <td rowspan=5 class=xl54>&nbsp;</td>
  <td class=xl27 style='border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-left:none'>Cutting</td>
  <td class=xl27 style='border-left:none'>Print</td>
  <td class=xl27 style='border-left:none'>Emb</td>
  <td class=xl27 style='border-left:none'>Sew</td>
  <td class=xl27 style='border-left:none'>Manager</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Line</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Line</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt;border-top:none'>Charger</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Charger</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Sign</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Sign</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none'>Date</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>Date</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr> 
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
