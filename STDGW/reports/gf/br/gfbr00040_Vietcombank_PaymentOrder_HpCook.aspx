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
        DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
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
            if(dt.Rows[0][9].ToString().Trim()!="")
			{
				p_D_Bank = dt.Rows[0][9].ToString();
			}
			else
			{
				p_D_Bank = "VIETCOMBANK ĐỒNG NAI - Biên Hòa";
			}
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
        DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
        if (dt_Amount.Rows.Count > 0)
        {
            p_Amt = dt_Amount.Rows[0][13].ToString();
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
<link rel=File-List href="Vietcombank_PaymentOrder_HPCook_files/filelist.xml">
<link rel=Edit-Time-Data
href="Vietcombank_PaymentOrder_HPCook_files/editdata.mso">
<link rel=OLE-Object-Data
href="Vietcombank_PaymentOrder_HPCook_files/oledata.mso">
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
  <o:LastPrinted>2012-10-02T15:22:23Z</o:LastPrinted>
  <o:Created>2011-07-29T01:24:58Z</o:Created>
  <o:LastSaved>2012-10-02T15:32:14Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .17in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
.font0
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
	mso-number-format:"d\\-mmm";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
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
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
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
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
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
.xl47
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
.xl48
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
.xl49
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
.xl50
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
.xl51
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
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
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
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
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
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style16;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style16;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
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
.xl72
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
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
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
.xl84
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
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl86
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
.xl87
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
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
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
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl93
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
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
      <x:Scale>97</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>19</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10995</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1229"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=701 style='border-collapse:
 collapse;table-layout:fixed;width:528pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=14 style='mso-width-source:userset;mso-width-alt:512;
 width:11pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:329'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <%
     for(int p=0;p<2;p++)
     {%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=3 width=126 style='height:15.0pt;mso-ignore:
  colspan;width:95pt'>VIETCOMBANK</td>
  <td class=xl27 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl27 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl27 width=45 style='width:34pt'>&nbsp;</td>
  <td class=xl27 width=14 style='width:11pt'>&nbsp;</td>
  <td class=xl27 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl27 width=60 style='width:45pt'>&nbsp;</td>
  <td class=xl27 width=39 style='width:29pt'>&nbsp;</td>
  <td class=xl27 width=65 style='width:49pt'>&nbsp;</td>
  <td class=xl27 width=39 style='width:29pt'>&nbsp;</td>
  <td class=xl27 width=62 style='width:47pt'>&nbsp;</td>
  <td class=xl28 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl24 width=0></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=14 height=25 class=xl58 style='border-right:.5pt solid black;
  height:18.75pt'>ỦY NHIỆM CHI - <font class="font8">PAYMENT ORDER</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=14 height=26 width=701 style='border-right:.5pt solid black;
  height:20.1pt;width:528pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1195" style='position:absolute;z-index:6' from="270.75pt,15pt"
   to="316.5pt,15pt" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:6;margin-left:360px;margin-top:19px;width:63px;height:2px'><img
  width=63 height=2 src="Vietcombank_PaymentOrder_HPCook_files/image001.gif"
  v:shapes="_x0000_s1195"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=14 height=26 class=xl61 width=701 style='border-right:.5pt solid black;
    height:20.1pt;width:528pt'>Ngày (<font class="font10">Date)</font><font
    class="font9">:<span style='mso-spacerun:yes'>  </span><%=p_Date %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl30 style='height:3.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl34 style='height:9.0pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl29 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'>&nbsp;</td>
  <td class=xl38 colspan=6 style='mso-ignore:colspan'>ĐỀ NGHỊ GHI NỢ TÀI KHOẢN <font
  class="font10">(Please Debit account):</font></td>
  <td class=xl38 colspan=3 style='mso-ignore:colspan'>SỐ TIỀN<font
  class="font10"> (With amount):</font></td>
  <td class=xl39></td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black'>PHÍ NH<font
  class="font9"> </font><font class="font10">(Bank charges)</font></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl66 style='border-right:.5pt solid black'>SỐ TK <font
  class="font10">(A/C No)</font><font class="font9">: </font><font
  class="font11"><span style='mso-spacerun:yes'>  </span><%=p_D_Acc_No %></font></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl43 colspan=2 style='mso-ignore:colspan'>BẰNG SỐ <font  class="font10">(In figures)</font><font class="font9">:</font></td>
  <td colspan=2 class=xl69 style='border-right:.5pt solid black' ><%=p_Amt%></td>
  <td class=xl44><%=p_Ccy %></td>
  <td width=62 style='width:47pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_1" o:spid="_x0000_s1185" style='position:absolute;
   margin-left:46.5pt;margin-top:23.25pt;width:20.25pt;height:15pt;z-index:1;
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
   margin-left:46.5pt;margin-top:7.5pt;width:20.25pt;height:15.75pt;z-index:2;
   visibility:visible;mso-wrap-style:tight;v-text-anchor:middle' fillcolor="window"
   strokecolor="windowText" strokeweight=".5pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:61px;margin-top:9px;width:29px;height:43px'><img
  width=29 height=43 src="Vietcombank_PaymentOrder_HPCook_files/image002.gif"
  v:shapes="Rectangle_x0020_1 Rectangle_x0020_2"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 class=xl45 width=62 style='height:24.95pt;width:47pt'>Phí
    trong<font class="font9"><br>
        </font><font class="font12">Including</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=298 style='border-right:.5pt solid black;
  width:224pt'>TÊN TK <font class="font10">(A/c name)</font><font class="font9">:<span
  style='mso-spacerun:yes'>  </span></font><font class="font11"><span
  style='mso-spacerun:yes'> </span><%=p_D_Acc_Nm %></font></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=5 rowspan=3 class=xl74 width=264 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:198pt'>BẰNG CHỮ <font class="font10">(
  In words): </font><font class="font9"><%=Inword %></font></td>
  <td class=xl45 width=62 style='width:47pt'>Phí ngoài<font class="font9"><br>
    </font><font class="font12">Excludin</font><font class="font13">g</font></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=298 style='border-right:.5pt solid black;  width:224pt' >ĐỊA CHỈ (Address): <%= p_D_Add%></td>
  <td class=xl40></td>
  <td class=xl29></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl36 style='height:12.95pt'>&nbsp;</td>
  <td colspan=5 rowspan=2 class=xl83 width=298 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:224pt'>TẠI NH<font class="font10"> (With
  bank)</font><font class="font9">:<span style='mso-spacerun:yes'> 
  </span><%= p_D_Bank%></font></td>
  <td class=xl40></td>
  <td class=xl29></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl36 style='height:12.95pt'>&nbsp;</td>
  <td class=xl40></td>
  <td colspan=5 class=xl89>&nbsp;</td>
  <td class=xl29></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl36 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl90>&amp; GHI CÓ TÀI KHOẢN<font class="font9"> </font><font
  class="font10">(&amp; Credit account):</font></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1190"
   style='position:absolute;z-index:4' from="148.5pt,12pt" to="4in,12pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1188" style='position:absolute;flip:y;z-index:3'
   from="10.5pt,24.75pt" to="288.75pt,24.75pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:13px;margin-top:15px;width:373px;height:19px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=184></td>
    <td width=188></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=188 height=2
    src="Vietcombank_PaymentOrder_HPCook_files/image003.gif" v:shapes="_x0000_s1190"></td>
   </tr>
   <tr>
    <td height=15></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=3 align=left valign=top><img width=373 height=2
    src="Vietcombank_PaymentOrder_HPCook_files/image004.gif" v:shapes="_x0000_s1188"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl29 width=14 style='height:20.1pt;width:11pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 rowspan=2 class=xl91 width=379 style='border-right:.5pt solid black;
  width:285pt'>NỘI DUNG<font class="font10"> (Details of Payment): </font><font
  class="font9"><%= p_Remark%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'>&nbsp;</td>
  <td colspan=5 class=xl93 style='border-right:.5pt solid black'>SỐ TK<font
  class="font10"> (A/C No):</font><font class="font9"><span
  style='mso-spacerun:yes'>  </span></font><font class="font11"><%= p_C_Acc_No%></font></td>
  <td class=xl29></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=298 style='border-right:.5pt solid black;
  width:224pt'>TÊN TK (A/c name):<span style='mso-spacerun:yes'>  </span><font
  class="font11"><span style='mso-spacerun:yes'> </span><%= p_C_Acc_Nm%></font></td>
  <td class=xl29></td>
  <td colspan=3 class=xl45 width=160 style='width:120pt'>KẾ TOÁN TRƯỞNG
  KÝ<br>
    <font class="font10">Chief accountant</font></td>
  <td colspan=4 class=xl45 width=219 style='border-right:.5pt solid black;
  width:165pt'>CHỦ TÀI KHOẢN KÝ VÀ ĐÓNG DẤU<br>
    <font class="font10">Acc. Holder &amp; Stamp</font></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=298 style='border-right:.5pt solid black;
  width:224pt'>ĐỊA CHỈ<font class="font10"> (Address):<span
  style='mso-spacerun:yes'>  </span><%= p_C_Add%></font></td>
  <td class=xl29></td>
  <td colspan=3 class=xl97></td>
  <td colspan=4 class=xl97 style='border-right:.5pt solid black'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl36 style='height:24.95pt'>&nbsp;</td>
  <td colspan=5 class=xl71 width=298 style='border-right:.5pt solid black;
  width:224pt'>TẠI
  NH (With bank): <%= p_C_Bank%></td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl36 style='height:6.75pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl49 style='height:9.0pt'>&nbsp;</td>
  <td colspan=12 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=18 style='height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1194"
   style='position:absolute;z-index:5' from="2.25pt,13.5pt" to="209.25pt,13.5pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:5;margin-left:2px;
  margin-top:17px;width:278px;height:2px'><img width=278 height=2
  src="Vietcombank_PaymentOrder_HPCook_files/image005.gif" v:shapes="_x0000_s1194"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=18 class=xl37 width=48 style='height:13.5pt;width:36pt'>DÀNH CHO
    NGÂN HÀNG (<font class="font14">For Bank's Use only</font><font
    class="font11">)<span style='mso-spacerun:yes'>     </span>MÃ VAT:</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl36 style='height:8.1pt'>&nbsp;</td>
  <td class=xl37></td>
  <td colspan=11 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29></td>
 </tr>
 <tr class=xl37 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl50 style='height:12.0pt'>&nbsp;</td>
  <td colspan=5 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl37 colspan=3 style='mso-ignore:colspan'>Thanh toán viên</td>
  <td colspan=2 class=xl99>Kiểm soát</td>
  <td class=xl37></td>
  <td class=xl37>Giám đốc</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl37></td>
 </tr>
 <tr class=xl52 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl53 style='height:14.1pt'>&nbsp;</td>
  <td colspan=12 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52></td>
 </tr>
 <tr class=xl52 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl53 style='height:14.1pt'>&nbsp;</td>
  <td colspan=12 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52></td>
 </tr>
 <tr class=xl52 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl53 style='height:14.1pt'>&nbsp;</td>
  <td colspan=12 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52></td>
 </tr>
 <tr class=xl52 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl55 style='height:14.1pt'>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl52></td>
 </tr>
 <tr class=xl52 height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 colspan=15 class=xl52 style='height:39.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=10 style='width:8pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
