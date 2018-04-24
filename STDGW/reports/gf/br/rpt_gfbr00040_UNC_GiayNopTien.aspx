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
    string p_Seq1= Request["Seq1"];
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_Tax_Code = "";
    string p_Province= "";
    string p_Province_1 = "";
    string p_Date = "";
    string p_Month="";
    string p_Year="";
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_D_Acc_No = dt.Rows[0][24].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][13].ToString();
        p_Tax_Code = dt.Rows[0][28].ToString();
        p_Province = dt.Rows[0][22].ToString();
        p_Province_1 = dt.Rows[0][20].ToString();
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
    }

    string SQL  = "select  (select to_char(to_date(a.item,'YYYYMMDD'),'DD/MM/YYYY') from tac_bprvpvditem a, tac_abacctitem b where a.del_if(+) = 0 and b.del_if = 0 and A.TAC_ABACCTITEM_PK = b.pk and A.TAC_BPRVPVD_PK = t.pk  " +
        " and B.TAC_ABITEM_ALIAS = 'DECLARATION DATE' ) DECLARATIONDATE, " +
        " (select a.item from tac_bprvpvditem a, tac_abacctitem b where a.del_if(+) = 0 and b.del_if = 0 and A.TAC_ABACCTITEM_PK = b.pk and A.TAC_BPRVPVD_PK = t.pk  " +
        " and B.TAC_ABITEM_ALIAS = 'DECLARATION NO' ) DECLARATION_NO, " +
        "  (select a.item from tac_bprvpvditem a, tac_abacctitem b where a.del_if(+) = 0 and b.del_if = 0 and A.TAC_ABACCTITEM_PK = b.pk and A.TAC_BPRVPVD_PK = t.pk  " +
        " and B.TAC_ABITEM_ALIAS = 'DECLARATION TYPE' ) DECLARATION_TYPE,  (select a.item from tac_bprvpvditem a, tac_abacctitem b where a.del_if(+) = 0 and b.del_if = 0 and A.TAC_ABACCTITEM_PK = b.pk and A.TAC_BPRVPVD_PK = t.pk and B.TAC_ABITEM_ALIAS = 'CUSTOMER  NAME' ) Customer  " +
        "      FROM TAC_BPRVPVD T, TAC_BPRVPV H, TAC_ABACCTCODE b " +
        "     WHERE T.DEL_IF        = 0 " +
        "       AND H.DEL_IF        = 0 " +
        "       and b.del_if = 0 " +
        "       AND T.TAC_BPRVPV_PK = H.PK " +
        "       AND T.TAC_BPRVPV_PK = '"+p_Seq1+"' " +
        "       AND T.DRCR_TYPE     = 'D' " +
        "       and B.AC_CD = '333120' " +
        "       and T.TAC_ABACCTCODE_PK = b.pk " +
        "     ORDER BY DRCR_ORD";
    string p_ToKhai = "";
    string p_Ngay = "";
    string p_LoaiXNK = "";
    string p_CQQLT = "";
    DataTable dt_2 = ESysLib.TableReadOpen(SQL);
    if (dt_2.Rows.Count > 0)
    {
        p_Ngay = dt_2.Rows[0][0].ToString();
        p_ToKhai = dt_2.Rows[0][1].ToString();
        p_LoaiXNK = dt_2.Rows[0][2].ToString();
        p_CQQLT = dt_2.Rows[0][3].ToString();
    }
    //Response.Write(p_ToKhai);
    //Response.End();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Giay%20nop%20tien_files/filelist.xml">
<link rel=Edit-Time-Data href="Giay%20nop%20tien_files/editdata.mso">
<link rel=OLE-Object-Data href="Giay%20nop%20tien_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-10-05T03:02:10Z</o:LastPrinted>
  <o:Created>2011-09-29T08:25:33Z</o:Created>
  <o:LastSaved>2011-10-05T03:22:00Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
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
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:11.0pt;
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
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style16;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style16;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:.5pt hairline black;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
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
	border-left:.5pt hairline black;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline black;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	color:navy;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>34</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$35:$F$35</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>18780</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>270</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1055">
  <o:colormenu v:ext="edit" strokecolor="none [8]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=904 style='border-collapse:
 collapse;table-layout:fixed;width:680pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 width=17 style='height:18.0pt;width:13pt'></td>
  <td class=xl24 width=35 style='width:26pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl25 width=117 style='width:88pt'>Mẫu số: C1- 02/NS</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=2 rowspan=3 class=xl44 width=124 style='border-right:.5pt hairline black;
  border-bottom:.5pt hairline black;width:93pt'>Không ghi vào khu vực này</td>
  <td colspan=6 class=xl51 style='border-left:none'>GIẤY NỘP TIỀN VÀO NGÂN SÁCH
  NHÀ NƯỚC</td>
  <td class=xl26>Mã hiệu:…………</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1025"
   style='position:absolute;direction:LTR;text-align:left;margin-left:65.25pt;
   margin-top:3.75pt;width:10.5pt;height:9.75pt;z-index:1' filled="f"
   fillcolor="#0cf [40]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:86px;margin-top:4px;width:16px;height:15px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=13 height=15 align=left valign=top style='border:.75pt solid black;
    vertical-align:top'><![endif]>
    <div v:shape="_x0000_s1025" style='padding:.75pt 0pt 0pt .75pt;text-align:
    left;direction:ltr' class=shape><font class="font0"><br>
        </font></div>
    <![if !vml]></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=117 style='height:18.0pt;
    width:88pt' x:str="Tiền mặt  ">Tiền mặt<span
    style='mso-spacerun:yes'>  </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl27 align=left>chuyển khoả<span style='display:none'>n</span></td>
  <td height=24 class=xl28 width=66 style='height:18.0pt;width:50pt'><!--[if gte vml 1]><v:rect
   id="_x0000_s1026" style='position:absolute;direction:LTR;text-align:left;
   margin-left:19.5pt;margin-top:3.75pt;width:10.5pt;height:9.75pt;z-index:2'
   filled="f" fillcolor="#0cf [40]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=25 height=4></td>
   </tr>
   <tr>
    <td></td>
    <td width=13 height=15 align=left valign=top style='border:.75pt solid black;
    vertical-align:top'><![endif]>
    <div v:shape="_x0000_s1026" style='padding:.75pt 0pt 0pt .75pt;text-align:
    left;direction:ltr' class=shape><font class="font0"><br>
        </font></div>
    <![if !vml]></td>
    <td width=25></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:49.5pt;height:18.0pt'></span><![endif]--></td>
  <td class=xl24></td>
  <td class=xl26>Số:……………</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=6 class=xl53 style='border-left:none'>(Đánh dấu X vào ô tương
  ứng)</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 align=left>Ngườ<span style='display:none'>i nộp thuế: <font
  class="font9"><%=p_D_Acc_Nm %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;flip:y;z-index:3;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="48pt,14.25pt" to="540.75pt,15pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:63px;margin-top:18px;width:659px;height:3px'><img
  width=659 height=3 src="Giay%20nop%20tien_files/image001.gif" v:shapes="_x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=89 style='height:18.0pt;width:67pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 align=left>Mã s<span style='display:none'>ố thuế:<font
  class="font6"> 0900283167</font></span></td>
  <td colspan=2 height=24 class=xl27 width=171 style='mso-ignore:colspan-rowspan;
  height:18.0pt;width:129pt'><!--[if gte vml 1]><v:line id="_x0000_s1032"
   style='position:absolute;flip:y;z-index:4;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="27.75pt,14.25pt" to="124.5pt,14.25pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=36 height=18></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=131 height=2 src="Giay%20nop%20tien_files/image002.gif"
    v:shapes="_x0000_s1032"></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:128.25pt;height:18.0pt'></span><![endif]--></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1033"
   style='position:absolute;flip:y;z-index:5;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="36.75pt,14.25pt" to="412.5pt,14.25pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:5;margin-left:48px;margin-top:18px;width:503px;height:2px'><img
  width=503 height=2 src="Giay%20nop%20tien_files/image003.gif" v:shapes="_x0000_s1033"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=117 style='height:18.0pt;
    width:88pt'>Địa chỉ: <font class="font9">Đường B3, Khu B, KCN Phố Nối A, Minh Hải</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;flip:y;z-index:7;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="37.5pt,13.5pt" to="105.75pt,13.5pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:7;margin-left:49px;margin-top:17px;width:93px;height:2px'><img
  width=93 height=2 src="Giay%20nop%20tien_files/image004.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=79 style='height:18.0pt;   width:59pt' >Huyện: <font class="font9">Văn Lâm</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1036"
   style='position:absolute;flip:y;z-index:8;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="44.25pt,13.5pt" to="170.25pt,13.5pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:8;margin-left:58px;margin-top:17px;width:170px;height:2px'><img
  width=170 height=2 src="Giay%20nop%20tien_files/image005.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=110 style='height:18.0pt;    width:83pt' >Tỉnh, TP: <font class="font9">Hưng Yên</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 align=left x:str="Người nộp thay: ">Ngườ<span
  style='display:none'>i nộp thay:<span style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1039"
   style='position:absolute;z-index:11;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="48pt,13.5pt" to="364.5pt,13.5pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:11;margin-left:63px;margin-top:17px;width:424px;height:2px'><img
  width=424 height=2 src="Giay%20nop%20tien_files/image006.gif" v:shapes="_x0000_s1039"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=89 style='height:18.0pt;width:67pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1037"
   style='position:absolute;flip:y;z-index:9;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="54.75pt,12.75pt" to="168pt,12.75pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:9;margin-left:72px;margin-top:16px;width:153px;height:2px'><img
  width=153 height=2 src="Giay%20nop%20tien_files/image007.gif" v:shapes="_x0000_s1037"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=110 style='height:18.0pt;
    width:83pt'>Mã số thuế:</td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 align=left>Địa c<span style='display:none'>hỉ: .</span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1040"
   style='position:absolute;z-index:12;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="12.75pt,12.75pt" to="543pt,12.75pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:12;margin-left:16px;margin-top:16px;width:709px;height:2px'><img
  width=709 height=2 src="Giay%20nop%20tien_files/image008.gif" v:shapes="_x0000_s1040"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=89 style='height:18.0pt;width:67pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 align=left x:str="Huyện: ">Huyệ<span style='display:none'>n:<span
  style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1041"
   style='position:absolute;z-index:13;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="9pt,13.5pt" to="261.75pt,13.5pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:13;margin-left:11px;margin-top:17px;width:339px;height:2px'><img
  width=339 height=2 src="Giay%20nop%20tien_files/image009.gif" v:shapes="_x0000_s1041"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=89 style='height:18.0pt;width:67pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1038"
   style='position:absolute;z-index:10;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="44.25pt,12.75pt" to="276.75pt,12.75pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:10;margin-left:58px;margin-top:16px;width:312px;height:2px'><img
  width=312 height=2 src="Giay%20nop%20tien_files/image010.gif" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=79 style='height:18.0pt;
    width:59pt' x:str="Tỉnh, TP: ">Tỉnh, TP:<span
    style='mso-spacerun:yes'><font class="font9"></font> </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 align=left style='mso-ignore:colspan'>Đề nghị NH
  (KBN<span style='display:none'>N): <font class="font9"><%=p_C_Bank %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1034"
   style='position:absolute;z-index:6;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="9.75pt,15pt" to="194.25pt,15pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:6;margin-left:12px;margin-top:19px;width:248px;height:2px'><img
  width=248 height=2 src="Giay%20nop%20tien_files/image011.gif" v:shapes="_x0000_s1034"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1042"
   style='position:absolute;flip:y;z-index:14;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="56.25pt,14.25pt" to="277.5pt,14.25pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:14;margin-left:74px;margin-top:18px;width:297px;height:2px'><img
  width=297 height=2 src="Giay%20nop%20tien_files/image012.gif" v:shapes="_x0000_s1042"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=79 style='height:18.0pt;
    width:59pt'>trích TK số: <font class="font9"><%=p_D_Acc_No %></font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=3 align=left style='mso-ignore:colspan'>(hoặc) nộp tiền mặt để
  chuyển cho<span style='display:none'> KBNN: <span
  style='mso-spacerun:yes'> </span><font class="font9"><%=p_C_Acc_Nm %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1043"
   style='position:absolute;flip:y;z-index:15;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="39.75pt,12.75pt" to="242.25pt,12.75pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:15;margin-left:52px;margin-top:16px;width:272px;height:2px'><img
  width=272 height=2 src="Giay%20nop%20tien_files/image013.gif" v:shapes="_x0000_s1043"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=117 style='height:18.0pt;width:88pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1044"
   style='position:absolute;flip:y;z-index:16;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="43.5pt,15pt" to="168.75pt,15pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:16;margin-left:57px;margin-top:19px;width:169px;height:2px'><img
  width=169 height=2 src="Giay%20nop%20tien_files/image014.gif" v:shapes="_x0000_s1044"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=110 style='height:18.0pt;
    width:83pt'>Tỉnh, TP: <font class="font9"><%=p_Province %></font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 align=left style='mso-ignore:colspan'>Để<span
  style='mso-spacerun:yes'>  </span>nộp vào TK tạm<span style='display:none'>
  thu số <font class="font9"><%=p_C_Acc_No %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1045"
   style='position:absolute;flip:y;z-index:17;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="32.25pt,14.25pt" to="474.75pt,14.25pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:17;margin-left:42px;margin-top:18px;width:592px;height:2px'><img
  width=592 height=2 src="Giay%20nop%20tien_files/image015.gif" v:shapes="_x0000_s1045"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 align=left style='mso-ignore:colspan'>Cơ quan quản
  lý thu:<span style='display:none'> <font class="font9"><%=p_CQQLT %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1046"
   style='position:absolute;flip:y;z-index:18;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="1.5pt,14.25pt" to="302.25pt,14.25pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:18;margin-left:1px;margin-top:18px;width:403px;height:2px'><img
  width=403 height=2 src="Giay%20nop%20tien_files/image016.gif" v:shapes="_x0000_s1046"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td class=xl27 align=left><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1047"
   style='position:absolute;flip:y;z-index:19;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="33.75pt,12.75pt" to="171pt,12.75pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:19;margin-left:44px;margin-top:16px;width:185px;height:2px'><img
  width=185 height=2 src="Giay%20nop%20tien_files/image017.gif" v:shapes="_x0000_s1047"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 align=left width=110 style='height:18.0pt;
    width:83pt' x:str="Mã số: ">Mã số:<span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 align=left style='mso-ignore:colspan'>Tờ khai HQ, QĐ
  số<font class="font6">:</font><span style='display:none'><font class="font5">
  </font><font class="font9"><%=p_ToKhai %></font><font class="font6"><span
  style='mso-spacerun:yes'>    </span></font><font class="font5"><span
  style='mso-spacerun:yes'> </span>ngày: </font><font class="font9"><%=p_Ngay %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1048"
   style='position:absolute;flip:y;z-index:20;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="2.25pt,14.25pt" to="81.75pt,14.25pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1049" style='position:absolute;flip:y;z-index:21;
   mso-wrap-style:square;mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="109.5pt,14.25pt" to="253.5pt,14.25pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:20;margin-left:2px;margin-top:18px;width:337px;height:2px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=108></td>
    <td width=35></td>
    <td width=194></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=108 height=2
    src="Giay%20nop%20tien_files/image018.gif" v:shapes="_x0000_s1048"></td>
    <td></td>
    <td align=left valign=top><img width=194 height=2
    src="Giay%20nop%20tien_files/image019.gif" v:shapes="_x0000_s1049"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27 align=left>Loại hình <span style='display:none'>XNK: <font
  class="font9"><%=p_LoaiXNK %></font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1050"
   style='position:absolute;flip:y;z-index:22;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="23.25pt,14.25pt" to="168pt,14.25pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:22;margin-left:30px;margin-top:18px;width:195px;height:2px'><img
  width=195 height=2 src="Giay%20nop%20tien_files/image020.gif" v:shapes="_x0000_s1050"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=110 style='height:18.0pt;width:83pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 align=left style='mso-ignore:colspan'
  x:str="(hoặc) Bảng kê Biên lai số: ">(hoặc) Bảng kê Biên<span
  style='display:none'> lai số:<span style='mso-spacerun:yes'> </span></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1051"
   style='position:absolute;flip:y;z-index:23;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="30pt,13.5pt" to="198.75pt,13.5pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><v:line id="_x0000_s1052" style='position:absolute;z-index:24;
   mso-wrap-style:square;mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="225pt,13.5pt" to="473.25pt,13.5pt" coordsize="21600,21600"
   strokecolor="black [8]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:23;margin-left:39px;margin-top:17px;width:593px;height:2px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=227></td>
    <td width=33></td>
    <td width=333></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=227 height=2
    src="Giay%20nop%20tien_files/image021.gif" v:shapes="_x0000_s1051"></td>
    <td></td>
    <td align=left valign=top><img width=333 height=2
    src="Giay%20nop%20tien_files/image022.gif" v:shapes="_x0000_s1052"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl27 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td class=xl27 align=left x:str=" ngày "><span
  style='mso-spacerun:yes'> </span>ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=12 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td rowspan=2 class=xl55 width=35 style='border-bottom:.5pt solid black;
  width:26pt'>STT</td>
  <td colspan=3 class=xl54 width=288 style='border-right:.5pt solid black;
  border-left:none;width:217pt'>Nội dung</td>
  <td rowspan=2 class=xl59 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Mã chương</td>
  <td rowspan=2 class=xl55 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Mã ngành KT (K)</td>
  <td rowspan=2 class=xl55 width=66 style='border-bottom:.5pt solid black;
  width:50pt'>Mã NDKT (TM)</td>
  <td rowspan=2 class=xl55 width=110 style='border-bottom:.5pt solid black;
  width:83pt' x:str="Kỳ thuế ">Kỳ thuế<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl55 width=117 style='border-bottom:.5pt solid black;
  width:88pt'>Số tiền</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl24 style='height:25.5pt'></td>
  <td colspan=3 class=xl62 width=288 style='border-right:.5pt solid black;
  border-left:none;width:217pt'>các khoản nộp NS</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     decimal p_Total_Amt = 0;
     string p_ccy = "";
     DataTable dt_detail = ESysLib.TableReadOpenCursor("rpt_SEL_gfbr00040_dorco", p_Seq1);
     if (dt_detail.Rows.Count > 0)
     {
         p_ccy = dt_detail.Rows[0][7].ToString();
     }
     //Response.Write(dt_detail.Rows[0][1].ToString());
     //Response.End();
     for (int i = 0; i < dt_detail.Rows.Count; i++)
     {
         if (dt_detail.Rows[i][6].ToString().Trim() != "")
         {
             p_Total_Amt += decimal.Parse(dt_detail.Rows[i][6].ToString());
         }
         else
         {
             p_Total_Amt += 0;
         }

         
         
         
      %>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 style='height:30.0pt'></td>
  <td class=xl32 width=35 style='width:26pt' x:num><%=dt_detail.Rows[i][0]%></td>
  <td colspan=3 class=xl66 width=288 style='border-right:.5pt solid black;  border-left:none;width:217pt'><%=dt_detail.Rows[i][1]%></td>
  <td class=xl33 width=64 style='width:48pt' x:num><%=dt_detail.Rows[i][2]%></td>
  <td class=xl33 width=79 style='width:59pt' x:num><%=dt_detail.Rows[i][3]%></td>
  <td class=xl33 width=66 style='width:50pt' x:num><%=dt_detail.Rows[i][4]%></td>
  <td class=xl34 align=left width=110 style='width:83pt'><%=dt_detail.Rows[i][5]%></td>
  <td class=xl35 align=left width=117 style='width:88pt' x:num><%=dt_detail.Rows[i][6]%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <% }%>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=8 class=xl71 width=642 style='border-right:.5pt solid black;  width:483pt'>Tổng cộng</td>
  <td class=xl36 align=left width=117 style='width:88pt' x:num><%=p_Total_Amt %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=12 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
     string Inword = "";
     string p_Amt="";
     p_Amt = System.Convert.ToString(p_Total_Amt) ;
     Inword = CommondLib.Num2VNText(p_Amt, p_ccy);
     string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
     DataTable dt_t = ESysLib.TableReadOpen(SQL3);

     if (dt_t.Rows.Count > 0)
     {
         Inword = dt_t.Rows[0][0].ToString();

     }
  %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl37 colspan=2 align=left style='mso-ignore:colspan'>Tổng số tiền
  ghi bằ<span style='display:none'>ng chữ: <font class="font11"><%=Inword%>./</font></span></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1053"
   style='position:absolute;z-index:25;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="36.75pt,15pt" to="476.25pt,15pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:25;margin-left:48px;margin-top:19px;width:588px;height:2px'><img
  width=588 height=2 src="Giay%20nop%20tien_files/image023.gif" v:shapes="_x0000_s1053"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl37 width=82 style='height:18.0pt;width:62pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=9 height=24 class=xl24 width=759 style='mso-ignore:colspan-rowspan;
  height:18.0pt;width:571pt'><!--[if gte vml 1]><v:line id="_x0000_s1054"
   style='position:absolute;z-index:26;mso-wrap-style:square;
   mso-wrap-distance-left:9pt;mso-wrap-distance-top:0;
   mso-wrap-distance-right:9pt;mso-wrap-distance-bottom:0;
   mso-position-horizontal:absolute;mso-position-horizontal-relative:text;
   mso-position-vertical:absolute;mso-position-vertical-relative:text;
   v-text-anchor:top' from="2.25pt,14.25pt" to="568.5pt,14.25pt" coordsize="21600,21600"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto">
   <v:stroke dashstyle="1 1" endcap="round"/>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=18></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=757 height=2 src="Giay%20nop%20tien_files/image024.gif"
    v:shapes="_x0000_s1054"></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:569.25pt;height:18.0pt'></span><![endif]--></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=3 class=xl74 width=206 style='width:155pt'>PHẦN KBNN GHI</td>
  <td class=xl38 width=117 style='width:88pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl40 colspan=3 style='mso-ignore:colspan'>Mã quỹ: …………………………<span
  style='display:none'>…..</span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="Mã ĐBHC: ………………………. ">Mã ĐBHC: ……………………….<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'
  x:str="Nợ TK: ……………...……………………. ">Nợ TK: ……………...…………………….<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl40 colspan=3 style='mso-ignore:colspan'>Mã KBNN: ……………………<span
  style='display:none'>……</span></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>Mã nguồn NS:……………………..</td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Có
  TK:……………...……………………..</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl42 width=35 style='width:26pt'>&nbsp;</td>
  <td class=xl43 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl43 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl43 width=117 style='width:88pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl75 width=387 style='width:291pt'>ĐỐI TƯỢNG NỘP TIỀN</td>
  <td colspan=4 class=xl75 width=372 style='width:280pt'>NGÂN HÀNG A</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl76 width=387 style='width:291pt'
  >Ngày <font class="font9"><%=p_Date %></font> tháng <font class="font9"><%=p_Month %> </font>năm <font
  class="font9"><%=p_Year %></font><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl76 width=372 style='width:280pt'>Ngày……tháng……năm……</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl75 width=387 style='width:291pt'>Người nộp tiền<span
  style='mso-spacerun:yes'>    </span>Kế toán trưởng<span
  style='mso-spacerun:yes'>     </span>Thủ trưởng</td>
  <td colspan=4 class=xl75 width=372 style='width:280pt'
  x:str="Kế toán                             Kế toán trưởng  ">Kế toán<span
  style='mso-spacerun:yes'>                             </span>Kế toán
  trưởng<span style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=12 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl75 width=387 style='width:291pt'>NGÂN HÀNG B</td>
  <td colspan=4 class=xl75 width=372 style='width:280pt'>KHO BẠC NHÀ NƯỚC</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl76 width=387 style='width:291pt'>Ngày……tháng……năm……</td>
  <td colspan=4 class=xl76 width=372 style='width:280pt'>Ngày……tháng…..năm…….</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=5 class=xl75 width=387 style='width:291pt'>Kế toán<span
  style='mso-spacerun:yes'>                        </span>Kế toán trưởng</td>
  <td colspan=4 class=xl77
  x:str="Thủ quỹ          Kế toán        Kế toán trưởng    ">Thủ quỹ<span
  style='mso-spacerun:yes'>          </span>Kế toán<span
  style='mso-spacerun:yes'>        </span>Kế toán trưởng<span
  style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=17 style='width:13pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
