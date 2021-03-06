﻿<%@ Page Language="C#"%>
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
        p_So = dt.Rows[0][11].ToString();
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Dr = "";
    char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Dr.Length; _k++)
    {
        _str_Dr += _ch_Dr[_k] ;
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
        
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt);
        //Response.End();
        //p_Ccy = "USD";
        //p_Amt1 = "1600.00";
        //p_D_Acc_No = "3456789012";
        //Response.Write(p_Amt1[p_Amt1.Length - 11]);
        //Response.End();
        p_D_Acc_No = p_D_Acc_No.Replace("-", "");
        p_D_Acc_No = p_D_Acc_No.Replace(".", "");
        p_D_Acc_No = p_D_Acc_No.Replace(" ", "");
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Wooribank_PRT_new_files/filelist.xml">
<link rel=Edit-Time-Data href="Wooribank_PRT_new_files/editdata.mso">
<link rel=OLE-Object-Data href="Wooribank_PRT_new_files/oledata.mso">
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
  <o:LastPrinted>2012-01-05T09:31:01Z</o:LastPrinted>
  <o:Created>2012-01-03T03:53:38Z</o:Created>
  <o:LastSaved>2012-01-05T10:03:05Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .5in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font10
	{color:#3366FF;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
	mso-font-charset:0;}
.font11
	{color:#3366FF;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
	mso-font-charset:0;}
.font12
	{color:#3366FF;
	font-size:7.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
	mso-font-charset:0;}
.font13
	{color:#3366FF;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:#3366FF;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:#3366FF;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font25
	{color:#3366FF;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Batang, serif;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl28
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
.xl29
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #3366FF;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:8.0pt;
	font-family:Batang, serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl44
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl46
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #3366FF;}
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl49
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #3366FF;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:.5pt solid #3366FF;}
.xl55
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:.5pt solid #3366FF;}
.xl56
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl62
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl64
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:22.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:17.0pt;
	font-family:Batang, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl66
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:17.0pt;
	font-family:Batang, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #3366FF;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;}
.xl72
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:none;
	border-bottom:.5pt solid #3366FF;
	border-left:.5pt solid #3366FF;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #3366FF;
	border-right:.5pt solid #3366FF;
	border-bottom:.5pt solid #3366FF;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
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
      
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6465</x:WindowHeight>
  <x:WindowWidth>12435</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=886 style='border-collapse:
 collapse;table-layout:fixed;width:666pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <col class=xl24 width=135 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col class=xl24 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=110 span=3 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=8 height=40 class=xl61 width=526 style='border-right:.5pt solid #3366FF;
  height:30.0pt;width:394pt'>WITHDRAWAL</td>
  <td class=xl51 width=110 style='border-left:none;width:83pt'>Prepared<br>Người lập</td>
  <td class=xl52 width=110 style='width:83pt'>Entered<br>Người vào máy</td>
  <td class=xl52 width=110 style='width:83pt'>Approved<br>Người kiểm tra</td>
  <td class=xl24 width=30 style='width:23pt'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=8 height=37 class=xl63 style='border-right:.5pt solid #3366FF;
  height:27.75pt'>PHIẾU RÚT TIỀN</td>
  <td rowspan=2 class=xl54 style='border-top:none'>&nbsp;</td>
  <td rowspan=2 class=xl54 style='border-top:none'>&nbsp;</td>
  <td rowspan=2 class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=8 height=33 class=xl65 style='border-right:.5pt solid #3366FF;
  height:24.75pt'>(출금 및 국내송금)</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt'>Account No.</td>
  <td class=xl41></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1025"
   style='position:absolute;margin-left:12pt;margin-top:8.25pt;width:20.25pt;
   height:25.5pt;z-index:1;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1026" style='position:absolute;margin-left:52.5pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:2;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1027" style='position:absolute;margin-left:93pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:3;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1028" style='position:absolute;margin-left:153.75pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:4;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1029" style='position:absolute;margin-left:133.5pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:5;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1030" style='position:absolute;margin-left:214.5pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:6;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1031" style='position:absolute;margin-left:234.75pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:7;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1032" style='position:absolute;margin-left:194.25pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:8;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1033" style='position:absolute;margin-left:32.25pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:9;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1034" style='position:absolute;margin-left:72.75pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:10;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1035" style='position:absolute;margin-left:174pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1036" style='position:absolute;margin-left:113.25pt;
   margin-top:8.25pt;width:20.25pt;height:25.5pt;z-index:12;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  
  <%if(p_Ccy=="VND"){ %>
 <v:rect id="_x0000_s1037" style='position:absolute;margin-left:12pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:13;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:32.25pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:15;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:52.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:16;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1038" style='position:absolute;margin-left:76.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:14;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:96.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:117pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1041" style='position:absolute;margin-left:141pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:17;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:161.25pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;margin-left:181.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:24;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1045" style='position:absolute;margin-left:225.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:21;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:205.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:23;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=3){%><%=p_Amt1[p_Amt1.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;margin-left:246pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:25;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;margin-left:273.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:22;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7">0</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1052" style='position:absolute;margin-left:294pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:26;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7">0</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%}else{ %>
   <v:rect id="_x0000_s1037" style='position:absolute;margin-left:12pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:13;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=15 ){%><%=p_Amt1[p_Amt1.Length - 15]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:32.25pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:15;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=14 ){%><%=p_Amt1[p_Amt1.Length - 14]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:52.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:16;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=13 ){%><%=p_Amt1[p_Amt1.Length - 13]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1038" style='position:absolute;margin-left:76.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:14;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=12 ){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:96.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=11 ){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:117pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=10 ){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1041" style='position:absolute;margin-left:141pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:17;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=9 ){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:161.25pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=8 ){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;margin-left:181.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:24;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=7 ){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1045" style='position:absolute;margin-left:225.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:21;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=5 ){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:205.5pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:23;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=6 ){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;margin-left:246pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:25;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=4 ){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;margin-left:273.75pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:22;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=2 ){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1052" style='position:absolute;margin-left:294pt;
   margin-top:40.5pt;width:20.25pt;height:25.5pt;z-index:26;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:4.5pt'><font class="font7"><%if(p_Amt1.Length >=1 ){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect>
  <%} %>
  <![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:15px;margin-top:10px;width:405px;height:79px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=83></td>
    <td width=3></td>
    <td width=83></td>
    <td width=3></td>
    <td width=83></td>
    <td width=3></td>
    <td width=68></td>
    <td width=15></td>
    <td width=8></td>
    <td width=56></td>
   </tr>
   <tr>
    <td height=36></td>
    <td colspan=7 align=left valign=top><img width=326 height=36
    src="Wooribank_PRT_new_files/image001.gif" v:shapes="_x0000_s1025 _x0000_s1026 _x0000_s1027 _x0000_s1028 _x0000_s1029 _x0000_s1030 _x0000_s1031 _x0000_s1032 _x0000_s1033 _x0000_s1034 _x0000_s1035 _x0000_s1036"></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
   <tr>
    <td height=36></td>
    <td align=left valign=top><img width=83 height=36
    src="Wooribank_PRT_new_files/image002.gif" v:shapes="_x0000_s1037 _x0000_s1039 _x0000_s1040"></td>
    <td></td>
    <td align=left valign=top><img width=83 height=36
    src="Wooribank_PRT_new_files/image003.gif" v:shapes="_x0000_s1038 _x0000_s1042 _x0000_s1043"></td>
    <td></td>
    <td align=left valign=top><img width=83 height=36
    src="Wooribank_PRT_new_files/image004.gif" v:shapes="_x0000_s1041 _x0000_s1044 _x0000_s1048"></td>
    <td></td>
    <td colspan=2 align=left valign=top><img width=83 height=36
    src="Wooribank_PRT_new_files/image005.gif" v:shapes="_x0000_s1045 _x0000_s1047 _x0000_s1051"></td>
    <td></td>
    <td align=left valign=top><img width=56 height=36
    src="Wooribank_PRT_new_files/image006.gif" v:shapes="_x0000_s1046 _x0000_s1052"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl41 width=64 style='height:12.75pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt'>Số tài khoản</td>
  <td colspan=8 class=xl41 style='mso-ignore:colspan'></td>
  <td rowspan=3 height=55 width=110 style='height:41.25pt;width:83pt'
  align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1054" style='position:absolute;
   margin-left:139.5pt;margin-top:11.25pt;width:25.5pt;height:25.5pt;z-index:27;
   mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1058" style='position:absolute;margin-left:63pt;
   margin-top:11.25pt;width:25.5pt;height:25.5pt;z-index:28;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1059" style='position:absolute;margin-left:114pt;
   margin-top:11.25pt;width:25.5pt;height:25.5pt;z-index:29;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1060" style='position:absolute;margin-left:88.5pt;
   margin-top:11.25pt;width:25.5pt;height:25.5pt;z-index:30;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:27;margin-left:83px;margin-top:14px;width:138px;height:36px'><img
  width=138 height=36 src="Wooribank_PRT_new_files/image007.gif" v:shapes="_x0000_s1054 _x0000_s1058 _x0000_s1059 _x0000_s1060"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=3 height=55 class=xl79 width=110 style='height:41.25pt;
    width:83pt'>Security no.<span style='mso-spacerun:yes'>              
    </span>Số bí mật. <font class="font11">(비밀번호)</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'>(계좌번호)</td>
  <td colspan=8 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl49 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Amount
  (In figures)</td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44 x:str="            "><span
  style='mso-spacerun:yes'>            </span></td>
  <td class=xl41></td>
  <td class=xl45></td>
  <td class=xl41></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl48 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Số
  tiền bằng số</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl28>l</td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt'>(금액)</td>
  <td class=xl27></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 colspan=2 style='height:15.0pt;mso-ignore:colspan'>In
  Words (Số tiền bằng ch<span style='display:none'>ữ) :<span
  style='mso-spacerun:yes'>           </span><font class="font20"><%=Inword %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1074"
   style='position:absolute;flip:y;z-index:42' from="21pt,14.25pt" to="533.25pt,14.25pt"
   strokecolor="#36f [48]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:42;margin-left:27px;
  margin-top:18px;width:685px;height:2px'><img width=685 height=2
  src="Wooribank_PRT_new_files/image008.gif" v:shapes="_x0000_s1074"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt'>(한글<font class="font13"> </font><font
  class="font11">금액)</font></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 style='height:19.5pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1061" style='position:absolute;margin-left:2.25pt;margin-top:7.5pt;
   width:9.75pt;height:9pt;z-index:31' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:31;margin-left:2px;margin-top:9px;width:15px;
  height:14px'><img width=15 height=14
  src="Wooribank_PRT_new_files/image009.gif" v:shapes="_x0000_s1061"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl47 width=79 style='height:19.5pt;width:59pt'>VND</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td colspan=4 class=xl53>To be withdrawn for/Mục đích</td>
  <td class=xl24></td>
  <td height=26 class=xl24 width=31 style='height:19.5pt;width:23pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1064" style='position:absolute;margin-left:6pt;margin-top:8.25pt;
   width:9.75pt;height:9pt;z-index:34' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=7 height=10></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=15 height=14 src="Wooribank_PRT_new_files/image009.gif"
    v:shapes="_x0000_s1064"></td>
    <td width=9></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:23.25pt;height:19.5pt'></span><![endif]--></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1067"
   style='position:absolute;z-index:37' from="69pt,16.5pt" to="247.5pt,16.5pt"
   strokecolor="#36f [48]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:37;margin-left:91px;
  margin-top:21px;width:240px;height:2px'><img width=240 height=2
  src="Wooribank_PRT_new_files/image010.gif" v:shapes="_x0000_s1067"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl40 width=110 style='height:19.5pt;width:83pt'>Cash In
    USD</td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1062" style='position:absolute;margin-left:2.25pt;margin-top:1.5pt;
   width:9.75pt;height:9pt;z-index:32' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:32;margin-left:2px;margin-top:1px;width:15px;
  height:14px'><img width=15 height=14
  src="Wooribank_PRT_new_files/image009.gif" v:shapes="_x0000_s1062"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl53 width=79 style='height:12.75pt;width:59pt'>USD</td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl48>(Tiền Dola Mỹ)</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 width=273 style='height:12.75pt;width:205pt'
  align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1063" style='position:absolute;
   margin-left:2.25pt;margin-top:1.5pt;width:9.75pt;height:9pt;z-index:33'
   fillcolor="window [65]" strokecolor="#36f [48]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:33;margin-left:2px;
  margin-top:1px;width:15px;height:14px'><img width=15 height=14
  src="Wooribank_PRT_new_files/image009.gif" v:shapes="_x0000_s1063"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=17 class=xl53 width=273 style='height:12.75pt;
    width:205pt'>Transfer/Chuyển tiền (<font class="font25">국내 송금시 작성</font><font
    class="font19">)</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td height=17 class=xl24 width=31 style='height:12.75pt;width:23pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1065" style='position:absolute;margin-left:6pt;margin-top:3pt;
   width:9.75pt;height:9pt;z-index:35' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=7 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=15 height=14 src="Wooribank_PRT_new_files/image009.gif"
    v:shapes="_x0000_s1065"></td>
    <td width=9></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:23.25pt;height:12.75pt'></span><![endif]--></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1068"
   style='position:absolute;z-index:38' from="69pt,9.75pt" to="247.5pt,9.75pt"
   strokecolor="#36f [48]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:38;margin-left:91px;
  margin-top:12px;width:240px;height:2px'><img width=240 height=2
  src="Wooribank_PRT_new_files/image010.gif" v:shapes="_x0000_s1068"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl49 width=110 style='height:12.75pt;width:83pt'>Cash
    in VND</td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl48>(Việt Nam Đồng)</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:32.0pt'>
  <td colspan=2 height=37 class=xl67 width=145 style='border-right:.5pt solid #3366FF;
  height:27.95pt;width:109pt'>Bank/Ngân hàng <font class="font17"><span
  style='mso-spacerun:yes'>             </span></font><font class="font12">(은행명)<span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=4 class=xl74 width=327 style='border-right:.5pt solid #3366FF;
  border-left:none;width:245pt;font-size:12.0pt'><%=p_C_Bank %></td>
  <td class=xl24></td>
  <td height=37 class=xl24 width=31 style='height:27.95pt;width:23pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1066" style='position:absolute;margin-left:6pt;margin-top:3pt;
   width:9.75pt;height:9pt;z-index:36' fillcolor="window [65]" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=7 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=15 height=14 src="Wooribank_PRT_new_files/image009.gif"
    v:shapes="_x0000_s1066"></td>
    <td width=9></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:23.25pt;height:27.75pt'></span><![endif]--></td>
  <td class=xl48>Transfer/Chuyển tiề<span style='display:none'>n</span></td>
  <td colspan=3 height=37 class=xl24 width=250 style='mso-ignore:colspan-rowspan;
  height:27.95pt;width:189pt'><!--[if gte vml 1]><v:line id="_x0000_s1069"
   style='position:absolute;z-index:39' from="18.75pt,10.5pt" to="165pt,10.5pt"
   strokecolor="#36f [48]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=197 height=2 src="Wooribank_PRT_new_files/image011.gif"
    v:shapes="_x0000_s1069"></td>
    <td width=29></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:187.5pt;height:27.75pt'></span><![endif]--></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:32.0pt'>
  <td colspan=2 height=37 class=xl77 width=145 style='border-right:.5pt solid #3366FF;
  height:27.95pt;width:109pt'>Beneficiary/Người thụ hưởng <font class="font11">(수취인)</font></td>
  <td colspan=4 class=xl58 width=327 style='border-right:.5pt solid #3366FF;
  border-left:none;width:245pt;font-size:12.0pt'><%=p_C_Acc_Nm %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl50 width=110 style='width:83pt'>Date / Ngày<span
  style='mso-spacerun:yes'>      </span><font class="font11">(날짜)</font></td>
  <td class=xl27><%=p_Date %>&nbsp;/&nbsp;<%=p_Month %>&nbsp;/&nbsp;<%=p_Year %></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl67 width=145 style='border-right:.5pt solid #3366FF;
  height:22.5pt;width:109pt'>AC No/Số tài khoản<font class="font17"> </font><font
  class="font12">(계좌번호)</font></td>
  <td colspan=4 class=xl68 width=327 style='border-right:.5pt solid #3366FF;
  border-left:none;width:245pt;font-size:12.0pt'><%=p_C_Acc_No %></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl67 width=145 style='border-right:.5pt solid #3366FF;
  height:27.75pt;width:109pt'>Amount/Số tiền<font class="font17"><span
  style='mso-spacerun:yes'>           </span></font><font class="font10">(</font><font
  class="font12">금액)</font></td>
  <td colspan=4 class=xl71 style='border-right:.5pt solid #3366FF;border-left:
  none;font-size:12.0pt'><%=_str_Amt %> <%=p_Ccy %></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=2 height=37 class=xl56 width=145 style='border-right:.5pt solid #3366FF;
  height:27.95pt;width:109pt'>Remark/Nội dung<span
  style='mso-spacerun:yes'>        </span><font class="font12">(비고)</font></td>
  <td colspan=4 class=xl58 width=327 style='border-right:.5pt solid #3366FF;
  border-left:none;width:245pt;font-size:10.0pt'><%=p_Remark %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 height=37 width=330 style='height:27.95pt;width:249pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1071" style='position:absolute;
   z-index:40' from="23.25pt,15.75pt" to="246pt,15.75pt" strokecolor="#36f [48]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:40;margin-left:30px;margin-top:20px;width:299px;
  height:2px'><img width=299 height=2 src="Wooribank_PRT_new_files/image012.gif"
  v:shapes="_x0000_s1071"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=37 class=xl47 width=330 style='height:27.95pt;
    width:249pt'>Name &amp; Signature/ Tên &amp; Chữ ký <font class="font11">(성명
    및 서명)</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=12 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 colspan=5 style='height:12.75pt;mso-ignore:colspan'>For
  Bank Use Only / Phần dành riêng cho Ngân Hàng</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt'>&nbsp;</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 rowspan=3 height=51 class=xl24 width=330 style='mso-ignore:
  colspan-rowspan;height:38.25pt;width:249pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1073" type="#_x0000_t75" style='position:absolute;
   margin-left:53.25pt;margin-top:6pt;width:168pt;height:27.75pt;z-index:41'>
   <v:imagedata src="Wooribank_PRT_new_files/image013.png" o:title="woori_bank"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=71 height=8></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=224 height=37 src="Wooribank_PRT_new_files/image014.jpg"
    v:shapes="_x0000_s1073"></td>
    <td width=35></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:247.5pt;height:38.25pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=30 style='width:23pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
