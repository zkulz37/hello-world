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
    string p_Phone = "";
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
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
        p_Phone = dt.Rows[0][23].ToString();
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
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][13].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        
        
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
        //p_Amt1 = "123456789012.00";
        //p_D_Acc_No = "3456789012";
        //Response.Write(p_Amt1[p_Amt1.Length - 11]);
        //Response.End();
    }
    p_C_Acc_No = p_C_Acc_No.Replace("-","");
    p_C_Acc_No = p_C_Acc_No.Replace(".","");
    p_D_Acc_No = p_D_Acc_No.Replace("-","");
    p_D_Acc_No = p_D_Acc_No.Replace(".","");
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="SHB_files/filelist.xml">
<link rel=Edit-Time-Data href="SHB_files/editdata.mso">
<link rel=OLE-Object-Data href="SHB_files/oledata.mso">
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
  <o:LastPrinted>2012-01-31T03:43:20Z</o:LastPrinted>
  <o:Created>2012-01-18T08:27:42Z</o:Created>
  <o:LastSaved>2012-01-31T03:45:25Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .5in .85in .3in;
	mso-header-margin:0in;
	mso-footer-margin:.86in;}
.font6
	{color:#333399;
	font-size:22.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:#333399;
	font-size:19.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:#333399;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:#333399;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:#333399;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#333399;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:#333399;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:#333399;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:white;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:#333399;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:#333399;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-text-control:shrinktofit;
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
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl26
	{mso-style-parent:style0;
	color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl27
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;}
.xl33
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl37
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl41
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;}
.xl44
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	color:#333399;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl49
	{mso-style-parent:style0;
	color:#333399;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	color:#333399;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl54
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:.5pt solid #333399;
	background:#333399;
	mso-pattern:auto none;
	white-space:normal;
	mso-rotate:90;}
.xl75
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:.5pt solid #333399;
	background:#333399;
	mso-pattern:auto none;
	white-space:normal;
	mso-rotate:90;}
.xl76
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;
	background:#333399;
	mso-pattern:auto none;
	white-space:normal;
	mso-rotate:90;}
.xl77
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl91
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl93
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid #333399;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:none;
	border-left:none;}
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
      <x:Scale>79</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>19</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
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
 <o:shapedefaults v:ext="edit" spidmax="1098"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=962 style='border-collapse:
 collapse;table-layout:fixed;width:723pt'>
 <col class=xl24 width=64 span=5 style='width:48pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=9 height=43 width=556 style='height:32.25pt;width:418pt'
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
  </v:shapetype><v:shape id="_x0000_s1067" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:8.25pt;margin-top:3.75pt;width:33pt;
   height:32.25pt;z-index:21'>
   <v:imagedata src="SHB_files/image001.png" o:title="20111201055919_viipipdotcom_1185shinhan_bank_logo_2792"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:21;margin-left:11px;margin-top:5px;width:44px;
  height:43px'><img width=44 height=43 src="SHB_files/image002.jpg" v:shapes="_x0000_s1067"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 height=43 class=xl49 align=left width=556 style='height:32.25pt;
    width:418pt'><span style='mso-spacerun:yes'>        </span>S<font
    class="font7">HINHAN</font><font class="font8"> </font><font class="font6">B</font><font
    class="font7">ANK</font><font class="font6"> </font><font class="font9">VIETNAM</font></td>
   </tr>
  </table>
  </span></td>
  <td width=76 style='width:57pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1025" style='position:absolute;direction:LTR;text-align:left;
   margin-left:45.75pt;margin-top:3pt;width:11.25pt;height:10.5pt;z-index:1'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><v:rect
   id="_x0000_s1026" style='position:absolute;direction:LTR;text-align:left;
   margin-left:45.75pt;margin-top:18.75pt;width:11.25pt;height:10.5pt;
   z-index:2' fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:60px;
  margin-top:3px;width:17px;height:37px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=17></td>
   </tr>
   <tr>
    <td height=16></td>
    <td align=left valign=top><img width=17 height=16
    src="SHB_files/image003.gif" v:shapes="_x0000_s1025"></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
   <tr>
    <td height=16></td>
    <td align=left valign=top><img width=17 height=16
    src="SHB_files/image003.gif" v:shapes="_x0000_s1026"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=43 class=xl25 width=76 style='height:32.25pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl50 width=251 style='width:189pt'><span
  style='mso-spacerun:yes'> </span>Rút tiền mặt/ <font class="font12">Cash
  Withdrawal</font><font class="font13"><br>
    <span style='mso-spacerun:yes'> </span></font><font class="font11">Chuyển
  khoản nội bộ/ </font><font class="font12">Fund Transfer</font></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1028"
   style='position:absolute;direction:LTR;text-align:left;margin-left:45.75pt;
   margin-top:3pt;width:11.25pt;height:10.5pt;z-index:3' fillcolor="window [65]"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:3;margin-left:60px;
  margin-top:3px;width:17px;height:16px'><img width=17 height=16
  src="SHB_files/image003.gif" v:shapes="_x0000_s1028"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=76 style='height:15.75pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 colspan=5 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>Đổi tiền/ <font class="font12">Foreign
  Exchange</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=9 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1030"
   style='position:absolute;direction:LTR;text-align:left;margin-left:45.75pt;
   margin-top:3pt;width:11.25pt;height:10.5pt;z-index:4' fillcolor="window [65]"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:4;margin-left:60px;
  margin-top:3px;width:17px;height:16px'><img width=17 height=16
  src="SHB_files/image003.gif" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=25 class=xl24 width=76 style='height:18.75pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 colspan=5 align=left style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>Đóng tài khoản/ <font class="font12">Close
  Account</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=10 class=xl27 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl27 colspan=6 align=left style='mso-ignore:colspan'>Ngày/<font
  class="font15">Date:</font><font class="font14">….<%=p_Date %>…./…<%=p_Month %>…./….<%=p_Year %>….</font></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 height=40 width=423 style='border-right:.5pt solid #333399;
  height:30.0pt;width:317pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1068" style='position:absolute;z-index:22' from="64.5pt,13.5pt"
   to="311.25pt,13.5pt" strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1097" style='position:absolute;z-index:51'
   from="3pt,29.25pt" to="311.25pt,29.25pt" strokecolor="#339 [62]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:22;margin-left:3px;margin-top:17px;width:413px;height:23px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=82></td>
    <td width=331></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=331 height=2
    src="SHB_files/image004.gif" v:shapes="_x0000_s1068"></td>
   </tr>
   <tr>
    <td height=19></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2 align=left valign=top><img width=413 height=2
    src="SHB_files/image005.gif" v:shapes="_x0000_s1097"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=40 class=xl51 width=423 style='border-right:.5pt solid #333399;
    height:30.0pt;width:317pt'>Đơn vị/<font class="font15">Name: </font><font
    class="font14"><%=p_D_Acc_Nm %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl29 colspan=3 align=left style='mso-ignore:colspan'>Tài khoản số/ <font
  class="font15">Accoun</font><span style='display:none'><font class="font15">t
  no:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1076"
   style='position:absolute;direction:LTR;text-align:left;margin-left:22.5pt;
   margin-top:6.75pt;width:15.75pt;height:17.25pt;z-index:30;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" strokeweight=".5pt"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1077" style='position:absolute;direction:LTR;
   text-align:left;margin-left:39.75pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:31;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1078" style='position:absolute;direction:LTR;
   text-align:left;margin-left:57pt;margin-top:6.75pt;width:15.75pt;height:17.25pt;
   z-index:32;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1080" style='position:absolute;direction:LTR;
   text-align:left;margin-left:81pt;margin-top:6.75pt;width:15.75pt;height:17.25pt;
   z-index:34;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1081" style='position:absolute;direction:LTR;
   text-align:left;margin-left:98.25pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:35;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1082" style='position:absolute;direction:LTR;
   text-align:left;margin-left:115.5pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:36;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1079" style='position:absolute;z-index:33'
   from="75pt,15.75pt" to="78.75pt,15.75pt" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto"/><v:rect id="_x0000_s1084" style='position:absolute;
   direction:LTR;text-align:left;margin-left:139.5pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:38;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1085" style='position:absolute;direction:LTR;
   text-align:left;margin-left:156.75pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:39;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1086" style='position:absolute;direction:LTR;
   text-align:left;margin-left:174pt;margin-top:6.75pt;width:15.75pt;height:17.25pt;
   z-index:40;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1087" style='position:absolute;direction:LTR;
   text-align:left;margin-left:191.25pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:41;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1088" style='position:absolute;direction:LTR;
   text-align:left;margin-left:208.5pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:42;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1089" style='position:absolute;direction:LTR;
   text-align:left;margin-left:225.75pt;margin-top:6.75pt;width:15.75pt;
   height:17.25pt;z-index:43;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1083" style='position:absolute;z-index:37'
   from="133.5pt,15.75pt" to="137.25pt,15.75pt" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:30;margin-left:29px;
  margin-top:8px;width:294px;height:25px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=69></td>
    <td width=1></td>
    <td width=7></td>
    <td width=1></td>
    <td width=69></td>
    <td width=1></td>
    <td width=7></td>
    <td width=1></td>
    <td width=138></td>
   </tr>
   <tr>
    <td height=12></td>
    <td rowspan=3 align=left valign=top><img width=69 height=25
    src="SHB_files/image006.gif" v:shapes="_x0000_s1076 _x0000_s1077 _x0000_s1078"></td>
    <td colspan=3></td>
    <td rowspan=3 align=left valign=top><img width=69 height=25
    src="SHB_files/image007.gif" v:shapes="_x0000_s1080 _x0000_s1081 _x0000_s1082"></td>
    <td colspan=3></td>
    <td rowspan=3 align=left valign=top><img width=138 height=25
    src="SHB_files/image008.gif" v:shapes="_x0000_s1084 _x0000_s1085 _x0000_s1086 _x0000_s1087 _x0000_s1088 _x0000_s1089"></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=7 height=2 src="SHB_files/image009.gif"
    v:shapes="_x0000_s1079"></td>
    <td></td>
    <td></td>
    <td align=left valign=top><img width=7 height=2 src="SHB_files/image009.gif"
    v:shapes="_x0000_s1083"></td>
   </tr>
   <tr>
    <td height=11></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=40 class=xl30 width=76 style='height:30.0pt;width:57pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 align=left style='height:15.0pt'>Điện thoại<span
  style='display:none'>/ <font class="font15">Tel:</font></span></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1070" style='position:absolute;z-index:24' from="15.75pt,12pt"
   to="261pt,12pt" strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:24;margin-left:20px;margin-top:15px;width:329px;height:2px'><img
  width=329 height=2 src="SHB_files/image010.gif" v:shapes="_x0000_s1070"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl33 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl35 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl36 colspan=3 align=left style='mso-ignore:colspan;border-right:
  .5pt solid #333399'>Số tiền/ <font class="font15">Amount:</font></td>
  <td class=xl38><%=p_Ccy %></td>
  <td colspan=6 class=xl53 style='border-right:.5pt solid #333399;border-left:
  none' ><%=p_Amt %></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 width=423 style='border-right:.5pt solid #333399;
  height:15.0pt;width:317pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1071" style='position:absolute;z-index:25' from="81.75pt,12.75pt"
   to="309.75pt,12.75pt" strokecolor="#339 [62]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:25;margin-left:108px;margin-top:16px;width:306px;height:
  2px'><img width=306 height=2 src="SHB_files/image011.gif" v:shapes="_x0000_s1071"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=6 height=20 class=xl55 width=423 style='border-right:.5pt solid #333399;
    height:15.0pt;width:317pt'>Địa chỉ/ <font class="font15">Address: </font><font
    class="font14"><%=p_D_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 class=xl59 width=460 style='border-right:.5pt solid #333399;
  border-left:none;width:347pt'>Bằng chữ/ <font class="font15">In words: </font><font
  class="font14"><%=Inword %></font></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>CMND/HC/<font class="font15">ID/Pass</font><span
  style='display:none'><font class="font15">port:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1073"
   style='position:absolute;z-index:27' from="20.25pt,12.75pt" to="213.75pt,12.75pt"
   strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:27;margin-left:26px;margin-top:16px;width:260px;height:2px'><img
  width=260 height=2 src="SHB_files/image012.gif" v:shapes="_x0000_s1073"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=10 height=20 width=460 style='border-right:.5pt solid #333399;
  height:15.0pt;width:347pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1038" style='position:absolute;direction:LTR;text-align:left;
   margin-left:122.25pt;margin-top:15pt;width:15.75pt;height:17.25pt;z-index:5;
   mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=12){%><%=p_C_Acc_No[p_C_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;direction:LTR;
   text-align:left;margin-left:139.5pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:6;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=11){%><%=p_C_Acc_No[p_C_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;direction:LTR;
   text-align:left;margin-left:156.75pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:7;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=10){%><%=p_C_Acc_No[p_C_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1046" style='position:absolute;direction:LTR;
   text-align:left;margin-left:239.25pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:13;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=6){%><%=p_C_Acc_No[p_C_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;direction:LTR;
   text-align:left;margin-left:256.5pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:14;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=5){%><%=p_C_Acc_No[p_C_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;direction:LTR;
   text-align:left;margin-left:273.75pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:15;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=4){%><%=p_C_Acc_No[p_C_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1049" style='position:absolute;direction:LTR;
   text-align:left;margin-left:291pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:16;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=3){%><%=p_C_Acc_No[p_C_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1050" style='position:absolute;direction:LTR;
   text-align:left;margin-left:308.25pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:17;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=2){%><%=p_C_Acc_No[p_C_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;direction:LTR;
   text-align:left;margin-left:325.5pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:18;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=1){%><%=p_C_Acc_No[p_C_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;direction:LTR;
   text-align:left;margin-left:180.75pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:9;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=9){%><%=p_C_Acc_No[p_C_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;direction:LTR;
   text-align:left;margin-left:198pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:10;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=8){%><%=p_C_Acc_No[p_C_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;direction:LTR;
   text-align:left;margin-left:215.25pt;margin-top:15pt;width:15.75pt;height:17.25pt;
   z-index:11;mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.875pt;direction:ltr'><font
    class="font16"><%if(p_C_Acc_No.Length >=7){%><%=p_C_Acc_No[p_C_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:5;margin-left:162px;margin-top:19px;width:294px;height:25px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=69></td>
    <td width=9></td>
    <td width=69></td>
    <td width=9></td>
    <td width=138></td>
   </tr>
   <tr>
    <td height=25></td>
    <td align=left valign=top><img width=69 height=25
    src="SHB_files/image013.gif" v:shapes="_x0000_s1038 _x0000_s1039 _x0000_s1040"></td>
    <td></td>
    <td align=left valign=top><img width=69 height=25
    src="SHB_files/image014.gif" v:shapes="_x0000_s1042 _x0000_s1043 _x0000_s1044"></td>
    <td></td>
    <td align=left valign=top><img width=138 height=25
    src="SHB_files/image015.gif" v:shapes="_x0000_s1046 _x0000_s1047 _x0000_s1048 _x0000_s1049 _x0000_s1050 _x0000_s1051"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=10 height=20 class=xl63 width=460 style='border-right:.5pt solid #333399;
    height:15.0pt;border-left:none;width:347pt'>Chuyển khoản cho/ <font
    class="font15">Fund Transfer to:</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Ngày cấp/ <font class="font15">Issued dat</font><span
  style='display:none'><font class="font15">e:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1072"
   style='position:absolute;z-index:26' from="11.25pt,12.75pt" to="213.75pt,12.75pt"
   strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:26;margin-left:14px;margin-top:16px;width:272px;height:2px'><img
  width=272 height=2 src="SHB_files/image016.gif" v:shapes="_x0000_s1072"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl32 colspan=4 align=left style='mso-ignore:colspan'>Tài khoản số/ <font
  class="font15">Account no:</font></td>
  <td class=xl27></td>
  <td height=20 class=xl27 width=64 style='height:15.0pt;width:48pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1041" style='position:absolute;z-index:8' from="2.25pt,9.75pt"
   to="6pt,9.75pt" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=12></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=7 height=2 src="SHB_files/image009.gif" v:shapes="_x0000_s1041"></td>
    <td width=55></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:15.0pt'></span><![endif]--></td>
  <td height=20 class=xl27 width=64 style='height:15.0pt;width:48pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1045" style='position:absolute;z-index:12' from="12.75pt,9.75pt"
   to="16.5pt,9.75pt" strokecolor="#339 [62]" strokeweight=".5pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=16 height=12></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=7 height=2 src="SHB_files/image009.gif" v:shapes="_x0000_s1045"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:15.0pt'></span><![endif]--></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 colspan=2 align=left style='height:15.0pt;
  mso-ignore:colspan'>Nơi cấp/ <font class="font15">Issued plac</font><span
  style='display:none'><font class="font15">e:</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1074"
   style='position:absolute;z-index:28' from="9pt,12.75pt" to="213pt,12.75pt"
   strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:28;margin-left:11px;margin-top:16px;width:274px;height:2px'><img
  width=274 height=2 src="SHB_files/image017.gif" v:shapes="_x0000_s1074"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=10 rowspan=3 height=62 width=460 style='border-right:.5pt solid #333399;
  border-bottom:.5pt solid #333399;height:46.5pt;width:347pt' align=left
  valign=top><!--[if gte vml 1]><v:line id="_x0000_s1069" style='position:absolute;
   z-index:23' from=".75pt,6pt" to="344.25pt,6pt" strokecolor="#339 [62]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:23;margin-left:0px;margin-top:7px;width:460px;
  height:2px'><img width=460 height=2 src="SHB_files/image018.gif" v:shapes="_x0000_s1069"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=10 rowspan=3 height=62 class=xl65 width=460 style='border-right:
    .5pt solid #333399;border-bottom:.5pt solid #333399;height:46.5pt;
    width:347pt'>Nội dung thanh toán/ <font class="font15">Payment Content: </font><font
    class="font14"><%=p_Remark %></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl40 style='height:.75pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=4 height=41 class=xl69 width=256 style='border-right:.5pt solid #333399;
  height:30.75pt;width:192pt'>Chữ ký và dấu của chủ tài khoản/<br>
    <font class="font15">Account Holder's signature and stamp</font></td>
  <td colspan=2 class=xl69 width=167 style='border-right:.5pt solid #333399;
  border-left:none;width:125pt'>Họ tên và chữ ký người<br>
    nhận tiền/</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl32 style='height:30.0pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl72 width=167 style='border-right:.5pt solid #333399;
  border-left:none;width:125pt'>Receiver's name and<br>
    signature</td>
  <td rowspan=3 height=88 width=38 style='border-bottom:.5pt solid #333399;
  height:66.0pt;width:29pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1075" style='position:absolute;direction:LTR;text-align:left;
   margin-left:1.5pt;margin-top:1.5pt;width:15.75pt;height:15pt;z-index:29'
   fillcolor="window [65]" strokecolor="navy [18]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:29;margin-left:1px;
  margin-top:1px;width:23px;height:22px'><img width=23 height=22
  src="SHB_files/image019.gif" v:shapes="_x0000_s1075"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=3 height=88 class=xl75 width=38 style='border-bottom:.5pt solid #333399;
    height:66.0pt;border-top:none;width:29pt'>Ủy quyền<br>
        <font class="font19">Authorization</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 rowspan=3 class=xl77 width=422 style='border-right:.5pt solid #333399;
  border-bottom:.5pt solid #333399;width:318pt'>Tôi, chủ tài khoản, xin ủy
  quyền cho người có tên dưới đây nhận tiền mặt rút <br>
    từ tài khoản của tôi. Tôi xin chịu toàn bộ trách nhiệm về hậu quả có thể
  xảy đến<br>
    <span style='mso-spacerun:yes'> </span>do việc ủy quyền này. <font
  class="font20">I, as the account holder, duly authorize the receiver <br>
    mentioned below to receive cash withdrawn from my account. I agree to take
  <br>
    responsibilities about the consequence of this authorization.</font></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl32 style='height:20.25pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 height=21 width=460 style='border-right:.5pt solid #333399;
  height:15.75pt;width:347pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1090" style='position:absolute;z-index:44' from="120pt,12.75pt"
   to="338.25pt,12.75pt" strokecolor="#339 [62]" strokeweight="1pt"
   o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:44;margin-left:159px;margin-top:16px;width:293px;height:
  2px'><img width=293 height=2 src="SHB_files/image020.gif" v:shapes="_x0000_s1090"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=10 height=21 class=xl93 width=460 style='border-right:.5pt solid #333399;
    height:15.75pt;width:347pt'>Người nhận tiền/ <font class="font15">Receiver:<span
    style='mso-spacerun:yes'>  </span></font><font class="font14"><%=p_C_Acc_Nm %></font></td>
   </tr>
  </table>
  </span></td>
 
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl32 style='height:29.25pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 height=39 width=133 style='height:29.25pt;width:101pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1091" style='position:absolute;
   z-index:45' from="49.5pt,10.5pt" to="102.75pt,10.5pt" strokecolor="#339 [62]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:45;margin-left:65px;margin-top:13px;width:73px;height:2px'><img
  width=73 height=2 src="SHB_files/image021.gif" v:shapes="_x0000_s1091"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=39 class=xl86 width=133 style='height:29.25pt;
    width:101pt'>CMND số:<br>
        <font class="font15">ID (PP) no.</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 height=39 width=97 style='height:29.25pt;width:73pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1092" style='position:absolute;
   z-index:46' from="47.25pt,10.5pt" to="120.75pt,10.5pt" strokecolor="#339 [62]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:46;margin-left:62px;margin-top:13px;width:100px;height:2px'><img
  width=100 height=2 src="SHB_files/image022.gif" v:shapes="_x0000_s1092"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=39 class=xl87 width=97 style='height:29.25pt;
    width:73pt'>Ngày cấp:<br>
        <font class="font15">Issued date</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl46></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1093" style='position:absolute;z-index:47' from="21pt,10.5pt"
   to="117.75pt,10.5pt" strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:47;margin-left:27px;margin-top:13px;width:131px;height:2px'><img
  width=131 height=2 src="SHB_files/image023.gif" v:shapes="_x0000_s1093"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=39 class=xl47 align=left width=64 style='height:29.25pt;
    width:48pt'>Tại:<br>
        <font class="font15">At</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl32 style='height:30.75pt'>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 height=41 width=460 style='border-right:.5pt solid #333399;
  height:30.75pt;width:347pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1094" style='position:absolute;z-index:48' from="52.5pt,12pt"
   to="140.25pt,12pt" strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1096" style='position:absolute;z-index:50'
   from="3.75pt,27.75pt" to="338.25pt,27.75pt" strokecolor="#339 [62]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><v:line id="_x0000_s1095" style='position:absolute;z-index:49'
   from="219pt,11.25pt" to="339pt,11.25pt" strokecolor="#339 [62]"
   strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:48;margin-left:4px;margin-top:14px;width:449px;height:24px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=65></td>
    <td width=119></td>
    <td width=103></td>
    <td width=161></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=1></td>
    <td colspan=3></td>
    <td colspan=2 rowspan=2 align=left valign=top><img width=162 height=2
    src="SHB_files/image024.gif" v:shapes="_x0000_s1095"></td>
   </tr>
   <tr>
    <td height=1></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=119 height=2
    src="SHB_files/image025.gif" v:shapes="_x0000_s1094"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=19></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=4 align=left valign=top><img width=448 height=2
    src="SHB_files/image026.gif" v:shapes="_x0000_s1096"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=10 height=41 class=xl88 width=460 style='border-right:.5pt solid #333399;
    height:30.75pt;width:347pt'>Số ĐT/<font class="font15">Tel:<span
    style='mso-spacerun:yes'>                              </span></font><font
    class="font14">Địa chỉ/</font><font class="font15">Address: </font><font
    class="font14"><%=p_C_Add %></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=12 height=20 class=xl90 style='height:15.0pt'>Dành cho ngân hàng/
  <font class="font15">Bank use only</font></td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl92 style='border-right:.5pt solid #333399;border-left:
  none'>Giám đốc</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl92 style='border-right:.5pt solid #333399;border-left:
  none'>Kế toán</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt;'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl92 style='border-right:.5pt solid #333399;border-left:
  none'>Thủ quỹ</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl32 style='height:11.1pt'>&nbsp;</td>
  <td colspan=12 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:11.1pt'>
  <td height=14 class=xl40 style='height:11.1pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl48 colspan=5 align=left style='height:11.25pt;
  mso-ignore:colspan'>Form code: 1.1.3 - Effective from 28th November 2011</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 height=17 class=xl24 width=15 style='mso-ignore:colspan-rowspan;
  height:12.75pt;width:11pt'><!--[if gte vml 1]><v:line id="_x0000_s1064"
   style='position:absolute;z-index:19' from="9pt,10.5pt" to="9pt,10.5pt"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="SHB_files/image027.gif" v:shapes="_x0000_s1064"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:11.25pt;height:12.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 height=17 class=xl24 width=15 style='mso-ignore:colspan-rowspan;
  height:12.75pt;width:11pt'><!--[if gte vml 1]><v:line id="_x0000_s1065"
   style='position:absolute;z-index:20' from="9pt,10.5pt" to="9pt,10.5pt"
   strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=13></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=2 height=2 src="SHB_files/image027.gif" v:shapes="_x0000_s1065"></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:11.25pt;height:12.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
