<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string P_ADD_WORK_MON,P_NATION,P_WG,P_SECTION_TYPE,P_SEARCH,P_INPUT;
    string P_TCO_ORG_PK,p_sal_secur;
     
  
    P_ADD_WORK_MON      = Request["P_ADD_WORK_MON"].ToString();
    P_NATION            = Request["P_NATION"].ToString();
    P_WG                = Request["P_WG"].ToString();
    P_SECTION_TYPE      = Request["P_SECTION_TYPE"].ToString();
    P_SEARCH            = Request["P_SEARCH"].ToString();
    P_INPUT             = Request["P_INPUT"].ToString();
    P_TCO_ORG_PK        = Request["P_TCO_ORG_PK"].ToString();
    p_sal_secur         = Request["p_sal_secur"].ToString();
    string l_from,l_to;
    string SQL
	= "SELECT A.FROM_DT FROM THR_CLOSE A " + 
        "        WHERE A.DEL_IF=0 AND A.MONTH_CLOSE='" + P_ADD_WORK_MON + "' AND NVL(A.CLOSE_YN,0)='N' " ;
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
        l_from=P_ADD_WORK_MON + "01";
    else
        l_from=dt_total.Rows[0][0].ToString();
    SQL
	= "SELECT B.ORG_NM " +
        "        ,A.EMP_ID " +
        "        ,A.FULL_NAME " +
        "        ,round(nvl(D.WT_DAYS,0),10) " +
        "        ,round(nvl(D.ALE_DAYS,0),10) " +
        "        ,round(nvl(D.REGIME_DAYS,0),10) " +
        "        ,round(nvl(D.OT,0),10) " +
        "        ,round(nvl(D.HT,0),10) " +
        "        ,round(nvl(D.OHT,0),10) " +
        "        ,round(nvl(D.NT,0) + nvl(D.NT2,0),10) " +
        "        ,round(nvl(D.EXPERIENCE_AMT,0),10) " +
        "        ,round(nvl(D.ATTENDANCE_AMT,0),10) " +
        "        ,round(nvl(D.ADJUSTED_AMT,0),10) " +
        "        ,D.REMARK " +
        "        FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C,THR_ADDITION_MONTH D " +
        "        WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 " +
        "        AND A.TCO_ORG_PK=B.PK " +
        "        AND A.THR_WG_PK=C.PK " +
        "        AND A.JOIN_DT <'" + l_from + "' " +
        "        AND (A.LEFT_DT IS NULL OR A.LEFT_DT > to_char(add_months(to_date('" + l_from + "','yyyymmdd'),-2),'yyyymmdd')) " +
        "        AND D.THR_EMP_PK=A.PK " +
        "        AND D.ADD_WORK_MON='" + P_ADD_WORK_MON + "' " +
        "        AND DECODE('" + P_NATION +"','ALL','ALL',A.NATION )='" + P_NATION +"'" +
        "        AND DECODE('" + P_WG + "','ALL','ALL',A.THR_WG_PK )='" + P_WG + "' " +
        "        AND DECODE('" + P_SECTION_TYPE + "','ALL','ALL',A.SECTION_TYPE )='" + P_SECTION_TYPE + "'  " +
        "        AND (('" + P_SEARCH + "'='1' AND UPPER(A.EMP_ID) LIKE  '%' || UPPER('" + P_INPUT + "')|| '%') " +
        "         OR ('" + P_SEARCH + "'='2' AND UPPER(A.ID_NUM) LIKE  '%' || UPPER('" + P_INPUT + "')|| '%') " +
        "         OR ('" + P_SEARCH + "'='3' AND UPPER(A.FULL_NAME) LIKE  '%' || UPPER('" + P_INPUT + "')|| '%' )) " +
        "         AND (   A.TCO_ORG_PK IN (SELECT     G.PK " +
        "                                    FROM COMM.TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = DECODE ('" + P_TCO_ORG_PK + "','ALL', 0, '" + P_TCO_ORG_PK + "') " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + P_TCO_ORG_PK + "' = 'ALL') " +
        "        ORDER BY B.ORG_NM,C.WORKGROUP_NM,A.EMP_ID " ;




//Response.Write(SQL);
//Response.End();
    dt_total = ESysLib.TableReadOpen(SQL);
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_addition_att_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_addition_att_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_addition_att_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-07-13T03:12:17Z</o:LastPrinted>
  <o:Created>2011-03-17T01:47:54Z</o:Created>
  <o:LastSaved>2011-07-13T03:12:40Z</o:LastSaved>
  <o:Company>HP Compaq</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .21in .21in .27in;
	mso-header-margin:.18in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
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
.xl24
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
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
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double black;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>04 2011</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2450</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='04 2011'!$A$1:$O$6</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='04 2011'!$2:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=16720 style='border-collapse:
 collapse;table-layout:fixed;width:12540pt'>
 <col class=xl25 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl25 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl25 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl25 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl25 width=51 span=2 style='mso-width-source:userset;mso-width-alt:
 1865;width:38pt'>
 <col class=xl25 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=84 span=2 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <col class=xl25 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>

 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=15 height=35 class=xl46 width=1170 style='height:26.25pt;
  width:878pt'>DANH SÁCH BÙ LƯƠNG THÁNG <%=P_ADD_WORK_MON.Substring(4,2).ToString() + "/" + P_ADD_WORK_MON.Substring(0,4).ToString() %></td>
  
 </tr>
 <tr class=xl26 height=22 style='height:16.5pt'>
  <td rowspan=3 height=65 class=xl47 style='border-bottom:2.0pt double black;
  height:48.75pt;border-top:none'>STT</td>
  <td rowspan=3 class=xl37 style='border-bottom:2.0pt double black'>Bộ Phận</td>
  <td rowspan=3 class=xl37 style='border-bottom:2.0pt double black;border-top:
  none'>Mã Số</td>
  <td rowspan=3 class=xl37 style='border-bottom:2.0pt double black;border-top:
  none'>Họ Tên</td>
  <td colspan=9 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>CHI TIẾT BÙ LƯƠNG</td>
  <%if (p_sal_secur=="1")
    { %>
  <td rowspan=3 class=xl37 style='border-bottom:2.0pt double black'>Tổng tiền</td>
  <%} %>
  <td rowspan=3 class=xl53 style='border-bottom:2.0pt double black;'>Ghi chú</td>
 
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td rowspan=2 height=43 class=xl43 style='border-bottom:2.0pt double black;
  height:32.25pt;border-top:none'>Ngày Công</td>
  <td rowspan=2 class=xl43 style='border-bottom:2.0pt double black;border-top:
  none'>Phép Năm</td>
  <td rowspan=2 class=xl43 style='border-bottom:2.0pt double black;border-top:
  none'>Nghỉ CĐ</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Tăng Ca</td>
  <td rowspan=2 class=xl43 style='border-bottom:2.0pt double black;border-top:
  none'>Ca Đêm</td>
  <td rowspan=2 class=xl44 width=86 style='border-bottom:2.0pt double black;
  border-top:none;width:65pt'>Kinh Nghiệm</td>
  <td rowspan=2 class=xl44 width=84 style='border-bottom:2.0pt double black;
  border-top:none;width:63pt'>Chuyên Cần</td>
 </tr>
 
 <tr class=xl26 height=22 style='height:16.5pt'>
  <td height=22 class=xl27 style='height:16.5pt' x:num>1.5</td>
  <td class=xl27 x:str="'2.0">2.0</td>
  <td class=xl27 x:str="'3.0">3.0</td>
 </tr>
 <% 
    double[] Group_Total=new double[10] {0,0,0,0,0,0,0,0,0,0};
     for (int i = 0; i < irow; i++) 
    {
       for (int j=0;j<9;j++)
            Group_Total[j]+=Double.Parse(dt_total.Rows[i][j+3].ToString());
    %> 
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt' x:num><%=i+1 %></td>
  <td class=xl29><% = dt_total.Rows[i][0].ToString()%></td>
  <td class=xl30><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl30><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][3].ToString()%> </td>
  <td class=xl32 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl32 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl33 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'> </span><% = dt_total.Rows[i][11].ToString()%></td>
   <%if (p_sal_secur=="1")
    { %>
    <td class=xl36 x:num><% = dt_total.Rows[i][12].ToString()%></td>
    <%} %>
  <td class=xl35><% = dt_total.Rows[i][13].ToString()%></td>
 </tr>
 <%} %>
 
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl64 style='height:21.75pt' x:str="Tổng ">Tổng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl66 x:num><span style='mso-spacerun:yes'>          
  </span><%=Group_Total[0] %> </td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=Group_Total[1] %></td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=Group_Total[2] %> </td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=Group_Total[3] %></td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%=Group_Total[4] %> </td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%=Group_Total[5] %></td>
  <td class=xl66 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=Group_Total[6] %></td>
  <td class=xl67 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%=Group_Total[7] %></td>
  <td class=xl67 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=Group_Total[8] %></td>
   <%if (p_sal_secur=="1")
    { %>
  <td class=xl67 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=Group_Total[9] %></td>
  <%} %>
  <td class=xl68 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=15 class=xl25 style='height:16.5pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
