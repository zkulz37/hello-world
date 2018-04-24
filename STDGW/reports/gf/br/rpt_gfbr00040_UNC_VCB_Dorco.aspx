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
        string p_Seq = Request["Seq"];
        string p_Date = "";
        string p_D_Acc_No = "";
        string p_D_Acc_Nm = "";
        string p_D_Add = "";
        string p_D_Bank = "";
        string p_C_Acc_No = "";
        string p_C_Acc_Nm = "";
        string p_C_Add = "";
        string p_C_Bank = "";
        string p_Remark = "";
        DataTable dt = ESysLib.TableReadOpenCursor("acnt.rpt_sel_gfbr00030", p_Seq);
        if (dt.Rows.Count == 0)
        {
            Response.Write("There is not data !!");
            Response.End();
        }
        else
        {
            p_Date = dt.Rows[0][10].ToString();
            p_D_Acc_No = dt.Rows[0][24].ToString();
            p_D_Acc_Nm = dt.Rows[0][12].ToString();
            p_D_Add = dt.Rows[0][25].ToString();
            p_D_Bank = dt.Rows[0][9].ToString();
            p_C_Acc_No = dt.Rows[0][0].ToString();
            p_C_Acc_Nm = dt.Rows[0][19].ToString();
            p_C_Add = dt.Rows[0][26].ToString();
            p_C_Bank = dt.Rows[0][1].ToString();
            p_Remark = dt.Rows[0][13].ToString();
        }
        
        string p_Amt = "";
        string p_Ccy = "";
        string Inword = "";
        DataTable dt_Amount = ESysLib.TableReadOpenCursor("acnt.rpt_sel_gfbr00030_1", p_Seq);
        if (dt_Amount.Rows.Count > 0)
        {
            p_Amt = dt_Amount.Rows[0][12].ToString();
            p_Ccy = dt_Amount.Rows[0][3].ToString();

            Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), "VND");
            string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
            DataTable dt_t = ESysLib.TableReadOpen(SQL3);

            if (dt_t.Rows.Count > 0)
            {
                Inword = dt_t.Rows[0][0].ToString();

            }
        }

        
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="unc%20mau%20(3)_files/filelist.xml">
<link rel=Edit-Time-Data href="unc%20mau%20(3)_files/editdata.mso">
<link rel=OLE-Object-Data href="unc%20mau%20(3)_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Ms Tuyen_acc</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-08-26T09:40:34Z</o:LastPrinted>
  <o:Created>2011-07-29T01:24:58Z</o:Created>
  <o:LastSaved>2011-08-26T09:40:53Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .25in .25in .5in;
	mso-header-margin:.24in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl106
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style43;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl127
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>UNC VCB</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10995</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='UNC VCB'!$A$1:$M$26</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl69>

<table x:str border=0 cellpadding=0 cellspacing=0 width=742 style='border-collapse:
 collapse;table-layout:fixed;width:559pt'>
 <col class=xl69 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl69 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl69 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl69 width=64 style='width:48pt'>
 <col class=xl69 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl69 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl69 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl69 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl69 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl69 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl69 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl69 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl69 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 colspan=2 width=106 style='height:15.0pt;mso-ignore:
  colspan;width:80pt'><a name="Print_Area"><span style='mso-spacerun:yes'>     
  </span>VIETCOMBANK</a></td>
  <td class=xl67 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl67 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl67 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl67 width=18 style='width:14pt'>&nbsp;</td>
  <td class=xl67 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl67 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl67 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl67 width=65 style='width:49pt'>&nbsp;</td>
  <td class=xl67 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl67 width=62 style='width:47pt'>&nbsp;</td>
  <td class=xl68 width=71 style='width:53pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=13 height=20 class=xl123 style='border-right:.5pt solid black;
  height:15.0pt'>ỦY NHIỆM CHI - PAYMENT ORDER</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl70 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl71 colspan=2 style='mso-ignore:colspan'>Ngày (<font class="font11">Date)</font><font
  class="font5">:</font></td>
  <td colspan=2 class=xl126 ><%=p_Date %></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl72>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl69></td>
  <td class=xl72>&nbsp;</td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl70 style='height:9.0pt'>&nbsp;</td>
  <td colspan=10 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
 </tr>
 <tr class=xl77 height=15 style='height:11.25pt'>
  <td height=15 class=xl76 style='height:11.25pt'>ĐỀ NGHỊ GHI NỢ TÀI KHOẢN <font class="font15">(Please Debit  account:)</font></td>
  <td colspan=5 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl78 colspan=3 style='mso-ignore:colspan'>SỐ TIỀN<font  class="font13"> </font><font class="font14">(With amount):</font></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl77>PHÍ NH <font class="font14">(Ba</font><font class="font14">nk charges)</font></td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl77 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl80 colspan=2 style='height:23.25pt;mso-ignore:colspan'>SỐ TK <font class="font14">(A/C No)</font><font class="font13">:</font></td>
  <td colspan=3 class=xl105 width=190 style='border-right:.5pt solid black;  width:143pt'><%=p_D_Acc_No %></td>
  <td class=xl82 style='border-left:none'>&nbsp;</td>
  <td class=xl83 colspan=2 style='mso-ignore:colspan'>BẰNG SỐ <font  class="font14">(In figures)</font><font class="font13">:</font></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black' x:num><%=p_Amt%></td>
  <td class=xl65 style='border-left:none'><%=p_Ccy %></td>
  <td class=xl85 width=62 style='width:47pt'>Phí trong<br>
    <font class="font14">Including</font></td>
  <td height=31 class=xl79 width=71 style='height:23.25pt;width:53pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_2" o:spid="_x0000_s1186" style='position:absolute;
   margin-left:9pt;margin-top:5.25pt;width:16.5pt;height:14.25pt;z-index:2;
   visibility:visible;v-text-anchor:middle' fillcolor="window" strokecolor="windowText"
   strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=6></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=24 height=21 src="unc%20mau%20(3)_files/image001.gif"
    v:shapes="Rectangle_x0020_2"></td>
    <td width=36></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:53.25pt;height:23.25pt'></span><![endif]--></td>
 </tr>
 <tr class=xl77 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl80 colspan=2 style='height:21.0pt;mso-ignore:colspan'>TÊN TK <font class="font14">(A/c name)</font><font class="font13">:</font></td>
  <td colspan=3 class=xl101 style='border-right:.5pt solid black'><%=p_D_Acc_Nm %></td>
  <td class=xl82 style='border-left:none'>&nbsp;</td>
  <td rowspan=2 class=xl129 width=67 style='border-bottom:.5pt solid black;  border-top:none;width:50pt'>BẰNG CHỮ( In words)</td>
  <td colspan=4 rowspan=2 class=xl131 width=228 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:172pt'><%=Inword %></td>
  <td class=xl85 width=62 style='width:47pt'>Phí ngoài<br>
    <font class="font14">Excludin</font><font class="font5">g</font></td>
  <td height=28 class=xl79 width=71 style='height:21.0pt;width:53pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_1" o:spid="_x0000_s1185" style='position:absolute;
   margin-left:9pt;margin-top:1.5pt;width:16.5pt;height:14.25pt;z-index:1;
   visibility:visible;v-text-anchor:middle' fillcolor="window" strokecolor="windowText"
   strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:center'><font class="font7"><span
    style='mso-spacerun:yes'> </span></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=1></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=24 height=21 src="unc%20mau%20(3)_files/image001.gif"
    alt="Text Box:  " v:shapes="Rectangle_x0020_1"></td>
    <td width=36></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:53.25pt;height:21.0pt'></span><![endif]--></td>
 </tr>
 <tr class=xl77 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl118 width=106 style='height:21.0pt;  width:80pt'>ĐỊA CHỈ (Address):</td>
  <td colspan=3 class=xl113 width=190 style='border-right:.5pt solid black;  width:143pt'><%= p_D_Add%></td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl77></td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl77 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl118 width=106 style='height:21.0pt;  width:80pt'>TẠI NH<font class="font14"> (With bank)</font><font class="font13">:</font></td>
  <td colspan=3 class=xl101 style='border-right:.5pt solid black'><%= p_D_Bank%></td>
  <td class=xl87></td>
  <td colspan=5 class=xl119 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl77></td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl71 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl88 style='height:17.25pt'>&nbsp;</td>
  <td colspan=5 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl122 width=164 style='width:123pt'>NỘI DUNG (Details of Payment):</td>
  <td colspan=4 class=xl116 style='border-right:.5pt solid black'><%= p_Remark%></td>
 </tr>
 <tr class=xl77 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'>&amp; GHI CÓ TÀI KHOẢN<font class="font15"> (&amp; Credit account):</font></td>
  <td colspan=5 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl116 style='border-right:.5pt solid black'></td>
 </tr>
 <tr class=xl77 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl80 colspan=2 style='height:18.0pt;mso-ignore:colspan'>SỐ TK (A/C No):</td>
  <td colspan=3 class=xl105 width=190 style='border-right:.5pt solid black; width:143pt' ><%= p_C_Acc_No%></td>
  <td class=xl77></td>
  <td colspan=7 class=xl108 style='border-right:.5pt solid black'></td>
 </tr>
 <tr class=xl77 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl80 colspan=2 style='height:33.0pt;mso-ignore:colspan'>TÊN TK (A/c Name):</td>
  <td colspan=3 class=xl101 style='border-right:.5pt solid black'><%= p_C_Acc_Nm%></td>
  <td class=xl77></td>
  <td colspan=3 class=xl110 width=164 style='width:123pt'>KẾ TOÁN TRƯỞNG KÝ<br>
    <font class="font15">Chief accountant</font></td>
  <td colspan=4 class=xl110 width=264 style='border-right:.5pt solid black; width:199pt'>CHỦ TÀI KHOẢN KÝ VÀ ĐÓNG DẤU<br>
    <font class="font15">Acc. Holder &amp; Stamp</font></td>
 </tr>
 <tr class=xl77 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl112 width=106 style='height:18.0pt;  width:80pt'>ĐỊA CHỈ (Address):</td>
  <td colspan=3 class=xl113 width=190 style='border-right:.5pt solid black;  width:143pt'><%= p_C_Add%></td>
  <td class=xl77></td>
  <td colspan=3 class=xl97></td>
  <td colspan=4 class=xl97 style='border-right:.5pt solid black'></td>
 </tr>
 <tr class=xl77 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl99 width=106 style='height:18.0pt;width:80pt'>TẠI NH (With bank)<font class="font13">:</font></td>
  <td colspan=3 class=xl101 style='border-right:.5pt solid black'><%= p_C_Bank%></td>
  <td colspan=7 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl71 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl89 style='height:19.5pt'>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
 </tr>
 <tr class=xl71 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl88 style='height:9.0pt'>&nbsp;</td>
  <td colspan=11 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl92>&nbsp;</td>
 </tr>
 <tr class=xl77 height=15 style='height:11.25pt'>
  <td height=15 class=xl76 style='height:11.25pt'>DÀNH CHO NGÂN HÀNG (For Bank's Use only) MÃ VAT:</td>
  <td colspan=11 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl71 height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl88 style='height:4.5pt'>&nbsp;</td>
  <td colspan=11 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl92>&nbsp;</td>
 </tr>
 <tr class=xl94 height=17 style='height:12.75pt'>
  <td height=17 class=xl93 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='mso-ignore:colspan'></td>
  <td class=xl94 colspan=3 style='mso-ignore:colspan'>Thanh toán viên</td>
  <td class=xl94></td>
  <td colspan=2 class=xl104>Kiểm soát</td>
  <td class=xl94></td>
  <td class=xl94>Giám đốc</td>
  <td class=xl95>&nbsp;</td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=48 style='width:36pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    