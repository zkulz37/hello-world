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
    string p_Project_pk = Request["project_pk"];
    string p_tecps_VendorBasc_pk = Request["tecps_VendorBasc_pk"];
    string p_TECPS_SUBSTRP12000_PK = Request["TECPS_SUBSTRP12000_PK"];
    string l_parameter = "'" + p_Project_pk + "',";
    l_parameter += "'" + p_tecps_VendorBasc_pk + "',";
    l_parameter += "'" + p_TECPS_SUBSTRP12000_PK + "'";
    string p_Field = "";
    string p_Date = "";
    string p_Request_No = "";
    string p_Project_Cd = "";
    string p_Project_Nm = "";
    string p_Subject = "";
    string p_Contract_Number = "";
    decimal p_Contract_Amount =0;
    string p_Subcontractor = "";
    string p_Contract_Period = "";
    string p_Contract_Period_Before = "";
    //string p_Contract_Period_After = "";
    decimal p_After_Amt = 0;
    string p_Remark = "";
    decimal p_Before_Amt = 0;
    DataTable dt = ESysLib.TableReadOpenCursor("pm_rpt_61050030_request", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }

    
    p_Field = dt.Rows[0][0].ToString();
    p_Date = dt.Rows[0][1].ToString();
    p_Request_No = dt.Rows[0][2].ToString();
    p_Project_Cd = dt.Rows[0][3].ToString();
    p_Project_Nm = dt.Rows[0][4].ToString();
    p_Subject = dt.Rows[0][5].ToString();
    p_Contract_Number = dt.Rows[0][6].ToString();
    p_Contract_Amount = decimal.Parse(dt.Rows[0][7].ToString());
    
    p_Subcontractor = dt.Rows[0][8].ToString();
    p_Contract_Period = dt.Rows[0][9].ToString();
    p_After_Amt = decimal.Parse(dt.Rows[0][10].ToString());
    //Response.Write(dt.Rows.Count);
    //Response.End();
    p_Remark = dt.Rows[0][11].ToString();
    p_Before_Amt = decimal.Parse(dt.Rows[0][12].ToString());
    p_Contract_Period_Before = dt.Rows[0][13].ToString();
    //if (p_After_Amt.Trim() != "" || p_Contract_Amount.Trim() != "")
    //{
    //    p_Remark = decimal.Parse(p_After_Amt) - decimal.Parse(p_Contract_Amount);
    //}
    //else
    //{
    //    p_Remark = 0;
    //}

    string SQL = "select B.ORDERINGCONTTYPENAME Item, nvl(c.changeamt,0) Total_Budget, (select nvl(SUPPLYPRICE,0) from TECPS_VENDORBASC where del_if = 0 and TECPS_PROJECTSUMM_PK = '" + p_Project_pk + "' and TECPS_SUBSTRP12000_PK = '" + p_TECPS_SUBSTRP12000_PK + "'   and serial_no = (select nvl(serial_no,0) - 1 from TECPS_VENDORBASC  where del_if = 0 and TECPS_PROJECTSUMM_PK = '" + p_Project_pk + "' and TECPS_SUBSTRP12000_PK = '"+p_TECPS_SUBSTRP12000_PK+"' and pk = '"+p_tecps_VendorBasc_pk+"') ) Pre, nvl(A.SUPPLYPRICE,0) this, null Accum, nvl(c.changeamt,0) - nvl(A.SUPPLYPRICE,0) Remain  " +
        "from TECPS_VENDORBASC a, TECPS_ORDERINGCONTTYPE b, " +
        " (  select  tecps_orderingconttype_pk,changecurrency,sum( changeamt ) changeamt, sum(changeamt_bk) changeamt_bk " +
        "           from tecps_performrmrk " +
        "           where del_if =0 " +
        "             and  tecps_projectsumm_pk = '"+p_Project_pk+"' " +
        "             and tecps_performbudgetbasc_pk = (select pk from tecps_performbudgetbasc " +
        "              where del_if =0 and seq= (select   nvl(max(seq), -1) from tecps_performbudgetbasc where tecps_projectsumm_pk='" + p_Project_pk + "' and status=0 and del_if =0)  " +
        "              and tecps_projectsumm_pk =  '" + p_Project_pk + "' and status= 0) " +
        "             group by tecps_orderingconttype_pk,changecurrency " +
        "       )  c " +
        "where a.del_if = 0 " +
        "and b.del_if = 0 " +
        "and A.TECPS_ORDERINGCONTTYPE_PK = b.pk " +
        " and b.pk = c.tecps_orderingconttype_pk " +
        "and A.TECPS_PROJECTSUMM_PK = '" + p_Project_pk + "' " +
        "and A.TECPS_SUBSTRP12000_PK = '"+p_TECPS_SUBSTRP12000_PK+"' " +
        "and a.pk = '"+p_tecps_VendorBasc_pk+"' ";

    DataTable dt_Detail = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs313_Request_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs313_Request_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs313_Request_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-10-28T03:52:32Z</o:LastPrinted>
  <o:Created>2008-11-20T03:45:48Z</o:Created>
  <o:LastSaved>2011-10-28T07:04:18Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.91in .41in .75in .54in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:left;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:바탕, serif;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:바탕, serif;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl108
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl111
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl112
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl115
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl116
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl117
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl119
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl120
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl121
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl122
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl123
	{mso-style-parent:style20;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl134
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl135
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl139
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl140
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl141
	{mso-style-parent:style17;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>C.M.R (Leasing equipment)</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>79</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>16</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8595</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:TabRatio>696</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=982 style='border-collapse:
 collapse;table-layout:fixed;width:740pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=6 rowspan=7 height=182 class=xl57 width=352 style='border-bottom:
  .5pt solid black;height:140.7pt;width:265pt'>CONTRACT MODIFICATION REQUEST</td>
  <td colspan=3 class=xl63 width=157 style='border-right:.5pt solid black;
  width:119pt'>Prepared</td>
  <td colspan=3 class=xl63 width=169 style='border-right:.5pt solid black;
  border-left:none;width:127pt'>Reviewed</td>
  <td colspan=3 class=xl63 width=176 style='border-right:1.0pt solid black;
  border-left:none;width:133pt'>Approved</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=3 rowspan=5 height=130 class=xl67 width=157 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:100.5pt;width:119pt'>&nbsp;</td>
  <td colspan=3 rowspan=5 class=xl67 width=169 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:127pt'>&nbsp;</td>
  <td colspan=3 rowspan=5 class=xl67 width=176 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black;width:133pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=2 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=2 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=2 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=2 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=3 height=26 class=xl81 width=157 style='border-right:.5pt solid black;
  height:20.1pt;width:119pt'>Name of PIC</td>
  <td colspan=3 class=xl81 width=169 style='border-right:.5pt solid black;
  border-left:none;width:127pt'>Name of S/M</td>
  <td colspan=3 class=xl85 width=176 style='border-right:1.0pt solid black;
  border-left:none;width:133pt'>Name of G/L</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 height=26 class=xl87 style='height:20.1pt'>■<font class="font10">
  Field :</font><%=p_Field%></td>
  <td colspan=3 class=xl89 width=173 style='width:131pt'>■<font class="font7">Date
  :</font><%=p_Date%></td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=32 style='width:24pt'>&nbsp;</td>
  <td colspan=5 class=xl90 width=313 style='border-right:1.0pt solid black;
  width:236pt' >■ Req No :<span
  style='mso-spacerun:yes'> </span><%=p_Request_No %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=15 height=26 class=xl92 width=854 style='border-right:1.0pt solid black;
  height:20.1pt;width:644pt'>Subject :<%=p_Subject %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=12 class=xl95 width=738 style='width:556pt'>We would like to
  propose the contract modification request for as below :<%=p_Field%></td>
  <td class=xl28></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td colspan=13 height=8 class=xl31 width=750 style='height:6.0pt;width:565pt'>&nbsp;</td>
  <td class=xl30></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl34 width=142 style='width:107pt'>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Project code :</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 width=102 style='width:77pt'><%=p_Project_Cd%></td>
  <td colspan=8 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl34 width=142 style='width:107pt'>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Project name :</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl36 width=500 style='width:377pt'><%=p_Project_Nm %></td>
  <td class=xl36></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl25>3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Budget status :</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl96>(Currency: VND, excluding VAT)</td>
  <td class=xl37></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl39 style='height:27.0pt'>&nbsp;</td>
  <td class=xl40 width=142 style='width:107pt'>Item</td>
  <td colspan=3 class=xl97 width=129 style='border-right:.5pt solid black;
  border-left:none;width:97pt'>Total Budget</td>
  <td colspan=2 class=xl99 width=123 style='border-right:.5pt solid black;
  border-left:none;width:93pt'>Previous time</td>
  <td colspan=3 class=xl99 width=135 style='border-right:.5pt solid black;
  border-left:none;width:102pt'>This time</td>
  <td colspan=2 class=xl99 width=137 style='border-right:.5pt solid black;
  border-left:none;width:103pt'>Accummulate</td>
  <td colspan=2 class=xl99 width=154 style='border-right:.5pt solid black;
  border-left:none;width:116pt'>Remain</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dt_Detail.Rows.Count;i++ )
     {
  %>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl33 style='height:23.25pt'>&nbsp;</td>
  <td rowspan=2 class=xl100 width=142 style='border-bottom:.5pt solid black;  border-top:none;width:107pt'><%=dt_Detail.Rows[i][0]%></td>
  <td colspan=3 rowspan=2 class=xl102 width=129 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:97pt;color:blue'  x:num><%=dt_Detail.Rows[i][1]%></td>
  <td colspan=2 rowspan=2 class=xl102 width=123 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:93pt;color:blue'  x:num><%=dt_Detail.Rows[i][2]%></td>
  <td colspan=3 rowspan=2 class=xl102 width=135 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:102pt;color:blue' x:num><%=dt_Detail.Rows[i][3]%></td>
  <td colspan=2 rowspan=2 class=xl102 width=137 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:103pt;color:blue' x:num><%=dt_Detail.Rows[i][4]%></td>
  <td colspan=2 rowspan=2 class=xl102 width=154 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:116pt;color:blue' x:num><%=dt_Detail.Rows[i][5]%></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl33 style='height:23.25pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl43></td>
  <td colspan=8 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current
  contract status :</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl96>(Unit : VND, excluding VAT)</td>
  <td class=xl37></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl39 style='height:34.5pt'>&nbsp;</td>
  <td class=xl40 width=142 style='width:107pt'>Contract number</td>
  <td colspan=4 class=xl97 width=198 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>Nature of work</td>
  <td colspan=4 class=xl99 width=189 style='border-right:.5pt solid black;
  border-left:none;width:143pt'>Contract amount</td>
  <td colspan=2 class=xl99 width=137 style='border-right:.5pt solid black;
  border-left:none;width:103pt'>Subcontractor</td>
  <td colspan=2 class=xl99 width=154 style='border-right:.5pt solid black;
  border-left:none;width:116pt'>Contract Period</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td rowspan=2 class=xl100 width=142 style='border-bottom:.5pt solid black;  border-top:none;width:107pt'><%=p_Contract_Number%></td>
  <td colspan=4 rowspan=2 class=xl111 width=198 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:149pt'><%=p_Subject %></td>
  <td colspan=4 rowspan=2 class=xl114 width=189 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:143pt' x:num><%=p_Contract_Amount%></td>
  <td colspan=2 rowspan=2 class=xl120 width=137 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:103pt'><%=p_Subcontractor %></td>
  <td colspan=2 rowspan=2 class=xl124 width=154 style='border-right:.5pt solid black;  border-bottom:.5pt solid black;width:116pt'><%=p_Contract_Period_Before %></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl31 width=12 style='height:12.75pt;width:9pt'>&nbsp;</td>
  <td class=xl30></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=4 class=xl128 width=271 style='width:204pt'>5.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Modification
  contents :</td>
  <td class=xl46 width=69 style='width:52pt;border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl46 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl46 width=50 style='width:38pt'>&nbsp;</td>
  <td class=xl46 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl46 width=32 style='width:24pt'>&nbsp;</td>
  <td colspan=3 class=xl129>(Unit : VND, excluding VAT)</td>
  <td class=xl37></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl33 style='height:24.0pt'>&nbsp;</td>
  <td colspan=3 class=xl97 width=238 style='border-right:.5pt solid black;
  width:179pt'>Item</td>
  <td colspan=4 class=xl99 width=206 style='border-right:.5pt solid black;
  border-left:none;width:156pt'>Before modified</td>
  <td colspan=4 class=xl99 width=222 style='border-right:.5pt solid black;
  border-left:none;width:167pt'>After modified</td>
  <td colspan=2 class=xl99 width=154 style='border-right:.5pt solid black;
  border-left:none;width:116pt'>Remarks</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl47 style='height:31.5pt'>&nbsp;</td>
  <td colspan=3 class=xl130 width=238 style='border-right:.5pt solid black;
  width:179pt'>Contract amount</td>
  <td colspan=4 class=xl134 width=206 style='border-right:.5pt solid black;
  border-left:none;width:156pt' x:num><%=p_Contract_Amount %>
  </td>
  <td colspan=4 class=xl134 width=222 style='border-right:.5pt solid black;
  border-left:none;width:167pt' x:num><%=p_After_Amt %></td>
  <td colspan=2 class=xl142 width=154 style='border-right:.5pt solid black;
  border-left:none;width:116pt' x:num><%=p_Remark %></td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl47 style='height:31.5pt'>&nbsp;</td>
  <td colspan=3 class=xl130 width=238 style='border-right:.5pt solid black;
  width:179pt'>Contract period</td>
  <td colspan=4 class=xl136 width=206 style='border-right:.5pt solid black;
  border-left:none;width:156pt'><%=p_Contract_Period_Before %></td>
  <td colspan=4 class=xl136 width=222 style='border-right:.5pt solid black;
  border-left:none;width:167pt'><%=p_Contract_Period %></td>
  <td colspan=2 class=xl136 width=154 style='border-right:.5pt solid black;
  border-left:none;width:116pt'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=12 style='mso-height-source:userset;height:9.0pt'>
  <td colspan=13 height=12 class=xl137 width=750 style='height:9.0pt;
  width:565pt'>&nbsp;</td>
  <td class=xl49></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=12 class=xl28 width=738 style='width:556pt'>6.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Reason
  of contract modification is as belows</td>
  <td class=xl28></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl50 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=12 rowspan=4 class=xl51 width=738 style='width:556pt'
  x:str="' - Quantity of some items is reduced because scope of work with client is changed"><span
  style='mso-spacerun:yes'> </span>- Quantity of some items is reduced because
  scope of work with client is changed</td>
  <td class=xl51></td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl50 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td class=xl51></td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl50 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td class=xl51></td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td class=xl51></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=13 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=13 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=13 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=13 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=4 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=7 class=xl28 width=398 style='width:300pt'></td>
  <td class=xl28></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl31 width=12 style='height:18.0pt;width:9pt'>&nbsp;</td>
  <td colspan=5 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 width=12 style='height:20.1pt;width:9pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Attachment as belows ;</td>
  <td colspan=11 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td class=xl54 colspan=2 style='mso-ignore:colspan'>1. Modified the bill of
  quantity</td>
  <td class=xl54></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 width=12 style='height:20.1pt;width:9pt'>&nbsp;</td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=13 height=26 class=xl138 width=750 style='height:20.1pt;
  width:565pt'>posco engineering &amp; construction - Vietnam co., ltd.</td>
  <td class=xl55 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=12 style='width:9pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
