<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_import_eval_result_sample_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_import_eval_result_sample_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_import_eval_result_sample_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>SV108</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:Created>2013-06-13T03:19:47Z</o:Created>
  <o:LastSaved>2013-06-13T03:54:22Z</o:LastSaved>
  <o:Company>vina</o:Company>
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
.font8
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:red;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:18.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<![if !supportAnnotations]><style id="dynCom" type="text/css"><!-- --></style>

<script language="JavaScript"><!--

    function msoCommentShow(com_id, anchor_id) {
        if (msoBrowserCheck()) {
            c = document.all(com_id);
            a = document.all(anchor_id);
            if (null != c) {
                var cw = c.offsetWidth;
                var ch = c.offsetHeight;
                var aw = a.offsetWidth;
                var ah = a.offsetHeight;
                var x = a.offsetLeft;
                var y = a.offsetTop;
                var el = a;
                while (el.tagName != "BODY") {
                    el = el.offsetParent;
                    x = x + el.offsetLeft;
                    y = y + el.offsetTop;
                }
                var bw = document.body.clientWidth;
                var bh = document.body.clientHeight;
                var bsl = document.body.scrollLeft;
                var bst = document.body.scrollTop;
                if (x + cw + ah / 2 > bw + bsl && x + aw - ah / 2 - cw >= bsl) {
                    c.style.left = x + aw - ah / 2 - cw;
                }
                else {
                    c.style.left = x + ah / 2;
                }
                if (y + ch + ah / 2 > bh + bst && y + ah / 2 - ch >= bst) {
                    c.style.top = y + ah / 2 - ch;
                }
                else {
                    c.style.top = y + ah / 2;
                }
                c.style.visibility = "visible";
            }
        }
    }

    function msoCommentHide(com_id) {
        if (msoBrowserCheck()) {
            c = document.all(com_id)
            if (null != c) {
                c.style.visibility = "hidden";
                c.style.left = "-10000";
                c.style.top = "-10000";
            }
        }
    }

    function msoBrowserCheck() {
        ms = navigator.appVersion.indexOf("MSIE");
        vers = navigator.appVersion.substring(ms + 5, ms + 6);
        ie4 = (ms > 0) && (parseInt(vers) >= 4);
        return ie4
    }

    if (msoBrowserCheck()) {
        document.styleSheets.dynCom.addRule(".msocomspan1", "position:absolute");
        document.styleSheets.dynCom.addRule(".msocomspan2", "position:absolute");
        document.styleSheets.dynCom.addRule(".msocomspan2", "left:-1.5ex");
        document.styleSheets.dynCom.addRule(".msocomspan2", "width:2ex");
        document.styleSheets.dynCom.addRule(".msocomspan2", "height:0.5em");
        document.styleSheets.dynCom.addRule(".msocomanch", "font-size:0.5em");
        document.styleSheets.dynCom.addRule(".msocomanch", "color:red");
        document.styleSheets.dynCom.addRule(".msocomhide", "display: none");
        document.styleSheets.dynCom.addRule(".msocomtxt", "visibility: hidden");
        document.styleSheets.dynCom.addRule(".msocomtxt", "position: absolute");
        document.styleSheets.dynCom.addRule(".msocomtxt", "top:-10000");
        document.styleSheets.dynCom.addRule(".msocomtxt", "left:-10000");
        document.styleSheets.dynCom.addRule(".msocomtxt", "width: 33%");
        document.styleSheets.dynCom.addRule(".msocomtxt", "background: infobackground");
        document.styleSheets.dynCom.addRule(".msocomtxt", "color: infotext");
        document.styleSheets.dynCom.addRule(".msocomtxt", "border-top: 1pt solid threedlightshadow");
        document.styleSheets.dynCom.addRule(".msocomtxt", "border-right: 2pt solid threedshadow");
        document.styleSheets.dynCom.addRule(".msocomtxt", "border-bottom: 2pt solid threedshadow");
        document.styleSheets.dynCom.addRule(".msocomtxt", "border-left: 1pt solid threedlightshadow");
        document.styleSheets.dynCom.addRule(".msocomtxt", "padding: 3pt 3pt 3pt 3pt");
        document.styleSheets.dynCom.addRule(".msocomtxt", "z-index: 100");
    }

// -->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12405</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1093 style='border-collapse:
 collapse;table-layout:fixed;width:822pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=64 style='width:48pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=14 height=37 class=xl27 width=1093 style='height:27.75pt;
  width:822pt'>Import Evaluation Result</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl28 style='height:23.25pt;border-top:none'>Seq</td>
  <td class=xl28 style='border-top:none;border-left:none'>Emp ID</td>
  <td class=xl28 style='border-top:none;border-left:none'>Full Name</td>
  <td class=xl28 style='border-top:none;border-left:none'>Total Salary</td>
  <td class=xl28 style='border-top:none;border-left:none'>Basic Salary</td>
  <td class=xl28 style='border-top:none;border-left:none'>Allowance</td>
  <td class=xl28 style='border-top:none;border-left:none'>Technical</td>
  <td class=xl28 style='border-top:none;border-left:none'>Position</td>
  <td class=xl28 style='border-top:none;border-left:none'>Site</td>
  <td class=xl28 style='border-top:none;border-left:none'>Special</td>
  <td class=xl28 style='border-top:none;border-left:none'>English</td>
  <td class=xl28 style='border-top:none;border-left:none'>Point</td>
  <td class=xl28 style='border-top:none;border-left:none'>Evaluation Result</td>
  <td class=xl28 style='border-top:none;border-left:none'>Remark</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt;border-top:none' x:num>1</td>
  <td class=xl25 style='border-top:none;border-left:none'>0001</td>
  <td class=xl26 style='border-top:none;border-left:none'>NGUYỄN A</td>
  <td class=xl26 align=right style='border-top:none;border-left:none'
  x:num="4650000">4650000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>2000000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>500000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>2000000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>150000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>150</td>
  <td class=xl24 style='border-top:none;border-left:none'>A</td>
  <td class=xl25 style='border-top:none;border-left:none'>10-JUNE-2013</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt;border-top:none' x:num>2</td>
  <td class=xl25 style='border-top:none;border-left:none'>0002<![if !supportAnnotations]><span
  class=msocomspan1><span class=msocomspan2 id="_anchor_1"
  onmouseover="msoCommentShow('_com_1','_anchor_1')"
  onmouseout="msoCommentHide('_com_1')" language=JavaScript><a
  class=msocomanch href="#_msocom_1" name="_msoanchor_1">[1]</a></span></span><![endif]></td>
  <td class=xl26 style='border-top:none;border-left:none'>NGUYỄN B</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>1800000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>1500000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>100000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>200000</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num>110</td>
  <td class=xl24 style='border-top:none;border-left:none'>B</td>
  <td class=xl25 style='border-top:none;border-left:none'>10-JUNE-2014</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=45 style='width:34pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=104 style='width:78pt'></td>
 </tr>
 <![endif]>
</table>

<div style='mso-element:comment-list'><![if !supportAnnotations]>

<hr class=msocomhide align=left size=1 width="33%">

<![endif]>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_1" class=msocomtxt
onmouseover="msoCommentShow('_com_1','_anchor_1')"
onmouseout="msoCommentHide('_com_1')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_1"
name="_msocom_1">[1]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
  <v:stroke joinstyle="miter"/>
  <v:path gradientshapeok="t" o:connecttype="rect"/>
 </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
  margin-left:99.75pt;margin-top:72.75pt;width:171pt;height:102.75pt;z-index:1;
  visibility:visible;mso-wrap-style:tight' fillcolor="infoBackground [80]"
  o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>3</x:Row>
   <x:Column>1</x:Column>
   <x:Author>SV108</x:Author>
   <x:Visible/>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s1025" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font9">Genuwin: EmpID must be formatted to
TEXT<br>
Ex: </font><font class="font10">0001, 0002 </font><font class="font9"><br>
but </font><font class="font10">'0001, '0002</font><font class="font9"> is not
valid</font><font class="font8"><br>
</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

</div>

</body>

</html>
