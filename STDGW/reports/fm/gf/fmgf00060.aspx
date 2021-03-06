<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<% 
    string lpk, lcompany_pk, ltakeindt;
    string SQL;
    decimal lQty = 0, lAmt = 0;
    int i ;
    lpk = Request["tac_fgtakein_pk"];
    lcompany_pk = Request["company_pk"];
    
    SQL
	= "select PARTNER_NAME, TAX_CODE, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' ') address  " + 
        "from comm.tco_company  " +
        "where del_if = 0  " +
        "and pk like '" + lcompany_pk + "' " ;    
    DataTable dt = new DataTable ();
    dt = ESysLib.TableReadOpen(SQL); 
    if(dt.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }
 SQL
	= "select SLIP_NO, to_char(to_date(TAKEIN_DATE, 'yyyymmdd'), 'dd/mm/yyyy') takein_dt, ACCT_SEQ_NO " + 
        "from acnt.TAC_FGTAKEIN " +
        "where pk like '" + lpk + "' " ;
    
    DataTable dtMaster = new DataTable ();
    dtMaster = ESysLib.TableReadOpen(SQL);
    if(dtMaster.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }    
    ltakeindt = dtMaster.Rows[0][1].ToString() ;   
    SQL
    = "select a.TCO_ITEM_PK, a.TAKEIN_QTY, a.ITEM_UOM, a.IN_AMT, b.ITEM_CODE, b.ITEM_NAME, a.IN_PRICE       " + 
        "from acnt.TAC_FGTAKEIND a, comm.tco_item b  " +
        "where a.del_if = 0  " +        
        "and a.TCO_ITEM_PK = b.pk " +        
        " and a.TAC_FGTAKEIN_PK like '" + lpk + "' " ;
        
    DataTable dtItem = new DataTable ();
    dtItem = ESysLib.TableReadOpen(SQL);
    
    if(dtItem.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");        
        Response.End();
    }
    for (i = 0; i < dtItem.Rows.Count; i++)
    {
        if (dtItem.Rows[i][1].ToString().Trim() != "")
        {
            lQty += Decimal.Parse(dtItem.Rows[i][1].ToString());
        }
        if (dtItem.Rows[i][3].ToString().Trim() != "")
        {
            lAmt += Decimal.Parse(dtItem.Rows[i][3].ToString());
        }
    }    
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Phieu%20Nhap%20Kho_files/filelist.xml">
<link rel=Edit-Time-Data href="Phieu%20Nhap%20Kho_files/editdata.mso">
<link rel=OLE-Object-Data href="Phieu%20Nhap%20Kho_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-11-12T08:01:52Z</o:LastPrinted>
  <o:Created>2008-11-12T08:00:32Z</o:Created>
  <o:LastSaved>2008-11-12T08:04:48Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
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
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:7.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
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
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	color:white;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:top;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl86
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
       <x:RangeSelection>$H$2:$I$3</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11850</x:WindowHeight>
  <x:WindowWidth>19065</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=812 style='border-collapse:
 collapse;table-layout:fixed;width:613pt'>
 <col class=xl29 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl29 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl29 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl29 width=186 style='mso-width-source:userset;mso-width-alt:6802;
 width:140pt'>
 <col class=xl29 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl29 width=62 span=2 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl29 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl29 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl29 width=62 span=247 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 width=30 style='height:15.0pt;width:23pt'></td>
  <td class=xl25 width=62 style='width:47pt'></td>
  <td class=xl25 width=70 style='width:53pt'></td>
  <td class=xl26 width=186 style='width:140pt'></td>
  <td class=xl26 width=50 style='width:38pt'></td>
  <td class=xl26 width=62 style='width:47pt'></td>
  <td class=xl26 width=62 style='width:47pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl27 align=left width=144 style='width:108pt'>Mẫu số: S02-TP</td>
  <td class=xl28 width=62 style='width:47pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 colspan=4 style='height:15.0pt;mso-ignore:colspan'><%=dt.Rows[0][0] %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 rowspan=2 class=xl32 width=228 style='width:171pt'>(Ban hành
  theo QĐ số 15/2006/QĐ-BTC ngày 20/03/2006 của Bộ trưởng BTC)</td>
  <td class=xl28></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl33 colspan=2 style='height:20.25pt;mso-ignore:colspan'>ADDRESS</td>
  <td class=xl92 colspan=4 width=368 style='width:278pt' ><%=dt.Rows[0][2] %></td>
  <td class=xl35></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl33 colspan=2 style='height:15.0pt;mso-ignore:colspan'>TAX
  CODE:</td>
  <td colspan=2 class=xl94 width=256 style='width:193pt'><%=dt.Rows[0][1] %></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30></td>  
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl38 style='border-right:.5pt solid black;
  height:22.5pt'>PHIẾU NHẬP KHO / INPUT FINISH GOOD</td>
  <td class=xl40 style='border-left:none'>Số chứng từ</td>
  <td class=xl41 style='border-left:none'><%=dtMaster.Rows[0][0] %> (<%=dtMaster.Rows[0][2] %>)</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=7 height=20 class=xl42 style='border-right:.5pt solid black;
  height:15.0pt' x:str>Ngày (date): <%=dtMaster.Rows[0][1] %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='border-top:none;border-left:none'>Ghi nợ 155000</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=lAmt %></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl46 ></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl44 style='border-top:none'>Ghi Có 154000</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=lAmt %></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=6 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td class=xl48></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=8 class=xl49>Bộ phận sản xuất / Dept</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=8 class=xl49>Địa chỉ:/ Address</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td class=xl29 colspan=3 align=left style='mso-ignore:colspan'>Diễn giải:/
  Description : Nhập kho TP vải dệt kim</td>
  <td class=xl26></td>
  <td class=xl51></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'>Nhập tại kho</td>
  <td colspan=6 class=xl52>Doanh nghiệp</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=8 class=xl49>Chứng từ kèm theo / Document<span
  style='mso-spacerun:yes'>   </span>: Báo cáo sản xuất</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl53 align=left width=30 style='height:30.0pt;
  width:23pt'>STT<br>
    No</td>
  <td colspan=2 rowspan=2 class=xl54 width=132 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:100pt'>Mã TP<br>
    Code</td>
  <td rowspan=2 class=xl56 width=186 style='width:140pt'>Tên Thành Phẩm
  <br>
    The name of finish good</td>
  <td rowspan=2 class=xl56 width=50 style='width:38pt'>ĐVT<br>
    Unit</td>
  <td colspan=2 class=xl56 width=124 style='border-left:none;width:94pt'
  x:str="Số Lượng ">Số Lượng<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl56 width=84 style='width:63pt'>Đơn giá<br>
    Price</td>
  <td rowspan=2 class=xl56 width=144 style='width:108pt'>Thành tiền<br>
    Amount</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl56 width=62 style='height:15.0pt;border-top:none;
  border-left:none;width:47pt' x:str="Chứng từ ">Chứng từ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 width=62 style='border-top:none;border-left:none;width:47pt'>Quantity</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl59 align=left style='height:15.0pt;border-top:none'>(A)</td>
  <td colspan=2 class=xl60 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>(B)</td>
  <td class=xl62 style='border-top:none;border-left:none'>(C)</td>
  <td class=xl62 style='border-top:none;border-left:none'>(D)</td>
  <td class=xl62 style='border-top:none;border-left:none; ' x:str="'(1)">(1)</td>
  <td class=xl62 style='border-top:none;border-left:none; ' x:str="'(E)">(E)</td>
  <td class=xl62 style='border-top:none;border-left:none' x:str="'(F)">(F)</td>
  <td class=xl62 style='border-top:none;border-left:none' x:str="'(G)">(G)</td>
  <td class=xl28></td>
 </tr>
 <%    
    for(i = 0; i < dtItem.Rows.Count; i++)
    {
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl63 align=right style='height:15.0pt; border-bottom:.5pt solid black; ' x:num><%=i + 1 %></td>
  <td colspan=2 class=xl64 style='border-left:none; border-bottom:.5pt solid black; '><%=dtItem.Rows[i][4] %></td>
  <td class=xl65 align=left style='border-left:none; border-bottom:.5pt solid black; '><%=dtItem.Rows[i][5] %></td>
  <td class=xl66 style='border-left:none; border-bottom:.5pt solid black; '><%=dtItem.Rows[i][2] %></td>
  <td class=xl67 align=right style='border-left:none; border-bottom:.5pt solid black; ' x:num><%=dtItem.Rows[i][1] %></td>
  <td class=xl67 align=right style='border-left:none; border-bottom:.5pt solid black; ' x:num><%=dtItem.Rows[i][1] %></td>
  <td class=xl67 align=right style='border-left:none; border-bottom:.5pt solid black; ' x:num><%=dtItem.Rows[i][6] %></td>
  <td class=xl67 align=right style='border-left:none; border-bottom:.5pt solid black; ' x:num><%=dtItem.Rows[i][3] %></td>
  <td class=xl28 style='border-left:none; border-bottom:none; '></td>
 </tr>
 <% 
    }
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl63 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl64 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl69 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>Cộng/ Total</td>
  <td class=xl71 style='border-left:none'>&nbsp;</td>
  <td class=xl72 align=right style='border-left:none' x:num></td>
  <td class=xl72 align=right style='border-left:none' x:num><%=lQty %></td>
  <td class=xl73 align=right style='border-left:none' x:num></td>
  <td class=xl69 align=right style='border-left:none' x:num><%=lAmt %></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=2 height=37 class=xl77 width=92 style='height:27.75pt;width:70pt'>Ghi bằng chữ<br>
    <span style='mso-spacerun:yes'> </span>In word</td>
  <td colspan=7 class=xl81 align=left width=658 style='width:496pt'><%=CommondLib.Num2VNText(lAmt.ToString(), "VND") %> (<%=CommondLib.changeNumericToWords(lAmt.ToString()) %> VND)</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt'></td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td colspan=5 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl82 x:str>Ngày (date): <%=dtMaster.Rows[0][1].ToString().Substring(0, 2)%> tháng <%=dtMaster.Rows[0][1].ToString().Substring(3, 2)%> năm <%=dtMaster.Rows[0][1].ToString().Substring(6, 4)%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl83 colspan=3 align=left style='height:15.0pt;
  mso-ignore:colspan' x:str="Người giao hàng ">Người giao hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl84>Kế Toán Thành Phẩm</td>
  <td class=xl29></td>
  <td class=xl84>Kế toán trưởng</td>
  <td class=xl26></td>
  <td colspan=2 class=xl85><span style='mso-spacerun:yes'>       </span>Thủ
  trưởng đơn vị</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 rowspan=2 height=40 class=xl25 width=162 style='height:30.0pt;
  width:123pt'>The name <br>
    of delivery</td>
  <td class=xl84>Account</td>
  <td class=xl29></td>
  <td class=xl84>Chief Account</td>
  <td class=xl26></td>
  <td colspan=2 class=xl84>General Director</td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
