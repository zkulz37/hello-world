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
    string l_company_pk= ""+ Request["company_pk"];
    string l_seq= ""+ Request["seq"];
    string l_voucher_type= ""+ Request["voucher_type"];
    string l_cust_cd = ""+ Request["cust_cd"];
    string l_status= ""+ Request["status"];
    string l_voucher_no= ""+ Request["voucher_no"];
    string l_Trs_fr= ""+ Request["Trs_fr"];
    string l_Trs_to= ""+ Request["Trs_to"];
    string l_RPPerson=""+ Request["RPPerson"];
    string l_Desc1=""+ Request["Desc1"];
    string l_Desc2=""+ Request["Desc2"];
    string s_from ="";
    string s_to="";
    string s_voi_type="";
    string s_status="";
    string SQLC = " SELECT PARTNER_LNAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = " + l_company_pk;
    string p_cmp_name = "", p_cmp_add = "", p_cmp_taxcode = "";
    DataTable dt1 = ESysLib.TableReadOpen(SQLC);

    if (dt1.Rows.Count > 0)
    {
        p_cmp_name = dt1.Rows[0][0].ToString();
        p_cmp_add = dt1.Rows[0][1].ToString();
        p_cmp_taxcode = dt1.Rows[0][3].ToString();
    }
    
    //Response.Write(l_voucher_type);
    //Response.End();
    string sql_t="select to_char(to_date('" + l_Trs_fr + "','yyyymmdd'),'dd/mm/yyyy') trs_dt,to_char(to_date('" + l_Trs_to + "','yyyymmdd'),'dd/mm/yyyy') trs_to, B.CODE_NM "+
    " ,decode('" + l_status + "','0','Approved','1','Saved','2','Confirmed','3','Cancel','Approved (In)') TR_STATUS " +
    " FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B " +
    " WHERE A.PK     = B.TAC_COMMCODE_MASTER_PK " +
    "       AND A.ID     = 'ACBG0130' " +
    "       AND A.DEL_IF = 0 "+
    "       AND B.DEL_IF = 0 and b.code= '"+ l_voucher_type + "'";
    
    
    DataTable dt= ESysLib.TableReadOpen(sql_t); 
    
    int cnt  =dt.Rows.Count;
    
    if (cnt>0 )
    {
        s_from=dt.Rows[0][0].ToString();
        s_to=dt.Rows[0][1].ToString();
        s_voi_type=dt.Rows[0][2].ToString();
        s_status=dt.Rows[0][3].ToString();
     }       
    
    string SQL
    = "SELECT SEQ, VOUCHERNO, TRS_DATE, PARTNER_ID, PARTNER_NAME, TOTAL,REMARK, REMARK2,TR_PERSON,TR_ENCLOSE,TR_STATUS,CRT_BY " + 
        "FROM(SELECT NULL CHK " +
        "            , H.PK SEQ " +
        "            , A.VOUCHERNO " +
        "            , TO_CHAR(TO_DATE(A.TR_DATE,'YYYY/MM/DD'),'YYYY/MM/DD') TRS_DATE " +
        "            , C.PARTNER_ID " +
        "            , C.PARTNER_NAME  " +
        "            , LTRIM(TO_CHAR(A.TOTAL, SF_GET_FORMAT('ACBG0040'))) TOTAL " +
        "            , A.REMARK " +
        "            , A.REMARK2 " +
        "            ,a.TR_ENCLOSE " +
        "            ,decode(a.TR_STATUS,'0','Approved','1','Saved','2','Confirmed','3','Cancel','Approved (In)') TR_STATUS " +
        "            ,a.TR_PERSON,a.crt_by " +
        "      FROM TAC_HGTRH H, TAC_BPRVPV A, TCO_BUSPARTNER C " +
        "     WHERE A.DEL_IF = 0 " +
        "       AND A.TCO_BUSPARTNER_PK = C.PK(+) " +
        "       AND A.PK = H.TR_TABLE_PK(+) " +
        "       AND H.DEL_IF(+) = 0 " +
        "       AND A.TCO_COMPANY_PK = " + l_company_pk + 
        "       AND A.TR_DATE BETWEEN '" + l_Trs_fr + "' AND '" + l_Trs_to + "' " +
        "       AND A.TR_STATUS LIKE DECODE(TRIM('" + l_status + "'),'','%','0','0','1','1','2','2', '3', '3', '4','4') " +
        "       AND ((A.VOUCHERNO LIKE '%'|| TRIM(UPPER('" + l_voucher_no +"')) || '%') OR ('" + l_voucher_no + "' IS NULL))            " +
        "       AND (DECODE('" + l_voucher_type + "','ALL','1',A.VOUCHER_TYPE) = DECODE('" + l_voucher_type + "','ALL','1','" + l_voucher_type + "')) " +
        "       AND (C.PARTNER_ID LIKE '%' || TRIM(UPPER('" + l_cust_cd + "')) OR ('" + l_cust_cd + "' IS NULL)) " +
        "       AND (('" + l_seq + "' IS NULL) OR (H.PK = '" + l_seq + "')) " +
        "       AND (('" + l_RPPerson + "' IS NULL) OR (UPPER(A.TR_PERSON) LIKE '%'||UPPER('" + l_RPPerson + "')||'%')) " +
        "       AND (('" + l_Desc1 + "' IS NULL) OR (UPPER(A.REMARK) LIKE '%'||UPPER('" + l_Desc1 + "')||'%')) " +
        "       AND (('" + l_Desc2 + "' IS NULL) OR (UPPER(A.REMARK2) LIKE '%'||UPPER('" + l_Desc2 + "')||'%')) " +
        "     ORDER BY A.TR_DATE DESC, A.VOUCHERNO DESC, A.PK) " ;
        
        //Response.Write(SQL);
        //Response.End();
        
        DataTable dtGrd = ESysLib.TableReadOpen(SQL);   
        int irow;
        irow = dtGrd.Rows.Count;
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
<link rel=File-List href="gfbr00050_ReceiptPayment%20Inq_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfbr00050_ReceiptPayment%20Inq_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfbr00050_ReceiptPayment%20Inq_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2008-12-09T09:26:20Z</o:LastPrinted>
  <o:Created>2008-12-03T03:21:02Z</o:Created>
  <o:LastSaved>2008-12-09T09:26:33Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
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
    <x:Name>ReceiptPayment Inq.</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8400</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>225</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='ReceiptPayment Inq.'!$A$7:$L$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1336 style='border-collapse:
 collapse;table-layout:fixed;width:1002pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=67 span=2 style='mso-width-source:userset;mso-width-alt:
 2450;width:50pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=215 span=2 style='mso-width-source:userset;mso-width-alt:
 7862;width:161pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl40 width=460 style='height:15.0pt;width:345pt'><%=p_cmp_name %></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=215 style='width:161pt'></td>
  <td class=xl24 width=215 style='width:161pt'></td>
  <td class=xl24 width=113 style='width:85pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl41 width=460 style='height:15.0pt;width:345pt'><%=p_cmp_add %></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl40 style='height:15.0pt'>Mã s&#7889;
  thu&#7871;:<%=p_cmp_taxcode %></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Trans
  Date : <font class="font9"><%=s_from %> ~ <%=s_to %></font></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Status : <font
  class="font9"><%=s_status %></font></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Type : <font class="font9"><%=s_voi_type%></font></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl25 style='height:27.75pt'>No</td>
  <td class=xl25 style='border-left:none'>Seq</td>
  <td class=xl25 style='border-left:none'>Voucher No</td>
  <td class=xl32 width=67 style='border-left:none;width:50pt'>Trans<br>
    Date</td>
  <td class=xl32 width=67 style='border-left:none;width:50pt'>Partner <br>
    Code</td>
  <td class=xl32 width=133 style='border-left:none;width:100pt'>Partner <br>
    Name</td>
  <td class=xl25 style='border-left:none'>Amount</td>
  <td class=xl25 style='border-left:none'>Description</td>
  <td class=xl25 style='border-left:none'>Local Description</td>
  <td class=xl26 style='border-left:none'>R/P Person</td>
  <td class=xl26 style='border-left:none'>Enclose</td>
  <td class=xl26 style='border-left:none'>Status</td>
  <td class=xl26 style='border-left:none'>Prps By</td>
 </tr>
 <%
    for (int i=0; i< irow; i++)
    {
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><% =dtGrd.Rows[i][0].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][1].ToString()%></td>
  <td class=xl33 style='border-top:none' x:num><%=dtGrd.Rows[i][2].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][3].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][4].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none' x:num><%=dtGrd.Rows[i][5].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none'  x:str><%=dtGrd.Rows[i][6].ToString()%></td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'
  x:str><%=dtGrd.Rows[i][7].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][8].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][9].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][10].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dtGrd.Rows[i][11].ToString()%></td>
 </tr>
 <%
    }
 %> 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl35 style='height:15.0pt'>Ng&#432;&#7901;i ghi
  s&#7893;</td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl35>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl24></td>
  <td colspan=4 class=xl35>T&#7893;ng Giám &#273;&#7889;c</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl36 style='height:15.0pt'><span
  style='mso-spacerun:yes'> </span>( Ký, h&#7885; tên)</td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl36>( Ký, h&#7885; tên)</td>
  <td class=xl24></td>
  <td colspan=4 class=xl36>(Ký, h&#7885; tên, &#273;óng d&#7845;u)</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=133 style='width:100pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
