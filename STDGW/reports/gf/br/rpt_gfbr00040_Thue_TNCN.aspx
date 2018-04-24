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
	/*
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
	/**/	
    string p_ToKhai = "";
    string p_Ngay = "";
    string p_LoaiXNK = "";
    string p_CQQLT = "";
	//Response.Write("ddddd");
    //    Response.End();
	string l_Seq="";
	string l_Seq1="";
	if(p_Seq=="")
	{
		l_Seq="0";
		
	}
	else l_Seq=p_Seq;
	if(p_Seq1=="")
	{
		l_Seq1="0";
	}else l_Seq1=p_Seq1;
    DataTable dt_2 = ESysLib.TableReadOpenCursor("rpt_SEL_gfbr00040_2",l_Seq+","+l_Seq1);
    if (dt_2.Rows.Count > 0)
    {
        p_Ngay = dt_2.Rows[0][0].ToString();
        p_ToKhai = dt_2.Rows[0][1].ToString();
        p_LoaiXNK = dt_2.Rows[0][2].ToString();
        p_CQQLT = dt_2.Rows[0][3].ToString();
    }
    //Response.Write("ddddd");
     //   Response.End();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="GiayNopTienVaoNganSachNhaNuoc_files/filelist.xml">
<link rel=Edit-Time-Data href="GiayNopTienVaoNganSachNhaNuoc_files/editdata.mso">
<link rel=OLE-Object-Data href="GiayNopTienVaoNganSachNhaNuoc_files/oledata.mso">
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
  <o:LastPrinted>2012-02-21T09:51:21Z</o:LastPrinted>
  <o:Created>2012-02-03T09:08:55Z</o:Created>
  <o:LastSaved>2012-02-21T09:51:32Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .31in .09in .43in;
	mso-header-margin:.3in;
	mso-footer-margin:.04in;}
.font6
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Times New Roman;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Times New Roman;
	mso-font-charset:0;}
.font12
	{color:black;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Wingdings 2", serif;
	mso-font-charset:2;}
.font13
	{color:black;
	font-size:17.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
.font15
	{color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Times New Roman;
	mso-font-charset:0;}
.font16
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Times New Roman;
	mso-font-charset:0;}
.font17
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.font18
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:black;
	font-size:13.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font21
	{color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
.font22
	{color:black;
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_giay nop tien vao NSNN";}
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
.xl25
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-family:"VnBravo Times", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style21;
	color:black;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl59
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl60
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style21;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl81
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl82
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl85
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style21;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl87
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style21;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Thue TNCN</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>89</x:Scale>
      <x:HorizontalResolution>-3</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1605 style='border-collapse:
 collapse;table-layout:fixed;width:1204pt'>
 <col class=xl25 width=62 style='mso-width-source:userset;mso-width-alt:1763;
 width:47pt'>
 <col class=xl25 width=139 style='mso-width-source:userset;mso-width-alt:3953;
 width:104pt'>
 <col class=xl25 width=36 style='mso-width-source:userset;mso-width-alt:1024;
 width:27pt'>
 <col class=xl25 width=67 style='mso-width-source:userset;mso-width-alt:1905;
 width:50pt'>
 <col class=xl25 width=93 style='mso-width-source:userset;mso-width-alt:2645;
 width:70pt'>
 <col class=xl25 width=47 span=2 style='mso-width-source:userset;mso-width-alt:
 1336;width:35pt'>
 <col class=xl25 width=105 style='mso-width-source:userset;mso-width-alt:2986;
 width:79pt'>
 <col class=xl25 width=92 style='mso-width-source:userset;mso-width-alt:2616;
 width:69pt'>
 <col class=xl25 width=33 style='mso-width-source:userset;mso-width-alt:938;
 width:25pt'>
 <col class=xl25 width=81 style='mso-width-source:userset;mso-width-alt:2304;
 width:61pt'>
 <col class=xl25 width=3 style='mso-width-source:userset;mso-width-alt:85;
 width:2pt'>
 <col class=xl25 width=80 span=10 style='width:60pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 width=62 style='height:19.5pt;width:47pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t202" coordsize="21600,21600"
   o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="Text_x0020_Box_x0020_2" o:spid="_x0000_s1025"
   type="#_x0000_t202" style='position:absolute;direction:LTR;text-align:left;
   margin-left:4.5pt;margin-top:12.75pt;width:108.75pt;height:52.5pt;z-index:1;
   visibility:visible;v-text-anchor:middle' filled="f" strokeweight=".5pt">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:center;padding-top:7.125pt;direction:ltr'><font
    class="font6">Không ghi vào khu vực này</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:5px;margin-top:16px;width:147px;
  height:72px'><img width=147 height=72
  src="GiayNopTienVaoNganSachNhaNuoc_files/image001.gif"
  alt="Text Box: Không ghi vào khu vực này" v:shapes="Text_x0020_Box_x0020_2"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl26 width=62 style='height:19.5pt;width:47pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=139 style='width:104pt'></td>
  <td class=xl27 width=36 style='width:27pt'></td>
  <td class=xl27 width=67 style='width:50pt'></td>
  <td class=xl27 width=93 style='width:70pt'></td>
  <td class=xl27 width=47 style='width:35pt'></td>
  <td class=xl27 width=47 style='width:35pt'></td>
  <td width=105 style='width:79pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Text_x0020_Box_x0020_3" o:spid="_x0000_s1026" type="#_x0000_t202"
   style='position:absolute;direction:LTR;text-align:left;margin-left:57.75pt;
   margin-top:10.5pt;width:175.5pt;height:37.5pt;z-index:2;visibility:visible;
   v-text-anchor:middle' filled="f" stroked="f" strokeweight=".5pt">
   <v:stroke dashstyle="1 1"/>
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t' inset=".5mm,.3mm,.5mm,.3mm"/>
   <x:ClientData ObjectType="Text">
    <x:Anchor>
     7, 77, 0, 14, 10, 84, 2, 12</x:Anchor>
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:77px;margin-top:14px;width:234px;
  height:50px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=234 height=50 align=center valign=middle style='vertical-align:
    top'><![endif]>
    <div v:shape="Text_x0020_Box_x0020_3" style='padding:.8503pt 1.4173pt .8503pt 1.4173pt;
    text-align:center;direction:ltr' class=shape><font class="font8">Mẫu số:
    C1- 02/NS</font><font class="font9"><br>
        </font><font class="font10">Mã hiệu:…………………</font><font class="font9"><br>
        </font><font class="font10"><span style='mso-spacerun:yes'>   
    </span>Số:…………………</font></div>
    <![if !vml]></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl27 width=105 style='height:19.5pt;width:79pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=92 style='width:69pt'></td>
  <td class=xl27 width=33 style='width:25pt'></td>
  <td class=xl27 width=81 style='width:61pt'></td>
  <td class=xl25 width=3 style='width:2pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl26 style='height:19.5pt'>GIẤY NỘP TIỀN VÀO
  NGÂN SÁCH NHÀ NƯỚC</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl47 style='height:19.5pt'>Tiền mặt<span
  style='mso-spacerun:yes'>  </span><font class="font12">£</font><font
  class="font11"> chuyển khoản </font><font class="font13">ý</font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl48 style='height:19.5pt'>(Đánh dấu X vào ô
  tương ứng)</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl28 style='height:10.5pt'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 height=23 class=xl49 style='height:17.25pt'>Người nộp thuế: <font
  class="font15"><%=p_D_Acc_Nm %></font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 height=23 class=xl50 style='height:17.25pt'>Mã số thuế: <font
  class="font7"><%=p_Tax_Code %><span style='mso-spacerun:yes'>  </span></font><font
  class="font11"><span style='mso-spacerun:yes'> </span>Địa chỉ:</font><font
  class="font16"> </font><font class="font7"><%=p_D_Add %></font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl50 style='height:17.25pt'>Người nộp thay:
  ……………………………………………………………………</td>
  <td colspan=5 class=xl50>Mã số thuế:…………………………………………………………</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 height=23 class=xl50 style='height:17.25pt'>Địa chỉ:
  ……………………………………………………………………………………………………………………………………………………………………………</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl28 colspan=3 align=left style='height:17.25pt;
  mso-ignore:colspan'>Huyện: …………………………………………<span style='display:none'>………….</span></td>
  <td colspan=8 class=xl50>Tỉnh, TP:
  ……………………………………………………………………………………………………………….</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 rowspan=2 height=46 class=xl51 width=802 style='height:34.5pt;
  width:602pt'>Đề nghị NH (KBNN):<span style='mso-spacerun:yes'>  </span><font
  class="font17"><%=p_D_Bank %></font><font
  class="font18"> </font><font class="font11">trích TK số: </font><font
  class="font19"><%=p_D_Acc_No %></font><font class="font20"> </font><font
  class="font11"><span style='mso-spacerun:yes'> </span>(hoặc)<span
  style='mso-spacerun:yes'>  </span>nộp tiền mặt để chuyển cho KBNN: </font><font
  class="font7"><%=p_Province %></font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 class=xl25 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 height=23 class=xl50 style='height:17.25pt'>Để ghi thu
  NSNN<span style='mso-spacerun:yes'>     </span><font class="font21">þ</font><font
  class="font22"><span style='mso-spacerun:yes'>   </span></font><font
  class="font11">hoặc nộp vào TK tạm thu số</font><font class="font16">:
  <%=p_C_Acc_No %></font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=11 height=23 class=xl50 style='height:17.25pt'>Cơ quan quản lý
  thu: <font class="font7"><%=p_CQQLT %></font><font class="font22"> </font><font
  class="font11">Mã số:<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=14 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=4 height=23 class=xl50 style='height:17.25pt'>Tờ khai HQ, QĐ số: <font class="font16"><%=p_ToKhai %></font><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 ><span
  style='mso-spacerun:yes'> </span>ngày: <font class="font16"><%=p_Ngay %></font></td>
  <td colspan=5 class=xl50 ><span
  style='mso-spacerun:yes'> </span>Loại hình XNK: <font class="font16"><%=p_LoaiXNK %></font><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl52 style='height:17.25pt'>(hoặc) Bảng kê Biên
  lai số: …………………………………………………………</td>
  <td colspan=6 class=xl52><span style='mso-spacerun:yes'> </span>ngày
  ……………………………………..</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl53 width=62 style='border-bottom:.5pt solid black;  height:30.0pt;border-top:none;width:47pt'>STT</td>
  <td colspan=2 class=xl56 width=175 style='border-right:.5pt solid black;  border-left:none;width:131pt'>Nội dung</td>
  <td rowspan=2 class=xl58 width=67 style='border-bottom:.5pt solid black;  border-top:none;width:50pt'>Cấp</td>
  <td rowspan=2 class=xl53 width=93 style='border-bottom:.5pt solid black;  border-top:none;width:70pt'>Mã chương</td>
  <td colspan=2 rowspan=2 class=xl56 width=94 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:70pt'>Mã ngành</td>
  <td class=xl30 width=105 style='width:79pt' x:str="Mã ">Mã<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl53 width=92 style='border-bottom:.5pt solid black;  border-top:none;width:69pt' x:str="Kỳ thuế ">Kỳ thuế<span  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 rowspan=2 class=xl56 width=114 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:86pt'>Số tiền (VND)</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl62 width=175 style='border-right:.5pt solid black;
  height:15.0pt;border-left:none;width:131pt'>các khoản nộp NS</td>
  <td class=xl30 width=105 style='width:79pt'>NDKT (TM)</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
   <%
	//Response.Write("ddddd");
     //   Response.End();
	string p_ccy = "";
		DataTable dt_detail = ESysLib.TableReadOpenCursor("rpt_SEL_gfbr00040_1", l_Seq+","+l_Seq1);
		if (dt_detail.Rows.Count > 0)
		{
			 p_ccy = dt_detail.Rows[0][7].ToString();
		}
	
     decimal p_Total_Amt = 0;
	 
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
		 /**/
      %>

 <tr height=54 style='mso-height-source:userset;height:40.5pt'>
  <td height=54 class=xl31 width=62 style='height:40.5pt;width:47pt' x:num><%=dt_detail.Rows[i][0]%></td>
  <td colspan=2 class=xl67 width=175 style='border-right:.5pt solid black; border-left:none;width:131pt;font-size:10.0pt'><%=dt_detail.Rows[i][1]%></td>
  <td class=xl32 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl32 width=93 style='width:70pt'><%=dt_detail.Rows[i][2]%></td>
  <td colspan=2 class=xl69 width=94 style='border-right:.5pt solid black;  border-left:none;width:70pt'><%=dt_detail.Rows[i][3]%></td>
  <td class=xl32 width=105 style='width:79pt'><%=dt_detail.Rows[i][4]%></td>
  <td class=xl32 width=92 style='width:69pt'><%=dt_detail.Rows[i][5]%></td>
  <td colspan=2 class=xl71 width=114 style='border-right:.5pt solid black; border-left:none;width:86pt;text-align:right'><%=dt_detail.Rows[i][6]%></td>
  <td class=xl84></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
  <% }%>

 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl33 width=62 style='height:16.5pt;width:47pt'>&nbsp;</td>
  <td colspan=2 class=xl76 width=175 style='border-right:.5pt solid black;
  border-left:none;width:131pt'>&nbsp;</td>
  <td class=xl34 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl34 width=93 style='width:70pt'>&nbsp;</td>
  <td colspan=2 class=xl76 width=94 style='border-right:.5pt solid black;
  border-left:none;width:70pt'>&nbsp;</td>
  <td class=xl34 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl34 width=92 style='width:69pt'>&nbsp;</td>
  <td colspan=2 class=xl76 width=114 style='border-right:.5pt solid black;
  border-left:none;width:86pt'>&nbsp;</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=9 height=22 class=xl78 width=688 style='border-right:.5pt solid black;
  height:16.5pt;width:516pt'>Tổng cộng</td>
  <td colspan=2 class=xl81 width=114 style='border-right:.5pt solid black;
  border-left:none;width:86pt;text-align:right' x:num><%=p_Total_Amt %></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
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
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=11 rowspan=2 height=60 class=xl83 width=802 style='height:45.0pt;
  width:602pt'>Tổng số tiền ghi bằng chữ:<span style='mso-spacerun:yes'> 
  </span><font class="font7"><%=Inword%></font></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl35 style='height:17.25pt'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl37 style='height:6.0pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl27></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=9 height=24 class=xl85 width=688 style='height:18.0pt;width:516pt'>PHẦN
  KBNN GHI</td>
  <td class=xl40 width=33 style='width:25pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl27></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl87 width=444 style='height:18.0pt;width:333pt'>Mã
  quỹ:…………………………………. Mã ĐBH ………………………………</td>
  <td colspan=3 class=xl51 width=244 style='width:183pt'>Nợ TK: ……………………………………</td>
  <td class=xl41 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl27></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl87 width=444 style='height:18.0pt;width:333pt'
  x:str="Mã KBNN:……………………. ………  .Mã nguồn NS:……………………….. ">Mã KBNN:…………………….
  ………<span style='mso-spacerun:yes'>  </span>.Mã nguồn NS:………………………..<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl51 width=244 style='width:183pt'>Có TK: …………………………………..
  ….</td>
  <td class=xl41 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl27></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl42 width=62 style='height:6.0pt;width:47pt'>&nbsp;</td>
  <td class=xl43 width=139 style='width:104pt'>&nbsp;</td>
  <td class=xl43 width=36 style='width:27pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl27></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl55 width=397 style='height:20.25pt;
  width:298pt'>ĐỐI TƯỢNG NỘP TIỀN</td>
  <td class=xl27></td>
  <td colspan=5 class=xl29 width=358 style='width:269pt'>NGÂN HÀNG A</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl88 width=397 style='height:20.25pt;
  width:298pt'>Ngày<span style='mso-spacerun:yes'>  </span><%=p_Date %><span
  style='mso-spacerun:yes'>   </span>tháng<span style='mso-spacerun:yes'> 
  </span><%=p_Month %><span style='mso-spacerun:yes'>  </span>năm <%=p_Year %></td>
  <td class=xl27></td>
  <td colspan=5 class=xl88 width=358 style='width:269pt'>Ngày……tháng……năm……</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl29 width=397 style='height:20.25pt;
  width:298pt'>Người nộp tiền<span style='mso-spacerun:yes'>          
  </span>Kế toán trưởng<span style='mso-spacerun:yes'>           </span>Thủ
  trưởng</td>
  <td class=xl27></td>
  <td colspan=5 class=xl29 width=358 style='width:269pt'>Kế toán<span
  style='mso-spacerun:yes'>                         </span>Kế toán trưởng</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=98 style='mso-height-source:userset;height:73.5pt'>
  <td height=98 colspan=5 class=xl29 style='height:73.5pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl29 width=397 style='height:20.25pt;
  width:298pt'>NGÂN HÀNG B</td>
  <td class=xl27></td>
  <td colspan=5 class=xl29 width=358 style='width:269pt'>KHO BẠC NHÀ NƯỚC</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl29 width=397 style='height:20.25pt;
  width:298pt'><span style='mso-spacerun:yes'>           </span><font
  class="font11">Ngày……tháng……năm……</font></td>
  <td class=xl27></td>
  <td colspan=5 class=xl88 width=358 style='width:269pt'>Ngày……tháng…..năm…….</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl29 width=397 style='height:20.25pt;
  width:298pt'>Kế toán<span
  style='mso-spacerun:yes'>                            </span>Kế toán trưởng</td>
  <td class=xl27></td>
  <td colspan=5 class=xl29 width=358 style='width:269pt'>Thủ quỹ<span
  style='mso-spacerun:yes'>         </span>Kế toán<span
  style='mso-spacerun:yes'>       </span>Kế toán trưởng</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl46 style='height:18.75pt'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl27 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=62 style='width:47pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
