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
    /*
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
*/
    string SQLAC = "SELECT pk,ac_cd_formular ac_cd, ac_nm, drcr_type  FROM tac_abacctcode ";
        SQLAC +=  " WHERE del_if = 0 and pk ='" + ac_pk + "'";
    
    DataTable dtAcc = ESysLib.TableReadOpen(SQLAC);
    if (dtAcc.Rows.Count > 0)
    {
        ac_cd = dtAcc.Rows[0][1].ToString();
        ac_nm = dtAcc.Rows[0][2].ToString();
        drcr_type = dtAcc.Rows[0][3].ToString();
    }

    
     string SQLB = "  select b.PK, PARTNER_ID,PARTNER_NAME";
        SQLB += " from TCO_BUSPARTNER b  ";
        SQLB += " where b.del_if =0 and b.pk = '"+cust_pk+"'  ";
        
        //Response.Write(SQLB);
        //Response.End();
       
        DataTable dtB = ESysLib.TableReadOpen(SQLB);
		if(dtB.Rows.Count>0)
		{
			 partner_id = dtB.Rows[0][1].ToString();
			 partner_nm = dtB.Rows[0][2].ToString();
		}
    string l_parameter="'" + com_pk + "','" + date_from + "','" + date_to + "','" + ac_pk + "','" + cust_pk + "','" + status + "','" + ccy +"'";    
	DataTable dtDetail = ESysLib.TableReadOpenCursor("ac_sel_60080070_cus_bal_v",l_parameter);
	if(dtDetail.Rows.Count==0)
	{
		Response.Write("There is no data");
		Response.End();
	}
	
	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00050_vouchers_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00050_vouchers_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00050_vouchers_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>vg-server</o:LastAuthor>
  <o:LastPrinted>2008-08-21T01:21:48Z</o:LastPrinted>
  <o:Created>2007-10-06T02:17:12Z</o:Created>
  <o:LastSaved>2012-08-08T03:12:55Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-weight:700;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl30
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
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl31
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl35
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl44
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
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl47
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
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl48
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
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl52
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
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl57
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl58
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
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl59
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
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>SL for Partner (Vouchers)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
	 <x:FitToPage/>
	 <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>55</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>5</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>30</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:TabRatio>371</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SL for Partner (Vouchers)'!$A$7:$O$7</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SL for Partner (Vouchers)'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1804 style='border-collapse:
 collapse;table-layout:fixed;width:1353pt'>
 <col class=xl28 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl27 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl28 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=185 style='mso-width-source:userset;mso-width-alt:6765;
 width:139pt'>
 <col class=xl27 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl27 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl27 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl28 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl27 width=103 span=5 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl27 width=188 style='mso-width-source:userset;mso-width-alt:6875;
 width:141pt'>
 <col class=xl27 width=169 style='mso-width-source:userset;mso-width-alt:6180;
 width:127pt'>
 <col class=xl27 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=4 width=262 style='height:15.0pt;mso-ignore:
  colspan;width:196pt'><%=lname%></td>
  <td class=xl27 width=185 style='width:139pt'></td>
  <td class=xl27 width=74 style='width:56pt'></td>
  <td class=xl27 width=180 style='width:135pt'></td>
  <td class=xl27 width=62 style='width:47pt'></td>
  <td class=xl28 width=42 style='width:32pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=103 style='width:77pt'></td>
  <td class=xl27 width=188 style='width:141pt'></td>
  <td class=xl27 width=169 style='width:127pt'></td>
  <td class=xl27 width=127 style='width:95pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 style='height:15.0pt;mso-ignore:colspan'>S/L
  for Partner</td>
  <td class=xl24></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>at</td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25 >Account code:</td>
  <td class=xl26 ><%=ac_cd%></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'><%=ac_nm%></td>
  <td class=xl24></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 style='height:15.0pt;mso-ignore:colspan'>From
  date <%=from_date%> ~ <%=to_date%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25 >Partner :</td>
  <td class=xl26><%=partner_id%></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'><%=partner_nm%></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl44 style='border-bottom:.5pt solid black;
  height:28.5pt'>Seq</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Voucher No</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Date</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Partner</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Account Code</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>User</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Ccy</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Closing</td>
  <td colspan=2 class=xl29 style='border-left:none'>Description</td>
  <td rowspan=2 class=xl29>Item Control</td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td height=19 class=xl31 id="_x0000_s1028" x:autofilter="all"
  style='height:14.25pt'>Code</td>
  <td class=xl31 id="_x0000_s1029" x:autofilter="all">Name</td>
  <td class=xl31 id="_x0000_s1030" x:autofilter="all">Code</td>
  <td class=xl31 id="_x0000_s1031" x:autofilter="all">Name</td>
  <td class=xl31 id="_x0000_s1034" x:autofilter="all">Trans</td>
  <td class=xl31 id="_x0000_s1035" x:autofilter="all">Books</td>
  <td class=xl31 id="_x0000_s1036" x:autofilter="all">Trans</td>
  <td class=xl31 id="_x0000_s1037" x:autofilter="all">Books</td>
  <td class=xl29 id="_x0000_s1039" x:autofilter="all" style='border-top:none;
  border-left:none'>Foreign</td>
  <td class=xl29 style='border-top:none;border-left:none'>Local</td>
 </tr>
 <%
	string p_Date="";
	for(int j = 1;j < dtDetail.Rows.Count;j++)
	{
		p_Date = dtDetail.Rows[j][2].ToString().Substring(6, 2) + "/" + dtDetail.Rows[j][2].ToString().Substring(4, 2) + "/" + dtDetail.Rows[j][2].ToString().Substring(0, 4);
 %>
 <tr class=xl26 height=60 style='height:45.0pt;mso-height-source:auto'>
  <td height=60 class=xl32 style='height:45.0pt;border-top:none' x:num><%=dtDetail.Rows[j][0]%></td>
  <td class=xl33 style='border-left:none'><%=dtDetail.Rows[j][1]%></td>
  <td class=xl34 style='border-left:none' ><%=p_Date%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][15]%></td>
  <td class=xl32 style='border-top:none;border-left:none;text-align:left'><%=dtDetail.Rows[j][16]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][6]%></td>
  <td class=xl32 style='border-top:none;border-left:none;text-align:left'><%=dtDetail.Rows[j][7]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][3]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][4]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][9]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][10]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][11]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][12]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][13]%></td>
  <td class=xl36 width=188 style='border-left:none;width:141pt'><%=dtDetail.Rows[j][17]%></td>
  <td class=xl36 width=169 style='border-left:none;width:127pt'><%=dtDetail.Rows[j][18]%></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][19]%></td>
 </tr>
 <%}%>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td rowspan=2 height=38 class=xl47 style='border-bottom:.5pt solid black;  height:28.5pt'>&nbsp;</td>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl51 style='border-right:.5pt solid black;  border-bottom:.5pt solid black'>Openning</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black'>Ccy</td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black'>Debit</td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:  none'>Credit</td>
  <td rowspan=2 class=xl60 style='border-bottom:.5pt solid black'  x:str="Closing"><span style='mso-spacerun:yes'> </span>Closing</td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl30>&nbsp;</td>
 </tr>
 <tr class=xl26 height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt'>Trans</td>
  <td class=xl31>Books</td>
  <td class=xl31>Trans</td>
  <td class=xl31>Books</td>
 </tr>
 <%
	
	DataTable dtSum = ESysLib.TableReadOpenCursor("ac_sel_60080070_cus_bal_sum",l_parameter);
	if(dtSum.Rows.Count>0)
	{
		for(int h = 1;h < dtSum.Rows.Count;h++)
		{
 %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 class=xl55 style='border-right:.5pt solid black;  height:15.0pt'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none' ><%=dtSum.Rows[h][0]%></td>
  <td class=xl39 style='border-top:none;border-left:none' ><%=dtSum.Rows[h][3]%></td>
  <td class=xl40 x:num><%=dtSum.Rows[h][5]%></td>
  <td class=xl40 x:num><%=dtSum.Rows[h][4]%></td>
  <td class=xl40 x:num><%=dtSum.Rows[h][6]%></td>
  <td class=xl41 style='border-left:none' x:num><%=dtSum.Rows[h][12]%></td>
  <td class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%}}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=48 style='width:36pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=169 style='width:127pt'></td>
  <td width=127 style='width:95pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>