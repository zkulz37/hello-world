<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string l_tac_subcontract_pk = Request["p_tac_subcontract_pk"];
    string l_company = Request["p_company"];
    string l_tr_date = Request["p_tr_date"];
    string l_contract_ccy =  Request["l_contract_ccy"];
    string l_contract_no = Request["contract_no"];


    string l_parameter = "";
       // l_parameter = "'" + l_tac_subcontract_pk + "', ";
  //  l_parameter += "'" + l_company + "', ";
     l_parameter += "'" + l_tr_date + "', ";
     l_parameter += "'" + l_contract_ccy + "', ";
     l_parameter += "'" + l_contract_no + "' ";

     //Response.Write(l_parameter);
     //Response.End();
//----------------------------------------------------------------------------------------------------------------   
    string ls_datefrom = "";
    string ls_dateto = "";
	string  l_dec_contrat="";
	string l_dec_acc="";
	string l_period_fr ="";
	string l_period_to ="";
	string l_guarantee ="";
    decimal AP_Famt = 0;
    decimal adv_amt_opening =0;
    decimal coll_famt = 0;
    decimal deduct_famt = 0;
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_gfqc00060_2_report", l_tac_subcontract_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }
    ls_datefrom = dt.Rows[0][6].ToString().Trim();
    if (ls_datefrom.Length == 8)
    {
        ls_datefrom = ls_datefrom.Substring(6, 2) + "/" + ls_datefrom.Substring(4, 2) + "/" + ls_datefrom.Substring(0, 4);
    }
    else
    {
        ls_datefrom = "";
    }
    ls_dateto = dt.Rows[0][7].ToString().Trim();
    if (ls_dateto.Length == 8)
    {
        ls_dateto = ls_dateto.Substring(6, 2) + "/" + ls_dateto.Substring(4, 2) + "/" + ls_dateto.Substring(0, 4);
    }
    else
    {
        ls_dateto = ""; 
    }
    
     AP_Famt =dt.Rows[0][49].ToString()==""? 0: decimal.Parse(dt.Rows[0][49].ToString());

  
    if (!dt.Rows[0]["adv_famt"].ToString().Equals(""))
    {
        adv_amt_opening = decimal.Parse(dt.Rows[0]["adv_famt"].ToString());
    }
    if (!dt.Rows[0]["coll_famt"].ToString().Equals(""))
    {
        coll_famt = decimal.Parse(dt.Rows[0]["coll_famt"].ToString());
    }
    if (!dt.Rows[0]["deduct_famt"].ToString().Equals(""))
    {
        deduct_famt = decimal.Parse(dt.Rows[0]["deduct_famt"].ToString());
    }
     if (!dt.Rows[0]["DESCRIPTION_CONTRACT"].ToString().Equals(""))
    {
        l_dec_contrat = dt.Rows[0]["DESCRIPTION_CONTRACT"].ToString();
    }

    if (!dt.Rows[0]["description"].ToString().Equals(""))
    {
        l_dec_acc = dt.Rows[0]["description"].ToString();
    }
    
	if (!dt.Rows[0]["valid_from"].ToString().Equals(""))
    {
        l_period_fr = dt.Rows[0]["valid_from"].ToString();
    }

	if (!dt.Rows[0]["valid_to"].ToString().Equals(""))
    {
        l_period_to =dt.Rows[0]["valid_to"].ToString();
    }
	if (!dt.Rows[0]["GUARANTEE_C"].ToString().Equals(""))
    {
        l_guarantee =dt.Rows[0]["GUARANTEE_C"].ToString();
    }
	
//------------------------------------------------------------------------------------------------------------------
    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";
    
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);

    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }

//------------------------------------------------------------------------------------------------------------------------------   
    
    DataTable dt2 = ESysLib.TableReadOpenCursor("ac_sel_gfqc00060_1_report", l_tac_subcontract_pk);
    
    if (dt2.Rows.Count > 0)
    {
       
    }
//---------------------------------------------------------------------------------------------------------------------------
    //decimal l_Remain = 0;
    
     
//-------------------------------------------------------------------------------------------------------------------------
    string l_book_ccy = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_contract_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

   
%>


	

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfqc00060_1_files/filelist.xml">
<link rel=Edit-Time-Data href="gfqc00060_1_files/editdata.mso">
<link rel=OLE-Object-Data href="gfqc00060_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2010-06-15T07:42:07Z</o:LastPrinted>
  <o:Created>2007-09-13T09:21:45Z</o:Created>
  <o:LastSaved>2010-06-15T07:47:20Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in 0in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5460</x:WindowHeight>
  <x:WindowWidth>14970</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=865 style='border-collapse:
 collapse;table-layout:fixed;width:653pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 width=13 style='height:11.25pt;width:10pt'></td>
  <td class=xl25 width=26 style='width:20pt'></td>
  <td colspan=10 class=xl27 width=820 style='width:618pt'><%=l_compa%></td>
  <td class=xl24 width=6 style='width:5pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td class=xl28></td>
  <td colspan=10 class=xl27><%=l_address%></td>
  <td class=xl24></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td class=xl28></td>
  <td colspan=10 class=xl27>Tax code:<%=l_taxcode%></td>
  <td class=xl24></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl24 style='height:4.5pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl32></td>
  <td class=xl33></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td class=xl25></td>
  <td colspan=10 class=xl68>PROGRESS PAYMENT</td>
  <td class=xl35></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl34 style='height:9.0pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <%
    // decimal Final = 0;
     decimal Contract_amt = 0;
	 decimal Final_ct_amt =0 ;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         //Final = decimal.Parse(dt.Rows[i][18].ToString());
         Contract_amt = decimal.Parse(dt.Rows[i][16].ToString());
		 Final_ct_amt = decimal.Parse(dt.Rows[i][18].ToString());
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Contract No :</td>
  <td colspan=8 class=xl69><%=dt.Rows[i][5]%></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Sub contract Name :</td>
  <td colspan=2 class=xl25><%=dt.Rows[i][47]%></td>
  <td colspan=6 class=xl28><%=dt.Rows[i][48]%></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Project Name :</td>
  <td colspan=2 class=xl25><%=dt.Rows[i][45]%></td>
  <td colspan=6 class=xl28><%=dt.Rows[i][46]%></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Quantity :</td>
  <td colspan=2 class=xl70 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][20]%></td>
  <td class=xl37>Quantity Adj:</td>
  <td class=xl38></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Unit price:</td>
  <td colspan=2 class=xl70 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][19]%></td>
  <td class=xl37>Unit price:</td>
  <td class=xl38></td>
  <td class=xl37>Total price:</td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>VAT :</td>
  <td colspan=2 class=xl70 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][35]%></td>
  <td class=xl37>VAT Adj:</td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][36]%></td>
  <td class=xl37>Total VAT:</td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][34]%></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Contract Amount :</td>
  <td colspan=2 class=xl70 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Contract_amt%></td>
  <td class=xl37>Adjust amount:</td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][17]%></td>
  <td class=xl37>Final:</td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][18]%></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Period of contract :</td>
  <td colspan=3 class=xl70> <%=l_period_fr %> ~ <%=l_period_to %> </td>
  
  <td class=xl38></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
  <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37>Period of guarantee :</td>
  <td colspan=3 class=xl70> <%=l_guarantee %> Month(s)</td>
  
  <td class=xl38></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <%
     for(int j = 0;j<dt2.Rows.Count;j++)
     {
      %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt2.Rows[j][9]%></td>
  <td colspan=2 class=xl70 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt2.Rows[j][2]%></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt2.Rows[j][3]%></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt2.Rows[j][4]%></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <%
 }
  %><%} %>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl34 style='height:14.1pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37></td>
  <td colspan=2 class=xl25></td>
  <td class=xl40></td>
  <td class=xl38></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl34 style='height:6.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl38></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl34 style='height:9.0pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>I. ADVANCE STATUS</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27>Openning Amt:</td>
  <td colspan=2 class=xl55  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=adv_amt_opening %></td>
  <td colspan=1 class=xl55  x:num></td>
  <td colspan=2 class=xl55  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=deduct_famt %></td>
  <td class=xl35></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl34 style='height:20.1pt'></td>
  <td class=xl41>No</td>
  <td class=xl42>Date</td>
  <td class=xl41>SEQ</td>
  <td colspan=4 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl43>Advance Amt</td>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Deduct Amt</td>
  <td class=xl35></td>
 </tr>
 <%
         
     int z = 0;
     decimal Advance = 0;
     string ls_dateI = "";
     decimal Deduct = 0;
   decimal Remain = 0;
         
  
    
     DataTable dt3 = ESysLib.TableReadOpenCursor("ac_sel_gfqc00090_adv", l_parameter);
    
       
            for(int k=0;k<dt3.Rows.Count;k++)
            {
                if (dt3.Rows[k][3].ToString().Trim() != "")
                {
                    Advance += decimal.Parse(dt3.Rows[k][3].ToString());
                }
               
                
                if (dt3.Rows[k][4].ToString().Trim() != "")
                {
                    Deduct += decimal.Parse(dt3.Rows[k][4].ToString());
                }
              
                ls_dateI = dt3.Rows[k][1].ToString().Trim();
                ls_dateI = ls_dateI.Substring(6, 2) + "/" + ls_dateI.Substring(4, 2) + "/" + ls_dateI.Substring(0, 4);
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td class=xl44 ><%=z+1%></td>
  <td class=xl45><%=ls_dateI%></td>
  <td class=xl46><%=dt3.Rows[k][0]%></td>
  <td colspan=4 class=xl74 width=327 style='border-right:.5pt solid black;
  border-left:none;width:246pt' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt3.Rows[k][2]%></td>
  <td class=xl48 x:num><%=dt3.Rows[k][3]%></td>
  <td colspan=3 class=xl77 sstyle="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt3.Rows[k][4]%></td>
  <td class=xl35></td>
 </tr>
 <%
     z += 1;
            } %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl49></td>
  <td class=xl50></td>
  <td class=xl51></td>
  <td colspan=4 class=xl79 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl52></td>
  <td colspan=3 class=xl82 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl35></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>Total Advance</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Advance%></td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Deduct%></td>
  <td class=xl35></td>
 </tr>
 <% Remain = adv_amt_opening + Advance - Deduct - deduct_famt; %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>Remain</td>
  <td class=xl54></td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:
  none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Remain%></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl37></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl38></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl34 style='height:12.0pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>II. PROGRESS PAYMENT</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Openning A/P Amt:</td>
  <td class=xl55 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=AP_Famt%></td>
  <td colspan=3 class=xl55 >Openning payment Amt:<%=dt.Rows[0]["coll_famt"].ToString() == "" ? "-" : decimal.Parse(dt.Rows[0]["coll_famt"].ToString()).ToString("#,###.00")%></td>
  <td class=xl35></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'></td>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black'>VOUCHER</td>
  <td colspan=4 rowspan=2 class=xl87 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl93 style='border-bottom:.5pt solid black;border-top:
  none'>A/P Amt</td>
  <td colspan=4 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:str="PAYMENT"><span style='mso-spacerun:yes'> </span>PAYMENT<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'></td>
  <td class=xl56>No</td>
  <td class=xl57>Date</td>
  <td class=xl57>SEQ</td>
  <td class=xl57>Date</td>
  <td class=xl57>SEQ</td>
  <td class=xl57>Amount</td>
  <td class=xl58></td>
 </tr>
 <%
         
     int m = 0;
     decimal AP_Amt = 0;
     string ls_dateII = "";
     decimal Amount = 0;
	 decimal PayAmt_II = 0;
      decimal remain_payment = 0;
  
     DataTable dt4 = ESysLib.TableReadOpenCursor("ac_sel_gfqc00090_II", l_parameter);
       
            for(int y=0;y<dt4.Rows.Count;y++)
            {
                if (dt4.Rows[y][3].ToString().Trim() != "")
                {
                    AP_Amt += decimal.Parse(dt4.Rows[y][3].ToString());
                }
                
                
                if (dt4.Rows[y][4].ToString().Trim() != "")
                {
                    Amount += decimal.Parse(dt4.Rows[y][4].ToString());
					PayAmt_II  += decimal.Parse(dt4.Rows[y][4].ToString());
                }
              
                //ls_dateII = dt4.Rows[y][1].ToString().Trim();
               // ls_dateII = ls_dateII.Substring(6, 2) + "/" + ls_dateII.Substring(4, 2) + "/" + ls_dateII.Substring(0, 4);
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td class=xl44 x:num><%=m+1%></td>
  <td class=xl45><%=dt4.Rows[y][1]%></td>
  <td class=xl46><%=dt4.Rows[y][0]%></td>
  <td colspan=4 class=xl99 width=327 style='border-right:.5pt solid black;border-left:none;width:246pt' ><%=dt4.Rows[y][2]%></td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt4.Rows[y][3]%></td>
  <td class=xl45 ><%=dt4.Rows[y][5]%></td>
  <td class=xl46 ><%=dt4.Rows[y][6]%></td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt4.Rows[y][4]%></td>
  <td class=xl59></td>
 </tr>
 <% m+=1; } %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl49></td>
  <td class=xl50></td>
  <td class=xl51></td>
  <td colspan=4 class=xl79 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl52></td>
  <td class=xl52></td>
  <td class=xl52></td>
  <td class=xl52></td>
  <td class=xl35></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>SubTotal </td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=AP_Amt%></td>
  <td class=xl54></td>
  <td class=xl54></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=PayAmt_II%></td>
  <td class=xl35></td>
 </tr>
 <%
    // Total = Openning + subtotal
     decimal Total_II_AP = 0;
     decimal Total_II_pay = 0;
     
     Total_II_AP =  AP_Famt + AP_Amt;
     Total_II_pay = coll_famt + Amount;
     
     
 %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>Total </td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Total_II_AP%></td>
  <td class=xl54></td>
  <td class=xl54></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Total_II_pay%></td>
  <td class=xl35></td>
 </tr>
<!--
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl66 style='border-right:.5pt solid black'>Total</td>
  <td class=xl51>111111111111111111111&nbsp;</td>
  <td class=xl51></td>
  <td class=xl51></td>
  <td class=xl35></td>
  <td class=xl24></td>
 </tr>
 --><% remain_payment = Final_ct_amt - Total_II_AP; %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>Remain</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=remain_payment%></td>
  <td class=xl54></td>
  <td class=xl54></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Total_II_AP - Total_II_pay %></td>
  <td class=xl35></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl34 style='height:9.0pt'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl34 style='height:9.0pt'></td>
  <td class=xl27 colspan=5 style='mso-ignore:colspan'>III. WITHHOLDING BUSINESS
  INCOME TAXES</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl34 style='height:20.1pt'></td>
  <td class=xl41>No</td>
  <td class=xl42>Date</td>
  <td class=xl41>SEQ</td>
  <td colspan=4 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl43>A/P Amt</td>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Payment Amt</td>
  <td class=xl35></td>
 </tr>
 <%
     int u = 0;
     decimal AP_AmtIII = 0;
     decimal Payment_AmtIII = 0;
     string ls_dateIII = "";
 DataTable dt5 = ESysLib.TableReadOpenCursor("ac_sel_gfqc00090_III", l_parameter);

 for (int x = 0; x < dt5.Rows.Count; x++)
 {
     if (dt5.Rows[x][3].ToString().Trim() != "")
     {
         AP_AmtIII += decimal.Parse(dt5.Rows[x][3].ToString());
     }
   

     if (dt5.Rows[x][4].ToString().Trim() != "")
     {
         Payment_AmtIII += decimal.Parse(dt5.Rows[x][4].ToString());
     }
    
     //ls_dateIII = dt5.Rows[x][1].ToString().Trim();
     //ls_dateIII = ls_dateIII.Substring(6, 2) + "/" + ls_dateIII.Substring(4, 2) + "/" + ls_dateIII.Substring(0, 4);
 
        
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td class=xl44><%=u + 1%></td>
  <td class=xl45><%=ls_dateIII%></td>
  <td class=xl46><%=dt5.Rows[x][0]%></td>
  <td colspan=4 class=xl102 width=327 style='border-right:.5pt solid black;border-left:none;width:246pt'><%=dt5.Rows[x][2]%></td>
  <td class=xl48 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt5.Rows[x][3]%></td>
  <td colspan=3 class=xl105 style='border-right:.5pt solid black;border-left: none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt5.Rows[x][4]%></td>
  <td class=xl35></td>
 </tr>
 <%u += 1;
} %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl34 style='height:17.1pt'></td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>Total</td>
  <td class=xl60 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=AP_AmtIII%></td>
  <td colspan=3 class=xl108 style='border-right:.5pt solid black;border-left:
  none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Payment_AmtIII%></td>
  <td class=xl35></td>
 </tr>
 <% decimal Total_payment = 0;
     Total_payment = Total_II_pay + Payment_AmtIII  ;
      %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl34 style='height:16.5pt'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>IV. TOTAL PAYMENT</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl61 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=Total_payment%></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <%  decimal remainV = 0;
     remainV = Final_ct_amt - Payment_AmtIII - Total_II_AP;
      %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl34 style='height:16.5pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>V. REMAIN</td>
  <td class=xl27></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl61 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=remainV%></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl35></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl71 style='border-right:.5pt solid black'>ACCOUNTING
  TEAM</td>
  <td class=xl36></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl34 style='height:15.95pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl56>Date</td>
  <td class=xl57>Checked by</td>
  <td class=xl57>Approved by</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td class=xl36></td>
  <td class=xl24></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td colspan=2 rowspan=3 class=xl113 width=179 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:135pt'><%=l_dec_acc %></td>
  <td class=xl47></td>
  <td class=xl24></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl47></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl47></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl34 style='height:24.95pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl71 style='border-right:.5pt solid black'>CONTRACT TEAM</td>
  <td class=xl36></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl34 style='height:15.95pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl56>Date</td>
  <td class=xl57>Checked by</td>
  <td class=xl57>Approved by</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td class=xl36></td>
  <td class=xl24></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td rowspan=3 class=xl111 style='border-bottom:.5pt solid black;border-top:
  none'></td>
  <td colspan=2 rowspan=3 class=xl113 width=179 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:135pt'><%=l_dec_contrat %></td>
  <td class=xl47></td>
  <td class=xl24></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl47></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl47></td>
  <td class=xl25></td>
  <td class=xl35></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl64 style='height:9.75pt'></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl67></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=6 style='width:5pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
