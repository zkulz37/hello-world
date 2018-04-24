<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_company = Request["Company"];
	string l_date_from = Request["DateFrom"];
	string l_date_to = Request["DateTo"];
	string l_voucher = Request["Voucher"];
	string l_Seq = Request["Seq"];
	string l_status = Request["Status"];
	string l_bookCcy = Request["BookCcy"];
	string l_acc_dr  = Request["AccDr"];
	string l_acc_cr = Request["AccCr"];
	string l_direct_code  = Request["DirectCode"];
	string l_indirect_code  = Request["IndirectCode"];

    String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
   
    string l_cmp_name="";
	string l_cmp_add ="";
	string l_cmp_taxcode="";
	string p_status = "";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_dt_today = "";
	int i=0;
	 
    if (l_bookCcy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
   
   string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}
    
   SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
SQL = SQL + " INITCAP(To_char (sysdate, 'day, month dd  yyyy')) ";
SQL = SQL + " FROM DUAL ";

    dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
	    p_dt_from = dt.Rows[0][0].ToString();
		p_dt_to = dt.Rows[0][1].ToString();
		p_dt_today = dt.Rows[0][2].ToString();
		
	}
	
	if (l_status == "2")
    {
		p_status = "Confirmed";
    }
	else if (l_status == "0") 
    {
		p_status = "Approved";
    }
	else if (l_status == "4" )
    {
		p_status = "Not Approved";
    }
	
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00070_files/filelist.xml">
<link rel=Edit-Time-Data href="gfhg00070_files/editdata.mso">
<link rel=OLE-Object-Data href="gfhg00070_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-04-15T05:42:35Z</o:LastPrinted>
  <o:Created>2009-04-15T01:30:16Z</o:Created>
  <o:LastSaved>2009-04-15T05:43:54Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .25in .75in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>27</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8670</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$6:$L$6</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1037"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=982 style='border-collapse:
 collapse;table-layout:fixed;width:737pt'>
 <col width=43 span=2 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col width=64 style='width:48pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=57 span=4 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col width=87 span=2 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col width=173 style='mso-width-source:userset;mso-width-alt:6326;width:130pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 colspan=6 width=341 style='height:15.0pt;mso-ignore:
  colspan;width:256pt'>DAILY ENTRY INQUIRY CASH FLOW</td>
  <td class=xl31 width=57 style='width:43pt'></td>
  <td class=xl31 width=57 style='width:43pt'></td>
  <td class=xl31 width=87 style='width:65pt'></td>
  <td class=xl31 width=87 style='width:65pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=180 style='width:135pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 colspan=3 style='height:12.75pt;mso-ignore:colspan'>as at <%=  p_dt_today %></td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl33 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Company:</td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan'><%= l_cmp_name %></td>
  <td class=xl34></td>
  <td class=xl35 width=57 style='width:43pt'>Period:</td>
  <td class=xl38 colspan=3 style='mso-ignore:colspan'><%= p_dt_from %> ~ <%=p_dt_to %></td>
  <td class=xl36 x:str="Status:   ">Status:<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl37><%= p_status %></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl24 style='height:25.5pt'>No</td>
  <td rowspan=2 class=xl24>Seq</td>
  <td rowspan=2 class=xl24>Trans Date</td>
  <td rowspan=2 class=xl24>Voucher No</td>
  <td colspan=2 class=xl24 style='border-left:none'>Account Code</td>
  <td rowspan=2 class=xl24>CF Code</td>
  <td rowspan=2 class=xl39 width=57 style='width:43pt'>CF Code<br>
    Indirect</td>
  <td colspan=2 class=xl24 style='border-left:none'>Amount</td>
  <td colspan=2 class=xl24 style='border-left:none'>Description</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 id="_x0000_s1029" x:autofilter="all"
  style='height:12.75pt;border-top:none;border-left:none'>Debit</td>
  <td class=xl24 id="_x0000_s1030" x:autofilter="all" style='border-top:none;
  border-left:none'>Credit</td>
  <td class=xl24 id="_x0000_s1033" x:autofilter="all" style='border-top:none;
  border-left:none'>Trans</td>
  <td class=xl24 id="_x0000_s1034" x:autofilter="all" style='border-top:none;
  border-left:none'>Books</td>
  <td class=xl24 id="_x0000_s1035" x:autofilter="all" style='border-top:none;
  border-left:none'>Foreign</td>
  <td class=xl24 id="_x0000_s1036" x:autofilter="all" style='border-top:none;
  border-left:none'>Local</td>
 </tr>
 <%
SQL = "SELECT R.PK R_PK,H.PK H_PK,R.TAC_HGTRD_PK,R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR,DRCR_ORD,TO_CHAR(H.TR_DATE,SF_GET_FORMAT ('ACAB0300')) TR_DATE, H.VOUCHERNO,  " + 
        "    SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_DR,"+l_company+") CD,  SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_CR,"+l_company+"),CF_CODE, CF_CODE_INDIRECT CF_ICODE, " +
        "    R.TR_AMT,R.TR_BOOKAMT, R.REMARK,R.REMARK2 " +
        "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R  " +
        "    WHERE H.DEL_IF = 0   " +
        "    AND R.DEL_IF = 0  " +
        "    AND H.PK = R.TAC_HGTRH_PK  " +
        "    AND R.DRCR_TYPE = 'D'   " +
        "    AND H.TCO_COMPANY_PK = "+l_company+"   " +
        "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+l_date_from+"' AND '"+l_date_to+"' " +
        "    AND (('" + l_direct_code + "' IS NULL) OR (R.CF_CODE = '" + l_direct_code + "')) " +
        "    AND (('" + l_acc_dr + "' IS NULL) OR (R.TAC_ABACCTCODE_PK_DR = '" + l_acc_dr + "'))    " +
        "    AND (('" + l_acc_cr + "' IS NULL) OR (R.TAC_ABACCTCODE_PK_CR = '" + l_acc_cr + "')) " +
        "    AND H.TR_STATUS IN (DECODE ("+ l_status +" , 2, 2, "+ l_status +"),DECODE ("+ l_status +", 2, 0, "+ l_status +"), DECODE ("+ l_status +", 2, 4, "+ l_status +"))  " +
        "    AND ((TRIM('"+l_voucher +"') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('"+l_voucher +"'))|| '%'))   " +
        "    AND ((TRIM('"+ l_Seq +"')  IS NULL) OR (h.pk = TRIM('"+ l_Seq +"') ))   " +
        "    AND (('"+ l_indirect_code +"' IS NULL) OR (R.CF_CODE_INDIRECT = '"+ l_indirect_code +"')) " +
        "  ORDER BY TR_DATE ASC,VOUCHERNO,H_PK,R_PK " ;

        dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
	for(i=0;i<dt.Rows.Count;i++)
	{
  %>
 <tr >
  <td  class=xl40  x:num><%=i+1 %></td>
  <td class=xl40  x:num><%= dt.Rows[i][1].ToString() %></td>
  <td class=xl25 ><%= dt.Rows[i][6].ToString() %></td>
  <td class=xl25 ><%= dt.Rows[i][7].ToString() %></td>
  <td class=xl25  x:num><%= dt.Rows[i][8].ToString() %></td>
  <td class=xl25  x:num><%= dt.Rows[i][9].ToString() %></td>
  <td class=xl28 ><%= dt.Rows[i][10].ToString() %></td>
  <td class=xl28 ><%= dt.Rows[i][11].ToString() %></td>
  <td class=xl26  x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';mso-text-control:shrinktofit;"><%= dt.Rows[i][12].ToString() %></td>
  <td class=xl26  x:num style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;"><%= dt.Rows[i][13].ToString() %></td>
  <td class=xl27 width=173 style='width:130pt'><%= dt.Rows[i][14].ToString() %></td>
  <td class=xl27 width=180 style='width:135pt'><%= dt.Rows[i][15].ToString() %></td>
 </tr>
 <%
} 
}
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=43 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=180 style='width:135pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
