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
        p_Date = dt.Rows[0][10].ToString();
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
        p_So = dt.Rows[0][11].ToString();
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Cr = "";
    char[] _ch_Cr = p_C_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Cr.Length; _k++)
    {
        _str_Cr += _ch_Cr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        string _ch_Amt = p_Amt.ToString();

        int p = _ch_Amt.Length % 3;
        
        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p) + "     ";
        }
        
        int z = _ch_Amt.Length / 3;
        int r;
        for (r = 0; r < z; r++)
        {
            _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
            p = p + 3;
            
        }
        
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        //}
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt1);
        //Response.End();
        //p_Ccy = "USD";
        //p_Amt1 = "123456789012.34";
        //p_D_Acc_No = "3456789012";
        //Response.Write(p_Amt1[p_Amt1.Length - 11]);
        //Response.End();
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="KEB_files/filelist.xml">
<link rel=Edit-Time-Data href="KEB_files/editdata.mso">
<link rel=OLE-Object-Data href="KEB_files/oledata.mso">
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
  <o:LastPrinted>2012-01-16T03:18:14Z</o:LastPrinted>
  <o:Created>2012-01-13T09:55:18Z</o:Created>
  <o:LastSaved>2012-01-16T03:47:23Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.26in .5in .22in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.23in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
	mso-font-charset:0;}
.font9
	{color:red;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:22.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Batang, serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:Batang, serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
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
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Batang, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
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
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
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
.xl47
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:10.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
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
  
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
       <x:RangeSelection>$E$12:$F$14</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column Q</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1022 style='border-collapse:
 collapse;table-layout:fixed;width:763pt'>
 <col class=xl27 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl27 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl27 width=141 style='mso-width-source:userset;mso-width-alt:5156;
 width:106pt'>
 <col class=xl27 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl27 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl27 width=25 span=2 style='mso-width-source:userset;mso-width-alt:
 914;width:19pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=23 span=14 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 width=73 style='height:12.75pt;width:55pt'></td>
  <td class=xl27 width=67 style='width:50pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=79 style='width:59pt'></td>
  <td class=xl27 width=80 style='width:60pt'></td>
  <td class=xl27 width=141 style='width:106pt'></td>
  <td class=xl27 width=15 style='width:11pt'></td>
  <td class=xl27 width=52 style='width:39pt'></td>
  <td class=xl27 width=25 style='width:19pt'></td>
  <td class=xl27 width=25 style='width:19pt'></td>
  <td class=xl27 width=79 style='width:59pt'></td>
  <td class=xl27 width=23 style='width:17pt'></td>
  <td class=xl27 width=23 style='width:17pt'></td>
  <td colspan=11 rowspan=2 class=xl56 width=253 style='width:187pt'>A combined
  use for domestic/overseas</td>
  <td class=xl27 width=23 style='width:17pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=25 height=34 class=xl57 style='height:25.5pt'>Application for
  Bank Transfer ( Fax)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=18 class=xl27 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl28 colspan=6 style='mso-ignore:colspan'>Date : <font class="font9"><%=p_Date %></font></td>
  <td class=xl27></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=3 style='height:14.25pt;mso-ignore:colspan'>To
  KEB Hanoi Branch</td>
  <td colspan=22 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=11 style='height:14.25pt;mso-ignore:colspan'>Please
  transfer money as below mentioned on the basis of the agreement for
  transactions by fax.</td>
  <td colspan=14 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 colspan=4 style='height:20.25pt;mso-ignore:colspan'
  >[From]</td>
  <td class=xl36>[To]</td>
  <td colspan=20 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:55.0pt'>
  <td rowspan=6 height=48 class=xl38 width=73 style='height:36.0pt;width:55pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1036" style='position:absolute;margin-left:0;margin-top:105.75pt;
   width:0;height:27pt;z-index:2;mso-wrap-style:tight' filled="f" stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1036'>
    <div style='text-align:left'><font class="font15">&nbsp;</font></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1035" style='position:absolute;margin-left:0;
   margin-top:102pt;width:0;height:30.75pt;z-index:3;mso-wrap-style:tight'
   filled="f" stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1035'>
    <div style='text-align:left'><font class="font15">,</font><font
    class="font7"><br>
        </font><font class="font15">&nbsp;</font></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1034" style='position:absolute;margin-left:0;
   margin-top:102.75pt;width:0;height:30pt;z-index:4;mso-wrap-style:tight'
   filled="f" stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1034'>
    <div style='text-align:left'><font class="font15">,</font></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1037" style='position:absolute;margin-left:0;
   margin-top:101.25pt;width:0;height:31.5pt;z-index:5;mso-wrap-style:tight'
   filled="f" stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1037'>
    <div style='text-align:left'><font class="font15">,</font></div>
   </v:textbox>
  </v:rect><![endif]-->Applicant</td>
  <td class=xl26 width=67 style='border-left:none;width:50pt'>Name</td>
  <td colspan=4 class=xl42 width=364 style='border-left:none;width:273pt;font-size:12.0pt'><%=p_D_Acc_Nm %></td>
  <td class=xl34></td>
  <td colspan=2 rowspan=3 class=xl50 width=77 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:58pt'>Beneficiary</td>
  <td colspan=2 class=xl64 style='border-left:none'>Bank Name</td>
  <td colspan=14 class=xl42 width=322 style='border-left:none;width:238pt;font-size:12.0pt'><%=p_C_Bank %></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl32 width=67 style='height:39.0pt;border-top:none;
  border-left:none;width:50pt'>Account Number</td>
  <td colspan=3 class=xl39 width=223 style='border-left:none;width:167pt'><%=p_D_Acc_No %></td>
  <td class=xl33 width=141 style='border-top:none;border-left:none;width:106pt'>Secret
  No: </td>
  <td class=xl34></td>
  <td colspan=2 class=xl26 width=104 style='border-left:none;width:78pt'>Beneficiary’s
  Name</td>
  <td colspan=14 class=xl73 style='border-right:.5pt solid black;border-left:
  none;white-space:normal;font-size:12.0pt'><%=p_C_Acc_Nm %></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=4 height=153 class=xl26 width=67 style='height:114.75pt;
  width:50pt'>Signature &amp; Seal</td>
  <td colspan=2 class=xl40 width=143 style='border-right:.5pt solid black;
  border-left:none;width:107pt'>Signature</td>
  <td colspan=2 class=xl26 width=221 style='border-left:none;width:166pt'>Seal</td>
  <td class=xl34></td>
  <td colspan=2 class=xl65 width=104 style='border-left:none;width:78pt'>Account
  No.</td>
  <td colspan=14 class=xl42 width=322 style='border-left:none;width:238pt'><%=_str_Cr%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:20.0pt'>
  <td colspan=2 rowspan=3 height=121 class=xl43 width=143 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:90.75pt;width:107pt'>&nbsp;</td>
  <td colspan=2 rowspan=3 class=xl43 width=221 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:166pt'>&nbsp;</td>
  <td rowspan=3 class=xl55 width=15 style='width:11pt'></td>
  <td colspan=2 rowspan=3 class=xl58 width=77 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:58pt'>Amount</td>
  <td colspan=2 rowspan=2 class=xl26 width=104 style='width:78pt'>In Figures</td>
  <%if (p_Ccy == "VND")
    { %>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 12)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 11)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1046" type="#_x0000_t75" style='position:absolute;
   margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;height:5.25pt;z-index:9'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:9;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if (p_Amt1.Length >= 10)
                                   {%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 9)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 8)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1045" type="#_x0000_t75"
   style='position:absolute;margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;
   height:5.25pt;z-index:8'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:8;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1045"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if (p_Amt1.Length >= 7)
                                   {%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 6)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 5)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1044" type="#_x0000_t75"
   style='position:absolute;margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;
   height:5.25pt;z-index:7'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if (p_Amt1.Length >= 4)
                                   {%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 3)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 3]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 2)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if (p_Amt1.Length >= 1)
                                                                          {%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></td>
  <td class=xl25 width=23 style='border-top:none;border-left:none;width:17pt;text-align:center'></td>
  <td class=xl25 width=23 style='border-top:none;border-left:none;width:17pt;text-align:center'></td>
  <%}
    else
    { %>
        <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=15 ){%><%=p_Amt1[p_Amt1.Length - 15]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=14 ){%><%=p_Amt1[p_Amt1.Length - 14]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1046" type="#_x0000_t75" style='position:absolute;
   margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;height:5.25pt;z-index:9'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:9;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if(p_Amt1.Length >=13 ){%><%=p_Amt1[p_Amt1.Length - 13]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=12 ){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=11 ){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1045" type="#_x0000_t75"
   style='position:absolute;margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;
   height:5.25pt;z-index:8'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:8;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1045"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if(p_Amt1.Length >=10 ){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=9 ){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=8 ){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></td>
  <td rowspan=2 height=45 width=23 style='height:33.75pt;width:17pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1044" type="#_x0000_t75"
   style='position:absolute;margin-left:15.75pt;margin-top:31.5pt;width:3.75pt;
   height:5.25pt;z-index:7'>
   <v:imagedata src="KEB_files/image001.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:21px;margin-top:42px;width:5px;
  height:7px'><img width=5 height=7 src="KEB_files/image002.gif" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=45 class=xl69 width=23 style='height:33.75pt;
    border-top:none;width:17pt' ><%if(p_Amt1.Length >=7 ){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=6 ){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=5 ){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></td>
  <td rowspan=2 class=xl69 width=23 style='border-top:none;width:17pt' ><%if(p_Amt1.Length >=4 ){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></td>
  <td class=xl25 width=23 style='border-top:none;border-left:none;width:17pt;text-align:center'><%if(p_Amt1.Length >=2 ){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></td>
  <td class=xl25 width=23 style='border-top:none;border-left:none;width:17pt;text-align:center'><%if(p_Amt1.Length >=1 ){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></td>
  <%} %>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl71 width=46 style='border-right:.5pt solid black;
  height:17.25pt;border-left:none;width:34pt'><%=p_Ccy %></td>
 </tr>
 <tr height=76 style='mso-height-source:userset;height:57.0pt'>
  <td colspan=16 height=76 class=xl66 width=426 style='border-right:.5pt solid black;
  height:57.0pt;border-left:none;width:316pt;border-left:.5pt solid black'>In Words:<font class="font12">
  <%=Inword %>.</font></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'></td>
  <td colspan=24 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl29 style='height:21.0pt'></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=5 class=xl37 width=50 style='width:38pt'>For<br>
    Bank<br>
    </td>
  <td colspan=3 class=xl76 style='border-left:none'>Prepared</td>
  <td colspan=5 class=xl76 style='border-left:none'>1<font class="font19"><sup>st</sup></font><font
  class="font17"> Manager</font></td>
  <td colspan=5 class=xl76 style='border-left:none'>2<font class="font19"><sup>nd</sup></font><font
  class="font17"> Manager</font></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt'></td>
  <td colspan=5 rowspan=2 class=xl49 width=431 style='width:323pt'>Remarks: <%=p_Remark %></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 rowspan=4 class=xl37 width=125 style='width:93pt'>&nbsp;</td>
  <td colspan=5 rowspan=4 class=xl77>&nbsp;</td>
  <td colspan=5 rowspan=4 class=xl78>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 style='height:23.25pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_1" o:spid="_x0000_s1040" type="#_x0000_t75" alt="CI"
   style='position:absolute;margin-left:51pt;margin-top:21pt;width:110.25pt;
   height:51.75pt;z-index:6;visibility:visible'>
   <v:imagedata src="KEB_files/image003.png" o:title="CI"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:68px;margin-top:28px;width:147px;
  height:69px'><img width=147 height=69 src="KEB_files/image004.jpg" alt=CI
  v:shapes="Picture_x0020_1"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl30 width=73 style='height:23.25pt;width:55pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl30 style='height:27.0pt'></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td colspan=24 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'></td>
  <td colspan=24 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1029" style='position:absolute;margin-left:0;margin-top:12pt;
   width:15pt;height:20.25pt;z-index:1;mso-wrap-style:none' stroked="f">
   <v:textbox style='mso-next-textbox:#_x0000_s1029;mso-fit-shape-to-text:t'/>
   <x:ClientData ObjectType="Rect">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:0px;margin-top:16px;width:20px;height:27px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=27 align=left valign=top bgcolor=white
    style='vertical-align:top;background:white'><![endif]>
    <div v:shape="_x0000_s1029" style='padding:3.6pt 7.2pt 3.6pt 7.2pt;
    text-align:left' class=shape></div>
    <![if !vml]></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl27 width=73 style='height:12.75pt;width:55pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=24 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=25 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=73 style='width:55pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
