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
        string p_Remark_ENG = "";
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
            p_Remark_ENG = dt.Rows[0][14].ToString();
        }
        
        string p_Amt = "";
        string p_Ccy = "";
        string Inword = "";
        DataTable dt_Amount = ESysLib.TableReadOpenCursor("acnt.rpt_sel_gfbr00030_1", p_Seq);
        if (dt_Amount.Rows.Count > 0)
        {
            p_Amt = dt_Amount.Rows[0][15].ToString();
            p_Ccy = dt_Amount.Rows[0][3].ToString();

            
                Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
            
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
<link rel=File-List href="UNC_PO_files/filelist.xml">
<link rel=Edit-Time-Data href="UNC_PO_files/editdata.mso">
<link rel=OLE-Object-Data href="UNC_PO_files/oledata.mso">
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
  <o:LastPrinted>2012-01-19T10:01:00Z</o:LastPrinted>
  <o:Created>2011-07-29T01:24:58Z</o:Created>
  <o:LastSaved>2012-01-19T10:06:18Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .36in .25in .42in;
	mso-header-margin:.24in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
.font0
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:7.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:7.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
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
.xl24
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
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
.xl32
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl45
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
.xl46
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
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl48
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
.xl49
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl50
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
.xl51
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
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
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
.xl54
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl55
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
.xl56
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style16;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style16;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl80
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
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>91</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
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
  </x:ExcelWorksheets>
  <x:WindowHeight>10995</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1196"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=728 style='border-collapse:
 collapse;table-layout:fixed;width:549pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:73'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <%
     for(int p=0;p<2;p++)
     {%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=10 style='height:15.0pt;width:8pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1193" type="#_x0000_t75" style='position:absolute;
   margin-left:6.75pt;margin-top:11.25pt;width:24.75pt;height:22.5pt;z-index:7'>
   <v:imagedata src="UNC_PO_files/image001.jpg" o:title="27559-Logo-Vietcombank_11"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1192" type="#_x0000_t75" style='position:absolute;
   margin-left:36pt;margin-top:15.75pt;width:114.75pt;height:14.25pt;z-index:6'>
   <v:imagedata src="UNC_PO_files/image002.jpg" o:title="27559-Logo-Vietcombank_11 - Copy"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:line id="_x0000_s1195" style='position:absolute;z-index:9'
   from="276pt,46.5pt" to="325.5pt,46.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:9px;margin-top:15px;width:426px;height:48px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=33></td>
    <td width=6></td>
    <td width=153></td>
    <td width=166></td>
    <td width=68></td>
   </tr>
   <tr>
    <td height=6></td>
    <td rowspan=3 align=left valign=top><img width=33 height=30
    src="UNC_PO_files/image003.jpg" v:shapes="_x0000_s1193"></td>
   </tr>
   <tr>
    <td height=19></td>
    <td></td>
    <td align=left valign=top><img width=153 height=19
    src="UNC_PO_files/image004.jpg" v:shapes="_x0000_s1192"></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=4></td>
    <td align=left valign=top><img width=68 height=2
    src="UNC_PO_files/image009.gif" v:shapes="_x0000_s1195"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=10 style='height:15.0pt;width:8pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl26 width=68 style='width:51pt'>&nbsp;</td>
  <td class=xl26 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl26 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=18 style='width:14pt'>&nbsp;</td>
  <td class=xl26 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl26 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl26 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl26 width=65 style='width:49pt'>&nbsp;</td>
  <td class=xl26 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl26 width=62 style='width:47pt'>&nbsp;</td>
  <td class=xl27 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl24 width=0></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=14 height=20 class=xl58 style='border-right:.5pt solid black;
  height:15.0pt'>ỦY NHIỆM CHI - <font class="font7">PAYMENT ORDER</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=14 height=30 class=xl61 style='border-right:.5pt solid black;
  height:22.5pt'>Ngày (<font class="font9">Date)</font><font class="font8">:<span
  style='mso-spacerun:yes'>  </span><%=p_Date %></font></td>
  <td class=xl24></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl29 style='height:3.75pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl33 style='height:9.0pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl35 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'>&nbsp;</td>
  <td class=xl38 colspan=5 style='mso-ignore:colspan'>ĐỀ NGHỊ GHI NỢ TÀI KHOẢN <font
  class="font12">(Please Debit account):</font></td>
  <td class=xl39></td>
  <td class=xl38 colspan=3 style='mso-ignore:colspan'>SỐ TIỀN<font
  class="font12"> (With amount):</font></td>
  <td class=xl39></td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>          </span>PHÍ NH<font class="font10"> </font><font
  class="font12">(Bank charges)</font></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl36 style='height:23.25pt'>&nbsp;</td>
  <td colspan=5 class=xl66 style='border-right:.5pt solid black'>SỐ TK <font
  class="font14">(A/C No)</font><font class="font13">:<span
  style='mso-spacerun:yes'>   </span></font><font class="font15"><%=p_D_Acc_No %></font></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'>BẰNG SỐ <font
  class="font14">(In figures)</font><font class="font13">:</font></td>
  <td colspan=2 class=xl69 style='border-right:.5pt solid black;text-align:right' ><span
  style='mso-spacerun:yes'>                  </span><%=p_Amt%></td>
  <td class=xl43><%=p_Ccy %></td>
  <td width=62 style='width:47pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_1" o:spid="_x0000_s1185" style='position:absolute;
   margin-left:46.5pt;margin-top:24.75pt;width:20.25pt;height:18pt;z-index:1;
   visibility:visible;v-text-anchor:middle' fillcolor="window" strokecolor="windowText"
   strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:center'><font class="font0"><span
    style='mso-spacerun:yes'> </span></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="Rectangle_x0020_2" o:spid="_x0000_s1186" style='position:absolute;
   margin-left:46.5pt;margin-top:6.75pt;width:20.25pt;height:18pt;z-index:2;
   visibility:visible;mso-wrap-style:tight;v-text-anchor:middle' fillcolor="window"
   strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:61px;margin-top:8px;width:29px;height:50px'><img
  width=29 height=50 src="UNC_PO_files/image005.gif" v:shapes="Rectangle_x0020_1 Rectangle_x0020_2"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl44 width=62 style='height:23.25pt;width:47pt'>Phí
    trong<font class="font13"><br>
        </font><font class="font14">Including</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=34 style='mso-height-source:userset;height:26.1pt'>
  <td height=34 class=xl36 style='height:26.1pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=306 style='border-right:.5pt solid black;
  width:230pt'>TÊN TK <font class="font14">(A/c name)</font><font class="font13">:<span
  style='mso-spacerun:yes'>   </span></font><font class="font19"><%=p_D_Acc_Nm %></font></td>
  <td class=xl46>&nbsp;</td>
  <td colspan=5 rowspan=3 class=xl71 width=295 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:222pt'>BẰNG CHỮ <font class="font14">(
  In words)</font><font class="font12">: </font><font class="font15"><%=Inword %></font></td>
  <td class=xl44 width=62 style='width:47pt'>Phí ngoài<font class="font13"><br>
    </font><font class="font14">Excludin</font><font class="font13">g</font></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl36 style='height:23.25pt'>&nbsp;</td>
  <td colspan=5 class=xl77 width=306 style='border-right:.5pt solid black;
  width:230pt'>ĐỊA CHỈ (Address):<span style='mso-spacerun:yes'>   </span><font
  class="font15"><%= p_D_Add%></font></td>
  <td class=xl47></td>
  <td class=xl35></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl36 style='height:12.95pt'>&nbsp;</td>
  <td colspan=5 rowspan=2 class=xl71 width=306 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:230pt'>TẠI NH<font class="font14"> (With
  bank)</font><font class="font13">:<span style='mso-spacerun:yes'>  </span></font><font
  class="font15"><span
  style='mso-spacerun:yes'> </span><%= p_D_Bank%></font></td>
  <td class=xl47></td>
  <td class=xl35></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl36 style='height:11.25pt'>&nbsp;</td>
  <td class=xl47></td>
  <td colspan=5 class=xl80>&nbsp;</td>
  <td class=xl35></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl28 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl48 style='height:24.0pt'>&nbsp;</td>
  <td colspan=5 class=xl81>&amp; GHI CÓ TÀI KHOẢN<font class="font10"> </font><font
  class="font12">(&amp; Credit account):</font></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1188"
   style='position:absolute;flip:y;z-index:3' from="14.25pt,24pt" to="281.25pt,24pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1190" style='position:absolute;z-index:5'
   from="120pt,12pt" to="281.25pt,12pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1189" style='position:absolute;z-index:4'
   from="13.5pt,36pt" to="280.5pt,36pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:17px;margin-top:15px;width:359px;height:34px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=1></td>
    <td width=141></td>
    <td width=216></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td colspan=2 align=left valign=top><img width=217 height=2
    src="UNC_PO_files/image006.gif" v:shapes="_x0000_s1190"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=358 height=2
    src="UNC_PO_files/image007.gif" v:shapes="_x0000_s1188"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=358 height=2
    src="UNC_PO_files/image007.gif" v:shapes="_x0000_s1189"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=32 class=xl28 width=18 style='height:24.0pt;width:14pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 rowspan=2 class=xl82 width=357 style='width:269pt'>NỘI DUNG<font
  class="font12"> (Details of Payment): </font><font class="font15"><%=p_Remark_ENG %> / <%= p_Remark%></font></td>
  <td class=xl49 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl36 style='height:19.5pt'>&nbsp;</td>
  <td colspan=5 class=xl83 style='border-right:.5pt solid black'>SỐ TK<font
  class="font14"> (A/C No):</font><font class="font10"><span
  style='mso-spacerun:yes'>  </span></font><font class="font15"><%= p_C_Acc_No%></font></td>
  <td class=xl35></td>
  <td class=xl49 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl36 style='height:22.5pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=306 style='border-right:.5pt solid black;
  width:230pt'>TÊN TK (A/c name):<span style='mso-spacerun:yes'>   </span><font
  class="font15"><%= p_C_Acc_Nm%></font></td>
  <td class=xl35></td>
  <td colspan=3 class=xl86 width=164 style='width:123pt'>KẾ TOÁN TRƯỞNG
  KÝ<br>
    <font class="font12">Chief accountant</font></td>
  <td colspan=4 class=xl86 width=230 style='border-right:.5pt solid black;
  width:174pt'>CHỦ TÀI KHOẢN KÝ VÀ ĐÓNG DẤU<br>
    <font class="font12">Acc. Holder &amp; Stamp</font></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl36 style='height:22.5pt'>&nbsp;</td>
  <td colspan=5 class=xl77 width=306 style='border-right:.5pt solid black;
  width:230pt'>ĐỊA CHỈ<font class="font14"> (Address):<span
  style='mso-spacerun:yes'>   </span></font><font class="font15"><%= p_C_Add%></font></td>
  <td class=xl35></td>
  <td colspan=3 class=xl88></td>
  <td colspan=4 class=xl88 style='border-right:.5pt solid black'></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl36 style='height:24.0pt'>&nbsp;</td>
  <td colspan=5 class=xl90 width=306 style='border-right:.5pt solid black;
  width:230pt'>TẠI NH (With bank):<span style='mso-spacerun:yes'>   </span><font
  class="font15"><%= p_C_Bank%></font></td>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl28 height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl48 style='height:6.75pt'>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl52 style='height:9.0pt'>&nbsp;</td>
  <td colspan=12 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl36 style='height:11.25pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1194"
   style='position:absolute;z-index:8' from="2.25pt,11.25pt" to="163.5pt,11.25pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:8;margin-left:2px;
  margin-top:14px;width:217px;height:2px'><img width=217 height=2
  src="UNC_PO_files/image008.gif" v:shapes="_x0000_s1194"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=15 class=xl37 width=48 style='height:11.25pt;width:36pt'>DÀNH
    CHO NGÂN HÀNG (<font class="font18">For Bank's Use only</font><font
    class="font11">)<span style='mso-spacerun:yes'>     </span>MÃ VAT:</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>&nbsp;</td>
  <td class=xl37></td>
  <td colspan=11 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl54 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl55 style='height:17.25pt'>&nbsp;</td>
  <td colspan=5 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl56 colspan=3 style='mso-ignore:colspan'>Thanh toán viên</td>
  <td colspan=2 class=xl93>Kiểm soát</td>
  <td class=xl56></td>
  <td class=xl56>Giám đốc</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl54></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr></tr>
 <tr></tr>
 <tr></tr>
 <tr></tr>
  <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=10 style='width:8pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=68 style='width:51pt'></td>
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
  <td width=37 style='width:28pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
