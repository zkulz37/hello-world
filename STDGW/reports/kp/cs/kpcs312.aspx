<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            string p_Pk = Request.QueryString["pk"];
            string p_Ccy = Request.QueryString["Ccy"];
            string p_Project = "";
            string p_Subcontractor = "";
            string p_Subcontract = "";
            string p_Orderwork = "";
            string p_Contract_dt = "";
    
            string SQL = "SELECT b.projectname, " +
        "       c.partner_name, " +
        "       d.ORDERINGCONTTYPECODE || '-' || d.orderingconttypename Outside, " +
        "       A.CONTRACT_CD, " +
        "       TO_CHAR (TO_DATE (a.contract_dt, 'YYYYMMDD'), 'DD/MM/YYYY') " +
        "  FROM tecps_substrp12000 A, " +
        "       tecps_projectsumm b, " +
        "       comm.tco_buspartner c, " +
        "       tecps_orderingconttype d " +
        " WHERE     a.del_if = 0 " +
        "       AND b.del_if(+) = 0 " +
        "       AND c.del_if(+) = 0 " +
        "       AND d.del_if(+) = 0 " +
        "       AND a.tecps_projectsumm_pk = b.pk(+) " +
        "       AND a.partner_pk = c.pk(+) " +
        "       AND A.TECPS_ORDERINGCONTTYPE_PK = d.pk(+) " +
        "       AND a.pk = '" + p_Pk + "' ";
            DataTable dt = ESysLib.TableReadOpen(SQL);
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data to show");
                Response.End();
            }
            p_Project = dt.Rows[0][0].ToString();
            p_Subcontractor =  dt.Rows[0][1].ToString();
            p_Orderwork = dt.Rows[0][2].ToString();
            p_Subcontract = dt.Rows[0][3].ToString();
            p_Contract_dt = dt.Rows[0][4].ToString();
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpcs312_asform_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpcs312_asform_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpcs312_asform_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2011-05-17T06:17:39Z</o:LastPrinted>
  <o:Created>2011-05-17T06:10:14Z</o:Created>
  <o:LastSaved>2011-05-26T08:05:34Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.34in .17in .2in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style44
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
.xl65
	{mso-style-parent:style44;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;}
.xl66
	{mso-style-parent:style44;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:right;}
.xl67
	{mso-style-parent:style44;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:right;}
.xl68
	{mso-style-parent:style44;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;}
.xl69
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style44;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style44;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";}
.xl76
	{mso-style-parent:style44;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style44;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;}
.xl78
	{mso-style-parent:style44;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style44;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	font-size:8.0pt;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>59</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>10</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1737 style='border-collapse: collapse;table-layout:fixed;width:1307pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=223 style='mso-width-source:userset;mso-width-alt:8155;width:167pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=106 span=6 style='mso-width-source:userset;mso-width-alt:3876; width:80pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=18 height=22 class=xl68 width=1737 style='height:16.5pt; width:1307pt' >PROJECT NAME : <%=p_Project %></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl79 colspan=3 style='height:15.75pt;mso-ignore:colspan'  >Subcontractor: <%=p_Subcontractor %></td>
  <td class=xl67></td>
  <td class=xl75></td>
  <td colspan=3 class=xl65></td>
  <td class=xl77 colspan=2 style='mso-ignore:colspan'  >Subcontract: <%=p_Subcontract %></td>
  <td class=xl65></td>
  <td colspan=7 class=xl65></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl79 colspan=3 style='height:15.75pt;mso-ignore:colspan'  >Order work: <%=p_Orderwork %></td>
  <td class=xl66></td>
  <td class=xl74>&nbsp;</td>
  <td colspan=3 class=xl74>&nbsp;</td>
  <td class=xl78 colspan=2 style='mso-ignore:colspan'  >Contract date: <%=p_Contract_dt %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>Unit: <%=p_Ccy%></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td rowspan=2 height=47 class=xl70 style='height:35.85pt' x:str="No.">No.</td>
  <td rowspan=2 class=xl70 x:str="Item Code">Item Code</td>
  <td rowspan=2 class=xl70 x:str="Item Name"><span  style='mso-spacerun:yes'> </span>Item Name<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl70 x:str="Spec"><span  style='mso-spacerun:yes'> </span>Spec<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl70 style='border-top:none' x:str="Weight"><span  style='mso-spacerun:yes'> </span>Weight<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl70 style='border-top:none' x:str="Unit"><span  style='mso-spacerun:yes'> </span>Unit<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl70 style='border-top:none' x:str="Quantity"><span  style='mso-spacerun:yes'> </span>Quantity<span  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl70 style='border-left:none' x:str="UNIT PRICE"><span
  style='mso-spacerun:yes'> </span>UNIT PRICE<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl93 width=76 style='border-bottom:.5pt solid black;
  border-top:none;width:57pt' x:str="Unit price&#10;(Intergrated)"><span
  style='mso-spacerun:yes'> </span>Unit price<br>
    (Intergrated)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl70 style='border-left:none' x:str="AMOUNT"><span
  style='mso-spacerun:yes'> </span>AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl71 width=106 style='border-top:none;width:80pt'
  x:str="Net Amount&#10;(Intergrated)"><span
  style='mso-spacerun:yes'> </span>Net Amount<br>
    (Intergrated)<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl71 width=106 style='border-top:none;width:80pt'  x:str="Vat Rate">Vat Rate</td>
  <td rowspan=2 class=xl71 width=106 style='border-top:none;width:80pt'  x:str="Vat Amount">Vat Amount</td>
  <td rowspan=2 class=xl72 style='border-bottom:.5pt solid black;border-top:  none' x:str="Total">Total</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl70 style='height:21.75pt;border-top:none;border-left:  none' x:str="MATERIAL">MATERIAL</td>
  <td class=xl70 style='border-top:none;border-left:none' x:str="LABOR">LABOR</td>
  <td class=xl70 style='border-top:none;border-left:none' x:str="EQUIPMENT">EQUIPMENT</td>
  <td class=xl70 style='border-top:none;border-left:none' x:str="MATERIAL">MATERIAL</td>
  <td class=xl70 style='border-top:none;border-left:none' x:str="LABOR">LABOR</td>
  <td class=xl70 style='border-top:none;border-left:none' x:str="EQUIPMENT">EQUIPMENT</td>
 </tr>
 <%
     string SQL_Detail = "SELECT B.ITEMCODE, " +
           "       B.ITEMNAME, " +
           "       A.STANDARD spec, " +
           "       a.WEIGHT, " +
           "       A.UNIT, " +
           "       A.ORDER_QTY, " +
           "       A.ORDER_MATERIAL_UP, " +
           "       A.ORDER_LABOR_UP, " +
           "       A.ORDER_EXPENSE_UP, " +
           "       A.ORDER_UP, " +
           "       A.ORDER_MATERIAL_FAMT, " +
           "       A.ORDER_LABOR_FAMT, " +
           "       A.ORDER_EXPENSE_FAMT, " +
           "       A.ORDER_FAMT, " +
           "       A.VAT_RATE, " +
           "       A.VAT_FAMT, " +
           "       ORDER_TOT_FAMT " +
           "  FROM TECPS_VENDORCTRTRMRK a, TECPS_ITEM b " +
           " WHERE     a.del_if = 0 " +
           "       AND b.del_if = 0 " +
           "       AND A.TECPS_SUBSTRP12000_PK  = '" + p_Pk + "' " +
           "       AND A.TECPS_ITEM_PK = b.pk and TECPS_VENDORBASC_PK is null " +
           "       order by B.ITEMCODE ";
     //Response.Write(SQL_Detail);
     //Response.End();
     DataTable dt_detail = ESysLib.TableReadOpen(SQL_Detail);
     int i ;
     int k = 0;
     
     for (i = 0; i < dt_detail.Rows.Count; i++)
     {
         
      %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl88 style='height:12.75pt;border-top:none' ><%=k+1%></td>
  <td class=xl90 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][0]%></td>
  <td class=xl90 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][1]%></td>
  <td class=xl69 style='border-top:none;border-left:none' ><%=dt_detail.Rows[i][2]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl91 style='border-top:none;border-left:none' ><%=dt_detail.Rows[i][4]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][5]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][6]%></td>
  <td class=xl69 style='border-top:none;border-left:none'  x:num><%=dt_detail.Rows[i][7]%></td>
  <td class=xl69 style='border-top:none;border-left:none'  x:num><%=dt_detail.Rows[i][8]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][9]%></td>
  <td class=xl69 style='border-top:none;border-left:none'  x:num><%=dt_detail.Rows[i][10]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][11]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][12]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][13]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][14]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][15]%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][16]%></td>
 </tr>
 <%k+=1;} %>

 <%
     decimal U_MATERIAL = 0;
     decimal U_LABOR = 0;
     decimal U_EQUIPMENT = 0;
     decimal U_Unit_Total = 0;
     decimal A_MATERIAL = 0;
     decimal A_LABOR = 0;
     decimal A_EQUIPMENT = 0;
     decimal A_Amount_Total = 0;
     decimal _VatRate = 0;
     decimal _VatAmount = 0;
     decimal _Total = 0;
     string SQL_Sum   = "SELECT sum(nvl(A.ORDER_MATERIAL_UP,0)), " +
        "       sum(nvl(A.ORDER_LABOR_UP,0)), " +
        "      sum(nvl(A.ORDER_EXPENSE_UP,0)), " +
        "      sum(nvl( a.ORDER_UP,0)), " +
        "      sum(nvl( A.ORDER_MATERIAL_FAMT,0)), " +
        "      sum(nvl( A.ORDER_LABOR_FAMT,0)), " +
        "      sum(nvl( A.ORDER_EXPENSE_FAMT,0)), " +
        "      sum(nvl( A.ORDER_FAMT,0)), " +
        "      sum(nvl( A.VAT_RATE,0)), " +
        "      sum(nvl( A.VAT_FAMT,0)), " +
        "      sum(nvl( ORDER_TOT_FAMT,0)) " +
        "  FROM TECPS_VENDORCTRTRMRK a, TECPS_ITEM b " +
        " WHERE     a.del_if = 0 " +
        "       AND b.del_if = 0 " +
        "       AND A.TECPS_SUBSTRP12000_PK = '" + p_Pk + "' " +
        "       AND A.TECPS_ITEM_PK = b.pk and TECPS_VENDORBASC_PK is null ";
     DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
     U_MATERIAL = decimal.Parse( dt_sum.Rows[0][0].ToString());
     U_LABOR = decimal.Parse(dt_sum.Rows[0][1].ToString());
     U_EQUIPMENT = decimal.Parse(dt_sum.Rows[0][2].ToString());
     U_Unit_Total = decimal.Parse(dt_sum.Rows[0][3].ToString());
     A_MATERIAL = decimal.Parse(dt_sum.Rows[0][4].ToString());
     A_LABOR = decimal.Parse(dt_sum.Rows[0][5].ToString());
     A_EQUIPMENT = decimal.Parse(dt_sum.Rows[0][6].ToString());
     A_Amount_Total = decimal.Parse(dt_sum.Rows[0][7].ToString());
     _VatRate = decimal.Parse(dt_sum.Rows[0][8].ToString());
     _VatAmount = decimal.Parse(dt_sum.Rows[0][9].ToString());
     _Total = decimal.Parse(dt_sum.Rows[0][10].ToString());
      %>
 <tr class=xl80 height=17 style='height:12.75pt'>
  <td colspan=7 height=17 class=xl81 style='height:12.75pt' x:str="GRAND TOTAL">GRAND TOTAL</td>
  <td class=xl82 align=right style='border-left:none' x:num><%=U_MATERIAL%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=U_LABOR%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=U_EQUIPMENT%></td>
  <td class=xl82 style='border-left:none' x:num><%=U_Unit_Total%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=A_MATERIAL%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=A_LABOR%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=A_EQUIPMENT%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=A_Amount_Total%></td>
  <td class=xl82 align=right style='border-left:none' x:num></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=_VatAmount%></td>
  <td class=xl82 align=right style='border-left:none' x:num><%=_Total%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=223 style='width:167pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=121 style='width:91pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
