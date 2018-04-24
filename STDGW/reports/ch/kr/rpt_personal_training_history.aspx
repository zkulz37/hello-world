<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

   string p_tco_org_pk        = Request["p_tco_org_pk"].ToString();
   string p_wg_pk              = Request["p_wg_pk"].ToString();
   string p_position           = Request["p_position"].ToString();
   string p_nation           = Request["p_nation"].ToString();
   string p_status             = Request["p_status"].ToString();
   string p_from_join_dt            = Request["p_from_join_dt"].ToString();
   string p_to_join_dt           = Request["p_to_join_dt"].ToString();
   string p_search_by          = Request["p_search_by"].ToString();
   string p_search_temp        = Request["p_search_temp"].ToString();
   string p_from_start_dt         = Request["p_from_start_dt"].ToString();
   string p_to_start_dt           = Request["p_to_start_dt"].ToString();
   string p_from_end_dt           = Request["p_from_end_dt"].ToString();
   string p_to_end_dt             = Request["p_to_end_dt"].ToString();

   string SQL
    = "SELECT  0 " +
        "            , B.ORG_NM " +
        "            , A.EMP_ID " +
        "            , A.FULL_NAME " +
        "            , C.WORKGROUP_NM " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.POS_TYPE ) AS POSITION " +
        "            , TO_CHAR(TO_DATE(A.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS JOIN_DT " +
        "            , D.TRAIN_NAME " +
        "            , TO_CHAR(TO_DATE(D.START_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS START_DT " +
        "            , TO_CHAR(TO_DATE(D.END_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS END_DT " +
        "            , D.LOCATION " +
        "            , D.INSTITUDE " +
        "            , DECODE(D.PASS_YN,'Y', 'Yes', 'N', 'No', '') AS PASS_YN " +
        "            , 'Internal' " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0011' AND V.CODE= A.EDU_TYPE ) AS EDUCATION " +
        "           FROM THR_EMPLOYEE A, COMM.TCO_ORG B, THR_WORK_GROUP C, THR_TRAIN_INTERNAL D " +
        "          WHERE A.DEL_IF = 0 " +
        "            AND B.DEL_IF = 0 " +
        "            AND C.DEL_IF = 0 " +
        "            AND D.DEL_IF = 0 " +
        "            AND A.TCO_ORG_PK = B.PK " +
        "            AND A.THR_WG_PK = C.PK " +
        "            AND  D.THR_EMP_PK = A.PK " +
        "            AND A.THR_WG_PK = DECODE('" + p_wg_pk + "','ALL', A.THR_WG_PK, '" + p_wg_pk + "') " +
   "            AND A.NATION = DECODE('" + p_nation + "','ALL', A.NATION, '" + p_nation + "') " +
   "            AND UPPER (DECODE ('" + p_search_by + "', " +
   "                              1, A.FULL_NAME, " +
   "                              2, A.EMP_ID, " +
   "                              3,A.ID_NUM, " +
   "                              4,PERSON_ID, " +
   "                              OLD_ID) " +
   "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
   "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', A.STATUS) = '" + p_status + "' " +
   "            AND (   A.TCO_ORG_PK IN ( " +
   "                              SELECT     G.PK " +
   "                                    FROM COMM.TCO_ORG G " +
   "                                   WHERE G.DEL_IF = 0 " +
   "                              START WITH G.PK = " +
   "                                            DECODE ('" + p_tco_org_pk + "', " +
   "                                                    'ALL', 0, " +
   "                                                    '" + p_tco_org_pk + "' " +
   "                                                   ) " +
   "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
   "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
   "            AND ((A.JOIN_DT BETWEEN '" + p_from_join_dt + "' AND '" + p_to_join_dt + "') OR ('" + p_from_join_dt + "' IS NULL) OR ('" + p_to_join_dt + "' IS NULL)) " +
   "            AND ((D.START_DT BETWEEN '" + p_from_start_dt + "' AND '" + p_to_start_dt + "') OR ('" + p_from_start_dt + "' IS NULL) OR ('" + p_to_start_dt + "' IS NULL)) " +
   "            AND ((D.END_DT BETWEEN '" + p_from_end_dt + "' AND '" + p_to_end_dt + "') OR ('" + p_from_end_dt + "' IS NULL) OR ('" + p_to_end_dt + "' IS NULL)) " +
        " UNION ALL " +
        " SELECT  0  " +
        "            , B.ORG_NM " +
        "            , A.EMP_ID, A.FULL_NAME " +
        "            , C.WORKGROUP_NM " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0008' AND V.CODE= A.POS_TYPE ) AS POSITION " +
        "            , TO_CHAR(TO_DATE(A.JOIN_DT, 'YYYYMMDD'),'DD/MM/YYYY') JOIN_DT " +
        "            , Q.COURSE_ID||'-'||Q.COURSE_NAME AS TRAIN_NAME " +
        "            , TO_CHAR(TO_DATE(Q.START_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS START_DT " +
        "            , TO_CHAR(TO_DATE(Q.END_DT, 'YYYYMMDD'),'DD/MM/YYYY') AS END_DT " +
        "            , Q.LOCATION " +
        "            , Q.TRAIN_INSTITUTION AS INTITUTION " +
        "            , DECODE(D.PASS_YN,'Y', 'Yes', 'N', 'No', '') PASS_YN " +
        "            , 'Company' " +
        "            , (SELECT V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0011' AND V.CODE= A.EDU_TYPE ) AS EDUCATION " +
        "           FROM THR_EMPLOYEE A, COMM.TCO_ORG B, THR_WORK_GROUP C, THR_TRAIN_REQD D, THR_TRAIN_REQ R, THR_TRAIN_COURSE Q " +
        "          WHERE A.DEL_IF = 0 AND R.DEL_IF=0 AND Q.DEL_IF=0 " +
        "            AND B.DEL_IF = 0 " +
        "            AND C.DEL_IF = 0 " +
        "            AND D.DEL_IF = 0 " +
        "            AND D.THR_TRAIN_REQ_PK = R.PK " +
        "            AND R.THR_TRAIN_COURSE_PK = Q.PK " +
        "            AND A.TCO_ORG_PK = B.PK " +
        "            AND A.THR_WG_PK = C.PK " +
        "            AND  D.TRAINEE_PK = A.PK " +
        "            AND D.PASS_YN IS NOT NULL " +
        "            AND A.THR_WG_PK = DECODE('" + p_wg_pk + "','ALL', A.THR_WG_PK, '" + p_wg_pk + "') " +
   "            AND A.NATION = DECODE('" + p_nation + "','ALL', A.NATION, '" + p_nation + "') " +
   "            AND UPPER (DECODE ('" + p_search_by + "', " +
   "                              1, A.FULL_NAME, " +
   "                              2, A.EMP_ID, " +
   "                              3,A.ID_NUM, " +
   "                              4,PERSON_ID, " +
   "                              OLD_ID) " +
   "                     ) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
   "            AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', A.STATUS) = '" + p_status + "' " +
   "            AND (   A.TCO_ORG_PK IN ( " +
   "                              SELECT     G.PK " +
   "                                    FROM COMM.TCO_ORG G " +
   "                                   WHERE G.DEL_IF = 0 " +
   "                              START WITH G.PK = " +
   "                                            DECODE ('" + p_tco_org_pk + "', " +
   "                                                    'ALL', 0, " +
   "                                                    '" + p_tco_org_pk + "' " +
   "                                                   ) " +
   "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
   "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
   "            AND ((A.JOIN_DT BETWEEN '" + p_from_join_dt + "' AND '" + p_to_join_dt + "') OR ('" + p_from_join_dt + "' IS NULL) OR ('" + p_to_join_dt + "' IS NULL)) " +
   "            AND ((Q.START_DT BETWEEN '" + p_from_start_dt + "' AND '" + p_to_start_dt + "') OR ('" + p_from_start_dt + "' IS NULL) OR ('" + p_to_start_dt + "' IS NULL)) " +
   "            AND ((Q.END_DT BETWEEN '" + p_from_end_dt + "' AND '" + p_to_end_dt + "') OR ('" + p_from_end_dt + "' IS NULL) OR ('" + p_to_end_dt + "' IS NULL)) " +
        "        order by  3,14 desc ";



	//Response.Write(SQL);
      //  Response.End();

    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }


    //-----------------information of company-----------------
    string SQL_Com
    = "select  a.TCO_BPPHOTO_PK,a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,A.FAX_no, to_char(sysdate, 'dd/mm/yyyy') " +
        "from comm.tco_company a " +
        "where a.DEL_IF=0 and rownum=1 ";
       


    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }

    string cur_grp, next_grp;
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_personal_training_history_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_personal_training_history_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_personal_training_history_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-15T04:08:58Z</o:LastPrinted>
  <o:Created>2011-09-15T04:06:45Z</o:Created>
  <o:LastSaved>2011-09-15T04:09:15Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .25in 1.0in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font9
	{color:windowtext;
	font-size:11.0pt;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2889</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int row=10; // số dòng tiêu đề
        
        for (int k=0;k<irow;k++)
        {
            row+=1;    
            cur_grp=dt_total.Rows[k][2].ToString() ;
            if (k<irow -1)
            {
                
                next_grp=dt_total.Rows[k+1][2].ToString();
                if (cur_grp!=next_grp)
                {   row+=1;
                
                %>
                    <x:RowBreak>
                        <x:Row><%=row %></x:Row>
                    </x:RowBreak>
                    
                <%
                    row+= 10;  //cộng lại với số dòng của tiêu đề lần 2 sau khi page break lần trước
                }
                
            }    
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>8475</x:WindowHeight>
  <x:WindowWidth>19875</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2644 style='border-collapse:
 collapse;table-layout:fixed;width:1978pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl24 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl24 width=256 style='mso-width-source:userset;mso-width-alt:9362;
 width:192pt'>
 <col class=xl24 width=167 style='mso-width-source:userset;mso-width-alt:6107;
 width:125pt'>
 <col class=xl24 width=168 style='mso-width-source:userset;mso-width-alt:6144;
 width:126pt'>
 <col class=xl24 width=189 style='mso-width-source:userset;mso-width-alt:6912;
 width:142pt'>
 <col class=xl24 width=79 span=21 style='width:59pt'>
 <% 
    int total = 0;
     Boolean flag = true;
     Boolean flag_1 = false;
     string emp_type_old="";string emp_type_new="";
     for (int i = 0; i < irow; i++)
     {
         total++;
         emp_type_old = dt_total.Rows[i][2].ToString();

         if (flag)
         {

 %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 width=24 style='height:20.1pt;width:18pt'></td>
  <td colspan=5 class=xl32 width=961 style='width:721pt'>LÝ L&#7882;CH &#272;ÀO
  T&#7840;O CÁ NHÂN</td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=5 class=xl25>Personal training history card</td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>1. THÔNG TIN CÁ NHÂN :<font
  class="font9">Private information</font></td>
  <td colspan=24 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl24 style='height:26.25pt'></td>
  <td class=xl27 width=181 style='width:136pt'>Mã s&#7889;<br>
    <span style='mso-spacerun:yes'> </span><font class="font9">Code</font></td>
  <td class=xl27 width=256 style='border-left:none;width:192pt'>H&#7885; và
  Tên<br>
    <font class="font9"><span style='mso-spacerun:yes'> </span>Full-name</font></td>
  <td class=xl27 width=167 style='border-left:none;width:125pt'>Ch&#7913;c
  v&#7909;<br>
    <font class="font9"><span style='mso-spacerun:yes'> </span>Position</font></td>
  <td class=xl27 width=168 style='border-left:none;width:126pt'>Ngày vào
  Cty<br>
    <span style='mso-spacerun:yes'> </span><font class="font9">Enter-date</font></td>
  <td class=xl27 width=189 style='border-left:none;width:142pt'>H&#7885;c
  l&#7921;c cao nh&#7845;t<br>
    <font class="font9">Highest education</font></td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28 style='border-top:none'><%= dt_total.Rows[i][2].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][3].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][5].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][6].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][14].ToString()%></td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:20.1pt'>
  <td height=26 colspan=27 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:20.1pt'>
  <td height=26 colspan=27 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>2. LÝ L&#7882;CH &#272;ÀO
  T&#7840;O : <font class="font9">Training history</font></td>
  <td colspan=24 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 style='height:30.0pt'></td>
  <td class=xl27 width=181 style='width:136pt'>B&#7897; ph&#7853;n<br>
    <font class="font9">Department</font></td>
  <td class=xl27 width=256 style='border-left:none;width:192pt'>Tên khóa
  &#273;ào t&#7841;o<br>
    <font class="font9">Training course</font></td>
  <td class=xl27 width=167 style='border-left:none;width:125pt'>Ngày b&#7855;t
  &#273;&#7847;u<br>
    <font class="font9">Start-date</font></td>
  <td class=xl27 width=168 style='border-left:none;width:126pt'>Ngày hoàn
  thành<br>
    <font class="font9">Finish-date</font></td>
  <td class=xl27 width=189 style='border-left:none;width:142pt'>C&#417; quan/
  b&#7897; ph&#7853;n &#273;ào t&#7841;o<br>
    <font class="font9">Training agency</font></td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
  <%     }
         flag = false;     
 %>  <%--End flag--%>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl24 style='height:24.75pt'></td>
  <td class=xl28 style='border-top:none'><%= dt_total.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][7].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][8].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][9].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%= dt_total.Rows[i][11].ToString()%></td>
  <td colspan=21 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
if (i < irow - 1)
{
    emp_type_new = dt_total.Rows[i + 1][2].ToString();
    if (emp_type_new != emp_type_old)
    {
        flag = true;
        flag_1 = true;
    }
}
else
{
    flag = true;
    flag_1 = true;
}

if (flag_1)
{
  %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl29 style='height:20.1pt'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>A4(210x297mm) Quá trình
  hu&#7845;n luy&#7879;n &#273;ào t&#7841;o (P0-V30-1B-F05) 2011.01.01, Rev.2</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31>Th&#7901;i gian l&#432;u gi&#7919;: v&#297;nh vi&#7877;n</td>
  <td colspan=20 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <%
     flag_1 = false;
}
     }       
%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=24 style='width:18pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=167 style='width:125pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
