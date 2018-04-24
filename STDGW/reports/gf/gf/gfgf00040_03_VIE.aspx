<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_comp = "" + Request["company_pk"];    
    string p_kind = ""+Request["KindCode"];
	string p_dept = ""+Request["DeptPK"];
	string p_status = ""+Request["Status"];
	string p_fa_acc = ""+ Request["AssetAccCode"];
	string p_depr_acc = ""+ Request["AssetDepr"]	;
	string p_expe_acc = ""+ Request["ExpAcc"];
    string p_from = "" + Request["dtFrom"];
    string p_to = "" + Request["dtTo"];
    string p_asset_type = "" + Request["Asset_Type"];
    string from_month = p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
    string to_month = p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
    string comp_name = "";
    string comp_lname = "";
    string address = "";
    string tax_code = "";
    string kind_code ="";
    string kind_code_dept = "";
    int j = 0, k=0;
    int stt = 0;
    string depr_date = "";
    string tmp_date = "";
    int month_depr = 0;
    int tmp_yy = 0;
    int tmp_mm = 0;
    int col1=0;
    int col2=0;
    int col3=0;
    int col4=0;
    int col5=0;
    int col6=0;
    int col7=0;
    int col8=0;
    int col9=0;
    int col10=0;
    int col11=0;
    int col12=0;
    string style_01 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_02 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_03 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_04 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_05 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_06 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_07 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_08 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_09 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_10 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_11 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string style_12 = "display:none;mso-width-source:userset;mso-width-alt:3693";
    string year= p_to.Substring(0,4) ;
    string month= p_to.Substring(4,2);
    switch(month)
    {
        case "01":
             col1=100;
             style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col2=0;
             col3=0;
             col4=0;
             col5=0;
             col6=0;
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "02":
             col1=100;
             style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col2=100;
             style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col3=0;
             col4=0;
             col5=0;
             col6=0;
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "03":
             col1=100;
             style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";   
             col2=100;
             style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col3=100;
             style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col4=0;
             col5=0;
             col6=0;
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "04":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4=100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col5=0;
             col6=0;
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "05":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5=100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col6=0;
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "06":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6=100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col7=0;
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "07":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7=100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col8=0;
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "08":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7 = 100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col8=100;
            style_08 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col9=0;
             col10=0;
             col11=0;
             col12=0;
        break;
        case "09":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7 = 100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col8 = 100;
            style_08 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col9=100;
            style_09 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col10=0;
             col11=0;
             col12=0;
        break;
        case "10":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7 = 100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col8 = 100;
            style_08 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col9 = 100;
            style_09 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col10=100;
            style_10 = "display:;mso-width-source:userset;mso-width-alt:3693";
             col11=0;
             col12=0;
        break;
        case "11":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7 = 100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col8 = 100;
            style_08 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col9 = 100;
            style_09 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col10 = 100;
            style_10 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col11=100;
            style_11 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col12=0;
        break;
        case "12":
            col1 = 100;
            style_01 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col2 = 100;
            style_02 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col3 = 100;
            style_03 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col4 = 100;
            style_04 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col5 = 100;
            style_05 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col6 = 100;
            style_06 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col7 = 100;
            style_07 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col8 = 100;
            style_08 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col9 = 100;
            style_09 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col10 = 100;
            style_10 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col11 = 100;
            style_11 = "display:;mso-width-source:userset;mso-width-alt:3693";
            col12=100;
            style_12 = "display:;mso-width-source:userset;mso-width-alt:3693";
        break;
    }
    
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int    i;
    string l_Scale1 = "";
    if (Request["p_Scale"] != "1")
    {
        l_Scale1 = Request["p_Scale"];
    }     
    string l_ccy = Request["p_ccy"];

    string p_xls_ccy_format = "";

   
   ///---Get company information-------------------------------------------------------------------------------
        
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_comp + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }
    //---Get booking ccy for format----------------------------------------------------------------------------
    string sql2= "SELECT SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";

    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        l_ccy = dt_bccy.Rows[0][0].ToString();
    }
    if (l_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    //----End booking ccy format-------------------------------------------------------------------------------
    //---------------------------------------------------------------------------------------------------------
    string l_parameter = "'" + p_from + "','" + p_to + "','" + p_comp + "','" +  p_kind  + "','" + p_dept + "','" + p_status +"','" +p_asset_type+ "'";
    
    DataTable dt_grp_kind = ESysLib.TableReadOpenCursor("sp_sel_gfgf00040_02_2", l_parameter);
    DataTable dt_sum_location = ESysLib.TableReadOpenCursor("sp_sel_gfgf00040_02_3", l_parameter);
    DataTable dt_grd_total = ESysLib.TableReadOpenCursor("sp_sel_gfgf00040_02_4", l_parameter);
    DataTable dt_detail = ESysLib.TableReadOpenCursor("sp_sel_gfgf00040_02_1",l_parameter);
    DataTable dt_depr_yn = ESysLib.TableReadOpenCursor("sp_sel_gfgf00040_02_5", l_parameter);
  
    if (dt_detail.Rows.Count==0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    int ti = 0; 
    int ti_s = 0; 

    //Response.Write(ti);
    //Response.End();
    
   //----------------------------------------------------------------------------------------------------------- 
    
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfgf00040_03_files/filelist.xml">
<link rel=Edit-Time-Data href="gfgf00040_03_files/editdata.mso">
<link rel=OLE-Object-Data href="gfgf00040_03_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2009-07-21T02:14:01Z</o:LastPrinted>
  <o:Created>2008-11-06T07:21:07Z</o:Created>
  <o:LastSaved>2009-07-21T02:21:29Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .19in .75in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
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
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-family:Arial, sans-serif;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}	
.xl66
	{mso-style-parent:style0;
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}	
.xl69
	{mso-style-parent:style0;
	text-align:left;}
.xl70
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Amended Depreciation List</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>32</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>13</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3148 style='border-collapse:
 collapse;table-layout:fixed;width:2366pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=100 span=3 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=<%=col1 %> style='<%=style_01 %>'>
 <col width=<%=col2 %> style='<%=style_02 %>'>
 <col width=<%=col3 %> style='<%=style_03 %>'>
 <col width=<%=col4 %> style='<%=style_04 %>'>
 <col width=<%=col5 %> style='<%=style_05 %>'>
 <col width=<%=col6 %> style='<%=style_06 %>'>
 <col width=<%=col7 %> style='<%=style_07 %>'>
 <col width=<%=col8 %> style='<%=style_08 %>'>
 <col width=<%=col9 %> style='<%=style_09 %>'>
 <col width=<%=col10 %> style='<%=style_10 %>'>
 <col width=<%=col11 %> style='<%=style_11 %>'>
 <col width=<%=col12 %> style='<%=style_12 %>'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 width=32 style='height:10.5pt;width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=<%=col1 %> style='width:<%=col1 %>pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl68 style='height:14.25pt'><%=l_cmp_name %></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl69 style='height:12.75pt'><%=l_cmp_add %></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=21 height=27 class=xl70 style='height:20.25pt'>LIST OF FIXED
  ASSETS DEPRECIATION</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=21 height=17 class=xl24 style='height:12.75pt'>From :<%=from_month %>  To :<%=to_month %></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=21 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=35 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=2 height=68 class=xl53 width=32 style='border-bottom:.5pt solid black;
  height:51.0pt;width:24pt'>No</td>
  <td rowspan=2 class=xl53 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Asset code</td>
  <td rowspan=2 class=xl53 width=154 style='border-bottom:.5pt solid black;
  width:116pt'>Asset Name</td>
  <td rowspan=2 class=xl53 width=42 style='border-bottom:.5pt solid black;
  width:32pt'>Qty</td>
  <td rowspan=2 class=xl53 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Place</td>
  <td rowspan=2 class=xl53 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Location</td>
  <td rowspan=2 class=xl53 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Service date</td>
  <td rowspan=2 class=xl53 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Date of depreciation</td>
  <td rowspan=2 class=xl53 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>Estimate life(month)</td>
  <td colspan=3 class=xl60 width=301 style='border-right:.5pt solid black;
  border-left:none;width:226pt'>At the beginning(<%=from_month %>)</td>
  <td colspan=2 class=xl63 width=199 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>Acquisition</td>
  <td colspan=2 class=xl63 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>Disposal</td>
  <td rowspan=2 class=xl53 width=<%=col1 %> style='border-bottom:.5pt solid black'>Depr. In <br />(01/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col2 %> style='border-bottom:.5pt solid black'>Depr. In <br />(02/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col3 %> style='border-bottom:.5pt solid black'>Depr. In <br />(03/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col4 %> style='border-bottom:.5pt solid black'>Depr. In <br />(04/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col5 %> style='border-bottom:.5pt solid black'>Depr. In <br />(05/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col6 %> style='border-bottom:.5pt solid black'>Depr. In <br />(06/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col7 %> style='border-bottom:.5pt solid black'>Depr. In <br />(07/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col8 %> style='border-bottom:.5pt solid black'>Depr. In <br />(08/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col9 %> style='border-bottom:.5pt solid black'>Depr. In <br />(09/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col10 %> style='border-bottom:.5pt solid black'>Depr. In <br />(10/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col11 %> style='border-bottom:.5pt solid black'>Depr. In <br />(11/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=<%=col12 %> style='border-bottom:.5pt solid black'>Depr. In <br />(12/<%=year %>)</td>
  <td rowspan=2 class=xl53 width=89 style='border-bottom:.5pt solid black'>Depr. In period</td>
  <td colspan=3 class=xl60 width=287 style='border-right:.5pt solid black;
  border-left:none;width:216pt'>At the Ending</td>
  <td rowspan=2 class=xl53 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Depr. Acc</td>
  <td rowspan=2 class=xl53 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Depr. Per Month</td>
  <td rowspan=2 class=xl53 width=79 style='border-bottom:.5pt solid black;
  width:59pt'>Expe. Acc</td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl26 width=105 style='height:30.0pt;border-top:none;
  width:79pt'>Original Cost</td>
  <td class=xl26 width=91 style='border-top:none;width:68pt'>Accumulation</td>
  <td class=xl26 width=105 style='border-top:none;width:79pt'>Remain</td>
  <td class=xl26 width=91 style='border-top:none;width:68pt'>New purchase</td>
  <td class=xl26 width=108 style='border-top:none;width:81pt'>Substitution From
  <br>
    Other Accounts</td>
  <td class=xl26 width=80 style='border-top:none;width:60pt'>Decrease of <br>
    Original Cost</td>
  <td class=xl26 width=85 style='border-top:none;width:64pt'>Decrease of<br>
    Accumulation</td>
  <td class=xl26 width=102 style='border-top:none;width:77pt'>Original Cost</td>
  <td class=xl26 width=90 style='border-top:none;width:68pt'>Accumulation</td>
  <td class=xl26 width=95 style='border-top:none;width:71pt'>Remain</td>
 </tr>
  <%
     string depr_yn="";
     if (dt_depr_yn.Rows.Count > 0)
     {
         for (int di = 0; di < dt_depr_yn.Rows.Count; di++)
         {
             depr_yn = dt_depr_yn.Rows[di]["depr_yn"].ToString();
 %>
 
 <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black;
  height:12.75pt'><%=dt_depr_yn.Rows[di]["depr_yn"].ToString()%></td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl64 >&nbsp;</td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["origin_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["remain_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["new_pur_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["sub_acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["dis_dec_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["dis_dec_acc_amt"].ToString()%></td>
  
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_01"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_02"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_03"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_04"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_05"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_06"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_07"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_08"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_09"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_10"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_11"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["amt_12"].ToString()%></td>
  
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["depr_peirod"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_org_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_acc_amt"].ToString()%></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["end_remain"].ToString()%></td>
  <td class=xl64></td>
  <td class=xl65 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_depr_yn.Rows[di]["depr_month_amt"].ToString()%></td>
  
  <td class=xl64 >&nbsp;</td>
 </tr>
             
<%           if (dt_grp_kind.Rows.Count > 0)
             {
                 for (int ki = 0; ki < dt_grp_kind.Rows.Count; ki++)
                 {
                     kind_code = dt_grp_kind.Rows[ki]["fa_kind_cd"].ToString();
                     if (dt_grp_kind.Rows[ki]["depr_yn"].ToString() == depr_yn)
                      {
 %>
  <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><%=dt_grp_kind.Rows[ki]["fa_kind_NM"].ToString()%></td>
  <!--td class=xl29 style='border-top:none'>&nbsp;</td-->
  <td class=xl29 >&nbsp;</td>
  <td class=xl29 >&nbsp;</td>
  <td class=xl29 >&nbsp;</td>
  <td class=xl29 >&nbsp;</td>
  <td class=xl29 >&nbsp;</td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["origin_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["remain_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["new_pur_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["sub_acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["dis_dec_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["dis_dec_acc_amt"].ToString()%></td>
  
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_01"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_02"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_03"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_04"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_05"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_06"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_07"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_08"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_09"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_10"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_11"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["amt_12"].ToString()%></td>
  
  
  
  
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["depr_peirod"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_org_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_acc_amt"].ToString()%></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["end_remain"].ToString()%></td>
  <td class=xl29></td>
  <td class=xl30 style="mso-number-format:'<%= p_xls_ccy_format %>';border-left:none" x:num><%= dt_grp_kind.Rows[ki]["depr_month_amt"].ToString()%></td>
  
  <td class=xl29 >&nbsp;</td>
 </tr>
 <%
    
     if (dt_detail.Rows.Count > 0)
     {
         stt = 0;
         for (i = 0; i < dt_detail.Rows.Count; i++)
         {

             if (dt_detail.Rows[i]["fa_kind_cd"].ToString() == kind_code && dt_detail.Rows[i]["depr_yn"].ToString() == depr_yn)
             {
                 stt++;
 %>            
 <tr class=xl31 height=16 style='height:12.0pt'>
  <td height=16 class=xl32 align=right style='height:12.0pt' x:num><%=stt%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_cd"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_nm"].ToString()%></td>
  <td class=xl33 align=right x:num><%=dt_detail.Rows[i]["fa_qty"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["place"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["LOCATION"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_use_date"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["fa_depr_date"].ToString()%></td>
  <td class=xl33 align=right x:num><%=dt_detail.Rows[i]["months"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["origin_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["remain_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["new_pur_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["sub_acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["dis_dec_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["dis_dec_acc_amt"].ToString()%></td>
  
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_01"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_02"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_03"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_04"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_05"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_06"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_07"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_08"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_09"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_10"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_11"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["amt_12"].ToString()%></td>
  
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["depr_peirod"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_org_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_acc_amt"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["end_remain"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["depr_acc"].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_detail.Rows[i]["depr_month_amt"].ToString()%></td>
  <td class=xl33><%=dt_detail.Rows[i]["exp_acc"].ToString()%></td>
 </tr>
 <%
     }
 }
 }
}
}
} // end if dt_grp_kind
} // end for dt_depr_yn
} // end if dt_depr_yn
     if (dt_grd_total.Rows.Count > 0)
        {
%>

 
 <tr class=xl35 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=9 height=17 class=xl58 style='border-right:.5pt solid black;
  height:12.75pt'>TOTAL</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["origin_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["remain_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["new_pur_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["sub_acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["dis_dec_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["dis_dec_acc_amt"].ToString()%></td>
  
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_01"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_02"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_03"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_04"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_05"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_06"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_07"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_08"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_09"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_10"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_11"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["amt_12"].ToString()%></td>
 
  
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["depr_peirod"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_org_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_acc_amt"].ToString()%></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["end_remain"].ToString()%></td>
  <td class=xl37></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_grd_total.Rows[0]["depr_month_amt"].ToString()%></td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none'>&nbsp;</td>  
  
  <!--td class=xl37 style='border-left:none' x:num ></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td>
  <td class=xl37 style='border-left:none' x:num></td-->
 </tr>
 <%
     }
     if (dt_sum_location.Rows.Count > 0)
     {
         for (int si = 0; si < dt_sum_location.Rows.Count; si++)
         {

           
 %>
 <tr class=xl31 height=16 style='height:12.0pt'>
  <td colspan=9 height=16 class=xl49 style='border-right:.5pt solid black;
  height:12.0pt'>Sub Total <%=dt_sum_location.Rows[si]["LOCATION"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["origin_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["remain_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["new_pur_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["sub_acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["dis_dec_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["dis_dec_acc_amt"].ToString()%></td>
  
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_01"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_02"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_03"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_04"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_05"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_06"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_07"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_08"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_09"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_10"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_11"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["amt_12"].ToString()%></td>
 
  
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["depr_peirod"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_org_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_acc_amt"].ToString()%></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["end_remain"].ToString()%></td>
  <td class=xl41></td>
  <td class=xl41 style="mso-number-format:'<%= p_xls_ccy_format %>';border-top:none;border-left:none" x:num><%= dt_sum_location.Rows[si]["depr_month_amt"].ToString()%></td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <!--td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td-->
 </tr>
 <%
     }
 } 
  %>

 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=29 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl50 width=287 style='border-right:.5pt solid black;
  width:216pt'>Day... Month.... Year.....</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Prepared by</td>
  <td colspan=26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24>Director</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=0></td>
  <td width=95 style='width:71pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
