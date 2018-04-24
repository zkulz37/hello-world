<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = ""+Request["p_company_pk"];
	string l_account_pk = ""+Request["p_acc_pk"];
	string l_date_from	= "" + Request["p_date_from"];
	string l_date_to = "" +Request["p_date_to"];
	string l_ccy = ""+ Request["p_ccy"];
	string l_status = ""+Request["p_status"];
    string l_openbal = "" + Request["p_openbal"];
	if (l_status=="")//Default status is confirm
	{
		l_status="2";
	}
   
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_acc_num = "";
	int i =0;

    string SQL2 = " SELECT AC_CD,AC_LNM,UPPER(a.DRCR_TYPE),  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL2 += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
    SQL2 += " FROM TAC_LOCALCODE a WHERE a.pk = '" + l_account_pk + "' ";

    DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    if (dt2.Rows.Count > 0)
    {
        p_acc_code = dt2.Rows[0][0].ToString();
        p_acc_name = dt2.Rows[0][1].ToString();
        p_acc_type = dt2.Rows[0][2].ToString();
        p_dt_from =  dt2.Rows[0][3].ToString();
        p_dt_to =    dt2.Rows[0][4].ToString();
        p_acc_num =  dt2.Rows[0][5].ToString();
    }
    
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][3].ToString();
    }
    string l_parameter = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy + "','" + l_openbal + "'";
    string l_parameterSum = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy  + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dtDetail = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_2", l_parameter);//Data of Date,not voucher
    if (dtDetail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    DataTable dtSum = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_1", l_parameterSum);
    //Response.Write(dtSum.Rows[1][4].ToString());
    //    Response.End();
    if (dtSum.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptPayment_files/filelist.xml">
<link rel=Edit-Time-Data href="rptPayment_files/editdata.mso">
<link rel=OLE-Object-Data href="rptPayment_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Cuong</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2008-06-02T01:56:22Z</o:LastPrinted>
  <o:Created>2006-06-26T17:03:23Z</o:Created>
  <o:LastSaved>2010-01-18T07:10:33Z</o:LastSaved>
  <o:Company>abc</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CTrang &P of &N";
	margin:.5in 0in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	padding:0px;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
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
	border-left:.5pt solid windowtext;}
.xl35
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
	border-left:.5pt solid windowtext;}
.xl36
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
	border-left:none;}
.xl37
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
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
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
	border-left:none;}
.xl40
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
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl42
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
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl48
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
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
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
	border-left:.5pt solid windowtext;}
.xl58
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
	border-left:.5pt solid windowtext;}
.xl59
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
.xl60
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
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
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
.xl65
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sổ NK chi tiền(Mau so S03a2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Sổ NK chi tiền(Mau so S03a2'!$A$9:$I$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Sổ NK chi tiền(Mau so S03a2'!$7:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1034"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:
 collapse;table-layout:fixed;width:882pt'>
 <col class=xl24 width=89 span=3 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=299 span=2 style='mso-width-source:userset;mso-width-alt:
 10934;width:224pt'>
 <col class=xl24 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 width=178 style='height:15.75pt;
  mso-ignore:colspan;width:134pt'>VINA GENUWIN</td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=299 style='width:224pt'></td>
  <td colspan=5 class=xl26 width=609 style='width:457pt'><span
  style='mso-spacerun:yes'> </span>Form number: S03a2</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=3 style='height:15.75pt;mso-ignore:colspan'>364
  cộng hòa, tân bình, hcmc</td>
  <td class=xl25></td>
  <td colspan=5 class=xl27 x:str="(Issued with Decision No. 15/2006/QĐ-BTC ">(Issued
  with Decision No. 15/2006/QĐ-BTC<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code:&nbsp;&nbsp;0303026656</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td colspan=5 class=xl27>dated March 20, 2006 by Ministry)</td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=8 height=34 class=xl56 style='height:25.5pt'>PAYMENT JOURNAL</td>
  <td class=xl28></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=8 height=26 class=xl27 style='height:19.5pt'>From date18/01/2002
  to date 18/01/2010</td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>Account code</td>
  <td class=xl30 x:num>112100</td>
  <td class=xl31>Account name:</td>
  <td class=xl32>CASH IN BANK - VND</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl32>Unit: USD</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt' x:str="Date ">Date<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black;border-top:
  none'>Local Description</td>
  <td class=xl36>Description</td>
  <td rowspan=2 class=xl59 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Debit</td>
  <td rowspan=2 class=xl59 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Credit<span style='mso-spacerun:yes'>  </span>Account</td>
  <td class=xl37>Amount</td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black'>Note</td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'>entered</td>
  <td class=xl37 x:str="No. ">No.<span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>Date</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>USD</td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$9:$I$9" style='height:15.75pt'>A</td>
  <td class=xl39 id="_x0000_s1026" x:autofilter="all">B</td>
  <td class=xl39 id="_x0000_s1027" x:autofilter="all">C</td>
  <td class=xl39 id="_x0000_s1028" x:autofilter="all" style='border-top:none'>D</td>
  <td class=xl39 id="_x0000_s1029" x:autofilter="all">&nbsp;</td>
  <td class=xl40 id="_x0000_s1030" x:autofilter="all" width=68
  style='border-top:none;width:51pt'>F</td>
  <td class=xl40 id="_x0000_s1031" x:autofilter="all" width=68
  style='border-top:none;width:51pt'>G</td>
  <td class=xl39 id="_x0000_s1032" x:autofilter="all" x:num>1</td>
  <td class=xl39 id="_x0000_s1033" x:autofilter="all" style='border-top:none'>H</td>
 </tr>
 <%
      //Response.Write(SQL);
      //Response.End();  
	//DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	string strDate = "";
	string strDate_Dsp = "";

    if (dtDetail.Rows.Count > 0)
	{
        for (i = 1; i < dtDetail.Rows.Count; i++)
		{
            if (strDate != dtDetail.Rows[i][2].ToString())
			{
                strDate_Dsp = dtDetail.Rows[i][2].ToString();
                strDate = dtDetail.Rows[i][2].ToString();
			}
			else
			{
				strDate_Dsp = "";
			}

            if (i < dtDetail.Rows.Count)
			{
			//height=42 style='height:31.5pt'
 %>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'><%= strDate_Dsp %></td>
  <td class=xl42><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl44 width=299 style='width:224pt'><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl44 width=299 style='width:224pt'><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl42 x:num><%= dtDetail.Rows[i][15].ToString()%></td>
  <td class=xl42 x:num><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl45 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl46 align=right x:num><%= dtDetail.Rows[i][0].ToString()%></td>
 </tr>
 <% }
 else
{ %>
<tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'><%= strDate_Dsp %></td>
  <td class=xl42><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl43><%= dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl44 width=299 style='width:224pt'><%= dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl44 width=299 style='width:224pt'><%= dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl42 x:num><%= dtDetail.Rows[i][15].ToString()%></td>
  <td class=xl42 x:num><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl45 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl46 align=right x:num><%= dtDetail.Rows[i][0].ToString()%></td>
 </tr>
  <%
			}
		}
	}
 %>
 <tr class=xl25 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl61 style='border-right:.5pt solid black;
  height:28.5pt'>&nbsp;</td>
  <td class=xl40 width=299 style='width:224pt'>Total Amount Incurred</td>
  <td class=xl48 width=299 style='width:224pt'>&nbsp;</td>
  <td colspan=2 class=xl64 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl49 x:num><span
  style='mso-spacerun:yes'> </span><%= dtDetail.Rows[1][5].ToString()%></td>
  <td class=xl50>&nbsp;</td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=3 class=xl47 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl53 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=8 height=23 class=xl47 style='height:17.25pt'>The book are….
  page(s) , number from<span style='mso-spacerun:yes'>   </span>page 01 to<span
  style='mso-spacerun:yes'>  </span>page……</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=5 class=xl47 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl47>Date 18/01/2010</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl54 style='height:17.25pt'>Prepared by</td>
  <td class=xl54>Chief Accountant</td>
  <td class=xl54></td>
  <td colspan=3 class=xl54>General Director</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'>(Sign, Fullname)</td>
  <td class=xl55>(Sign, Fullname)</td>
  <td class=xl55></td>
  <td colspan=3 class=xl55>(Sign, Fullname, Stamp)</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl55></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl55></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl55></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl55></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl55 style='height:17.25pt'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl55></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl54 style='height:17.25pt'>BÀ D</td>
  <td class=xl54>BÀ E</td>
  <td class=xl54></td>
  <td colspan=3 class=xl54>BÀ F</td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=299 style='width:224pt'></td>
  <td width=299 style='width:224pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
