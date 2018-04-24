<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
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
     SQLB += "     SF_GET_CUST_OPENBAL('" + com_pk + "','" + ac_pk + "',b.PK ,'" + date_from + "',  '','" + status + "','BOOKS') openning  ";
        SQLB += " from COMM.TCO_BUSPARTNER b  ";
        SQLB += " where b.del_if =0   ";
        if (cust_pk == "")
        {
            SQLB += " and  b.PK IN (" + cust_pk_list + ")   ";
        }
        else
        {
            SQLB += " and  b.PK =" + cust_pk + "   ";
        }
        //Response.Write(SQLB);
        //Response.End();
       
        DataTable dtB = ESysLib.TableReadOpen(SQLB);
    
        
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00050_soCTTT_S31-DN2_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00050_soCTTT_S31-DN2_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00050_soCTTT_S31-DN2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-11-09T01:59:48Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2009-11-09T09:29:58Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
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
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid #00CCFF;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid #00CCFF;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style16;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style16;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid #00CCFF;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
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
      <x:Scale>63</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>12</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
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
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$A$10:$K$10</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$9:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1468 style='border-collapse:
 collapse;table-layout:fixed;width:1102pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=292 span=2 style='mso-width-source:userset;mso-width-alt:
 10678;width:219pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=123 span=3 style='mso-width-source:userset;mso-width-alt:
 4498;width:92pt'>
 <col class=xl24 width=64 style='width:48pt'>
<% 
    //string sddk = "";
    //string sdck=
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
  <td colspan=4 height=19 class=xl60 width=552 style='height:14.25pt;
  width:415pt'><%=lname%></td>
  <td class=xl24 width=292 style='width:219pt'></td>
  <td class=xl25 width=63 style='width:47pt'></td>
  <td class=xl34 width=81 style='width:61pt'></td>
  <td colspan=4 class=xl30 width=433 style='width:324pt'><span
  style='mso-spacerun:yes'> </span>Mẫu số S31-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl61 width=552 style='height:14.25pt;
  width:415pt'><%=address%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=4 class=xl58
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl60 style='height:15.75pt'>Mã số thuế: <%=tax_code %></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=4 class=xl58>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=11 height=30 class=xl59 style='height:22.5pt'
  x:str="SỔ CHI TIẾT THANH TOÁN VỚI NGƯỜI MUA/  NGƯỜI BÁN ">SỔ CHI TIẾT THANH
  TOÁN VỚI NGƯỜI MUA/<span style='mso-spacerun:yes'>  </span>NGƯỜI BÁN<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl58 style='height:19.5pt'>Từ ngày <%=date_from%>
  Đến ngày <%=to_date %></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Số
  hiệu tài khoản:</td>
  <td class=xl30 x:num><%=ac_cd %></td>
  <td colspan=6 class=xl29><%=ac_nm%></td>
  <td class=xl29></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Đối
  tượng:</td>
  <td class=xl30><%=partner_id%></td>
  <td colspan=6 class=xl29><%=partner_nm%></td>
  <td class=xl29></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl31>Đơn vị tính:</td>
  <td class=xl32><%= p_book_ccy  %></td>
 </tr>
 <tr class=xl30 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td rowspan=2 height=63 class=xl43 width=74 style='height:47.25pt;width:56pt'>Ngày
  tháng ghi sổ</td>
  <td colspan=2 class=xl44 style='border-left:none'>Voucher</td>
  <td rowspan=2 class=xl44>Diễn giải</td>
  <td rowspan=2 class=xl44>Description</td>
  <td rowspan=2 class=xl43 width=63 style='width:47pt'>Số hiệu TK đối ứng</td>
  <td rowspan=2 class=xl43 width=81 style='width:61pt'>Thời hạn được chiết khấu</td>
  <td colspan=2 class=xl44 style='border-left:none'>Số phát sinh</td>
  <td rowspan=2 class=xl44>Số dư</td>
  <td class=xl44 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl30 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl44 id="_x0000_s1026" x:autofilter="all"
  style='height:25.5pt;border-top:none;border-left:none'>Số</td>
  <td class=xl43 id="_x0000_s1027" x:autofilter="all" width=86
  style='border-top:none;border-left:none;width:65pt'>Ngày tháng</td>
  <td class=xl44 id="_x0000_s1031" x:autofilter="all" style='border-top:none;
  border-left:none'>Nợ</td>
  <td class=xl44 id="_x0000_s1032" x:autofilter="all" style='border-top:none;
  border-left:none'>Có</td>
  <td class=xl44 id="_x0000_s1033" x:autofilter="all" style='border-top:none;
  border-left:none'>Seq</td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 width=74 style='height:15.75pt;border-top:none;
  width:56pt'>A</td>
  <td class=xl35 style='border-top:none;border-left:none'>B</td>
  <td class=xl36 width=86 style='border-top:none;border-left:none;width:65pt'>C</td>
  <td class=xl35 style='border-top:none;border-left:none'>D</td>
  <td class=xl35 style='border-top:none;border-left:none'>E</td>
  <td class=xl36 width=63 style='border-top:none;border-left:none;width:47pt'>F</td>
  <td class=xl36 width=81 style='border-top:none;border-left:none;width:61pt'>G</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl35 style='border-top:none;border-left:none'>H</td>
 </tr>
 
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 width=292 style='border-top:none;border-left:none;width:219pt'>SỐ DƯ ĐẦU KỲ</td>
  <td class=xl50 width=292 style='border-top:none;border-left:none;width:219pt'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'><span style='mso-spacerun:yes'></span></td>
  <td class=xl53 style='border-top:none;border-left:none'><span style='mso-spacerun:yes'></span><span style='mso-spacerun:yes'></span></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy %>';font-size:11.0pt" x:num><span style='mso-spacerun:yes'></span><%=dr_openning%></td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     
     string SQLD = "SELECT   h.pk, TO_CHAR (h.tr_date, 'YYYYMMDD'), h.voucherno, " +
     "         DECODE (d.drcr_type, 'D', ac.ac_cd, ad.ac_cd) ac, " +
     "         DECODE (d.drcr_type, 'D', ad.ac_cd, ac.ac_cd) corr_ac, " +
   
     "         sf_a_get_accd (DECODE (d.drcr_type, 'D', DECODE (r.drcr_type, 'C', r.tac_abacctcode_pk_dr,r.tac_abacctcode_pk_cr),  " +
        "                          DECODE (r.drcr_type, 'D', r.tac_abacctcode_pk_dr,r.tac_abacctcode_pk_cr ) ),'"+com_pk+"') acct_code,  " +

     "         d.ccy, d.tr_rate, d.bk_rate, " +
     "         DECODE (d.drcr_type, 'D', r.tr_amt, 0) dr_famt, " +
     "         DECODE (d.drcr_type, 'C', r.tr_amt, 0) cr_famt, " +
     "         DECODE (d.drcr_type, 'D', r.tr_bookamt, 0) dr_amt, " +
     "         DECODE (d.drcr_type, 'C', r.tr_bookamt, 0) cr_amt, h.remark, " +
     "         h.remark2, " +
     "         TO_CHAR " +
     "            ((  TO_NUMBER ('"+dr_openning+"', '9,999,999,999,999,999,990.99') " +
     "              + SUM (  DECODE (d.drcr_type, 'D', r.tr_bookamt, 0) " +
     "                     - DECODE (d.drcr_type, 'C', r.tr_bookamt, 0) " +
     "                    ) OVER (ORDER BY h.tr_date, " +
    
     "                                               h.voucherno, h.pk) " +
     "             ), " +
     "             sf_get_format ('ACBG0040') " +
     "            ) AS closingbalance " +
     "    FROM tac_hgtrh h, " +
     "         tac_hgtrd d, " +
     "         tac_hgtrd_ref r, " +
     "         tac_abacctcode ad, " +
     "         tac_abacctcode ac " +
     "   WHERE h.del_if = 0 " +
     "     AND d.del_if = 0 " +
     "     AND r.del_if = 0 " +
     "     AND ac.del_if = 0 " +
     "     AND ad.del_if = 0 " +
     "     AND h.tco_company_pk = " +com_pk+
     "     AND TO_CHAR (tr_date, 'YYYYMMDD') BETWEEN '" + date_from + "' AND '" + date_to + "' " +
     "     AND d.tac_abacctcode_pk IN (SELECT     pk " +
     "                                       FROM tac_abacctcode " +
     "                                      WHERE del_if = 0 AND leaf_yn = 'Y' " +
     "                                 CONNECT BY pac_pk = PRIOR pk " +
     "                                 START WITH pk = '"+ac_pk+"') " +
     "     AND d.tco_buspartner_pk = '" + partner_pk + "' " +
     "     AND d.tac_hgtrh_pk = h.pk " +
     "     AND r.tac_hgtrd_pk = d.pk " +
     "     AND r.tac_abacctcode_pk_dr = ad.pk " +
     "     AND r.tac_abacctcode_pk_cr = ac.pk " +
     "     AND h.tr_status in ('"+status+"',DECODE('"+status +"',2,0,'"+ status +"'),DECODE('"+ status +"',2,4,'"+ status +"'))" +

     "     AND d.ccy LIKE '%' || '"+ ccy +"' || '%' " +
     "ORDER BY h.tr_date, h.voucherno ";
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
            dr_amt = double.Parse(dtD.Rows[j][11].ToString());
            cr_amt = double.Parse(dtD.Rows[j][12].ToString());
            remark = dtD.Rows[j][12].ToString();
            remark2 = dtD.Rows[j][13].ToString();
            dr_sum += dr_amt;
            cr_sum += cr_amt;
            dr_end += dr_amt;
            cr_end += cr_amt;
            
  %>
<tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt;border-top:none'><%=tr_date%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=voucherno%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=tr_date%></td>
  <td class=xl40 width=292 style='border-top:none;border-left:none;width:219pt'><%=remark2%></td>
  <td class=xl40 width=292 style='border-top:none;border-left:none;width:219pt'><%=remark%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=corr_acc%></td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy %>';" x:num><span style='mso-spacerun:yes'></span><%=dr_amt%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy %>';" x:num><span style='mso-spacerun:yes'></span><%=cr_amt%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy %>';font-size:11.0pt" x:num><span style='mso-spacerun:yes'><%=dtD.Rows[j][15]%></span></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=seq%></td>
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
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:str><span style='mso-spacerun:yes'> </span>Tổng cộng số phát sinh<span style='mso-spacerun:yes'> </span></td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy %>';" x:num><span style='mso-spacerun:yes'></span><%=dr_sum%></td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy %>';" x:num><span style='mso-spacerun:yes'></span><%=cr_sum%></td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl55 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 width=292 style='border-top:none;border-left:none;width:219pt'>SỐ DƯ CUỐI KỲ</td>
  <td class=xl50 width=292 style='border-top:none;border-left:none;width:219pt'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'><span style='mso-spacerun:yes'></span></td>
  <td class=xl57 style='border-top:none;border-left:none'><span style='mso-spacerun:yes'></span></td>
 
  <td class=xl57 style="mso-number-format:'<%= p_xls_ccy %>';font-size:11.0pt" x:num><span style='mso-spacerun:yes'></span><%=dr_closing%></td>
  
   
   <td class=xl54 style='border-top:none;border-left:none'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=10 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl58>Ngày ........ tháng ........ năm ...........</td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl30><%= v1 %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30><%= v2 %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl30><%= v3 %></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td class=xl33><span style='mso-spacerun:yes'> </span><%= g1 %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl33><%= g3 %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl33><%= g3 %></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
  <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
  <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'><%= n1 %></td>
 </tr>
  <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'><%= n2 %></td>
 </tr>
  <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl28 style='height:15.75pt;mso-ignore:colspan'><%= n3 %></td>
 </tr>
 <%
     }
 }
 %>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
