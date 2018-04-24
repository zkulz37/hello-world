<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Company_pk = Request["company_pk"];
    string p_Acc_pk = Request["acc_pk"];
    string p_Emp_pk = Request["emp_pk"];
    string p_Ccy = Request["CCy"];
    string p_From = Request["from_date"];
    string p_Status = Request["status"];
    //string p_From = Request["from_date"];
    string p_To = Request["to_date"];
    string p_tr_date_fr = "", p_tr_date_to = "";
    p_tr_date_fr = p_From ;
    p_tr_date_to = p_To ;
    double l_debit_begin = 0, l_credit_begin = 0;
    string l_parameter = "'" + p_Company_pk + "', ";
    l_parameter += "'" + p_Acc_pk + "', ";
    l_parameter += "'" + p_Emp_pk + "', ";
    l_parameter += "'" + p_Ccy + "', ";
    l_parameter += "'" + p_From + "', ";
    l_parameter += "'" + p_Status + "' ";   

    string p_company_name = "";
    string p_tax_code = "";
    string p_cmp_add = "";

    int j;
    int i;
    double l_tot_debit = 0, l_tot_credit = 0;
    string l_emp_id = "", l_emp_pk = "", SQL_Emp = "", l_department = "";
    DataTable dtEmp = new DataTable();
    
    
    string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_Company_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    p_company_name = dt2.Rows[0][0].ToString();
    p_tax_code = dt2.Rows[0][1].ToString();
    p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

    DataTable dt = new DataTable(); //ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00110_1", l_parameter);
    DataTable dt3 = new DataTable();

    p_From = (p_From.Substring(6, 2) + "/" + p_From.Substring(4, 2) + "/" + p_From.Substring(0, 4));
    p_To = (p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4));

    SQL =
    "SELECT  B.PK, B.EMP_ID, B.FULL_NAME,  N.OPEN_BAL,N.DR_SUM,N.CR_SUM, N.ACC_DR_SUM,N.ACC_CR_SUM,N.CLOSE_BAL, N.OPEN_FBAL " +
        "FROM " +
    "( " +
                "SELECT TAC_ABACCTCODE_PK,VHR_EMP_PK, SUM(OPEN_BAL) OPEN_BAL, " +
                " SUM(DR_SUM) DR_SUM, SUM(CR_SUM) CR_SUM, " +
                "(SUM(O_DR_SUM) + SUM(DR_SUM))  ACC_DR_SUM, (SUM(O_CR_SUM)+SUM(CR_SUM)) ACC_CR_SUM, " +
                " (SUM(OPEN_BAL) + (SUM(DR_SUM) - SUM(CR_SUM))*TO_NUMBER('1') )  CLOSE_BAL, " +
                            " SUM (OPEN_FBAL) OPEN_FBAL  " +
                "FROM " +
                "( " +
                "SELECT M.TAC_ABACCTCODE_PK,M.VHR_EMP_PK , " +
                        "(SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0)))*TO_NUMBER('1')  OPEN_BAL, " +
                        " SUM(NVL(M.THIS_DRAMT,0)) O_DR_SUM,SUM(NVL(M.THIS_CRAMT,0)) O_CR_SUM,  " +
                        "0 DR_SUM, 0 CR_SUM, " +
                        "(SUM (NVL (M.THIS_DRFAMT, 0)) " +
                              "- SUM (NVL (M.THIS_CRFAMT, 0))) " +
                             " * TO_NUMBER ('1') OPEN_FBAL " +
                    "FROM TAC_HGEMPMMBAL M " +
                        " WHERE M.DEL_IF =0  " +
                        "AND M.TCO_COMPANY_PK = '" + p_Company_pk + "' " +
                        " AND M.TR_STATUS = '" + p_Status + "' " +
                        " AND DECODE('" + p_Acc_pk + "','',1,M.TAC_ABACCTCODE_PK) = DECODE('" + p_Acc_pk + "','',1,'" + p_Acc_pk + "') " +
                        " AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + p_tr_date_fr + "','" + p_Company_pk + "') " +
                        " AND DECODE('" + p_Emp_pk + "','',1,M.VHR_EMP_PK) = DECODE('" + p_Emp_pk + "','',1,'" + p_Emp_pk + "') " +
                    " GROUP BY M.TAC_ABACCTCODE_PK,M.VHR_EMP_PK " +
                " UNION ALL " +
                " SELECT D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK, " +
                        "(SUM(NVL(D.YMD_DRBOOKS,0))-SUM(NVL(D.YMD_CRBOOKS,0)))*TO_NUMBER('1')  OPEN_BAL, " +
                        " SUM(NVL(D.YMD_DRBOOKS,0)) O_DR_SUM, SUM(NVL(D.YMD_CRBOOKS,0)) O_CR_SUM, " +
                        " 0 DR_SUM, 0 CR_SUM, " +
                             " (SUM (NVL (D.YMD_DRTRANS, 0)) " +
                              " - SUM (NVL (D.YMD_CRTRANS, 0))) " +
                             " * TO_NUMBER ('1') " +
                                " OPEN_FBAL " +
                        "FROM TAC_HGEMPDDBAL D " +
                        " WHERE D.DEL_IF =0 " +
                         " AND D.TCO_COMPANY_PK = '" + p_Company_pk + "' " +
                         " AND D.TR_STATUS = '" + p_Status + "' " +
                         " AND DECODE('" + p_Acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + p_Acc_pk + "','',1,'" + p_Acc_pk + "') " +
                         " AND DECODE('" + p_Emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + p_Emp_pk + "','',1,'" + p_Emp_pk + "') " +
                         "AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + p_tr_date_fr + "','" + p_Company_pk + "'),'YYYYMMDD'),+1),'YYYYMMDD')" +
                         " AND D.STD_YMD < '" + p_tr_date_fr + "' " +
                         " GROUP BY D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK " +
                " UNION ALL " +
                "SELECT D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK, " +
                        "0 OPEN_BAL,0 O_DR_SUM, 0 O_CR_SUM,SUM(NVL(D.YMD_DRBOOKS,0)) DR_SUM,SUM(NVL(D.YMD_CRBOOKS,0)) CR_SUM, 0 OPEN_FBAL " +
                        " FROM TAC_HGEMPDDBAL D " +
                        " WHERE D.DEL_IF =0 " +
                         " AND D.TCO_COMPANY_PK = '" + p_Company_pk + "' " +
                         " AND D.TR_STATUS = '" + p_Status + "' " +
                         "AND DECODE('" + p_Acc_pk + "','',1,D.TAC_ABACCTCODE_PK) = DECODE('" + p_Acc_pk + "','',1,'" + p_Acc_pk + "') " +
                         "AND DECODE('" + p_Emp_pk + "','',1,D.VHR_EMP_PK) = DECODE('" + p_Emp_pk + "','',1,'" + p_Emp_pk + "') " +
                         " AND D.STD_YMD BETWEEN '" + p_tr_date_fr + "' AND '" + p_tr_date_to + "' " +
                         " GROUP BY D.TAC_ABACCTCODE_PK,D.VHR_EMP_PK " +
                " ) " +
                " GROUP BY TAC_ABACCTCODE_PK, VHR_EMP_PK) N, TAC_EMPLOYEE_ADV B " +
                 " WHERE N.VHR_EMP_PK = B.PK " +
      "ORDER BY EMP_ID,TAC_ABACCTCODE_PK     ";
    DataTable dtList = new DataTable();
    dtList = ESysLib.TableReadOpen(SQL);
    if (dtList.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }                        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00110_sochitietTU_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00110_sochitietTU_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00110_sochitietTU_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-08-26T08:34:24Z</o:LastPrinted>
  <o:Created>2006-10-29T04:26:21Z</o:Created>
  <o:LastSaved>2010-08-31T02:55:51Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in 0in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
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
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	color:black;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl32
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
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
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
	white-space:normal;}
.xl35
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
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
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
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl50
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
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl55
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
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl62
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
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
	white-space:normal;}
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
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
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Mẫu số  04TT</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
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
        int irow = 0;
        double l_begin_amt = 0;
        for (int k = 0; k < dtList.Rows.Count; k++)
        {        
            l_emp_pk = dtList.Rows[k][0].ToString();
            l_begin_amt = double.Parse(dtList.Rows[k][3].ToString());
         SQL_Emp = "select e.emp_id || ' ' || e.full_name full_name, g.org_nm from hr.thr_employee e, comm.tco_org g where e.pk like " + l_emp_pk + " and e.del_if = 0 and e.tco_org_pk = g.pk(+) ";
         dtEmp = ESysLib.TableReadOpen(SQL_Emp);
         
        SQL = "        SELECT   1 " +
        "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
        "        WHERE H.DEL_IF= 0 " +
        "        AND D.DEL_IF = 0 " +
        "        AND A.DEL_IF = 0 " +
        "        AND D.DRCR_TYPE = 'D' " +
        "        AND R.DEL_IF = 0 " +
        "        AND D.PK = R.TAC_HGTRD_PK " +
        "        AND H.PK = D.TAC_HGTRH_PK " +
        "        AND D.PK = I.TAC_HGTRD_PK " +
        "        AND I.TAC_ABACCTITEM_PK = A.PK " +
        "        AND (('" + p_Acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + p_Acc_pk + "')) " +
        "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
        "        AND H.TR_STATUS IN ('" + p_Status + "',DECODE('" + p_Status + "',2,0,'" + p_Status + "'),DECODE('" + p_Status + "',2,4,'" + p_Status + "'))  " +
        "        AND H.TCO_COMPANY_PK ='" + p_Company_pk + "' " +
        "        AND I.ITEM_TABLE_PK = '" + l_emp_pk + "' " +
        "        AND DECODE('" + p_Ccy + "','ALL','1',D.CCY) = DECODE('" + p_Ccy + "','ALL','1','" + p_Ccy + "')  " +
        "        AND H.TR_DATE BETWEEN TO_DATE('" + p_tr_date_fr + "','YYYYMMDD') AND TO_DATE('" + p_tr_date_to + "','YYYYMMDD') " +
        "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
         dt = ESysLib.TableReadOpen(SQL);
         
        
         SQL = "        SELECT   1 " +                
                "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
                "        WHERE H.DEL_IF= 0 " +
                "        AND D.DEL_IF = 0 " +
                "        AND A.DEL_IF = 0 " +
                "        AND D.DRCR_TYPE = 'C' " +
                "        AND H.PK = D.TAC_HGTRH_PK " +
                "        AND D.PK = I.TAC_HGTRD_PK " +
                "        AND I.TAC_ABACCTITEM_PK = A.PK " +
                "        AND (('" + p_Acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + p_Acc_pk + "')) " +
                "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
      "        AND H.TR_STATUS IN ('" + p_Status + "',DECODE('" + p_Status + "',2,0,'" + p_Status + "'),DECODE('" + p_Status + "',2,4,'" + p_Status + "'))  " +
                "        AND H.TCO_COMPANY_PK ='" + p_Company_pk + "' " +
                "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
                "        AND DECODE('" + p_Ccy + "','ALL','1',D.CCY) = DECODE('" + p_Ccy + "','ALL','1','" + p_Ccy + "')  " +
                "        AND H.TR_DATE BETWEEN TO_DATE('" + p_tr_date_fr + "','YYYYMMDD') AND TO_DATE('" + p_tr_date_to + "','YYYYMMDD') " +
                "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
         dt3 = ESysLib.TableReadOpen(SQL);
         if(dt.Rows.Count + dt3.Rows.Count > 0 || l_begin_amt != 0)
         {
          irow += 19 + dt.Rows.Count ;
          irow += dt3.Rows.Count ;
          }
            
            %>
            
            <x:RowBreak>
                <x:Row><%=irow %></x:Row>
            </x:RowBreak>
            <%    
               
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
    
    
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9255</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Mẫu số  04TT'!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=799 style='border-collapse:
 collapse;table-layout:fixed;width:600pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=250 style='mso-width-source:userset;mso-width-alt:9142;
 width:188pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <%
     
     for (j = 0; j < dtList.Rows.Count; j++)
     {
         l_emp_pk = dtList.Rows[j][0].ToString(); // employee pk
         SQL_Emp = "select e.emp_id || ' ' || e.full_name full_name, g.org_nm from TAC_EMPLOYEE_ADV e, comm.tco_org g where e.pk like " + l_emp_pk + " and e.tco_org_pk = g.pk(+) ";
         dtEmp = ESysLib.TableReadOpen(SQL_Emp);
         if (dtEmp.Rows.Count > 0)
         {
             l_emp_id = dtEmp.Rows[0][0].ToString();
             l_department = dtEmp.Rows[0][1].ToString();
         }
         l_tot_debit = 0;
         l_tot_credit = 0;
         l_debit_begin = double.Parse(dtList.Rows[j][3].ToString());
         l_credit_begin = 0;
         
         SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),D.REMARK,D.REMARK2,SF_A_GET_ACCD(DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),'" + p_Company_pk + "')," +
                "        TO_CHAR(DECODE(D.DRCR_TYPE,'D',R.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(D.DRCR_TYPE,'C',R.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(R.TR_BOOKAMT,'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
                "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
                "        WHERE H.DEL_IF= 0 " +
                "        AND D.DEL_IF = 0 " +
                "        AND A.DEL_IF = 0 " +
                "        AND D.DRCR_TYPE = 'D' " +
                "        AND R.DEL_IF = 0 " +
                "        AND D.PK = R.TAC_HGTRD_PK " +
                "        AND H.PK = D.TAC_HGTRH_PK " +
                "        AND D.PK = I.TAC_HGTRD_PK " +
                "        AND I.TAC_ABACCTITEM_PK = A.PK " +
                "        AND (('" + p_Acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + p_Acc_pk + "')) " +
                "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
                "        AND H.TR_STATUS IN ('" + p_Status + "',DECODE('" + p_Status + "',2,0,'" + p_Status + "'),DECODE('" + p_Status + "',2,4,'" + p_Status + "'))  " +
                "        AND H.TCO_COMPANY_PK ='" + p_Company_pk + "' " +
                "        AND I.ITEM_TABLE_PK = '" + l_emp_pk + "' " +
                "        AND DECODE('" + p_Ccy + "','ALL','1',D.CCY) = DECODE('" + p_Ccy + "','ALL','1','" + p_Ccy + "')  " +
                "        AND H.TR_DATE BETWEEN TO_DATE('" + p_tr_date_fr + "','YYYYMMDD') AND TO_DATE('" + p_tr_date_to + "','YYYYMMDD') " +
                "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
         dt = ESysLib.TableReadOpen(SQL);

         /*SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),D.REMARK,D.REMARK2,''," +
                "        TO_CHAR(DECODE(D.DRCR_TYPE,'D',D.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(D.DRCR_TYPE,'C',D.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(D.TR_BOOKAMT,'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
                "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
                "        WHERE H.DEL_IF= 0 " +
                "        AND D.DEL_IF = 0 " +
                "        AND A.DEL_IF = 0 " +
                "        AND D.DRCR_TYPE = 'C' " +
                "        AND H.PK = D.TAC_HGTRH_PK " +
                "        AND D.PK = I.TAC_HGTRD_PK " +
                "        AND I.TAC_ABACCTITEM_PK = A.PK " +
                "        AND (('" + p_Acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + p_Acc_pk + "')) " +
                "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
      "        AND H.TR_STATUS IN ('" + p_Status + "',DECODE('" + p_Status + "',2,0,'" + p_Status + "'),DECODE('" + p_Status + "',2,4,'" + p_Status + "'))  " +
                "        AND H.TCO_COMPANY_PK ='" + p_Company_pk + "' " +
                "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
                "        AND DECODE('" + p_Ccy + "','ALL','1',D.CCY) = DECODE('" + p_Ccy + "','ALL','1','" + p_Ccy + "')  " +
                "        AND H.TR_DATE BETWEEN TO_DATE('" + p_tr_date_fr + "','YYYYMMDD') AND TO_DATE('" + p_tr_date_to + "','YYYYMMDD') " +
                "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
          */
         SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),D.REMARK,D.REMARK2,SF_A_GET_ACCD(DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),'" + p_Company_pk + "')," +
                "        TO_CHAR(DECODE(D.DRCR_TYPE,'D',R.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(D.DRCR_TYPE,'C',R.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(R.TR_BOOKAMT,'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
                "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
                "        WHERE H.DEL_IF= 0 " +
                "        AND D.DEL_IF = 0 " +
                "        AND A.DEL_IF = 0 " +
                "        AND D.DRCR_TYPE = 'C' " +
                "        AND R.DEL_IF = 0 " +
                "        AND D.PK = R.TAC_HGTRD_PK " +
                "        AND H.PK = D.TAC_HGTRH_PK " +
                "        AND D.PK = I.TAC_HGTRD_PK " +
                "        AND I.TAC_ABACCTITEM_PK = A.PK " +
                "        AND (('" + p_Acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + p_Acc_pk + "')) " +
                "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
                "        AND H.TR_STATUS IN ('" + p_Status + "',DECODE('" + p_Status + "',2,0,'" + p_Status + "'),DECODE('" + p_Status + "',2,4,'" + p_Status + "'))  " +
                "        AND H.TCO_COMPANY_PK ='" + p_Company_pk + "' " +
                "        AND I.ITEM_TABLE_PK = '" + l_emp_pk + "' " +
                "        AND DECODE('" + p_Ccy + "','ALL','1',D.CCY) = DECODE('" + p_Ccy + "','ALL','1','" + p_Ccy + "')  " +
                "        AND H.TR_DATE BETWEEN TO_DATE('" + p_tr_date_fr + "','YYYYMMDD') AND TO_DATE('" + p_tr_date_to + "','YYYYMMDD') " +
                "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
          
         dt3 = ESysLib.TableReadOpen(SQL);
         if (dt.Rows.Count + dt3.Rows.Count > 0 || l_debit_begin != 0)
         {               
 %>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl48 width=525 style='height:15.75pt;
  width:394pt'><%=p_company_name%></td>
  <td colspan=3 class=xl70 width=274 style='width:206pt'>Mẫu số: 04-TT</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl71 width=525 style='height:15.75pt;
  width:394pt'><%=p_cmp_add%></td>
  <td colspan=3 class=xl46
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl48 style='height:15.75pt'>Mã số thuế: <%=p_tax_code%></td>
  <td colspan=3 class=xl46>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl48 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl46 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=7 height=27 class=xl68 width=799 style='height:20.25pt;
  width:600pt'>SỔ CHI TIẾT TẠM ỨNG NHÂN VIÊN</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=7 height=20 class=xl69 style='height:15.0pt'>Từ ngày <%=p_From%>
  đến ngày <%=p_To%> &nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=7 height=20 class=xl26 width=799 style='height:15.0pt;width:600pt'>Họ  tên người thanh toán/Employee Name :<font class="font9"><%=l_emp_id%></font></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl25 width=172 style='height:15.0pt;width:129pt'>Bộ  phận (hoặc địa chỉ) :</td>
  <td class=xl25 width=250 style='width:188pt'><%=l_department%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl26 width=422 style='height:15.0pt;width:317pt'>Số  tiền tạm ứng được thanh toán theo bảng dưới đây:</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl62 style='border-right:.5pt solid black;
  height:15.0pt'>Chứng từ/ Voucher</td>
  <td rowspan=2 class=xl64 width=250 style='border-bottom:.5pt solid black;
  width:188pt'>Diễn giải</td>
  <td rowspan=2 class=xl65 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>Số hiệu TK đối ứng</td>
  <td colspan=2 class=xl67 width=213 style='border-left:none;width:160pt'>Số
  tiền</td>
  <td rowspan=2 class=xl64 width=61 style='border-bottom:.5pt solid black;
  width:46pt'>Ghi chú</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Số/ No</td>
  <td class=xl30>Ngày/ Date</td>
  <td class=xl31 width=110 style='width:83pt'>Nợ</td>
  <td class=xl31 width=103 style='width:77pt'>Có</td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 width=100 style='height:15.75pt;width:75pt'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl50 width=250 style='width:188pt'>SỐ DƯ ĐẦU KỲ</td>
  <td class=xl35 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl36 x:num><%=l_debit_begin%> </td>
  <td class=xl72 width=103 style='width:77pt' x:num><%=l_credit_begin%>  </td>
  <td class=xl34 width=61 style='border-top:none;width:46pt'>&nbsp;</td>
 </tr>
 <%     
     for (i = 0; i < dt.Rows.Count; i++)
     {
         l_tot_debit += double.Parse(dt.Rows[i][5].ToString());
         l_tot_credit += double.Parse(dt.Rows[i][6].ToString());
  %>
 <tr class=xl25 height=40 style='height:30.0pt'>
  <td height=40 class=xl37 style='height:30.0pt'><%=dt.Rows[i][0]%></td>
  <td class=xl38><%=dt.Rows[i][1]%></td>
  <td class=xl53 width=250 style='width:188pt'><%=dt.Rows[i][3]%></td>
  <td class=xl49><%=dt.Rows[i][4]%></td>
  <td class=xl39 x:num><%=dt.Rows[i][5]%></td>
  <td class=xl39 x:num><%=dt.Rows[i][6]%></td>
  <td class=xl60 x:num><%=dt.Rows[i][8]%></td>
 </tr> 
 <%} %>
 <%     
     for (i = 0; i < dt3.Rows.Count; i++)
     {
         l_tot_debit += double.Parse(dt3.Rows[i][5].ToString());
         l_tot_credit += double.Parse(dt3.Rows[i][6].ToString());
  %>
 <tr class=xl25 height=40 style='height:30.0pt'>
  <td height=40 class=xl37 style='height:30.0pt'><%=dt3.Rows[i][0]%></td>
  <td class=xl38><%=dt3.Rows[i][1]%></td>
  <td class=xl53 width=250 style='width:188pt'><%=dt3.Rows[i][3]%></td>
  <td class=xl49><%=dt3.Rows[i][4]%></td>
  <td class=xl39 x:num><%=dt3.Rows[i][5]%></td>
  <td class=xl39 x:num><%=dt3.Rows[i][6]%></td>
  <td class=xl60 x:num><%=dt3.Rows[i][8]%></td>
 </tr> 
 <%} %>
 
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl57 style='border-left:none' x:str>Tổng cộng số phát sinh</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl56 x:num><%=l_tot_debit%> </td>
  <td class=xl56 x:num><%=l_tot_credit%> </td>
  <td class=xl47 width=61 style='width:46pt'>&nbsp;</td>
 </tr>
 <% 
     l_debit_begin += l_tot_debit ;
     //l_credit_begin += l_tot_credit;    
     l_debit_begin = l_debit_begin - l_tot_credit;                
 %>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl40 width=100 style='height:15.75pt;width:75pt'>&nbsp;</td>
  <td class=xl41 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl55 width=250 style='border-top:none;width:188pt'>SỐ DƯ CUỐI KỲ</td>
  <td class=xl42 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl36 x:num><%=l_debit_begin%> </td>
  <td class=xl43 x:num>&nbsp;</td>
  <td class=xl44 width=61 style='width:46pt'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl61>Ngày ........ tháng ........ năm ...........</td>
 </tr>
 <tr class=xl27 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl58 style='height:14.25pt'>Người ghi sổ</td>
  <td class=xl27></td>
  <td class=xl28 width=250 style='width:188pt'>Kế toán trưởng</td>
  <td class=xl28></td>
  <td colspan=3 class=xl28 width=274 style='width:206pt'>Tổng Giám đốc</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl59 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>( Ký, họ tên)</td>
  <td class=xl24></td>
  <td class=xl45 width=250 style='width:188pt'>(Ký, họ tên)</td>
  <td class=xl45></td>
  <td colspan=3 class=xl45 width=274 style='width:206pt'>(Ký, họ tên)</td>
 </tr>
 <%
     }            
     }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
