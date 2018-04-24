<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string ls_compk = ""; //cong ty
	string ls_from_dt = "", ls_to_dt = ""; // tu ngay den ngay
	string ls_param = "", ls_date= "";
	string ls_item = "", ls_abplcenter_pk = "";
	ls_compk = Request["company_pk"];
	ls_from_dt = Request["from_dt"];
	ls_to_dt = Request["to_dt"];	
	ls_item =  Request["item"];	
	ls_abplcenter_pk = Request["tac_abplcenter_pk"];
	ls_param = "'" + ls_compk + "', '" + ls_from_dt + "', '" + ls_to_dt + "', '" + ls_item + "', '" + ls_abplcenter_pk + "'" ;
	//Response.Write(ls_param);
	//Response.End();
	DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpenCursor("sp_sel_fmgf00220_4", ls_param);	
	
	int i;
    ls_date = "";
    ls_date = ls_from_dt.Substring(6, 2) + "/" + ls_from_dt.Substring(4, 2) + "/" + ls_from_dt.Substring(0, 4);
    ls_date += " to " + ls_to_dt.Substring(6, 2) + "/" + ls_to_dt.Substring(4, 2) + "/" + ls_to_dt.Substring(0, 4);
    string SQL
        = "select partner_name, addr1 || nvl(addr2, '' ) || nvl(addr3, '') addr, tax_code " +
            "from comm.tco_company where pk = '" + ls_compk + "'";
    DataTable dtComp = ESysLib.TableReadOpen(SQL);
    
    string l_comp_nm = "", l_addr = "", l_tax_code = "";
    if (dtComp.Rows.Count > 0)
    {
        l_comp_nm = dtComp.Rows[0][0].ToString();
        l_addr = dtComp.Rows[0][1].ToString();
        l_tax_code = dtComp.Rows[0][2].ToString();
    }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Balance_files/filelist.xml">
<link rel=Edit-Time-Data href="Balance_files/editdata.mso">
<link rel=OLE-Object-Data href="Balance_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:Created>2010-05-05T03:50:09Z</o:Created>
  <o:LastSaved>2010-05-05T03:52:07Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl31
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:129;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>fmgf00220 1 </x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>14940</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1936 style='border-collapse:
 collapse;table-layout:fixed;width:1454pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=190 style='mso-width-source:userset;mso-width-alt:6948;
 width:143pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=134 style='mso-width-source:userset;mso-width-alt:4900;
 width:101pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl24 width=64 span=9 style='width:48pt'>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl25 align=left width=286 style='height:18.0pt;
  width:215pt'><%=l_comp_nm %></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=125 style='width:94pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=92 style='width:69pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=94 style='width:71pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=134 style='width:101pt'></td>
  <td class=xl26 width=92 style='width:69pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl25 align=left style='height:18.0pt'><%=l_addr %></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl25 align=left style='height:18.0pt'>MST: <%=l_tax_code %></td>
  <td class=xl25></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=15 height=27 class=xl46 style='height:20.25pt'>INVENTORY OF
  MATERIAL REPORT</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=15 height=24 class=xl47 style='height:18.0pt'>Period from <%=ls_date %></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=15 height=24 class=xl47 style='height:18.0pt'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 align=left style='height:18.0pt'>Warehouse</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30>Unit:</td>
  <td class=xl30></td>
  <td class=xl28 align=left>VND</td>
  <td class=xl28></td>
  <td class=xl30>Exchange Rate:</td>
  <td class=xl31 align=left x:num="1"><span
  style='mso-spacerun:yes'>                   </span>1 </td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl48 width=286 style='border-right:.5pt solid black;
  height:18.0pt;width:215pt'>Item</td>
  <td rowspan=3 class=xl66 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Project</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black'>Openning
  Balance</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>Take In</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>Take Out</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>Closing Balance</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl53 width=96 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none;width:72pt'>Code</td>
  <td rowspan=2 class=xl53 width=190 style='border-bottom:.5pt solid black;
  border-top:none;width:143pt'>Name</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Amount</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Amount</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Amount</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black;border-top:
  none'>Qty</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Amount</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <%
  
	decimal l_begin_qty = 0, l_begin_famt = 0, l_begin_amt = 0;
	decimal l_input_qty = 0, l_input_famt = 0, l_input_amt = 0;
	decimal l_output_qty = 0, l_output_famt = 0, l_output_amt = 0;
	decimal l_end_qty = 0, l_end_famt = 0, l_end_amt = 0;
	for ( i = 0 ; i < dt.Rows.Count ; i++)
	{
		if(dt.Rows[i][2].ToString().Trim() != "")		
		{
			l_begin_qty += decimal.Parse(dt.Rows[i][2].ToString());
		}
		if(dt.Rows[i][3].ToString().Trim() != "")		
		{
			l_begin_famt += decimal.Parse(dt.Rows[i][3].ToString());			
		}
		if(dt.Rows[i][4].ToString().Trim() != "")		
		{
			l_begin_amt += decimal.Parse(dt.Rows[i][4].ToString());			
		}
		if(dt.Rows[i][5].ToString().Trim() != "")		
		{
			l_input_qty += decimal.Parse(dt.Rows[i][5].ToString());
		}
		if(dt.Rows[i][6].ToString().Trim() != "")		
		{
			l_input_famt += decimal.Parse(dt.Rows[i][6].ToString());			
		}
		if(dt.Rows[i][7].ToString().Trim() != "")		
		{
			l_input_amt += decimal.Parse(dt.Rows[i][7].ToString());			
		}
		if(dt.Rows[i][8].ToString().Trim() != "")		
		{
			l_output_qty += decimal.Parse(dt.Rows[i][8].ToString());
		}
		if(dt.Rows[i][9].ToString().Trim() != "")		
		{
			l_output_famt += decimal.Parse(dt.Rows[i][9].ToString());			
		}
		if(dt.Rows[i][10].ToString().Trim() != "")		
		{
			l_output_amt += decimal.Parse(dt.Rows[i][10].ToString());			
		}
		if(dt.Rows[i][11].ToString().Trim() != "")		
		{
			l_end_qty += decimal.Parse(dt.Rows[i][11].ToString());
		}
		if(dt.Rows[i][12].ToString().Trim() != "")		
		{
			l_end_famt += decimal.Parse(dt.Rows[i][12].ToString());			
		}
		if(dt.Rows[i][13].ToString().Trim() != "")		
		{
			l_end_amt += decimal.Parse(dt.Rows[i][13].ToString());			
		}
		
 %>
 <tr class=xl33 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl34 align=left width=96 style='height:18.75pt;
  width:72pt'><%=dt.Rows[i][0]%> </td>
  <td class=xl35 align=left width=190 style='width:143pt'><%=dt.Rows[i][1]%></td>
  <td class=xl64 width=89 style='width:67pt'><%=dt.Rows[i][14]%></td>
  <td class=xl36 align=left x:num><span style='mso-spacerun:yes'>         
  </span><%=dt.Rows[i][2]%> </td>
  <td class=xl37 align=left x:num><span
  style='mso-spacerun:yes'>                  </span><%=dt.Rows[i][3]%></td>
  <td class=xl36 align=left x:num><span style='mso-spacerun:yes'>     
  </span><%=dt.Rows[i][4]%> </td>
  <td class=xl36 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[i][5]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl37 align=left x:num><span
  style='mso-spacerun:yes'>                        </span><%=dt.Rows[i][6]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl36 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[i][7]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl36 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[i][8]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl37 align=left x:num><span
  style='mso-spacerun:yes'>                         </span><%=dt.Rows[i][9]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl36 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[i][10]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl36 align=left x:num><span style='mso-spacerun:yes'>         
  </span><%=dt.Rows[i][11]%></td>
  <td class=xl37 align=left x:num><span
  style='mso-spacerun:yes'>                     </span><%=dt.Rows[i][12]%> </td>
  <td class=xl36 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dt.Rows[i][13]%> </td>
  <td class=xl38></td>
  <td class=xl27></td>
  <td colspan=7 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <% 
    }
 %>
 <tr class=xl33 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl60 align=left width=286 style='border-right:
  .5pt solid black;height:18.75pt;width:215pt'>TOTAL</td>
  <td class=xl65 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl39 align=center x:num><%=l_begin_qty%></td>
  <td class=xl40 align=left x:num><span
  style='mso-spacerun:yes'>              </span><%=l_begin_famt%> </td>
  <td class=xl39 align=center x:num><%=l_begin_amt%></td>
  <td class=xl39 align=center x:num><%=l_input_qty%></td>
  <td class=xl40 align=left x:num><span
  style='mso-spacerun:yes'>     </span><%=l_input_famt%> </td>
  <td class=xl39 align=center x:num><%=l_input_amt%></td>
  <td class=xl39 align=center x:num><%=l_output_qty%></td>
  <td class=xl40 align=left x:num><span
  style='mso-spacerun:yes'>   </span><%=l_output_famt%> </td>
  <td class=xl39 align=center x:num><%=l_output_amt%></td>
  <td class=xl39 align=center x:num><%=l_end_qty %></td>
  <td class=xl40 align=left x:num><span
  style='mso-spacerun:yes'>                 </span><%=l_end_famt %> </td>
  <td class=xl39 align=left x:num><span
  style='mso-spacerun:yes'>       </span><%=l_end_amt%> </td>
  <td class=xl38></td>
  <td class=xl27></td>
  <td colspan=7 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=15 class=xl41 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=15 class=xl41 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl42 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=7 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl47>Prepared, as at <%=ls_date %></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl43 style='height:18.75pt'></td>
  <td colspan=3 class=xl62>PREPARED BY</td>
  <td class=xl43></td>
  <td colspan=4 class=xl62>CHIEF ACCOUNTANT</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl62>DIRECTOR</td>
  <td colspan=9 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl44 style='height:18.0pt'></td>
  <td colspan=3 class=xl63>(Sign, name)</td>
  <td class=xl44></td>
  <td colspan=4 class=xl63>(Sign, name)</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl63>(Sign, name, Stamp)</td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=15 class=xl45 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=15 class=xl45 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=15 class=xl45 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl45 style='height:18.0pt'></td>
  <td colspan=3 class=xl63>NGUYỄN VAN AI</td>
  <td class=xl41></td>
  <td colspan=4 class=xl63>NGUYỄN VAN AI</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl63></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=96 style='width:72pt'></td>
  <td width=190 style='width:143pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
