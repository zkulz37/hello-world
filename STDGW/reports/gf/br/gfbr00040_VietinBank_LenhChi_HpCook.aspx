<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
     ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        //p_So = dt.Rows[0][11].ToString();
		p_So = dt.Rows[0][29].ToString();
    }

    //string _str = "";
    //char[] _ch = p_C_Acc_No.ToCharArray();
    //for (int _j = 0; _j < _ch.Length; _j++)
    //    _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";

    //string _str_Dr = "";
    //char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    //for (int _k = 0; _k < _ch_Dr.Length; _k++)
    //    _str_Dr += _ch_Dr[_k] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][12].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();


        //string _ch_Amt = p_Amt.ToString();
        
        //int p = _ch_Amt.Length % 3;
        //if (p > 0)
        //{
        //    _str_Amt = _ch_Amt.Substring(0, p)+"     ";
        //}
        //int z = _ch_Amt.Length / 3;
        //int r;
        //for (r = 0; r < z; r++)
        //{
        //    _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
        //    p = p + 3;
        //}
        if (p_Ccy == "VND")
        {
            Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        }
        else
        {
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        }
        
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
<link rel=File-List
href="lenhchi_hpcook_files/filelist.xml">
<link rel=Edit-Time-Data
href="lenhchi_hpcook_files/editdata.mso">
<link rel=OLE-Object-Data
href="lenhchi_hpcook_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2012-10-09T07:25:49Z</o:LastPrinted>
  <o:Created>2012-01-12T09:28:17Z</o:Created>
  <o:LastSaved>2012-10-09T08:10:59Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.19in .25in .25in .25in;
	mso-header-margin:.19in;
	mso-footer-margin:.25in;}
.font5
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#333333;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:#333333;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:#333333;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:gray;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:#333333;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font22
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font25
	{color:#333333;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font26
	{color:#333333;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font27
	{color:red;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font28
	{color:gray;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font30
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font31
	{color:windowtext;
	font-size:10.0pt;
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
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl29
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:blue;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"\.VnArial", sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:blue;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:blue;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	color:blue;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:#333333;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:#333333;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	color:#333333;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl58
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl59
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl60
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:red;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:red;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	color:#FF9900;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	background:blue;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:blue;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl91
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Lenh chi</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet9</x:CodeName>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>32</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>-1215</x:WindowTopX>
  <x:WindowTopY>1350</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1100"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=790 style='border-collapse:
 collapse;table-layout:fixed;width:599pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:2848;
 width:67pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2240;
 width:53pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1024;
 width:24pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:384;
 width:9pt'>
 <col class=xl24 width=21 span=11 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:704;
 width:17pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:672;
 width:16pt'>
 <col class=xl24 width=20 style='mso-width-source:userset;mso-width-alt:640;
 width:15pt'>
 <col class=xl24 width=21 span=4 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=11 style='mso-width-source:userset;mso-width-alt:352;
 width:8pt'>
 <col class=xl24 width=21 span=3 style='mso-width-source:userset;mso-width-alt:
 672;width:16pt'>
 <col class=xl24 width=26 span=2 style='mso-width-source:userset;mso-width-alt:
 832;width:20pt'>
 <col class=xl24 width=5 style='mso-width-source:userset;mso-width-alt:160;
 width:4pt'>
 <col class=xl24 width=72 style='width:54pt'>
 <col class=xl24 width=3 span=2 style='mso-width-source:userset;mso-width-alt:
 96;width:2pt'>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl30 colspan=8 width=287 style='height:18.0pt;mso-ignore:
  colspan;width:217pt'><a name="RANGE!A1">Ngân Hàng TMCP Công Thương Việt Nam</a></td>
  <td class=xl32 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl32 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=22 style='width:17pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=20 style='width:15pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl34 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl35 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=11 style='width:8pt'>&nbsp;</td>
  <td width=21 style='width:16pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1099" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:2.25pt;width:129pt;
   height:36.75pt;z-index:20;visibility:visible'>
   <v:imagedata src="lenhchi_hpcook_files/image001.png"
    o:title=""/>
   <o:lock v:ext="edit" aspectratio="f"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:20;margin-left:0px;margin-top:3px;width:172px;
  height:49px'><img width=172 height=49
  src="lenhchi_hpcook_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl33 width=21 style='height:18.0pt;width:16pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=21 style='width:16pt'>&nbsp;</td>
  <td class=xl33 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl33 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl33 width=5 style='width:4pt'>&nbsp;</td>
  <td class=xl36 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=30 height=34 class=xl37 style='border-right:.5pt solid black;
  height:25.5pt'>Lệnh Chi</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=30 height=21 class=xl40 style='border-right:.5pt solid black;
  height:15.75pt'>Payment Order</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'>&nbsp;</td>
  <td colspan=5 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl46></td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>Số<font class="font14"> </font><font
  class="font15">No: </font><font class="font16"><%=p_So %></font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=8 style='mso-ignore:colspan'>Ngày<font class="font17">
  </font><font class="font15">Date:<span style='mso-spacerun:yes'>  </span></font><font
  class="font18"><%=p_Date%>/<%=p_Month%>/<%=p_Year %></font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl48 style='height:15.75pt'>&nbsp;</td>
  <td colspan=21 class=xl49 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl50 colspan=6 style='mso-ignore:colspan'>Liên <font class="font14"><span
  style='mso-spacerun:yes'>       </span>Copy<span
  style='mso-spacerun:yes'>  </span></font></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl52 style='height:18.75pt'>Tên đơn vị trả <span
  style='display:none'>tiền<font class="font17"> </font><font class="font15">Payer:<span
  style='mso-spacerun:yes'>   </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1057"
   style='position:absolute;z-index:11' from="51.75pt,14.25pt" to="520.5pt,14.25pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:11;margin-left:68px;margin-top:18px;width:627px;height:2px'><img
  width=627 height=2
  src="lenhchi_hpcook_files/image003.gif" v:shapes="_x0000_s1057"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl53 width=70 style='height:18.75pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=28 class=xl54 style='border-right:.5pt solid black'><%=p_D_Acc_Nm%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl56 style='height:15.75pt'>Tài khoản nợ<font
  class="font14"> </font><span style='display:none'><font class="font15">Debit
  A/C</font><font class="font14">:<span style='mso-spacerun:yes'> 
  </span><%=p_D_Acc_No %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1058"
   style='position:absolute;z-index:12' from="46.5pt,13.5pt" to="322.5pt,13.5pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:12;margin-left:61px;margin-top:17px;width:370px;height:2px'><img
  width=370 height=2
  src="lenhchi_hpcook_files/image004.gif" v:shapes="_x0000_s1058"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl57 width=70 style='height:15.75pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl58></td>
  <td colspan=15 class=xl59 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1059" style='position:absolute;z-index:13' from="113.25pt,15pt"
   to="387.75pt,15pt" strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1028" style='position:absolute;flip:y;z-index:2'
   from="415.5pt,52.5pt" to="585.75pt,52.5pt" strokecolor="gray [23]"
   strokeweight="6pt" o:insetmode="auto"/><v:line id="_x0000_s1029" style='position:absolute;
   z-index:3' from="417.75pt,4.5pt" to="417.75pt,49.5pt" strokecolor="gray [23]"
   strokeweight="4.5pt" o:insetmode="auto"/><v:line id="_x0000_s1061" style='position:absolute;
   z-index:15' from="3.75pt,47.25pt" to="387.75pt,47.25pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1060" style='position:absolute;z-index:14'
   from="151.5pt,31.5pt" to="387.75pt,31.5pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1062" style='position:absolute;z-index:16'
   from="133.5pt,66.75pt" to="587.25pt,66.75pt" strokecolor="gray [23]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:13;margin-left:4px;margin-top:3px;width:781px;height:87px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=146></td>
    <td width=27></td>
    <td width=24></td>
    <td width=317></td>
    <td width=32></td>
    <td width=234></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=16></td>
    <td colspan=5></td>
    <td colspan=2 rowspan=7 align=left valign=top><img width=235 height=71
    src="lenhchi_hpcook_files/image005.gif" v:shapes="_x0000_s1028 _x0000_s1029"></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=368 height=2
    src="lenhchi_hpcook_files/image006.gif" v:shapes="_x0000_s1059"></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3></td>
    <td align=left valign=top><img width=317 height=2
    src="lenhchi_hpcook_files/image007.gif" v:shapes="_x0000_s1060"></td>
   </tr>
   <tr>
    <td height=19></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=4 align=left valign=top><img width=514 height=2
    src="lenhchi_hpcook_files/image008.gif" v:shapes="_x0000_s1061"></td>
   </tr>
   <tr>
    <td height=10></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td colspan=4 align=left valign=top><img width=607 height=2
    src="lenhchi_hpcook_files/image009.gif" v:shapes="_x0000_s1062"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl61 width=89 style='height:17.25pt;width:67pt'>Tại
    ngân hàng<font class="font22"> </font><font class="font15">With bank:<span
    style='mso-spacerun:yes'>  </span></font><font class="font14"><%=p_D_Bank%></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td colspan=15 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl63 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl64 style='border-right:.5pt solid black'>Số tiền bằng
  số <font class="font18">Amount in figures</font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=18 rowspan=2 height=43 class=xl66 width=497 style='height:32.25pt;
  width:377pt'>Số tiền bằng chữ <font class="font15">Amount in words:<span
  style='mso-spacerun:yes'>   </span></font><font class="font14"><%=Inword%></font></td>
  <td class=xl68></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=8 rowspan=2 class=xl29 ><span
  style='mso-spacerun:yes'>        </span><%=p_Amt%></td>
  <td rowspan=2 class=xl69><%=p_Ccy %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl70 colspan=13 style='height:22.5pt;mso-ignore:colspan'>Tên
  đơn vị nhận tiền<font class="font15"> Receiver: </font><font class="font25"><span
  style='mso-spacerun:yes'> </span></font><font class="font26"><%=p_C_Acc_Nm %><span style='mso-spacerun:yes'>  </span></font></td>
  <td colspan=6 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl61 style='height:15.75pt'>Tài khoản có<font
  class="font14"> </font><span style='display:none'><font class="font16">Credit/
  </font><font class="font15">AC:<span style='mso-spacerun:yes'>  </span></font><font
  class="font5"><%=p_C_Acc_No %><span style='mso-spacerun:yes'>     </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1063"
   style='position:absolute;z-index:17' from="48pt,13.5pt" to="521.25pt,13.5pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:17;margin-left:63px;margin-top:17px;width:633px;height:2px'><img
  width=633 height=2
  src="lenhchi_hpcook_files/image010.gif" v:shapes="_x0000_s1063"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=70 style='height:15.75pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl58></td>
  <td class=xl24></td>
  <td colspan=24 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl73 style='height:18.0pt'>Tại ngân hàng<font
  class="font14"> </font><span style='display:none'><font class="font15">With
  bank:</font><font class="font14"><span style='mso-spacerun:yes'>  
  </span><%=p_C_Bank %><span style='mso-spacerun:yes'> </span></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1064"
   style='position:absolute;z-index:18' from="47.25pt,15pt" to="520.5pt,15pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:18;margin-left:62px;margin-top:19px;width:633px;height:2px'><img
  width=633 height=2
  src="lenhchi_hpcook_files/image010.gif" v:shapes="_x0000_s1064"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl74 width=70 style='height:18.0pt;width:53pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl58 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=30 height=23 class=xl75 width=784 style='border-right:.5pt solid black;
  height:17.25pt;width:595pt'><!--[if gte vml 1]><v:line id="_x0000_s1065"
   style='position:absolute;z-index:19' from="87pt,14.25pt" to="587.25pt,14.25pt"
   strokecolor="gray [23]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:19;margin-left:115px;margin-top:18px;width:669px;height:
  2px'><img width=669 height=2
  src="lenhchi_hpcook_files/image011.gif" v:shapes="_x0000_s1065"></span><![endif]>Nội
  dung<font class="font28"> </font><font class="font15">Remarks:<span
  style='mso-spacerun:yes'>    </span></font><font class="font14"><%=p_Remark %></font></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl61 style='height:8.25pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=20 class=xl78 style='mso-ignore:colspan'></td>
  <td width=21 style='width:16pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1027" style='position:absolute;flip:y;z-index:1' from="12.75pt,7.5pt"
   to="23.25pt,13.5pt" strokecolor="white [9]" strokeweight="2.25pt"
   o:insetmode="auto"/><v:line id="_x0000_s1030" style='position:absolute;
   z-index:4' from="15.75pt,10.5pt" to="15.75pt,10.5pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:15px;margin-top:8px;width:18px;
  height:12px'><img width=18 height=12
  src="lenhchi_hpcook_files/image012.gif" v:shapes="_x0000_s1027 _x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=11 class=xl78 width=21 style='height:8.25pt;width:16pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl79 width=72 style='width:54pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl80 style='height:4.5pt'>&nbsp;</td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=21 class=xl82 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl83 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl84 width=72 style='width:54pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl85 colspan=2 style='height:16.5pt;mso-ignore:colspan'>Đơn
  vị trả tiền<font class="font30"> </font><font class="font31">Payer</font></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=16 style='mso-ignore:colspan'>Ngày hạch toán <font
  class="font31">Accounting date ..…/…../……</font></td>
  <td class=xl27></td>
  <td class=xl86>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl87 colspan=3 style='height:18.75pt;mso-ignore:colspan'>Kế
  toán<font class="font5"> </font><font class="font22">Accountant</font></td>
  <td class=xl28 colspan=9 style='mso-ignore:colspan'>Chủ tài khoản<font
  class="font5"> A</font><font class="font22">/c holder</font></td>
  <td class=xl28 colspan=7 style='mso-ignore:colspan'>Giao dịch viên<font
  class="font5"> </font><font class="font22">Teller</font></td>
  <td class=xl28 colspan=11 style='mso-ignore:colspan;border-right:.5pt solid black'>Kiểm
  soát viên<font class="font5"> </font><font class="font22">Supervisor</font></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl87 style='height:10.5pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl87 style='height:10.5pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl87 style='height:15.75pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl87 style='height:15.75pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl87 style='height:15.75pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl87 style='height:15.75pt'>&nbsp;</td>
  <td colspan=28 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl89 style='height:18.75pt'>&nbsp;</td>
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
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td colspan=2 rowspan=2 height=46 class=xl28 width=6 style='mso-ignore:colspan-rowspan;
  height:34.5pt;width:4pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1033" type="#_x0000_t202"
   href="#RANGE!A1" style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;
   width:0;height:0;z-index:5;visibility:visible;mso-wrap-style:tight'
   o:button="t" fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1036" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:6;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:7;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:8;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1045" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:9;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1048" type="#_x0000_t202" href="#RANGE!A1"
   style='position:absolute;margin-left:2.25pt;margin-top:18.75pt;width:0;
   height:0;z-index:10;visibility:visible;mso-wrap-style:tight' o:button="t"
   fillcolor="#cf3" strokecolor="blue [12]" o:insetmode="auto">
   <v:fill o:detectmouseclick="t"/>
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font27">TRỞ LẠI</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=24></td>
   </tr>
   <tr>
    <td></td>
    <td><map name=MicrosoftOfficeMap0><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"><area shape=Rect
    coords="0, 0, 2, 2" href="#RANGE!A1"></map><img border=0 width=2 height=2
    src="lenhchi_hpcook_files/image013.gif"
    usemap="#MicrosoftOfficeMap0" v:shapes="_x0000_s1033 _x0000_s1036 _x0000_s1039 _x0000_s1042 _x0000_s1045 _x0000_s1048"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:4.5pt;height:34.5pt'></span><![endif]--></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=30 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=11 style='width:8pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=3 style='width:2pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
