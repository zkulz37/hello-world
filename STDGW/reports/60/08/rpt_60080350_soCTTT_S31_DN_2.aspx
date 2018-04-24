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
    string com_pk = "" + Request["com"];
    string ac_pk = "" + Request["acc_pk"];
    string cust_pk = "" + Request["cust_pk"];
    string date_from = "" + Request["sdate"];
    string from_date = date_from.Substring(6, 2) + "/" + date_from.Substring(4, 2) + "/" + date_from.ToString().Substring(0, 4);
    string date_to = "" + Request["edate"];
    string to_date = date_to.Substring(6, 2) + "/" + date_to.Substring(4, 2) + "/" + date_to.Substring(0, 4);
    string ccy = "" + Request["ccy"];
    string status = "" + Request["status"];
	string amt_type = "" + Request["amt_type"];
    string partner_pk = "";
    string partner_id = "";
    string partner_nm = "";
    string name = "";
    string lname = "";
    string address = "";
    string tax_code = "";
    string ac_cd = "";
    string ac_nm = "";
    string drcr_type = "";

    double dr_openning = 0;
    double cr_openning = 0;
    double dr_closing = 0;
	double dr_amt_sum =0;
	double cr_amt_sum =0;
    double cr_closing = 0;
    double dr_sum = 0;
    double cr_sum = 0;
    double ending = 0;
    double p_numrow_head = 12;
    double p_numrow_foot = 14;
    double p_page_break = 0;   
    int dc;
    int i = 0; 
    string seq = "";
    string tr_date="";
    string remark = "";
    string remark2 = "";
    string voucherno = "";
    string corr_acc = "";
    string p_book_ccy = ""; 
    double dr_amt = 0;
    double cr_amt = 0;
	double end_dr=0;
	double end_cr=0;
    double dr_end = 0;
    double cr_end = 0;
    string SQLC = "";
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";
    String e6 = "";
    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";
    String v6 = "";
    String g1 = "";
    String g2 = "";
    String g3 = "";
    String g4 = "";
    String g5 = "";
    String g6 = "";
    String n1 = "";
    String n2 = "";
    String n3 = "";
    String n4 = "";
    String n5 = "";
    String n6 = "";
	string para="";
	DataTable dtD;
	string openning="";
	string para_mst="'" + com_pk + "','" + date_from  + "','" + ac_pk + "','" + cust_pk + "' ,'" + status + "','" + ccy + "'";
	DataTable dtB = ESysLib.TableReadOpenCursor("ac_rpt_60080350_master",para_mst);	
	
	
    if (dtB.Rows.Count > 0)
    {
        name = dtB.Rows[0]["partner_name_company"].ToString();
        lname = dtB.Rows[0]["partner_lname_company"].ToString();
        address = dtB.Rows[0]["addr1_company"].ToString();
        tax_code = dtB.Rows[0]["tax_code_company"].ToString();
		 
		ac_cd = dtB.Rows[0]["ac_cd"].ToString();
        ac_nm = dtB.Rows[0]["ac_nm"].ToString();
        drcr_type = dtB.Rows[0]["drcr_type"].ToString();
    }
	string SQL="";
    SQL = "SELECT   " +
                "    D.CODE, " +
                "    D.CHAR_1,  " +
                "    D.CHAR_2,  " +
                "    D.CHAR_3,  " +
                "    D.CHAR_4,  " +
                "    D.CHAR_5,  " +
                "    D.REMARK " +
                " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
                " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
                " AND M.ID='EACAB034' " +
                " order by D.ORD ";
    DataTable dt1 = ESysLib.TableReadOpen(SQL);


    for (int k = 0; k < dt1.Rows.Count; k++)
    {

        string strTmp = dt1.Rows[k][0].ToString();
       
        if (strTmp == "VIE")
        {
            v1 = dt1.Rows[k][1].ToString();
            v2 = dt1.Rows[k][2].ToString();
            v3 = dt1.Rows[k][3].ToString();
            v4 = dt1.Rows[k][4].ToString();
            v5 = dt1.Rows[k][5].ToString();
            v6 = dt1.Rows[k][6].ToString();
        }
        if (strTmp == "SIGN")
        {
            g1 = dt1.Rows[k][1].ToString();
            g2 = dt1.Rows[k][2].ToString();
            g3 = dt1.Rows[k][3].ToString();
            g4 = dt1.Rows[k][4].ToString();
            g5 = dt1.Rows[k][5].ToString();
            g6 = dt1.Rows[k][6].ToString();
        }

        if (strTmp == "NAM")
        {
            n1 = dt1.Rows[k][1].ToString();
            n2 = dt1.Rows[k][2].ToString();
            n3 = dt1.Rows[k][3].ToString();
            n4 = dt1.Rows[k][4].ToString();
            n5 = dt1.Rows[k][5].ToString();
            n6 = dt1.Rows[k][6].ToString();
        }
    }  
    SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'  ";
    DataTable dtCcy = ESysLib.TableReadOpen(SQL);
    if (dtCcy.Rows.Count > 0)
    {
        p_book_ccy  = dtCcy.Rows[0][0].ToString();
    }

    String p_xls_ccy = "";
    if (p_book_ccy == "VND")
    {
        p_xls_ccy = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string cust_pk_list = "";
    string strtmp = "";
    string SQLB = "select distinct(cust_pk) from ( select m.TCO_BUSPARTNER_PK cust_pk from TAC_HGCUSTMMBAL m where m.del_if=0 and m.STD_YM||'01'< '" + date_to + "'  and  m.TAC_ABACCTCODE_PK= '" + ac_pk + "' union all select d.TCO_BUSPARTNER_PK cust_pk from TAC_HGCUSTDDBAL d where d.del_if=0   and d.STD_YMD <='" + date_to + "'   and  d.TAC_ABACCTCODE_PK= '" + ac_pk + "' ) where (('" + cust_pk + "' is null) or (cust_pk='" + cust_pk + "')) and (cust_pk is not null) ";
     
    /*if (cust_pk == "")
    {
        dtB = ESysLib.TableReadOpen(SQLB);
        if (dtB.Rows.Count > 0)
        {
            for (i = 0; i < dtB.Rows.Count; i++)
            {
                cust_pk_list = cust_pk_list + strtmp + dtB.Rows[i][0].ToString();
                strtmp = ",";
            }
        }
    }*/
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00050_soCTTT_S31-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00050_soCTTT_S31-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00050_soCTTT_S31-DN_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-08-22T06:26:57Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2008-08-22T06:27:10Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{
	mso-footer-data:"&CPage &P";
	margin:.5in 0in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
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
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
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
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>So cai NKC (Mau so S03b-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>12</x:SplitHorizontal>
     <x:TopRowBottomPane>12</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   <x:PageBreaks>
     <x:RowBreaks>
       
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1553 style='border-collapse:
 collapse;table-layout:fixed;width:1164pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=292 span=2 style='mso-width-source:userset;mso-width-alt:
 10678;width:219pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl25 width=123 span=4 style='mso-width-source:userset;mso-width-alt:
 4498;width:92pt'>
 <col class=xl25 width=64 style='width:48pt'>
<% 
     if (dtB.Rows.Count > 0)
     {
         for (i = 0; i < dtB.Rows.Count; i++)
         {
             partner_pk = dtB.Rows[i]["tco_buspartner_pk"].ToString();
			 partner_id = dtB.Rows[i]["partner_id"].ToString();
             openning = dtB.Rows[i]["openning"].ToString();
             partner_nm = dtB.Rows[i]["partner_name"].ToString();
			 
			 para="'" + com_pk + "','" + date_from  + "','" + date_to  + "','" + ac_pk + "','" + partner_pk + "','" + openning + "','" + status + "','" + ccy + "'";
			 string para_op_bal="'" + com_pk + "','" + date_from  + "','" + date_to  + "','" + ac_pk + "','" + partner_pk + "','" + status + "','" + amt_type + "'";
			 DataTable dtOpenClosing = ESysLib.TableReadOpenCursor("ac_sel_60080350_voucher_sum",para_op_bal);
			 if(dtOpenClosing.Rows.Count >1)
			 {
				dr_openning = double.Parse(dtOpenClosing.Rows[1][1].ToString());
				cr_openning = double.Parse(dtOpenClosing.Rows[1][2].ToString());
				
				dr_closing  = double.Parse(dtOpenClosing.Rows[1][13].ToString());
				cr_closing  = double.Parse(dtOpenClosing.Rows[1][14].ToString());
				
				dr_amt_sum  = double.Parse(dtOpenClosing.Rows[1][5].ToString());
				cr_amt_sum  = double.Parse(dtOpenClosing.Rows[1][6].ToString());
				
				
			 }
			 
			 dtD = ESysLib.TableReadOpenCursor("ac_rpt_60080350_detail",para);
			 
			 if(dr_openning !=0 || cr_openning!=0 || dtD.Rows.Count > 0)
			 {
			 
 %>
 
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl80 width=561 style='height:14.25pt;
  width:421pt'><%=lname%></td>
  <td class=xl24 width=292 style='width:219pt'></td>
  <td class=xl25 width=63 style='width:47pt'></td>
  <td class=xl70 width=81 style='width:61pt'></td>
  <td colspan=5 class=xl34 width=556 style='width:416pt'><span
  style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S31-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl81 width=561 style='height:14.25pt;
  width:421pt'><%=address%>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl32></td>
  <td colspan=5 class=xl72
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl80 style='height:15.75pt'>Mã s&#7889;
  thu&#7871;:<%=tax_code %></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl32></td>
  <td colspan=5 class=xl72>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=12 height=30 class=xl73 style='height:22.5pt'
  x:str="S&#7892; CHI TI&#7870;T THANH TOÁN V&#7898;I NG&#431;&#7900;I MUA/  NG&#431;&#7900;I BÁN ">S&#7892;
  CHI TI&#7870;T THANH TOÁN V&#7898;I NG&#431;&#7900;I MUA/<span
  style='mso-spacerun:yes'>  </span>NG&#431;&#7900;I BÁN<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=12 height=26 class=xl72 style='height:19.5pt'>T&#7915; ngày <%=from_date %>
  &#272;&#7871;n ngày <%=to_date %></td>
 </tr>
 <tr class=xl32 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 colspan=2 style='height:19.5pt;mso-ignore:colspan'>S&#7889;
  hi&#7879;u tài kho&#7843;n:</td>
  <td class=xl33 x:num><%=ac_cd %></td>
  <td colspan=6 class=xl33><%=ac_nm%></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
 </tr>
 
 <tr class=xl32 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 colspan=2 style='height:19.5pt;mso-ignore:colspan'>&#272;&#7889;i
  t&#432;&#7907;ng:</td>
  <td class=xl33><%=partner_id%></td>
  <td colspan=6 class=xl33><%=partner_nm %></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl35>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl36><%= p_book_ccy  %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl34 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td rowspan=2 height=63 class=xl76 width=74 style='border-bottom:.5pt solid black;
  height:47.25pt;width:56pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Di&#7877;n
  gi&#7843;i</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl76 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>S&#7889; hi&#7879;u TK &#273;&#7889;i &#7913;ng</td>
  <td rowspan=2 class=xl76 width=81 style='border-bottom:.5pt solid black;
  width:61pt'>Th&#7901;i h&#7841;n &#273;&#432;&#7907;c chi&#7871;t kh&#7845;u</td>
  <td colspan=2 class=xl74 style='border-left:none'>S&#7889; phát sinh</td>
  <td colspan=2 class=xl74>S&#7889; d&#432;</td>
  <td class=xl37>Ghi chú</td>
 </tr>
 <tr class=xl34 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl38 style='height:25.5pt'>S&#7889;</td>
  <td class=xl39 width=95 style='width:71pt'>Ngày tháng</td>
  <td class=xl38>N&#7907;</td>
  <td class=xl58  style='border-right:.5pt solid windowtext;'>Có</td>
  <td class=xl38>N&#7907;</td>
  <td class=xl58>Có</td>
  <td class=xl68>Seq</td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl71 width=74 style='height:15.75pt;width:56pt'>A</td>
  <td class=xl38>B</td>
  <td class=xl39 width=95 style='width:71pt'>C</td>
  <td class=xl68 style='border-left:none'>D</td>
  <td class=xl38>E</td>
  <td class=xl39 width=63 style='width:47pt'>F</td>
  <td class=xl39 width=81 style='width:61pt'>G</td>
  <td class=xl38 x:num>1</td>
  <td class=xl58 style='border-right:.5pt solid windowtext;' x:num>2</td>
  <td class=xl38 x:num>3</td>
  <td class=xl58 x:num>4</td>
  <td class=xl68>H</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt;border-top:.5pt solid windowtext;'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl83 width=292 style='width:219pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  <td class=xl83 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl43 x:num  style="mso-number-format:'<%= p_xls_ccy %>';"></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num  style="mso-number-format:'<%= p_xls_ccy %>';"></td>
  <td class=xl69 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy %>'" x:num><%=dr_openning %></td>
  <td class=xl69 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy %>'" x:num><%=cr_openning%></td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
        dr_sum = 0;
        cr_sum = 0;
        
        for (int j = 0; j < dtD.Rows.Count; j++)
        {
            seq = dtD.Rows[j]["pk"].ToString();
            tr_date = dtD.Rows[j]["tr_date"].ToString();;
            voucherno = dtD.Rows[j]["voucherno"].ToString();
            corr_acc = dtD.Rows[j]["acct_code"].ToString();
			
			dr_amt = double.Parse(dtD.Rows[j]["dr_amt"].ToString());
            cr_amt = double.Parse(dtD.Rows[j]["cr_amt"].ToString());

            end_dr = double.Parse(dtD.Rows[j]["end_dr"].ToString());
            end_cr = double.Parse(dtD.Rows[j]["end_cr"].ToString());
			
			
            remark = dtD.Rows[j]["remark"].ToString();
            remark2 = dtD.Rows[j]["remark2"].ToString();
            
			
			
  %>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'><%=tr_date%></td>
  <td class=xl29 style='border-left:none'><%=voucherno%></td>
  <td class=xl29 style='border-left:none'><%=tr_date%></td>
  <td class=xl56 width=292 style='border-left:none;width:219pt'><%=remark2%></td>
  <td class=xl56 width=292 style='border-left:none;width:219pt'><%=remark%></td>
  <td class=xl44 x:num><%=corr_acc%></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_amt%></td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=cr_amt%></td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=end_dr%></td>
  <td class=xl62 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' x:num  style="mso-number-format:'<%= p_xls_ccy %>';"><%=end_cr%></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=seq%></td>
 </tr>
 <%
        }		       
  %>
 
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49 x:str="T&#7893;ng c&#7897;ng s&#7889; phát sinh"><span
  style='mso-spacerun:yes'> </span>T&#7893;ng c&#7897;ng s&#7889; phát
  sinh<span style='mso-spacerun:yes'> </span></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_amt_sum%></td>
  <td class=xl49 style='mso-spacerun:yes' x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=cr_amt_sum%></td>
  <td class=xl49 style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;" x:num></td>
  <td class=xl49 style="mso-spacerun:yes;mso-number-format:'<%= p_xls_ccy %>'" x:num></td>
  <td class=xl61 style='mso-spacerun:yes'>&nbsp;</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 width=292 style='width:219pt'>S&#7888; D&#431; CU&#7888;I
  K&#7922;</td>
  <td class=xl53 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl54 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"></td>
  <td class=xl54 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;" x:num><%=dr_closing%></td>
  <td class=xl60 x:num style="mso-spacerun:yes;mso-number-format:'<%= p_xls_ccy %>'"><%=cr_closing%></td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=11 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>

 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl72>Ngày ........ tháng ........ n&#259;m ...........</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'></td>
  <td class=xl34><%= v1 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl34><%= v2 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl34><%= v3 %></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'></td>
  <td class=xl55><%= g1 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl55><%= g3 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl55><%= g3 %></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
<tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
<tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=12 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>  
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'></td>
  <td class=xl34><%= n1 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl34><%= n2 %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl34><%= n3 %></td>
 </tr> 
 <%
				}
			 }
         }           
 %> 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
