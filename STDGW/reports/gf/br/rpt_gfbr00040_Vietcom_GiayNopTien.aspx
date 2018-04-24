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
        
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
       
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
<link rel=File-List href="fffffffffffffffff_files/filelist.xml">
<link rel=Edit-Time-Data href="fffffffffffffffff_files/editdata.mso">
<link rel=OLE-Object-Data href="fffffffffffffffff_files/oledata.mso">
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
  <o:LastPrinted>2012-01-03T09:29:54Z</o:LastPrinted>
  <o:Created>2012-01-03T08:48:30Z</o:Created>
  <o:LastSaved>2012-01-04T02:11:06Z</o:LastSaved>
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
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
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
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
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
	font-weight:700;
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
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
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
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
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
.xl80
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
.xl81
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
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
.xl84
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
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
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
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl98
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
.xl99
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
.xl100
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
.xl101
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
.xl102
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl106
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl107
	{mso-style-parent:style0;
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
.xl108
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
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
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="1044"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=919 style='border-collapse:
 collapse;table-layout:fixed;width:690pt'>
 <col class=xl24 width=11 style='mso-width-source:userset;mso-width-alt:402;
 width:8pt'>
 <col class=xl24 width=68 span=6 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl24 width=68 span=6 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=15 height=23 width=855 style='border-right:.5pt solid black;
  height:17.25pt;width:642pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
   direction:LTR;text-align:left;margin-left:33.75pt;margin-top:9.75pt;width:97.5pt;
   height:12pt;z-index:12'>
   <v:imagedata src="fffffffffffffffff_files/image001.jpg" o:title="27559-Logo-Vietcombank_11 - Copy"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:8.25pt;margin-top:6pt;width:19.5pt;
   height:18pt;z-index:13'>
   <v:imagedata src="fffffffffffffffff_files/image002.jpg" o:title="27559-Logo-Vietcombank_11"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:12;margin-left:11px;margin-top:8px;width:164px;
  height:24px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=26></td>
    <td width=8></td>
    <td width=130></td>
   </tr>
   <tr>
    <td height=5></td>
    <td rowspan=3 align=left valign=top><img width=26 height=24
    src="fffffffffffffffff_files/image003.jpg" v:shapes="_x0000_s1039"></td>
   </tr>
   <tr>
    <td height=16></td>
    <td></td>
    <td align=left valign=top><img width=130 height=16
    src="fffffffffffffffff_files/image004.jpg" v:shapes="_x0000_s1038"></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=15 height=23 class=xl68 width=855 style='border-right:.5pt solid black;
    height:17.25pt;width:642pt'>CHỨNG TỪ GIAO DỊCH</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=15 height=20 class=xl71 style='border-right:.5pt solid black;
  height:15.0pt'>GIẤY NỘP TIỀN <font class="font5">- DEPOSIT SLIP</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=15 height=20 width=855 style='border-right:.5pt solid black;
  height:15.0pt;width:642pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1029" style='position:absolute;z-index:4' from="338.25pt,13.5pt"
   to="402pt,13.5pt" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:450px;margin-top:17px;width:87px;height:2px'><img
  width=87 height=2 src="fffffffffffffffff_files/image005.gif" v:shapes="_x0000_s1029"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=15 height=20 class=xl74 width=855 style='border-right:.5pt solid black;
    height:15.0pt;width:642pt'>Ngày<font class="font9"> (Date):</font><font
    class="font8"><%=p_Date %><span style='mso-spacerun:yes'> </span></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
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
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl32 style='height:9.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 rowspan=2 class=xl77 style='border-bottom:.5pt solid black'>ĐỀ
  NGHỊ GHI CÓ TÀI KHOẢN <font class="font11">(Please Credit account:)</font></td>
  <td class=xl24></td>
  <td colspan=3 rowspan=2 class=xl77 style='border-bottom:.5pt solid black'>SỐ
  TIỀN<font class="font12"> </font><font class="font11">(With amount):</font></td>
  <td class=xl34 colspan=2 align=left style='mso-ignore:colspan'>Phí trong<font
  class="font12"> </font><font class="font11">(Charge Includ</font><span
  style='display:none'><font class="font11">ed):</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="Rectangle_x0020_2"
   o:spid="_x0000_s1025" style='position:absolute;direction:LTR;text-align:left;
   margin-left:32.25pt;margin-top:2.25pt;width:18.75pt;height:14.25pt;
   z-index:1;visibility:visible;mso-wrap-style:tight;v-text-anchor:middle'
   fillcolor="window" strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:Anchor>
     13, 43, 5, 3, 13, 73, 6, 0</x:Anchor>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1027" style='position:absolute;direction:LTR;
   text-align:left;margin-left:32.25pt;margin-top:16.5pt;width:18.75pt;
   height:12pt;flip:x;z-index:2;visibility:visible;mso-wrap-style:tight;
   v-text-anchor:middle' fillcolor="window" strokecolor="windowText"
   strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left;direction:ltr'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:42px;margin-top:2px;width:27px;height:37px'><img
  width=27 height=37 src="fffffffffffffffff_files/image006.gif" v:shapes="Rectangle_x0020_2 _x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl24 width=68 style='height:16.5pt;width:51pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl35 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl36 style='height:18.75pt'>&nbsp;</td>
  <td class=xl35></td>
  <td class=xl37 colspan=3 align=left style='mso-ignore:colspan'>Phí ngoài<font
  class="font12"> </font><font class="font11">(Charge Excluded):</font></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl36 style='height:20.1pt'>&nbsp;</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'>SỐ TK <font class="font11">(A/C
  No.)</font><font class="font12">:</font></td>
  <td colspan=4 class=xl79 width=272 style='border-right:.5pt solid black;
  width:204pt'><%=p_C_Acc_No %></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 colspan=2 align=left style='mso-ignore:colspan'>Bằng số <font
  class="font11">(In figures)</font><font class="font12">:</font></td>
  <td colspan=3 class=xl81 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>                                   
  </span><%=p_Amt %><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl44 width=68 style='width:51pt'><%=p_Ccy %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl36 style='height:26.25pt'>&nbsp;</td>
  <td class=xl45 colspan=2 style='mso-ignore:colspan'>TÊN TK <font
  class="font11">(A/c name)</font><font class="font12">:</font></td>
  <td colspan=4 class=xl83 width=272 style='border-right:.5pt solid black;
  width:204pt'><%=p_C_Acc_Nm %></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=6 rowspan=3 class=xl85 align=left width=408 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;width:306pt'>Bằng chữ <font
  class="font11">( In words) :</font><font class="font12"><%=Inword %></font></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl36 style='height:27.0pt'>&nbsp;</td>
  <td colspan=2 class=xl94 width=136 style='width:102pt'>ĐỊA CHỈ (Address):</td>
  <td colspan=4 class=xl96 width=272 style='border-right:.5pt solid black;
  width:204pt'><%=p_C_Add %></td>
  <td class=xl48></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl36 style='height:26.25pt'>&nbsp;</td>
  <td colspan=2 class=xl98 width=136 style='width:102pt'>NGÂN HÀNG<font
  class="font11"> (With bank)</font><font class="font12">:</font></td>
  <td colspan=4 class=xl100 width=272 style='border-right:.5pt solid black;
  width:204pt'><%=p_C_Bank %></td>
  <td class=xl48></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl49 style='height:17.25pt'>&nbsp;</td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl51>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl35 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl36 style='height:17.25pt'>&nbsp;</td>
  <td class=xl34 colspan=3 align=left style='mso-ignore:colspan'>NGƯỜI NỘP TIỀN
  <font class="font11">(Depositor)</font></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl52 colspan=2 align=left style='mso-ignore:colspan'>TRONG ĐÓ:</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl51>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl36 style='height:39.75pt'>&nbsp;</td>
  <td colspan=6 height=53 width=408 style='height:39.75pt;width:306pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035" style='position:absolute;
   z-index:10' from="84.75pt,11.25pt" to="303pt,11.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1043" style='position:absolute;z-index:17'
   from="1.5pt,37.5pt" to="303.75pt,37.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1042" style='position:absolute;z-index:16'
   from=".75pt,24.75pt" to="303pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:10;margin-left:0px;margin-top:14px;width:406px;height:37px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=1></td>
    <td width=111></td>
    <td width=293></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td align=left valign=top><img width=293 height=2
    src="fffffffffffffffff_files/image007.gif" v:shapes="_x0000_s1035"></td>
   </tr>
   <tr>
    <td height=16></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=405 height=2
    src="fffffffffffffffff_files/image008.gif" v:shapes="_x0000_s1042"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=405 height=2
    src="fffffffffffffffff_files/image008.gif" v:shapes="_x0000_s1043"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=53 class=xl108 width=408 style='height:39.75pt;
    width:306pt'><span style='mso-spacerun:yes'>  </span>Họ &amp; tên<font
    class="font11"> (Full name):</font><font class="font8">
    <%=p_D_Acc_Nm %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td class=xl53 align=left x:str="In Which ">In Which<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 align=left>Tiền mặt<font class="font12"> </font><font
  class="font11">(C</font><span style='display:none'><font class="font11">ash):</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1028"
   style='position:absolute;z-index:3' from="14.25pt,9pt" to="204pt,9pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:18px;margin-top:11px;width:255px;height:2px'><img
  width=255 height=2 src="fffffffffffffffff_files/image009.gif" v:shapes="_x0000_s1028"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=53 class=xl55 width=68 style='height:39.75pt;width:51pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl36 style='height:25.5pt'>&nbsp;</td>
  <td colspan=6 height=34 width=408 style='height:25.5pt;width:306pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034" style='position:absolute;
   flip:y;z-index:9' from="67.5pt,12pt" to="303pt,12pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1041" style='position:absolute;flip:y;z-index:15'
   from=".75pt,23.25pt" to="305.25pt,24pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:0px;margin-top:15px;width:408px;height:18px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=89></td>
    <td width=316></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=316 height=2
    src="fffffffffffffffff_files/image010.gif" v:shapes="_x0000_s1034"></td>
   </tr>
   <tr>
    <td height=13></td>
   </tr>
   <tr>
    <td height=3></td>
    <td colspan=3 align=left valign=top><img width=408 height=3
    src="fffffffffffffffff_files/image011.gif" v:shapes="_x0000_s1041"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=34 class=xl108 width=408 style='height:25.5pt;
    width:306pt'><span style='mso-spacerun:yes'>  </span>Địa chỉ <font
    class="font11">(Address):</font><font class="font8"><%=p_D_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td colspan=3 height=34 width=204 style='height:25.5pt;width:153pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1030" style='position:absolute;
   z-index:5' from="116.25pt,15pt" to="304.5pt,15pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:5;margin-left:154px;margin-top:19px;width:253px;height:2px'><img
  width=253 height=2 src="fffffffffffffffff_files/image012.gif" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=34 class=xl102 width=204 style='height:25.5pt;
    width:153pt'>NFTT <font class="font11">(Time Bank Note):</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl103 width=204 style='width:153pt'></td>
  <td class=xl58 width=10 style='width:8pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 rowspan=2 height=51 width=408 style='height:38.25pt;width:306pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1032" style='position:absolute;
   z-index:7' from="2.25pt,37.5pt" to="306.75pt,37.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1040" style='position:absolute;flip:y;z-index:14'
   from=".75pt,24.75pt" to="306.75pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1033" style='position:absolute;flip:y;z-index:8'
   from="101.25pt,12.75pt" to="304.5pt,12.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:0px;margin-top:16px;width:410px;height:35px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=2></td>
    <td width=132></td>
    <td width=273></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td align=left valign=top><img width=273 height=2
    src="fffffffffffffffff_files/image013.gif" v:shapes="_x0000_s1033"></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=4 align=left valign=top><img width=410 height=2
    src="fffffffffffffffff_files/image014.gif" v:shapes="_x0000_s1040"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td colspan=3 align=left valign=top><img width=408 height=2
    src="fffffffffffffffff_files/image015.gif" v:shapes="_x0000_s1032"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 rowspan=2 height=51 class=xl104 width=408 style='height:38.25pt;
    width:306pt'>NỘI DUNG NỘP<font class="font12"> </font><font class="font11">(Details):
    </font><font class="font8"><%=p_Remark %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35></td>
  <td colspan=3 class=xl105>KÝ TÊN <font class="font11">(Signature)</font></td>
  <td colspan=4 class=xl106 style='border-right:.5pt solid black'></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl36 style='height:21.75pt'>&nbsp;</td>
  <td class=xl35></td>
  <td colspan=4 height=29 class=xl35 width=272 style='mso-ignore:colspan-rowspan;
  height:21.75pt;width:204pt'><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;z-index:6' from=".75pt,21pt" to="153pt,21pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=27></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=205 height=2 src="fffffffffffffffff_files/image016.gif"
    v:shapes="_x0000_s1031"></td>
    <td width=67></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:204.0pt;height:21.75pt'></span><![endif]--></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl59 style='height:6.75pt'>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl49 style='height:9.0pt'>&nbsp;</td>
  <td colspan=13 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl36 style='height:11.25pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;z-index:11' from="2.25pt,9.75pt" to="176.25pt,9.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:11;margin-left:2px;
  margin-top:12px;width:234px;height:2px'><img width=234 height=2
  src="fffffffffffffffff_files/image017.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=15 class=xl63 align=left width=68 style='height:11.25pt;
    width:51pt'>DÀNH CHO NGÂN HÀNG <font class="font14">(For Bank's Use only)</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=12 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl49 style='height:4.5pt'>&nbsp;</td>
  <td colspan=13 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td height=19 class=xl65 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 class=xl64 style='mso-ignore:colspan'></td>
  <td class=xl64 colspan=2 align=left style='mso-ignore:colspan'>Thanh toán
  viên</td>
  <td class=xl64></td>
  <td colspan=2 class=xl66>Kiểm soát</td>
  <td class=xl66>Thủ quỹ</td>
  <td class=xl64></td>
  <td class=xl64 align=left>Giám đốc</td>
  <td class=xl64></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl64></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
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
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=11 style='width:8pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>