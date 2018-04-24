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
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
    }

    
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][15].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        
        
        Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        
    }
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
	//Response.Write(p_Amt1);
    //    Response.End();
	//p_Ccy = "VND";
	//p_Amt1 = "987654321";
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="TELEGRAPHIC_TRANSFER_files/filelist.xml">
<link rel=Edit-Time-Data href="TELEGRAPHIC_TRANSFER_files/editdata.mso">
<link rel=OLE-Object-Data href="TELEGRAPHIC_TRANSFER_files/oledata.mso">
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
  <o:LastPrinted>2012-06-14T09:45:58Z</o:LastPrinted>
  <o:Created>2012-06-13T04:24:24Z</o:Created>
  <o:LastSaved>2012-06-25T01:44:59Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:12.0pt;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:top;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid red;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:.5pt solid red;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:.5pt solid red;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid red;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid red;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl114
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;}
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
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1083"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1137 style='border-collapse:
 collapse;table-layout:fixed;width:853pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl24 width=64 span=7 style='width:48pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=64 span=4 style='width:48pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 width=13 style='height:15.75pt;width:10pt'>&nbsp;</td>
  <td class=xl26 width=64 style='width:48pt'>&nbsp;</td>
  <td colspan=16 class=xl82 width=1044 style='width:783pt'>Chuyển khoản qua
  Ngân Hàng Trực Tuyến để hưởng phí chuyển khoản ưu đãi. Để biết thêm thông
  tin, vui lòng truy cập www.hsbc.com.vn</td>
  <td class=xl27 width=16 style='width:12pt'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=14 class=xl83>Transfer using Internet Banking and enjoy
  preferential remittance fees. For more information, please visit
  www.hsbc.com.vn</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl28 style='height:11.1pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=9 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span><font class="font8">Kính gửi:</font><font
  class="font7"> Ngân Hàng TNHH một thành viên HSBC (Việt Nam)</font></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=5 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span><font class="font8">To: </font><font
  class="font7">HSBC Bank (Vietnam) Ltd.</font></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=9 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>YÊU CẦU CHUYỂN TIỀN BẰNG ĐIỆN/HỐI
  PHIẾU/TRONG NƯỚC</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=11 align=left style='mso-ignore:colspan'
  x:str="     TELEGRAPHIC TRANSFER/DEMAND DRAFT/LOCAL TRANSFER APPLICATION FORM "><span
  style='mso-spacerun:yes'>     </span>TELEGRAPHIC TRANSFER/DEMAND DRAFT/LOCAL
  TRANSFER APPLICATION FOR<span style='display:none'>M<span
  style='mso-spacerun:yes'> </span></span></td>
  <td colspan=4 class=xl84>Ngày Hiệu Lực/ Value Date:</td>
  <td colspan=2 class=xl85 style='font-size:14pt'><%=p_Date%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl24 colspan=10 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>(Xin vui lòng đánh dấu (X) vào ô thích
  hợp/ Please tick (X) where applicable)</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl24 colspan=17 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Căn cứ vào các điều khoản và điều kiện ở
  trang sau, vui lòng phát hành một/ Subject to the terms and conditions
  printed overleaf, please issue a:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td rowspan=2 height=42 class=xl24 width=64 style='mso-ignore:colspan-rowspan;
  height:31.5pt;width:48pt'><!--[if gte vml 1]><v:rect id="_x0000_s1031"
   style='position:absolute;direction:LTR;text-align:left;margin-left:29.25pt;
   margin-top:6pt;width:16.5pt;height:18pt;z-index:1' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=38 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=24 height=26 src="TELEGRAPHIC_TRANSFER_files/image001.gif"
    v:shapes="_x0000_s1031"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=9></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:31.5pt'></span><![endif]--></td>
  <td class=xl30 colspan=5 align=left style='mso-ignore:colspan'
  x:str="Lệnh chuyển tiền trong nước ">Lệnh chuyển tiền trong nước<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1032"
   style='position:absolute;direction:LTR;text-align:left;margin-left:15pt;
   margin-top:6.75pt;width:16.5pt;height:18pt;z-index:2' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:2;margin-left:19px;
  margin-top:8px;width:24px;height:26px'><img width=24 height=26
  src="TELEGRAPHIC_TRANSFER_files/image001.gif" v:shapes="_x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl30 align=left width=78 style='height:15.75pt;
    width:59pt'><span style='mso-spacerun:yes'>           </span>Điện Chuyển
    Tiền (TT) ra nước ngoài</td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=4 align=left style='mso-ignore:colspan'>Transfer
  within Vietnam</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=6 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>           </span>Telegraphic Transfer (TT) to
  overseas</td>
  <td class=xl24></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl28 style='height:6.0pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td rowspan=2 height=42 class=xl24 width=64 style='mso-ignore:colspan-rowspan;
  height:31.5pt;width:48pt'><!--[if gte vml 1]><v:rect id="_x0000_s1033"
   style='position:absolute;direction:LTR;text-align:left;margin-left:30pt;
   margin-top:6pt;width:16.5pt;height:18pt;z-index:3' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=39 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=24 height=26 src="TELEGRAPHIC_TRANSFER_files/image001.gif"
    v:shapes="_x0000_s1033"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=9></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:31.5pt'></span><![endif]--></td>
  <td class=xl30 colspan=8 align=left style='mso-ignore:colspan'
  x:str="Lệnh fax lại, dùng cho khách hàng có thỏa thuận dùng fax ">Lệnh fax
  lại, dùng cho khách hàng có thỏa thuận dùng fax<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1034"
   style='position:absolute;direction:LTR;text-align:left;margin-left:15.75pt;
   margin-top:6.75pt;width:16.5pt;height:18pt;z-index:4' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:4;margin-left:20px;
  margin-top:8px;width:24px;height:26px'><img width=24 height=26
  src="TELEGRAPHIC_TRANSFER_files/image001.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl30 align=left width=78 style='height:15.75pt;
    width:59pt'><span style='mso-spacerun:yes'>            </span>Hối Phiếu
    (DD), và giữ để nhận tại Ngân Hàng</td>
   </tr>
  </table>
  </span></td>
  <td class=xl30></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=7 align=left style='mso-ignore:colspan'
  x:str="Refaxed TT, subject to registered Fax Indemnity ">Refaxed TT, subject
  to registered Fax Indemnity<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=7 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>            </span>Demand Draft (DD), and hold for
  collection at your counter</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=2 align=left style='mso-ignore:colspan'>(*) Loại tiền
  tệ:</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td colspan=5 rowspan=2 class=xl86 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;font-size:14pt'><%=p_Ccy%></td>
  <td class=xl33 colspan=3 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>(*) Số tiền chuyển:</td>
  <td colspan=5 rowspan=2 class=xl115 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;font-size:14pt'><span style='mso-spacerun:yes'>  
  </span><%=p_Amt%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl37 colspan=3 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Remitting currenc<span style='display:
  none'>y:</span></td>
  <td class=xl113>&nbsp;</td>
  <td class=xl38 colspan=2 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Amount transfer:</td>
  <td class=xl114>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=3 align=left style='mso-ignore:colspan'>(*) Số tiền
  bằng chữ<span style='display:none'>:</span></td>
  <td class=xl24></td>
  <td colspan=13 rowspan=2 class=xl90 width=892 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:669pt;font-size:14pt'><%=Inword%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl37 colspan=4 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Amount transfer in words:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=4 align=left style='mso-ignore:colspan'>(*) Tên Người
  Chuyển Tiền:</td>
  <td colspan=13 rowspan=2 class=xl94 width=892 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:669pt;font-size:14pt'><%=p_D_Acc_Nm %></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl37 colspan=4 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Name of Remitter:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:35.1pt'>
  <td height=46 class=xl28 style='height:35.1pt'>&nbsp;</td>
  <td class=xl41 colspan=2 align=left style='mso-ignore:colspan'>Địa chỉ/
  Address<span style='display:none'>:</span></td>
  <td class=xl24></td>
  <td colspan=14 class=xl96 width=956 style='border-right:1.0pt solid black;
  width:717pt;font-size:14pt'><%=p_D_Add%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl43 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=8 align=left style='mso-ignore:colspan'>(*) Để thanh
  toán, xin ghi nợ tài khoản của tôi/ chúng tôi số:</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1038"
   style='position:absolute;direction:LTR;text-align:left;margin-left:18.75pt;
   margin-top:6pt;width:23.25pt;height:28.5pt;z-index:8;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;direction:LTR;
   text-align:left;margin-left:42pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:9;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;direction:LTR;
   text-align:left;margin-left:65.25pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:10;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:8;margin-left:24px;margin-top:7px;width:95px;height:40px'><img
  width=95 height=40 src="TELEGRAPHIC_TRANSFER_files/image002.gif" v:shapes="_x0000_s1038 _x0000_s1039 _x0000_s1040"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl44 width=64 style='height:20.1pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl44></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1041"
   style='position:absolute;direction:LTR;text-align:left;margin-left:5.25pt;
   margin-top:6pt;width:23.25pt;height:28.5pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;direction:LTR;
   text-align:left;margin-left:28.5pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:12;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;direction:LTR;
   text-align:left;margin-left:51.75pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:13;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;direction:LTR;
   text-align:left;margin-left:75pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:14;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1045" style='position:absolute;direction:LTR;
   text-align:left;margin-left:98.25pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:15;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;direction:LTR;
   text-align:left;margin-left:121.5pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:16;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:11;margin-left:6px;margin-top:7px;width:188px;height:40px'><img
  width=188 height=40 src="TELEGRAPHIC_TRANSFER_files/image003.gif" v:shapes="_x0000_s1041 _x0000_s1042 _x0000_s1043 _x0000_s1044 _x0000_s1045 _x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl44 width=78 style='height:20.1pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1047"
   style='position:absolute;direction:LTR;text-align:left;margin-left:1.5pt;
   margin-top:6pt;width:23.25pt;height:28.5pt;z-index:17;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;direction:LTR;
   text-align:left;margin-left:24.75pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:18;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1049" style='position:absolute;direction:LTR;
   text-align:left;margin-left:48pt;margin-top:6pt;width:23.25pt;height:28.5pt;
   z-index:19;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1050" style='position:absolute;direction:LTR;
   text-align:left;margin-left:79.5pt;margin-top:12.75pt;width:15.75pt;
   height:15.75pt;z-index:20' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:17;margin-left:1px;
  margin-top:7px;width:127px;height:40px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=95></td>
    <td width=9></td>
    <td width=23></td>
   </tr>
   <tr>
    <td height=9></td>
    <td rowspan=3 align=left valign=top><img width=95 height=40
    src="TELEGRAPHIC_TRANSFER_files/image004.gif" v:shapes="_x0000_s1047 _x0000_s1048 _x0000_s1049"></td>
   </tr>
   <tr>
    <td height=23></td>
    <td></td>
    <td align=left valign=top><img width=23 height=23
    src="TELEGRAPHIC_TRANSFER_files/image005.gif" v:shapes="_x0000_s1050"></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl44 width=64 style='height:20.1pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl44></td>
  <td class=xl45 colspan=2 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'>từ khoản vay</td>
  <td class=xl47>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl28 style='height:20.25pt'>&nbsp;</td>
  <td class=xl37 colspan=9 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>When making this payment, please debit my/
  our account number:</td>
  <td class=xl40 align=left><span style='mso-spacerun:yes'>             
  </span>-</td>
  <td class=xl40 align=left><span style='mso-spacerun:yes'>      </span>-</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl48><span style='mso-spacerun:yes'>             </span>-</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl49 colspan=2 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'>from loan disbursement</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl51 colspan=16 align=left style='mso-ignore:colspan'>(*) Phí Ngân
  Hàng bao gồm Phí của Ngân Hàng Khác/ Bank's Charges including Other Banks'
  Charges<font class="font0"> (Chỉ chọn 1 trong 3 loại/ Please choose 1 from 3
  options):</font></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1035"
   style='position:absolute;direction:LTR;text-align:left;margin-left:3.75pt;
   margin-top:6.75pt;width:16.5pt;height:18pt;z-index:5' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:5;margin-left:4px;
  margin-top:8px;width:24px;height:26px'><img width=24 height=26
  src="TELEGRAPHIC_TRANSFER_files/image001.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl54 align=left width=64 style='height:15.0pt;
    width:48pt'><span style='mso-spacerun:yes'>       </span>do người chuyển
    chịu, xin ghi nợ tài khoản số:</td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1036"
   style='position:absolute;direction:LTR;text-align:left;margin-left:39pt;
   margin-top:6.75pt;width:16.5pt;height:18pt;z-index:6' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:6;margin-left:51px;
  margin-top:8px;width:24px;height:26px'><img width=24 height=26
  src="TELEGRAPHIC_TRANSFER_files/image001.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 colspan=3 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>do người thụ hưởng chịu</td>
  <td rowspan=2 height=40 class=xl24 width=64 style='mso-ignore:colspan-rowspan;
  height:30.0pt;width:48pt'><!--[if gte vml 1]><v:rect id="_x0000_s1037"
   style='position:absolute;direction:LTR;text-align:left;margin-left:30pt;
   margin-top:6.75pt;width:16.5pt;height:18pt;z-index:7' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=39 height=8></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=24 height=26 src="TELEGRAPHIC_TRANSFER_files/image001.gif"
    v:shapes="_x0000_s1037"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:30.0pt'></span><![endif]--></td>
  <td class=xl24 colspan=5 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'>chia cho người hưởng và người chuyển (chỉ áp dụng</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54 colspan=8 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>       </span>are for remitter's account, please
  debit account number:</td>
  <td class=xl24 colspan=3 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>are for beneficiary's account</td>
  <td class=xl24 colspan=4 align=left style='mso-ignore:colspan'>cho lệnh
  chuyển tiền đi nước ngoài)</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1051"
   style='position:absolute;direction:LTR;text-align:left;margin-left:4.5pt;
   margin-top:6.75pt;width:23.25pt;height:28.5pt;z-index:21;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1052" style='position:absolute;direction:LTR;
   text-align:left;margin-left:27.75pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:22;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1053" style='position:absolute;direction:LTR;
   text-align:left;margin-left:51pt;margin-top:6.75pt;width:23.25pt;height:28.5pt;
   z-index:23;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1054" style='position:absolute;direction:LTR;
   text-align:left;margin-left:84pt;margin-top:6.75pt;width:23.25pt;height:28.5pt;
   z-index:24;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1055" style='position:absolute;direction:LTR;
   text-align:left;margin-left:107.25pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:25;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1056" style='position:absolute;direction:LTR;
   text-align:left;margin-left:130.5pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:26;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1057" style='position:absolute;direction:LTR;
   text-align:left;margin-left:153.75pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:27;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1058" style='position:absolute;direction:LTR;
   text-align:left;margin-left:177pt;margin-top:6.75pt;width:23.25pt;height:28.5pt;
   z-index:28;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1059" style='position:absolute;direction:LTR;
   text-align:left;margin-left:200.25pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:29;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1060" style='position:absolute;direction:LTR;
   text-align:left;margin-left:233.25pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:30;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1061" style='position:absolute;direction:LTR;
   text-align:left;margin-left:256.5pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:31;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1062" style='position:absolute;direction:LTR;
   text-align:left;margin-left:279.75pt;margin-top:6.75pt;width:23.25pt;
   height:28.5pt;z-index:32;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:6.0pt;direction:ltr'><font
    class="font13"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:21;margin-left:5px;margin-top:8px;width:400px;height:40px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=95></td>
    <td width=11></td>
    <td width=188></td>
    <td width=11></td>
    <td width=95></td>
   </tr>
   <tr>
    <td height=40></td>
    <td align=left valign=top><img width=95 height=40
    src="TELEGRAPHIC_TRANSFER_files/image002.gif" v:shapes="_x0000_s1051 _x0000_s1052 _x0000_s1053"></td>
    <td></td>
    <td align=left valign=top><img width=188 height=40
    src="TELEGRAPHIC_TRANSFER_files/image003.gif" v:shapes="_x0000_s1054 _x0000_s1055 _x0000_s1056 _x0000_s1057 _x0000_s1058 _x0000_s1059"></td>
    <td></td>
    <td align=left valign=top><img width=95 height=40
    src="TELEGRAPHIC_TRANSFER_files/image004.gif" v:shapes="_x0000_s1060 _x0000_s1061 _x0000_s1062"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl54 width=64 style='height:15.0pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=5 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'>are shared for remitter and beneficiary (applicable fo<span
  style='display:none'>r</span></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl24 align=left><span style='mso-spacerun:yes'>         </span>-</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24 align=left><span style='mso-spacerun:yes'>     </span>-</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 align=left style='mso-ignore:colspan'>overseas
  payment)</td>
  <td class=xl24></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=4 align=left style='mso-ignore:colspan'>(*) Tên Người
  Thụ Hưởng:</td>
  <td colspan=13 rowspan=2 class=xl98 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;font-size:14pt'><%=p_C_Acc_Nm%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl37 colspan=4 align=left style='mso-ignore:colspan'>Name of
  Beneficiary:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl32 colspan=17 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'>(*) Tên và Địa Chỉ Ngân Hàng của Người Thụ Hưởng<font
  class="font12"> (Thông tin chi tiết bao gồm Tên Ngân hàng, Chi nhánh và Địa
  chỉ (Tỉnh/ Thành/ Quốc Gia)):</font></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl58 colspan=17 align=left style='mso-ignore:colspan;border-right:
  1.0pt solid black'><span style='mso-spacerun:yes'>    </span>Name and Address
  of the Beneficiary's Bank<font class="font12"> (Please provide details
  including Beneficiary's Bank name, Branch and Address (Province/ City/ C</font><span
  style='display:none'><font class="font12">ountry)):</font></span></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr class=xl60 height=46 style='mso-height-source:userset;height:35.1pt'>
  <td height=46 class=xl61 width=13 style='height:35.1pt;width:10pt'>&nbsp;</td>
  <td colspan=17 class=xl102 width=1108 style='border-right:1.0pt solid black;
  width:831pt;font-size:14pt'><%=p_C_Bank%></td>
  <td class=xl62 width=16 style='width:12pt'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl63 colspan=5 align=left style='mso-ignore:colspan'>(*) Tài khoản
  Người Thụ Hưởng Số:</td>
  <td class=xl64 colspan=2 align=left style='mso-ignore:colspan;font-size:14pt'><%=p_C_Acc_No%></td>
  <td class=xl64></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl63 colspan=5 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Beneficiary's Account Number:</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl28 style='height:6.75pt'>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl65 colspan=6 align=left style='mso-ignore:colspan'>(*) Mã Số
  Thanh Toán của Ngân Hàng :</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl28 style='height:14.25pt'>&nbsp;</td>
  <td class=xl58 colspan=6 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Bank Clearing Code/ SWIFT Code:</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt'>&nbsp;</td>
  <td class=xl66 colspan=10 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>(Áp dụng cho điện chuyển tiền ra nước
  ngoài)/ (Applicable for Overseas payments)</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 class=xl28 style='height:39.95pt'>&nbsp;</td>
  <td colspan=6 class=xl105 width=344 style='width:258pt'>(*) Nội dung Thanh
  toán/ Payment Narrative:<br>
    <span style='mso-spacerun:yes'>   </span><font class="font14"><span
  style='mso-spacerun:yes'> </span>(Tối đa 140 ký tự/ Maximum 140 characters)</font></td>
  <td colspan=11 rowspan=2 class=xl106 width=764 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:573pt;font-size:14pt'><%=p_Remark%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl28 style='height:20.25pt'>&nbsp;</td>
  <td class=xl55 align=left x:str="    "><span
  style='mso-spacerun:yes'>    </span></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl67 colspan=6 align=left style='mso-ignore:colspan'>Áp dụng cho
  Lệnh Thanh Toán Thuế, gồm c<span style='display:none'>ó/ Applicable for Tax
  Payment, please include:</span></td>
  <td colspan=8 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl70 colspan=5 align=left style='mso-ignore:colspan'
  x:str="Tờ Khai Hải Quan/ Quyết Định số:  ">Tờ Khai Hải Quan/ Quyết Định
  số:<span style='mso-spacerun:yes'>  </span></td>
  <td colspan=4 class=xl64 style='mso-ignore:colspan'></td>
  <td class=xl69 align=left>Ngày:</td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td class=xl69 colspan=4 align=left style='mso-ignore:colspan'>Loại Hình Xuất
  Nhập Khẩu:</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl72 colspan=6 align=left style='mso-ignore:colspan'>Customs
  Declaration/ Decision Number:</td>
  <td colspan=3 class=xl64 style='mso-ignore:colspan'></td>
  <td class=xl71 align=left><span style='mso-spacerun:yes'> </span>Date:</td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td class=xl71 colspan=3 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Import/ Export Type:</td>
  <td class=xl24></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl70 colspan=3 align=left style='mso-ignore:colspan'>Người Nộp
  Thuế:</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl69 colspan=2 align=left style='mso-ignore:colspan'>Mã số Thuế:</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1063"
   style='position:absolute;z-index:33' from="7.5pt,19.5pt" to="819.75pt,19.5pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><v:line
   id="_x0000_s1064" style='position:absolute;z-index:34' from="7.5pt,19.5pt"
   to="7.5pt,127.5pt" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto"/><v:line id="_x0000_s1065" style='position:absolute;
   z-index:35' from="8.25pt,49.5pt" to="819.75pt,49.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1066" style='position:absolute;
   z-index:36' from="51.75pt,20.25pt" to="51.75pt,108pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1067" style='position:absolute;
   z-index:37' from="203.25pt,20.25pt" to="203.25pt,108pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1068" style='position:absolute;
   z-index:38' from="342pt,19.5pt" to="342pt,108pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1069" style='position:absolute;
   z-index:39' from="415.5pt,19.5pt" to="415.5pt,107.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1070" style='position:absolute;
   z-index:40' from="6.75pt,69pt" to="819.75pt,69pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1071" style='position:absolute;
   z-index:41' from="7.5pt,88.5pt" to="819.75pt,88.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1073" style='position:absolute;
   z-index:42' from="7.5pt,108pt" to="820.5pt,108pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1074" style='position:absolute;
   z-index:43' from="820.5pt,19.5pt" to="820.5pt,126.75pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><v:line id="_x0000_s1075" style='position:absolute;
   z-index:44' from="709.5pt,19.5pt" to="709.5pt,127.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1076" style='position:absolute;
   z-index:45' from="489.75pt,20.25pt" to="489.75pt,108pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1077" style='position:absolute;
   z-index:46' from="564pt,19.5pt" to="564pt,107.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1079" style='position:absolute;
   z-index:47' from="639pt,19.5pt" to="639pt,107.25pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1080" style='position:absolute;
   z-index:48' from="7.5pt,127.5pt" to="820.5pt,127.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1081" style='position:absolute;
   z-index:49' from="342pt,134.25pt" to="342pt,283.5pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1082" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:756.75pt;margin-top:213.75pt;
   width:73.5pt;height:64.5pt;z-index:50'>
   <v:imagedata src="TELEGRAPHIC_TRANSFER_files/image006.png" o:title="Ảnh chụp màn hình_2012-06-14_150409"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:33;margin-left:8px;margin-top:25px;width:1099px;
  height:354px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=447></td>
    <td width=2></td>
    <td width=552></td>
    <td width=86></td>
    <td width=12></td>
   </tr>
   <tr>
    <td height=146></td>
    <td colspan=4 align=left valign=top><img width=1087 height=146
    src="TELEGRAPHIC_TRANSFER_files/image007.gif" v:shapes="_x0000_s1063 _x0000_s1064 _x0000_s1065 _x0000_s1066 _x0000_s1067 _x0000_s1068 _x0000_s1069 _x0000_s1070 _x0000_s1071 _x0000_s1073 _x0000_s1074 _x0000_s1075 _x0000_s1076 _x0000_s1077 _x0000_s1079 _x0000_s1080"></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
   <tr>
    <td height=107></td>
    <td></td>
    <td rowspan=3 align=left valign=top><img width=2 height=201
    src="TELEGRAPHIC_TRANSFER_files/image008.gif" v:shapes="_x0000_s1081"></td>
   </tr>
   <tr>
    <td height=86></td>
    <td></td>
    <td></td>
    <td colspan=2 align=left valign=top><img width=98 height=86
    src="TELEGRAPHIC_TRANSFER_files/image009.gif" v:shapes="_x0000_s1082"></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl72 align=left width=64 style='height:20.1pt;
    width:48pt'>Tax Payer:</td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl71 colspan=2 align=left style='mso-ignore:colspan'>Tax Code:</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl28 style='height:30.0pt'>&nbsp;</td>
  <td class=xl73 align=left width=64 style='width:48pt'><span
  style='mso-spacerun:yes'>      </span>STT<br>
    <span style='mso-spacerun:yes'>       </span>No.</td>
  <td colspan=4 class=xl110 width=216 style='width:162pt'>Loại thuế<br>
    Tax type</td>
  <td colspan=2 class=xl103 width=128 style='width:96pt'><span
  style='mso-spacerun:yes'>               </span>Kỳ thuế<br>
    <span style='mso-spacerun:yes'>           </span>Tax Period</td>
  <td class=xl24></td>
  <td colspan=3 class=xl103 width=206 style='width:155pt'>Chương<span
  style='mso-spacerun:yes'>             </span>Loại<br>
    Chapter<span style='mso-spacerun:yes'>             </span>Type</td>
  <td colspan=4 class=xl103 width=256 style='width:192pt'><span
  style='mso-spacerun:yes'> </span>Khoản<span
  style='mso-spacerun:yes'>              </span>Mục<span
  style='mso-spacerun:yes'>            </span>Tiểu mục<br>
    Section<span style='mso-spacerun:yes'>             </span>Item<span
  style='mso-spacerun:yes'>             </span>Sub Item</td>
  <td colspan=2 class=xl110 width=174 style='border-right:1.0pt solid black;
  width:130pt'>Số tiền<br>
    Amount</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl69 colspan=3 align=left style='mso-ignore:colspan'>Tổng số tiền/
  Total:</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl28 style='height:7.5pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl74 colspan=8 align=left style='mso-ignore:colspan'>Khách Hàng ký
  và Đóng dấu/ Remitter or Applicant's Signature(s) and Stamp</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl75 colspan=6 align=left style='mso-ignore:colspan'>Chữ ký điện tử
  không có hiệu lực/ e-Signature is not valid</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=8 align=left style='mso-ignore:colspan'>Tôi / Chúng
  tôi đã đọc và đồng ý tuân thủ các Điều Khoản và Điều Kiện</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=8 align=left style='mso-ignore:colspan'>áp dụng đối
  với việc chuyển tiền bằng Điện/Hối Phiếu trong nước</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=8 align=left style='mso-ignore:colspan'>được quy định
  và sửa đổi theo quyết định của Ngân Hàng tùy từng</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=2 align=left style='mso-ignore:colspan'>thời điểm.</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
  <td rowspan=6 class=xl112>TLG0509_FB</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=8 align=left style='mso-ignore:colspan'>I / We hereby
  confirm that I / We have read and fully agreed to be</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=8 align=left style='mso-ignore:colspan'>bound by the
  Terms and Conditions applicable to TT/DD as specified</td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76 colspan=6 align=left style='mso-ignore:colspan'>and amended by
  the Bank from time to time.</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl28 style='height:8.25pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl28 style='height:7.5pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl77 style='height:15.0pt'>&nbsp;</td>
  <td class=xl78 colspan=7 align=left style='mso-ignore:colspan'>(*) Mục quan
  trọng cần phải điền đầy đủ/ Compulsory Fields</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80 colspan=9 align=left style='mso-ignore:colspan'>Phát hành bởi
  Ngân hàng TNHH một thành viên HSBC (Việt Nam)/ Issued by HSBC Bank (Vietnam)
  Ltd.</td>
  <td class=xl81>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=16 style='width:12pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
