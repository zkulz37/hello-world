<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_Project_Pk = Request["Project_Pk"];
	string p_Project_Cd = Request["Project_Cd"];
	string p_Project_Nm = Request["Project_Nm"];
	string p_Customer_Pk = Request["Customer_Pk"];
    string p_Customer_Cd = Request["Customer_Cd"];
    string p_Customer_Nm = Request["Customer_Nm"];
    string p_Tab = Request["Tab"];

    string p_Org_Ccy = "";
    string p_Org_Amt = "";
    string p_Period_Fr = "";
    string p_Period_To = "";
    string p_Final_Ccy = "";
    string p_Final_Amt = "";
    string p_Warranty_Fr = "";
    string p_Warranty_To = "";
    string p_Advance = "";
    string p_Progress = "";
    string p_Retention = "";
    string p_VAT_Amt = "";

    //string SQL = " select   a.ccy,a.ctr_amt, to_char(to_date(C.EXRATE_DT, 'YYYYMMDD'), 'DD/Mon/YYYY') Period_Fr , to_char(to_date(C.VALID_TO, 'YYYYMMDD'), 'DD/Mon/YYYY') Period_To, " +
    //    " d.ccy final_ccy,d.final_amt, to_char(to_date(C.WANRANTY_FR , 'YYYYMMDD'), 'DD/Mon/YYYY') Warranty_Fr, to_char(to_date(C.WANRANTY_TO , 'YYYYMMDD'), 'DD/Mon/YYYY') Warranty_To, " +
    //    "C.ADVANCE, C.PROGRESS, C.RETENTION, A.VAT_AMT " +
    //    "    from tecps_project_contr a, comm.tco_buspartner b, tecps_projectsumm c,  " +
    //    "    (select tecps_projectsumm_pk, sum(nvl(ctr_amt,0))final_amt, ccy from tecps_project_contr where del_if = 0 and tecps_projectsumm_pk = '" + p_Project_Pk + "'   group by ccy,vat_yn, tecps_projectsumm_pk) d " +
    //    "    where  a.del_if =0 and b.del_if (+)=0 " +
    //    "    and c.del_if = 0 " +
    //    "    and a.tco_buspartner_pk = b.pk(+) " +
    //    "    and A.TECPS_PROJECTSUMM_PK = c.pk " +
    //    "    and A.TECPS_PROJECTSUMM_PK = d.TECPS_PROJECTSUMM_PK " +
    //    "    and a.tecps_projectsumm_pk = '"+p_Project_Pk+"' " +
    //    "     and a.TCO_BUSPARTNER_PK = '"+p_Customer_Pk+"' ";
    string l_parameter = "'" + p_Project_Pk + "','" + p_Customer_Pk + "','" + p_Tab +"'";
    DataTable dt_master = ESysLib.TableReadOpenCursor("rpt_sel_kpbp1212",l_parameter);
    if (dt_master.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
       p_Org_Ccy = dt_master.Rows[0][0].ToString();
       p_Org_Amt = dt_master.Rows[0][1].ToString();
       p_Period_Fr = dt_master.Rows[0][2].ToString();
       p_Period_To = dt_master.Rows[0][3].ToString();
       p_Final_Ccy = dt_master.Rows[0][4].ToString();
       p_Final_Amt = dt_master.Rows[0][5].ToString();
       p_Warranty_Fr = dt_master.Rows[0][6].ToString();
       p_Warranty_To = dt_master.Rows[0][7].ToString();
       p_Advance = dt_master.Rows[0][8].ToString();
       p_Progress = dt_master.Rows[0][9].ToString();
       p_Retention = dt_master.Rows[0][10].ToString();
       p_VAT_Amt = dt_master.Rows[0][11].ToString();
    }
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor("rpt_sel_kpbp1212_1",l_parameter);
	DataTable dt_sum = ESysLib.TableReadOpenCursor("rpt_sel_kpbp1212_1_sum",l_parameter);

    string sql2 = "SELECT SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";
    string p_ccy = "";
    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        p_ccy = dt_bccy.Rows[0][0].ToString();
    }
    string p_format = "";
    if (p_ccy == "0")
    {
        p_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbp1212_trans_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbp1212_trans_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbp1212_trans_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-11-02T08:54:52Z</o:LastPrinted>
  <o:Created>2011-09-17T02:23:27Z</o:Created>
  <o:LastSaved>2011-11-10T03:12:45Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.3in .17in .16in .17in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style21
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma 2";}
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
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl46
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl64
	{mso-style-parent:style20;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style20;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
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
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl80
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AR report</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>8</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7875</x:WindowHeight>
  <x:WindowWidth>15000</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\\192.168.1.6\Accounting_Backup\posco e&amp;c\CONTRACT\customer_Communication_History1.xlsx</x:Path>
  <x:SheetName>Bugs Log</x:SheetName>
  <x:SheetName>Configuration</x:SheetName>
  <x:SheetName>Analysis</x:SheetName>
  <x:SheetName>Plan</x:SheetName>
  <x:SheetName>Sheet1</x:SheetName>
  <x:SheetName>Sheet2</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>62</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
   <x:Crn>
    <x:Row>1</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.1 Entry Subcontractor</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>2</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.4 Inquiry subcontractor</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>3</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.5 Contract registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>4</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Change Budget Period</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>5</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.7 Level code registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>6</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.8 Capacity</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>7</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Register Standard Expenses Item</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>8</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.9 Size Code Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>9</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Register Budget Item</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>10</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.10 Facilities Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>11</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.0.11 Work Division Entry</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>12</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.1 Project Summary Mgmt</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>13</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.2 Project Status Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>14</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.1.3 Project Search By Scale Value</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>15</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.1 Contract serial No. Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>16</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.2 Contract details EXCEL UPLOAD</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>17</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.3 Contract details registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>18</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.4 Contract O/H expenses registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>19</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.5 Contract deteails search/print</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>20</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.6 Contract progress payment registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>21</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;1.2.7 Register legally allowed Expenses of Main Contract</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>22</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.1 Placement Order Work Division Code</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>23</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.2 Budget Cost of Work Schedule(BCWS) Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>24</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.3 BCWS Period Change</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>25</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.4 [Contructtion]Working Details EXCEL UPLOAD</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>26</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.5 BCWS Details Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>27</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.6 Inputed Personnel Man Hour Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>28</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.7 Working Legal O/H Expenses Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>29</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.8 Working Expense Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>30</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.9 Working O/H Cost Caculation</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>31</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.11 Working Details Search by Work Division</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>32</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.12 BCWS Print-Out By Item of Expenditure</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>33</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.13 BCWS Summary Search Approval</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>34</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.1.14 [Contruction] Working Details Search By Conditions</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>35</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.1 Adjustment Serial No. Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>36</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.2 Adjustment Details Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>37</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.3 Adjustted Input Personnel Man Hour Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>38</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.4 Adjusted Legal O/H Expenses Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>39</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.5 Adjusted Expense Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>40</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.6 Adjusted O/H Cost Caculation</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>41</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.7 Adjustment Approval Details Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>42</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.8 Adjusted BCWS Print-Out By Item of Expenditure</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>43</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.9 Adjusted BCWS Summary Search Approval</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>44</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;2.2.10 [Construction] Working Details Standard Code Revision</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>45</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.1 SubContract List</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>46</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.2 SubContract Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>47</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.3 Changed SubContract Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>48</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.4 Inspection Report Input for P/P</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>49</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;3.1.5 Outsourcing Cumulative P/P Search</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>50</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.1 Expenditure Issue Input</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>51</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.2 Actual Result of Advanced Money</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>52</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.3 None - Payment Repay</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>53</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;4.1.4 Actual Result of Corporation Card</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>54</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;5.1.1 Progress Plan Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>55</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;5.2.1 Actual Result Registration</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>56</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Input Cost</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>57</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Project Status</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>58</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Profit &amp; Loss of Project</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>59</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Inquiry Budget</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>60</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;Subcontract Status</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>61</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;6.2.1 Expected completion cost</x:Text>
   </x:Crn>
   <x:Crn>
    <x:Row>62</x:Row>
    <x:ColFirst>1</x:ColFirst>
    <x:ColLast>1</x:ColLast>
    <x:Text>&#160;6.2.2 Expected completion cost approval</x:Text>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>SCREENS</x:Name>
  <x:Formula>='\\192.168.1.6\Accounting_Backup\posco e&amp;c\CONTRACT\[customer_Communication_History1.xlsx]Configuration'!$B$2:$B$65460</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1871 style='border-collapse:
 collapse;table-layout:fixed;width:1407pt'>
 <col class=xl25 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl25 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl25 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl26 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl25 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl25 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=118 span=3 style='mso-width-source:userset;mso-width-alt:
 4315;width:89pt'>
 <col class=xl25 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <col class=xl25 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl25 width=107 span=2 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 <col class=xl25 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl25 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl25 width=13 style='height:9.75pt;width:10pt'></td>
  <td class=xl25 width=138 style='width:104pt'></td>
  <td class=xl25 width=38 style='width:29pt'></td>
  <td class=xl25 width=91 style='width:68pt'></td>
  <td class=xl26 width=76 style='width:57pt'></td>
  <td class=xl25 width=111 style='width:83pt'></td>
  <td class=xl25 width=25 style='width:19pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=114 style='width:86pt'></td>
  <td class=xl25 width=118 style='width:89pt'></td>
  <td class=xl25 width=118 style='width:89pt'></td>
  <td class=xl25 width=118 style='width:89pt'></td>
  <td class=xl25 width=127 style='width:95pt'></td>
  <td class=xl25 width=118 style='width:89pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=118 style='width:89pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl25 width=117 style='width:88pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl28></td>
  <td class=xl29></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td class=xl29></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl32></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td colspan=18 class=xl75 style='border-right:.5pt solid black'>CONTRACT
  COLLECTION INFORMATION</td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl25 style='height:9.0pt'></td>
  <td class=xl33></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl25 style='height:14.1pt'></td>
  <td class=xl35>Project Name</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26><%=p_Project_Cd %></td>
  <td colspan=8 class=xl26><%=p_Project_Nm %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Subcontractor</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl36><%=p_Customer_Cd %></td>
  <td colspan=8 class=xl26><%=dt_master.Rows[0]["partner_nm"].ToString() %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>Original Contract Amount
  (Net)</td>
  <td class=xl26><%=p_Org_Ccy %></td>
  <td class=xl37 x:num ><%=p_Org_Amt %></td>
  <td class=xl25></td>
  <td class=xl25>Contract Period</td>
  <td colspan=2 class=xl78 align="left"  ><%=p_Period_Fr %> ~ <%=p_Period_To %></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>Final Contract Amount
  (Net)</td>
  <td class=xl25></td>
  <td class=xl26><%=p_Final_Ccy %></td>
  <td class=xl37 x:num><%=p_Final_Amt %></td>
  <td class=xl25></td>
  <td class=xl25>Warranty Period</td>
  <td colspan=2 class=xl78 align="left" ><%=p_Warranty_Fr %>~<%=p_Warranty_To %></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Payment Condition</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26>Advance</td>
  <td class=xl38 x:num><%=p_Advance %>%</td>
  <td class=xl25></td>
  <td class=xl25>Progress</td>
  <td class=xl38 x:num><%=p_Progress %>%</td>
  <td class=xl25>Retention</td>
   <td class=xl38 x:num><%=p_Retention %>%</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl40></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl41></td>
  <td class=xl43></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl25 style='height:27.75pt'></td>
  <td class=xl45>REQUEST TYPE</td>
  <td class=xl46>No</td>
  <td class=xl46>Request date</td>
  <td class=xl46>Percentage</td>
  <td colspan=2 class=xl79 style='border-right:.5pt solid black;border-left:
  none'>Claimed Amount</td>
  <td class=xl46>VAT</td>
  <td class=xl48 width=114 style='width:86pt'>Advance<br>
    deduct</td>
  <td class=xl46>Retention</td>
  <td class=xl48 width=118 style='width:89pt'>Others<br>
    deduct</td>
  <td class=xl48 width=118 style='width:89pt'>Total <br>
    deduct</td>
  <td class=xl48 width=127 style='width:95pt'>Net Receivable</td>
  <td class=xl48 width=118 style='width:89pt'>Total Receivable</td>
  <td class=xl48 width=107 style='width:80pt'>Net Collected</td>
  <td class=xl48 width=107 style='width:80pt'>VAT Collected</td>
  <td class=xl48 width=118 style='width:89pt'>Total Collected</td>
  <td class=xl48 width=107 style='width:80pt'>Date</td>
  <td class=xl46>Remark</td>
 </tr>
 <%
    
    int i=0;
   
    for (i = 0; i < dt_detail.Rows.Count;i++ )
    {
       
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl49 width=138  style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["requesttype"]%></td>
  <td class=xl50 width=38 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["REQUEST_TIMES"]%></td>
  <td class=xl51 width=91 style='mso-number-format:<%= p_format %>' x:num ><%=dt_detail.Rows[i]["requestdate"]%></td>
  <td class=xl52  ><%=dt_detail.Rows[i]["percentage"]%></td>
  <td colspan=2 class=xl81 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["claimed_amount"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num ><%=dt_detail.Rows[i]["vat"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["deductap"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["retention"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["other_deduct"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["total_deduct"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num ><%=dt_detail.Rows[i]["netreceivable"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["totalreceivable"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["netcollected"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["vatcollected"]%></td>
  <td class=xl53 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["totalcollected"]%></td>
  <td class=xl53><%=dt_detail.Rows[i]["date_collect"]%></td>
  <td class=xl54 width=117 style='mso-number-format:<%= p_format %>' x:num><%=dt_detail.Rows[i]["description"]%></td>
 </tr>
 <% } %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl55 width=138 style='width:104pt'>Total</td>
  <td class=xl56 width=38 style='width:29pt'></td>
  <td class=xl56 width=91 style='width:68pt'></td>
  <td class=xl57 ><%=dt_sum.Rows[0]["percentage"]%></td>
  <td colspan=2 class=xl83 style='border-right:.5pt solid black;border-left:  none' x:num><%=dt_sum.Rows[0]["claimed_amount"]%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%=dt_sum.Rows[0]["vat"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["deductap"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["retention"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["other_deduct"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["total_deduct"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["netreceivable"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["totalreceivable"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["netcollected"]%></td>
  <td class=xl59 style='border-top:none' x:num><%=dt_sum.Rows[0]["vatcollected"]%></td>
  <td class=xl60 style='border-top:none' x:num><%=dt_sum.Rows[0]["totalcollected"]%></td>
  <td class=xl61></td>
  <td class=xl56 width=117 style='width:88pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl86></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl62>SUMMARY</td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=2 class=xl87 x:str="Net"><span
  style='mso-spacerun:yes'>�</span>Net<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl47>VAT</td>
  <td class=xl47>Total</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Contract Amount</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=2 class=xl85 style='mso-number-format:<%= p_format %>' x:num><%=dt_master.Rows[0]["final_amt"].ToString() %></td>
  <td class=xl37 style='mso-number-format:<%= p_format %>' x:num><%=dt_master.Rows[0]["final_vat_famt"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_master.Rows[0]["final_total_amt"].ToString() %> </td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Issued VAT invoice</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl85 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["net_invoice"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["vat_invoice"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["total_invoice"].ToString() %></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Remain VAT invoice</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl85 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["remain_net_inv"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["remain_vat_inv"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["remain_total_inv"].ToString() %></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35>Receivable Amount</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl64><%=dt_sum.Rows[0]["percentage"]%></td>
  <td colspan=2 class=xl88 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["claimed_amount"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["vat"].ToString() %></td>
  <td class=xl63 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["total_famt"].ToString() %></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl65>Balance</td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl67><%=dt_sum.Rows[0]["percentage1"]%></td>
  <td class=xl68 colspan="2" style='mso-number-format:<%= p_format %>' x:num ><%=dt_sum.Rows[0]["remain_net_amt"].ToString() %></td>
 
  <td class=xl70 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["remain_vat"].ToString() %></td>
  <td class=xl70 style='mso-number-format:<%= p_format %>' x:num><%=dt_sum.Rows[0]["remain_total"].ToString() %></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl71></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl73></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl74></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=117 style='width:88pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
