<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>f
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_company, p_work_mon, p_cost_center, p_cost_group, p_cost_type, p_dept, p_apkind,p_sal_code;
    
    p_company = Request["p_1"].ToString();
    p_work_mon = Request["p_2"].ToString();
    p_cost_center = Request["p_3"].ToString();
    p_cost_group = Request["p_4"].ToString();
    p_cost_type = Request["p_5"].ToString();
    p_dept = Request["p_6"].ToString();
    p_apkind = Request["p_7"].ToString();
    p_sal_code = Request["p_8"].ToString();
    
    
    string SQL
	= "SELECT  (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0092' AND V.CODE=A.GRP_COST) " + 
        " ,(SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0093' AND V.CODE=A.TYPE_COST)" +
        " ,C.TAC_PMHRCODE||' '||C.ITEM_NM ITEM,B.CCY,B.TR_RATE, " + 
        "                ROUND(SUM(NVL(B.TR_AMT,0)),3) AS T1 " +
        "                ,ROUND(SUM(NVL(B.BK_AMT,0)),3) AS T2 " +
        "                , (SELECT  NVL(A.AC_CD,NULL) FROM TAC_ABACCTCODE A  WHERE A.DEL_IF = 0 AND A.PK = C.TAC_ABACCTCODE_PK_DR ) DEBIT_CD " +
        "                , (SELECT  NVL(A.AC_CD,NULL) FROM TAC_ABACCTCODE A  WHERE A.DEL_IF = 0 AND A.PK = C.TAC_ABACCTCODE_PK_CR ) DEBIT_CD " +
         "                , TO_CHAR(TO_DATE(A.STD_YM,'YYYYMM'),'MM/YYYY') " +
        "        FROM TAC_PMSAL_EMP A,TAC_PMSAL_EMPTRD B,TAC_PMCOSTTYPE C, THR_EMPLOYEE EM " +
        "        WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND EM.DEL_IF = 0  " +
        "            AND EM.PK = A.VHR_EMP_PK " +
        "            AND A.PK=B.TAC_PMSAL_EMPTR_PK  " +
        "            AND C.PK=B.TAC_PMCOSTTYPE_PK " +
        "            AND A.STD_YM = '" + p_work_mon + "' " +
        "            AND A.TCO_COMPANY_PK = DECODE('" + p_company + "','ALL', A.TCO_COMPANY_PK, '" + p_company + "') " +
        "            AND (   EM.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + p_dept + "','ALL', 0,'" + p_dept + "') " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + p_dept + "' = 'ALL' " +
        "                ) " +
        "            AND A.GRP_COST = DECODE('" + p_cost_group + "','ALL', A.GRP_COST, '" + p_cost_group + "') " +
        "            AND A.TYPE_COST = DECODE('" + p_cost_type + "','ALL', A.TYPE_COST, '" + p_cost_type + "') " +
        "            AND A.TAC_ABPL_PK = DECODE('" + p_cost_center + "','ALL', A.TAC_ABPL_PK, '" + p_cost_center + "') " +
        "            AND A.AP_TYPE=C.AP_TYPE " +
        "            AND C.AP_TYPE=(CASE WHEN '" + p_apkind + "'='ALL' THEN C.AP_TYPE ELSE '" + p_apkind + "' END) " +
        " AND C.TAC_PMHRCODE=(CASE WHEN '" + p_sal_code + "'='ALL' THEN C.TAC_PMHRCODE ELSE '" + p_sal_code + "' END) "+
        "        GROUP BY A.GRP_COST,A.TYPE_COST,C.TAC_PMHRCODE||' '||C.ITEM_NM, C.PK,B.CCY,B.TR_RATE,C.TAC_ABACCTCODE_PK_DR,C.TAC_ABACCTCODE_PK_CR,NVL(C.SEQ,0),A.STD_YM " +
        "        ORDER BY A.GRP_COST,A.TYPE_COST,NVL(C.SEQ,0) ";
	

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow, icol_emp;
    irow = dt_total.Rows.Count;
    icol_emp = dt_total.Columns.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
   
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_payroll_make_slip_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_payroll_make_slip_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_payroll_make_slip_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>htruong</o:Author>
  <o:LastAuthor>htruong</o:LastAuthor>
  <o:Created>2009-09-15T02:07:35Z</o:Created>
  <o:LastSaved>2009-09-15T04:14:09Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9855</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2552 style='border-collapse:
 collapse;table-layout:fixed;width:1918pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=132 style='mso-width-source:userset;mso-width-alt:6827;
 width:99pt'>
 <col class=xl25 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl25 width=77 style='mso-width-source:userset;mso-width-alt:10000;
 width:58pt'>
 <col class=xl25 width=258 style='mso-width-source:userset;mso-width-alt:3000;
 width:194pt'>
 <col class=xl25 width=82 span=3 style='mso-width-source:userset;mso-width-alt:
 4000;width:62pt'>
 <col class=xl25 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl25 width=82  style='mso-width-source:userset;mso-width-alt:
 4000;width:62pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=11 height=39 class=xl27 width=2552 style='height:29.25pt;
  width:1918pt' x:str="PAYROLL MAKE SLIP ">PAYROLL MAKE SLIP<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=11 height=39 class=xl28 style='height:29.25pt'>MONTH: <%=dt_total.Rows[0][9].ToString()%></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=4 height=39 class=xl24 style='height:29.25pt'>&nbsp;</td>
  <td colspan=20 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td height=78 class=xl26 style='height:58.5pt;border-top:none'>No</td>
  <td class=xl26 style='border-top:none;border-left:none'>Cost Group</td>
  <td class=xl26 style='border-top:none;border-left:none'>Cost Type</td>
  <td class=xl26 style='border-top:none;border-left:none'>Item</td>
  <td class=xl26 style='border-left:none'>Currency</td>
  <td class=xl26 style='border-left:none' >Transaction Rate</td>
  <td class=xl26 style='border-left:none'>Transaction Amount</td>
  <td class=xl26 style='border-left:none'>Booking Amount</td>
  <td class=xl26 style='border-left:none'>Debit Account</td>
  <td class=xl26 style='border-left:none'>Credit Account</td>
 </tr>
 <% 
     double[] Total = new double[2];
     string s_format;
     for (int j = 0; j < 2; j++)
     {
         Total[j] = 0;
     }
     
     for (int i = 0; i < irow; i++) 
    {
        Total[0] += Double.Parse(dt_total.Rows[i][5].ToString());
        Total[1] += Double.Parse(dt_total.Rows[i][6].ToString());  
        
    %> 
 <tr class=xl31 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl29 style='height:28.5pt;border-top:none' x:num><%=i+1%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][0].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][6].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' ><%=dt_total.Rows[i][7].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' ><%=dt_total.Rows[i][8].ToString()%></td>
 </tr>
 <%
    }
  %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=6 height=38 class=xl33 style='border-right:.5pt solid black;
  height:28.5pt'>Total</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[0]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[1]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>&nbsp;</td>
 
 
  
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=24 class=xl25 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=24 class=xl25 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=258 style='width:194pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=106 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
