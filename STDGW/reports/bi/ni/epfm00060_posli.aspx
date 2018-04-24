<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("inv");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">


<%
    int  curPg, totPg, curRow, minRow, maxRow, totRow, nullRow_Qty, rowSeq;
    string pk;
    
    pk = Request.QueryString["p_pk"];
    DataTable dtM, dtD;

    dtM = ESysLib.TableReadOpenCursor("inv.sp_sel_epfm00060_posli", pk);
    dtD = ESysLib.TableReadOpenCursor("inv.sp_sel_epfm00060_posli_1", pk);
	
	if (dtM.Rows.Count == 0){
        Response.Write("No thing to print.");
        Response.End();
	}

    totRow = dtD.Rows.Count;

    if (totRow > 0){
	    if ((int)(totRow/12) == (totRow/12)) {
            totPg = (int)(totRow / 12);
        }
	    else{
		    totPg = (int)(totRow/12) + 1;
        }
    }
    else{
	    totPg = 1;
    }

    minRow = 0;

    if (totRow-1 >= minRow + 11){
	    maxRow = minRow + 11;
    }
    else{
	    maxRow = totRow - 1;
    }

    curRow = 0;
    rowSeq = 0;
    curPg = 1;

%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epfm00060_posli_filelist.xml">
<link rel=Edit-Time-Data href="epfm00060_posli_editdata.mso">
<link rel=OLE-Object-Data href="epfm00060_posli_oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Poslilama</o:Author>
  <o:LastAuthor>Nguyen Thanh Xuan</o:LastAuthor>
  <o:LastPrinted>2010-10-01T16:31:09Z</o:LastPrinted>
  <o:Created>2010-09-30T09:06:31Z</o:Created>
  <o:LastSaved>2010-10-07T01:52:06Z</o:LastSaved>
  <o:Company>Poslilama</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .2in 0in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;
	mso-horizontal-page-align:center;}
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
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Invoice</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>40</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column M</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Invoice!$12:$12</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="2"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl38>

<table x:str border=0 cellpadding=0 cellspacing=0 width=951 style='border-collapse:
 collapse;table-layout:fixed;width:715pt'>
 <col class=xl38 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl38 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl38 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl38 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl38 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl38 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl38 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl38 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl38 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl38 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 <col class=xl38 width=64 span=3 style='width:48pt'>
 <col class=xl38 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 width=29 style='height:31.5pt;width:22pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s2049" type="#_x0000_t75" style='position:absolute;
   margin-left:.75pt;margin-top:2.25pt;width:112.5pt;height:24.75pt;z-index:1'>
   <v:imagedata src="epfm00060_posli_image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:3px;width:150px;
  height:33px'><img width=150 height=33 src="epfm00060_posli_image002.jpg"
  v:shapes="_x0000_s2049"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=42 class=xl38 width=29 style='height:31.5pt;width:22pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl38 width=102 style='width:77pt'></td>
  <td class=xl38 width=97 style='width:73pt'></td>
  <td class=xl38 width=96 style='width:72pt'></td>
  <td class=xl38 width=34 style='width:26pt'></td>
  <td colspan=5 class=xl66 width=333 style='width:250pt'>INVOICE</td>
  <td class=xl38 width=64 style='width:48pt'></td>
  <td class=xl38 width=64 style='width:48pt'></td>
  <td class=xl38 width=64 style='width:48pt'></td>
  <td class=xl38 width=68 style='width:51pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl53 style='height:18.0pt'>POSCO<span
  style='mso-spacerun:yes'>  </span>Engineering &amp; contruction -VIET NAM
  Co.,Ltd</td>
  <td colspan=5 rowspan=2 class=xl64 style='border-bottom:.5pt solid black'>Phi&#7871;u
  giao nh&#7853;n hàng</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl90 style='height:18.0pt'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Project name (Tên Công Trình)</td>
  <td colspan=3 class=xl54 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=dtM.Rows[0]["PL_CD"]%>-<%=dtM.Rows[0]["pl_nm"]%></td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Invoice No (S&#7889; CT)</td>
  <td colspan=2 class=xl86 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=dtM.Rows[0]["invoice_no"].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Sending place (N&#417;i giao)</td>
  <td colspan=3 class=xl54 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=dtM.Rows[0]["send_place"].ToString()%></td>
  <td colspan=3 class=xl54 width=167 style='border-right:.5pt solid black;
  border-left:none;width:126pt'>Receiving place<span style='mso-spacerun:yes'> 
  </span>(N&#417;i nh&#7853;n)</td>
  <td colspan=2 class=xl88 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=dtM.Rows[0]["receive_place"].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Sending date (Ngày giao)</td>
  
  <%if (dtM.Rows[0]["send_date"].ToString() != string.Empty)
    { %>
  
  <td colspan=3 class=xl91 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%= DateTime.ParseExact(dtM.Rows[0]["send_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture).ToString("dd/MM/yyyy")%></td>
  
  <%}else{ %>
  
   <td colspan=3 class=xl91 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=string.Empty%></td>
   <%} %>


  
  <td colspan=3 class=xl54 width=167 style='border-right:.5pt solid black;
  border-left:none;width:126pt'>Receiving date (Ngày nh&#7853;n)</td>
  
   <%if (dtM.Rows[0]["receive_date"].ToString() != string.Empty)
     { %>
     
  <td colspan=2 class=xl72 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=DateTime.ParseExact(dtM.Rows[0]["receive_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.CurrentCulture).ToString("dd/MM/yyyy")%></td>
  
  <%}else{ %>
  
   <td colspan=2 class=xl72 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=string.Empty%></td>
  
  <%} %>
  
  
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Sender (Ng&#432;&#7901;i giao)</td>
  <td colspan=3 class=xl74 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=dtM.Rows[0]["send_by"].ToString()%></td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Receiver (Ng&#432;&#7901;i nh&#7853;n)</td>
  <td colspan=2 class=xl82 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=dtM.Rows[0]["receiver"].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Dept.(Ng&#432;&#7901;i giao)</td>
  <td colspan=3 class=xl57 style='border-right:.5pt solid black;border-left:
  none'><%=dtM.Rows[0]["send_dept"].ToString()%></td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Dept.(Ng&#432;&#7901;i nhận)</td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:
  none'><%=dtM.Rows[0]["receive_dept"].ToString()%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Production Engineer (K&#7929; s&#432; S&#7843;n
  Xu&#7845;t)</td>
  <td colspan=3 class=xl74 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=dtM.Rows[0]["prod_engineer"].ToString()%></td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Driver name (Tài x&#7871;)</td>
  <td colspan=2 class=xl84 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=dtM.Rows[0]["driver_name"].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl54 width=131 style='border-right:.5pt solid black;
  height:27.75pt;width:99pt'>Tranportation Co.,Ltd (Cty v&#7853;n chuy&#7875;n)</td>
  <td colspan=3 class=xl54 width=227 style='border-right:.5pt solid black;
  border-left:none;width:171pt'><%=dtM.Rows[0]["transport_company"].ToString()%></td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Vehicle No. (S&#7889; xe)</td>
  <td colspan=2 class=xl82 width=166 style='border-right:.5pt solid black;
  border-left:none;width:124pt'><%=dtM.Rows[0]["vehicle_no"].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=9 class=xl38 style='height:5.25pt;mso-ignore:colspan'></td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl37 style='height:21.75pt'>No.</td>
  <td class=xl45 style='border-left:none'>Code</td>
  <td colspan=3 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl45 style='border-left:none'>Unit</td>
  <td class=xl37 style='border-left:none'>Q'ty</td>
  <td class=xl95>Weight</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black'>Remark</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 
 <% 
     nullRow_Qty = 0;
     for(int i=0; i< dtD.Rows.Count;i++)
    {
        curRow = i +1;
        if (dtD.Rows[i][12].Equals(DBNull.Value))
        {
            dtD.Rows[i][12] = dtD.Rows[i][13]; 
        }
%>

 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl41 align=right style='height:21.0pt;border-top:none'
  x:num><% =curRow %></td>
  <td class=xl42 style='border-top:none;border-left:none'><%=dtD.Rows[i][5].ToString()%></td>
  <td colspan=3 class=xl79 style='border-right:.5pt solid black;border-left:
  none; border-top:none;'><%=dtD.Rows[i][6].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none'  x:num ><%=dtD.Rows[i][7]%></td>
  <td class=xl41 style='border-top:none;border-left:none'  x:num><%=dtD.Rows[i][8]%></td>
  <td class=xl97 style='border-top:none'  x:num ><%=dtD.Rows[i][9]%></td>
  <td colspan=2 class=xl77 style='border-right:.5pt solid black;border-left:
  none;border-top:none;'><%=dtD.Rows[i][12].ToString()%></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 
 <%}
     %>
     
 <% 
     int l_IEmptyRow = 18;
     int l_iTemp = 0;
     if (dtD.Rows.Count > 25)
     {
         l_iTemp = dtD.Rows.Count - 25;
         l_iTemp = l_iTemp % 30;
         if (l_iTemp == 0)
         {
             l_IEmptyRow = 30;
         }
         else
         {
             l_IEmptyRow = 30 - l_iTemp ;
         }
         curRow = 0;
     }
     for (int j = curRow; j < l_IEmptyRow; j++)
    { %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num></td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'  x:num>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>&nbsp;</td>
  <td class=xl98 style='border-top:none' x:num>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <%}
   int _i_Total = dtD.Rows.Count + 13;
      %>
  <!--
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A14+1">3</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 

 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A15+1">4</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A16+1">5</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A17+1">6</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A18+1">7</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A19+1">8</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A20+1">9</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A21+1">10</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A22+1">11</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A23+1">12</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A24+1">13</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A25+1">14</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A26+1">15</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A27+1">16</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A28+1">17</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl43 align=right style='height:21.0pt;border-top:none'
  x:num x:fmla="=A29+1">18</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 -->
 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5 height=28 class=xl49 style='border-right:.5pt solid black;
  height:21.0pt'>TOTAL</td>
  <td class=xl37 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num x:fmla="=SUM(G13:G<%=_i_Total %>)"></td>
  <td class=xl94 style='border-top:none' x:num  x:fmla="=SUM(H13:H<%=_i_Total %>)"></td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=14 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl59 style='border-right:.5pt solid black;
  height:18.0pt'>Prepared by</td>
  <td class=xl36 style='border-left:none'>Checked by</td>
  <td class=xl36 style='border-left:none'>Review by</td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Approved by</td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Driver</td>
  <td class=xl36 style='border-left:none'>Receiver</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl47 style='height:18.0pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl47 style='height:18.0pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
