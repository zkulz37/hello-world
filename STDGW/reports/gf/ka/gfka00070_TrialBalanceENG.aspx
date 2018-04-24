﻿<%@ Page Language="C#"%>
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
   
    string l_compk = Request["p_compk"];
    string l_kind = Request["p_kind"];
    string l_lang = Request["p_lang"];
    string l_date_fr = Request["p_date_fr"];
    string l_date_to = Request["p_date_to"];
    string l_status = Request["p_status"];
    string l_current = Request["p_current"];
    string l_rate = Request["p_rate"];
    string l_pacctype = Request["p_pacctype"];
    string l_level = Request["p_level"];
    string l_possum = Request["p_possum"];
    string l_accd = Request["p_accd"];
    string l_check="";
    string l_check_sum = "";
    if (Request["p_check"] == "1")
    {
        l_check = "0";
        l_check_sum = "1";
    }
    else {
        l_check = "2";
        l_check_sum = "3";
    }

    string strdt_fr = "", strdt_to = "";
    string l_company = "",l_address="";
    string Form_Type = "",AccCode="",LevelName="";
    //string SQL2 = " select TO_CHAR(to_date('" + l_date_fr + "', 'yyyymm') , 'yyyymm') dt_from,tO_CHAR(to_date('" + l_date_to + "', 'yyyymm') , 'yyyymm') dt_to  from dual ";
    ////Response.Write(SQL2);
    ////Response.End();
    //DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    //if (dt2.Rows.Count > 0)
    //{
    //    strdt_fr = dt2.Rows[0][0].ToString();
    //    strdt_to = dt2.Rows[0][1].ToString();
    //}
    strdt_fr = l_date_fr.Substring(6, 2)+"/"+ l_date_fr.Substring(4, 2) + "/" + l_date_fr.Substring(0, 4);//2009.08.25
    strdt_to = l_date_fr.Substring(6, 2)+"/"+l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);//2009.08.25
    //Response.Write(strdt_fr);
    //Response.End();
    string SQL1 = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_compk + "'";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_company = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
    }
    string l_parameter = "'" + l_compk + "','" + l_lang + "','" + l_date_fr + "','" + l_date_to + "','" + l_status + "','" + l_current + "','" + l_rate + "','" + l_level + "','" + l_possum + "','" + l_accd + "','" + l_check + "','" + l_pacctype + "'";
    //Response.Write(l_parameter);
    //Response.End();
    //DataTable dt = ESysLib.TableReadOpenCursor("ACNT.SP_SEL_GRD_DTL_GENERAL_LEDGER3", l_parameter);
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00070_v1", l_parameter);
    l_parameter = "'" + l_compk + "','" + l_lang + "','" + l_date_fr + "','" + l_date_to + "','" + l_status + "','" + l_current + "','" + l_rate + "','" + l_level + "','" + l_possum + "','" + l_accd + "','" + l_check_sum + "','" + l_pacctype + "'";
   
    //DataTable dtTotal = ESysLib.TableReadOpenCursor("acnt.SP_SEL_GRD_DTL_GENERAL_LEDGER3", l_parameter);
    DataTable dtTotal = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfka00070_v1", l_parameter);
    //Response.Write(dtTotal.Rows.Count.ToString());
    //Response.End();
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
            
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_trial_70.hml_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_trial_70.hml_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_trial_70.hml_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2008-08-11T08:21:55Z</o:LastPrinted>
  <o:Created>2008-08-11T07:52:23Z</o:Created>
  <o:LastSaved>2010-01-14T03:02:47Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl33
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl46
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl47
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl48
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Trial Balance</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Trial Balance'!$A$8:$J$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1250 style='border-collapse:
 collapse;table-layout:fixed;width:940pt'>
 <col class=xl24 width=245 style='mso-width-source:userset;mso-width-alt:8960;
 width:184pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=117 span=8 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 width=245 style='height:15.75pt;width:184pt'><%=l_company %></td>
  <td class=xl24 width=69 style='width:52pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl26 width=117 style='width:88pt'></td>
  <td class=xl27 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'><%=l_address%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl42 style='height:22.5pt'>BẢNG CÂN ĐỐI SỐ
  PHÁT SINH - TRIAL BALANCE</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl28 style='height:19.5pt'>From <%=strdt_fr %>-> <%=strdt_to %></td>
 </tr>
 <tr class=xl25 height=22 style='height:16.5pt'>
  <td height=22 colspan=6 class=xl25 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl30>Đơn vị tính:</td>
  <td class=xl25>VND</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td rowspan=2 height=51 class=xl43 style='border-bottom:.5pt solid black;
  height:38.25pt'>Account Name</td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black'>Level</td>
  <td colspan=2 class=xl45 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Openning Balance&#10;SỐ DƯ ĐẦU KỲ"><span
  style='mso-spacerun:yes'> </span>Openning Balance<br>
    SỐ DƯ ĐẦU KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl47 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Period amount&#10;SỐ PHÁT SINH TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Period amount<br>
    SỐ PHÁT SINH TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl47 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Acc. Amount&#10;SỐ PHÁT SINH LŨY KẾ TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Acc. Amount<br>
    SỐ PHÁT SINH LŨY KẾ TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl47 width=234 style='border-right:1.0pt solid black;
  border-left:none;width:176pt' x:str="Ending Balance&#10;SỐ DƯ CUỐI KỲ"><span
  style='mso-spacerun:yes'> </span>Ending Balance<br>
    SỐ DƯ CUỐI KỲ<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt' x:str="NỢ"><span
  style='mso-spacerun:yes'> </span>NỢ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="CÓ" id="_x0000_s1031"><span
  style='mso-spacerun:yes'> </span>CÓ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="NỢ" id="_x0000_s1032"><span
  style='mso-spacerun:yes'> </span>NỢ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="CÓ" id="_x0000_s1033"><span
  style='mso-spacerun:yes'> </span>CÓ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="NỢ" id="_x0000_s1034"><span
  style='mso-spacerun:yes'> </span>NỢ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="CÓ" id="_x0000_s1035"><span
  style='mso-spacerun:yes'> </span>CÓ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 x:str="NỢ" id="_x0000_s1036"><span
  style='mso-spacerun:yes'> </span>NỢ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="CÓ" id="_x0000_s1037"><span
  style='mso-spacerun:yes'> </span>CÓ<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
     string tag_begin = "";
     string tag_end = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (l_check == "0" && l_pacctype == "ALL")
         {
             tag_begin = " ";
             tag_end = " ";
             if (dt.Rows[i][19].ToString() == "I")
             {
                 tag_begin = "<i>";
                 tag_end = "</i>";
             }
             if (dt.Rows[i][19].ToString() == "B")
             {
                 tag_begin = "<b>";
                 tag_end = "</b>";
             }
          %>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "0" && l_pacctype == "BAL")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
      %>
      
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "0" && l_pacctype == "PER")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %>  
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "0" && l_pacctype == "BAL-PER")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %>  
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "2" && l_pacctype == "ALL")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %>
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "2" && l_pacctype == "BAL")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %>
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "2" && l_pacctype == "BAL-PER")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %>
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
     else if (l_check == "2" && l_pacctype == "PER")
     {
         tag_begin = " ";
         tag_end = " ";
         if (dt.Rows[i][19].ToString() == "I")
         {
             tag_begin = "<i>";
             tag_end = "</i>";
         }
         if (dt.Rows[i][19].ToString() == "B")
         {
             tag_begin = "<b>";
             tag_end = "</b>";
         }
  %> 
  <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=245 style='height:15.0pt;width:184pt'><%=tag_begin%><%=dt.Rows[i][2]%><%=tag_end%></td>
  <td class=xl34 width=69 style='width:52pt'>Level <%=tag_begin%><%=dt.Rows[i][23]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][3]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][4]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][7]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][8]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][11]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][12]%><%=tag_end%></td>
  <td class=xl35 x:num><%=tag_begin%><%=dt.Rows[i][15]%><%=tag_end%></td>
  <td class=xl36 x:num><%=tag_begin%><%=dt.Rows[i][16]%><%=tag_end%></td>
 </tr>
 <%
     }
 }
      %>
    <%
     for (int i = 0; i < dtTotal.Rows.Count; i++)
        {
            if (l_check_sum == "1" && l_pacctype == "ALL")
            {
      %> 
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
      }
      else if (l_check_sum == "1" && l_pacctype == "BAL")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
    }
      else if (l_check_sum == "1" && l_pacctype == "PER")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
       }
      else if (l_check_sum == "1" && l_pacctype == "BAL-PER")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
     }
      else if (l_check_sum == "3" && l_pacctype == "ALL")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
      }
      else if (l_check_sum == "3" && l_pacctype == "BAL")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
      }
      else if (l_check_sum == "3" && l_pacctype == "PER")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
  <% 
  }
      else if (l_check_sum == "3" && l_pacctype == "BAL-PER")
      {
  %>
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl49 width=314 style='border-right:.5pt solid black;
  height:15.75pt;width:236pt'>Tổng cộng</td>
  <td class=xl37 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][1]%></td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'><%=dtTotal.Rows[i][2]%></span></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][5]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][6]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][9]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][10]%></td>
  <td class=xl38 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][13]%></td>
  <td class=xl39 x:num><span
  style='mso-spacerun:yes'> </span><%=dtTotal.Rows[i][14]%></td>
 </tr>
 <%
      } 
     }
         %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl40 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl53>Ngày 21 tháng 10 năm 2009</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl50 style='height:15.75pt'>Kế toán trưởng</td>
  <td class=xl28></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl50>Giám đốc</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl51 style='height:15.75pt'>( Ký, họ tên )</td>
  <td class=xl28></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl51>( Ký, họ tên, đóng dấu )</td>
  <td class=xl28></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=245 style='width:184pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>