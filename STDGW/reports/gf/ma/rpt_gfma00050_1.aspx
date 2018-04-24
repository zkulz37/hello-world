<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
  ESysLib.SetUser("acnt");   
  string l_pk=Request["pk"];
  string l_tco_company_pk = Request["company_pk"];
  string l_num="";
  string l_t_num="";

  string l_col1_1 = "";
  string l_col1_2 = "";
  string l_col1_3 = "";

  string l_col2_1 = "";
  string l_col2_2 = "";
  string l_col2_3 = "";

  string l_col3_1 = "";
  string l_col3_2 = "";
  string l_col3_3 = "";

  string l_colK_1 = "";
  string l_colK_2 = "";
  string l_colK_3 = "";
  string l_colK_4 = "";
  string l_colK_5 = "";
  
  string l_colV_1 = "";
  string l_colV_2 = "";
  string l_colV_3 = "";
  string l_colV_4 = "";
  string l_colV_5 = "";
      
  string l_colE_1 = "";
  string l_colE_2 = "";
  string l_colE_3 = "";
  string l_colE_4 = "";
  string l_colE_5 = "";
    
  string l_colS_1 = "";
  string l_colS_2 = "";
  string l_colS_3 = "";
  string l_colS_4 = "";
  string l_colS_5 = "";
  string l_colN_1 = "";
  string l_colN_2 = "";
  string l_colN_3 = "";
  string l_colN_4 = "";
  string l_colN_5 = "";

  string SQL_EACAB044 = "SELECT   char_1, char_2, char_3,char_4, code,char_5 " +
        "    FROM tac_commcode_master a, tac_commcode_detail b " +
        "    WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB046' " +
        "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
        "    ORDER BY code, b.code_nm ";
 
  DataTable dt_EACAB044 = ESysLib.TableReadOpen(SQL_EACAB044);
  if (dt_EACAB044.Rows.Count > 0)
  {
      for (int j = 0; j < dt_EACAB044.Rows.Count; j++)
      {
          switch (dt_EACAB044.Rows[j][4].ToString())
          { 
              case "KOR":
                  l_colK_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colK_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colK_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colK_4 = dt_EACAB044.Rows[j][3].ToString();
                  l_colK_5 = dt_EACAB044.Rows[j][5].ToString();
              break;
              case "ENG":
                  l_colE_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colE_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colE_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colE_4 = dt_EACAB044.Rows[j][3].ToString();
                  l_colE_5 = dt_EACAB044.Rows[j][5].ToString(); 
              break;
             case "VIE":
                  l_colV_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colV_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colV_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colV_4 = dt_EACAB044.Rows[j][3].ToString();
                  l_colV_5 = dt_EACAB044.Rows[j][5].ToString();
              break;
             case "SIG":
                  l_colS_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colS_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colS_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colS_4 = dt_EACAB044.Rows[j][3].ToString();
                  l_colS_5 = dt_EACAB044.Rows[j][5].ToString();
              break;
              case "NAM":
                  l_colN_1 = dt_EACAB044.Rows[j][0].ToString();
                  l_colN_2 = dt_EACAB044.Rows[j][1].ToString();
                  l_colN_3 = dt_EACAB044.Rows[j][2].ToString();
                  l_colN_4 = dt_EACAB044.Rows[j][3].ToString();
                  l_colN_5 = dt_EACAB044.Rows[j][5].ToString();
              break;               
          }
      }
  }

  string SQL_com = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE,TCO_BPPHOTO_PK " +
          " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

  DataTable dt_comm = ESysLib.TableReadOpen(SQL_com);
  string SQL
     = "SELECT a.pk, TO_CHAR(TO_DATE(a.tr_date, 'yyyymmdd'), 'dd-Mon-yyyy') tr_date, a.voucher_no, b.full_name, c.ORG_NM " +
         "  FROM tac_advspendm a, tac_employee_adv b, comm.tco_org c " +
         " WHERE a.del_if = 0 AND b.del_if = 0 AND a.tac_employee_adv_pk = b.pk " +
         "       AND c.del_if (+)= 0 AND a.tco_org_pk = c.pk(+) AND a.pk ='" + l_pk + "' ";

string tr_date="";
string vc_no = "";
string full_name = "";
string ORG_NM = "";     
DataTable dt = ESysLib.TableReadOpen(SQL);
if (dt.Rows.Count > 0)
{ 
    tr_date = dt.Rows[0]["tr_date"].ToString();
    vc_no = dt.Rows[0]["voucher_no"].ToString();
    full_name = dt.Rows[0]["full_name"].ToString();
    ORG_NM = dt.Rows[0]["ORG_NM"].ToString();
}




string l_parameter = "'" + l_pk + "'";
DataTable dt_d = ESysLib.TableReadOpenCursor("acnt.sp_sel_rptgfma00050_1", l_parameter);
   
 

 

 
   
  %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Denghi_qtoan1_files/filelist.xml">
<link rel=Edit-Time-Data href="Denghi_qtoan1_files/editdata.mso">
<link rel=OLE-Object-Data href="Denghi_qtoan1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:LastPrinted>2009-08-24T03:58:06Z</o:LastPrinted>
  <o:Created>2009-08-03T06:49:07Z</o:Created>
  <o:LastSaved>2009-08-24T04:18:19Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
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
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
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
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	text-align:right;
	border-top:none;
	border-right:none;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl58
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
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
	border-left:.5pt solid black;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
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
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}	
-->
</style>
<xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>De Nghi quyet toan</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column I</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=708 style='border-collapse:
 collapse;table-layout:fixed;width:532pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1243'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=8 style='mso-width-source:userset;mso-width-alt:292;
 width:6pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1280'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=8 style='mso-width-source:userset;mso-width-alt:292;
 width:6pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=2 height=44 class=xl51 width=64 style='height:34.2pt;width:48pt'><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:61px;
  height:43px'><img width=61 height=43
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_comm.Rows[0]["TCO_BPPHOTO_PK"].ToString()%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span></td>
  <td class=xl25 colspan=6 width=293 style='mso-ignore:colspan;width:220pt'><%=dt_comm.Rows[0]["PARTNER_NAME"].ToString()%></td>
  <td class=xl24 width=8 style='width:6pt'></td>
  <td colspan=6 class=xl26 width=343 style='width:258pt'><%=vc_no%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 colspan=9 ><%=dt_comm.Rows[0]["ADDR1"].ToString()%></td>
  <td colspan=4 class=xl26 width=343 style='width:258pt'>Ngày(Date):<%=tr_date%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=14 class=xl24 style='height:17.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td colspan=13 class=xl52>GI&#7844;Y &#272;&#7872; NGH&#7882; QUY&#7870;T
  TOÁN</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td colspan=13 class=xl53>(BALANCE SHEET)</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td colspan=13 class=xl26></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=3 class=xl24 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=6 style='mso-ignore:colspan'>H&#7885; Tên <font
  class="font9">(Full Name)</font><font class="font6">: </font><font
  class="font10"><%=full_name%></font></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=3 class=xl24 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'>B&#7897; ph&#7853;n<font
  class="font9"> (Section)</font><font class="font6">: </font><font
  class="font10"><%=ORG_NM%></font></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td colspan=10 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl27 colspan=7 style='height:17.1pt;mso-ignore:colspan'>A.PH&#7846;N
  T&#7840;M &#7912;NG (ADVANCE AMOUNT)</td>
  <td class=xl25></td>
  <td class=xl27 colspan=6 style='mso-ignore:colspan'>B. PH&#7846;N CHI
  (SPENDING AMOUNT)</td>
 </tr>
 <tr class=xl26 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=2 height=46 class=xl31 style='border-right:.5pt solid black;
  height:34.5pt'>Ngày<font class="font9"> (date)</font></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Lý do<font class="font9"> (Reason)</font></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>S&#7889; ti&#7873;n <font class="font9">(Amount)</font></td>
  <td class=xl26></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'>Ngày <font
  class="font9">(date)</font></td>
  <td colspan=2 class=xl55 width=126 style='border-right:.5pt solid black;
  border-left:none;width:95pt'>N&#7897;i dung chi <br>
    <font class="font9">(Description)</font></td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ti&#7873;n (Amount)</td>
 </tr>
 <%
     int r_i;
     string voucher_date="";
     string ldescription_adv = "";
     string tr_amt = "";
     string spen_dt = "";
     string spen_des = "";
     string spen_amt="";
     if (dt_d.Rows.Count > 0)
     {
         r_i = dt_d.Rows.Count;
  
        for (int i = 0; i < dt_d.Rows.Count; i++)
         {
             voucher_date = dt_d.Rows[i]["ADV_DT"].ToString();
             ldescription_adv = dt_d.Rows[i]["ADV_DES"].ToString();
             tr_amt = dt_d.Rows[i]["ADV_AMT"].ToString();
             spen_dt = dt_d.Rows[i]["SPEND_DT"].ToString();
             spen_des = dt_d.Rows[i]["SPEND_DES"].ToString();
             spen_amt = dt_d.Rows[i]["SPEND_AMT"].ToString();
            
         
                
  %>   
 <tr class=xl26 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl31 style='border-right:.5pt solid black;
  height:24.95pt'><%=voucher_date%></td>
  <td class=xl30>2</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'><%=ldescription_adv%></td>
  <td class=xl32>4</td>
  <td class=xl77 x:num><%=tr_amt%></td>
  <td class=xl26></td>
  
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'><%=spen_dt%></td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'><%=spen_des%></td>
  <td colspan=2 class=xl77 width=117 style='border-right:.5pt solid black;
  border-left:none;width:88pt' x:num><%=spen_amt%></td>
 </tr>
 <%
   
        }// end for
     }// end if
  %>
  <%
      for (int j = 0; j < 14 - dt_d.Rows.Count; j++)
      {
   %>
 <tr class=xl26 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl31 style='border-right:.5pt solid black;
  height:24.95pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl55 width=117 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>&nbsp;</td>
 </tr>
 <%
      }
  %>
 
 <tr class=xl25 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=2 height=42 class=xl31 style='border-right:.5pt solid black;
  height:31.5pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td colspan=2 class=xl58 width=132 style='border-right:.5pt solid black;
  border-left:none;width:99pt'>T&#7892;NG C&#7896;NG A<br>
    <font class="font11">(Total A)</font></td>
  <td class=xl33 width=0>&nbsp;</td>
  <td class=xl34 ><%=Request["totalA"]%></td>
  <td class=xl25></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl60 width=126 style='border-right:.5pt solid black;
  border-left:none;width:95pt'>T&#7892;NG C&#7896;NG B<font class="font6"><br>
    </font><font class="font11">(Total B)</font></td>
  <td colspan=2 class=xl55 width=117 style='border-right:.5pt solid black;
  border-left:none;width:88pt'><%=Request["totalB"]%></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl27 colspan=6 style='mso-ignore:colspan'>C. PH&#7846;N QUY&#7870;T
  TOÁN (BALANCE)</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 colspan=3 class=xl25 style='height:24.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'>A&gt;B</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl31>A-B</td>
  <td class=xl35 colspan=5 style='border-right:.5pt solid black'  x:num><%=Request["Bal_A"]%></td>
  
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 colspan=3 class=xl25 style='height:24.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'>A&lt;=B</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>B-A</td>
  <td class=xl38 colspan=5 style='border-right:.5pt solid black'  x:num><%=Request["Bal_B"]%></td>
 
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=14 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl61 style='border-right:.5pt solid black;
  height:15.75pt'><%=l_colV_1%></td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  none'><%=l_colV_2%></td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  none'><%=l_colV_3%></td>
  <td colspan=2 class=xl64 style='border-right:.5pt solid black;border-left:
  none' ><%=l_colV_4%></td>
  <td colspan=3 class=xl61 style='border-right:.5pt solid black;border-left:
  none'><%=l_colV_5%></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl66 style='border-right:.5pt solid black;
  height:15.75pt'><%=l_colE_1%></td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black;border-left:
  none'><%=l_colE_2%></td>
  <td colspan=3 class=xl69 style='border-right:.5pt solid black;border-left:
  none'><%=l_colE_3%></td>
  <td colspan=2 class=xl69 style='border-right:.5pt solid black;border-left:
  none' ><%=l_colE_4%></td>
  <td colspan=3 class=xl66 style='border-right:.5pt solid black;border-left:
  none'><%=l_colE_5%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl41></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl41></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl41></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl44>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl76 style='border-left:none'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl44>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=0></td>
  <td width=124 style='width:93pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=0></td>
  <td width=115 style='width:86pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=85 style='width:64pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
