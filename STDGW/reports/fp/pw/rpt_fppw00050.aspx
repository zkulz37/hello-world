<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tlg_gd_plan_d_pk = Request["p_tlg_gd_plan_d_pk"].ToString();

    string SQL
    = "select to_char(to_date(HR_F_BEGIN_OF_WEEK(B.PLAN_DATE,D.TCO_COMPANY_PK),'yyyymmdd'),'DD MON') " +
        "       ||'~' ||  " +
        "       to_char(to_date(HR_F_BEGIN_OF_WEEK(B.PLAN_DATE,D.TCO_COMPANY_PK),'yyyymmdd')+6,'DD MON')    " +
        "       c00 " +
        "    , to_char(to_date(B.PLAN_DATE,'yyyymmdd'),'DD MON YYYY') c01         " +
        "    , to_char(SYSDATE,'DD MON YYYY') c02 " +
        "    , E.PARTNER_NAME c03 " +
        "    , D.PO_NO c04 " +
        "    , D.SLIP_NO c05 " +
        "    , B.PLAN_QTY c06 " +
        "    , C.ORD_UOM c07 " +
        "    , F.ITEM_NAME c08 " +
        "from tlg_gd_plan_m a, tlg_gd_plan_d b " +
        "    , tlg_sa_saleorder_d c , tlg_sa_saleorder_m d " +
        "    , TCO_BUSPARTNER e, tlg_it_item f " +
        "where A.DEL_IF = 0 " +
        "and B.DEL_IF = 0 " +
        "and C.DEL_IF = 0 " +
        "and D.DEL_IF = 0 " +
        "and F.DEL_IF = 0 " +
        "and f.pk = B.DELI_ITEM_PK " +
        "and b.wi_no is not null " +
        "and A.PK = b.tlg_gd_plan_m_pk " +
        "and D.PK = C.TLG_SA_SALEORDER_M_PK " +
        "and e.pk = D.DELI_TO_PK " +
        "and b.pk = " + p_tlg_gd_plan_d_pk +
        "and B.TLG_SA_SALEORDER_D_PK = c.pk ";

    DataTable dt_table = ESysLib.TableReadOpen(SQL);
    
    if(dt_table.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppw00050_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppw00050_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppw00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>DENNYHO</o:Author>
  <o:LastAuthor>Hee Nguyen</o:LastAuthor>
  <o:Created>2014-09-18T04:00:08Z</o:Created>
  <o:LastSaved>2014-10-25T02:24:45Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .32in .75in .25in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
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
.style56
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style56;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl76
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl91
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl93
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl94
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl96
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl100
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl101
	{mso-style-parent:style56;
	color:windowtext;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl105
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl114
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted black;}
.xl116
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl120
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl121
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl126
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl127
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl128
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl129
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl132
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl133
	{mso-style-parent:style56;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl134
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl135
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl137
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl138
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl139
	{mso-style-parent:style56;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>6. LENH SX</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$6:$F$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11580</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>3600</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=858 style='border-collapse:
 collapse;table-layout:fixed;width:645pt'>
 <col class=xl66 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl66 width=64 style='width:48pt'>
 <col class=xl66 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl66 width=64 span=2 style='width:48pt'>
 <col class=xl66 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl66 width=64 span=3 style='width:48pt'>
 <col class=xl66 width=190 style='mso-width-source:userset;mso-width-alt:6948;
 width:143pt'>
 <col class=xl66 width=64 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 width=16 style='height:15.0pt;width:12pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=130 style='width:98pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=74 style='width:56pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
  <td class=xl76 width=190 style='width:143pt'></td>
  <td class=xl76 width=64 style='width:48pt'></td>
 </tr>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl76 style='height:21.0pt'></td>
  <td colspan=9 class=xl101>LỆNH SẢN XUẤT</td>
  <td class=xl67></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl76 style='height:18.75pt'></td>
  <td colspan=10 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl76 style='height:34.5pt'></td>
  <td colspan=2 class=xl102 width=194 style='width:146pt'>Kế hoạch<br>
    </td>
  <td colspan=4 class=xl103>DELIVERY PLAN (<%=dt_table.Rows[0]["c00"].ToString() %>)</td>
  
  <td class=xl82 width=64 style='width:48pt'>Ngày kế hoạch</td>
  <td class=xl83>Kiểm tra</td>
  <td class=xl82 width=190 style='width:143pt'>Quản lí<br>
    </td>
  <td class=xl76></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'></td>
  <td colspan=2 class=xl104>Ngày<span style='mso-spacerun:yes'>  </span>kế
  hoạch</td>
  <td colspan=3 class=xl100><%=dt_table.Rows[0]["c01"].ToString() %></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl76></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'></td>
  <td colspan=2 class=xl99>S/O<span style='mso-spacerun:yes'>  </span>kế hoạch</td>
  <td colspan=3 class=xl100>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl76></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'></td>
  <td colspan=2 class=xl99>Ngày sản xuất</td>
  <td colspan=3 class=xl100><%=dt_table.Rows[0]["c02"].ToString() %></td>
  <td class=xl70></td>
  <td colspan=3 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl76></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl76 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl108>&nbsp;</td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=2 class=xl109>KHÁCH HÀNG</td>
  <td colspan=3 class=xl111 style='border-right:.5pt solid black'>:<%=dt_table.Rows[0]["c03"].ToString() %></td>
  <td class=xl71 colspan=2 style='mso-ignore:colspan'>SỐ HÓA ĐƠN</td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black'>:<%=dt_table.Rows[0]["c04"].ToString() %></td>
  <td class=xl76></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td class=xl72>ES NO</td>
  <td class=xl73>&nbsp;</td>
  <td colspan=3 class=xl113 style='border-right:.5pt dotted black'>:<%=dt_table.Rows[0]["c05"].ToString() %></td>
  <td colspan=2 class=xl115 style='border-left:none'>QTY()</td>
  <td class=xl74>:<%=dt_table.Rows[0]["c06"].ToString() %></td>
  <td class=xl75><%=dt_table.Rows[0]["c07"].ToString() %></td>
  <td class=xl76></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=2 class=xl116>SẢN PHẨM()</td>
  <td colspan=7 class=xl97>:<%=dt_table.Rows[0]["c08"].ToString() %></td>
  
  <td class=xl76></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl76 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=9 class=xl105 style='border-right:.5pt solid black'
  x:str="NGUYÊN VẬT LIỆU CHO CHUYỀN  () ">NGUYÊN VẬT LIỆU CHO CHUYỀN<span
  style='mso-spacerun:yes'>  </span>()<span style='mso-spacerun:yes'> </span></td>
  <td class=xl76></td>
 </tr>
 <tr height=69 style='mso-height-source:userset;height:51.75pt'>
  <td height=69 class=xl76 style='height:51.75pt'></td>
  <td class=xl87 width=64 style='width:48pt'>STT<br>
    No</td>
  <td class=xl88 width=130 style='width:98pt'>Mã nguyên vật liệu<br>
    </td>
  <td colspan=4 class=xl118 width=266 style='border-right:.5pt solid black;
  border-left:none;width:200pt'>Tên nguyên vật liệu<br>
    </td>
  <td class=xl88 width=64 style='width:48pt'>Đơn vị<br>
    </td>
  <td class=xl88 width=64 style='width:48pt'>SL Yêu cầu<br>
    </td>
  <td class=xl89 width=190 style='width:143pt'>Thực xuất<br>
    </td>
  <td class=xl76></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=9 class=xl121 style='border-right:.5pt solid black'>BÁO CÁO SẢN
  XUẤT()</td>
  <td class=xl76></td>
 </tr>
 <tr height=60 style='height:45.0pt'>
  <td height=60 class=xl90 style='height:45.0pt'></td>
  <td colspan=2 class=xl124 width=194 style='border-right:.5pt solid black;
  width:146pt'>Công đoạn <br>
    </td>
  <td class=xl91 width=64 style='width:48pt'>Máy<br>
    </td>
  <td class=xl92 width=64 style='width:48pt'>Sản phẩm<br>
    </td>
  <td colspan=2 class=xl124 width=138 style='border-right:.5pt solid black;
  width:104pt'>Phế phẩm<br>
    </td>
  <td class=xl93 width=64 style='border-left:none;width:48pt'>Giờ bắt đầu<br>
    </td>
  <td class=xl94 width=64 style='width:48pt'>Giờ kết thúc<br>
    </td>
  <td class=xl94 width=190 style='width:143pt'>Nhân công<br>
    </td>
  <td class=xl86></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'></td>
  <td colspan=2 class=xl126 width=194 style='border-right:.5pt solid black;
  width:146pt'>CUTTING</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl128 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl95></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=2 class=xl126 width=194 style='border-right:.5pt solid black;
  width:146pt'>PRESS</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl128 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl95></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl76 style='height:17.25pt'></td>
  <td colspan=2 class=xl130 width=194 style='border-right:.5pt solid black;
  width:146pt'>SKIVING</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl96>OP(LANG)</td>
  <td colspan=2 class=xl132 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl95></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl76 style='height:15.0pt'></td>
  <td colspan=2 class=xl134 style='border-right:.5pt solid black'>SL trên
  khuông/Số khuông</td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=2 class=xl138 style='border-right:.5pt solid black;border-left:
  none'>Lần</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80>SL kiểm</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl70></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=16 style='width:12pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=190 style='width:143pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
