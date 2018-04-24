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
	string l_company_pk = "" + Request["company_pk"];
	string l_account_pk = "" + Request["account_pk"];
	string l_date_from	= ""+ Request["dtbFrom"];
	string l_date_to = "" + Request["dtbTo"];
	string l_ccy = ""+Request["ccy"];
	string l_status = "" +Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
	string l_cust_pk = ""+Request["cust_pk"];
	string l_partner_type = ""+Request["partner_type"];
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_cust_name ="";
	string p_cust_code ="";
	string p_cd_dr_num ="1";

	string p_open_bal_xls = "0";
	string p_close_bal_xls = "0";
	string p_debit_xls = "0";
	string p_credit_xls = "0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
	string p_temp ="";
	string strDate = "";
	string strDate_Dsp = "";

	
	int i =0;
	
	String p_xls_ccy_book ="";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_book = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_book = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    
	string SQL = " SELECT partner_lname, addr2, tax_code, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date,to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
        p_dt_from = dt.Rows[0][3].ToString();
		p_dt_to = dt.Rows[0][4].ToString();
    }
   
   SQL= "SELECT DECODE(ac_get_DRCRTYPE('"+l_company_pk+"','"+l_account_pk+"'),'D','1','C','-1','1') FROM DUAL " ; 
	dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cd_dr_num = dt.Rows[0][0].ToString();
    }

    SQL = " SELECT AC_CD_formular AC_CD,AC_NM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
	SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date  ";
	SQL += "FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
	}
	if (l_cust_pk!="")
	{
	    SQL= "SELECT PARTNER_ID,PARTNER_NAME,PARTNER_LNAME FROM TCO_BUSPARTNER WHERE PK = "+l_cust_pk;
	    dt = ESysLib.TableReadOpen(SQL);
        if (dt.Rows.Count >0)
        {
            p_cust_code = dt.Rows[0][0].ToString();
            p_cust_name = dt.Rows[0][1].ToString();
        }
        
	}
	string l_parameter = "'" + l_company_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_account_pk + "','" + l_cust_pk + "','" + l_status + "','" + l_partner_type + "'" ;
    //Response.Write(l_parameter);
    //Response.End();


    DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_sel_60080080_mo_cust_bal3", l_parameter);
    if (dt_detail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	 DataTable dt_sum = ESysLib.TableReadOpenCursor("ac_rpt_60080080_sum_cust_bal3", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="book_files/filelist.xml">
<link rel=Edit-Time-Data href="book_files/editdata.mso">
<link rel=OLE-Object-Data href="book_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kiet</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-03-24T03:19:56Z</o:LastPrinted>
  <o:Created>2007-10-11T03:53:00Z</o:Created>
  <o:LastSaved>2009-03-24T03:22:46Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
	.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Monthly Partner Balance</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>94</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Monthly Partner Balance'!$A$6:$E$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1189 style='border-collapse: collapse;table-layout:fixed;width:895pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3754; width:66pt'>
 <col class=xl24 width=249 style='mso-width-source:userset;mso-width-alt:10624; width:187pt'>
 <col class=xl24 width=123 span=7 style='mso-width-source:userset;mso-width-alt: 4498;width:92pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl25 colspan=2 width=337 style='height:18.75pt;
  mso-ignore:colspan;width:253pt'><%=p_cmp_name %></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
  <td class=xl24 width=123 style='width:92pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=2 style='height:12.75pt;mso-ignore:colspan'>BẢNG TỔNG HỢP CÔNG NỢ</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28 ></td>
  <td class=xl29 x:num></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Từ ngày <%= p_dt_from %> đến ngày <%=p_dt_to %></td>
  <td class=xl24></td>
  <td class=xl28 style='mso-ignore:colspan; ' <% if (p_cust_code!="") { %> x:str="Khách hàng : " <%} %>><% if (p_cust_code!="") { %>Partner : <%} %></td>
  <td class=xl27 style='mso-ignore:colspan;text-align:center;'><%=p_cust_code %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'><b><%=p_cust_name %></b></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl33 style='height:30.0pt'>Mã KH</td>
  <td rowspan=2 class=xl33>Tên KH</td>
  <td rowspan=2 height=40 class=xl33 style='height:30.0pt'>Mã TK</td>
  <td rowspan=2 class=xl33>Số đầu kỳ nợ</td>
  <td rowspan=2 class=xl33>Số đầu kỳ có</td>
  <td colspan=2 class=xl33 style='border-left:none'>Phát sinh trong kỳ</td>
  <td colspan=2 class=xl33 style='border-left:none'>Lũy kế</td>
  <td rowspan=2 class=xl33>Số cuối kỳ nợ</td>
  <td rowspan=2 class=xl33>Số cuối kỳ có</td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt;border-top:none;border-left:
  none'>Nợ</td>
  <td class=xl33 style='border-top:none;border-left:none'>Có</td>
  <td class=xl33 style='border-top:none;border-left:none'>Nợ</td>
  <td class=xl33 style='border-top:none;border-left:none'>Có</td>
 </tr>
 <%
    
    
    if (dt_detail.Rows.Count >1)
	{ 
	    for(i=1;i<dt_detail.Rows.Count;i++)
		{
  %>
 <tr class=xl31 height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl35 width=249 style='border-top:none;border-left:none;width:187pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][9].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][10].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][11].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_detail.Rows[i][12].ToString()%></td>
 </tr>
   <%
    }
}
%>
 <tr class=xl31 height=17 style='height:12.75pt'>
 
  <td colspan=2 class=xl44 width=249 style='border-top:none;border-left:none;width:187pt'>Total : </td>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'></td>
  
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["dr_open"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["cr_open"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["dr_sum"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["cr_sum"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["acc_dr_sum"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["acc_cr_sum"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["dr_end_bal"].ToString()%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_book %>';" x:num><%=dt_sum.Rows[0]["cr_end_bal"].ToString()%></td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=88 style='width:66pt'></td>
  <td width=249 style='width:187pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=142 style='width:107pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
