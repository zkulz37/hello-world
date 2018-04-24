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

    
    //string SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
    string SQL = " SELECT pk, partner_name, partner_lname, addr2 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + com_pk + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQL);
    if (dtCom.Rows.Count > 0)
    {
        name = dtCom.Rows[0][1].ToString();
        lname = dtCom.Rows[0][2].ToString();
        address = dtCom.Rows[0][3].ToString();
        tax_code = dtCom.Rows[0][4].ToString();
    }

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

    string SQLAC = "SELECT pk,ac_cd_formular ac_cd, ac_nm, drcr_type  FROM tac_abacctcode ";
        SQLAC +=  " WHERE del_if = 0 and tco_company_pk ='" + com_pk + "' and pk ='" + ac_pk + "'";
    
    DataTable dtAcc = ESysLib.TableReadOpen(SQLAC);
    if (dtAcc.Rows.Count > 0)
    {
        ac_cd = dtAcc.Rows[0][1].ToString();
        ac_nm = dtAcc.Rows[0][2].ToString();
        drcr_type = dtAcc.Rows[0][3].ToString();
    }

    string cust_pk_list = "";
    string strtmp = "";
    string SQLB = "select distinct(cust_pk) from ( select m.TCO_BUSPARTNER_PK cust_pk from TAC_HGCUSTMMBAL m where m.del_if=0 and m.STD_YM||'01'< '" + date_to + "'  and  m.TAC_ABACCTCODE_PK= '" + ac_pk + "' union all select d.TCO_BUSPARTNER_PK cust_pk from TAC_HGCUSTDDBAL d where d.del_if=0   and d.STD_YMD <='" + date_to + "'   and  d.TAC_ABACCTCODE_PK= '" + ac_pk + "' ) where (('" + cust_pk + "' is null) or (cust_pk='" + cust_pk + "')) and (cust_pk is not null) ";
     
    if (cust_pk == "")
    {
        dtAcc = ESysLib.TableReadOpen(SQLB);
        if (dtAcc.Rows.Count > 0)
        {
            for (i = 0; i < dtAcc.Rows.Count; i++)
            {
                cust_pk_list = cust_pk_list + strtmp + dtAcc.Rows[i][0].ToString();
                strtmp = ",";
            }
        }
    }
     SQLB = "  select b.PK, PARTNER_ID,PARTNER_NAME, ";
       // SQLB += "     SF_GET_CUST_OPENINGBAL('" + com_pk + "','" + date_from + "','" + ac_pk + "',  a.TCO_BUSPARTNER_PK ,'"+status + "','" + ccy + "') openning  ";
     SQLB += "     SF_GET_CUST_OPENBAL('" + com_pk + "','" + ac_pk + "',b.PK ,'" + date_from + "','" + ccy + "','" + status + "','BOOKS') openning  ";
        SQLB += " from TCO_BUSPARTNER b  ";
        SQLB += " where b.del_if =0   ";
        if (cust_pk == "")
        {
            SQLB += " and  b.PK IN (" + cust_pk_list + ")   ";
        }
        else
        {
            SQLB += " and  b.PK =" + cust_pk + "   ";
        }
       
        DataTable dtB = ESysLib.TableReadOpen(SQLB);
    
        
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
       <% 
    double d_tmp =0;

    if (dtB.Rows.Count > 0)
    {
            for (i = 0; i < dtB.Rows.Count; i++)
          { 
                SQLC = " select count(*)  ";
                SQLC += "  from tac_hgtrh h, tac_hgtrd d, tac_hgtrd_ref r ";
                SQLC += " where h.del_if = 0 and d.del_if = 0 and r.del_if = 0 ";
                SQLC += "   and h.TCO_COMPANY_PK = '" + com_pk + "' ";
                SQLC += "   and to_char(tr_date,'YYYYMMDD') between '" + date_from + "' and '" + date_to + "' ";
                SQLC += "   and d.tac_abacctcode_pk IN (SELECT     pk       FROM tac_abacctcode     WHERE del_if = 0 AND leaf_yn = 'Y'    CONNECT BY pac_pk = PRIOR pk          START WITH pk = '" + ac_pk + "')  ";
                SQLC += "   and d.TCO_BUSPARTNER_PK = " + dtB.Rows[i][0].ToString();
                SQLC += "   and d.tac_hgtrh_pk = h.pk ";
                SQLC += "   and r.tac_hgtrd_pk = d.pk ";
                SQLC += "   AND h.tr_status in ('" + status + "',DECODE('" + status + "',2,0,'" + status + "'),DECODE('" + status + "',2,4,'" + status + "'))  ";
                SQLC += "   and d.ccy like '%' || '" + ccy + "' || '%' "; 
               
               DataTable dtC = ESysLib.TableReadOpen(SQLC);
               d_tmp = double.Parse(dtC.Rows[0][0].ToString());
               p_page_break = p_page_break + p_numrow_head + d_tmp + p_numrow_foot;
                %>
                     <x:RowBreak>
                    <x:Row><%= p_page_break%></x:Row>
                    </x:RowBreak> 
            <% 
          } 
    } 
   %> 
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
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$A$10:$L$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
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
             partner_pk = dtB.Rows[i][0].ToString();
             partner_id = dtB.Rows[i][1].ToString();
             partner_nm = dtB.Rows[i][2].ToString();
             dr_openning = 0;
             cr_openning = 0;
             if (drcr_type == "D")
             {
                 dr_openning = double.Parse(dtB.Rows[i][3].ToString());
                 cr_openning = 0;

             }
             else
             {
                 dr_openning = 0;
                 cr_openning = double.Parse(dtB.Rows[i][3].ToString());

             }
             dr_end = dr_openning;
             cr_end = cr_openning;
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
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Invoice No</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Invoice Date</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Serial No</td>
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
  <td class=xl68>I</td>
  <td class=xl68>J</td>
  <td class=xl68>K</td>
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
  <td class=xl43 x:num  style="mso-number-format:'<%= p_xls_ccy %>';"><%=dr_openning %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num  style="mso-number-format:'<%= p_xls_ccy %>';"><%=cr_openning%></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num></td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
        string SQLD = " select h.pk, to_char(h.tr_date,'YYYYMMDD'), h.voucherno,  ";
        SQLD += "     " + ac_pk + ", ";
        //SQLD += "    SF_A_GET_ACCD(r.tac_abacctcode_pk_cr,'" + com_pk + "') corr_ac, ";

        SQLD += "SF_A_GET_ACCD(DECODE(D.DRCR_TYPE,'D',DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR)),'" + com_pk + "') ACCT_CODE,";     
        SQLD += "    d.ccy, d.TR_RATE, d.bk_rate, ";
        SQLD += "    decode(d.drcr_type,'D',r.tr_amt,0) dr_famt, ";
        SQLD += "    decode(d.drcr_type,'C',r.tr_amt,0) cr_famt, ";
        SQLD += "    decode(d.drcr_type,'D',r.tr_bookamt,0) dr_amt, ";
        SQLD += "    decode(d.drcr_type,'C',r.tr_bookamt,0) cr_amt, ";
        SQLD += "    h.remark, h.remark2, ";
		SQLD += "	 (SELECT a.item FROM tac_hgtrditem a, tac_abacctitem b WHERE a.del_if = 0 AND b.del_if = 0 AND a.tac_abacctitem_pk = b.pk AND TAC_ABITEM_ALIAS = 'INVOICE NO' AND a.tac_hgtrd_pk = d.pk)inv_no,";
		SQLD += "	 (SELECT TO_CHAR (TO_DATE (a.item, 'yyyymmdd'), 'dd/mm/yyyy') FROM tac_hgtrditem a, tac_abacctitem b WHERE a.del_if = 0 AND b.del_if = 0 AND a.tac_abacctitem_pk = b.pk AND TAC_ABITEM_ALIAS = 'INVOICE DATE' AND a.tac_hgtrd_pk = d.pk)inv_dt,";
		SQLD += "	 (SELECT a.item FROM tac_hgtrditem a, tac_abacctitem b WHERE a.del_if = 0 AND b.del_if = 0 AND a.tac_abacctitem_pk = b.pk AND TAC_ABITEM_ALIAS = 'SERIAL NO' AND a.tac_hgtrd_pk = d.pk)serial_no";
        SQLD += "  from tac_hgtrh h, tac_hgtrd d, tac_hgtrd_ref r ";
        SQLD += " where h.del_if = 0 and d.del_if = 0 and r.del_if = 0 ";
        SQLD += "   and h.TCO_COMPANY_PK = '" + com_pk + "' ";
        SQLD += "   and to_char(tr_date,'YYYYMMDD') between '" + date_from + "' and '" + date_to + "' ";
        SQLD += "   and d.tac_abacctcode_pk IN (SELECT     pk       FROM tac_abacctcode     WHERE del_if = 0 AND leaf_yn = 'Y'    CONNECT BY pac_pk = PRIOR pk          START WITH pk = '" + ac_pk + "')  ";
        SQLD += "   and d.TCO_BUSPARTNER_PK = '" + partner_pk + "'";
        SQLD += "   and d.tac_hgtrh_pk = h.pk ";
        SQLD += "   and r.tac_hgtrd_pk = d.pk ";
        SQLD += "   AND h.tr_status in ('" + status + "',DECODE('" + status + "',2,0,'" + status + "'),DECODE('" + status + "',2,4,'" + status + "'))  ";
        SQLD += "   and d.ccy like '%' || '" + ccy + "' || '%' ";
        SQLD += "   order by h.tr_date, h.voucherno "; 
        //Response.Write(SQLD);
		//Response.End();
        DataTable dtD = ESysLib.TableReadOpen(SQLD);
        dr_sum = 0;
        cr_sum = 0;
        
        for (int j = 0; j < dtD.Rows.Count; j++)
        {
            seq = dtD.Rows[j][0].ToString();
            tr_date = dtD.Rows[j][1].ToString().Substring(6, 2) + "/" + dtD.Rows[j][1].ToString().Substring(4, 2) + "/" + dtD.Rows[j][1].ToString().Substring(0, 4);
            voucherno = dtD.Rows[j][2].ToString();
            corr_acc = dtD.Rows[j][4].ToString();
            dr_amt = double.Parse(dtD.Rows[j][10].ToString());
            cr_amt = double.Parse(dtD.Rows[j][11].ToString());
            remark = dtD.Rows[j][12].ToString();
            remark2 = dtD.Rows[j][13].ToString();
            dr_sum += dr_amt;
            cr_sum += cr_amt;
            dr_end += dr_amt;
            cr_end += cr_amt;
            
  %>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'><%=tr_date%></td>
  <td class=xl29 style='border-left:none'><%=voucherno%></td>
  <td class=xl28 style='border-left:none'><%=tr_date%></td>
  <td class=xl56 width=292 style='border-left:none;width:219pt'><%=remark2%></td>
  <td class=xl56 width=292 style='border-left:none;width:219pt'><%=remark%></td>
  <td class=xl44 x:num><%=corr_acc%></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_amt%></td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=cr_amt%></td>
  <td class=xl45 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_end%></td>
  <td class=xl62 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' x:num  style="mso-number-format:'<%= p_xls_ccy %>';"><%=cr_end%></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=seq%></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=dtD.Rows[j][14].ToString()%></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=dtD.Rows[j][15].ToString()%></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=dtD.Rows[j][16].ToString()%></td>
 </tr>
 <%
        }
     if (drcr_type == "D")
     {
         dr_closing = dr_openning + dr_sum - cr_sum;
         cr_closing = 0;
     }
     else
     {
         dr_closing = 0;
         cr_closing = cr_openning - dr_sum + cr_sum;
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
  <td class=xl49 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_sum%></td>
  <td class=xl49 style='mso-spacerun:yes' x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=cr_sum%></td>
  <td class=xl49 x:num></td>
  <td class=xl49 style='mso-spacerun:yes' x:num></td>
  <td class=xl61 style='mso-spacerun:yes'>&nbsp;</td>
  <td class=xl61 style='mso-spacerun:yes'>&nbsp;</td>
  <td class=xl61 style='mso-spacerun:yes'>&nbsp;</td>
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
  <td class=xl54 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=dr_closing%></td>
  <td class=xl54 x:num  style="mso-number-format:'<%= p_xls_ccy %>';white-space:nowrap;mso-text-control:shrinktofit;"><%=cr_closing%></td>
  <td class=xl54 x:num></td>
  <td class=xl60 x:num><span style='mso-spacerun:yes'></span></td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
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
