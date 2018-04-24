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
        p_Date = dt.Rows[0][10].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
    }

    //string _str = "";
    //char[] _ch = p_C_Acc_No.ToCharArray();
    //for (int _j = 0; _j < _ch.Length; _j++)
    //{
    //    _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    //}
    //string _str_Dr = "";
    //char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    //for (int _k = 0; _k < _ch_Dr.Length; _k++)
    //{
    //    _str_Dr += _ch_Dr[_k] ;
    //}
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][13].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();


        //string _ch_Amt = p_Amt.ToString();

        //int p = _ch_Amt.Length % 3;
        
        //if (p > 0)
        //{
        //    _str_Amt = _ch_Amt.Substring(0, p) + "     ";
        //}
        
        //int z = _ch_Amt.Length / 3;
        //int r;
        //for (r = 0; r < z; r++)
        //{
        //    _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
        //    p = p + 3;
            
        //}
        
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
<link rel=File-List href="VCB_GRT_files/filelist.xml">
<link rel=Edit-Time-Data href="VCB_GRT_files/editdata.mso">
<link rel=OLE-Object-Data href="VCB_GRT_files/oledata.mso">
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
  <o:LastPrinted>2012-01-04T06:15:14Z</o:LastPrinted>
  <o:Created>2012-01-03T08:48:30Z</o:Created>
  <o:LastSaved>2012-01-04T06:21:46Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.4in .5in .5in .5in;
	mso-header-margin:.4in;
	mso-footer-margin:.5in;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:15.0pt;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
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
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl68
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:top;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl88
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl104
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
    
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=881 style='border-collapse:
 collapse;table-layout:fixed;width:666pt'>
 <col class=xl24 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl24 width=61 span=6 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl24 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl24 width=14 style='mso-width-source:userset;mso-width-alt:512;
 width:11pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=16 height=40 width=817 style='border-right:.5pt solid black;
  height:30.0pt;width:618pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1038" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:36.75pt;margin-top:14.25pt;
   width:112.5pt;height:13.5pt;z-index:11'>
   <v:imagedata src="VCB_GRT_files/image001.jpg" o:title="27559-Logo-Vietcombank_11 - Copy"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:12pt;margin-top:11.25pt;width:22.5pt;
   height:21pt;z-index:12'>
   <v:imagedata src="VCB_GRT_files/image002.jpg" o:title="27559-Logo-Vietcombank_11"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:11;margin-left:16px;margin-top:15px;width:183px;
  height:28px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=30></td>
    <td width=3></td>
    <td width=150></td>
   </tr>
   <tr>
    <td height=4></td>
    <td rowspan=3 align=left valign=top><img width=30 height=28
    src="VCB_GRT_files/image003.jpg" v:shapes="_x0000_s1039"></td>
   </tr>
   <tr>
    <td height=18></td>
    <td></td>
    <td align=left valign=top><img width=150 height=18
    src="VCB_GRT_files/image004.jpg" v:shapes="_x0000_s1038"></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=16 height=40 class=xl97 width=817 style='border-right:.5pt solid black;
    height:30.0pt;width:618pt'>GIẤY RÚT TIỀN <font class="font16">- WITHDRAWAL
    SLIP</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=16 height=20 width=817 style='border-right:.5pt solid black;
  height:15.0pt;width:618pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1029" style='position:absolute;z-index:4' from="303.75pt,13.5pt"
   to="379.5pt,13.5pt" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:404px;margin-top:17px;width:103px;height:2px'><img
  width=103 height=2 src="VCB_GRT_files/image005.gif" v:shapes="_x0000_s1029"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=16 height=20 class=xl100  width=817 style='border-right:.5pt solid black;
    height:15.0pt;width:618pt'>Ngày<font class="font8"> (Date):</font><font
    class="font7"><span style='mso-spacerun:yes'> <%=p_Date %></span></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl28 style='height:4.5pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl32 style='height:9.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 style='height:16.5pt'>&nbsp;</td>
  <td class=xl34 colspan=5 align=left style='mso-ignore:colspan'>1.ĐỀ NGHỊ GHI
  NỢ TÀI KHOẢN <font class="font10">(Please Debit account:)</font></td>
  <td class=xl34></td>
  <td class=xl24></td>
  <td class=xl34 colspan=3 align=left style='mso-ignore:colspan'>SỐ TIỀN<font
  class="font11"> </font><font class="font10">(With amount):</font></td>
  <td class=xl24></td>
  <td colspan=4 class=xl103 style='border-right:.5pt solid black'>PHÍ NH<font
  class="font11"> </font><font class="font10">(Banks charge)</font></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl35 height=29 style='height:21.75pt'>
  <td height=29 class=xl36 style='height:21.75pt'>&nbsp;</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'>SỐ TK <font class="font10">(A/C
  No.)</font><font class="font11">:</font></td>
  <td colspan=4 class=xl88 width=244 style='border-right:.5pt solid black;
  width:184pt'><%=p_D_Acc_No %></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 colspan=2 align=left style='mso-ignore:colspan'>Bằng số <font
  class="font10">(In figures)</font><font class="font11">:</font></td>
  <td class=xl68 align=left style='text-align:right' ><span  style='mso-spacerun:yes'>                   </span><%=p_Amt %></td>
  <td class=xl44 width=36 style='width:27pt'><%=p_Ccy %></td>
  <td class=xl71></td>
  <td class=xl70 align=left width=62 style='width:47pt'>Phí trong <font
  class="font10">Including</font></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="Rectangle_x0020_2"
   o:spid="_x0000_s1025" style='position:absolute;direction:LTR;text-align:left;
   margin-left:8.25pt;margin-top:4.5pt;width:22.5pt;height:15pt;z-index:1;
   visibility:visible;mso-wrap-style:tight;v-text-anchor:middle' fillcolor="window"
   strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1027" style='position:absolute;direction:LTR;
   text-align:left;margin-left:8.25pt;margin-top:19.5pt;width:22.5pt;height:14.25pt;
   flip:x;z-index:2;visibility:visible;mso-wrap-style:tight;v-text-anchor:middle'
   fillcolor="window" strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:10px;margin-top:5px;width:32px;height:41px'><img
  width=32 height=41 src="VCB_GRT_files/image006.gif" v:shapes="Rectangle_x0020_2 _x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl35 width=45 style='height:21.75pt;width:34pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl36 style='height:26.25pt'>&nbsp;</td>
  <td class=xl45 colspan=2 style='mso-ignore:colspan'>TÊN TK <font
  class="font10">(A/c name)</font><font class="font11">:</font></td>
  <td colspan=4 class=xl90 width=244 style='border-right:.5pt solid black;
  width:184pt'><%=p_D_Acc_Nm %></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=4 rowspan=2 class=xl92 width=297 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:224pt'>Bằng chữ <font class="font10">(
  In words) :</font><font class="font11"><%=Inword %></font></td>
  <td class=xl48></td>
  <td class=xl70 align=left width=62 style='width:47pt'>Phí ngoài<font
  class="font11"> </font><font class="font10">Excluded</font></td>
  <td class=xl67></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl36 style='height:27.0pt'>&nbsp;</td>
  <td colspan=2 class=xl94 width=122 style='width:92pt'>ĐỊA CHỈ (Address):</td>
  <td colspan=4 class=xl105 width=244 style='border-right:.5pt solid black;
  width:184pt'><%=p_D_Add %></td>
  <td class=xl49></td>
  <td class=xl48></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl36 style='height:26.25pt'>&nbsp;</td>
  <td colspan=2 class=xl83 width=122 style='width:92pt'>NGÂN HÀNG<font
  class="font10"> (With bank)</font><font class="font11">:</font></td>
  <td colspan=4 class=xl85 width=244 style='border-right:.5pt solid black;
  width:184pt'><%=p_D_Bank %></td>
  <td class=xl49></td>
  <td class=xl72 align=left width=85 style='border-top:none;width:64pt'>Trong
  đó:<span style='mso-spacerun:yes'>              </span><font class="font10">(Of
  which)</font></td>
  <td width=34 style='width:26pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1045" style='position:absolute;direction:LTR;text-align:left;
   margin-left:5.25pt;margin-top:24pt;width:12pt;height:10.5pt;z-index:18;
   visibility:visible;mso-wrap-style:tight;v-text-anchor:middle' fillcolor="window"
   strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;direction:LTR;
   text-align:left;margin-left:5.25pt;margin-top:34.5pt;width:12pt;height:12pt;
   flip:x;z-index:19;visibility:visible;mso-wrap-style:tight;v-text-anchor:middle'
   fillcolor="window" strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;direction:LTR;
   text-align:left;margin-left:5.25pt;margin-top:3pt;width:12pt;height:11.25pt;
   z-index:20;visibility:visible;mso-wrap-style:tight;v-text-anchor:middle'
   fillcolor="window" strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;direction:LTR;
   text-align:left;margin-left:5.25pt;margin-top:14.25pt;width:12pt;height:9.75pt;
   flip:x;z-index:21;visibility:visible;mso-wrap-style:tight;v-text-anchor:middle'
   fillcolor="window" strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:18;margin-left:6px;margin-top:3px;width:18px;height:60px'><img
  width=18 height=60 src="VCB_GRT_files/image007.gif" v:shapes="_x0000_s1045 _x0000_s1046 _x0000_s1047 _x0000_s1048"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=35 class=xl66 width=34 style='height:26.25pt;border-top:none;
    width:26pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=3 height=81 width=142 style='height:60.75pt;width:107pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1028" style='position:absolute;
   z-index:3' from="61.5pt,9pt" to="213pt,9pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1031" style='position:absolute;z-index:6'
   from="63.75pt,31.5pt" to="213.75pt,32.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1044" style='position:absolute;flip:y;z-index:17'
   from="21pt,42pt" to="214.5pt,42pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1030" style='position:absolute;z-index:5'
   from="59.25pt,20.25pt" to="212.25pt,20.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:27px;margin-top:11px;width:260px;height:46px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=51></td>
    <td width=3></td>
    <td width=3></td>
    <td width=200></td>
    <td width=1></td>
    <td width=1></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td colspan=3 align=left valign=top><img width=204 height=2
    src="VCB_GRT_files/image008.gif" v:shapes="_x0000_s1028"></td>
   </tr>
   <tr>
    <td height=13></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=206 height=2
    src="VCB_GRT_files/image009.gif" v:shapes="_x0000_s1030"></td>
   </tr>
   <tr>
    <td height=13></td>
   </tr>
   <tr>
    <td height=3></td>
    <td colspan=3></td>
    <td colspan=3 align=left valign=top><img width=202 height=3
    src="VCB_GRT_files/image010.gif" v:shapes="_x0000_s1031"></td>
   </tr>
   <tr>
    <td height=11></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=7 align=left valign=top><img width=260 height=2
    src="VCB_GRT_files/image011.gif" v:shapes="_x0000_s1044"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=3 height=81 class=xl79 width=142 style='height:60.75pt;
    border-top:none;width:107pt'>Ngoại Tệ 1<font class="font10">(Fre 1):<span
    style='mso-spacerun:yes'>                       </span>Ngoại Tệ 1(Fre
    2):<span style='mso-spacerun:yes'>                 </span>FTT (Time Bk
    Note):<span style='mso-spacerun:yes'>              </span>VNĐ:</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=36 style='border-top:none;width:27pt'>&nbsp;</td>
  <td colspan=3 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl50 style='height:17.25pt'>&nbsp;</td>
  <td class=xl61 colspan=5 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>2.NGƯỜI NHẬN TIỀN <font class="font10">(Beneficiary's
  Information):</font></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl52>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl35 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl36 style='height:17.25pt'>&nbsp;</td>
  <td colspan=6 rowspan=2 height=54 width=366 style='height:40.5pt;width:276pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035" style='position:absolute;
   z-index:9' from="71.25pt,12pt" to="273pt,12pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1043" style='position:absolute;z-index:16'
   from="2.25pt,37.5pt" to="274.5pt,37.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     1, 3, 11, 27, 6, 66, 11, 27</x:Anchor>
   </x:ClientData>
  </v:line><v:line id="_x0000_s1042" style='position:absolute;z-index:15'
   from="2.25pt,24.75pt" to="273pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:2px;margin-top:15px;width:365px;height:36px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=92></td>
    <td width=271></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=271 height=2
    src="VCB_GRT_files/image012.gif" v:shapes="_x0000_s1035"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2 align=left valign=top><img width=363 height=2
    src="VCB_GRT_files/image013.gif" v:shapes="_x0000_s1042"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=365 height=2
    src="VCB_GRT_files/image014.gif" v:shapes="_x0000_s1043"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 rowspan=2 height=54 class=xl48 width=366 style='height:40.5pt;
    width:276pt'>Họ &amp; tên<font class="font10"> (Full name):</font><font
    class="font7"><%=p_C_Acc_Nm %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl52>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl36 style='height:23.25pt'>&nbsp;</td>
  <td class=xl35></td>
  <td class=xl77 colspan=2 align=left style='mso-ignore:colspan'>KẾ TOÁN TRƯỞNG
  K<span style='display:none'>Ý<span style='mso-spacerun:yes'>             
  </span><font class="font10"><span
  style='mso-spacerun:yes'>                                                   </span></font></span></td>
  <td colspan=3 class=xl82 x:str="CHỦTÀIKHOẢNKÝ &amp;ĐÓNGDẤU       ">CHỦTÀIKHOẢNKÝ
  &amp;ĐÓNGDẤU<span style='mso-spacerun:yes'>       </span></td>
  <td class=xl77 colspan=3 align=left style='mso-ignore:colspan;border-right:
  .5pt solid black'>NGƯỜI NHẬN TIỀN K<span style='display:none'>Ý</span></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl36 style='height:17.25pt'>&nbsp;</td>
  <td class=xl35 colspan=2 align=left style='mso-ignore:colspan'>Số CMT/Hộ
  chiếu<font class="font10"> (ID/PP</font><span style='display:none'><font
  class="font10"> No.):</font></span></td>
  <td colspan=4 height=23 class=xl48 width=244 style='mso-ignore:colspan-rowspan;
  height:17.25pt;width:184pt'><!--[if gte vml 1]><v:line id="_x0000_s1049"
   style='position:absolute;z-index:22' from="6pt,12.75pt" to="181.5pt,13.5pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=7 height=16></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=236 height=3 src="VCB_GRT_files/image015.gif" v:shapes="_x0000_s1049"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:183.0pt;height:17.25pt'></span><![endif]--></td>
  <td class=xl35></td>
  <td colspan=2 class=xl81 x:str="Chief accountant ">Chief accountant<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl81>Acc. Holder &amp; Stamp</td>
  <td colspan=2 class=xl80 width=107 style='width:81pt'>Receiver</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl36 style='height:17.25pt'>&nbsp;</td>
  <td class=xl35 align=left>Ngày cấp <font class="font10">(D</font><span
  style='display:none'><font class="font10">ate of issue):<span
  style='mso-spacerun:yes'>          </span>/<span
  style='mso-spacerun:yes'>           </span>/<span
  style='mso-spacerun:yes'>           </span></font><font class="font11">Nơi
  cấp </font><font class="font10">(Place of issue):</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1050"
   style='position:absolute;flip:y;z-index:23' from="36pt,12.75pt" to="52.5pt,12.75pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1051" style='position:absolute;flip:y;z-index:24'
   from="54pt,12.75pt" to="78pt,12.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1052" style='position:absolute;flip:y;z-index:25'
   from="79.5pt,12.75pt" to="101.25pt,12.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:23;margin-left:47px;margin-top:16px;width:89px;height:2px'><img
  width=89 height=2 src="VCB_GRT_files/image016.gif" v:shapes="_x0000_s1050 _x0000_s1051 _x0000_s1052"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=23 class=xl37 width=61 style='height:17.25pt;width:46pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 height=23 class=xl48 width=122 style='mso-ignore:colspan-rowspan;
  height:17.25pt;width:92pt'><!--[if gte vml 1]><v:line id="_x0000_s1053"
   style='position:absolute;flip:y;z-index:26' from="37.5pt,12.75pt" to="90.75pt,12.75pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=49 height=16></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=73 height=2 src="VCB_GRT_files/image017.gif" v:shapes="_x0000_s1053"></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:91.5pt;height:17.25pt'></span><![endif]--></td>
  <td class=xl35></td>
  <td colspan=7 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl55>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl36 style='height:25.5pt'>&nbsp;</td>
  <td colspan=6 height=34 width=366 style='height:25.5pt;width:276pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034" style='position:absolute;
   flip:y;z-index:8' from="57.75pt,12pt" to="274.5pt,12pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1041" style='position:absolute;flip:y;z-index:14'
   from=".75pt,24pt" to="274.5pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     1, 1, 14, 32, 6, 67, 14, 33</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:8;margin-left:0px;margin-top:15px;width:367px;height:19px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=76></td>
    <td width=291></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=291 height=2
    src="VCB_GRT_files/image018.gif" v:shapes="_x0000_s1034"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=3></td>
    <td colspan=2 align=left valign=top><img width=367 height=3
    src="VCB_GRT_files/image019.gif" v:shapes="_x0000_s1041"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=34 class=xl48 width=366 style='height:25.5pt;
    width:276pt'>Địa chỉ <font class="font10">(Address):</font><font
    class="font7"><%=p_C_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl56 width=10 style='width:8pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 rowspan=2 height=44 width=366 style='height:33.0pt;width:276pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1033" style='position:absolute;
   flip:y;z-index:7' from="89.25pt,12pt" to="274.5pt,12pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1040" style='position:absolute;flip:y;z-index:13'
   from=".75pt,24.75pt" to="275.25pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:0px;margin-top:15px;width:368px;height:19px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=118></td>
    <td width=249></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=249 height=2
    src="VCB_GRT_files/image020.gif" v:shapes="_x0000_s1033"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=368 height=2
    src="VCB_GRT_files/image021.gif" v:shapes="_x0000_s1040"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 rowspan=2 height=44 class=xl87 width=366 style='height:33.0pt;
    width:276pt'>NỘI DUNG NỘP<font class="font11"> </font><font class="font10">(Details):
    </font><font class="font7"><%=p_Remark %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt'>&nbsp;</td>
  <td colspan=8 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl57 style='height:.75pt'>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl50 style='height:9.0pt'>&nbsp;</td>
  <td colspan=14 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl36 style='height:11.25pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;z-index:10' from="2.25pt,9.75pt" to="172.5pt,9.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:10;margin-left:2px;
  margin-top:12px;width:229px;height:2px'><img width=229 height=2
  src="VCB_GRT_files/image022.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=15 class=xl61 align=left width=61 style='height:11.25pt;
    width:46pt'>DÀNH CHO NGÂN HÀNG <font class="font13">(For Bank's Use only): </font><font
    class="font9">Mã VAT:</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=13 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl50 style='height:4.5pt'>&nbsp;</td>
  <td colspan=14 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td height=19 class=xl63 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl62 colspan=2 align=left style='mso-ignore:colspan'>Thanh toán
  viên</td>
  <td class=xl62></td>
  <td colspan=2 class=xl64>Kiểm soát</td>
  <td class=xl64>Thủ quỹ</td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl62 align=left>Giám đốc</td>
  <td class=xl62></td>
  <td class=xl65>&nbsp;</td>
  <td class=xl62></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=17 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=5 style='width:4pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
